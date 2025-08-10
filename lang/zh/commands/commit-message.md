## 提交消息

从已暂存的更改（git diff --staged）生成适当的提交消息。不会执行git命令，仅生成消息并复制到剪贴板。

### 使用方法

```bash
/commit-message [选项]
```

### 选项

- `--format <格式>`: 指定消息格式（conventional, gitmoji, angular）
- `--lang <语言>`: 强制指定消息语言（en, zh）
- `--breaking`: 检测并记录Breaking Change

### 基本示例

```bash
# 从暂存的更改生成消息（自动判断语言）
# 主候选会自动复制到剪贴板
/commit-message

# 强制指定语言
/commit-message --lang zh
/commit-message --lang en

# 检测Breaking Change
/commit-message --breaking
```

### 前提条件

**重要**: 此命令仅分析已暂存的更改。需要事先使用`git add`将更改暂存。

```bash
# 没有暂存更改时会显示警告
$ /commit-message
没有暂存的更改。请先执行git add。
```

### 自动剪贴板功能

生成的主候选会以`git commit -m "消息"`的完整形式自动复制到剪贴板。可以直接在终端粘贴执行。

**实现注意事项**:

- 将提交命令传递给`pbcopy`时，请在消息输出之外的进程中执行
- 使用`printf`代替`echo`以避免末尾换行

### 项目规范的自动检测

**重要**: 如果项目有自己的规范，则优先使用这些规范。

#### 1. 确认CommitLint配置

从以下文件自动检测配置：

- `commitlint.config.js`
- `commitlint.config.mjs`
- `commitlint.config.cjs`
- `commitlint.config.ts`
- `.commitlintrc.js`
- `.commitlintrc.json`
- `.commitlintrc.yml`
- `.commitlintrc.yaml`
- `package.json`中的`commitlint`部分

```bash
# 搜索配置文件
find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
```

#### 2. 检测自定义类型

项目自定义类型示例：

```javascript
// commitlint.config.mjs
export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore',
        'wip',      // 进行中
        'hotfix',   // 紧急修复
        'release',  // 发布
        'deps',     // 依赖更新
        'config'    // 配置更改
      ]
    ]
  }
}
```

#### 3. 检测语言设置

```javascript
// 项目使用中文消息时
export default {
  rules: {
    'subject-case': [0],  // 为支持中文而禁用
    'subject-max-length': [2, 'always', 72]  // 中文调整字符限制
  }
}
```

#### 4. 分析现有提交历史

```bash
# 从最近的提交学习使用模式
git log --oneline -50 --pretty=format:"%s"

# 使用类型统计
git log --oneline -100 --pretty=format: