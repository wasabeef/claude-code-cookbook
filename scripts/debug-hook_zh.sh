#!/bin/bash

# 钩子调试用脚本
echo "钩子在 $(date) 执行" >>/tmp/claude-hook-debug.log
echo "输入数据:" >>/tmp/claude-hook-debug.log
cat >>/tmp/claude-hook-debug.log
echo "---" >>/tmp/claude-hook-debug.log