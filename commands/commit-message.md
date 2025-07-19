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

✅ \`git commit -m "$COMMIT_MESSAGE"\` をクリップボードにコピーしました
EOF
```

### 出力例（日本語プロジェクト）

```bash
$ /commit-message

📝 コミットメッセージ提案
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ メイン候補:
feat: JWT 認証システムを実装

📋 代替案:
1. feat: JWT トークンによるユーザー認証を追加
2. fix: 認証ミドルウェアのトークン検証エラーを解決
3. docs: 認証ロジックを別モジュールに分離

✅ `git commit -m "feat: JWT 認証システムを実装"` をクリップボードにコピーしました
```

### 動作概要

1. **分析**: `git diff --staged` の内容を分析
2. **生成**: 適切なコミットメッセージを生成
3. **コピー**: メイン候補を自動的にクリップボードへコピー

**注意**: このコマンドは git add や git commit を実行しません。コミットメッセージの生成とクリップボードへのコピーのみを行います。

### スマート機能

#### 1. 変更内容の自動分類（ステージングされたファイルのみ）

- 新ファイル追加 → `feat`
- エラー修正パターン → `fix`
- テストファイルのみ → `test`
- 設定ファイル変更 → `chore`
- README/docs 更新 → `docs`

#### 2. プロジェクト規約の自動検出

- `.gitmessage` ファイル
- `CONTRIBUTING.md` 内の規約
- 過去のコミット履歴パターン

#### 3. 言語判定の詳細（ステージングされた変更のみ）

```bash
# 判定基準（優先順位）
1. git diff --staged の内容から言語を判定
2. ステージングされたファイルのコメント分析
3. git log --oneline -20 の言語分析
4. プロジェクトのメイン言語設定
```

#### 4. ステージング分析の詳細

分析に使用する情報（読み取りのみ）:

- `git diff --staged --name-only` - 変更ファイル一覧
- `git diff --staged` - 実際の変更内容
- `git status --porcelain` - ファイル状態

### Breaking Change 検出時

API の破壊的変更がある場合：

**英語**:

```bash
feat!: change user API response format

BREAKING CHANGE: user response now includes additional metadata
```

または

```bash
feat(api)!: change authentication flow
```

**日本語**:

```bash
feat!: ユーザー API レスポンス形式を変更

BREAKING CHANGE: レスポンスに追加のメタデータが含まれるようになりました
```

または

```bash
feat(api)!: 認証フローを変更
```

### ベストプラクティス

1. **プロジェクトに合わせる**: 既存のコミット言語に従う
2. **簡潔性**: 50 文字以内で明確に
3. **一貫性**: 混在させない（英語なら英語で統一）
4. **OSS**: オープンソースなら英語推奨
5. **1 行厳守**: 必ず 1 行のコミットメッセージにする（詳細な説明が必要な場合は PR で補足）

### よくあるパターン

**英語**:

```
feat: add user registration endpoint
fix: resolve memory leak in cache manager
docs: update API documentation
```

**日本語**:

```
feat: ユーザー登録エンドポイントを追加
fix: キャッシュマネージャーのメモリリークを解決
docs: API ドキュメントを更新
```

### Claude との連携

```bash
# ステージングされた変更と組み合わせて使用
git add -p  # インタラクティブにステージング
/commit-message
「最適なコミットメッセージを生成して」

# 特定のファイルだけステージングして分析
git add src/auth/*.js
/commit-message --lang en
「認証関連の変更に適したメッセージを生成して」

# Breaking Change の検出と対応
git add -A
/commit-message --breaking
「破壊的変更がある場合は適切にマークして」
```

### 注意事項

- **前提条件**: 変更は事前に `git add` でステージングされている必要があります
- **制限事項**: ステージングされていない変更は分析対象外です
- **推奨事項**: プロジェクトの既存コミット規約を事前に確認してください
