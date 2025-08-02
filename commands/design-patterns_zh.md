## 设计模式

为代码库提供适用的设计模式建议，并评估SOLID原则的遵守情况。

### 使用方法

```bash
/design-patterns [分析对象] [选项]
```

### 选项

- `--suggest` : 建议适用的模式（默认）
- `--analyze` : 分析现有模式的使用情况
- `--refactor` : 生成重构方案
- `--solid` : 检查SOLID原则的遵守情况
- `--anti-patterns` : 检测反模式

### 基本示例

```bash
# 分析整个项目的模式
/design-patterns

# 为特定文件建议模式
/design-patterns src/services/user.js --suggest

# 检查SOLID原则
/design-patterns --solid

# 检测反模式
/design-patterns --anti-patterns
```

### 分析类别

#### 1. 创建型模式

- **工厂模式 (Factory Pattern)**: 对象创建的抽象化
- **建造者模式 (Builder Pattern)**: 复杂对象的逐步构建
- **单例模式 (Singleton Pattern)**: 保证实例的唯一性
- **原型模式 (Prototype Pattern)**: 对象的克隆创建

#### 2. 结构型模式

- **适配器模式 (Adapter Pattern)**: 接口转换
- **装饰器模式 (Decorator Pattern)**: 动态添加功能
- **外观模式 (Facade Pattern)**: 简化复杂子系统
- **代理模式 (Proxy Pattern)**: 控制对象访问

#### 3. 行为型模式

- **观察者模式 (Observer Pattern)**: 实现事件通知
- **策略模式 (Strategy Pattern)**: 算法切换
- **命令模式 (Command Pattern)**: 操作的封装
- **迭代器模式 (Iterator Pattern)**: 集合遍历

### SOLID原则检查项

```
S - 单一职责原则 (Single Responsibility Principle)
O - 开放封闭原则 (Open/Closed Principle)
L - 里氏替换原则 (Liskov Substitution Principle)
I - 接口隔离原则 (Interface Segregation Principle)
D - 依赖倒置原则 (Dependency Inversion Principle)
```

### 输出示例

```
设计模式分析报告
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

当前使用的模式
├─ 观察者模式: EventEmitter (12 处)
├─ 工厂模式: UserFactory (3 处)
├─ 单例模式: DatabaseConnection (1 处)
└─ 策略模式: PaymentProcessor (5 处)

推荐模式
├─ [高优先级] 仓储模式 (Repository Pattern)
│  └─ 适用对象: src/models/*.js
│  └─ 理由: 分离数据访问逻辑
│  └─ 示例:
│      class UserRepository {
│        async findById(id) { ... }
│        async save(user) { ... }
│      }
│
├─ [中优先级] 命令模式 (Command Pattern)
│  └─ 适用对象: src/api/handlers/*.js
│  └─ 理由: 统一请求处理
│
└─ [低优先级] 装饰器模式 (Decorator Pattern)
   └─ 适用对象: src/middleware/*.js
   └─ 理由: 改善功能组合

SOLID原则违反
├─ [S] UserService: 同时负责认证和权限管理
├─ [O] PaymentGateway: 添加新支付方式时需要修改
├─ [D] EmailService: 直接依赖具体类
└─ [I] IDataStore: 包含未使用的方法

重构建议
1. 将UserService拆分为认证和权限管理
2. 引入PaymentStrategy接口
3. 定义EmailService接口
4. 按用途分离IDataStore
```

### 高级使用示例

```bash
# 分析模式应用的影响
/design-patterns --impact-analysis Repository

# 生成特定模式的实现示例
/design-patterns --generate Factory --for src/models/Product.js

# 建议模式组合
/design-patterns --combine --context "带缓存的API"

# 评估架构模式
/design-patterns --architecture MVC
```

### 模式应用示例

#### 改进前（有问题的代码）

```javascript
class OrderService {
  processOrder(order, paymentType) {
    if (paymentType === "credit") {
      // 信用卡处理
    } else if (paymentType === "paypal") {
      // PayPal处理
    }
    // 其他支付方式...
  }
}
```

#### 改进后（应用策略模式）

```javascript
// 策略接口
class PaymentStrategy {
  process(amount) {
    throw new Error("必须实现process方法");
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

- **上帝对象 (God Object)**: 承担过多责任的类
- **意大利面代码 (Spaghetti Code)**: 控制流复杂交织的代码
- **复制粘贴编程 (Copy-Paste Programming)**: 过度使用重复代码
- **魔法数字 (Magic Numbers)**: 硬编码的常量
- **回调地狱 (Callback Hell)**: 深度嵌套的回调

### 最佳实践

1. **逐步应用**: 不要一次性应用过多模式
2. **验证必要性**: 模式是解决问题的手段而非目的
3. **团队共识**: 应用模式前与团队讨论
4. **文档化**: 记录应用模式的意图