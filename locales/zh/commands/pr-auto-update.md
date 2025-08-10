## PR 自动更新

## 概述

自动更新 Pull Request 描述和标签的命令。通过分析 Git 更改内容，生成并设置适当的描述文本和标签。

## 使用方法

```bash
/pr-auto-update [选项] [PR 编号]
```

### 选项

- `--pr <编号>` : 指定目标 PR 编号（省略时从当前分支自动检测）
- `--description-only` : 仅更新描述（不修改标签）
- `--labels-only` : 仅更新标签（不修改描述）
- `--dry-run` : 不执行实际更新，仅显示生成的内容
- `--lang <语言>` : 指定语言（ja, en）

### 基本示例

```bash
# 自动更新当前分支的 PR
/pr-auto-update

# 更新特定的 PR
/pr-auto-update --pr 1234

# 仅更新描述
/pr-auto-update --description-only

# 预演模式确认
/pr-auto-update --dry-run
```

## 功能详情

### 1. PR 自动检测

从当前分支自动检测对应的 PR：

```bash
# 从分支搜索 PR
gh pr list --head $(git branch --show-current) --json number,title,url
```

### 2. 更改内容分析

收集和分析以下信息：

- **文件更改**: 添加、删除、修改的文件
- **代码分析**: import 语句、函数定义、类定义的更改
- **测试**: 测试文件的存在与内容
- **文档**: README、docs 的更新
- **配置**: package.json、pubspec.yaml、配置文件的更改
- **CI/CD**: GitHub Actions、workflow 的更改

### 3. 描述文本自动生成

#### 模板处理优先级

1. **现有 PR 描述**: **完全遵循**已存在的内容
2. **项目模板**: 从 `.github/PULL_REQUEST_TEMPLATE.md` 获取结构
3. **默认模板**: 上述不存在时的后备方案

#### 现有内容保留规则

**重要**: 不修改现有内容

- 保留已写的部分
- 仅补充空白部分
- 保留功能性注释（如 Copilot review rule 等）

#### 项目模板的使用

```bash
# 解析 .github/PULL_REQUEST_TEMPLATE.md 的结构
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
2. **GitHub API**: 使用 `gh api repos/{OWNER}/{REPO}/labels --jq '.[].name'` 获取现有标签

#### 自动判定规则

**基于文件模式**:

- 文档: `*.md`, `README`, `docs/` → 包含 `documentation|docs|doc` 的标签
- 测试: `test`, `spec` → 包含 `test|testing` 的标签
- CI/CD: `.github/`, `*.yml`, `Dockerfile` → 包含 `ci|build|infra|ops` 的标签
- 依赖: `package.json`, `pubspec.yaml`, `requirements.txt` → 包含 `dependencies|deps` 的标签

**基于更改内容**:

- Bug 修复: `fix|bug|error|crash|修复` → 包含 `bug|fix` 的标签
- 新功能: `feat|feature|add|implement|新功能|实装` → 包含 `feature|enhancement|feat` 的标签
- 重构: `refactor|clean|重构` → 包含 `refactor|cleanup|clean` 的标签
- 性能: `performance|perf|optimize|性能` → 包含 `performance|perf` 的标签
- 安全: `security|secure|安全` → 包含 `security` 的标签

#### 约束

- **最多 3 个**: 自动选择的标签数量上限
- **仅限现有标签**: 禁止创建新标签
- **部分匹配**: 根据标签名是否包含关键词判定

#### 实际使用示例

**存在 `.github/labels.yml` 时**:

```bash
# 从标签定义自动获取
grep "^- name:" .github/labels.yml | sed "s/^- name: '\\?\\([^']*\\)'\\?/\\1/"

# 例：使用项目特定的标签体系
```

**从 GitHub API 获取时**:

```bash
# 获取现有标签列表
gh api repos/{OWNER}/{REPO}/labels --jq '.[].name'

# 例：使用 bug, enhancement, documentation 等标准标签
```

### 5. 执行流程

```bash
#!/bin/bash

