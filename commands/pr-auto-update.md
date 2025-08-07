## PR Auto Update

## 概要

Pull Request の説明とラベルを自動的に更新するコマンドです。Git の変更内容を分析して、適切な説明文とラベルを生成・設定します。

## 使い方

```bash
/pr-auto-update [オプション] [PR 番号]
```

### オプション

- `--pr <番号>` : 対象の PR 番号を指定（省略時は現在のブランチから自動検出）
- `--description-only` : 説明文のみ更新（ラベルは変更しない）
- `--labels-only` : ラベルのみ更新（説明文は変更しない）
- `--dry-run` : 実際の更新は行わず、生成される内容のみ表示
- `--lang <言語>` : 言語を指定（ja, en）

### 基本例

```bash
# 現在のブランチの PR を自動更新
/pr-auto-update

# 特定の PR を更新
/pr-auto-update --pr 1234

# 説明文のみ更新
/pr-auto-update --description-only

# ドライランで確認
/pr-auto-update --dry-run
```

## 機能詳細

### 1. PR の自動検出

現在のブランチから対応する PR を自動検出：

```bash
# ブランチから PR を検索
gh pr list --head $(git branch --show-current) --json number,title,url
```

### 2. 変更内容の分析

以下の情報を収集・分析：

- **ファイル変更**: 追加・削除・変更されたファイル
- **コード分析**: import 文、関数定義、クラス定義の変更
- **テスト**: テストファイルの有無と内容
- **ドキュメント**: README、docs の更新
- **設定**: package.json、pubspec.yaml、設定ファイルの変更
- **CI/CD**: GitHub Actions、workflow の変更

### 3. 説明文の自動生成

#### テンプレート処理の優先順位

1. **既存の PR 説明**: 既に記述されている内容を**完全に踏襲**
2. **プロジェクトテンプレート**: `.github/PULL_REQUEST_TEMPLATE.md` から構造を取得
3. **デフォルトテンプレート**: 上記が存在しない場合のフォールバック

#### 既存内容の保持ルール

**重要**: 既存の内容は変更しない

- 書かれているセクションは保持
- 空のセクションのみ補完
- 機能的なコメント（Copilot review rule など）は保持

#### プロジェクトテンプレートの使用

```bash
# .github/PULL_REQUEST_TEMPLATE.md の構造を解析
parse_template_structure() {
  local template_file="$1"
  
  if [ -f "$template_file" ]; then
    # セクション構造を抽出
    grep -E '^##|^###' "$template_file"
    
    # コメントプレースホルダーを特定
    grep -E '<!--.*-->' "$template_file"
    
    # 既存のテンプレート構造を完全に踏襲
    cat "$template_file"
  fi
}
```

### 4. ラベルの自動設定

#### ラベル取得の仕組み

**優先順位**:

2. **GitHub API**: `gh api repos/{OWNER}/{REPO}/labels --jq '.[].name'` で既存ラベルを取得

#### 自動判定ルール

**ファイルパターンベース**:

- ドキュメント: `*.md`, `README`, `docs/` → `documentation|docs|doc` を含むラベル
- テスト: `test`, `spec` → `test|testing` を含むラベル  
- CI/CD: `.github/`, `*.yml`, `Dockerfile` → `ci|build|infra|ops` を含むラベル
- 依存関係: `package.json`, `pubspec.yaml`, `requirements.txt` → `dependencies|deps` を含むラベル

**変更内容ベース**:

- バグ修正: `fix|bug|error|crash|修正` → `bug|fix` を含むラベル
- 新機能: `feat|feature|add|implement|新機能|実装` → `feature|enhancement|feat` を含むラベル
- リファクタリング: `refactor|clean|リファクタ` → `refactor|cleanup|clean` を含むラベル
- パフォーマンス: `performance|perf|optimize|パフォーマンス` → `performance|perf` を含むラベル
- セキュリティ: `security|secure|セキュリティ` → `security` を含むラベル

#### 制約

- **最大 3 個まで**: 自動選択されるラベル数の上限
- **既存ラベルのみ**: 新しいラベルの作成は禁止
- **部分マッチ**: ラベル名にキーワードが含まれているかで判定

#### 実際の使用例

**`.github/labels.yml` が存在する場合**:

```bash
# ラベル定義から自動取得
grep "^- name:" .github/labels.yml | sed "s/^- name: '\?\([^']*\)'\?/\1/"

# 例: プロジェクト固有のラベル体系を使用
```

**GitHub API から取得する場合**:

```bash
# 既存ラベルの一覧取得
gh api repos/{OWNER}/{REPO}/labels --jq '.[].name'

# 例: bug, enhancement, documentation などの標準的なラベルを使用
```

