## PR 列表

顯示當前倉庫的開放 PR 列表，並按優先級排序。

### 使用方法

```bash
# 向 Claude 請求
「請按優先級顯示開放的 PR 列表」
```

### 基本示例

```bash
# 獲取倉庫資訊
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# 獲取開放 PR 資訊並請求 Claude
gh pr list --state open --draft=false --json number,title,author,createdAt,additions,deletions,reviews --limit 30

「請按優先級整理上述 PR，並包含每個 PR 的 2 行概要。使用上面獲取的倉庫名生成 URL」
```

### 顯示格式

```text
開放 PR 列表(按優先級排序)

### 高優先級
#編号 標題 [Draft/DNM] | 作者 | 開放時长 | 批準數 | +添加/-刪除
      ├─ 概要第 1 行
      └─ 概要第 2 行
      https://github.com/owner/repo/pull/編号

### 中優先級
(相同格式)

### 低優先級
(相同格式)
```

### 優先級判定標準

**高優先級**

- `fix:` Bug 修復
- `release:` 發布工作

**中優先級**

- `feat:` 新功能
- `update:` 功能改進
- 其他常規 PR

**低優先級**

- 包含 DO NOT MERGE 的 PR
- Draft 狀態的 `test:`、`build:`、`perf:` PR

### 注意事項

- 需要安裝 GitHub CLI (`gh`)
- 仅顯示開放狀態的 PR(排除 Draft)
- 最多顯示 30 個 PR
- 時长是從 PR 開放至今的時間
- PR URL 根據實際倉庫名自動生成
