## Issue List

現在のリポジトリのオープン Issue 一覧を優先順位付きで表示します。

### 使い方

```bash
# Claude に依頼
「オープン Issue 一覧を優先順位付きで表示して」
```

### 基本例

```bash
# リポジトリ情報を取得
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# オープン Issue 情報を取得して Claude に依頼
gh issue list --state open --json number,title,author,createdAt,updatedAt,labels,assignees,comments --limit 30

「上記の Issue を優先度別に整理して、各 Issue の 2 行概要も含めて表示して。URL は上記で取得したリポジトリ名を使用して生成して」
```

### 表示形式

```
オープン Issue 一覧（優先順位順）

### 高優先度
#番号 タイトル [ラベル] | 作者 | オープンから経過時間 | コメント数 | 担当者
      ├─ 概要 1 行目
      └─ 概要 2 行目
      https://github.com/owner/repo/issues/番号

### 中優先度
（同様の形式）

### 低優先度
（同様の形式）
```

### 優先度の判定基準

**高優先度**

- `bug` ラベルが付いている Issue
- `critical` や `urgent` ラベルが付いている Issue
- `security` ラベルが付いている Issue

**中優先度**

- `enhancement` ラベルが付いている Issue
- `feature` ラベルが付いている Issue
- 担当者が設定されている Issue

**低優先度**

- `documentation` ラベルが付いている Issue
- `good first issue` ラベルが付いている Issue
- `wontfix` や `duplicate` ラベルが付いている Issue

### ラベルによるフィルタリング

```bash
# 特定のラベルの Issue のみ取得
gh issue list --state open --label "bug" --json number,title,author,createdAt,labels,comments --limit 30

# 複数ラベルでフィルタリング（AND 条件）
gh issue list --state open --label "bug,high-priority" --json number,title,author,createdAt,labels,comments --limit 30
```

### 注意事項

- GitHub CLI (`gh`) が必要です
- オープン状態の Issue のみ表示します
- 最大 30 件の Issue を表示します
- 経過時間は Issue がオープンされてからの時間です
- Issue の URL は実際のリポジトリ名から自動生成されます