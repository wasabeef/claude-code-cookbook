## PR自动更新

## 概述

自动更新Pull Request描述和标签的命令。分析Git变更内容，生成并设置适当的说明文本和标签。

## 使用方法

```bash
/pr-auto-update [选项] [PR编号]
```

### 选项

- `--pr <编号>` : 指定目标PR编号（省略时从当前分支自动检测）
- `--description-only` : 仅更新说明文本（不更改标签）
- `--labels-only` : 仅更新标签（不更改说明文本）
- `--dry-run` : 不实际更新，仅显示将生成的内容
- `--lang <语言>` : 指定语言（ja, en）

### 基本示例

```bash
# 自动更新当前分支的PR
/pr-auto-update

# 更新特定PR
/pr-auto-update --pr 1234

# 仅更新说明文本
/pr-auto-update --description-only

# 以模拟方式确认
/pr-auto-update --dry-run
```

## 功能详情

### 1. PR自动检测

从当前分支自动检测对应的PR：

```bash
# 从分支搜索PR
gh pr list --head $(git branch --show-current) --json number,title,url
```

### 2. 变更内容分析

收集和分析以下信息：

- **文件变更**: 添加、删除、修改的文件
- **代码分析**: import语句、函数定义、类定义的变更
- **测试**: 测试文件的存在和内容
- **文档**: README、docs的更新
- **配置**: package.json、pubspec.yaml、配置文件的变更
- **CI/CD**: GitHub Actions、workflow的变更

### 3. 说明文本自动生成

#### 模板处理的优先级

1. **现有PR说明**: 完全遵循已描述的内容
2. **项目模板**: 从`.github/PULL_REQUEST_TEMPLATE.md`获取结构
3. **默认模板**: 上述不存在时的后备方案

#### 现有内容的保留规则

**重要**: 不更改现有内容

- 保留已编写的部分
- 仅补充空的部分
- 保留功能性注释（如Copilot review rule等）

#### 项目模板的使用

```bash
# 解析.github/PULL_REQUEST_TEMPLATE.md的结构
parse_template_structure() {
  local template_file="$1"
  
  if [ -f "$template_file" ]; then
    # 提取部分结构
grep -E '^##|^###' "$template_file"
    
    # 识别注释占位符
grep -E '<!--.*-->' "$template_file"
    
    # 完全遵循现有模板结构
    cat "$template_file"
  fi
}
```

### 4. 标签自动设置

#### 标签获取机制

**优先级**:

1. **`.github/labels.yml`**: 从项目特定的标签定义获取
2. **GitHub API**: 通过`gh api repos/{OWNER}/{REPO}/labels --jq '.[].name'`获取现有标签

#### 自动判定规则

**基于文件模式**:

- 文档: `*.md`, `README`, `docs/` → 包含`documentation|docs|doc`的标签
- 测试: `test`, `spec` → 包含`test|testing`的标签
- CI/CD: `.github/`, `*.yml`, `Dockerfile` → 包含`ci|build|infra|ops`的标签
- 依赖关系: `package.json`, `pubspec.yaml`, `requirements.txt` → 包含`dependencies|deps`的标签

**基于变更内容**:

- 错误修复: `fix|bug|error|crash|修正` → 包含`bug|fix`的标签
- 新功能: `feat|feature|add|implement|新功能|実装` → 包含`feature|enhancement|feat`的标签
- 重构: `refactor|clean|リファクタ` → 包含`refactor|cleanup|clean`的标签
- 性能: `performance|perf|optimize|パフォーマンス` → 包含`performance|perf`的标签
- 安全: `security|secure|セキュリティ` → 包含`security`的标签

#### 约束

- **最多3个**: 自动选择的标签数量上限
- **仅现有标签**: 禁止创建新标签
- **部分匹配**: 通过标签名称是否包含关键字来判定

#### 实际使用示例

**存在`.github/labels.yml`时**:

```bash
# 从标签定义自动获取
grep "^- name:" .github/labels.yml | sed "s/^- name: '\?\([^']*\)'\?/\1/"

# 示例: 使用项目特定的标签体系
```

**从GitHub API获取时**:

```bash
# 获取现有标签列表
gh api repos/{OWNER}/{REPO}/labels --jq '.[].name'

# 示例: 使用bug, enhancement, documentation等标准标签
```

### 5. 执行流程

```bash
#!/bin/bash

# 1. PR检测和获取
detect_pr() {
  if [ -n "$PR_NUMBER" ]; then
    echo $PR_NUMBER
  else
gh pr list --head $(git branch --show-current) --json number --jq '.[0].number'
  fi
}

# 2. 变更内容分析
analyze_changes() {
  local pr_number=$1
  
  # 获取文件变更
gh pr diff $pr_number --name-only
  
  # 内容分析
gh pr diff $pr_number | head -1000
}

# 3. 生成说明文本
generate_description() {
  local pr_number=$1
  local changes=$2
  
  # 获取当前PR说明
  local current_body=$(gh pr view $pr_number --json body --jq -r .body)
  
  # 如果有现有内容则直接使用
  if [ -n "$current_body" ]; then
    echo "$current_body"
  else
    # 从模板新建生成
    local template_file=".github/PULL_REQUEST_TEMPLATE.md"
    if [ -f "$template_file" ]; then
generate_from_template "$(cat "$template_file")" "$changes"
    else
generate_from_template "" "$changes"
    fi
  fi
}

# 从模板生成
generate_from_template() {
  local template="$1"
  local changes="$2"
  
  if [ -n "$template" ]; then
    # 原样使用模板（保留HTML注释）
```