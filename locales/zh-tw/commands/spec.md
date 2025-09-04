## Spec

**「在編寫代碼之前赋予結構」** - 完全遵循 Kiro 的規格驅動開發

與傳統代碼生成工具不同，實現 Kiro 的規格驅動開發，重點是為開發的混沌赋予結構。從最少的需求輸入，逐步展開到產品經理級別的詳细規格和可實施的設計，**從原型到生產環境**保證一致的質量。

### 使用方法

```bash
# 請求 Claude 的 Spec Mode(最少需求輸入)
「創建[功能描述]的 spec」

# Kiro 式分阶段展開：
# 1. 簡單需求 → 自動生成詳细用戶故事
# 2. 使用 EARS 記法的結構化需求描述
# 3. 通過分阶段對話精细化規格
# 4. 生成 3 個独立文件：
#    - requirements.md: EARS 記法的需求定義
#    - design.md: 包含 Mermaid 圖、TypeScript 接口的設計
#    - tasks.md: 自動應用最佳實践的實施計劃
```

### 實證效果(Kiro 實績)

**2 天完成安全文件共享應用**

```bash
「創建文件共享系統(支持加密)的 spec」
→ 2 天完成生產級別的加密文件共享應用
→ 自動應用安全最佳實践
→ 無需额外提示
```

**新手一晚開發遊戲**

```bash
「創建 2D 益智遊戲的 spec」
→ 遊戲開發新手的開源開發者
→ 一晚完成遊戲創建
→ 實現邏輯由 Kiro 處理，開發者專注創造性
```

**週末從原型到生產**

```bash
「創建電商網站商品管理系統的 spec」
→ 一個週末從概念到可運行的原型
→ 從原型到生產環境的一致質量
→ 通過 spec-driven development 的結構化方法
```

### 基本示例

```bash
# 新功能的 spec 創建(最少輸入)
「商品評論系統
- 星級評分功能
- 評論發布
- 圖片上傳」

# 系統功能的 spec 創建
「用戶認證
- OAuth 支持
- 多因素認證」

# API 功能的 spec 創建
「支付系統 API
- Stripe 集成
- 重視安全性」
```

### 與 Claude 配合

```bash
# 復杂功能 spec
「創建聊天功能的 spec。包括 WebSocket、實時通知、歷史管理」

# 數據庫關聯功能 spec
「創建電商網站庫存管理功能的 spec。包括商品添加、庫存更新、警報功能」

# 前端功能 spec
「創建 React 儀表板的 spec。包括圖表顯示、筛選器、導出功能」

# 後端功能 spec
「創建 RESTful API 的 spec。包括認證、驗證、日誌記錄」
```

### Spec Mode 的特點

**分阶段對話工作流**

- 完全再現 Kiro 的核心價值——分阶段讨論
- 在各阶段與用戶合作精细化規格
- 經過疑問解決、選項讨論、批準流程後生成文件

**3 阶段的交互式展開**

- **Phase 1**: Requirements Discovery → 讨論 → 批準 → 生成 `requirements.md`
- **Phase 2**: Design Exploration → 讨論 → 批準 → 生成 `design.md`
- **Phase 3**: Implementation Planning → 讨論 → 批準 → 生成 `tasks.md`

**動態規格制定**

- 通過對話解決需求的模糊性
- 提示和讨論技術選項
- 說明權衡並確認判斷

### 詳细示例

```bash
# 復杂系統功能
「創建在線支付系統的 spec。包括 Stripe 集成、安全性、錯誤處理」

# 前端功能
「創建 React 組件的 spec。包括狀態管理、属性設計、測試」

# 後端功能
「創建 GraphQL API 的 spec。包括 Schema 設計、解析器、認證」

# DevOps 功能
「創建 CI/CD 管道的 spec。包括測試自動化、部署、監控」
```

### 分阶段對話工作流(Phase by Phase)

#### Phase 1: Requirements Discovery & Discussion

**1. 從最少輸入自動擴展(Kiro 式)**

```
用戶：「用戶管理系統
- 登錄功能
- 個人資料編輯
- 管理员權限」

Claude：「從需求生成詳细用戶故事。
這個理解正確吗？

自動生成的用戶故事：
- 用戶注冊和認證功能(支持 OAuth)
- 個人資料管理功能(头像、設置)
- 權限管理功能(RBAC)
- 密碼重置功能
- 安全審計日誌

已補充未明確的细节。還需要其他功能吗？」
```

**2. 使用 EARS 記法的結構化需求描述**

```
Claude：「使用 Kiro 的 EARS 記法結構化需求：

EARS 記法需求定義：

WHEN 用戶尝試登錄時
GIVEN 輸入正確的郵箱和密碼
THEN 系統確認認證
AND 成功時重定向到儀表板

WHILE 用戶在個人資料編輯页面時
THE SYSTEM SHALL 實時執行驗證
AND 預覽顯示更改內容

WHERE 需要管理员權限的功能
IS 尝試訪問時
THE SYSTEM SHALL 確認權限級別
AND 不足時拒绝訪問」
```

