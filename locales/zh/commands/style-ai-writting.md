## AI 写作检查

检测 AI 生成文本的机械化模式，并提供更自然的中文改进建议。

### 使用方法

```bash
/ai-writing-check [选项]
```

### 选项

- 无参数 : 分析当前文件或选中的文本
- `--file <path>` : 分析特定文件
- `--dir <path>` : 批量分析目录内的文件
- `--severity <level>` : 检测级别（all/high/medium）
- `--fix` : 自动修复检测到的模式

### 基本示例

```bash
# 检查文件的 AI 痕迹
cat README.md
/ai-writing-check
「检查这个文档的 AI 痕迹并提供改进方案」

# 分析特定文件
/ai-writing-check --file docs/guide.md
「检测 AI 风格的表达并建议自然的表达方式」

# 扫描整个项目
/ai-writing-check --dir . --severity high
「只报告项目中重要的 AI 痕迹问题」
```

### 检测模式

#### 1. 列表格式的机械化模式

```markdown
检测示例：

- **重要**: 这是重要的项目
- 已完成的项目（带勾选标记）
- 热门话题（带火焰表情）
- 准备启动（带火箭表情）

改进示例：

- 重要项目：这是重要的项目
- 已完成的项目
- 热门话题
- 准备启动
```

#### 2. 夸张和炒作表达

```markdown
检测示例：
革命性的技术将改变行业。
这完全解决了问题。
像魔法一样运行。

改进示例：
有效的技术将为行业带来变化。
解决了许多问题。
运行流畅。
```

#### 3. 机械化的强调模式

```markdown
检测示例：
**想法**: 有新的提议（带灯泡表情）
**注意**: 重要警告事项（带警告表情）

改进示例：
想法：有新的提议
注意事项：重要警告事项
```

#### 4. 冗余的技术写作

```markdown
检测示例：
首先先进行设置。
可以使用这个工具。
大幅提升性能。

改进示例：
首先进行设置。
可以使用这个工具。
性能提升 30%。
```

### 与 Claude 配合

```bash
# 文档整体的 AI 痕迹分析
cat article.md
/ai-writing-check
「从以下角度分析并提供改进方案：
1. 机械化表达的检测
2. 自然中文的修改建议
3. 按优先级排列的改进列表」

# 聚焦特定模式
/ai-writing-check --file blog.md
「特别关注夸张表达和冗余表达并提供改进建议」

# 批量检查多个文件
find . -name "*.md" -type f
/ai-writing-check --dir docs/
「分析整个文档的 AI 痕迹并创建摘要」
```

### 详细示例

```bash
# 改进前后对比
/ai-writing-check --file draft.md
「检测 AI 风格的表达，按以下格式展示：
- 问题位置（带行号）
- 问题类型和原因
- 具体改进方案
- 改进效果」

# 自动修复模式
/ai-writing-check --file report.md --fix
「自动修复检测到的模式并报告结果」

# 项目 AI 痕迹报告
/ai-writing-check --dir . --severity all
「分析整个项目的 AI 痕迹：
1. 统计信息（按模式分类的检测数）
2. 问题最多的文件 TOP 5
3. 改进优先级矩阵
4. 分阶段改进计划」
```

### 高级用法

```bash
# 应用自定义规则
/ai-writing-check --file spec.md
「作为技术规格书，使用以下额外标准检查：
- 模糊表达（适当的、根据需要）
- 缺乏具体性（高速 → 具体数值）
- 术语使用不一致」

# CI/CD 集成检查
/ai-writing-check --dir docs/ --severity high
「以可在 GitHub Actions 执行的格式输出结果：
- 错误数和文件名
- 需要修复的行号
- exit code 设置」

# 风格指南合规检查
/ai-writing-check --file manual.md
「基于公司风格指南进行额外检查：
- 敬语使用（统一礼貌用语）
- 专业术语的适当使用
- 对读者的考虑」
```

### 注意事项

- AI 痕迹的判定因上下文而异，建议仅作参考
- 根据文档类型（技术文档、博客、手册等）调整标准
- 不必接受所有建议，选择合适的即可
- `--fix` 选项会自动修复检测到的模式

### 命令执行时的行为

执行 `/ai-writing-check` 命令时，Claude 会进行以下处理：

1. **模式检测**: 从指定的文件或文本中检测 AI 风格的模式
2. **具体修改建议**: 为每个问题提供带行号的修改方案
3. **--fix 模式**: 自动修复检测到的模式，并显示结果摘要
4. **报告生成**: 提供检测数、改进优先级、修改前后对比

Claude 会读取实际文件内容，基于 textlint-rule-preset-ai-writing 的规则进行分析。

### 参考

此命令参考了 [textlint-rule-preset-ai-writing](https://github.com/textlint-ja/textlint-rule-preset-ai-writing) 的规则集创建。这是一个 textlint 规则预设，用于检测 AI 生成文本的机械化模式，促进更自然的表达。
