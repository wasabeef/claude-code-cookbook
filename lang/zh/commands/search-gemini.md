## Gemini 网页搜索

使用Gemini CLI执行网页搜索以获取最新信息。

### 使用方法

```bash
# 必须通过Gemini CLI进行网页搜索
gemini --prompt "WebSearch: <搜索查询>"
```

### 基本示例

```bash
# 使用Gemini CLI
gemini --prompt "WebSearch: React 19 新功能"
gemini --prompt "WebSearch: TypeError Cannot read property of undefined 解决方法"
```

### 与Claude的协作

```bash
# 文档搜索与总结
gemini --prompt "WebSearch: Next.js 14 App Router 官方文档"
「总结搜索结果并说明主要功能」

# 错误调查
cat error.log
gemini --prompt "WebSearch: [错误消息] 解决方法"
「从搜索结果中提出最合适的解决方法」

# 技术比较
gemini --prompt "WebSearch: Rust vs Go performance benchmark 2024"
「从搜索结果中总结性能差异」
```

### 详细示例

```bash
# 从多个来源收集信息
gemini --prompt "WebSearch: GraphQL best practices 2024 multiple sources"
「从搜索结果中总结多个可靠来源的信息」

# 调查时间序列变化
gemini --prompt "WebSearch: JavaScript ES2015 ES2016 ES2017 ES2018 ES2019 ES2020 ES2021 ES2022 ES2023 ES2024 features"
「按时间顺序总结各版本的主要变更点」

# 限制特定域名搜索
gemini --prompt "WebSearch: site:github.com Rust WebAssembly projects stars:>1000"
「按星数从多到少列出10个项目」

# 最新安全信息
gemini --prompt "WebSearch: CVE-2024 Node.js vulnerabilities"
「总结发现的漏洞影响和对策」
```

### 禁止事项

- **禁止使用Claude内置的WebSearch工具**
- 需要网页搜索时，必须使用 `gemini --prompt "WebSearch: ..."`

### 注意事项

- **如果Gemini CLI可用，请务必使用 `gemini --prompt "WebSearch: ..."`**
- 网页搜索结果并不总是最新的
- 建议在官方文档或可靠来源中确认重要信息
```