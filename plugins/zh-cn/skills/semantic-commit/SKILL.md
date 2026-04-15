---
description: "按语义单元拆分变更并提交。「提交」「分割提交」「语义提交」「按逻辑单元提交」等触发。"
allowed-tools:
  - Bash(git *)
  - Read
  - Grep
---

# 按语义单元拆分变更并提交

将大型变更拆分为有意义的最小单位，并按顺序使用语义化提交消息进行提交。不依赖外部工具，仅使用 git 标准命令。

## 使用方法

```bash
/semantic-commit [选项]
```

## 选项

- `--dry-run` : 不实际提交，仅显示建议的提交拆分
- `--lang <语言>` : 强制指定提交消息语言 (en, zh-cn)
- `--max-commits <数>` : 指定最大提交数 (默认: 10)

## 基本示例

```bash
# 分析当前变更并按逻辑单位提交
/semantic-commit

# 仅确认拆分方案 (不实际提交)
/semantic-commit --dry-run

# 用英语生成提交消息
/semantic-commit --lang en

# 用中文生成提交消息
/semantic-commit --lang zh-cn

# 最多拆分为 5 个提交
/semantic-commit --max-commits 5
```

## 工作流程

1. **变更分析**: 通过 `git diff HEAD` 获取所有变更
2. **文件分类**: 将变更的文件逻辑分组
3. **提交建议**: 为各组生成语义化提交消息
4. **顺序执行**: 用户确认后，按顺序提交各组

## 变更拆分的核心功能

### "大型变更"的检测

以下条件被检测为大型变更：

1. **变更文件数**: 5 个以上文件的变更
2. **变更行数**: 100 行以上的变更
3. **多功能**: 跨越 2 个以上功能区域的变更
4. **混合模式**: feat + fix + docs 混合

```bash
# 变更规模分析
CHANGED_FILES=$(git diff HEAD --name-only | wc -l)
CHANGED_LINES=$(git diff HEAD --stat | tail -1 | grep -o '[0-9]\+ insertions\|[0-9]\+ deletions' | awk '{sum+=$1} END {print sum}')

if [ $CHANGED_FILES -ge 5 ] || [ $CHANGED_LINES -ge 100 ]; then
  echo "检测到大型变更: 建议拆分"
fi
```

### "有意义的最小单位"拆分策略

#### 1. 按功能边界拆分

```bash
# 从目录结构识别功能单位
git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq
# → src/auth, src/api, components/ui 等
```

#### 2. 按变更类型分离

```bash
# 新文件 vs 现有文件修改
git diff HEAD --name-status | grep '^A' # 新文件
git diff HEAD --name-status | grep '^M' # 修改文件
git diff HEAD --name-status | grep '^D' # 删除文件
```

#### 3. 依赖关系分析

```bash
# 检测导入关系的变更
git diff HEAD | grep -E '^[+-].*import|^[+-].*require' | \
cut -d' ' -f2- | sort | uniq
```

### 文件单位的详细分析

```bash
# 获取变更文件列表
git diff HEAD --name-only

# 分别分析各文件的变更内容
git diff HEAD -- <file>

# 判定文件的变更类型
git diff HEAD --name-status | while read status file; do
  case $status in
    A) echo "$file: 新建" ;;
    M) echo "$file: 修改" ;;
    D) echo "$file: 删除" ;;
    R*) echo "$file: 重命名" ;;
  esac
done
```

### 逻辑分组的标准

1. **功能单位**: 相关功能的文件
   - `src/auth/` 下的文件 → 认证功能
   - `components/` 下的文件 → UI 组件

2. **变更类型**: 相同类型的变更
   - 仅测试文件 → `test:`
   - 仅文档 → `docs:`
   - 仅配置文件 → `chore:`

3. **依赖关系**: 相互关联的文件
   - 模型 + 迁移
   - 组件 + 样式

4. **变更规模**: 保持适当的提交大小
   - 每个提交 10 个文件以下
   - 高关联性文件分组

## 输出示例

