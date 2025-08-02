#!/bin/bash

# 简单继续检查
# 如果没有暗号，则提示"请继续工作"
#
# 暗号在 CLAUDE.md 中定义的完成时的固定用语
# 详情: ~/.claude/CLAUDE.md 的「工作完成报告规则」部分

COMPLETION_PHRASE="May the Force be with you."

# 读取从 Stop hook 传递的 JSON
input_json=$(cat)

# 提取 transcript_path
transcript_path=$(echo "$input_json" | jq -r '.transcript_path // empty')

if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
  # 获取最后一条消息的全部内容（包括错误消息）
  last_entry=$(tail -n 1 "$transcript_path")

  # 调试用（根据需要启用）
  # echo "Debug: last_entry=$last_entry" >&2

  # 获取助手消息的文本
  last_message=$(echo "$last_entry" | jq -r '.message.content[0].text // empty' 2>/dev/null || echo "")

  # 检查各种可能的错误字段
  error_message=$(echo "$last_entry" | jq -r '.message.error // .error // empty' 2>/dev/null || echo "")

  # 将消息整体字符串化进行检查（无论 JSON 结构如何）
  full_entry_text=$(echo "$last_entry" | jq -r '.' 2>/dev/null || echo "$last_entry")

  # 检查 Claude 使用限制是否达到（多种方法）
  if echo "$error_message" | grep -qi "usage limit" ||
    echo "$last_message" | grep -qi "usage limit" ||
    echo "$full_entry_text" | grep -qi "usage limit"; then
    # 如果是使用限制错误，则不执行任何操作（正常退出）
    exit 0
  fi

  # 检测其他错误模式
  if echo "$error_message" | grep -qi "network error\|timeout\|connection refused" ||
    echo "$full_entry_text" | grep -qi "network error\|timeout\|connection refused"; then
    # 如果是网络错误，则不执行任何操作（正常退出）
    exit 0
  fi

  # 检测 /compact 相关模式（视为错误消息）
  if echo "$error_message" | grep -qi "Context low.*Run /compact to compact" ||
    echo "$full_entry_text" | grep -qi "Context low.*Run /compact to compact"; then
    # 如果是 /compact 相关消息，则不执行任何操作（正常退出）
    exit 0
  fi

  # 检测 Stop hook feedback 的重复模式
  if echo "$last_message" | grep -qi "Stop hook feedback" &&
    echo "$last_message" | grep -qi "请继续工作"; then
    # 如果是 Stop hook feedback 的重复模式，则不执行任何操作（正常退出）
    exit 0
  fi

  # 检查计划提示相关模式（修正：已批准则继续）
  if echo "$last_message" | grep -qi "User approved Claude's plan" ||
    echo "$full_entry_text" | grep -qi "User approved Claude's plan"; then
    # 计划已批准 → 继续工作（不阻塞）
    exit 0
  fi

  # 如果正在请求 y/n 确认
  if echo "$last_message" | grep -qi "y/n" ||
    echo "$full_entry_text" | grep -qi "y/n"; then
    # 计划已批准 → 继续工作（不阻塞）
    exit 0
  fi

  # 检查 /spec 相关工作模式
  if echo "$last_message" | grep -qi "spec" ||
    echo "$last_message" | grep -qi "spec-driven" ||
    echo "$last_message" | grep -qi "requirements\.md\\|design\.md\\|tasks\.md"; then
    # /spec 相关工作中不催促继续（正常退出）
    exit 0
  fi

  # 检查暗号
  if echo "$last_message" | grep -q "$COMPLETION_PHRASE"; then
    # 如果有暗号，则不执行任何操作（正常退出）
    exit 0
  fi
fi

# 如果没有暗号，则催促继续
cat <<EOF
{
  "decision": "block",
  "reason": "请继续工作。\n  如果没有要继续的工作，请输出 \`$COMPLETION_PHRASE\` 来结束。"
}
EOF