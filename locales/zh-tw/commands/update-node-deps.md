## Node 依賴更新

安全地更新 Node.js 項目的依賴關系。

### 使用方法

```bash
# 確認依賴狀態並請求 Claude
npm outdated
「將 package.json 的依賴更新到最新版本」
```

### 基本示例

```bash
# 確認當前依賴
cat package.json
「分析這個 Node.js 項目的依賴並告诉我可更新的包」

# 確認可更新列表
npm outdated
「分析這些包更新的危險度」
```

### 與 Claude 配合

```bash
# 全面的依賴更新
cat package.json
「分析 Node.js 的依賴並執行以下操作：
1. 調查各包的最新版本
2. 確認是否有破坏性變更
3. 評估危險度（安全・注意・危險）
4. 提出必要的代碼更改
5. 生成更新版 package.json」

# 安全的分阶段更新
npm outdated
「避免主版本升級，只更新可以安全升級的包」

# 特定包的更新影響分析
「告诉我將 express 更新到最新版本的影響和必要的更改」
```

### 詳细示例

```bash
# 包含 Release Notes 的詳细分析
cat package.json && npm outdated
「分析依賴，為每個包提供：
1. 當前 → 最新版本
2. 危險度評估（安全・注意・危險）
3. 主要變更（來自 CHANGELOG）
4. 必要的代碼修改
以表格形式展示」

# TypeScript 項目的類型定義考虑
cat package.json tsconfig.json
「包括 TypeScript 的類型定義更新依賴，制定不會產生類型錯誤的更新計劃」
```

### 危險度標準

```
安全（🟢）：
- 補丁版本升級（1.2.3 → 1.2.4）
- 仅修復 bug
- 保證向後兼容

注意（🟡）：
- 次版本升級（1.2.3 → 1.3.0）
- 新增功能
- 有弃用警告

危險（🔴）：
- 主版本升級（1.2.3 → 2.0.0）
- 破坏性變更
- API 的刪除或更改
```

### 執行更新

```bash
# 創建備份
cp package.json package.json.backup
cp package-lock.json package-lock.json.backup

# 執行更新
npm update

# 更新後確認
npm test
npm run build
npm audit
```

### 注意事項

更新後必须進行功能測試。如果出現問題，使用以下命令恢復：

```bash
cp package.json.backup package.json
cp package-lock.json.backup package-lock.json
npm install
```
