## Gemini 網絡搜索

使用 Gemini CLI 執行網絡搜索以獲取最新資訊。

### 使用方法

```bash
# 通過 Gemini CLI 進行網絡搜索(必须)
gemini --prompt "WebSearch: <搜索查询>"
```

### 基本示例

```bash
# 使用 Gemini CLI
gemini --prompt "WebSearch: React 19 新功能"
gemini --prompt "WebSearch: TypeError Cannot read property of undefined 解決方法"
```

### 與 Claude 配合

```bash
# 文檔搜索和摘要
gemini --prompt "WebSearch: Next.js 14 App Router 官方文檔"
「請總結搜索結果並說明主要功能」

# 錯誤調查
cat error.log
gemini --prompt "WebSearch: [錯誤消息] 解決方法"
「請從搜索結果中提出最合適的解決方法」

# 技術比较
gemini --prompt "WebSearch: Rust vs Go performance benchmark 2024"
「請從搜索結果總結性能差異」
```

### 詳细示例

```bash
# 從多個來源收集資訊
gemini --prompt "WebSearch: GraphQL best practices 2024 multiple sources"
「請從搜索結果整理多個可靠來源的資訊」

# 調查時間序列變化
gemini --prompt "WebSearch: JavaScript ES2015 ES2016 ES2017 ES2018 ES2019 ES2020 ES2021 ES2022 ES2023 ES2024 features"
「請按時間顺序整理各版本的主要變更」

# 限定特定域名搜索
gemini --prompt "WebSearch: site:github.com Rust WebAssembly projects stars:>1000"
「請按星標數量從高到低列出 10 個項目」

# 最新的安全資訊
gemini --prompt "WebSearch: CVE-2024 Node.js vulnerabilities"
「請總結發現的漏洞影響和對策」
```

### 禁止事項

- **禁止使用 Claude 的內置 WebSearch 工具**
- 需要網絡搜索時，必须使用 `gemini --prompt "WebSearch: ..."`

### 注意事項

- **如果 Gemini CLI 可用，必须使用 `gemini --prompt "WebSearch: ..."`**
- 網絡搜索結果不一定總是最新的
- 重要資訊建議通過官方文檔或可靠來源確認
