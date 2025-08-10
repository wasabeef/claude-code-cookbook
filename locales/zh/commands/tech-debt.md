## 技术债务

分析项目的技术债务，创建按优先级排序的改进计划。

### 使用方法

```bash
# 确认项目结构并分析技术债务
ls -la
「分析这个项目的技术债务并创建改进计划」
```

### 基本示例

```bash
# 分析 TODO/FIXME 注释
grep -r "TODO\|FIXME\|HACK\|XXX\|WORKAROUND" . --exclude-dir=node_modules --exclude-dir=.git
「按优先级整理这些 TODO 注释并制定改进计划」

# 确认项目依赖关系
ls -la | grep -E "package.json|Cargo.toml|pubspec.yaml|go.mod|requirements.txt"
「分析项目的依赖关系，识别过时的依赖和风险」

# 检测大文件和复杂函数
find . -type f -not -path "*/\.*" -not -path "*/node_modules/*" -exec wc -l {} + | sort -rn | head -10
「识别过大的文件和复杂的结构，提出改进方案」
```

### 与 Claude 配合

```bash
# 全面的技术债务分析
ls -la && find . -name "*.md" -maxdepth 2 -exec head -20 {} \;
「从以下角度分析这个项目的技术债务：
1. 代码质量（复杂度、重复、可维护性）
2. 依赖关系健康度
3. 安全风险
4. 性能问题
5. 测试覆盖不足」

# 架构债务分析
find . -type d -name "src" -o -name "lib" -o -name "app" | head -10 | xargs ls -la
「识别架构层面的技术债务，提出重构计划」

# 按优先级排序的改进计划
「按以下标准评估技术债务并以表格形式展示：
- 影响度（高/中/低）
- 修复成本（时间）
- 业务风险
- 改进效果
- 推荐实施时期」
```

### 详细示例

```bash
# 自动检测项目类型并分析
find . -maxdepth 2 -type f \( -name "package.json" -o -name "Cargo.toml" -o -name "pubspec.yaml" -o -name "go.mod" -o -name "pom.xml" \)
「基于检测到的项目类型，分析以下内容：
1. 语言和框架特定的技术债务
2. 偏离最佳实践的情况
3. 现代化机会
4. 分阶段改进策略」

# 代码质量指标分析
find . -type f -name "*" | grep -E "\.(js|ts|py|rs|go|dart|kotlin|swift|java)$" | wc -l
「分析项目的代码质量，展示以下指标：
- 循环复杂度高的函数
- 重复代码检测
- 过长的文件/函数
- 缺乏适当的错误处理」

# 安全债务检测
grep -r "password\|secret\|key\|token" . --exclude-dir=.git --exclude-dir=node_modules | grep -v ".env.example"
「检测安全相关的技术债务，提出修复优先级和对策」

# 测试不足分析
find . -type f \( -name "*test*" -o -name "*spec*" \) | wc -l && find . -type f -name "*.md" | xargs grep -l "test"
「分析测试覆盖的技术债务，提出测试策略」
```

### 注意事项

- 自动检测项目的语言和框架，进行相应的分析
- 技术债务分为「需要立即修复的重要问题」和「长期改进项目」
- 提供考虑业务价值和技术改进平衡的现实计划
- 也考虑改进的 ROI（投资回报率）
