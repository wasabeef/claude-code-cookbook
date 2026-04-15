---
description: "从暂存更改生成提交消息。「生成提交消息」「建议 commit message」「写个提交信息」等触发。"
allowed-tools:
  - Bash(git diff *)
  - Bash(git log *)
  - Read
---

# 从暂存更改生成提交消息

从暂存的更改 (git diff --staged) 生成合适的提交消息。仅生成消息并复制到剪贴板，不执行 git 命令。

## 使用方法

```bash
/commit-message [选项]
```

## 选项

- `--format <格式>` : 指定消息格式 (conventional, gitmoji, angular)
- `--lang <语言>` : 强制指定消息语言 (en, zh-cn)
- `--breaking` : 检测并记录 Breaking Change

## 基本示例

```bash
# 从暂存的更改生成消息 (自动判定语言)
# 主要候选会自动复制到剪贴板
/commit-message

# 强制指定语言
/commit-message --lang zh-cn
/commit-message --lang en

# 检测 Breaking Change
/commit-message --breaking
```

## 前提条件

**重要**: 此命令仅分析暂存的更改。需要先使用 `git add` 暂存更改。

```bash
# 如果没有暂存更改，会显示警告
$ /commit-message
没有暂存的更改。请先执行 git add。
```

## 自动剪贴板功能

生成的主要候选会以 `git commit -m "消息"` 的完整格式自动复制到剪贴板。可以直接在终端粘贴执行。

**实现注意事项**:

- 将提交命令传递给 `pbcopy` 时，应与消息输出分开执行
- 使用 `printf` 而不是 `echo` 以避免末尾换行

## 项目规范自动检测

**重要**: 如果存在项目特有的规范，将优先使用。

### 1. CommitLint 配置检查

从以下文件自动检测配置：

- `commitlint.config.js`
- `commitlint.config.mjs`
- `commitlint.config.cjs`
- `commitlint.config.ts`
- `.commitlintrc.js`
- `.commitlintrc.json`
- `.commitlintrc.yml`
- `.commitlintrc.yaml`
- `package.json` 的 `commitlint` 部分

```bash
# 搜索配置文件
find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
```

### 2. 自定义类型检测

项目特有类型示例：

```javascript
// commitlint.config.mjs
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      [
        "feat",
        "fix",
        "docs",
        "style",
        "refactor",
        "test",
        "chore",
        "wip", // 进行中
        "hotfix", // 紧急修复
        "release", // 发布
        "deps", // 依赖更新
        "config", // 配置更改
      ],
    ],
  },
};
```

### 3. 语言设置检测

```javascript
// 项目使用中文消息时
export default {
  rules: {
    "subject-case": [0], // 为支持中文而禁用
    "subject-max-length": [2, "always", 72], // 为中文调整字符数限制
  },
};
```

### 4. 现有提交历史分析

```bash
# 从最近的提交学习使用模式
git log --oneline -50 --pretty=format:"%s"

# 使用类型统计
git log --oneline -100 --pretty=format:"%s" | \
grep -oE '^[a-z]+(\([^)]+\))?' | \
sort | uniq -c | sort -nr
```

## 语言自动判定

根据以下条件自动切换中文/英文：

1. **CommitLint 配置**中的语言设置
2. **git log 分析**的自动判定
3. **项目文件**的语言设置
4. **更改文件**中的注释和字符串分析

默认为英文。判定为中文项目时生成中文消息。

## 消息格式

### Conventional Commits (默认)

```text
<type>: <description>
```

**重要**: 必须生成单行提交消息。不生成多行消息。

**注意**: 如果项目有特有规范，将优先使用。

## 标准类型

**必须类型**:

- `feat`: 新功能 (用户可见的功能添加)
- `fix`: 缺陷修复

**可选类型**:

- `build`: 构建系统或外部依赖的更改
- `chore`: 其他更改 (不影响发布)
- `ci`: CI 配置文件或脚本的更改
- `docs`: 仅文档更改
- `style`: 不影响代码含义的更改 (空格、格式、分号等)
- `refactor`: 既不修复缺陷也不添加功能的代码更改
- `perf`: 性能改进
- `test`: 添加或修正测试

