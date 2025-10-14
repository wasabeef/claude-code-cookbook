## 多角色分析

使用多個角色並行分析同一對象，生成综合報告的命令。

### 使用方法

```bash
/multi-role <角色 1>,<角色 2> [--agent|-a] [分析對象]
/multi-role <角色 1>,<角色 2>,<角色 3> [--agent|-a] [分析對象]
```

### 可用角色

#### 專業分析角色

- `security` : 安全審計專家
- `performance` : 性能優化專家
- `analyzer` : 根本原因分析專家
- `frontend` : 前端·UI/UX 專家
- `mobile` : 移動開發專家
- `backend` : 後端與伺服器端專家

#### 開發支援角色

- `reviewer` : 程式碼審查專家
- `architect` : 系統架構師
- `qa` : 測試工程師

**重要**:

- `--agent` 選項需要放在角色指定之後
- 消息要寫在 `--agent` 之後
- 正確示例: `/multi-role qa,architect --agent 評估計劃`
- 錯誤示例: `/multi-role qa,architect 評估計劃 --agent`

### 選項

- `--agent` 或 `-a` : 將各角色作為子代理並行執行 (推薦用于大規模分析)
  - 使用此選項時，如果角色的 description 中包含自動委托促進短語 (如 "use PROACTIVELY" 等)，將啟用更积极的自動委托

### 基本示例

```bash
# 安全和性能的雙重分析 (常規)
/multi-role security,performance
"評估這個 API 端點"

# 大規模系統的並行分析 (子代理)
/multi-role security,performance --agent
"全面分析系統的安全性和性能"

# 前端·移動·性能的综合分析
/multi-role frontend,mobile,performance
"考虑這個界面的優化方案"

# 架構設計的多角度評估 (子代理)
/multi-role architect,security,performance --agent
"評估微服務化的設計"
```

### 分析流程

### 阶段 1: 並行分析

各角色独立分析同一對象

- 從專業視角進行評估
- 按角色特有標準判定
- 生成独立的建議

### 阶段 2: 综合分析

結構化整合結果

- 整理各角色的評估結果
- 識別重復·矛盾點
- 明確互補關系

### 阶段 3: 综合報告

生成最終建議

- 带優先級的行動計劃
- 明示權衡取舍
- 提供實施路線圖

### 輸出格式示例

### 2 角色分析的情况

```text
多角色分析: Security + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

分析對象: API 端點 /api/users

Security 分析結果:
認證: JWT 驗證實施得当
授權: 基于角色的訪問控制不完整
加密: API 密鑰在日誌中以明文輸出

評估分數: 65/100
重要度: High(因為訪問敏感數據)

Performance 分析結果:
響應時間: 平均 180ms(目標 200ms 以內)
數據庫查询: 檢測到 N+1 問題
緩存: Redis 緩存未實施

評估分數: 70/100
重要度: Medium(目前在可接受範圍內)

相互關聯分析:
協同效應機會:
- 實施 Redis 緩存時同時考虑加密
- 改進日誌輸出提升安全性和性能

權衡點:
- 加強授權檢查 ↔ 對響應時間的影響
- 日誌加密 ↔ 調試效率降低

综合優先級:
Critical: 修復 API 密鑰明文輸出
High: 解決 N+1 查询
Medium: 實施 Redis 緩存 + 加密
Low: 细化授權控制

實施路線圖:
第 1 週: 實施 API 密鑰屏蔽
第 2 週: 優化數據庫查询
第 3-4 週: 設計·實施緩存層
第 2 月: 逐步加強授權控制
```

### 3 角色分析的情况

