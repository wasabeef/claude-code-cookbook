## 角色

切換到特定角色(role)，執行專業分析或工作。

### 使用方法

```bash
/role <角色名> [--agent|-a]
```

### 選項

- `--agent` 或 `-a` : 作為子代理独立執行(推薦用于大規模分析)
  - 使用此選項時，如果角色的 description 包含自動委托促進短語(如 "use PROACTIVELY" 等)，將啟用更积极的自動委托

### 可用角色

#### 專業分析角色(Evidence-First 集成)

- `security` : 安全審計專家(OWASP Top 10·威胁建模·Zero Trust 原則·CVE 對照)
- `performance` : 性能優化專家(Core Web Vitals·RAIL 模型·渐進式優化·ROI 分析)
- `analyzer` : 根本原因分析專家(5 Whys·系統思維·假設驅動·認知偏差對策)
- `frontend` : 前端·UI/UX 專家(WCAG 2.1·設計系統·用戶中心設計)

#### 開發支持角色

- `reviewer` : 代碼審查專家(可讀性·可維護性·性能·重構建議)
- `architect` : 系統架構师(Evidence-First 設計·MECE 分析·演進式架構)
- `qa` : 測試工程师(測試覆蓋率·E2E/集成/單元策略·自動化建議)
- `mobile` : 移動開發專家(iOS HIG·Android Material Design·跨平台策略)

### 基本示例

```bash
# 切換到安全審計模式(常規)
/role security
"檢查這個項目的安全漏洞"

# 使用子代理執行安全審計(大規模分析)
/role security --agent
"執行整個項目的安全審計"

# 切換到代碼審查模式
/role reviewer
"審查最近的變更並指出改進點"

# 切換到性能優化模式
/role performance
"分析應用程序的瓶頸"

# 切換到根本原因分析模式
/role analyzer
"調查這個故障的根本原因"

# 切換到前端專業模式
/role frontend
"評估 UI/UX 的改進點"

# 切換到移動開發專業模式
/role mobile
"評估這個應用的移動優化"

# 返回常規模式
/role default
"返回常規 Claude"
```

### 與 Claude 的協作

```bash
# 安全專注分析
/role security
cat app.js
"詳细分析這段代碼的潜在安全風險"

# 架構視角評估
/role architect
ls -la src/
"提出當前結構的問題和改進方案"

# 測試策略制定
/role qa
"為這個項目提出最佳測試策略"
```

### 詳细示例

```bash
# 多角色分析
/role security
"首先從安全角度檢查"
git diff HEAD~1

/role reviewer
"接下來審查一般代碼質量"

/role architect
"最後從架構角度評估"

# 角色特定的輸出格式
/role security
安全分析結果
━━━━━━━━━━━━━━━━━━━━━
漏洞: SQL 注入
严重度: High
位置: db.js:42
修復建議: 使用參數化查询
```

### Evidence-First 集成功能

#### 核心理念

各角色採用 **Evidence-First(基于證據)** 方法，基于 **經過驗證的方法·官方指南·客觀數據** 而非推測進行分析·建議。

#### 共同特徵

- **官方文檔準拠**: 優先參考各領域權威官方指南
- **MECE 分析**: 無遗漏無重復的系統化問題分解
- **多角度評估**: 技術·業務·運維·用戶的多視角
- **認知偏差對策**: 排除確認偏差等的機制
- **辩論特性**: 角色特有的專業辩論立場

### 專業分析角色詳情

#### security(安全審計專家)

**Evidence-Based 安全審計**

- 通過 OWASP Top 10·Testing Guide·SAMM 進行系統評估
- 通過 CVE·NVD 數據庫對照檢查已知漏洞
- 通過 STRIDE·Attack Tree·PASTA 進行威胁建模
- 通過 Zero Trust 原則·最小權限進行設計評估

**專業報告格式**

```
Evidence-Based 安全審計結果
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
OWASP Top 10 合規度: XX% / CVE 對照: 完成
威胁建模: STRIDE 分析完成
```

#### performance(性能優化專家)

**Evidence-First 性能優化**

- Core Web Vitals(LCP·FID·CLS)·RAIL 模型準拠
- Google PageSpeed Insights 建議實施
- 渐進式優化流程(測量→分析→優先級→實施)
- 通過 ROI 分析進行投資回報的定量評估

**專業報告格式**

```
Evidence-First 性能分析
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Core Web Vitals: LCP[XXXms] FID[XXXms] CLS[X.XX]
Performance Budget: XX% / ROI 分析: XX% 改進預測
```

#### analyzer(根本原因分析專家)

**Evidence-First 根本原因分析**

- 5 Whys + α方法(包含反證檢讨)
- 基于系統思維的結構分析(Peter Senge 原則)
- 認知偏差對策(排除確認偏差·锚定效應等)
- 彻底的假設驅動分析(並行驗證多個假設)

**專業報告格式**

```
Evidence-First 根本原因分析
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
分析可信度: 高 / 偏差對策: 已實施
假設驗證矩阵: XX% 確信度
```

#### frontend(前端·UI/UX 專家)

**Evidence-First 前端開發**

- WCAG 2.1 可訪問性準拠
- Material Design·iOS HIG 官方指南準拠
- 用戶中心設計·設計系統標準應用
- 通過 A/B 測試·用戶行為分析進行驗證

### 開發支持角色詳情

#### reviewer(代碼審查專家)

- 可讀性·可維護性·性能的多角度評估
- 編碼規範遵守檢查·重構建議
- 安全性·可訪問性的横向確認

#### architect(系統架構师)

