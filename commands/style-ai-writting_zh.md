## AI写作检查

检测AI生成文本中的机械模式，并提供改进为更自然中文的建议。

### 使用方法

```bash
/ai-writing-check [选项]
```

### 选项

- 无 : 分析当前文件或选中的文本
- `--file <path>` : 分析特定文件
- `--dir <path>` : 批量分析目录内的文件
- `--severity <level>` : 检测级别（all/high/medium）
- `--fix` : 自动修正检测到的模式

### 基本示例

```bash
# 检查文件的AI痕迹
cat README.md
/ai-writing-check
「检查这篇文档的AI痕迹并提供改进方案」

# 分析特定文件
/ai-writing-check --file docs/guide.md
「检测AI式表达并提出自然表达的修正建议」

# 扫描整个项目
/ai-writing-check --dir . --severity high
「仅报告项目内重要的AI痕迹问题」
```

### 检测模式

#### 1. 列表格式的机械模式

```markdown
检测示例:

- **重要**: 这是重要项目
- 已完成项目（带对勾）
- 热门话题（带火焰 emoji）
- 准备就绪（带火箭 emoji）

改进示例:

- 重要项目: 这是重要项目
- 已完成项目
- 热门话题
- 准备就绪
```

#### 2. 夸张或 hype 表达

```markdown
检测示例:
革命性技术将改变行业。
这将完全解决问题。
它会像魔法一样工作。

改进示例:
有效的技术将为行业带来变化。
它将解决许多问题。
它运行流畅。
```

#### 3. 机械的强调模式

```markdown
检测示例:
**想法**: 有新提案（带灯泡 emoji）
**注意**: 重要警告（带警告 emoji）

改进示例:
想法: 有新提案
注意事项: 重要警告
```

#### 4. 冗余的技术写作

```markdown
检测示例:
首先，我们需要进行初始设置。
您可以使用此工具。
性能将大幅提升。

改进示例:
首先进行设置。
您可以使用此工具。
性能提升 30%。
```

### 与Claude的协作

```bash
# 分析整篇文档的AI痕迹
cat article.md
/ai-writing-check
「从以下角度分析并提供改进方案：
1. 检测机械表达
2. 提出自然中文的修正建议
3. 按优先级排列的改进列表」

# 聚焦特定模式
/ai-writing-check --file blog.md
「特别关注夸张表达和冗余表达并提供改进建议」

# 批量检查多个文件
find . -name "*.md" -type f
/ai-writing-check --dir docs/
「分析整个文档的AI痕迹并创建摘要」
```

### 详细示例

```bash
# 改进前后对比
/ai-writing-check --file draft.md
「检测AI痕迹表达，并按以下格式呈现：
- 问题位置（带行号）
- 问题类型和原因
- 具体改进方案
- 改进效果」

# 自动修正模式
/ai-writing-check --file report.md --fix
「自动修正检测到的模式并报告结果」

# 项目AI痕迹报告
/ai-writing-check --dir . --severity all
「分析整个项目的AI痕迹：
1. 统计信息（按模式分类的检测数量）
2. 问题最严重的前5个文件
3. 改进优先级矩阵
4. 阶段性改进计划」
```

### 高级使用示例

```bash
# 应用自定义规则
/ai-writing-check --file spec.md
「作为技术规范，按以下附加标准检查：
- 模糊表达（适当的、必要时）
- 缺乏具体性（快速 → 具体数值）
- 术语使用不一致」

# 用于CI/CD集成的检查
/ai-writing-check --dir docs/ --severity high
「以GitHub Actions可执行的格式输出结果：
- 错误数量和文件名
- 需要修正的行号
- 设置退出码」

# 符合风格指南的检查
/ai-writing-check --file manual.md
「根据公司风格指南进行附加检查：
- 敬语使用（统一使用礼貌用语）
- 专业术语的正确使用
- 考虑读者体验」
```

### 注意事项

- AI痕迹的判定因上下文而异，建议将提案作为参考
- 会根据文档类型（技术文档、博客、手册等）调整标准
- 不必接受所有建议，选择合适的进行采纳
- `--fix`选项会自动修正检测到的模式

### 命令执行时的操作

执行`/ai-writing-check`命令时，Claude将执行以下处理：

1. **模式检测**: 从指定文件或文本中检测AI痕迹模式
2. **具体修正建议**: 为每个问题提供带行号的修正方案
3. **--fix模式**: 自动修正检测到的模式，并显示结果摘要
4. **报告生成**: 提供检测数量、改进优先级、修正前后对比

Claude会读取实际文件内容，并基于textlint-rule-preset-ai-writing规则进行分析。

### 参考

此命令参考了[textlint-rule-preset-ai-writing](https://github.com/textlint-ja/textlint-rule-preset-ai-writing)规则集。这是一个用于检测AI生成文本中的机械模式并促进更自然表达的textlint规则预设。
```