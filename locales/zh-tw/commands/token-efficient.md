# Token 效率模式

AI 應答壓縮模式，將上下文使用量減少 30-50% 的效率化模式。

## 概述

Token 效率模式透過視覺符號和縮略語系統，壓縮 Claude 的應答內容。
**產生的程式碼品質和內容完全不會改變**。改變的只是說明方式。

## 使用方法

```bash
# 模式啟用
「使用 Token 效率模式回應」
「使用 --uc 模式」
「使用簡潔模式」
```

## 運作原理

### 1. 符號體系

#### 邏輯與流程

| 符號 | 意義       | 使用範例                       |
| ---- | ---------- | ------------------------------ |
| →    | 導致、引起 | `auth.js:45 → 🛡️ 安全風險`     |
| ⇒    | 轉換成     | `input ⇒ validated_output`     |
| ←    | 回滾、返回 | `migration ← rollback`         |
| ⇄    | 雙向       | `sync ⇄ remote`                |
| &    | 且、結合   | `🛡️ security & ⚡ performance` |
| \|   | 或、分隔   | `react\|vue\|angular`          |
| :    | 定義、指定 | `scope: file\|module`          |
| »    | 然後、序列 | `build » test » deploy`        |
| ∴    | 因此       | `tests ❌ ∴ code broken`       |
| ∵    | 因為       | `slow ∵ O(n²) algorithm`       |

#### 狀態與進度

| 符號 | 意義       | 用途         |
| ---- | ---------- | ------------ |
| ✅   | 完成、成功 | 任務正常結束 |
| ❌   | 失敗、錯誤 | 需要立即處理 |
| ⚠️   | 警告       | 建議檢視     |
| 🔄   | 進行中     | 目前活躍     |
| ⏳   | 等待中     | 稍後執行     |
| 🚨   | 緊急、重要 | 高優先級     |

#### 技術領域

| 符號 | 領域   | 用途         |
| ---- | ------ | ------------ |
| ⚡   | 效能   | 速度、最佳化 |
| 🔍   | 分析   | 搜尋、調查   |
| 🔧   | 設定   | 設置、工具   |
| 🛡️   | 安全性 | 保護、安全性 |
| 📦   | 部署   | 套件、打包   |
| 🎨   | 設計   | UI、前端     |
| 🏗️   | 架構   | 系統結構     |
| 🗄️   | 資料庫 | 資料持久化   |
| ⚙️   | 後端   | 伺服器處理   |
| 🧪   | 測試   | 品質保證     |

### 2. 縮略語系統

#### 系統與架構

- `cfg` → configuration(設定)
- `impl` → implementation(實作)
- `arch` → architecture(架構)
- `perf` → performance(效能)
- `ops` → operations(運營)
- `env` → environment(環境)

#### 開發流程

- `req` → requirements(需求)
- `deps` → dependencies(相依性)
- `val` → validation(驗證)
- `auth` → authentication(認證)
- `docs` → documentation(文件)
- `std` → standards(標準)

#### 品質與分析

- `qual` → quality(品質)
- `sec` → security(安全性)
- `err` → error(錯誤)
- `rec` → recovery(復原)
- `sev` → severity(嚴重度)
- `opt` → optimization(最佳化)

## 實例比較

### 例 1: 錯誤報告

**一般模式(85 字元)**

```text
認證系統的使用者驗證函式第 45 行發現了安全性弱點。
```

**Token 高效(34 字元)**

```text
auth.js:45 → 🛡️ sec vuln in user val()
```

### 例 2: 建置狀況

**一般模式(120 字元)**

```text
建置程序已正常完成。目前正在執行測試，之後將進行部署。
```

**Token 高效(32 字元)**

```text
build ✅ » test 🔄 » deploy ⏳
```

### 例 3: 效能分析

**一般模式(95 字元)**

```text
效能分析結果，演算法為 O(n²) 計算複雜度導致處理速度緩慢。
```

**Token 高效(40 字元)**

```text
⚡ perf: slow ∵ O(n²) → optimize to O(n)
```

## 適用場景

### ✅ 有效場合

- **長期除錯作業**：保持歷史記錄的同時提升效率
- **大規模程式碼檢視**：簡潔分析大量檔案
- **CI/CD 監控**：即時狀態更新
- **專案進度報告**：一覽式列出多項任務狀態
- **錯誤追蹤**：視覺化表現問題連鎖

### ❌ 應避免的場合

- 對初學者的說明
- 詳細文件製作
- 初次需求定義
- 與非技術人員的溝通

## 實作範例

### 除錯作業

```text
[14:23] breakpoint → vars: {user: null, token: expired}
[14:24] step → auth.validate() ❌
[14:25] check → token.exp < Date.now() ∴ expired
[14:26] fix → refresh() → ✅
[14:27] continue → main flow 🔄
```

### 檔案分析結果

```text
/src/auth/: 🛡️ issues × 3
/src/api/: ⚡ bottleneck in handler()
/src/db/: ✅ clean
/src/utils/: ⚠️ deprecated methods
/tests/: 🧪 coverage 78%
```

### 專案狀態

```text
Frontend: 🎨 ✅ 100%
Backend: ⚙️ 🔄 75%
Database: 🗄️ ✅ migrated
Tests: 🧪 ⚠️ 68% (target: 80%)
Deploy: 📦 ⏳ scheduled
Security: 🛡️ 🚨 1 critical
```

## 設定選項

```javascript
// 壓縮等級
--uc; // Ultra Compressed: 最大壓縮
--mc; // Moderate Compressed: 中等壓縮
--lc; // Light Compressed: 輕度壓縮

// 領域特化
--dev; // 開發向壓縮
--ops; // 營運向壓縮
--sec; // 安全性向壓縮
```

## 優點

1. **上下文節省**：30-50% 的 Token 減少
2. **視覺理解**：符號讓直覺掌握變得容易
3. **資訊密度提升**：相同空間內容納更多資訊
4. **歷史保持**：維持更長的對話歷史
5. **模式識別**：視覺模式讓問題發現更容易

## 注意事項

- 此模式僅改變 **AI 的回應風格**
- 產生的**程式碼品質**不會改變
- 需要時可以「使用一般模式說明」切換
- 對初學者或非技術人員建議使用一般模式

## 命令範例

```bash
# 啟用
「Token 效率模式開啟」
「簡潔回應」
「使用 --uc 分析」

# 停用
「回到一般模式」
「詳細說明」
「Token 效率模式關閉」
```

## 實作的影響

| 項目           | 影響           |
| -------------- | -------------- |
| 產生程式碼品質 | 無變化 ✅      |
| 實作正確性     | 無變化 ✅      |
| 功能性         | 無變化 ✅      |
| AI 說明方式    | 被壓縮 🔄      |
| 上下文使用     | 減少 30-50% ⚡ |

---

💡 **專業提示**：長時間作業時，最初使用一般模式深化理解，之後切換到 Token 效率模式，可最佳化效率與上下文保持的平衡。
