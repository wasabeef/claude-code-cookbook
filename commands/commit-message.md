## Commit Message

ステージングされた変更（git diff --staged）から適切なコミットメッセージを生成します。git コマンドの実行は行わず、メッセージの生成とクリップボードへのコピーのみを行います。

### 使い方

```bash
/commit-message [オプション]
```

### オプション

- `--format <形式>` : メッセージ形式を指定（conventional, gitmoji, angular）
- `--lang <言語>` : メッセージ言語を強制指定（en, ja）
- `--breaking` : Breaking Change の検出と記載

### 基本例

```bash
# ステージングされた変更からメッセージ生成（言語自動判定）
# メイン候補が自動的にクリップボードにコピーされます
/commit-message

# 言語を強制的に指定
/commit-message --lang ja
/commit-message --lang en

# Breaking Change を検出
/commit-message --breaking
```

### 前提条件

**重要**: このコマンドはステージングされた変更のみを分析します。事前に `git add` で変更をステージングしておく必要があります。

```bash
# ステージングされていない場合は警告が表示されます
$ /commit-message
ステージングされた変更がありません。先に git add を実行してください。
```

### 自動クリップボード機能

生成されたメイン候補は `git commit -m "メッセージ"` の完全な形式で自動的にクリップボードにコピーされます。ターミナルでそのまま貼り付けて実行できます。

**実装時の注意**:

- コミットコマンドを `pbcopy` に渡す際は、メッセージ出力とは別プロセスで実行すること
- `echo` の代わりに `printf` を使用して末尾の改行を避けること

### プロジェクト規約の自動検出

**重要**: プロジェクト独自の規約が存在する場合は、それを優先します。

#### 1. CommitLint 設定の確認

以下のファイルから設定を自動検出：

- `commitlint.config.js`
- `commitlint.config.mjs`
- `commitlint.config.cjs`
- `commitlint.config.ts`
- `.commitlintrc.js`
- `.commitlintrc.json`
- `.commitlintrc.yml`
- `.commitlintrc.yaml`
- `package.json` の `commitlint` セクション

```bash
# 設定ファイルの検索
find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
```

#### 2. カスタムタイプの検出

プロジェクト独自のタイプ例：

```javascript
// commitlint.config.mjs
export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore',
        'wip',      // 作業中
        'hotfix',   // 緊急修正
        'release',  // リリース
        'deps',     // 依存関係更新
        'config'    // 設定変更
      ]
    ]
  }
}
```

#### 3. 言語設定の検出

```javascript
// プロジェクトが日本語メッセージを使用する場合
export default {
  rules: {
    'subject-case': [0],  // 日本語対応のため無効化
    'subject-max-length': [2, 'always', 72]  // 日本語は文字数制限を調整
  }
}
```

#### 4. 既存コミット履歴の分析

```bash
# 最近のコミットから使用パターンを学習
git log --oneline -50 --pretty=format:"%s"

# 使用タイプ統計
git log --oneline -100 --pretty=format:"%s" | \
grep -oE '^[a-z]+(\([^)]+\))?' | \
sort | uniq -c | sort -nr
```

### 言語の自動判定

以下の条件で自動的に日本語/英語を切り替えます：

1. **CommitLint 設定**から言語設定を確認
2. **git log 分析**による自動判定
3. **プロジェクトファイル**の言語設定
4. **変更ファイル内**のコメント・文字列分析

デフォルトは英語。日本語プロジェクトと判定された場合は日本語で生成。

### メッセージ形式

#### Conventional Commits (デフォルト)

```
<type>: <description>
```

**重要**: 必ず 1 行のコミットメッセージを生成します。複数行のメッセージは生成しません。

**注意**: プロジェクト独自の規約がある場合は、それを優先します。

### 標準タイプ

**必須タイプ**:

- `feat`: 新機能（ユーザーに見える機能追加）
- `fix`: バグ修正

**任意タイプ**:

- `build`: ビルドシステムや外部依存関係の変更
- `chore`: その他の変更（リリースに影響しない）
- `ci`: CI 設定ファイルやスクリプトの変更
- `docs`: ドキュメントのみの変更
- `style`: コードの意味に影響しない変更（空白、フォーマット、セミコロンなど）
- `refactor`: バグ修正や機能追加を伴わないコード変更
- `perf`: パフォーマンス改善
- `test`: テストの追加や修正

### 出力例（英語プロジェクト）

```bash
$ /commit-message

📝 コミットメッセージ提案
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ メイン候補:
feat: implement JWT-based authentication system

📋 代替案:
1. feat: add user authentication with JWT tokens
2. fix: resolve token validation error in auth middleware
3. refactor: extract auth logic into separate module

✅ `git commit -m "feat: implement JWT-based authentication system"` をクリップボードにコピーしました
```

**実装例（修正版）**:

```bash
# コミットコマンドを先にクリップボードにコピー（改行なし）
printf 'git commit -m "%s"' "$COMMIT_MESSAGE" | pbcopy

# その後でメッセージを表示
cat << EOF
📝 コミットメッセージ提案
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ メイン候補:
$COMMIT_MESSAGE

📋 代替案:
1. ...
2. ...
3. ...

✅ \`git commit -m