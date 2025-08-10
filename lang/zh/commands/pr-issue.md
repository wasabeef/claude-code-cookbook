## 问题列表

按优先级显示当前仓库的开放Issue列表。

### 使用方法

```bash
# 向Claude请求
「请按优先级显示开放Issue列表」
```

### 基本示例

```bash
# 获取仓库信息
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# 获取开放Issue信息并向Claude请求
gh issue list --state open --json number,title,author,createdAt,updatedAt,labels,assignees,comments --limit 30

「请将上述Issue按优先级整理，并包含每个Issue的2行概要。URL使用上述获取的仓库名生成」
```

### 显示格式

```
开放Issue列表（按优先级排序）

### 高优先级
#编号 标题 [标签] | 作者 | 开放时间 | 评论数 | 负责人
      ├─ 概要第1行
      └─ 概要第2行
      https://github.com/owner/repo/issues/编号

### 中优先级
（类似格式）

### 低优先级
（类似格式）
```

### 优先级判定标准

**高优先级**

- 带有`bug`标签的Issue
- 带有`critical`或`urgent`标签的Issue
- 带有`security`标签的Issue

**中优先级**

- 带有`enhancement`标签的Issue
- 带有`feature`标签的Issue
- 已分配负责人的Issue

**低优先级**

- 带有`documentation`标签的Issue
- 带有`good first issue`标签的Issue
- 带有`wontfix`或`duplicate`标签的Issue

### 按标签过滤

```bash
# 仅获取特定标签的Issue
gh issue list --state open --label "bug" --json number,title,author,createdAt,labels,comments --limit 30

# 多标签过滤（AND条件）
gh issue list --state open --label "bug,high-priority" --json number,title,author,createdAt,labels,comments --limit 30
```

### 注意事项

- 需要GitHub CLI (`gh`)
- 仅显示开放状态的Issue
- 最多显示30个Issue
- 经过时间是从Issue开放以来的时间
- Issue的URL会从实际仓库名自动生成
```