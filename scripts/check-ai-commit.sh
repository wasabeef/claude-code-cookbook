#!/bin/bash

# AI 署名チェックスクリプト
# git commit コマンドで AI の署名が含まれている場合にエラーを出す

# jq で Bash ツールの入力を解析
COMMAND=$(jq -r '.tool_input.command')

# git commit コマンドかチェック
if echo "$COMMAND" | grep -q '^git commit'; then
    # AI 署名が含まれているかチェック
    if echo "$COMMAND" | grep -q '🤖 Generated with'; then
        echo "Error: コミットメッセージに AI 署名が含まれています" >&2
        echo "AI 署名を削除してから再度コミットしてください" >&2
        exit 2
    fi
fi

# 問題なければ成功
exit 0