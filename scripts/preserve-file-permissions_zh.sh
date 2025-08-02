#!/bin/bash

# 调试日志
DEBUG_LOG="/tmp/claude_permissions_debug.log"

# 用于保存权限的临时文件
PERMISSIONS_CACHE="/tmp/claude_file_permissions.txt"

# 从标准输入读取 JSON
input_json=$(cat)

# 从 JSON 中提取必要信息
hook_type=$(echo "$input_json" | jq -r '.hook_event_name // ""')
tool_name=$(echo "$input_json" | jq -r '.tool_name // ""')
file_path=$(echo "$input_json" | jq -r '.tool_input.file_path // ""')

# 记录调试信息
echo "[$(date)] Hook: $hook_type, Tool: $tool_name, File: $file_path" >>"$DEBUG_LOG"

# 仅处理文件操作类工具
case "$tool_name" in
Write | Edit | MultiEdit) ;;
*)
  # 不做任何处理，直接通过
  echo "$input_json"
  exit 0
  ;;
esac

# 文件路径为空则通过
if [ -z "$file_path" ]; then
  echo "$input_json"
  exit 0
fi

if [ "$hook_type" = "PreToolUse" ]; then
  # 如果文件存在，记录当前权限
  if [ -f "$file_path" ]; then
    # 获取权限（八进制形式）
    current_perms=$(stat -f "%OLp" "$file_path" 2>/dev/null || stat -c "%a" "$file_path" 2>/dev/null)
    if [ -n "$current_perms" ]; then
      # 保存文件路径和权限
      echo "${file_path}:${current_perms}" >>"$PERMISSIONS_CACHE"
      echo "已保存 $file_path 的权限: $current_perms" >&2
      echo "[$(date)] PreToolUse: 已保存 $file_path 及其权限 $current_perms" >>"$DEBUG_LOG"
    fi
  fi

elif [ "$hook_type" = "PostToolUse" ]; then
  # 如果有保存的权限，则恢复
  if [ -f "$PERMISSIONS_CACHE" ]; then
    # 查找对应文件的权限
    saved_entry=$(grep "^${file_path}:'" "$PERMISSIONS_CACHE" | tail -1)
    if [ -n "$saved_entry" ]; then
      saved_perms=$(echo "$saved_entry" | cut -d: -f2)
      if [ -n "$saved_perms" ] && [ -f "$file_path" ]; then
        chmod "$saved_perms" "$file_path" 2>/dev/null
        if [ $? -eq 0 ]; then
          echo "已恢复 $file_path 的权限: $saved_perms" >&2
          echo "[$(date)] PostToolUse: 已将 $file_path 恢复为权限 $saved_perms" >>"$DEBUG_LOG"

          # 后台等待 3 秒后再次设置权限
          (
            sleep 3
            chmod "$saved_perms" "$file_path" 2>/dev/null
            if [ $? -eq 0 ]; then
              echo "[$(date)] PostToolUse: 已将 $file_path 再次恢复为权限 $saved_perms (延迟 3 秒)" >>"$DEBUG_LOG"
            fi
          ) &

          # 从缓存中删除对应条目
          grep -v "^${file_path}:'" "$PERMISSIONS_CACHE" >"${PERMISSIONS_CACHE}.tmp" || true
          mv "${PERMISSIONS_CACHE}.tmp" "$PERMISSIONS_CACHE" 2>/dev/null || true
        else
          echo "无法恢复 $file_path 的权限" >&2
        fi
      fi
    fi
  fi
fi

# 原样输出输入（无更改）
echo "$input_json"