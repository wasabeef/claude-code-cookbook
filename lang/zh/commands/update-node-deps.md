## Node依赖更新

安全更新Node.js项目的依赖关系。

### 使用方法

```bash
# 检查依赖状态并请求Claude帮助
npm outdated
「请将package.json的依赖关系更新到最新版本」
```

### 基本示例

```bash
# 检查当前依赖
cat package.json
「请分析这个Node.js项目的依赖关系，并告诉我哪些包可以更新」

# 检查可更新列表
npm outdated
「请分析这些包更新的风险程度」
```

### 与Claude协作

```bash
# 全面依赖更新
cat package.json
「请分析Node.js依赖，并执行以下操作：
1. 研究每个包的最新版本
2. 确认是否有破坏性变更
3. 评估风险程度（安全・注意・危险）
4. 建议必要的代码变更
5. 生成更新后的package.json」

# 安全的逐步更新
npm outdated
「请避开主版本升级，只更新安全的包」

# 特定包的更新影响分析
「请告诉我将express更新到最新版本的影响和必要的变更」
```

### 详细示例

```bash
# 包含发布说明的详细分析
cat package.json && npm outdated
「请分析依赖，并为每个包提供：
1. 当前 → 最新版本
2. 风险评估（安全・注意・危险）
3. 主要变更（来自CHANGELOG）
4. 必要的代码修正
请以表格形式呈现」

# 考虑TypeScript项目的类型定义
cat package.json tsconfig.json
「请更新依赖，包括TypeScript类型定义，并制定不会产生类型错误的更新计划」
```

### 风险程度标准

```
安全（🟢）：
- 补丁版本升级（1.2.3 → 1.2.4）
- 仅包含bug修复
- 保证向后兼容性

注意（🟡）：
- 次版本升级（1.2.3 → 1.3.0）
- 添加新功能
- 包含弃用警告

危险（🔴）：
- 主版本升级（1.2.3 → 2.0.0）
- 破坏性变更
- API删除或更改
```

### 执行更新

```bash
# 创建备份
cp package.json package.json.backup
cp package-lock.json package-lock.json.backup

# 执行更新
npm update

# 更新后检查
npm test
npm run build
npm audit
```

### 注意事项

更新后务必进行功能测试。如果出现问题，请使用以下命令恢复：

```bash
cp package.json.backup package.json
cp package-lock.json.backup package-lock.json
npm install
```