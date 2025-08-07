## PR List

現在のリポジトリのオープン PR 一覧を優先順位付きで表示します。

### 使い方

```bash
# Claude に依頼
「オープン PR 一覧を優先順位付きで表示して」
```

### 基本例

```bash
# リポジトリ情報を取得
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# オープン PR 情報を取得して Claude に依頼
gh pr list --state open --draft=false --json number,title,author,createdAt,additions,deletions,reviews --limit 30

「上記の PR を優先度別に整理して、各 PR の 2 行概要も含めて表示して。URL は上記で取得したリポジトリ名を使用して生成して」
```

### 表示形式

```
オープン PR 一覧（優先順位順）

### 高優先度
#番号 タイトル [Draft/DNM] | 作者 | オープンから経過時間 | Approved 数 | +追加/-削除
      ├─ 概要 1 行目
      └─ 概要 2 行目
      https://github.com/owner/repo/pull/番号

### 中優先度
（同様の形式）

### 低優先度
（同様の形式）
```

### 優先度の判定基準

**高優先度**

- `fix:` バグ修正
- `release:` リリース作業

**中優先度**

- `feat:` 新機能
- `update:` 機能改善
- その他通常の PR

**低優先度**

- DO NOT MERGE を含む PR
- Draft で `test:`、`build:`、`perf:` の PR

### 注意事項

- GitHub CLI (`gh`) が必要です
- オープン状態の PR のみ表示します（Draft は除外）
- 最大 30 件の PR を表示します
- 経過時間は PR がオープンされてからの時間です
- PR の URL は実際のリポジトリ名から自動生成されます