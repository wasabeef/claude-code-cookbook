## Rust Dependencies Update（Rust依存関係更新）

Rust プロジェクトの依存関係を安全に更新します。

### 使い方

```bash
# 依存関係の状態を確認して Claude に依頼
cargo tree
「Cargo.toml の依存関係を最新バージョンに更新して」
```

### 基本例

```bash
# 現在の依存関係を確認
cat Cargo.toml
「この Rust プロジェクトの依存関係を分析して更新可能なクレートを教えて」

# 更新可能な一覧を確認
cargo update --dry-run
「これらのクレートの更新における危険度を分析して」
```

### Claude との連携

```bash
# 包括的な依存関係更新
cat Cargo.toml
「Rust の依存関係を分析し、以下を実行して：
1. 各クレートの最新バージョンを調査
2. 破壊的変更の有無を確認
3. 危険度を評価（安全・注意・危険）
4. 必要なコード変更を提案
5. 更新版 Cargo.toml を生成」

# 安全な段階的更新
cargo tree
「メジャーバージョンアップを避けて、安全にアップデート可能なクレートのみ更新して」

# 特定クレートの更新影響分析
「tokio を最新バージョンに更新した場合の影響と必要な変更を教えて」
```

### 詳細例

```bash
# Release Notes を含む詳細分析
cat Cargo.toml && cargo tree
「依存関係を分析し、各クレートについて：
1. 現在 → 最新バージョン
2. 危険度評価（安全・注意・危険）
3. 主な変更点（CHANGELOG から）
4. トレイト境界の変更
5. 必要なコード修正
をテーブル形式で提示して」

# 非同期ランタイムの移行分析
cat Cargo.toml src/main.rs
「async-std から tokio への移行、または tokio のメジャーバージョンアップに必要な変更をすべて提示して」
```

### 危険度の基準

```
安全（🟢）：
- パッチバージョンアップ（0.1.2 → 0.1.3）
- バグ修正のみ
- 後方互換性保証

注意（🟡）：
- マイナーバージョンアップ（0.1.0 → 0.2.0）
- 新機能追加
- 非推奨警告あり

危険（🔴）：
- メジャーバージョンアップ（0.x.y → 1.0.0、1.x.y → 2.0.0）
- 破壊的変更
- API の削除・変更
- トレイト境界の変更
```

### 更新の実行

```bash
# バックアップ作成
cp Cargo.toml Cargo.toml.backup
cp Cargo.lock Cargo.lock.backup

# 更新実行
cargo update

# 更新後の確認
cargo check
cargo test
cargo clippy
```

### 注意事項

更新後は必ず動作確認を実施してください。問題が発生した場合は以下で復元：

```bash
cp Cargo.toml.backup Cargo.toml
cp Cargo.lock.backup Cargo.lock
cargo build
```