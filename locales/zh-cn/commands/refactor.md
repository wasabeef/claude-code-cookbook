## 重构

实施安全且渐进式的代码重构，定量评估 SOLID 原则的遵守情况。将技术债务可视化，明确改进的优先级。

### 使用方法

```bash
# 识别复杂代码并制定重构计划
find . -name "*.js" -exec wc -l {} + | sort -rn | head -10
"重构大文件以降低复杂度"

# 检测并整合重复代码
grep -r "function processUser" . --include="*.js"
"通过 Extract Method 将重复函数共通化"

# 检测 SOLID 原则违反
grep -r "class.*Service" . --include="*.js" | head -10
"评估这些类是否遵循单一职责原则"
```

### 基本示例

```bash
# 检测长方法
grep -A 50 "function" src/*.js | grep -B 50 -A 50 "return" | wc -l
"用 Extract Method 拆分 50 行以上的方法"

# 条件分支的复杂度
grep -r "if.*if.*if" . --include="*.js"
"用 Strategy 模式改进嵌套的条件语句"

# 检测代码异味
grep -r "TODO\|FIXME\|HACK" . --exclude-dir=node_modules
"解决成为技术债务的注释"
```

### 重构技法

#### Extract Method(提取方法)

```javascript
// Before: 冗长的方法
function processOrder(order) {
  // 50 行复杂处理
}

// After: 职责分离
function processOrder(order) {
  validateOrder(order);
  calculateTotal(order);
  saveOrder(order);
}
```

#### Replace Conditional with Polymorphism(多态替换条件)

```javascript
// Before: switch 语句
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

### SOLID 原则评分 (0-100 分)

#### 评估标准与计分

```text
S - Single Responsibility(20 分)
├─ 类的职责数: 1 个 (20 分) | 2 个 (15 分) | 3 个 (10 分) | 4 个以上 (5 分)
├─ 方法数: <7 个 (+5 分) | 7-15 个 (+3 分) | >15 个 (0 分)
├─ 变更原因的明确性: 明确 (+5 分) | 模糊 (0 分)
└─ 评分例: UserService(认证+数据处理) = 10 分

O - Open/Closed(20 分)
├─ 扩展点: Strategy/Template Method(20 分) | 仅继承 (10 分) | 无 (5 分)
├─ 新功能添加时的现有代码变更: 不需要 (+5 分) | 最小限 (+3 分) | 需要 (0 分)
├─ 接口利用: 适当 (+5 分) | 部分 (+3 分) | 无 (0 分)
└─ 评分例: PaymentProcessor(Strategy) = 20 分

L - Liskov Substitution(20 分)
├─ 派生类的契约遵守: 完全 (20 分) | 部分 (10 分) | 违反 (0 分)
├─ 先决条件的加强: 无 (+5 分) | 有 (-5 分)
├─ 后决条件的弱化: 无 (+5 分) | 有 (-5 分)
└─ 评分例: Square extends Rectangle = 0 分 (违反)

I - Interface Segregation(20 分)
├─ 接口大小: 1-3 方法 (20 分) | 4-7(15 分) | 8+(5 分)
├─ 未使用方法实现: 无 (+5 分) | 1-2 个 (+2 分) | 3 个以上 (0 分)
├─ 角色的明确性: 单一角色 (+5 分) | 多个角色 (0 分)
└─ 评分例: Readable/Writable 分离 = 20 分

D - Dependency Inversion(20 分)
├─ 依赖方向: 仅抽象 (20 分) | 混合 (10 分) | 仅具象 (5 分)
├─ DI 利用: Constructor Injection(+5 分) | Setter(+3 分) | 无 (0 分)
├─ 可测试性: Mock 可能 (+5 分) | 困难 (0 分)
└─ 评分例: Repository Pattern = 20 分

总评分 = S + O + L + I + D
├─ 90-100 分: Excellent(SOLID 完全遵守)
├─ 70-89 分: Good(轻微改进余地)
├─ 50-69 分: Fair(重构建议)
├─ 30-49 分: Poor(大規模改进必要)
└─ 0-29 分: Critical(设计重新考虑必要)
```

### 重构步骤

1. **现状分析**
   - 复杂度测量 (循环复杂度)
   - 重复代码检测
   - 依赖关系分析

2. **渐进式执行**
   - 小步骤 (15-30 分钟单位)
   - 每次变更后执行测试
   - 频繁提交

3. **质量确认**
   - 维持测试覆盖率
   - 性能测量
   - 代码审查

### 常见的代码异味

- **God Object**: 承担过多职责的类
- **Long Method**: 超过 50 行的长方法
- **Duplicate Code**: 相同逻辑的重复
- **Large Class**: 超过 300 行的大类
- **Long Parameter List**: 4 个以上的参数

### 自动化支持

```bash
# 静态分析
npx complexity-report src/
sonar-scanner

# 代码格式化
npm run lint:fix
prettier --write src/

# 测试执行
npm test
npm run test:coverage
```

### 技术债务的定量化

#### 债务计算公式

```text
技术债务 (时间) = 复杂度评分 × 影响范围 × 修复难度

复杂度评分:
├─ 循环复杂度: 1-5(低) | 6-10(中) | 11-20(高) | 21+(危险)
├─ 认知复杂度: 嵌套深度 × 条件分支数
├─ 代码行数: <50(1 点) | 50-200(2 点) | 200-500(3 点) | 500+(5 点)
└─ 重复率: 0-10%(1 点) | 10-30%(2 点) | 30-50%(3 点) | 50%+(5 点)

影响范围:
├─ 依赖模块数: 直接依赖 + 间接依赖 × 0.5
├─ 使用频率: API 调用次数/日
├─ 业务重要度: Critical(×3) | High(×2) | Medium(×1) | Low(×0.5)
└─ 团队知识: 理解者 1 名 (×3) | 2-3 名 (×2) | 4 名以上 (×1)