**3. 邊緣情况和安全需求的自動補充**

```
Claude：「基于 Kiro 的最佳實践，還考虑了以下情况：

安全需求(自動補充)：
- 暴力攻擊對策
- 會話管理和超時
- CSRF 保護和 XSS 對策
- 密碼強度要求

邊緣情况(自動檢測)：
- 同時登錄限制
- 账戶鎖定功能
- 數據遷移時的一致性保證
- 大量請求時的負載均衡

這些需求合適吗？」
```

**5. Phase 1 完成和批準**

```
Claude：「Requirements Phase 已完成。
可以生成 requirements.md 吗？」
→ 「繼續」→ 生成 requirements.md
```

#### Phase 2: Design Exploration & Discussion

**1. 代碼庫分析 + 自動設計建議(Kiro 式)**

```
Claude：「分析現有代碼庫，提出最佳架構：

代碼庫分析結果：
- 認證：JWT + Express.js(v4.18.x)
- 數據庫：PostgreSQL(v14+)
- 前端：React + TypeScript(v18+)
- 現有模式：Repository 模式、Service 層分離

Kiro 推薦架構：
- 符合 Clean Architecture
- Domain-Driven Design 元素
- 部分應用 CQRS 模式
- 自動化的安全最佳實践

使用這個設計吗？」
```

**2. 使用 Mermaid 圖的可視化設計**

```text
Claude：「自動生成系統設計的 Mermaid 圖：

自動生成的架構圖：

graph TB
    Client[React Client] --> API[Express API Gateway]
    API --> Auth[Auth Service]
    API --> User[User Service]
    API --> Profile[Profile Service]

    Auth --> AuthDB[(Auth Database)]
    User --> UserDB[(User Database)]
    Profile --> ProfileDB[(Profile Database)]

    Auth --> JWT[JWT Service]
    Auth --> OAuth[OAuth Provider]

還需要生成數據流圖吗？」
```

**3. TypeScript 接口自動生成**

```text
Claude：「基于設計自動生成 TypeScript 接口：

自動生成的 TypeScript 接口：

// Domain entities
interface User {
  readonly id: UserId;
  readonly email: Email;
  readonly profile: UserProfile;
  readonly auth: AuthSettings;
  readonly permissions: Permission[];
  readonly createdAt: Date;
  readonly updatedAt: Date;
}

interface UserProfile {
  readonly displayName: string;
  readonly avatar: AvatarUrl;
  readonly preferences: UserPreferences;
}

interface AuthSettings {
  readonly passwordHash: PasswordHash;
  readonly mfaEnabled: boolean;
  readonly lastLoginAt: Date;
  readonly failedAttempts: number;
}

// Use cases
interface UserRepository {
  findById(id: UserId): Promise<User | null>;
  findByEmail(email: Email): Promise<User | null>;
  save(user: User): Promise<void>;
}

interface AuthenticationService {
  authenticate(credentials: LoginCredentials): Promise<AuthResult>;
  refreshToken(token: RefreshToken): Promise<AccessToken>;
}

使用這個接口設計吗？」
```

**4. Phase 2 完成和批準**

```

Claude：「Design Phase 已完成。
可以生成 design.md 吗？」
→ 「繼續」→ 生成 design.md

```

#### Phase 3: Implementation Planning & Discussion

**1. 最佳實践自動應用(Kiro 式)**

```

Claude：「生成了自動應用 Kiro 最佳實践的實施計劃：

自動生成的實施策略：

1. 安全第一開發
   - 自動集成 OWASP Top 10 對策
   - 自動實現加密和哈希
   - 自動生成安全測試

2. 強制清洁架構
   - 自動實現層分離
   - 自動應用依賴倒置
   - 強制可測試設計

3. 性能優化
   - 自動實現緩存策略
   - 數據庫優化
   - 利用異步處理

使用這個方法吗？」

```

**2. 質量檢查點自動設置**

```

Claude：「自動設置各實施阶段的質量檢查點：

自動質量保證流程：

Phase 3a: 後端實施

- [ ] 安全掃描(SAST/DAST)
- [ ] API 規範測試(OpenAPI 合規)
- [ ] 性能測試(負載和響應)
- [ ] 漏洞掃描(依賴關系和 CVE)

Phase 3b: 前端實施

- [ ] 無障礙測試(WCAG 2.1 AA)
- [ ] 瀏覽器兼容性測試
- [ ] 響應式設計驗證
- [ ] 安全头確認

Phase 3c: 集成和部署

- [ ] E2E 測試套件
- [ ] CI/CD 管道配置
- [ ] 監控和日誌設置
- [ ] 生產環境安全審計

全部自動執行。有额外的質量標準吗？」

```

**3. 依賴關系和風險緩解的自動分析**

