## Gemini Web Search

Gemini CLI で Web 検索を実行して最新情報を取得します。

### 使い方

```bash
# Gemini CLI 経由で Web 検索（必須）
gemini --prompt "WebSearch: <検索クエリ>"
```

### 基本例

```bash
# Gemini CLI を使用
gemini --prompt "WebSearch: React 19 新機能"
gemini --prompt "WebSearch: TypeError Cannot read property of undefined 解決方法"
```

### Claude との連携

```bash
# ドキュメント検索と要約
gemini --prompt "WebSearch: Next.js 14 App Router 公式ドキュメント"
「検索結果を要約して主要な機能を説明して」

# エラー調査
cat error.log
gemini --prompt "WebSearch: [エラーメッセージ] 解決方法"
「検索結果から最も適切な解決方法を提案して」

# 技術比較
gemini --prompt "WebSearch: Rust vs Go performance benchmark 2024"
「検索結果からパフォーマンスの違いをまとめて」
```

### 詳細例

```bash
# 複数ソースからの情報収集
gemini --prompt "WebSearch: GraphQL best practices 2024 multiple sources"
「検索結果から複数の信頼できるソースの情報をまとめて」

# 時系列での変化を調査
gemini --prompt "WebSearch: JavaScript ES2015 ES2016 ES2017 ES2018 ES2019 ES2020 ES2021 ES2022 ES2023 ES2024 features"
「各バージョンの主要な変更点を時系列でまとめて」

# 特定ドメインに絞った検索
gemini --prompt "WebSearch: site:github.com Rust WebAssembly projects stars:>1000"
「スター数の多い順に 10 個のプロジェクトをリストアップして」

# 最新のセキュリティ情報
gemini --prompt "WebSearch: CVE-2024 Node.js vulnerabilities"
「見つかった脆弱性の影響と対策をまとめて」
```

### 禁止事項

- **Claude の組み込み WebSearch ツールの使用は禁止**
- Web 検索が必要な場合は、必ず `gemini --prompt "WebSearch: ..."` を使用すること

### 注意事項

- **Gemini CLI が利用可能な場合は、必ず `gemini --prompt "WebSearch: ..."` を使用してください**
- Web 検索結果は常に最新とは限りません
- 重要な情報は公式ドキュメントや信頼できるソースで確認することをお勧めします
