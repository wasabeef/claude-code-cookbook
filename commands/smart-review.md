## Smart Review

現在の状況を分析し、最適なロール・アプローチを自動提案するコマンド。

### 使い方

```bash
/smart-review                    # 現在のディレクトリを分析
/smart-review <ファイル/ディレクトリ> # 特定対象を分析
```

### 自動判定ロジック

### ファイル拡張子による判定

- `package.json`, `*.tsx`, `*.jsx`, `*.css`, `*.scss` → **frontend**
- `Dockerfile`, `docker-compose.yml`, `*.yaml` → **architect**
- `*.test.js`, `*.spec.ts`, `test/`, `__tests__/` → **qa**
- `*.rs`, `Cargo.toml`, `performance/` → **performance**

### セキュリティ関連ファイル検出

- `auth.js`, `security.yml`, `.env`, `config/auth/` → **security**
- `login.tsx`, `signup.js`, `jwt.js` → **security + frontend**
- `api/auth/`, `middleware/auth/` → **security + architect**

### 複合判定パターン

- `mobile/` + `*.swift`, `*.kt`, `react-native/` → **mobile**
- `webpack.config.js`, `vite.config.js`, `large-dataset/` → **performance**
- `components/` + `responsive.css` → **frontend + mobile**
- `api/` + `auth/` → **security + architect**

### エラー・問題分析

- スタックトレース、`error.log`, `crash.log` → **analyzer**
- `memory leak`, `high CPU`, `slow query` → **performance + analyzer**
- `SQL injection`, `XSS`, `CSRF` → **security + analyzer**

### 提案パターン

### 単一ロール提案

```bash
$ /smart-review src/auth/login.js
→ 「認証ファイルを検出しました」
→ 「security ロールでの分析を推奨します」
→ 「実行しますか？ [y]es / [n]o / [m]ore options」
```

### 複数ロール提案

```bash
$ /smart-review src/mobile/components/
→ 「📱🎨 モバイル + フロントエンド要素を検出」
→ 「推奨アプローチ:」
→ 「[1] mobile ロール単体」
→ 「[2] frontend ロール単体」  
→ 「[3] multi-role mobile,frontend」
→ 「[4] role-debate mobile,frontend」
```

### 問題分析時の提案

```bash
$ /smart-review error.log
→ 「⚠️ エラーログを検出しました」
→ 「analyzer ロールで根本原因分析を開始します」
→ 「[自動実行] /role analyzer」

$ /smart-review slow-api.log
→ 「🐌 パフォーマンス問題を検出」
→ 「推奨: [1]/role performance [2]/role-debate performance,analyzer」
```

### 複雑な設計決定時の提案

```bash
$ /smart-review architecture-design.md
→ 「🏗️🔒⚡ アーキテクチャ + セキュリティ + パフォーマンス要素検出」
→ 「複雑な設計決定のため、議論形式を推奨します」
→ 「[推奨] /role-debate architect,security,performance」
→ 「[代替] /multi-role architect,security,performance」
```

### 提案ロジックの詳細

### 優先度判定

1. **Security** - 認証・認可・暗号化関連は最優先
2. **Critical Errors** - システム停止・データ損失は緊急
3. **Architecture** - 大規模変更・技術選定は慎重検討
4. **Performance** - ユーザー体験に直結
5. **Frontend/Mobile** - UI/UX 改善
6. **QA** - 品質保証・テスト関連

### 議論推奨条件

- 3 つ以上のロールが関連する場合
- セキュリティ vs パフォーマンスのトレードオフがある場合
- アーキテクチャの大幅変更が含まれる場合
- モバイル + Web の両方に影響がある場合

### 基本例

```bash
# 現在のディレクトリを分析
/smart-review
「最適なロールとアプローチを提案して」

# 特定ファイルを分析
/smart-review src/auth/login.js
「このファイルに最適なレビュー方法を提案して」

# エラーログを分析
/smart-review error.log
「このエラーの解決に最適なアプローチを提案して」
```

### 実裁例

### プロジェクト全体の分析

```bash
$ /smart-review
→ 「📊 プロジェクト分析中...」
→ 「React + TypeScript プロジェクトを検出」
→ 「認証機能 + API + モバイル対応を確認」
→ 「」
→ 「💡 推奨ワークフロー:」
→ 「1. security で認証系チェック」
→ 「2. frontend で UI/UX 評価」
→ 「3. mobile でモバイル最適化確認」
→ 「4. architect で全体設計レビュー」
→ 「」
→ 「自動実行しますか？ [y]es / [s]elect role / [c]ustom」
```

### 特定問題の分析

```bash
$ /smart-review "JWT の有効期限をどう設定すべきか"
→ 「🤔 技術的な設計判断を検出」
→ 「複数の専門観点が必要な問題です」
→ 「」
→ 「推奨アプローチ:」
→ 「/role-debate security,performance,frontend」
→ 「理由: セキュリティ・パフォーマンス・ UX のバランスが重要」
```

### Claude との連携

```bash
# ファイル内容と組み合わせた分析
cat src/auth/middleware.js
/smart-review
「このファイルの内容を含めてセキュリティ観点で分析して」

# エラーと組み合わせた分析
npm run build 2>&1 | tee build-error.log
/smart-review build-error.log
「ビルドエラーの解決方法を提案して」

# 設計相談
/smart-review
「React Native と Progressive Web App のどちらを選ぶべきか議論して」
```

### 注意事項

- 提案は参考情報です。最終的な判断はユーザーが行ってください
- 複雑な問題ほど議論形式（role-debate）を推奨します
- 単純な問題は single role で十分な場合が多いです
- セキュリティ関連は必ず専門ロールでの確認を推奨します