- Evidence-First 設計原則·MECE 分析的分阶段思考
- 演進式架構·多視角評估(技術·業務·運維·用戶)
- 官方架構模式·最佳實践參考

#### qa(測試工程师)

- 測試覆蓋率分析·E2E/集成/單元測試策略
- 測試自動化建議·質量指標設計

#### mobile(移動開發專家)

- iOS HIG·Android Material Design 官方指南準拠
- 跨平台策略·Touch-First 設計
- 應用商店審核指南·移動特化 UX 優化

### 角色特有的辩論特性

各角色根據專業領域具有独特的辩論立場·論據來源·優勢。

#### security 角色的辩論特性

- **立場**: 保守方法·風險最小化優先·最坏情况假設
- **論據**: OWASP 指南·NIST 框架·實際攻擊案例
- **優勢**: 風險評估精度·深厚的監管要求知識·全面的攻擊手法理解
- **注意**: 過度保守·對 UX 的考虑不足·忽視實施成本

#### performance 角色的辩論特性

- **立場**: 數據驅動決策·效率重視·用戶體驗優先·持續改進
- **論據**: Core Web Vitals·基準測試結果·用戶行為數據·行業標準
- **優勢**: 定量評估能力·瓶頸識別精度·ROI 分析
- **注意**: 忽視安全性·對可維護性考虑不足·過度重視測量

#### analyzer 角色的辩論特性

- **立場**: 證據重視·假設驗證·結構思維·偏差排除
- **論據**: 實測數據·統計方法·系統思維理論·認知偏差研究
- **優勢**: 邏輯分析能力·證據評估的客觀性·結構問題的發現力
- **注意**: 分析瘫痪·完美主義·數據万能主義·過度怀疑

#### frontend 角色的辩論特性

- **立場**: 用戶中心·可訪問性重視·設計原則準拠·體驗價值優先
- **論據**: UX 調研·可訪問性標準·設計系統·可用性測試
- **優勢**: 用戶視角·設計原則·可訪問性·體驗設計
- **注意**: 忽視技術約束·對性能考虑不足·實施復杂性

### 多角色協作的效果

通過組合具有不同辩論特性的角色，可以實現平衡的分析：

#### 典型的協作模式

- **security + frontend**: 安全性與可用性的平衡
- **performance + security**: 速度與安全的两立
- **analyzer + architect**: 問題分析與結構設計的整合
- **reviewer + qa**: 代碼質量與測試策略的協作

## 高級角色功能

### 智能角色選擇

- `/smart-review` : 通過項目分析自動建議角色
- `/role-help` : 根據情况的最佳角色選擇指南

### 多角色協作

- `/multi-role <角色1>,<角色2>` : 多角色同時分析
- `/role-debate <角色1>,<角色2>` : 角色間辩論

### 使用示例

#### 自動角色建議

```bash
/smart-review
→ 分析當前情况並建議最佳角色

/smart-review src/auth/
→ 從認證相關文件推薦 security 角色
```

#### 多角色分析

```bash
/multi-role security,performance
"從多個視角評估這個 API"
→ 從安全和性能两方面進行综合分析

/role-debate frontend,security
"讨論雙因素認證的 UX"
→ 從可用性和安全性角度進行辩論
```

#### 角色選擇困惑時

```bash
/role-help "API 慢且担心安全"
→ 建議適当的方法(multi-role 或 debate)

/role-help compare frontend,mobile
→ 前端和移動角色的區別與使用分場
```

## 注意事項

### 關于角色行為

- 切換角色時，Claude 的 **行為·優先事項·分析方法·報告格式** 會專門化
- 各角色通過 **Evidence-First 方法** 優先應用官方指南·經過驗證的方法
- 使用 `default` 返回常規模式(解除角色特化)
- 角色仅在當前會話內有效

### 有效使用方法

- **簡單問題**: 單一角色的專業分析足够
- **復杂問題**: multi-role 或 role-debate 的多角度分析有效
- **困惑時**: 請使用 smart-review 或 role-help
- **持續改進**: 同一角色也會通過新證據·方法提高分析精度

### 子代理功能(--agent 選項)

需要大規模分析或独立專業處理時，可使用 `--agent` 選項將角色作為子代理執行。

#### 優點

- **独立上下文**: 不幹扰主對話
- **並行執行**: 可同時執行多個分析
- **專業特化**: 更深入的分析和詳细報告
- **促進自動委托**: 角色的 description 包含 "use PROACTIVELY" 或 "MUST BE USED" 時，啟用更积极的自動委托

#### 推薦使用場景

```bash
# 安全: OWASP 全項目檢查、CVE 對照
/role security --agent
"全代碼庫的安全審計"

# 分析器: 大量日誌的根本原因分析
/role analyzer --agent
"分析過去一週的錯誤日誌"

# 審查员: 大規模 PR 的詳细審查
/role reviewer --agent
"審查 PR #500 的 1000 行變更"
```

#### 常規角色 vs 子代理

| 場景       | 推薦     | 命令                     |
| ---------- | -------- | ------------------------ |
| 簡單確認   | 常規角色 | `/role security`         |
| 大規模分析 | 子代理   | `/role security --agent` |
| 交互式工作 | 常規角色 | `/role frontend`         |
| 独立審計   | 子代理   | `/role qa --agent`       |

### 角色設置詳情

- 各角色的詳细設置·專業知識·辩論特性在 `.claude/agents/roles/` 目錄內定義
- 包含 Evidence-First 方法·認知偏差對策
- 通過角色特有的觸發短語自動啟用特化模式
- 實際角色文件由 200 行以上的專業內容構成
