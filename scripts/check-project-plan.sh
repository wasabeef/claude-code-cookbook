#!/bin/bash

# 現在のセッションでプランが存在するかチェック
check_project_plan() {
  local todos_dir="$HOME/.claude/todos"
  
  # 現在のセッション ID を取得
  local current_session_id="$CLAUDE_SESSION_ID"
  if [ -z "$current_session_id" ]; then
    return 1
  fi
  
  # 現在のセッションの TODO ファイルが存在するかチェック
  local plan_file="$todos_dir/$current_session_id.json"
  if [ -f "$plan_file" ]; then
    return 0  # 現在のセッションの TODO が存在
  else
    return 1  # 現在のセッションの TODO が存在しない
  fi
}

# メイン処理
if check_project_plan; then
  echo '{"continue": false, "stopReason": "💡 /show-plan でプランを確認"}'
fi