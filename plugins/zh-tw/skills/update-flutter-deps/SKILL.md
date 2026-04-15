---
description: "安全更新 Flutter 依賴。「更新 Flutter 套件」「更新 pubspec.yaml」等觸發。"
allowed-tools:
  - Bash(flutter *)
  - Bash(dart *)
  - Read
  - Edit
---

# 安全更新 Flutter 依賴

安全地更新 Flutter 項目的依賴關系。

## 使用方法

```bash
# 確認依賴狀態並請求 Claude
flutter pub deps --style=compact
「將 pubspec.yaml 的依賴更新到最新版本」
```

## 基本示例

```bash
# 確認當前依賴
cat pubspec.yaml
「分析這個 Flutter 項目的依賴並告诉我可更新的包」

# 升級後確認
flutter pub upgrade --dry-run
「確認這個升級計劃中是否有破坏性變更」
```

## 與 Claude 配合

```bash
# 全面的依賴更新
cat pubspec.yaml
「分析 Flutter 的依賴並執行以下操作：
1. 調查各包的最新版本
2. 確認是否有破坏性變更
3. 評估危險度 (安全・注意・危險)
4. 提出必要的代碼更改
5. 生成更新版 pubspec.yaml」

# 安全的分阶段更新
flutter pub outdated
「避免主版本升級，只更新可以安全升級的包」

# 特定包的更新影響分析
「告诉我將 provider 更新到最新版本的影響和必要的更改」
```

## 詳细示例

```bash
# 包含 Release Notes 的詳细分析
cat pubspec.yaml && flutter pub outdated
「分析依賴，為每個包提供：
1. 當前 → 最新版本
2. 危險度評估 (安全・注意・危險)
3. 主要變更 (來自 CHANGELOG)
4. 必要的代碼修改
以表格形式展示」

# Null Safety 遷移分析
cat pubspec.yaml
「識別不支持 Null Safety 的包，制定遷移計劃」
```

## 危險度標準

```text
安全 (🟢)：
- 補丁版本升級 (1.2.3 → 1.2.4)
- 仅修復 bug
- 保證向後兼容

注意 (🟡)：
- 次版本升級 (1.2.3 → 1.3.0)
- 新增功能
- 有弃用警告

危險 (🔴)：
- 主版本升級 (1.2.3 → 2.0.0)
- 破坏性變更
- API 的刪除或更改
```

## 執行更新

```bash
# 創建備份
cp pubspec.yaml pubspec.yaml.backup
cp pubspec.lock pubspec.lock.backup

# 執行更新
flutter pub upgrade

# 更新後確認
flutter analyze
flutter test
flutter pub deps --style=compact
```

## 注意事項

更新後必须進行功能測試。如果出現問題，使用以下命令恢復：

```bash
cp pubspec.yaml.backup pubspec.yaml
cp pubspec.lock.backup pubspec.lock
flutter pub get
```