```bash
$ /semantic-commit

变更分析中...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

检测到的变更:
• src/auth/login.ts (修改)
• src/auth/register.ts (新建)
• src/auth/types.ts (修改)
• tests/auth.test.ts (新建)
• docs/authentication.md (新建)

建议的提交拆分:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
提交 1/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
消息: feat: 实现用户注册和登录系统
包含文件:
  • src/auth/login.ts
  • src/auth/register.ts
  • src/auth/types.ts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
提交 2/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
消息: test: 添加认证系统的全面测试
包含文件:
  • tests/auth.test.ts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
提交 3/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
消息: docs: 添加认证系统文档
包含文件:
  • docs/authentication.md

是否按此拆分方案执行提交？ (y/n/edit):
```

## 执行时的选项

- `y` : 按建议的拆分执行
- `n` : 取消
- `edit` : 逐个编辑提交消息
- `merge <编号 1> <编号 2>` : 合并指定的提交
- `split <编号>` : 进一步拆分指定的提交

## Dry Run 模式

```bash
$ /semantic-commit --dry-run

变更分析中... (DRY RUN)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[显示提交拆分建议]

ℹ️  DRY RUN 模式: 不会实际执行提交
💡 要执行请去掉 --dry-run 选项重新运行
```

## 智能分析功能

### 1. 项目结构理解

- 从 `package.json`, `Cargo.toml`, `pom.xml` 等判断项目类型
- 从文件夹结构推测功能单位

### 2. 变更模式识别

```bash
# 检测 Bug 修复模式
- "fix", "bug", "error" 等关键词
- 异常处理的添加
- 条件分支的修改

# 检测新功能模式
- 新文件创建
- 新方法添加
- API 端点添加
```

### 3. 依赖关系分析

- 导入语句的变更
- 类型定义的添加/修改
- 与配置文件的关联性

## 技术实现

### 使用 Git 标准命令的顺序提交实现

#### 1. 预处理: 保存当前状态

```bash
# 如有未暂存的变更则先重置
git reset HEAD
git status --porcelain > /tmp/original_state.txt

# 确认工作分支
CURRENT_BRANCH=$(git branch --show-current)
echo "工作分支: $CURRENT_BRANCH"
```

#### 2. 按组顺序执行提交

```bash
# 读取拆分计划
while IFS= read -r commit_plan; do
  group_num=$(echo "$commit_plan" | cut -d':' -f1)
  files=$(echo "$commit_plan" | cut -d':' -f2- | tr ' ' '\n')

  echo "=== 执行提交 $group_num ==="

  # 仅暂存相关文件
  echo "$files" | while read file; do
    if [ -f "$file" ]; then
      git add "$file"
      echo "暂存: $file"
    fi
  done

  # 确认暂存状态
  staged_files=$(git diff --staged --name-only)
  if [ -z "$staged_files" ]; then
    echo "警告: 没有暂存的文件"
    continue
  fi

  # 生成提交消息 (LLM 分析)
  commit_msg=$(generate_commit_message_for_staged_files)

  # 用户确认
  echo "建议的提交消息: $commit_msg"
  echo "暂存的文件:"
  echo "$staged_files"
  read -p "执行此提交？ (y/n): " confirm

  if [ "$confirm" = "y" ]; then
    # 执行提交
    git commit -m "$commit_msg"
    echo "✅ 提交 $group_num 完成"
  else
    # 取消暂存
    git reset HEAD
    echo "❌ 跳过提交 $group_num"
  fi

done < /tmp/commit_plan.txt
```

#### 3. 错误处理和回滚

