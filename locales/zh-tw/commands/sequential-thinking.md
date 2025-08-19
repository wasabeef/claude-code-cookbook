## 顺序思考

通過動態且迭代的思考過程，逐步解決復杂問題。這是一种在思考過程中可以調整方向和重新審視的灵活方法。

### 使用方法

```bash
# 請求 Claude 進行分阶段思考
「請用 sequential-thinking 考虑[课題]」
```

### 基本示例

```bash
# 算法設計
「請用 sequential-thinking 設計高效的緩存策略」

# 問題解決
「請用 sequential-thinking 解決數據庫性能問題」

# 設計探讨
「請用 sequential-thinking 探讨實時通知系統的設計」
```

### 與 Claude 配合

```bash
# 復杂的實現方针
「請用 sequential-thinking 探讨認證系統的實現方针。考虑 OAuth2、JWT、會話管理」

# Bug 原因分析
「請用 sequential-thinking 分析內存洩漏的原因。包含代碼審查和性能分析結果」

# 重構策略
cat src/complex_module.js
「請用 sequential-thinking 制定此模塊的重構策略」

# 技術選型
「請用 sequential-thinking 分析前端框架的選擇。考虑項目需求和約束」
```

### 思考過程

1. **初始分析** - 基本理解和分解問題
2. **假設生成** - 建立解決方案的假設
3. **驗證與更正** - 驗證假設，必要時更正
4. **分支與探索** - 探索多個解決路徑
5. **整合與結論** - 得出最優解

### 特點

- **動態調整** - 可在思考過程中轉換方向
- **假設驗證** - 建立假設並驗證的循環
- **分支思考** - 同時探索多個思考路徑
- **逐步细化** - 逐步優化解決方案
- **灵活性** - 基于新資訊調整方针

### 詳细示例

```bash
# 復杂系統設計
「請用 sequential-thinking 探讨電商網站的微服務設計。包括訂單處理、庫存管理、支付的協作」

# 安全設計
「請用 sequential-thinking 探讨 API 安全設計。包括認證、授權、速率限制、審計日誌」

# 性能優化
「請用 sequential-thinking 探讨大規模數據處理的優化。考虑內存使用、處理速度、可擴展性」

# 依賴管理
「請用 sequential-thinking 探讨 monorepo 的依賴管理策略。包括構建時間、部署、測試執行」
```

### 注意事項

sequential-thinking 最適合需要逐步深化思考的復杂問題。對于簡單問題或有明確答案的情况，請使用常規的提問形式。

### 執行示例

```bash
# 使用示例
「請用 sequential-thinking 探讨 GraphQL Schema 的設計」

# 預期行為
# 1. 初始分析：分析 GraphQL Schema 的基本需求
# 2. 假設生成：探讨多种設計模式
# 3. 驗證：驗證各模式的優缺點
# 4. 分支：必要時探索新方法
# 5. 整合：提出最優的 Schema 設計
```
