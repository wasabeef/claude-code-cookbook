## Gemini 网络搜索

使用 Gemini CLI 执行网络搜索以获取最新信息。

### 使用方法

```bash
# 通过 Gemini CLI 进行网络搜索(必须)
gemini --prompt "WebSearch: <搜索查询>"
```

### 基本示例

```bash
# 使用 Gemini CLI
gemini --prompt "WebSearch: React 19 新功能"
gemini --prompt "WebSearch: TypeError Cannot read property of undefined 解决方法"
```

### 与 Claude 配合

```bash
# 文档搜索和摘要
gemini --prompt "WebSearch: Next.js 14 App Router 官方文档"
「请总结搜索结果并说明主要功能」

# 错误调查
cat error.log
gemini --prompt "WebSearch: [错误消息] 解决方法"
「请从搜索结果中提出最合适的解决方法」

# 技术比较
gemini --prompt "WebSearch: Rust vs Go performance benchmark 2024"
「请从搜索结果总结性能差异」
```

### 详细示例

```bash
# 从多个来源收集信息
gemini --prompt "WebSearch: GraphQL best practices 2024 multiple sources"
「请从搜索结果整理多个可靠来源的信息」

# 调查时间序列变化
gemini --prompt "WebSearch: JavaScript ES2015 ES2016 ES2017 ES2018 ES2019 ES2020 ES2021 ES2022 ES2023 ES2024 features"
「请按时间顺序整理各版本的主要变更」

# 限定特定域名搜索
gemini --prompt "WebSearch: site:github.com Rust WebAssembly projects stars:>1000"
「请按星标数量从高到低列出 10 个项目」

# 最新的安全信息
gemini --prompt "WebSearch: CVE-2024 Node.js vulnerabilities"
「请总结发现的漏洞影响和对策」
```

### 禁止事项

- **禁止使用 Claude 的内置 WebSearch 工具**
- 需要网络搜索时，必须使用 `gemini --prompt "WebSearch: ..."`

### 注意事项

- **如果 Gemini CLI 可用，必须使用 `gemini --prompt "WebSearch: ..."`**
- 网络搜索结果不一定总是最新的
- 重要信息建议通过官方文档或可靠来源确认