```bash
# 预提交钩子失败时的处理
commit_with_retry() {
  local commit_msg="$1"
  local max_retries=2
  local retry_count=0

  while [ $retry_count -lt $max_retries ]; do
    if git commit -m "$commit_msg"; then
      echo "✅ 提交成功"
      return 0
    else
      echo "❌ 提交失败 (尝试 $((retry_count + 1))/$max_retries)"

      # 合并预提交钩子的自动修正
      if git diff --staged --quiet; then
        echo "预提交钩子自动修正了变更"
        git add -u
      fi

      retry_count=$((retry_count + 1))
    fi
  done

  echo "❌ 提交失败。请手动确认。"
  return 1
}

# 从中断恢复
resume_from_failure() {
  echo "检测到中断的提交处理"
  echo "当前暂存状态:"
  git status --porcelain

  read -p "继续处理？ (y/n): " resume
  if [ "$resume" = "y" ]; then
    # 从最后的提交位置恢复
    last_commit=$(git log --oneline -1 --pretty=format:"%s")
    echo "最后的提交: $last_commit"
  else
    # 完全重置
    git reset HEAD
    echo "处理已重置"
  fi
}
```

#### 4. 完成后的验证

```bash
# 确认所有变更都已提交
remaining_changes=$(git status --porcelain | wc -l)
if [ $remaining_changes -eq 0 ]; then
  echo "✅ 所有变更都已提交"
else
  echo "⚠️  还有未提交的变更:"
  git status --short
fi

# 显示提交历史
echo "创建的提交:"
git log --oneline -n 10 --graph
```

#### 5. 抑制自动推送

```bash
# 注意: 不执行自动推送
echo "📝 注意: 不会自动推送"
echo "如需推送请执行以下命令:"
echo "  git push origin $CURRENT_BRANCH"
```

### 拆分算法的详细说明

#### 步骤 1: 初始分析

```bash
# 获取所有变更文件并分类
git diff HEAD --name-status | while read status file; do
  echo "$status:$file"
done > /tmp/changes.txt

# 按功能目录统计变更
git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq -c
```

#### 步骤 2: 基于功能边界的初始分组

```bash
# 基于目录的分组
GROUPS=$(git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq)
for group in $GROUPS; do
  echo "=== 组别: $group ==="
  git diff HEAD --name-only | grep "^$group" | head -10
done
```

#### 步骤 3: 变更内容相似性分析

```bash
# 分析各文件的变更类型
git diff HEAD --name-only | while read file; do
  # 检测新函数/类的添加
  NEW_FUNCTIONS=$(git diff HEAD -- "$file" | grep -c '^+.*function\|^+.*class\|^+.*def ')

  # 检测 Bug 修复模式
  BUG_FIXES=$(git diff HEAD -- "$file" | grep -c '^+.*fix\|^+.*bug\|^-.*error')

  # 判断是否为测试文件
  if [[ "$file" =~ test|spec ]]; then
    echo "$file: TEST"
  elif [ $NEW_FUNCTIONS -gt 0 ]; then
    echo "$file: FEAT"
  elif [ $BUG_FIXES -gt 0 ]; then
    echo "$file: FIX"
  else
    echo "$file: REFACTOR"
  fi
done
```

#### 步骤 4: 基于依赖关系的调整

```bash
# 分析导入关系
git diff HEAD | grep -E '^[+-].*import|^[+-].*from.*import' | \
while read line; do
  echo "$line" | sed 's/^[+-]//' | awk '{print $2}'
done | sort | uniq > /tmp/imports.txt

# 相关文件的分组
git diff HEAD --name-only | while read file; do
  basename=$(basename "$file" .js .ts .py)
  related=$(git diff HEAD --name-only | grep "$basename" | grep -v "^$file$")
  if [ -n "$related" ]; then
    echo "相关文件组: $file <-> $related"
  fi
done
```

#### 步骤 5: 提交大小优化

```bash
# 调整组别大小
MAX_FILES_PER_COMMIT=8
current_group=1
file_count=0

git diff HEAD --name-only | while read file; do
  if [ $file_count -ge $MAX_FILES_PER_COMMIT ]; then
    current_group=$((current_group + 1))
    file_count=0
  fi
  echo "提交 $current_group: $file"
  file_count=$((file_count + 1))
done
```

#### 步骤 6: 最终分组确定

```bash
# 验证拆分结果
for group in $(seq 1 $current_group); do
  files=$(grep "提交 $group:" /tmp/commit_plan.txt | cut -d':' -f2-)
  lines=$(echo "$files" | xargs git diff HEAD -- | wc -l)
  echo "提交 $group: $(echo "$files" | wc -w) 个文件, $lines 行变更"
done
```

