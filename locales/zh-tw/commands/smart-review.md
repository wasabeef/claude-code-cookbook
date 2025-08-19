## 智能審查

分析當前情况，自動建議最佳角色和方法的命令。

### 使用方法

```bash
/smart-review                    # 分析當前目錄
/smart-review <文件/目錄>        # 分析特定對象
```

### 自動判定邏輯

### 基于文件擴展名的判定

- `package.json`, `*.tsx`, `*.jsx`, `*.css`, `*.scss` → **frontend**
- `Dockerfile`, `docker-compose.yml`, `*.yaml` → **architect**
- `*.test.js`, `*.spec.ts`, `test/`, `__tests__/` → **qa**
- `*.rs`, `Cargo.toml`, `performance/` → **performance**

### 安全相關文件檢測

- `auth.js`, `security.yml`, `.env`, `config/auth/` → **security**
- `login.tsx`, `signup.js`, `jwt.js` → **security + frontend**
- `api/auth/`, `middleware/auth/` → **security + architect**

### 復合判定模式

- `mobile/` + `*.swift`, `*.kt`, `react-native/` → **mobile**
- `webpack.config.js`, `vite.config.js`, `large-dataset/` → **performance**
- `components/` + `responsive.css` → **frontend + mobile**
- `api/` + `auth/` → **security + architect**

### 錯誤與問題分析

- 堆棧跟蹤、`error.log`, `crash.log` → **analyzer**
- `memory leak`, `high CPU`, `slow query` → **performance + analyzer**
- `SQL injection`, `XSS`, `CSRF` → **security + analyzer**

### 建議模式

### 單一角色建議

```bash
$ /smart-review src/auth/login.js
→ 「檢測到認證文件」
→ 「推薦使用 security 角色分析」
→ 「是否執行？ [y]es / [n]o / [m]ore options」
```

### 多角色建議

```bash
$ /smart-review src/mobile/components/
→ 「📱🎨 檢測到移動端 + 前端元素」
→ 「推薦方法：」
→ 「[1] mobile 角色單独」
→ 「[2] frontend 角色單独」
→ 「[3] multi-role mobile,frontend」
→ 「[4] role-debate mobile,frontend」
```

### 問題分析時的建議

```bash
$ /smart-review error.log
→ 「⚠️ 檢測到錯誤日誌」
→ 「使用 analyzer 角色開始根本原因分析」
→ 「[自動執行] /role analyzer」

$ /smart-review slow-api.log
→ 「🐌 檢測到性能問題」
→ 「推薦：[1]/role performance [2]/role-debate performance,analyzer」
```

### 復杂設計決策時的建議

```bash
$ /smart-review architecture-design.md
→ 「🏗️🔒⚡ 檢測到架構 + 安全 + 性能元素」
→ 「由于設計決策復杂，推薦讨論形式」
→ 「[推薦] /role-debate architect,security,performance」
→ 「[替代] /multi-role architect,security,performance」
```

### 建議邏輯詳情

### 優先級判定

1. **Security** - 認證、授權、加密相關最優先
2. **Critical Errors** - 系統停機、數據丢失紧急處理
3. **Architecture** - 大規模變更、技術選型慎重考虑
4. **Performance** - 直接影響用戶體驗
5. **Frontend/Mobile** - UI/UX 改進
6. **QA** - 質量保證、測試相關

### 推薦讨論的條件

- 涉及 3 個以上角色時
- 存在安全性與性能的權衡時
- 包含架構大幅變更時
- 同時影響移動端和 Web 時

### 基本示例

```bash
# 分析當前目錄
/smart-review
「請建議最佳的角色和方法」

# 分析特定文件
/smart-review src/auth/login.js
「請建議此文件的最佳審查方法」

# 分析錯誤日誌
/smart-review error.log
「請建議解決此錯誤的最佳方法」
```

### 實際示例

### 項目整體分析

```bash
$ /smart-review
→ 「📊 正在分析項目...」
→ 「檢測到 React + TypeScript 項目」
→ 「確認包含認證功能 + API + 移動端支持」
→ 「」
→ 「💡 推薦工作流程：」
→ 「1. security 檢查認證系統」
→ 「2. frontend 評估 UI/UX」
→ 「3. mobile 確認移動端優化」
→ 「4. architect 審查整體設計」
→ 「」
→ 「是否自動執行？ [y]es / [s]elect role / [c]ustom」
```

### 特定問題分析

```bash
$ /smart-review "JWT 有效期應该如何設置"
→ 「🤔 檢測到技術設計決策」
→ 「這是需要多個專業視角的問題」
→ 「」
→ 「推薦方法：」
→ 「/role-debate security,performance,frontend」
→ 「原因：需要平衡安全性、性能和用戶體驗」
```

### 與 Claude 配合

```bash
# 結合文件內容分析
cat src/auth/middleware.js
/smart-review
「請結合此文件內容從安全角度分析」

# 結合錯誤分析
npm run build 2>&1 | tee build-error.log
/smart-review build-error.log
「請建議構建錯誤的解決方法」

# 設計咨询
/smart-review
「請讨論應该選擇 React Native 還是 Progressive Web App」
```

### 注意事項

- 建議仅供參考，最終決定由用戶做出
- 復杂問題推薦使用讨論形式（role-debate）
- 簡單問題使用單一角色通常就足够
- 安全相關問題必须推薦使用專業角色確認
