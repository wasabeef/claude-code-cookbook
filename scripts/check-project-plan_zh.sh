#!/bin/bash

# 检查当前会话中是否存在项目计划
check_project_plan() {
  local todos_dir="$HOME/.claude/todos"

  # 获取当前会话 ID
  local current_session_id="$CLAUDE_SESSION_ID"
  if [ -z "$current_session_id" ]; then
    return 1
  fi

  # 检查当前会话的 TODO 文件是否存在
  local plan_file="$todos_dir/$current_session_id.json"
  if [ -f "$plan_file" ]; then
    return 0 # 当前会话的 TODO 存在
  else
    return 1 # 当前会话的 TODO 不存在
  fi
}

# 主处理
if check_project_plan; then
  echo '{"continue": false, "stopReason": "💡 使用 /show-plan 查看计划"}'
fi