```

Claude：「自動分析實施顺序和風險緩解策略：

優化的實施顺序：

Week 1: 基礎設施和安全基礎

- 數據庫設計和模式創建
- 認證基礎(JWT + 會話管理)
- 安全中間件實施
- 基本 API 端點

Week 2: 核心功能實施

- 用戶管理功能
- 個人資料管理功能
- 權限管理系統
- 驗證和錯誤處理

Week 3: 高級功能和優化

- 多因素認證實施
- 審計日誌功能
- 性能優化
- 前端集成

自動檢測的風險緩解策略：

- 多因素認證：分阶段引入(SMS→應用認證)
- 會話管理：Redis 集群配置
- 大量訪問：速率限制 + CDN 利用
- 數據一致性：加強事務管理

這個計劃没有問題吗？」

```

**4. Phase 3 完成和批準**

```

Claude：「Implementation Planning Phase 已完成。
可以生成 tasks.md 吗？」
→ 「繼續」→ 生成 tasks.md

```

### Kiro 特有的功能

**EARS 記法 (Easy Approach to Requirements Syntax)**

```text
# Kiro 標準的 EARS 記法模式

WHEN [情况・觸發器]
GIVEN [前提條件]
THEN [系統行為]
AND [额外行為]

WHILE [狀態・流程]
THE SYSTEM SHALL [必须行為]
AND [相關行為]

WHERE [功能・組件]
IS [條件・狀態]
THE SYSTEM SHALL [對應行為]
```

**自動生成功能**

- **Mermaid 圖**: 自動生成架構和數據流圖
- **TypeScript 接口**: 基于設計自動創建類型定義
- **最佳實践**: 自動集成安全和性能對策
- **質量檢查點**: 自動設置分阶段質量標準

**hooks 聯動**

- 文件保存時的自動質量檢查
- 自動應用代碼標準
- 自動執行安全掃描
- 自動驗證 OWASP Top 10 對策

**原型→生產質量保證**

- 通過結構化方法的一致設計
- 強制安全第一開發
- 自動應用可擴展架構
- 集成持續質量管理

### 注意事項

**適用範圍**

- Spec Mode 最適合功能實施
- 簡單修復或小規模更改使用常規實施形式
- 推薦用于新功能開發或復杂功能改造

**質量保證**

- 明確各阶段的完成標準
- 實施前的設計審查
- 包括測試和無障礙的全面質量標準

**執行注意事項**

- 解決需求的模糊性後再進入設計阶段
- 設計完成後生成實施任務
- 重視各阶段的批準流程

### 觸發短語和控制

#### 分阶段工作流控制

**開始觸發器**

- 「創建[功能名]的 spec」
- 「想用 spec 驅動開發[功能名]」
- 「從規格書設計[功能名]」

**阶段進度控制**

- **「繼續」**: 完成當前阶段並生成文件，進入下一阶段
- **「修改」**: 在當前阶段內調整和改進內容
- **「重做」**: 從头開始當前阶段
- **「詳细說明」**: 提供更詳细的說明或選項
- **「跳過」**: 跳過當前阶段進入下一個(不推薦)

**文件生成時機**

```
Phase 1 完成 → 「繼續」 → 生成 requirements.md
Phase 2 完成 → 「繼續」 → 生成 design.md
Phase 3 完成 → 「繼續」 → 生成 tasks.md
```

### 執行示例(分阶段流程)

```bash
# 使用示例
用戶：「創建用戶管理系統的 spec」

# Phase 1: Requirements Discovery
Claude: [開始需求確認和讨論]
用戶: [響應・讨論・修改]
Claude: 「Requirements Phase 已完成。可以繼續吗？」
用戶: 「繼續」
→ 生成 requirements.md

# Phase 2: Design Exploration
Claude: [開始設計提案和讨論]
用戶: [技術選擇・架構讨論]
Claude: 「Design Phase 已完成。可以繼續吗？」
用戶: 「繼續」
→ 生成 design.md

# Phase 3: Implementation Planning
Claude: [開始實施計劃讨論]
用戶: [優先級・風險・工時讨論]
Claude: 「Implementation Phase 已完成。可以繼續吗？」
用戶: 「繼續」
→ 生成 tasks.md

# 完成
Claude: 「spec 驅動開發的準備已完成。可以開始實施。」
```

### 與 /plan 的區別

| 特徵     | /plan            | /spec                                              |
| -------- | ---------------- | -------------------------------------------------- |
| 對象     | 一般實施計劃     | 功能規格驅動開發                                   |
| 輸出格式 | 單一計劃文檔     | 3 個独立文件(requirements.md、design.md、tasks.md) |
| 需求定義 | 基本需求整理     | 使用 EARS 記法的詳细驗收標準                       |
| 設計     | 以技術選型為中心 | 基于代碼庫分析                                     |
| 實施     | 一般任務分解     | 考虑依賴關系的序列                                 |
| 質量保證 | 基本測試策略     | 全面質量要求(測試、無障礙、性能)                   |
| 同步     | 靜態計劃         | 動態 spec 更新                                     |

### 推薦用例

**推薦使用 spec**

- 新功能開發
- 復杂功能改造
- API 設計
- 數據庫設計
- UI/UX 實施

**推薦使用 plan**

- 系統整體設計
- 基礎設施構建
- 重構
- 技術選型
- 架構變更