修复难度:
├─ 测试覆盖率: 0%(×3) | <50%(×2) | 50-80%(×1.5) | >80%(×1)
├─ 文档: 无 (×2) | 不充分 (×1.5) | 充分 (×1)
├─ 依赖关系: 密耦合 (×3) | 中等 (×2) | 疏耦合 (×1)
└─ 变更风险: Breaking Change(×3) | 兼容性考虑 (×2) | 安全 (×1)

成本换算:
├─ 时间成本: 债务时间 × 开发者时薪
├─ 机会损失: 新功能开发延迟日数 × 日次销售影响
├─ 质量成本: 缺陷发生概率 × 修复成本 × 发生频率
└─ 总成本: 时间 + 机会损失 + 质量成本
```

#### 优先级矩阵

| 优先级                    | 影响度 | 修复成本 | 处理期限 | 具体例                   | 推荐行动             |
| ------------------------- | ------ | -------- | -------- | ------------------------ | -------------------- |
| **Critical(即座处理)**    | 高     | 低       | 1 周内   | God Object、循环依赖     | 即座重构开始         |
| **Important(计划性处理)** | 高     | 高       | 1 个月内 | 大规模职责分离、架构变更 | 纳入 Sprint 计划     |
| **Watch(监视对象)**       | 低     | 高       | 3 个月内 | 复杂度高的内部处理       | 指标监视、恶化时处理 |
| **Acceptable(容许范围)**  | 低     | 低       | 无需处理 | 轻微的代码异味           | 通常重构时处理       |

### 重构步骤

1. **现状分析和测量**
   - 复杂度测量 (循环、认知)
   - SOLID 评分计算 (0-100 分)
   - 技术债务定量化 (时间/成本)
   - 优先级矩阵创建

2. **渐进式执行**
   - 小步骤 (15-30 分钟单位)
   - 每次变更后测试执行
   - 频繁提交
   - SOLID 评分的持续测量

3. **质量确认**
   - 测试覆盖率维持
   - 性能测量
   - 技术债务删减确认
   - 代码审查

### 常见代码异味和债务评分

| 代码异味                | 检测标准             | 债务评分    | 改进手法                |
| ----------------------- | -------------------- | ----------- | ----------------------- |
| **God Object**          | 职责 >3, 方法 >20    | 高 (15-20h) | Extract Class, SRP 适用 |
| **Long Method**         | 行数 >50, 复杂度 >10 | 中 (5-10h)  | Extract Method          |
| **Duplicate Code**      | 重复率 >30%          | 高 (10-15h) | Extract Method/Class    |
| **Large Class**         | 行数 >300, 方法 >15  | 高 (10-20h) | Extract Class           |
| **Long Parameter List** | 参数 >4              | 低 (2-5h)   | Parameter Object        |
| **Feature Envy**        | 其他类引用 >5        | 中 (5-10h)  | Move Method             |
| **Data Clumps**         | 同一参数群重复       | 低 (3-5h)   | Extract Class           |
| **Primitive Obsession** | 原始类型过度使用     | 中 (5-8h)   | Replace with Object     |
| **Switch Statements**   | case >5              | 中 (5-10h)  | Strategy Pattern        |
| **Shotgun Surgery**     | 变更时影响位置 >3    | 高 (10-15h) | Move Method/Field       |

### 实践例: SOLID 评分评估

```javascript
// 评估对象: UserService 类
class UserService {
  constructor(db, cache, logger, emailService) { // 4 个依赖
    this.db = db;
    this.cache = cache;
    this.logger = logger;
    this.emailService = emailService;
  }

  // 职责 1: 认证
  authenticate(username, password) { /* ... */ }
  refreshToken(token) { /* ... */ }

  // 职责 2: 用户管理
  createUser(data) { /* ... */ }
  updateUser(id, data) { /* ... */ }
  deleteUser(id) { /* ... */ }

  // 职责 3: 通知
  sendWelcomeEmail(user) { /* ... */ }
  sendPasswordReset(email) { /* ... */ }
}

// SOLID 评分评估结果
S: 10 分 (职责 3 个: 认证、CRUD、通知)
O: 5 分 (无扩展点，直接实现)
L: 15 分 (无继承，不适用)
I: 10 分 (接口未分离)
D: 10 分 (具象类依赖)
总合: 50 分 (Fair - 重构建议)

// 技术债务
复杂度: 15 (方法 7 个，职责 3 个)
影响范围: 8 (认证系在全功能使用)
修复难度: 2 (有测试，文档不足)
债务时间: 15 × 8 × 2 = 240 小时
优先级: Critical (认证系应即座处理)
```

### 改进后实现例

```javascript
// SOLID 原则适用后 (评分: 90 分)

// S: 单一职责 (20 分)
class AuthenticationService {
  authenticate(credentials) { /* ... */ }
  refreshToken(token) { /* ... */ }
}

// O: 开放封闭 (20 分)
class UserRepository {
  constructor(storage) { // Strategy Pattern
    this.storage = storage;
  }
  save(user) { return this.storage.save(user); }
}

// I: 接口分离 (20 分)
interface Readable {
  find(id);
  findAll();
}
interface Writable {
  save(entity);
  delete(id);
}

// D: 依赖倒置 (20 分)
class UserService {
  constructor(
    private auth: IAuthService,
    private repo: IUserRepository,
    private notifier: INotificationService
  ) {}
}

// 债务删减: 240 小时 → 20 小时 (92% 删减)
```

### 注意事项

- **禁止功能变更**: 不改变外部行为
- **测试优先**: 重构前添加测试
- **渐进式方法**: 不要一次性大幅变更
- **持续验证**: 每步都执行测试