### 5. 実行フロー

```bash
#!/bin/bash

# 1. PR の検出・取得
detect_pr() {
  if [ -n "$PR_NUMBER" ]; then
    echo $PR_NUMBER
  else
    gh pr list --head $(git branch --show-current) --json number --jq '.[0].number'
  fi
}

# 2. 変更内容の分析
analyze_changes() {
  local pr_number=$1
  
  # ファイル変更の取得
gh pr diff $pr_number --name-only
  
  # 内容分析
gh pr diff $pr_number | head -1000
}

# 3. 説明文の生成
generate_description() {
  local pr_number=$1
  local changes=$2
  
  # 現在の PR 説明を取得
  local current_body=$(gh pr view $pr_number --json body --jq -r .body)
  
  # 既存内容があればそのまま使用
  if [ -n "$current_body" ]; then
    echo "$current_body"
  else
    # テンプレートから新規生成
    local template_file=".github/PULL_REQUEST_TEMPLATE.md"
    if [ -f "$template_file" ]; then
      generate_from_template "$(cat "$template_file")" "$changes"
    else
      generate_from_template "" "$changes"
    fi
  fi
}

# テンプレートからの生成
generate_from_template() {
  local template="$1"
  local changes="$2"
  
  if [ -n "$template" ]; then
    # テンプレートをそのまま使用（HTML コメント保持）
  else
    # デフォルトフォーマットで生成
    echo "## What does this change?"
    echo ""
    echo "$changes"
  fi
}

# 4. ラベルの決定
determine_labels() {
  local changes=$1
  local file_list=$2
  local pr_number=$3
  
  # 利用可能なラベルを取得
  local available_labels=()
  if [ -f ".github/labels.yml" ]; then
    # labels.yml からラベル名を抽出
    available_labels=($(grep "^- name:" .github/labels.yml | sed "s/^- name: '\?\([^']*\)'\?/\1/"))
  else
    # GitHub API からラベルを取得
    local repo_info=$(gh repo view --json owner,name)
    local owner=$(echo "$repo_info" | jq -r .owner.login)
    local repo=$(echo "$repo_info" | jq -r .name)
    available_labels=($(gh api "repos/$owner/$repo/labels" --jq '.[].name'))
  fi
  
  local suggested_labels=()
  
  # 汎用的なパターンマッチング
  analyze_change_patterns "$file_list" "$changes" available_labels suggested_labels
  
  # 最大 3 個に制限
  echo "${suggested_labels[@]:0:3}"
}

# 変更パターンからラベルを決定
analyze_change_patterns() {
  local file_list="$1"
  local changes="$2"
  local -n available_ref=$3
  local -n suggested_ref=$4
  
  # ファイルタイプによる判定
  if echo "$file_list" | grep -q "\.md$\|README\|docs/"; then
    add_matching_label "documentation\|docs\|doc" available_ref suggested_ref
  fi
  
  if echo "$file_list" | grep -q "test\|spec"; then
    add_matching_label "test\|testing" available_ref suggested_ref
  fi
  
  # 変更内容による判定
  if echo "$changes" | grep -iq "fix\|bug\|error\|crash\|修正"; then
    add_matching_label "bug\|fix" available_ref suggested_ref
  fi
  
  if echo "$changes" | grep -iq "feat\|feature\|add\|implement\|新機能\|実装"; then
    add_matching_label "feature\|enhancement\|feat" available_ref suggested_ref
  fi
}

# マッチするラベルを追加
add_matching_label() {
  local pattern="$1"
  local -n available_ref=$2
  local -n suggested_ref=$3
  
  # すでに 3 個ある場合はスキップ
  if [ ${#suggested_ref[@]} -ge 3 ]; then
    return
  fi
  
  # パターンにマッチする最初のラベルを追加
  for available_label in "${available_ref[@]}"; do
    if echo "$available_label" | grep -iq "$pattern"; then
      # 重複チェック
      local already_exists=false
      for existing in "${suggested_ref[@]}"; do
        if [ "$existing" = "$available_label" ]; then
          already_exists=true
          break
        fi
      done
      
      if [ "$already_exists" = false ]; then
        suggested_ref+=($available_label)
        return
      fi
    fi
  done
}

# 旧関数の互換性のため残しておく
find_and_add_label() {
  add_matching_label "$@"
}

# 5. PR の更新
update_pr() {
  local pr_number=$1
  local description="$2"
  local labels="$3"
  
  if [ "$DRY_RUN" = "true" ]; then
    echo "=== DRY RUN ==="
    echo "Description:"
    echo "$description"
    echo "Labels: $labels"
  else
    # リポジトリ情報を取得
    local repo_info=$(gh repo view --json owner,name)
    local owner=$(echo "$repo_info" | jq -r .owner.login)
    local repo=$(echo "$repo_info" | jq -r .name)
    
    # GitHub API を使用して本文を更新（HTML コメント保持）
    # JSON エスケープを適切に処理
    local escaped_body=$(echo "$description" | jq -R -s .)
    gh api \
      --method PATCH \
      "/repos/$owner/$repo/pulls/$pr_number" \
      --field body="$description"
    
    # ラベルは通常の gh コマンドで問題なし
    if [ -n "$labels" ]; then
      gh pr edit $pr_number --add-label "$labels"
    fi
  fi
}
```

