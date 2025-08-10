## PR 列表

显示当前仓库的开放 PR 列表，并按优先级排序。

### 使用方法

```bash
# 向 Claude 请求
「请按优先级显示开放的 PR 列表」
```

### 基本示例

```bash
# 获取仓库信息
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# 获取开放 PR 信息并请求 Claude
gh pr list --state open --draft=false --json number,title,author,createdAt,additions,deletions,reviews --limit 30

「请按优先级整理上述 PR，并包含每个 PR 的 2 行概要。使用上面获取的仓库名生成 URL」
```

### 显示格式

```
开放 PR 列表（按优先级排序）

### 高优先级
#编号 标题 [Draft/DNM] | 作者 | 开放时长 | 批准数 | +添加/-删除
      ├─ 概要第 1 行
      └─ 概要第 2 行
      https://github.com/owner/repo/pull/编号

### 中优先级
（相同格式）

### 低优先级
（相同格式）
```

### 优先级判定标准

**高优先级**

- `fix:` Bug 修复
- `release:` 发布工作

**中优先级**

- `feat:` 新功能
- `update:` 功能改进
- 其他常规 PR

**低优先级**

- 包含 DO NOT MERGE 的 PR
- Draft 状态的 `test:`、`build:`、`perf:` PR

### 注意事项

- 需要安装 GitHub CLI (`gh`)
- 仅显示开放状态的 PR（排除 Draft）
- 最多显示 30 个 PR
- 时长是从 PR 开放至今的时间
- PR URL 根据实际仓库名自动生成