## 输出示例 (英文项目)

```bash
$ /commit-message

📝 提交消息建议
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 主要候选:
feat: implement JWT-based authentication system

📋 备选方案:
1. feat: add user authentication with JWT tokens
2. fix: resolve token validation error in auth middleware
3. refactor: extract auth logic into separate module

✅ `git commit -m "feat: implement JWT-based authentication system"` 已复制到剪贴板
```

**实现示例 (修正版)**:

```bash
# 先将提交命令复制到剪贴板 (无换行)
printf 'git commit -m "%s"' "$COMMIT_MESSAGE" | pbcopy

# 然后显示消息
cat << EOF
📝 提交消息建议
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 主要候选:
$COMMIT_MESSAGE

📋 备选方案:
1. ...
2. ...
3. ...

✅ `git commit -m "$COMMIT_MESSAGE"` 已复制到剪贴板
EOF
```

## 输出示例 (中文项目)

```bash
$ /commit-message

📝 提交消息建议
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 主要候选:
feat: 实现 JWT 认证系统

📋 备选方案:
1. feat: 添加基于 JWT 令牌的用户认证
2. fix: 解决认证中间件的令牌验证错误
3. docs: 将认证逻辑分离到单独模块

✅ `git commit -m "feat: 实现 JWT 认证系统"` 已复制到剪贴板
```

## 工作概要

1. **分析**: 分析 `git diff --staged` 的内容
2. **生成**: 生成合适的提交消息
3. **复制**: 自动将主要候选复制到剪贴板

**注意**: 此命令不执行 git add 或 git commit。仅生成提交消息并复制到剪贴板。

## 智能功能

### 1. 更改内容自动分类 (仅暂存文件)

- 新文件添加 → `feat`
- 错误修复模式 → `fix`
- 仅测试文件 → `test`
- 配置文件更改 → `chore`
- README/docs 更新 → `docs`

### 2. 项目规范自动检测

- `.gitmessage` 文件
- `CONTRIBUTING.md` 中的规范
- 过去提交历史模式

### 3. 语言判定详情 (仅暂存更改)

```bash
# 判定基准 (优先级)
1. 从 git diff --staged 的内容判定语言
2. 暂存文件的注释分析
3. git log --oneline -20 的语言分析
4. 项目主要语言设置
```

### 4. 暂存分析详情

分析使用的信息 (仅读取):

- `git diff --staged --name-only` - 更改文件列表
- `git diff --staged` - 实际更改内容
- `git status --porcelain` - 文件状态

## Breaking Change 检测时

当有 API 破坏性更改时：

**英文**:

```bash
feat!: change user API response format

BREAKING CHANGE: user response now includes additional metadata
```

或

```bash
feat(api)!: change authentication flow
```

**中文**:

```bash
feat!: 更改用户 API 响应格式

BREAKING CHANGE: 响应现在包含额外的元数据
```

或

```bash
feat(api)!: 更改认证流程
```

## 最佳实践

1. **适应项目**: 遵循现有的提交语言
2. **简洁性**: 50 字符内要清楚
3. **一致性**: 不要混合使用 (英文就统一英文)
4. **OSS**: 开源软件推荐英文
5. **坚持单行**: 必须单行提交消息 (需要详细说明时在 PR 中补充)

## 常见模式

**英文**:

```text
feat: add user registration endpoint
fix: resolve memory leak in cache manager
docs: update API documentation
```

**中文**:

```text
feat: 添加用户注册端点
fix: 解决缓存管理器内存泄漏
docs: 更新 API 文档
```

## 与 Claude 的协作

```bash
# 与暂存更改结合使用
git add -p  # 交互式暂存
/commit-message
"生成最优的提交消息"

# 仅暂存特定文件后分析
git add src/auth/*.js
/commit-message --lang zh-cn
"为认证相关更改生成合适的消息"

# Breaking Change 检测和应对
git add -A
/commit-message --breaking
"如有破坏性更改请适当标记"
```

## 注意事项

- **前提条件**: 更改需要先通过 `git add` 暂存
- **限制事项**: 未暂存的更改不在分析范围内
- **推荐事项**: 请事先确认项目现有的提交规范
