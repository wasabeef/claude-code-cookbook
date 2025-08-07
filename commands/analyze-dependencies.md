## Dependency Analysis

プロジェクトの依存関係を分析し、アーキテクチャの健全性を評価します。

### 使い方

```bash
/dependency-analysis [オプション]
```

### オプション

- `--visual` : 依存関係を視覚的に表示
- `--circular` : 循環依存のみを検出
- `--depth <数値>` : 分析の深さを指定（デフォルト: 3）
- `--focus <パス>` : 特定のモジュール/ディレクトリに焦点

### 基本例

```bash
# プロジェクト全体の依存関係分析
/dependency-analysis

# 循環依存の検出
/dependency-analysis --circular

# 特定モジュールの詳細分析
/dependency-analysis --focus src/core --depth 5
```

### 分析項目

#### 1. 依存関係マトリックス

モジュール間の依存関係を数値化して表示：

- 直接依存
- 間接依存
- 依存の深さ
- ファンイン/ファンアウト

#### 2. アーキテクチャ違反検出

- レイヤー違反（下位層が上位層に依存）
- 循環依存
- 過度な結合（高い依存度）
- 孤立したモジュール

#### 3. Clean Architecture 準拠チェック

- ドメイン層の独立性
- インフラ層の適切な分離
- ユースケース層の依存方向
- インターフェースの適用状況

### 出力例

```
依存関係分析レポート
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 メトリクス概要
├─ 総モジュール数: 42
├─ 平均依存数: 3.2
├─ 最大依存深度: 5
└─ 循環依存: 2 件検出

⚠️  アーキテクチャ違反
├─ [HIGH] src/domain/user.js → src/infra/database.js
│  └─ ドメイン層がインフラ層に直接依存
├─ [MED] src/api/auth.js ⟲ src/services/user.js
│  └─ 循環依存を検出
└─ [LOW] src/utils/helper.js → 12 modules
   └─ 過度なファンアウト

✅ 推奨アクション
1. UserRepository インターフェースを導入
2. 認証サービスの責務を再設計
3. ヘルパー関数を機能別に分割

📈 依存関係グラフ
[視覚的な依存関係図を ASCII アートで表示]
```

### 高度な使用例

```bash
# CI/CD パイプラインでの自動チェック
/dependency-analysis --circular --fail-on-violation

# アーキテクチャルールの定義と検証
/dependency-analysis --rules .architecture-rules.yml

# 時系列での依存関係の変化を追跡
/dependency-analysis --compare HEAD~10
```

### 設定ファイル例 (.dependency-analysis.yml)

```yaml
```