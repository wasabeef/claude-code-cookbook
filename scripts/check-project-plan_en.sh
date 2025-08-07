#!/bin/bash

# Check if a project plan exists in the current session
check_project_plan() {
  local todos_dir="$HOME/.claude/todos"

  # Get current session ID
  local current_session_id="$CLAUDE_SESSION_ID"
  if [ -z "$current_session_id" ]; then
    return 1
  fi

  # Check if TODO file for current session exists
  local plan_file="$todos_dir/$current_session_id.json"
  if [ -f "$plan_file" ]; then
    return 0 # TODO for current session exists
  else
    return 1 # TODO for current session does not exist
  fi
}

# Main processing
if check_project_plan; then
  echo '{"continue": false, "stopReason": "💡 Check the plan with /show-plan"}'
fi