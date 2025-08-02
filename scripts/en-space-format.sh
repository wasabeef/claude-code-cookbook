#!/bin/bash
set -euo pipefail

# Insert spaces between English text and non-English characters

# Get file path
if [ -n "${1:-}" ]; then
  file_path="$1"
else
  file_path=$(jq -r '.tool_input.file_path // empty' <<<"${CLAUDE_TOOL_INPUT:-$(cat)}")
fi

# Basic checks
[ -z "$file_path" ] || [ ! -f "$file_path" ] || [ ! -r "$file_path" ] || [ ! -w "$file_path" ] && exit 0

# Exclusions list
EXCLUSIONS_FILE="$(dirname "${BASH_SOURCE[0]}")/en-space-exclusions.json"

# Process in temporary file
temp_file=$(mktemp)
trap 'rm -f "$temp_file"' EXIT

# Basic space insertion
sed -E \
  -e 's/([a-zA-Z0-9])([^a-zA-Z0-9])/\1 \2/g' \
  -e 's/([^a-zA-Z0-9])([a-zA-Z0-9])/\1 \2/g' \
  -e 's/([a-zA-Z0-9])(\()/\1 \2/g' \
  -e 's/(\))([a-zA-Z0-9])/\1 \2/g' \
  -e 's/(\))([^a-zA-Z0-9])/\1 \2/g' \
  -e 's/\$\(([^)]*)\) ([0-9])/\$\(\1\)\2/g' \
  -e 's/(%)([^a-zA-Z0-9])/\1 \2/g' \
  "$file_path" >"$temp_file"

# Apply exclusions list
if [ -f "$EXCLUSIONS_FILE" ] && command -v jq >/dev/null 2>&1; then
  while IFS= read -r pattern; do
    [ -z "$pattern" ] && continue
    escaped="${pattern//[\[\\.^$()|*+?{]/\\&}"
    spaced=$(sed -E 's/([a-zA-Z0-9])([^a-zA-Z0-9])/\1 \2/g; s/([^a-zA-Z0-9])([a-zA-Z0-9])/\1 \2/g' <<<"$escaped")
    sed -i '' "s/$spaced/$pattern/g" "$temp_file"
  done < <(jq -r '.exclusions[]' "$EXCLUSIONS_FILE" 2>/dev/null)
fi

mv "$temp_file" "$file_path"