## Conventional Commits 规范

### 基本格式

```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### 标准类型

**必需类型**:

- `feat`: 新功能 (用户可见的功能添加)
- `fix`: Bug 修复

**可选类型**:

- `build`: 构建系统或外部依赖的变更
- `chore`: 其他变更 (不影响发布)
- `ci`: CI 配置文件和脚本的变更
- `docs`: 仅文档变更
- `style`: 不影响代码含义的变更 (空白、格式、分号等)
- `refactor`: 既不修复 Bug 也不添加功能的代码变更
- `perf`: 性能改进
- `test`: 添加或修正测试

### 作用域 (可选)

表示变更的影响范围：

```text
feat(api): 添加用户认证端点
fix(ui): 解决按钮对齐问题
docs(readme): 更新安装说明
```

### Breaking Change

有 API 破坏性变更时：

```text
feat!: 更改用户 API 响应格式

BREAKING CHANGE: 用户响应现在包含额外的元数据
```

或

```text
feat(api)!: 更改认证流程
```

### 项目规约的自动检测

**重要**: 如果存在项目特有的规约，优先使用。

#### 1. CommitLint 配置确认

自动检测以下文件的配置：

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
# 确认配置文件示例
cat commitlint.config.mjs
cat .commitlintrc.json
grep -A 10 '"commitlint"' package.json
```

#### 2. 自定义类型检测

项目特有类型的示例：

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
        "config", // 配置变更
      ],
    ],
  },
};
```

#### 3. 语言设置检测

```javascript
// 项目使用中文消息时
export default {
  rules: {
    "subject-case": [0], // 为支持中文而禁用
    "subject-max-length": [2, "always", 72], // 中文调整字符数限制
  },
};
```

### 自动分析流程

1. **搜索配置文件**

   ```bash
   find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
   ```

2. **分析现有提交**

   ```bash
   git log --oneline -50 --pretty=format:"%s"
   ```

3. **使用类型统计**

   ```bash
   git log --oneline -100 --pretty=format:"%s" | \
   grep -oE '^[a-z]+(\([^)]+\))?' | \
   sort | uniq -c | sort -nr
   ```

### 项目规约示例

#### Angular 风格

```text
feat(scope): 添加新功能
fix(scope): 修复 Bug
docs(scope): 更新文档
```

#### Gitmoji 结合风格

```text
✨ feat: 添加用户注册
🐛 fix: 解决登录问题
📚 docs: 更新 API 文档
```

#### 中文项目

```text
feat: 新增用户注册功能
fix: 修复登录处理的 Bug
docs: 更新 API 文档
```

## 语言判定

此命令完整的语言判定逻辑：

1. **从 CommitLint 配置**确认语言设置

   ```bash
   # subject-case 规则被禁用时判定为中文
   grep -E '"subject-case".*\[0\]|subject-case.*0' commitlint.config.*
   ```

2. **通过 git log 分析**自动判定

   ```bash
   # 分析最近 20 个提交的语言
   git log --oneline -20 --pretty=format:"%s" | \
   grep -E '[一-龥]|添加|修复|更新|删除|实现|优化|重构|测试|文档' | wc -l
   # 50% 以上包含中文字符或中文技术词汇则使用中文模式
   ```

3. **项目文件**的语言设置

   ```bash
   # 确认 README.md 的语言
   head -10 README.md | grep -E '[一-龥]' | wc -l

   # 确认 package.json 的 description
   grep -E '"description".*[一-龥]' package.json
   ```

4. **变更文件内**的注释·字符串分析

   ```bash
   # 确认变更文件的注释语言
   git diff HEAD | grep -E '^[+-].*//.*[一-龥]|^[+-].*//.*添加|^[+-].*//.*修复|^[+-].*//.*更新' | wc -l
   ```

### 判定算法

```bash
# 语言判定分数计算
CHINESE_SCORE=0

# 1. CommitLint 配置 (+3 分)
if grep -q '"subject-case".*\[0\]' commitlint.config.* 2>/dev/null; then
  CHINESE_SCORE=$((CHINESE_SCORE + 3))
