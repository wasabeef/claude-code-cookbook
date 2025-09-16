## Check Fact

プロジェクト内のコードベース、ドキュメント (docs/、README.md など)を参照し、与えられた情報の正誤を確認するためのコマンド。

### 使い方

```bash
# 基本的な使い方
/check-fact "このアプリケーションは Zustand と TanStack Query を使用して状態管理している"

# 複数の情報を一度に確認
/check-fact "このプロジェクトは tRPC と TanStack Router でタイプセーフな API 通信とルーティングを実現している"

# 特定の技術仕様について確認
/check-fact "認証には Clerk または Supabase Auth を使用し、パスキー認証が実装されている"
```

### 確認プロセス

1. **情報源の優先順位**
   - コードベース (最も信頼性が高い)
   - README.md、docs/ 内ドキュメント
   - 設定ファイル (package.json、tsconfig.json、next.config.js、.env.local 等)
   - Issue、Pull Requestの議論履歴

2. **判定結果の分類**
   - `✅ 正しい` - 情報がコードベースと完全に一致
   - `❌ 誤り` - 情報が明確に間違っている
   - `⚠️ 一部正しい` - 部分的に正確だが不完全
   - `❓ 判断不可` - 確認に必要な情報が不足

3. **根拠の明示**
   - 該当ファイル名と行番号
   - 関連するコードスニペット
   - ドキュメントの該当箇所

### 報告形式

```text
## ファクトチェック結果

### 検証対象
「[ユーザーが提供した情報]」

### 結論
[✅/❌/⚠️/❓] [判定結果]

### 根拠
- **ファイル**: `src/components/Auth.tsx:123`
- **内容**: [該当するコード/文章]
- **補足**: [追加説明]

### 詳細説明
[誤りの場合は正しい情報を提示]
[一部正しいの場合は正確でない部分を指摘]
[判断不可の場合は不足している情報を説明]
```

### 基本例

```bash
# プロジェクト技術スタック確認
/check-fact "このアプリは Next.js 14 + Server Actions + Prisma の構成になっている"

# 実装状況確認
/check-fact "Next.js 14 の App Router で RSC (React Server Components) と Streaming が活用されている"

# アーキテクチャ確認
/check-fact "サーバー状態は TanStack Query で、クライアント状態は Zustand で管理し、Redux は使用していない"

# セキュリティ実装確認
/check-fact "認証は Edge Runtime 上で JWT を使用し、Middleware で保護されている"
```

### Claudeとの連携

```bash
# コードベース全体の分析後に確認
ls -la && cat package.json | jq '{next: .dependencies.next, react: .dependencies.react, typescript: .devDependencies.typescript}'
/check-fact "このプロジェクトで使用している主要な依存関係は..."

# 特定機能の実装状況確認
grep -r "use server\|use client\|async function" . --include="*.tsx" --include="*.ts"
/check-fact "Server Actions と Form Actions を使用してプログレッシブエンハンスメントが実装されている"

# ドキュメントとの整合性確認
cat README.md
/check-fact "README に記載されている機能は全て実装済み"
```

### 活用シーン

- 技術仕様書作成時: 記載内容の正確性確認
- プロジェクト引き継ぎ時: 既存実装の理解確認
- クライアント報告前: 実装状況の事実確認
- 技術ブログ執筆時: 記事内容の正確性検証
- 面接・説明資料作成時: プロジェクト概要の正確性確認

### 注意事項

- コードベースが最も信頼性の高い情報源です
- ドキュメントが古い場合は、実装を優先します
- 判断に必要な情報が不足している場合は素直に「判断不可」とします
- セキュリティに関わる情報は特に慎重に検証します
