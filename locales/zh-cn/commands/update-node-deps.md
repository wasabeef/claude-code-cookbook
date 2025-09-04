## Node 依赖更新

安全地更新 Node.js 项目的依赖关系。

### 使用方法

```bash
# 确认依赖状态并请求 Claude
npm outdated
「将 package.json 的依赖更新到最新版本」
```

### 基本示例

```bash
# 确认当前依赖
cat package.json
「分析这个 Node.js 项目的依赖并告诉我可更新的包」

# 确认可更新列表
npm outdated
「分析这些包更新的危险度」
```

### 与 Claude 配合

```bash
# 全面的依赖更新
cat package.json
「分析 Node.js 的依赖并执行以下操作：
1. 调查各包的最新版本
2. 确认是否有破坏性变更
3. 评估危险度(安全・注意・危险)
4. 提出必要的代码更改
5. 生成更新版 package.json」

# 安全的分阶段更新
npm outdated
「避免主版本升级，只更新可以安全升级的包」

# 特定包的更新影响分析
「告诉我将 express 更新到最新版本的影响和必要的更改」
```

### 详细示例

```bash
# 包含 Release Notes 的详细分析
cat package.json && npm outdated
「分析依赖，为每个包提供：
1. 当前 → 最新版本
2. 危险度评估(安全・注意・危险)
3. 主要变更(来自 CHANGELOG)
4. 必要的代码修改
以表格形式展示」

# TypeScript 项目的类型定义考虑
cat package.json tsconfig.json
「包括 TypeScript 的类型定义更新依赖，制定不会产生类型错误的更新计划」
```

### 危险度标准

```
安全(🟢)：
- 补丁版本升级(1.2.3 → 1.2.4)
- 仅修复 bug
- 保证向后兼容

注意(🟡)：
- 次版本升级(1.2.3 → 1.3.0)
- 新增功能
- 有弃用警告

危险(🔴)：
- 主版本升级(1.2.3 → 2.0.0)
- 破坏性变更
- API 的删除或更改
```

### 执行更新

```bash
# 创建备份
cp package.json package.json.backup
cp package-lock.json package-lock.json.backup

# 执行更新
npm update

# 更新后确认
npm test
npm run build
npm audit
```

### 注意事项

更新后必须进行功能测试。如果出现问题，使用以下命令恢复：

```bash
cp package.json.backup package.json
cp package-lock.json.backup package-lock.json
npm install
```
