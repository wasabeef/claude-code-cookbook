#!/bin/bash
set -euo pipefail

# 日本語と半角英数字の間に半角スペースを挿入

# ファイルパス取得
if [ -n "${1:-}" ]; then
  file_path="$1"
else
  file_path=$(jq -r '.tool_input.file_path // empty' <<< "${CLAUDE_TOOL_INPUT:-$(cat)}")
fi

# 基本チェック
[ -z "$file_path" ] || [ ! -f "$file_path" ] || [ ! -r "$file_path" ] || [ ! -w "$file_path" ] && exit 0

# 除外リスト
EXCLUSIONS_FILE="$(dirname "${BASH_SOURCE[0]}")/ja-space-exclusions.json"

# 一時ファイルで処理
temp_file=$(mktemp)
trap 'rm -f "$temp_file"' EXIT

# 基本的なスペース挿入
sed -E \
  -e 's/([ぁ-ゟァ-ヿ一-鿿㐀-䶿])([a-zA-Z0-9])/\1 \2/g' \
  -e 's/([a-zA-Z0-9])([ぁ-ゟァ-ヿ一-鿿㐀-䶿])/\1 \2/g' \
  -e 's/([ぁ-ゟァ-ヿ一-鿿㐀-䶿])(\()/\1 \2/g' \
  -e 's/(\))([ぁ-ゟァ-ヿ一-鿿㐀-䶿])/\1 \2/g' \
  -e 's/(\))([a-zA-Z0-9])/\1 \2/g' \
  -e 's/(%)([ぁ-ゟァ-ヿ一-鿿㐀-䶿])/\1 \2/g' \
  -e 's/([（(\[{][^）)\]}]*[）)\]}])\s+(の|と|で|が|を|は|に)/\1\2/g' \
  "$file_path" > "$temp_file"

# 除外リスト適用
if [ -f "$EXCLUSIONS_FILE" ] && command -v jq >/dev/null 2>&1; then
  while IFS= read -r pattern; do
    [ -z "$pattern" ] && continue
    escaped="${pattern//[\[\\.^$()|*+?{]/\\&}"
    spaced=$(sed -E 's/([ぁ-ゟァ-ヿ一-鿿㐀-䶿])([a-zA-Z0-9])/\1 \2/g; s/([a-zA-Z0-9])([ぁ-ゟァ-ヿ一-鿿㐀-䶿])/\1 \2/g' <<< "$escaped")
    sed -i '' "s/$spaced/$pattern/g" "$temp_file"
  done < <(jq -r '.exclusions[]' "$EXCLUSIONS_FILE" 2>/dev/null)
fi

mv "$temp_file" "$file_path"