# 1. PR 检测与获取
detect_pr() {
  if [ -n "$PR_NUMBER" ]; then
    echo $PR_NUMBER
  else
    gh pr list --head $(git branch --show-current) --json number --jq '.[0].number'
  fi
}

# 2. 更改内容分析
analyze_changes() {
  local pr_number=$1
  
  # 获取文件更改
  gh pr diff $pr_number --name-only
  
  # 内容分析
  gh pr diff $pr_number | head -1000
}

# 3. 描述生成
generate_description() {
  local pr_number=$1
  local changes=$2
  
  # 获取当前 PR 描述
  local current_body=$(gh pr view $pr_number --json body --jq -r .body)
  
  # 如有现有内容则直接使用
  if [ -n "$current_body" ]; then
    echo "$current_body"
  else
    # 从模板生成新内容
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
    # 直接使用模板（保留 HTML 注释）
    echo "$template"
  else
    # 使用默认格式生成
    echo "## What does this change?"
    echo ""
    echo "$changes"
  fi
}

# 4. 标签确定
determine_labels() {
  local changes=$1
  local file_list=$2
  local pr_number=$3
  
  # 获取可用标签
  local available_labels=()
  if [ -f ".github/labels.yml" ]; then
    # 从 labels.yml 提取标签名
    available_labels=($(grep "^- name:" .github/labels.yml | sed "s/^- name: '\\?\\([^']*\\)'\\?/\\1/"))
  else
    # 从 GitHub API 获取标签
    local repo_info=$(gh repo view --json owner,name)
    local owner=$(echo "$repo_info" | jq -r .owner.login)
    local repo=$(echo "$repo_info" | jq -r .name)
    available_labels=($(gh api "repos/$owner/$repo/labels" --jq '.[].name'))
  fi
  
  local suggested_labels=()
  
  # 通用模式匹配
  analyze_change_patterns "$file_list" "$changes" available_labels suggested_labels
  
  # 限制最多 3 个
  echo "${suggested_labels[@]:0:3}"
}

# 根据更改模式确定标签
analyze_change_patterns() {
  local file_list="$1"
  local changes="$2"
  local -n available_ref=$3
  local -n suggested_ref=$4
  
  # 根据文件类型判定
  if echo "$file_list" | grep -q "\\.md$\\|README\\|docs/"; then
    add_matching_label "documentation\\|docs\\|doc" available_ref suggested_ref
  fi
  
  if echo "$file_list" | grep -q "test\\|spec"; then
    add_matching_label "test\\|testing" available_ref suggested_ref
  fi
  
  # 根据更改内容判定
  if echo "$changes" | grep -iq "fix\\|bug\\|error\\|crash\\|修复"; then
    add_matching_label "bug\\|fix" available_ref suggested_ref
  fi
  
  if echo "$changes" | grep -iq "feat\\|feature\\|add\\|implement\\|新功能\\|实现"; then
    add_matching_label "feature\\|enhancement\\|feat" available_ref suggested_ref
  fi
}

