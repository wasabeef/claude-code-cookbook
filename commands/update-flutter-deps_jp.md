## Flutter Dependencies Update

Flutter プロジェクトの依存関係を安全に更新します。

### 使い方

```bash
# 依存関係の状態を確認して Claude に依頼
flutter pub deps --style=compact
「pubspec.yaml の依存関係を最新バージョンに更新して」
```

### 基本例

```bash
# 現在の依存関係を確認
cat pubspec.yaml
「この Flutter プロジェクトの依存関係を分析して更新可能なパッケージを教えて」

# アップグレード後の確認
flutter pub upgrade --dry-run
「このアップグレード予定の内容から破壊的変更があるか確認して」
```

### Claude との連携

```bash
# 包括的な依存関係更新
cat pubspec.yaml
「Flutter の依存関係を分析し、以下を実行して：
1. 各パッケージの最新バージョンを調査
2. 破壊的変更の有無を確認
3. 危険度を評価（安全・注意・危険）
4. 必要なコード変更を提案
5. 更新版 pubspec.yaml を生成」

# 安全な段階的更新
flutter pub outdated
「メジャーバージョンアップを避けて、安全にアップデート可能なパッケージのみ更新して」

# 特定パッケージの更新影響分析
「provider を最新バージョンに更新した場合の影響と必要な変更を教えて」
```

### 詳細例

```bash
# Release Notes を含む詳細分析
cat pubspec.yaml && flutter pub outdated
「依存関係を分析し、各パッケージについて：
1. 現在 → 最新バージョン
2. 危険度評価（安全・注意・危険）
3. 主な変更点（CHANGELOG から）
4. 必要なコード修正
をテーブル形式で提示して」

# Null Safety 移行の分析
cat pubspec.yaml
「Null Safety に対応していないパッケージを特定し、移行計画を立てて」
```

### 危険度の基準

```
安全（🟢）：
- パッチバージョンアップ（1.2.3 → 1.2.4）
- バグ修正のみ
- 後方互換性保証

注意（🟡）：
- マイナーバージョンアップ（1.2.3 → 1.3.0）
- 新機能追加
- 非推奨警告あり

危険（🔴）：
- メジャーバージョンアップ（1.2.3 → 2.0.0）
- 破壊的変更
- API の削除・変更
```

### 更新の実行

```bash
# バックアップ作成
cp pubspec.yaml pubspec.yaml.backup
cp pubspec.lock pubspec.lock.backup

# 更新実行
flutter pub upgrade

# 更新後の確認
flutter analyze
flutter test
flutter pub deps --style=compact
```

### 注意事項

更新後は必ず動作確認を実施してください。問題が発生した場合は以下で復元：

```bash
cp pubspec.yaml.backup pubspec.yaml
cp pubspec.lock.backup pubspec.lock
flutter pub get
```
