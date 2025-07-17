#!/bin/bash

# Hook デバッグ用スクリプト
echo "Hook executed at $(date)" >> /tmp/claude-hook-debug.log
echo "Input data:" >> /tmp/claude-hook-debug.log
cat >> /tmp/claude-hook-debug.log
echo "---" >> /tmp/claude-hook-debug.log