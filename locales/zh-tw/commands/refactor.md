## Refactor

實施安全且漸進式的代碼重構，定量評估 SOLID 原則的遵守狀況。可視化技術債務，明確改善優先級。

### 使用方法

```bash
# 複雜代碼的識別和重構計劃
find . -name "*.js" -exec wc -l {} + | sort -rn | head -10
「請重構大檔案以減少複雜度」

# 重複代碼的檢測與整合
grep -r "function processUser" . --include="*.js"
「請用 Extract Method 整合重複的函數」

# SOLID 原則違反的檢測
grep -r "class.*Service" . --include="*.js" | head -10
「請評估這些類是否遵循單一責任原則」
```

### 基本範例

```bash
# 長方法的檢測
grep -A 50 "function" src/*.js | grep -B 50 -A 50 "return" | wc -l
"請用 Extract Method 分割 50 行以上的方法"

# 條件分支的複雜度
grep -r "if.*if.*if" . --include="*.js"
"請用 Strategy 模式改善巢狀條件語句"

# 代碼異味的檢測
grep -r "TODO\|FIXME\|HACK" . --exclude-dir=node_modules
"請解決成為技術債務的註釋"
```

### 重構技法

#### Extract Method(方法提取)

```javascript
// Before: 冗長的方法
function processOrder(order) {
  // 50 行的複雜處理
}

// After: 責任分離
function processOrder(order) {
  validateOrder(order);
  calculateTotal(order);
  saveOrder(order);
}
```

#### Replace Conditional with Polymorphism

```javascript
// Before: switch 語句
function getPrice(user) {
  switch (user.type) {
    case "premium":
      return basePrice * 0.8;
    case "regular":
      return basePrice;
  }
}

// After: Strategy 模式
class PremiumPricing {
  calculate(basePrice) {
    return basePrice * 0.8;
  }
}
```

### SOLID 原則評分(0-100 分)

#### 評估標準與配分

```text
S - Single Responsibility(20 分)
├─ 類的責任數: 1 個(20 分) | 2 個(15 分) | 3 個(10 分) | 4 個以上(5 分)
├─ 方法數: <7 個(+5 分) | 7-15 個(+3 分) | >15 個(0 分)
├─ 變更理由的明確性: 明確(+5 分) | 模糊(0 分)
└─ 分數例: UserService(認證+資料處理) = 10 分

O - Open/Closed(20 分)
├─ 擴展點: Strategy/Template Method(20 分) | 僅繼承(10 分) | 無(5 分)
├─ 新功能添加時的既有代碼變更: 不必要(+5 分) | 最小化(+3 分) | 必要(0 分)
├─ 介面利用: 適當(+5 分) | 部分(+3 分) | 無(0 分)
└─ 分數例: PaymentProcessor(Strategy) = 20 分

L - Liskov Substitution(20 分)
├─ 衍生類的契約遵守: 完全(20 分) | 部分(10 分) | 違反(0 分)
├─ 前置條件的強化: 無(+5 分) | 有(-5 分)
├─ 後置條件的弱化: 無(+5 分) | 有(-5 分)
└─ 分數例: Square extends Rectangle = 0 分(違反)

I - Interface Segregation(20 分)
├─ 介面大小: 1-3 方法(20 分) | 4-7(15 分) | 8+(5 分)
├─ 未使用方法實現: 無(+5 分) | 1-2 個(+2 分) | 3 個以上(0 分)
├─ 角色的明確性: 單一角色(+5 分) | 多重角色(0 分)
└─ 分數例: Readable/Writable 分離 = 20 分

D - Dependency Inversion(20 分)
├─ 依賴方向: 僅抽象(20 分) | 混合(10 分) | 僅具象(5 分)
├─ DI 利用: Constructor Injection(+5 分) | Setter(+3 分) | 無(0 分)
├─ 可測試性: Mock 可能(+5 分) | 困難(0 分)
└─ 分數例: Repository Pattern = 20 分

總分 = S + O + L + I + D
├─ 90-100 分: Excellent(SOLID 完全遵循)
├─ 70-89 分: Good(輕微改善空間)
├─ 50-69 分: Fair(建議重構)
├─ 30-49 分: Poor(大規模改善必要)
└─ 0-29 分: Critical(設計重新檢討必須)
```

### 技術債務的定量化

#### 債務計算公式

```text
技術債務(時間) = 複雜度分數 × 影響範圍 × 修正難度

複雜度分數:
├─ 循環複雜度: 1-5(低) | 6-10(中) | 11-20(高) | 21+(危險)
├─ 認知複雜度: 巢狀深度 × 條件分支數
├─ 代碼行數: <50(1 分) | 50-200(2 分) | 200-500(3 分) | 500+(5 分)
└─ 重複率: 0-10%(1 分) | 10-30%(2 分) | 30-50%(3 分) | 50%+(5 分)

影響範圍:
├─ 依賴模組數: 直接依賴 + 間接依賴 × 0.5
├─ 使用頻率: API 呼叫次數/日
├─ 業務重要度: Critical(×3) | High(×2) | Medium(×1) | Low(×0.5)
└─ 團隊知識: 理解者 1 名(×3) | 2-3 名(×2) | 4 名以上(×1)

修正難度:
├─ 測試覆蓋率: 0%(×3) | <50%(×2) | 50-80%(×1.5) | >80%(×1)
├─ 文件: 無(×2) | 不充分(×1.5) | 充分(×1)
├─ 依賴關係: 緊耦合(×3) | 中度(×2) | 鬆耦合(×1)
└─ 變更風險: Breaking Change(×3) | 相容性考慮(×2) | 安全(×1)

成本換算:
├─ 時間成本: 債務時間 × 開發者時薪
├─ 機會損失: 新功能開發延遲日數 × 日營收影響
├─ 品質成本: Bug 發生機率 × 修正成本 × 發生頻率
└─ 總成本: 時間 + 機會損失 + 品質成本
```

