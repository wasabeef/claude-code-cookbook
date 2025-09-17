#!/bin/bash

# デバッグログ出力（本番環境ではコメントアウト）
# echo "$(date): deny-check.sh called" >> ~/.claude/deny-check.log
DEBUG=false

# JSON 入力を読み取り、コマンドとツール名を抽出
input=$(cat)

# デバッグ: 入力を記録
# echo "Input received: $input" >> ~/.claude/deny-check.log
command=$(echo "$input" | jq -r '.tool_input.command' 2>/dev/null || echo "")
tool_name=$(echo "$input" | jq -r '.tool_name' 2>/dev/null || echo "")

# Bash コマンドのみをチェック
if [ "$tool_name" != "Bash" ]; then
  exit 0
fi

# settings.json から拒否パターンを読み取り
settings_file="$HOME/.claude/settings.json"

# Bash コマンドの全拒否パターンを取得
deny_patterns=$(jq -r '.permissions.deny[] | select(startswith("Bash(")) | gsub("^Bash\\("; "") | gsub("\\)$"; "")' "$settings_file" 2>/dev/null)

# コマンドが拒否パターンにマッチするかチェックする関数
matches_deny_pattern() {
  local cmd="$1"
  local pattern="$2"

  # 先頭・末尾の空白を削除
  cmd="${cmd#"${cmd%%[![:space:]]*}"}" # 先頭の空白を削除
  cmd="${cmd%"${cmd##*[![:space:]]}"}" # 末尾の空白を削除

  # 特殊なパターンの処理
  # "bash:*" や "sh:*" は bash/sh で始まるコマンドをブロック
  if [[ "$pattern" == "bash:*" ]]; then
    if [[ "$cmd" == "bash "* ]] || [[ "$cmd" == "bash" ]]; then
      return 0 # マッチ
    fi
    return 1 # マッチしない
  fi

  if [[ "$pattern" == "sh:*" ]]; then
    if [[ "$cmd" == "sh "* ]] || [[ "$cmd" == "sh" ]]; then
      return 0 # マッチ
    fi
    return 1 # マッチしない
  fi

  # :* パターンの処理（プレフィックスマッチング）
  if [[ "$pattern" == *":*"* ]]; then
    # :* を * に変換してプレフィックスマッチング
    pattern="${pattern//:*/*}"
  fi

  # glob パターンマッチング（ワイルドカード対応）
  [[ "$cmd" == $pattern ]]
}

# まずコマンド全体をチェック
while IFS= read -r pattern; do
  # 空行をスキップ
  [ -z "$pattern" ] && continue

  [ "$DEBUG" = "true" ] && echo "Checking pattern: '$pattern' against command: '$command'" >&2

  # コマンド全体がパターンにマッチするかチェック
  if matches_deny_pattern "$command" "$pattern"; then
    echo "Error: コマンドが拒否されました: '$command' (パターン: '$pattern')" >&2
    exit 2
  fi
done <<<"$deny_patterns"

# コマンドを論理演算子で分割し、各部分もチェック
# セミコロン、&& と || で分割（パイプ | と単一 & は分割しない）
temp_command="${command//;/$'\n'}"
temp_command="${temp_command//&&/$'\n'}"
temp_command="${temp_command//\|\|/$'\n'}"

IFS=$'\n'
for cmd_part in $temp_command; do
  # 空の部分をスキップ
  [ -z "$(echo "$cmd_part" | tr -d '[:space:]')" ] && continue

  # 各拒否パターンに対してチェック
  while IFS= read -r pattern; do
    # 空行をスキップ
    [ -z "$pattern" ] && continue

    # このコマンド部分がパターンにマッチするかチェック
    if matches_deny_pattern "$cmd_part" "$pattern"; then
      echo "Error: コマンドが拒否されました: '$cmd_part' (パターン: '$pattern')" >&2
      exit 2
    fi
  done <<<"$deny_patterns"
done

# コマンドを許可
exit 0
