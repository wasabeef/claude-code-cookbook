# Token Efficiency Mode

AI の応答を圧縮して、コンテキスト使用量を 30-50% 削減する効率化モードです。

## 概要

Token Efficiency Mode は、視覚的シンボルと略語システムを活用して、Claude の応答を圧縮します。
**生成されるコードの品質や内容は一切変更されません**。変わるのは説明の仕方だけです。

## 使用方法

```bash
# モード有効化
「Token Efficiency Mode で応答して」
「--uc モードで」
「簡潔モードで」
```

## 動作原理

### 1. シンボル体系

#### ロジック & フロー

| シンボル | 意味                         | 使用例                               |
| -------- | ---------------------------- | ------------------------------------ |
| →        | 〜につながる、〜を引き起こす | `auth.js:45 → 🛡️ セキュリティリスク` |
| ⇒        | 〜に変換                     | `input ⇒ validated_output`           |
| ←        | ロールバック、戻す           | `migration ← rollback`               |
| ⇄        | 双方向                       | `sync ⇄ remote`                      |
| &        | かつ、結合                   | `🛡️ security & ⚡ performance`       |
| \|       | または、区切り               | `react\|vue\|angular`                |
| :        | 定義、指定                   | `scope: file\|module`                |
| »        | 次に、シーケンス             | `build » test » deploy`              |
| ∴        | したがって                   | `tests ❌ ∴ code broken`             |
| ∵        | なぜなら                     | `slow ∵ O(n²) algorithm`             |

#### ステータス & 進捗

| シンボル | 意味         | 用途           |
| -------- | ------------ | -------------- |
| ✅       | 完了、成功   | タスク正常終了 |
| ❌       | 失敗、エラー | 即座の対応必要 |
| ⚠️       | 警告         | レビュー推奨   |
| 🔄       | 進行中       | 現在アクティブ |
| ⏳       | 待機中       | 後で実行予定   |
| 🚨       | 緊急、重要   | 高優先度       |

#### 技術ドメイン

| シンボル | 分野           | 用途                 |
| -------- | -------------- | -------------------- |
| ⚡       | パフォーマンス | 速度、最適化         |
| 🔍       | 分析           | 検索、調査           |
| 🔧       | 設定           | セットアップ、ツール |
| 🛡️       | セキュリティ   | 保護、安全性         |
| 📦       | デプロイ       | パッケージ、バンドル |
| 🎨       | デザイン       | UI、フロントエンド   |
| 🏗️       | アーキテクチャ | システム構造         |
| 🗄️       | データベース   | データ永続化         |
| ⚙️       | バックエンド   | サーバー処理         |
| 🧪       | テスト         | 品質保証             |

### 2. 略語システム

#### システム & アーキテクチャ

- `cfg` → configuration(設定)
- `impl` → implementation(実装)
- `arch` → architecture(アーキテクチャ)
- `perf` → performance(パフォーマンス)
- `ops` → operations(運用)
- `env` → environment(環境)

#### 開発プロセス

- `req` → requirements(要件)
- `deps` → dependencies(依存関係)
- `val` → validation(検証)
- `auth` → authentication(認証)
- `docs` → documentation(ドキュメント)
- `std` → standards(標準)

#### 品質 & 分析

- `qual` → quality(品質)
- `sec` → security(セキュリティ)
- `err` → error(エラー)
- `rec` → recovery(回復)
- `sev` → severity(重要度)
- `opt` → optimization(最適化)

## 実例比較

### 例 1: エラー報告

**通常モード (92 文字)**

```text
認証システムのユーザー検証関数の 45 行目でセキュリティの脆弱性が見つかりました。
```

**Token Efficient(39 文字)**

```text
auth.js:45 → 🛡️ sec vuln in user val()
```

### 例 2: ビルド状況

**通常モード (145 文字)**

```text
ビルドプロセスが正常に完了しました。現在テストを実行中で、その後デプロイメントを行います。
```

**Token Efficient(35 文字)**

```text
build ✅ » test 🔄 » deploy ⏳
```

### 例 3: パフォーマンス分析

**通常モード (98 文字)**

```text
パフォーマンス分析の結果、アルゴリズムが O(n²) の計算量のため処理が遅いことが判明しました。
```

**Token Efficient(42 文字)**

```text
⚡ perf: slow ∵ O(n²) → optimize to O(n)
```

## 活用シーン

### ✅ 効果的な場面

- **長時間のデバッグセッション**: 履歴を保持しながら効率的に
- **大規模コードレビュー**: 多数のファイルを簡潔に分析
- **CI/CD モニタリング**: リアルタイムステータス更新
- **プロジェクト進捗報告**: 複数タスクの状態を一覧化
- **エラー追跡**: 問題の連鎖を視覚的に表現

### ❌ 避けるべき場面

- 初心者への説明
- 詳細なドキュメント作成
- 初回の要件定義
- 非技術者とのコミュニケーション

## 実装例

### デバッグセッション

```text
[14:23] breakpoint → vars: {user: null, token: expired}
[14:24] step → auth.validate() ❌
[14:25] check → token.exp < Date.now() ∴ expired
[14:26] fix → refresh() → ✅
[14:27] continue → main flow 🔄
```

### ファイル分析結果

```text
/src/auth/: 🛡️ issues × 3
/src/api/: ⚡ bottleneck in handler()
/src/db/: ✅ clean
/src/utils/: ⚠️ deprecated methods
/tests/: 🧪 coverage 78%
```

### プロジェクトステータス

```text
Frontend: 🎨 ✅ 100%
Backend: ⚙️ 🔄 75%
Database: 🗄️ ✅ migrated
Tests: 🧪 ⚠️ 68% (target: 80%)
Deploy: 📦 ⏳ scheduled
Security: 🛡️ 🚨 1 critical
```

## 設定オプション

```javascript
// 圧縮レベル
--uc; // Ultra Compressed: 最大圧縮
--mc; // Moderate Compressed: 中程度圧縮
--lc; // Light Compressed: 軽度圧縮

// ドメイン特化
--dev; // 開発向け圧縮
--ops; // 運用向け圧縮
--sec; // セキュリティ向け圧縮
```

## メリット

1. **コンテキスト節約**: 30-50% のトークン削減
2. **視覚的理解**: シンボルで直感的把握
3. **情報密度向上**: 同じスペースでより多くの情報
4. **履歴保持**: より長い会話履歴を維持
5. **パターン認識**: 視覚的パターンで問題発見が容易

## 注意事項

- このモードは **AI の応答スタイル**のみを変更します
- 生成される**コードの品質**は変わりません
- 必要に応じて「通常モードで説明して」と切り替え可能
- 初学者や非技術者には通常モードを推奨

## コマンド例

```bash
# 有効化
「Token Efficient Mode on」
「簡潔に応答して」
「--uc で分析」

# 無効化
「通常モードに戻して」
「詳細に説明して」
「Token Efficient Mode off」
```

## 実装の影響

| 項目             | 影響           |
| ---------------- | -------------- |
| 生成コード品質   | 変更なし ✅    |
| 実装の正確性     | 変更なし ✅    |
| 機能性           | 変更なし ✅    |
| AI の説明方法    | 圧縮される 🔄  |
| コンテキスト使用 | 30-50% 削減 ⚡ |

---

💡 **Pro Tip**: 長時間の作業セッションでは、最初は通常モードで理解を深め、その後 Token Efficient Mode に切り替えることで、効率とコンテキスト保持のバランスを最適化できます。
