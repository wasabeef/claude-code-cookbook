#!/bin/bash
# トリガーベースのコメントチェック

input="$CLAUDE_TOOL_INPUT"
file_path=$(echo "$input" | jq -r '.tool_input.file_path // empty')
[ -z "$file_path" ] || [ ! -f "$file_path" ] && exit 0

# 新規ファイル作成時のみチェック
if echo "$input" | jq -e '.tool == "Write"' >/dev/null; then
  jq -n '{decision: "block", reason: "新規ファイルを作成しました。コードファイルの場合は適切な docstring（関数・クラス・モジュールレベルの API ドキュメント）を追加することを検討してください。"}'
fi

# 大幅な編集時（MultiEdit 使用時）のみチェック
if echo "$input" | jq -e '.tool == "MultiEdit"' >/dev/null; then
  jq -n '{decision: "block", reason: "複数の編集を行いました。変更に合わせて docstring や API ドキュメントの更新が必要か確認してください。"}'
fi