#### 優先級矩陣

| 優先級                    | 影響度 | 修正成本 | 回應期限 | 具體例                   | 建議行動             |
| ------------------------- | ------ | -------- | -------- | ------------------------ | -------------------- |
| **Critical(即刻回應)**    | 高     | 低       | 1 週內   | God Object、循環依賴     | 立即開始重構         |
| **Important(計劃性回應)** | 高     | 高       | 1 個月內 | 大規模責任分離、架構變更 | 納入 Sprint 計劃     |
| **Watch(監視對象)**       | 低     | 高       | 3 個月內 | 複雜度高的內部處理       | 指標監視、惡化時回應 |
| **Acceptable(容許範圍)**  | 低     | 低       | 不必要   | 輕微的代碼異味           | 通常重構處理         |

### 重構程序

1. **現況分析與測量**
   - 複雜度測量(循環・認知)
   - SOLID 分數計算(0-100 分)
   - 技術債務的定量化(時間/成本)
   - 優先級矩陣製作

2. **階段性執行**
   - 小步驟(15-30 分鐘單位)
   - 各變更後的測試執行
   - 頻繁的提交
   - SOLID 分數的持續測量

3. **品質確認**
   - 測試覆蓋率維持
   - 效能測量
   - 技術債務削減確認
   - 代碼審查

### 常見代碼異味與債務分數

| 代碼異味                | 檢測標準             | 債務分數    | 改善技法                |
| ----------------------- | -------------------- | ----------- | ----------------------- |
| **God Object**          | 責任 >3, 方法 >20    | 高 (15-20h) | Extract Class, SRP 適用 |
| **Long Method**         | 行數 >50, 複雜度 >10 | 中 (5-10h)  | Extract Method          |
| **Duplicate Code**      | 重複率 >30%          | 高 (10-15h) | Extract Method/Class    |
| **Large Class**         | 行數 >300, 方法 >15  | 高 (10-20h) | Extract Class           |
| **Long Parameter List** | 參數 >4              | 低 (2-5h)   | Parameter Object        |
| **Feature Envy**        | 其他類參照 >5        | 中 (5-10h)  | Move Method             |
| **Data Clumps**         | 相同參數群的重複     | 低 (3-5h)   | Extract Class           |
| **Primitive Obsession** | 基本型別的過度使用   | 中 (5-8h)   | Replace with Object     |
| **Switch Statements**   | case >5              | 中 (5-10h)  | Strategy Pattern        |
| **Shotgun Surgery**     | 變更時的影響處 >3    | 高 (10-15h) | Move Method/Field       |

### 實踐例：SOLID 分數評估

```javascript
// 評估對象: UserService 類
class UserService {
  constructor(db, cache, logger, emailService) { // 4 個依賴
    this.db = db;
    this.cache = cache;
    this.logger = logger;
    this.emailService = emailService;
  }

  // 責任 1: 認證
  authenticate(username, password) { /* ... */ }
  refreshToken(token) { /* ... */ }

  // 責任 2: 用戶管理
  createUser(data) { /* ... */ }
  updateUser(id, data) { /* ... */ }
  deleteUser(id) { /* ... */ }

  // 責任 3: 通知
  sendWelcomeEmail(user) { /* ... */ }
  sendPasswordReset(email) { /* ... */ }
}

// SOLID 分數評估結果
S: 10 分 (責任 3 個: 認證、CRUD、通知)
O: 5 分 (無擴展點、直接實現)
L: 15 分 (無繼承、不適用)
I: 10 分 (介面未分離)
D: 10 分 (具象類依賴)
總計: 50 分 (Fair - 建議重構)

// 技術債務
複雜度: 15 (方法 7 個、責任 3 個)
影響範圍: 8 (認證在全功能中使用)
修正難度: 2 (有測試、文件不足)
債務時間: 15 × 8 × 2 = 240 小時
優先級: Critical (認證系統需即刻回應)
```

### 改善後的實現例

```javascript
// SOLID 原則適用後 (分數: 90 分)

// S: 單一責任 (20 分)
class AuthenticationService {
  authenticate(credentials) { /* ... */ }
  refreshToken(token) { /* ... */ }
}

// O: 開放封閉 (20 分)
class UserRepository {
  constructor(storage) { // Strategy Pattern
    this.storage = storage;
  }
  save(user) { return this.storage.save(user); }
}

// I: 介面分離 (20 分)
interface Readable {
  find(id);
  findAll();
}
interface Writable {
  save(entity);
  delete(id);
}

// D: 依賴反轉 (20 分)
class UserService {
  constructor(
    private auth: IAuthService,
    private repo: IUserRepository,
    private notifier: INotificationService
  ) {}
}

// 債務削減: 240 小時 → 20 小時 (削減 92%)
```

### 自動化支援

```bash
# SOLID 分數測量
npx solid-analyzer src/ --output report.json

# 複雜度分析
npx complexity-report src/ --format json
sonar-scanner -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info

# 技術債務的可視化
npx code-debt-analyzer --config .debt.yml

# 代碼格式化
npm run lint:fix
prettier --write src/

# 測試執行和覆蓋率
npm test -- --coverage
npm run test:mutation  # 變異測試
```

### 注意事項

- **功能變更的禁止**: 不改變外部行為
- **測試優先**: 重構前追加測試
- **階段性方法**: 不一次做大的變更
- **持續驗證**: 各步驟的測試執行
