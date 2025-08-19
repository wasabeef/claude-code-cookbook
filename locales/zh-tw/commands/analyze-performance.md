## 性能分析

分析應用程序的性能問題，從技術债務的角度提出改進方案。

### 使用方法

```bash
# 全面分析性能問題
find . -name "*.js" -o -name "*.ts" | xargs wc -l | sort -rn | head -10
"識別大型文件和性能問題，並提出改進方案"

# 檢測低效的代碼模式
grep -r "for.*await\|forEach.*await" . --include="*.js"
"分析 N+1 查询問題和性能瓶頸"

# 內存洩漏的可能性
grep -r "addEventListener\|setInterval" . --include="*.js" | grep -v "removeEventListener\|clearInterval"
"評估內存洩漏風險和對策"
```

### 基本示例

```bash
# 包體积和加載時間
npm ls --depth=0 && find ./public -name "*.js" -o -name "*.css" | xargs ls -lh
"識別包體积和資源優化的改進點"

# 數據庫性能
grep -r "SELECT\|findAll\|query" . --include="*.js" | head -20
"分析數據庫查询的優化點"

# 依賴項的性能影響
npm outdated && npm audit
"評估過時依賴對性能的影響"
```

### 分析視角

#### 1. 代碼層面的問題

- **O(n²) 算法**: 檢測低效的數組操作
- **同步 I/O**: 識別阻塞處理
- **重復處理**: 刪除不必要的計算或請求
- **內存洩漏**: 事件監听器和定時器管理

#### 2. 架構層面的問題

- **N+1 查询**: 數據庫訪問模式
- **緩存不足**: 重復計算或 API 調用
- **包體积**: 不必要的庫或代碼分割
- **資源管理**: 連接池或線程使用量

#### 3. 技術债務带來的影響

- **遗留代碼**: 旧實現導致的性能下降
- **設計問題**: 責任分散不足導致的高耦合度
- **測試不足**: 性能回歸檢測遗漏
- **監控不足**: 問題早期發現體系

### 改進優先級

```
🔴 Critical: 系統故障風險
├─ 內存洩漏 (服務器崩溃)
├─ N+1 查询 (數據庫負載)
└─ 同步 I/O (響應延遲)

🟡 High: 用戶體驗影響
├─ 包體积 (首次加載時間)
├─ 圖片優化 (顯示速度)
└─ 緩存策略 (響應速度)

🟢 Medium: 運維效率
├─ 依賴更新 (安全性)
├─ 代碼重復 (可維護性)
└─ 監控增強 (運維負担)
```

### 測量和工具

#### Node.js / JavaScript

```bash
# 性能分析
node --prof app.js
clinic doctor -- node app.js

# 包分析
npx webpack-bundle-analyzer
lighthouse --chrome-flags="--headless"
```

#### 數據庫

```sql
-- 查询分析
EXPLAIN ANALYZE SELECT ...
SHOW SLOW LOG;
```

#### 前端

```bash
# React 性能
grep -r "useMemo\|useCallback" . --include="*.jsx"

# 資源分析
find ./src -name "*.png" -o -name "*.jpg" | xargs ls -lh
```

### 持續改進

- **定期審計**: 每週執行性能測試
- **指標收集**: 跟蹤響應時間、內存使用量
- **告警設置**: 超過閾值時自動通知
- **團隊共享**: 記錄改進案例和反模式
