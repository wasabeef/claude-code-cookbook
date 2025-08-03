#!/bin/bash
# Trigger-based comment check

input="$CLAUDE_TOOL_INPUT"
file_path=$(echo "$input" | jq -r '.tool_input.file_path // empty')
[ -z "$file_path" ] || [ ! -f "$file_path" ] && exit 0

# Check only when creating new files
if echo "$input" | jq -e '.tool == "Write"' >/dev/null; then
  jq -n '{decision: "block", reason: "A new file has been created. If this is a code file, consider adding appropriate docstrings (function, class, or module-level API documentation)."}'
fi

# Check only when making significant edits (using MultiEdit)
if echo "$input" | jq -e '.tool == "MultiEdit"' >/dev/null; then
  jq -n '{decision: "block", reason: "Multiple edits have been made. Please check if docstrings or API documentation need to be updated according to the changes."}'
fi