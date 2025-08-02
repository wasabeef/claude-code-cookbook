## PR列表

按优先级显示当前仓库的开放PR列表。

### 使用方法

```bash
# 向Claude请求
「请按优先级显示开放PR列表」
```

### 基本示例

```bash
# 获取仓库信息
gh repo view --json nameWithOwner | jq -r '.nameWithOwner'

# 获取开放PR信息并向Claude请求
gh pr list --state open --draft=false --json number,title,author,createdAt,additions,deletions,reviews --limit 30

「请将上述PR按优先级整理，并包含每个PR的2行概要。URL使用上述获取的仓库名生成」
```

### 显示格式

```
开放PR列表（按优先级排序）

### 高优先级
#编号 标题 [Draft/DNM] | 作者 | 开放时间 | Approved数 | +添加/-删除
      ├─ 概要第1行
      └─ 概要第2行
      https://github.com/owner/repo/pull/番号

### 中优先级
（类似格式）

### 低优先级
（类似格式）
```

### 优先级判定标准

**高优先级**

- `fix:` 错误修复
- `release:` 发布工作

**中优先级**

- `feat:` 新功能
- `update:` 功能改进
- 其他普通PR

**低优先级**

- 包含DO NOT MERGE的PR
- Draft状态且包含`test:`、`build:`、`perf:`的PR

### 注意事项

- 需要GitHub CLI (`gh`)
- 仅显示开放状态的PR（排除Draft）
- 最多显示30个PR
- 经过时间是从PR开放以来的时间
- PR的URL会从实际仓库名自动生成
```