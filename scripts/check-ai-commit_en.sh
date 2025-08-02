#!/bin/bash

# AI signature check script
# Outputs an error if git commit command contains AI signature

# Parse Bash tool input with jq
COMMAND=$(jq -r '.tool_input.command')

# Check if it's a git commit command
if echo "$COMMAND" | grep -q '^git commit'; then
  # Check if AI signature is included
  if echo "$COMMAND" | grep -q '🤖 Generated with'; then
    echo "Error: Commit message contains AI signature" >&2
    echo "Please remove the AI signature and commit again" >&2
    exit 2
  fi
fi

# Success if no issues
exit 0