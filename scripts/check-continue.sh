#!/bin/bash

# Simple continuation check
# If the passphrase is not present, tell the user "Please resume work"
#
# The passphrase is the completion phrase defined in CLAUDE.md
# For details: See "Work Completion Report Rules" in ~/.claude/CLAUDE.md

COMPLETION_PHRASE="May the Force be with you."

# Read JSON passed from Stop hook
input_json=$(cat)

# Extract transcript_path
transcript_path=$(echo "$input_json" | jq -r '.transcript_path // empty')

if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
  # Get the entire last message (including error messages)
  last_entry=$(tail -n 1 "$transcript_path")

  # For debugging (enable as needed)
  # echo "Debug: last_entry=$last_entry" >&2

  # Get assistant message text
  last_message=$(echo "$last_entry" | jq -r '.message.content[0].text // empty' 2>/dev/null || echo "")

  # Check various possibilities for error fields
  error_message=$(echo "$last_entry" | jq -r '.message.error // .error // empty' 2>/dev/null || echo "")

  # Stringify the entire message for checking (regardless of JSON structure)
  full_entry_text=$(echo "$last_entry" | jq -r '.' 2>/dev/null || echo "$last_entry")

  # Check for Claude usage limit reached (in multiple ways)
  if echo "$error_message" | grep -qi "usage limit" ||
    echo "$last_message" | grep -qi "usage limit" ||
    echo "$full_entry_text" | grep -qi "usage limit"; then
    # Do nothing for usage limit errors (exit normally)
    exit 0
  fi

  # Detect other error patterns
  if echo "$error_message" | grep -qi "network error\|timeout\|connection refused" ||
    echo "$full_entry_text" | grep -qi "network error\|timeout\|connection refused"; then
    # Do nothing for network errors (exit normally)
    exit 0
  fi

  # Detect /compact related patterns (treat as error messages)
  if echo "$error_message" | grep -qi "Context low.*Run /compact to compact" ||
    echo "$full_entry_text" | grep -qi "Context low.*Run /compact to compact"; then
    # Do nothing for /compact related messages (exit normally)
    exit 0
  fi

  # Detect repetition patterns of Stop hook feedback
  if echo "$last_message" | grep -qi "Stop hook feedback" &&
    echo "$last_message" | grep -qi "Please resume work"; then
    # Do nothing for repetition patterns of Stop hook feedback (exit normally)
    exit 0
  fi

  # Check for plan presentation patterns (correction: continue if approved)
  if echo "$last_message" | grep -qi "User approved Claude's plan" ||
    echo "$full_entry_text" | grep -qi "User approved Claude's plan"; then
    # Plan approved → continue work (do not block)
    exit 0
  fi

  # If waiting for y/n confirmation
  if echo "$last_message" | grep -qi "y/n" ||
    echo "$full_entry_text" | grep -qi "y/n"; then
    # Plan approved → continue work (do not block)
    exit 0
  fi

  # Check for /spec related work patterns
  if echo "$last_message" | grep -qi "spec" ||
    echo "$last_message" | grep -qi "spec-driven" ||
    echo "$last_message" | grep -qi "requirements\.md\|design\.md\|tasks\.md"; then
    # Do not prompt for continuation during /spec related work (exit normally)
    exit 0
  fi

  # Check for passphrase
  if echo "$last_message" | grep -q "$COMPLETION_PHRASE"; then
    # Do nothing if passphrase is present (exit normally)
    exit 0
  fi
fi

# If no passphrase, prompt to continue
cat <<EOF
{
  "decision": "block",
  "reason": "Please resume work.\n  If there is no more work to continue, output \`$COMPLETION_PHRASE\` to finish."
}
EOF