fi

# 2. git log 分析 (最大 +2 分)
CHINESE_COMMITS=$(git log --oneline -20 --pretty=format:"%s" | \
  grep -cE '[一-龥]|添加|修复|更新|删除|实现|优化|重构|测试|文档' 2>/dev/null || echo 0)
if [ $CHINESE_COMMITS -gt 10 ]; then
  CHINESE_SCORE=$((CHINESE_SCORE + 2))
elif [ $CHINESE_COMMITS -gt 5 ]; then
  CHINESE_SCORE=$((CHINESE_SCORE + 1))
fi

# 3. README.md 确认 (+1 分)
if head -5 README.md 2>/dev/null | grep -qE '[一-龥]'; then
  CHINESE_SCORE=$((CHINESE_SCORE + 1))
fi

# 4. 变更文件内容确认 (+1 分)
if git diff HEAD 2>/dev/null | grep -qE '^[+-].*[一-龥]|^[+-].*添加|^[+-].*修复|^[+-].*更新'; then
  CHINESE_SCORE=$((CHINESE_SCORE + 1))
fi

# 判定: 3 分以上为中文模式
if [ $CHINESE_SCORE -ge 3 ]; then
  LANGUAGE="zh"
else
  LANGUAGE="en"
fi
```

## 设置文件自动加载

### 执行时的动作

命令执行时按以下顺序确认设置：

1. **搜索 CommitLint 配置文件**

   ```bash
   # 按以下顺序搜索，使用找到的第一个文件
   commitlint.config.mjs
   commitlint.config.js
   commitlint.config.cjs
   commitlint.config.ts
   .commitlintrc.js
   .commitlintrc.json
   .commitlintrc.yml
   .commitlintrc.yaml
   package.json (commitlint 部分)
   ```

2. **解析配置内容**
   - 提取可用类型列表
   - 确认是否有作用域限制
   - 获取消息长度限制
   - 确认语言设置

3. **分析现有提交历史**

   ```bash
   # 从最近的提交学习使用模式
   git log --oneline -100 --pretty=format:"%s" | \
   head -20
   ```

### 配置示例分析

**标准 commitlint.config.mjs**:

```javascript
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      ["feat", "fix", "docs", "style", "refactor", "perf", "test", "chore"],
    ],
    "scope-enum": [2, "always", ["api", "ui", "core", "auth", "db"]],
  },
};
```

**中文对应配置**:

```javascript
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "subject-case": [0], // 为中文禁用
    "subject-max-length": [2, "always", 72],
    "type-enum": [
      2,
      "always",
      ["feat", "fix", "docs", "style", "refactor", "test", "chore"],
    ],
  },
};
```

**包含自定义类型的配置**:

```javascript
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
        "wip", // Work in Progress
        "hotfix", // 紧急修复
        "release", // 发布准备
        "deps", // 依赖更新
        "config", // 配置变更
      ],
    ],
  },
};
```

### 后备行为

找不到配置文件时：

1. **基于 git log 分析**的自动推测

   ```bash
   # 从最近 100 个提交中提取类型
   git log --oneline -100 --pretty=format:"%s" | \
   grep -oE '^[a-z]+(\([^)]+\))?' | \
   sort | uniq -c | sort -nr
   ```

2. **使用 Conventional Commits 标准**作为默认

   ```
   feat, fix, docs, style, refactor, perf, test, chore, build, ci
   ```

3. **语言判定**
   - 中文提交 50% 以上 → 中文模式
   - 其他 → 英文模式

## 先决条件

- 在 Git 仓库内执行
- 存在未提交的变更
- 已暂存的变更会被重置

## 注意事项

- **无自动推送**: 提交后的 `git push` 需手动执行
- **不创建分支**: 在当前分支提交
- **建议备份**: 重要变更前使用 `git stash` 备份

## 项目规约的优先级

生成提交消息时的优先级：

1. **CommitLint 配置** (最优先)
   - `commitlint.config.*` 文件的设置
   - 自定义类型和作用域限制
   - 消息长度和大小写限制

2. **现有提交历史** (第 2 优先)
   - 实际使用的类型统计
   - 消息语言 (中文/英文)
   - 作用域使用模式

3. **项目类型** (第 3 优先)
   - `package.json` → Node.js 项目
   - `Cargo.toml` → Rust 项目
   - `pom.xml` → Java 项目

4. **Conventional Commits 标准** (后备)
   - 未找到配置时的标准行为

### 规约检测实例

**Monorepo 的 scope 自动检测**:

```bash
# 从 packages/ 文件夹推测 scope
ls packages/ | head -10
# → api, ui, core, auth 等作为 scope 建议
```

**框架特定规约**:

```javascript
// Angular 项目情况
{
  'scope-enum': [2, 'always', [
    'animations', 'common', 'core', 'forms', 'http', 'platform-browser',
    'platform-server', 'router', 'service-worker', 'upgrade'
  ]]
}

