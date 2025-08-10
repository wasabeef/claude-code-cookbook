## 重构

实施安全且渐进式的代码重构，评估 SOLID 原则的遵守情况。

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

#### Extract Method（提取方法）

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

#### Replace Conditional with Polymorphism（多态替换条件）

```javascript
// Before: switch 语句
function getPrice(user) {
  switch (user.type) {
    case 'premium': return basPrice * 0.8;
    case 'regular': return basePrice;
  }
}

// After: Strategy 模式
class PremiumPricing {
  calculate(basePrice) { return basePrice * 0.8; }
}
```

### SOLID 原则检查

```
S - Single Responsibility（单一职责）
├─ 每个类具有单一职责
├─ 变更原因限定为一个
└─ 职责边界明确

O - Open/Closed（开闭原则）
├─ 对扩展开放
├─ 对修改关闭
└─ 添加新功能时保护现有代码

L - Liskov Substitution（里氏替换）
├─ 派生类的可替换性
├─ 契约遵守
└─ 维持期望的行为

I - Interface Segregation（接口隔离）
├─ 适当粒度的接口
├─ 避免依赖未使用的方法
└─ 按角色定义接口

D - Dependency Inversion（依赖倒置）
├─ 依赖抽象
├─ 与具体实现分离
└─ 利用依赖注入
```

### 重构步骤

1. **现状分析**
   - 复杂度测量（循环复杂度）
   - 重复代码检测
   - 依赖关系分析

2. **渐进式执行**
   - 小步骤（15-30 分钟单位）
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

### 注意事项

- **禁止功能变更**: 不改变外部行为
- **测试优先**: 重构前添加测试
- **渐进式方法**: 不要一次性大幅变更
- **持续验证**: 每步都执行测试
