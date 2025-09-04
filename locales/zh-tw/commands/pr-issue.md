## Issue 列表

顯示當前倉庫的開放 Issue 列表，並按優先級排序。

### 使用方法

```bash
# 向 Claude 請求
「請按優先級顯示開放的 Issue 列表」
```

### 基本示例

```bash
# 獲取倉庫資訊
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# 獲取開放 Issue 資訊並請求 Claude
gh issue list --state open --json number,title,author,createdAt,updatedAt,labels,assignees,comments --limit 30

「請按優先級整理上述 Issue，並包含每個 Issue 的 2 行概要。使用上面獲取的倉庫名生成 URL」
```

### 顯示格式

```
開放 Issue 列表(按優先級排序)

### 高優先級
#編号 標題 [標簽] | 作者 | 開放時长 | 評論數 | 負責人
      ├─ 概要第 1 行
      └─ 概要第 2 行
      https://github.com/owner/repo/issues/編号

### 中優先級
(相同格式)

### 低優先級
(相同格式)
```

### 優先級判定標準

**高優先級**

- 带有 `bug` 標簽的 Issue
- 带有 `critical` 或 `urgent` 標簽的 Issue
- 带有 `security` 標簽的 Issue

**中優先級**

- 带有 `enhancement` 標簽的 Issue
- 带有 `feature` 標簽的 Issue
- 已分配負責人的 Issue

**低優先級**

- 带有 `documentation` 標簽的 Issue
- 带有 `good first issue` 標簽的 Issue
- 带有 `wontfix` 或 `duplicate` 標簽的 Issue

### 按標簽筛選

```bash
# 仅獲取特定標簽的 Issue
gh issue list --state open --label "bug" --json number,title,author,createdAt,labels,comments --limit 30

# 使用多個標簽筛選(AND 條件)
gh issue list --state open --label "bug,high-priority" --json number,title,author,createdAt,labels,comments --limit 30
```

### 注意事項

- 需要安裝 GitHub CLI (`gh`)
- 仅顯示開放狀態的 Issue
- 最多顯示 30 個 Issue
- 時长是從 Issue 開放至今的時間
- Issue URL 根據實際倉庫名自動生成
