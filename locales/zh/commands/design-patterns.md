## 设计模式

提出可应用于代码库的设计模式，评估 SOLID 原则的遵守情况。

### 使用方法

```bash
/design-patterns [分析对象] [选项]
```

### 选项

- `--suggest` : 提出可应用的模式（默认）
- `--analyze` : 分析现有模式的使用情况
- `--refactor` : 生成重构方案
- `--solid` : 检查 SOLID 原则的遵守情况
- `--anti-patterns` : 检测反模式

### 基本示例

```bash
# 整个项目的模式分析
/design-patterns

# 对特定文件提出模式建议
/design-patterns src/services/user.js --suggest

# SOLID 原则检查
/design-patterns --solid

# 反模式检测
/design-patterns --anti-patterns
```

### 分析类别

#### 1. 创建型模式

- **Factory Pattern**: 对象创建的抽象化
- **Builder Pattern**: 复杂对象的分步构建
- **Singleton Pattern**: 保证实例的唯一性
- **Prototype Pattern**: 对象的克隆生成

#### 2. 结构型模式

- **Adapter Pattern**: 接口转换
- **Decorator Pattern**: 动态添加功能
- **Facade Pattern**: 简化复杂子系统
- **Proxy Pattern**: 对象访问控制

#### 3. 行为型模式

- **Observer Pattern**: 事件通知的实现
- **Strategy Pattern**: 算法切换
- **Command Pattern**: 操作封装
- **Iterator Pattern**: 集合遍历

### SOLID 原则检查项

```
S - Single Responsibility Principle (单一职责原则)
O - Open/Closed Principle (开闭原则)
L - Liskov Substitution Principle (里氏替换原则)
I - Interface Segregation Principle (接口隔离原则)
D - Dependency Inversion Principle (依赖倒置原则)
```

### 输出示例

```
设计模式分析报告
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

当前使用的模式
├─ Observer Pattern: EventEmitter (12 处)
├─ Factory Pattern: UserFactory (3 处)
├─ Singleton Pattern: DatabaseConnection (1 处)
└─ Strategy Pattern: PaymentProcessor (5 处)

推荐模式
├─ [HIGH] Repository Pattern
│  └─ 对象: src/models/*.js
│  └─ 原因: 分离数据访问逻辑
│  └─ 示例:
│      class UserRepository {
│        async findById(id) { ... }
│        async save(user) { ... }
│      }
│
├─ [MED] Command Pattern
│  └─ 对象: src/api/handlers/*.js
│  └─ 原因: 统一请求处理
│
└─ [LOW] Decorator Pattern
   └─ 对象: src/middleware/*.js
   └─ 原因: 改进功能组合

SOLID 原则违反
├─ [S] UserService: 同时负责认证和权限管理
├─ [O] PaymentGateway: 添加新支付方式需要修改
├─ [D] EmailService: 直接依赖具体类
└─ [I] IDataStore: 包含未使用的方法

重构建议
1. 将 UserService 拆分为认证和权限管理
2. 引入 PaymentStrategy 接口
3. 定义 EmailService 接口
4. 按用途拆分 IDataStore
```

### 高级用法

```bash
# 模式应用的影响分析
/design-patterns --impact-analysis Repository

# 生成特定模式的实现示例
/design-patterns --generate Factory --for src/models/Product.js

# 模式组合建议
/design-patterns --combine --context "带缓存的 API"

# 架构模式评估
/design-patterns --architecture MVC
```

### 模式应用示例

#### Before (有问题的代码)

```javascript
class OrderService {
  processOrder(order, paymentType) {
    if (paymentType === "credit") {
      // 信用卡处理
    } else if (paymentType === "paypal") {
      // PayPal 处理
    }
    // 其他支付方式...
  }
}
```

#### After (应用 Strategy Pattern)

```javascript
// 策略接口
class PaymentStrategy {
  process(amount) {
    throw new Error("必须实现 process 方法");
  }
}

// 具体策略
class CreditCardPayment extends PaymentStrategy {
  process(amount) {
    /* 实现 */
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

### 反模式检测

- **God Object**: 承担过多职责的类
- **Spaghetti Code**: 控制流复杂纠缠的代码
- **Copy-Paste Programming**: 过度使用重复代码
- **Magic Numbers**: 硬编码的常量
- **Callback Hell**: 深度嵌套的回调

### 最佳实践

1. **渐进式应用**: 不要一次应用太多模式
2. **必要性验证**: 模式是解决问题的手段而非目的
3. **团队共识**: 应用模式前团队讨论
4. **文档化**: 记录应用模式的意图