// React 项目情况
{
  'scope-enum': [2, 'always', [
    'components', 'hooks', 'utils', 'types', 'styles', 'api'
  ]]
}
```

**企业·团队特有规约**:

```javascript
// 中国企业常见模式
{
  'type-enum': [2, 'always', [
    'feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore',
    'wip',      // 进行中 (Pull Request 用)
    'hotfix',   // 紧急修复
    'release'   // 发布准备
  ]],
  'subject-case': [0],  // 中文对应
  'subject-max-length': [2, 'always', 72]  // 中文设置较长
}
```

## 最佳实践

1. **尊重项目规约**: 遵循现有的设置和模式
2. **小变更单位**: 1 个提交 = 1 个逻辑变更
3. **清晰的消息**: 明确说明变更内容
4. **重视关联性**: 将功能相关的文件分组
5. **分离测试**: 测试文件单独提交
6. **利用配置文件**: 引入 CommitLint 统一团队规约

## 实际拆分示例 (Before/After)

### 示例 1: 大规模认证系统添加

**Before(1 个巨大提交):**

```bash
# 变更文件 (15 个文件，850 行变更)
src/auth/login.js          # 新建
src/auth/register.js       # 新建
src/auth/password.js       # 新建
src/auth/types.js          # 新建
src/api/auth-routes.js     # 新建
src/middleware/auth.js     # 新建
src/database/migrations/001_users.sql  # 新建
src/database/models/user.js            # 新建
tests/auth/login.test.js   # 新建
tests/auth/register.test.js # 新建
tests/api/auth-routes.test.js # 新建
docs/authentication.md    # 新建
package.json              # 依赖添加
README.md                 # 使用方法添加
.env.example             # 环境变量示例添加

# 传统的问题提交
feat: 实现完整的用户认证系统，包含登录、注册、密码重置、API 路由、数据库模型、测试和文档
```

**After(拆分为有意义的 5 个提交):**

```bash
# 提交 1: 数据库基础
feat(db): 添加用户模型和认证架构

包含文件:
- src/database/migrations/001_users.sql
- src/database/models/user.js
- src/auth/types.js

理由: 数据库结构是其他功能的基础，因此最先提交

# 提交 2: 认证逻辑
feat(auth): 实现核心认证功能

包含文件:
- src/auth/login.js
- src/auth/register.js
- src/auth/password.js
- src/middleware/auth.js

理由: 认证的核心业务逻辑批量提交

# 提交 3: API 端点
feat(api): 添加认证 API 路由

包含文件:
- src/api/auth-routes.js

理由: API 层依赖认证逻辑，因此后提交

# 提交 4: 全面测试
test(auth): 添加认证系统的全面测试

包含文件:
- tests/auth/login.test.js
- tests/auth/register.test.js
- tests/api/auth-routes.test.js

理由: 实现完成后批量添加测试

# 提交 5: 配置和文档
docs(auth): 添加认证文档和配置

包含文件:
- docs/authentication.md
- package.json
- README.md
- .env.example