# 添加匹配的标签
add_matching_label() {
  local pattern="$1"
  local -n available_ref=$2
  local -n suggested_ref=$3
  
  # 如果已有 3 个则跳过
  if [ ${#suggested_ref[@]} -ge 3 ]; then
    return
  fi
  
  # 添加匹配模式的第一个标签
  for available_label in "${available_ref[@]}"; do
    if echo "$available_label" | grep -iq "$pattern"; then
      # 重复检查
      local already_exists=false
      for existing in "${suggested_ref[@]}"; do
        if [ "$existing" = "$available_label" ]; then
          already_exists=true
          break
        fi
      done
      
      if [ "$already_exists" = false ]; then
        suggested_ref+=("$available_label")
        return
      fi
    fi
  done
}

# 为兼容性保留旧函数
find_and_add_label() {
  add_matching_label "$@"
}

# 5. PR 更新
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
    # 获取仓库信息
    local repo_info=$(gh repo view --json owner,name)
    local owner=$(echo "$repo_info" | jq -r .owner.login)
    local repo=$(echo "$repo_info" | jq -r .name)
    
    # 使用 GitHub API 更新正文（保留 HTML 注释）
    # 正确处理 JSON 转义
    local escaped_body=$(echo "$description" | jq -R -s .)
    gh api \
      --method PATCH \
      "/repos/$owner/$repo/pulls/$pr_number" \
      --field body="$description"
    
    # 标签使用常规 gh 命令即可
    if [ -n "$labels" ]; then
      gh pr edit $pr_number --add-label "$labels"
    fi
  fi
}
```

## 配置文件（未来扩展用）

`~/.claude/pr-auto-update.config`:

```json
{
  "language": "ja",
  "max_labels": 3
}
```

## 常见模式

### Flutter 项目

```markdown
## What does this change?

实现了{功能名}。解决了用户的{问题}。

### 主要更改内容

- **UI 实现**: 新建{画面名}
- **状态管理**: 添加 Riverpod Provider
- **API 集成**: 实现 GraphQL 查询与变更
- **测试**: 添加 Widget 测试和单元测试

### 技术规格

- **架构**: {使用的模式}
- **依赖**: {新增的包}
- **性能**: {优化内容}
```

### Node.js 项目

```markdown
## What does this change?

实现了{API 名}端点。支持{用例}。

### 主要更改内容

- **API 实现**: 新建{端点}
- **验证**: 添加请求验证逻辑
- **数据库**: 实现对{表名}的操作
- **测试**: 添加集成测试和单元测试

### 安全性

- **认证**: JWT 令牌验证
- **授权**: 基于角色的访问控制
- **输入验证**: SQL 注入防护
```

### CI/CD 改进

```markdown
## What does this change?

改进了 GitHub Actions 工作流。实现了{效果}。

### 改进内容

- **性能**: 构建时间减少{时间}
- **可靠性**: 增强错误处理
- **安全性**: 改进密钥管理

### 技术细节

- **并行化**: {作业名}并行执行
- **缓存**: 优化{缓存对象}的缓存策略
- **监控**: 添加{指标}监控
```

## 注意事项

1. **完全保留现有内容**:
   - **一字不改**现有描述内容
   - 仅补充空白注释和占位符
   - 尊重用户有意编写的内容

2. **模板优先级**:
   - 现有 PR 描述 > `.github/PULL_REQUEST_TEMPLATE.md` > 默认
   - 完全遵循项目特定的模板结构

3. **标签约束**:
   - 如存在 `.github/labels.yml` 则优先使用
   - 不存在时从 GitHub API 获取现有标签
   - 禁止创建新标签
   - 自动选择最多 3 个

4. **安全更新**:
   - 推荐使用 `--dry-run` 预先确认
   - 包含敏感信息的更改时显示警告
   - 保存原始描述作为备份

5. **保持一致性**:
   - 符合项目现有 PR 风格
   - 统一语言（日语/英语）
   - 继承标签规则

## 故障排除

### 常见问题

1. **找不到 PR**: 检查分支名与 PR 的关联
2. **权限错误**: 检查 GitHub CLI 的认证状态
3. **无法设置标签**: 检查仓库权限
4. **HTML 注释被转义**: GitHub CLI 的规格导致 `<!-- -->` 被转换为 `&lt;!-- --&gt;`

### GitHub CLI 的 HTML 注释转义问题

**重要**: GitHub CLI (`gh pr edit`) 会自动转义 HTML 注释。此外，Shell 的重定向处理可能混入 `EOF < /dev/null` 等非法字符串。

#### 根本解决方案

1. **使用 GitHub API 的 --field 选项**: 使用 `--field` 进行适当的转义处理
2. **简化 Shell 处理**: 避免复杂的重定向和管道处理
3. **简化模板处理**: 废除 HTML 注释移除处理，完全保留
4. **正确处理 JSON 转义**: 正确处理特殊字符

### 调试选项

```bash
# 输出详细日志（实现时添加）
/pr-auto-update --verbose
```