## 設定ファイル（今後の拡張用）

`~/.claude/pr-auto-update.config`:

```json
{
  "language": "ja",
  "max_labels": 3
}
```

## よくあるパターン

### Flutter プロジェクト

```markdown
## What does this change?

{機能名}を実装しました。ユーザーの{課題}を解決します。

### 主な変更内容

- **UI 実装**: {画面名}を新規作成
- **状態管理**: Riverpod プロバイダーを追加
- **API 統合**: GraphQL クエリ・ミューテーションを実装
- **テスト**: ウィジェットテスト・ユニットテストを追加

### 技術仕様

- **アーキテクチャ**: {使用パターン}
- **依存関係**: {新規追加したパッケージ}
- **パフォーマンス**: {最適化内容}
```

### Node.js プロジェクト

```markdown
## What does this change?

{API 名}エンドポイントを実装しました。{ユースケース}に対応します。

### 主な変更内容

- **API 実装**: {エンドポイント}を新規作成
- **バリデーション**: リクエスト検証ロジックを追加
- **データベース**: {テーブル名}への操作を実装
- **テスト**: 統合テスト・ユニットテストを追加

### セキュリティ

- **認証**: JWT トークン検証
- **認可**: ロールベースアクセス制御
- **入力検証**: SQL インジェクション対策
```

### CI/CD 改善

```markdown
## What does this change?

GitHub Actions ワークフローを改善しました。{効果}を実現します。

### 改善内容

- **パフォーマンス**: ビルド時間を{時間}短縮
- **信頼性**: エラーハンドリングを強化
- **セキュリティ**: シークレット管理を改善
- **並列化**: {ジョブ名}を並列実行
- **キャッシュ**: {キャッシュ対象}のキャッシュ戦略を最適化
- **モニタリング**: {メトリクス}の監視を追加
```

## 注意事項

1. **既存内容の完全保持**:
   - 既に記述されている内容は**一文字も変更しない**
   - 空のコメント部分とプレースホルダーのみ補完
   - ユーザーが意図的に書いた内容を尊重

2. **テンプレート優先順位**:
   - 既存の PR 説明 > `.github/PULL_REQUEST_TEMPLATE.md` > デフォルト
   - プロジェクト固有のテンプレート構造を完全踏襲

3. **ラベル制約**:
   - `.github/labels.yml` が存在すれば優先使用
   - 存在しない場合は GitHub API から既存ラベルを取得
   - 新しいラベルの作成は禁止
   - 最大 3 個まで自動選択

4. **安全な更新**:
   - `--dry-run` で事前確認を推奨
   - 機密情報を含む変更の場合は警告表示
   - バックアップとして元の説明を保存

5. **一貫性の維持**:
   - プロジェクトの既存 PR スタイルに合わせる
   - 言語（日本語/英語）の統一
   - ラベリング規則の継承

## トラブルシューティング

### よくある問題

1. **PR が見つからない**: ブランチ名と PR の関連付けを確認
2. **権限エラー**: GitHub CLI の認証状態を確認
3. **ラベルが設定できない**: リポジトリの権限を確認
4. **HTML コメントがエスケープされる**: GitHub CLI の仕様により `<!-- -->` が `&lt;!-- --&gt;` に変換される

### GitHub CLI の HTML コメントエスケープ問題

**重要**: GitHub CLI (`gh pr edit`) は HTML コメントを自動エスケープします。また、シェルのリダイレクト処理で `EOF < /dev/null` などの不正な文字列が混入する場合があります。

#### 根本的解決策

1. **GitHub API の --field オプション使用**: `--field` を使用して適切なエスケープ処理
2. **シェル処理の簡素化**: 複雑なリダイレクトやパイプ処理を避ける
3. **テンプレート処理の単純化**: HTML コメント除去処理を廃止し、完全保持
4. **JSON エスケープの適切な処理**: 特殊文字を正しく処理

### デバッグオプション

```bash
# 詳細ログ出力（実装時に追加）
/pr-auto-update --verbose
```