理由: 文档和配置最后汇总提交
```

### 示例 2: Bug 修复和重构混合

**Before(混合的问题提交):**

```bash
# 变更文件 (8 个文件，320 行变更)
src/user/service.js       # Bug 修复 + 重构
src/user/validator.js     # 新建 (重构)
src/auth/middleware.js    # Bug 修复
src/api/user-routes.js    # Bug 修复 + 错误处理改进
tests/user.test.js        # 测试添加
tests/auth.test.js        # Bug 修复测试添加
docs/user-api.md          # 文档更新
package.json              # 依赖更新

# 问题提交
fix: 解决用户验证 Bug 并重构验证逻辑，改进错误处理
```

**After(按类型拆分为 3 个提交):**

```bash
# 提交 1: 紧急 Bug 修复
fix: 解决用户验证和认证 Bug

包含文件:
- src/user/service.js(仅 Bug 修复部分)
- src/auth/middleware.js
- tests/auth.test.js(仅 Bug 修复测试)

理由: 影响生产环境的 Bug 最优先修复

# 提交 2: 验证逻辑重构
refactor: 提取并改进用户验证逻辑

包含文件:
- src/user/service.js(重构部分)
- src/user/validator.js
- src/api/user-routes.js
- tests/user.test.js

理由: 结构改进按功能单位汇总提交

# 提交 3: 文档和依赖更新
chore: 更新文档和依赖

包含文件:
- docs/user-api.md
- package.json

理由: 开发环境整备最后汇总提交
```

### 示例 3: 多功能并行开发

**Before(跨功能的巨大提交):**

```bash
# 变更文件 (12 个文件，600 行变更)
src/user/profile.js       # 新功能 A
src/user/avatar.js        # 新功能 A
src/notification/email.js # 新功能 B
src/notification/sms.js   # 新功能 B
src/api/profile-routes.js # 新功能 A 用 API
src/api/notification-routes.js # 新功能 B 用 API
src/dashboard/widgets.js  # 新功能 C
src/dashboard/charts.js   # 新功能 C
tests/profile.test.js     # 新功能 A 用测试
tests/notification.test.js # 新功能 B 用测试
tests/dashboard.test.js   # 新功能 C 用测试
package.json              # 全功能依赖

# 问题提交
feat: 添加用户档案管理、通知系统和仪表板组件
```

**After(按功能拆分为 4 个提交):**

```bash
# 提交 1: 用户档案功能
feat(profile): 添加用户档案管理

包含文件:
- src/user/profile.js
- src/user/avatar.js
- src/api/profile-routes.js
- tests/profile.test.js

理由: 档案功能是独立的功能单位

# 提交 2: 通知系统
feat(notification): 实现邮件和短信通知

包含文件:
- src/notification/email.js
- src/notification/sms.js
- src/api/notification-routes.js
- tests/notification.test.js

理由: 通知功能是独立的功能单位

# 提交 3: 仪表板组件
feat(dashboard): 添加交互式组件和图表

包含文件:
- src/dashboard/widgets.js
- src/dashboard/charts.js
- tests/dashboard.test.js

理由: 仪表板功能是独立的功能单位

# 提交 4: 依赖和基础设施更新
chore: 为新功能更新依赖

包含文件:
- package.json

理由: 通用依赖更新最后汇总
```

## 拆分效果比较

| 项目           | Before(巨大提交)    | After(适当拆分)     |
| -------------- | ------------------- | ------------------- |
| **代码审查性** | ❌ 非常困难         | ✅ 各提交小巧易审查 |
| **Bug 追踪**   | ❌ 问题位置难以确定 | ✅ 即时定位问题提交 |
| **回滚**       | ❌ 必须整体回滚     | ✅ 精准回滚问题部分 |
| **并行开发**   | ❌ 容易发生冲突     | ✅ 按功能合并容易   |
| **部署**       | ❌ 功能批量部署     | ✅ 可逐步部署       |

## 故障排除

### 提交失败时

- 确认预提交钩子
- 解决依赖关系
- 逐个文件重试

### 拆分不当时

- 用 `--max-commits` 选项调整
- 使用手动 `edit` 模式
- 以更小单位重新执行
