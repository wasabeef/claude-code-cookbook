## Node Dependencies Update（ノード依存関係更新）

Node.js プロジェクトの依存関係を安全に更新します。

### 使い方

```bash
# 依存関係の状態を確認して Claude に依頼
npm outdated
「package.json の依存関係を最新バージョンに更新して」
```

### 基本例

```bash
# 現在の依存関係を確認
cat package.json
「この Node.js プロジェクトの依存関係を分析して更新可能なパッケージを教えて」

# アップデート可能な一覧を確認
npm outdated
「これらのパッケージの更新における危険度を分析して」
```

### Claude との連携

```bash
# 包括的な依存関係更新
cat package.json
「Node.js の依存関係を分析し、以下を実行して：
1. 各パッケージの最新バージョンを調査
2. 破壊的変更の有無を確認
3. 危険度を評価（安全・注意・危険）
4. 必要なコード変更を提案
5. 更新版 package.json を生成」

# 安全な段階的更新
npm outdated
「メジャーバージョンアップを避けて、安全にアップデート可能なパッケージのみ更新して」

# 特定パッケージの更新影響分析
「express を最新バージョンに更新した場合の影響と必要な変更を教えて」
```

### 詳細例

```bash
# Release Notes を含む詳細分析
cat package.json && npm outdated
「依存関係を分析し、各パッケージについて：
1. 現在 → 最新バージョン
2. 危険度評価（安全・注意・危険）
3. 主な変更点（CHANGELOG から）
4. 必要なコード修正
をテーブル形式で提示して」

# TypeScript プロジェクトの型定義考慮
cat package.json tsconfig.json
「TypeScript の型定義も含めて依存関係を更新し、型エラーが発生しないように更新計画を立てて」
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
cp package.json package.json.backup
cp package-lock.json package-lock.json.backup

# 更新実行
npm update

# 更新後の確認
npm test
npm run build
npm audit
```

### 注意事項

更新後は必ず動作確認を実施してください。問題が発生した場合は以下で復元：

```bash
cp package.json.backup package.json
cp package-lock.json.backup package-lock.json
npm install
```