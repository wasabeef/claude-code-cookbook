## 設計模式

提出可應用于代碼庫的設計模式，評估 SOLID 原則的遵守情况。

### 使用方法

```bash
/design-patterns [分析對象] [選項]
```

### 選項

- `--suggest` : 提出可應用的模式(默認)
- `--analyze` : 分析現有模式的使用情况
- `--refactor` : 生成重構方案
- `--solid` : 檢查 SOLID 原則的遵守情况
- `--anti-patterns` : 檢測反模式

### 基本示例

```bash
# 整個項目的模式分析
/design-patterns

# 對特定文件提出模式建議
/design-patterns src/services/user.js --suggest

# SOLID 原則檢查
/design-patterns --solid

# 反模式檢測
/design-patterns --anti-patterns
```

### 分析類別

#### 1. 創建型模式

- **Factory Pattern**: 對象創建的抽象化
- **Builder Pattern**: 復杂對象的分步構建
- **Singleton Pattern**: 保證實例的唯一性
- **Prototype Pattern**: 對象的克隆生成

#### 2. 結構型模式

- **Adapter Pattern**: 接口轉換
- **Decorator Pattern**: 動態添加功能
- **Facade Pattern**: 簡化復杂子系統
- **Proxy Pattern**: 對象訪問控制

#### 3. 行為型模式

- **Observer Pattern**: 事件通知的實現
- **Strategy Pattern**: 算法切換
- **Command Pattern**: 操作封裝
- **Iterator Pattern**: 集合遍歷

### SOLID 原則檢查項

```text
S - Single Responsibility Principle (單一职責原則)
O - Open/Closed Principle (開闭原則)
L - Liskov Substitution Principle (里氏替換原則)
I - Interface Segregation Principle (接口隔離原則)
D - Dependency Inversion Principle (依賴倒置原則)
```

### 輸出示例

```text
設計模式分析報告
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

當前使用的模式
├─ Observer Pattern: EventEmitter (12 處)
├─ Factory Pattern: UserFactory (3 處)
├─ Singleton Pattern: DatabaseConnection (1 處)
└─ Strategy Pattern: PaymentProcessor (5 處)

推薦模式
├─ [HIGH] Repository Pattern
│  └─ 對象: src/models/*.js
│  └─ 原因: 分離數據訪問邏輯
│  └─ 示例:
│      class UserRepository {
│        async findById(id) { ... }
│        async save(user) { ... }
│      }
│
├─ [MED] Command Pattern
│  └─ 對象: src/api/handlers/*.js
│  └─ 原因: 統一請求處理
│
└─ [LOW] Decorator Pattern
   └─ 對象: src/middleware/*.js
   └─ 原因: 改進功能組合

SOLID 原則违反
├─ [S] UserService: 同時負責認證和權限管理
├─ [O] PaymentGateway: 添加新支付方式需要修改
├─ [D] EmailService: 直接依賴具體類
└─ [I] IDataStore: 包含未使用的方法

重構建議
1. 將 UserService 拆分為認證和權限管理
2. 引入 PaymentStrategy 接口
3. 定義 EmailService 接口
4. 按用途拆分 IDataStore
```

### 高級用法

```bash
# 模式應用的影響分析
/design-patterns --impact-analysis Repository

# 生成特定模式的實現示例
/design-patterns --generate Factory --for src/models/Product.js

# 模式組合建議
/design-patterns --combine --context "带緩存的 API"

# 架構模式評估
/design-patterns --architecture MVC
```

### 模式應用示例

#### Before (有問題的代碼)

```javascript
class OrderService {
  processOrder(order, paymentType) {
    if (paymentType === "credit") {
      // 信用卡處理
    } else if (paymentType === "paypal") {
      // PayPal 處理
    }
    // 其他支付方式...
  }
}
```

#### After (應用 Strategy Pattern)

```javascript
// 策略接口
class PaymentStrategy {
  process(amount) {
    throw new Error("必须實現 process 方法");
  }
}

// 具體策略
class CreditCardPayment extends PaymentStrategy {
  process(amount) {
    /* 實現 */
  }
}

// 上下文
class OrderService {
  constructor(paymentStrategy) {
    this.paymentStrategy = paymentStrategy;
  }

  processOrder(order) {
    this.paymentStrategy.process(order.total);
  }
}
```

### 反模式檢測

- **God Object**: 承担過多职責的類
- **Spaghetti Code**: 控制流復杂纠缠的代碼
- **Copy-Paste Programming**: 過度使用重復代碼
- **Magic Numbers**: 硬編碼的常量
- **Callback Hell**: 深度嵌套的回調

### 最佳實践

1. **渐進式應用**: 不要一次應用太多模式
2. **必要性驗證**: 模式是解決問題的手段而非目的
3. **團隊共識**: 應用模式前團隊讨論
4. **文檔化**: 記錄應用模式的意圖
