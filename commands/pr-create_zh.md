## PR创建

基于Git变更分析自动创建PR，实现高效的Pull Request工作流程。

### 使用方法

```bash
# 通过变更分析自动创建PR
git add . && git commit -m "feat: 实现用户认证功能"
「分析变更内容并使用适当的说明和标签创建Draft PR」

# 保持现有模板更新
cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
「请完全保持模板结构并补充变更内容」

# 逐步提高质量
gh pr ready
「质量确认完成后，请改为Ready for Review状态」
```

### 基本示例

```bash
# 1. 创建分支并提交
git checkout main && git pull
git checkout -b feat-user-profile
git add . && git commit -m "feat: 实现用户资料功能"
git push -u origin feat-user-profile

# 2. 创建PR
「请按照以下步骤创建PR：
1. 使用git diff --cached确认变更内容
2. 使用.github/PULL_REQUEST_TEMPLATE.md创建说明
3. 从变更内容中选择最多3个适当的标签
4. 创建为Draft PR（保留HTML注释）」

# 3. CI通过后改为Ready状态
「CI通过后请将PR改为Ready for Review状态」
```

### 执行步骤

#### 1. 创建分支

```bash
# 遵循命名规则: {type}-{subject}
git checkout main
git pull
git checkout -b feat-user-authentication

# 确认分支（显示当前分支名）
git branch --show-current
```

#### 2. 提交

```bash
# 暂存变更
git add .

# 遵循指南的提交消息
git commit -m "feat: 实现用户认证API"
```

#### 3. 推送到远程

```bash
# 首次推送（设置upstream）
git push -u origin feat-user-authentication

# 第二次及以后
git push
```

#### 4. 通过自动分析创建Draft PR

**步骤1: 分析变更内容**

```bash
# 获取文件变更（确认暂存变更）
git diff --cached --name-only

# 内容分析（最多1000行）
git diff --cached | head -1000
```

**步骤2: 自动生成说明**

```bash
# 模板处理优先级
# 1. 现有PR说明（完全保留）
# 2. .github/PULL_REQUEST_TEMPLATE.md
# 3. 默认模板

cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
# 保留HTML注释和分隔线，仅补充空部分
```

**步骤3: 自动选择标签**

```bash
# 获取可用标签（非交互式）
「请从.github/labels.yml或GitHub仓库获取可用标签，并根据变更内容自动选择适当的标签」

# 通过模式匹配自动选择（最多3个）
# - 文档: *.md, docs/ → documentation|docs
# - 测试: test, spec → test|testing
# - 错误修复: fix|bug → bug|fix
# - 新功能: feat|feature → feature|enhancement
```

**步骤4: 使用GitHub API创建PR（保留HTML注释）**

```bash
# 创建PR
「请使用以下信息创建Draft PR：
- 标题: 从提交消息自动生成
- 说明: 使用.github/PULL_REQUEST_TEMPLATE.md适当填写
- 标签: 从变更内容自动选择（最多3个）
- 基础分支: main
- 完全保留HTML注释」
```

**方法B: GitHub MCP（后备）**

```javascript
// 保留HTML注释创建PR
mcp_github_create_pull_request({
  owner: 'organization',
  repo: 'repository',
  base: 'main',
  head: 'feat-user-authentication',
  title: 'feat: 实现用户认证',
  body: prBodyContent, // 包含HTML注释的完整内容
  draft: true,
  maintainer_can_modify: true,
});
```

### 自动标签选择系统

#### 基于文件模式判断

- **文档**: `*.md`, `README`, `docs/` → `documentation|docs|doc`
- **测试**: `test`, `spec` → `test|testing`
- **CI/CD**: `.github/`, `*.yml`, `Dockerfile` → `ci|build|infra|ops`
- **依赖关系**: `package.json`, `pubspec.yaml` → `dependencies|deps`

#### 基于变更内容判断

- **错误修复**: `fix|bug|error|crash|修正` → `bug|fix`
- **新功能**: `feat|feature|add|implement|新功能|実装` → `feature|enhancement|feat`
- **重构**: `refactor|clean|リファクタ` → `refactor|cleanup|clean`
- **性能**: `performance|perf|optimize` → `performance|perf`
- **安全**: `security|secure` → `security`

#### 约束事项

- **最多3个**: 自动选择的上限
- **仅现有标签**: 禁止新建
- **部分匹配**: 根据包含关键字判断

### 项目指南

#### 基本态度

1. **务必以Draft开始**: 所有PR都以Draft状态创建
2. **逐步提高质量**: 阶段1（基本实现）→ 阶段2（添加测试）→ 阶段3（更新文档）
3. **适当标签**: 务必添加最多3种标签
4. **使用模板**: 务必使用.github/PULL_REQUEST_TEMPLATE.md
5. **日语空格**: 日语和半角英数字之间务必使用半角空格

#### 分支命名规则

```text
{type}-{subject}

示例:
- feat-user-profile
- fix-login-error
- refactor-api-client
```

#### 提交消息

```text
{type}: {description}

示例:
- feat: 实现用户认证API
- fix: 修复登录错误
- docs: 更新README
```

### 模板处理系统

#### 处理优先级

1. **现有PR说明**: 完全遵循已描述的内容
2. **项目模板**: 维持.github/PULL_REQUEST_TEMPLATE.md结构
```