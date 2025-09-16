## Issue 列表

显示当前仓库的开放 Issue 列表，并按优先级排序。

### 使用方法

```bash
# 向 Claude 请求
「请按优先级显示开放的 Issue 列表」
```

### 基本示例

```bash
# 获取仓库信息
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# 获取开放 Issue 信息并请求 Claude
gh issue list --state open --json number,title,author,createdAt,updatedAt,labels,assignees,comments --limit 30

「请按优先级整理上述 Issue，并包含每个 Issue 的 2 行概要。使用上面获取的仓库名生成 URL」
```

### 显示格式

```text
开放 Issue 列表(按优先级排序)

### 高优先级
#编号 标题 [标签] | 作者 | 开放时长 | 评论数 | 负责人
      ├─ 概要第 1 行
      └─ 概要第 2 行
      https://github.com/owner/repo/issues/编号

### 中优先级
(相同格式)

### 低优先级
(相同格式)
```

### 优先级判定标准

**高优先级**

- 带有 `bug` 标签的 Issue
- 带有 `critical` 或 `urgent` 标签的 Issue
- 带有 `security` 标签的 Issue

**中优先级**

- 带有 `enhancement` 标签的 Issue
- 带有 `feature` 标签的 Issue
- 已分配负责人的 Issue

**低优先级**

- 带有 `documentation` 标签的 Issue
- 带有 `good first issue` 标签的 Issue
- 带有 `wontfix` 或 `duplicate` 标签的 Issue

### 按标签筛选

```bash
# 仅获取特定标签的 Issue
gh issue list --state open --label "bug" --json number,title,author,createdAt,labels,comments --limit 30

# 使用多个标签筛选(AND 条件)
gh issue list --state open --label "bug,high-priority" --json number,title,author,createdAt,labels,comments --limit 30
```

### 注意事项

- 需要安装 GitHub CLI (`gh`)
- 仅显示开放状态的 Issue
- 最多显示 30 个 Issue
- 时长是从 Issue 开放至今的时间
- Issue URL 根据实际仓库名自动生成