```text
多角色分析: Frontend + Mobile + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

分析對象: 用戶資料界面

Frontend 分析結果:
可用性: 直觀的布局
可訪問性: WCAG 2.1 符合率 85%
響應式: 平板顯示有問題

Mobile 分析結果:
觸摸目標: 確保 44pt 以上
單手操作: 重要按钮在上方
離線支持: 未實施

Performance 分析結果:
初始顯示: LCP 2.1 秒 (良好)
圖像優化: 不支持 WebP
延遲加載: 未實施

综合建議:
1. 移動優化 (單手操作 + 離線支持)
2. 圖像優化 (WebP + 延遲加載)
3. 改進平板 UI

優先級: Mobile > Performance > Frontend
實施期間: 3-4 週
```

### 有效的組合模式

### 安全重視

```bash
/multi-role security,architect
"認證系統的設計"

/multi-role security,frontend
"登錄界面的安全性"

/multi-role security,mobile
"移動應用的數據保護"
```

### 性能重視

```bash
/multi-role performance,architect
"可擴展性設計"

/multi-role performance,frontend
"Web 页面高速化"

/multi-role performance,mobile
"應用運行優化"
```

### 用戶體驗重視

```bash
/multi-role frontend,mobile
"跨平台 UI"

/multi-role frontend,performance
"UX 與性能的平衡"

/multi-role mobile,performance
"移動 UX 優化"
```

### 全面分析

```bash
/multi-role architect,security,performance
"系統整體評估"

/multi-role frontend,mobile,performance
"用戶體驗综合評估"

/multi-role security,performance,mobile
"移動應用综合診斷"
```

### 與 Claude 的協作

```bash
# 結合文件分析
cat src/components/UserProfile.tsx
/multi-role frontend,mobile
"從多個視角評估這個組件"

# 設計文檔評估
cat architecture-design.md
/multi-role architect,security,performance
"從多個專業領域評估這個設計"

# 錯誤分析
cat performance-issues.log
/multi-role performance,analyzer
"多角度分析性能問題"
```

### multi-role vs role-debate 的使用區分

### 使用 multi-role 的場合

- 需要各專業領域的独立評估
- 想制定综合改進計劃
- 需要整理矛盾或重復
- 要決定實施優先級

### 使用 role-debate 的場合

- 專業領域間存在權衡
- 技術選型可能有分歧
- 想通過讨論決定設計方针
- 想听取不同視角的辩論

### 子代理並行執行 (--agent)

使用 `--agent` 選項時，各角色作為独立的子代理並行執行。

#### 自動委托的促進

当角色文件的 description 字段包含以下短語時，使用 `--agent` 會啟用更积极的自動委托：

- "use PROACTIVELY"
- "MUST BE USED"
- 其他強調表達

#### 執行流程

```text
常規執行:
角色 1 → 角色 2 → 角色 3 → 综合
(顺序執行，約 3-5 分鐘)

--agent 執行:
角色 1 ─┐
角色 2 ─┼→ 综合
角色 3 ─┘
(並行執行，約 1-2 分鐘)
```

#### 有效使用示例

```bash
# 大規模系統的综合評估
/multi-role architect,security,performance,qa --agent
"新系統的全面評估"

# 多視角的詳细分析
/multi-role frontend,mobile,performance --agent
"所有界面的 UX 優化分析"
```

#### 性能比较

| 角色數 | 常規執行 | --agent 執行 | 縮短率 |
| ------ | -------- | ------------ | ------ |
| 2 角色 | 2-3 分鐘 | 1 分鐘       | 50%    |
| 3 角色 | 3-5 分鐘 | 1-2 分鐘     | 60%    |
| 4 角色 | 5-8 分鐘 | 2-3 分鐘     | 65%    |

### 注意事項

- 同時執行 3 個以上角色時輸出會變长
- 復杂分析可能需要更长執行時間
- 出現相互矛盾的建議時，也可考虑 role-debate
- 最終判斷請參考综合結果由用戶決定
- **使用 --agent 時**: 會使用更多資源，但對大規模分析更高效

### 角色設定詳情

- 各角色的詳細設定、專業知識與討論特性都定義在 `.claude/agents/roles/` 目錄中
- 包含 Evidence-First 手法與認知偏差對策
- 角色專屬觸發語句會自動啟用特化模式
