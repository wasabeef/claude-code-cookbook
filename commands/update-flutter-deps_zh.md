## Flutter依赖更新

安全更新Flutter项目的依赖关系。

### 使用方法

```bash
# 检查依赖状态并请求Claude帮助
flutter pub deps --style=compact
「请将pubspec.yaml的依赖关系更新到最新版本」
```

### 基本示例

```bash
# 检查当前依赖
cat pubspec.yaml
「请分析这个Flutter项目的依赖关系，并告诉我哪些包可以更新」

# 更新前预览
flutter pub upgrade --dry-run
「请从这个更新计划中确认是否有破坏性变更」
```

### 与Claude协作

```bash
# 全面依赖更新
cat pubspec.yaml
「请分析Flutter依赖，并执行以下操作：
1. 研究每个包的最新版本
2. 确认是否有破坏性变更
3. 评估风险程度（安全・注意・危险）
4. 建议必要的代码变更
5. 生成更新后的pubspec.yaml」

# 安全的逐步更新
flutter pub outdated
「请避开主版本升级，只更新安全的包」

# 特定包的更新影响分析
「请告诉我将provider更新到最新版本的影响和必要的变更」
```

### 详细示例

```bash
# 包含发布说明的详细分析
cat pubspec.yaml && flutter pub outdated
「请分析依赖，并为每个包提供：
1. 当前 → 最新版本
2. 风险评估（安全・注意・危险）
3. 主要变更（来自CHANGELOG）
4. 必要的代码修正
请以表格形式呈现」

# 空安全迁移分析
cat pubspec.yaml
「请找出不支持空安全的包，并制定迁移计划」
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
cp pubspec.yaml pubspec.yaml.backup
cp pubspec.lock pubspec.lock.backup

# 执行更新
flutter pub upgrade

# 更新后检查
flutter analyze
flutter test
flutter pub deps --style=compact
```

### 注意事项

更新后务必进行功能测试。如果出现问题，请使用以下命令恢复：

```bash
cp pubspec.yaml.backup pubspec.yaml
cp pubspec.lock.backup pubspec.lock
flutter pub get
```