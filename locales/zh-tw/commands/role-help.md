## 角色帮助

迷茫時的角色選擇指南和帮助系統。

### 使用方法

```bash
/role-help                      # 全面的角色選擇指南
/role-help <情况/問題>          # 特定情况的推薦角色
/role-help compare <角色1>,<角色2> # 角色比较
```

### 基本示例

```bash
# 一般指導
/role-help
→ 顯示可用角色及特點列表

# 情况別推薦
/role-help "担心 API 的安全性"
→ 推薦 security 角色及使用方法

# 角色比较
/role-help compare frontend,mobile
→ frontend 和 mobile 的區別與使用場景
```

### 情况別角色選擇指南

### 安全相關

```
這种情况使用 security 角色:
✅ 登錄·認證功能的實現
✅ API 的安全漏洞檢查
✅ 數據加密·隱私保護
✅ 安全合規性確認
✅ 滲透測試·滲透測試

使用方法: /role security
```

### 🏗️ 架構·設計

```
這种情况使用 architect 角色:
✅ 系統整體設計評估
✅ 微服務 vs 單體判斷
✅ 數據庫設計·技術選型
✅ 可擴展性·擴展性考虑
✅ 技術债務評估·改進計劃

使用方法: /role architect
```

### ⚡ 性能問題

```
這种情况使用 performance 角色:
✅ 應用程序運行緩慢
✅ 數據庫查询優化
✅ Web 页面加載速度改進
✅ 內存·CPU 使用量優化
✅ 擴展·負載對策

使用方法: /role performance
```

### 🔍 問題原因調查

```
這种情况使用 analyzer 角色:
✅ Bug·錯誤的根本原因分析
✅ 系統故障原因究明
✅ 復杂問題的結構分析
✅ 數據分析·統計調查
✅ 為什么會發生這個問題的解明

使用方法: /role analyzer
```

### 🎨 前端·UI/UX

```
這种情况使用 frontend 角色:
✅ 用戶界面改進
✅ 可訪問性支持
✅ 響應式設計
✅ 可用性·易用性提升
✅ Web 前端技術全般

使用方法: /role frontend
```

### 📱 移動應用開發

```
這种情况使用 mobile 角色:
✅ iOS·Android 應用優化
✅ 移動特有的 UX 設計
✅ 觸摸界面優化
✅ 離線支持·同步功能
✅ App Store·Google Play 支持

使用方法: /role mobile
```

### 👀 代碼審查·質量

```
這种情况使用 reviewer 角色:
✅ 代碼質量檢查
✅ 可讀性·可維護性評估
✅ 編碼規範確認
✅ 重構建議
✅ PR·提交審查

使用方法: /role reviewer
```

### 🧪 測試·質量保證

```
這种情况使用 qa 角色:
✅ 測試策略制定
✅ 測試覆蓋率評估
✅ 自動測試實施方针
✅ Bug 預防·質量提升策略
✅ CI/CD 中的測試自動化

使用方法: /role qa
```

### 需要多個角色的情况

### 🔄 multi-role (並行分析)

```
這种情况使用 multi-role:
✅ 需要多個專業視角的評估
✅ 想制定综合改進計劃
✅ 想比较各領域的評估
✅ 想整理矛盾·重復

例: /multi-role security,performance
```

### 🗣️ role-debate (辩論)

```
這种情况使用 role-debate:
✅ 專業領域間存在權衡
✅ 技術選型有分歧
✅ 想通過辩論決定設計方针
✅ 想听取不同視角的辩論

例: /role-debate security,performance
```

### 🤖 smart-review (自動建議)

```
這种情况使用 smart-review:
✅ 不知道该使用哪個角色
✅ 想了解當前情况的最佳方法
✅ 想從多個選項中選擇
✅ 初學者不知如何判斷

例: /smart-review
```

### 角色比较表

### 安全系

| 角色 | 主要用途 | 擅长領域 | 不擅长領域 |
|------|---------|----------|-----------|
| security | 漏洞·攻擊對策 | 威胁分析、認證設計 | UX、性能 |
| analyzer | 根本原因分析 | 邏輯分析、證據收集 | 預防策、未來規劃 |

### 設計系

| 角色 | 主要用途 | 擅长領域 | 不擅长領域 |
|------|---------|----------|-----------|
| architect | 系統設計 | 长期視角、全局優化 | 詳细實現、短期解決 |
| reviewer | 代碼質量 | 實現級別、可維護性 | 業務需求、UX |

### 性能系

| 角色 | 主要用途 | 擅长領域 | 不擅长領域 |
|------|---------|----------|-----------|
| performance | 高速化·優化 | 測量、瓶頸 | 安全性、UX |
| qa | 質量保證 | 測試、自動化 | 設計、架構 |

### 用戶體驗系

| 角色 | 主要用途 | 擅长領域 | 不擅长領域 |
|------|---------|----------|-----------|
| frontend | Web UI/UX | 瀏覽器、可訪問性 | 服務器端、DB |
| mobile | 移動 UX | 觸摸、離線支持 | 服務器端、Web |

### 迷茫時的流程圖

```
問題的性質是？
├─ 安全相關 → security
├─ 性能問題 → performance  
├─ Bug·故障調查 → analyzer
├─ UI/UX 改進 → frontend or mobile
├─ 設計·架構 → architect
├─ 代碼質量 → reviewer
├─ 測試相關 → qa
└─ 復合·復杂 → smart-review 建議

跨越多個領域？
├─ 想要综合分析 → multi-role
├─ 辩論·權衡 → role-debate
└─ 不知如何判斷 → smart-review
```

### 常見問題

### Q: frontend 和 mobile 的區別是？

```
A: 
frontend: 以 Web 瀏覽器為中心、HTML/CSS/JavaScript
mobile: 以移動應用為中心、iOS/Android 原生·React Native 等

两者都相關時推薦 multi-role frontend,mobile
```

### Q: security 和 analyzer 的使用場景？

```
A:
security: 攻擊·威胁預防、安全設計
analyzer: 已發生問題的原因分析、調查

安全事件調查使用 multi-role security,analyzer
```

### Q: architect 和 performance 的區別是？

```
A:
architect: 系統整體的长期設計、擴展性
performance: 具體的速度·效率改進

大規模系統的性能設計使用 multi-role architect,performance
```

### 與 Claude 的協作

```bash
# 結合情况說明
/role-help
"React 應用页面加載慢，用戶投诉很多"

# 結合文件內容
cat problem-description.md
/role-help
"推薦適合這個問題的角色"

# 特定選項的迷茫
/role-help compare security,performance
"JWT 令牌有效期問題该用哪個角色？"
```

### 注意事項

- 復杂問題多角色組合更有效
- 紧急性高時使用 single role 快速應對
- 迷茫時推薦使用 smart-review 獲得自動建議
- 最終判斷請用戶根據問題性質決定
