---
description: "安全更新 Flutter 依赖。「更新 Flutter 包」「更新 pubspec.yaml」等触发。"
allowed-tools:
  - Bash(flutter *)
  - Bash(dart *)
  - Read
  - Edit
---

# 安全更新 Flutter 依赖

安全地更新 Flutter 项目的依赖关系。

## 使用方法

```bash
# 确认依赖状态并请求 Claude
flutter pub deps --style=compact
「将 pubspec.yaml 的依赖更新到最新版本」
```

## 基本示例

```bash
# 确认当前依赖
cat pubspec.yaml
「分析这个 Flutter 项目的依赖并告诉我可更新的包」

# 升级后确认
flutter pub upgrade --dry-run
「确认这个升级计划中是否有破坏性变更」
```

## 与 Claude 配合

```bash
# 全面的依赖更新
cat pubspec.yaml
「分析 Flutter 的依赖并执行以下操作：
1. 调查各包的最新版本
2. 确认是否有破坏性变更
3. 评估危险度 (安全・注意・危险)
4. 提出必要的代码更改
5. 生成更新版 pubspec.yaml」

# 安全的分阶段更新
flutter pub outdated
「避免主版本升级，只更新可以安全升级的包」

# 特定包的更新影响分析
「告诉我将 provider 更新到最新版本的影响和必要的更改」
```

## 详细示例

```bash
# 包含 Release Notes 的详细分析
cat pubspec.yaml && flutter pub outdated
「分析依赖，为每个包提供：
1. 当前 → 最新版本
2. 危险度评估 (安全・注意・危险)
3. 主要变更 (来自 CHANGELOG)
4. 必要的代码修改
以表格形式展示」

# Null Safety 迁移分析
cat pubspec.yaml
「识别不支持 Null Safety 的包，制定迁移计划」
```

## 危险度标准

```text
安全 (🟢)：
- 补丁版本升级 (1.2.3 → 1.2.4)
- 仅修复 bug
- 保证向后兼容

注意 (🟡)：
- 次版本升级 (1.2.3 → 1.3.0)
- 新增功能
- 有弃用警告

危险 (🔴)：
- 主版本升级 (1.2.3 → 2.0.0)
- 破坏性变更
- API 的删除或更改
```

## 执行更新

```bash
# 创建备份
cp pubspec.yaml pubspec.yaml.backup
cp pubspec.lock pubspec.lock.backup

# 执行更新
flutter pub upgrade

# 更新后确认
flutter analyze
flutter test
flutter pub deps --style=compact
```

## 注意事项

更新后必须进行功能测试。如果出现问题，使用以下命令恢复：

```bash
cp pubspec.yaml.backup pubspec.yaml
cp pubspec.lock.backup pubspec.lock
flutter pub get
```
