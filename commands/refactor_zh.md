## 重构

实施安全且逐步的代码重构，评估SOLID原则的遵守情况。

### 使用方法

```bash
# 识别复杂代码并制定重构计划
find . -name "*.js" -exec wc -l {} + | sort -rn | head -10
「请重构大文件以降低复杂度」

# 检测并整合重复代码
grep -r "function processUser" . --include="*.js"
「请使用Extract Method将重复函数抽象化」

# 检测SOLID原则违规
grep -r "class.*Service" . --include="*.js" | head -10
「请评估这些类是否遵循单一责任原则」
```

### 基本示例

```bash
# 检测长方法
grep -A 50 "function" src/*.js | grep -B 50 -A 50 "return" | wc -l
"请使用Extract Method拆分50行以上的方法"

# 条件分支复杂度
grep -r "if.*if.*if" . --include="*.js"
"请使用策略模式改进嵌套条件语句"

# 检测代码异味
grep -r "TODO\|FIXME\|HACK" . --exclude-dir=node_modules
"请解决成为技术债务的注释"
```

### 重构技巧

#### 提取方法（Extract Method）

```javascript
// 重构前: 冗长方法
function processOrder(order) {
  // 50行复杂处理
}

// 重构后: 责任分离
function processOrder(order) {
  validateOrder(order);
  calculateTotal(order);
  saveOrder(order);
}
```

#### 用多态替换条件语句

```javascript
// 重构前: switch语句
function getPrice(user) {
  switch (user.type) {
    case 'premium': return basePrice * 0.8;
    case 'regular': return basePrice;
  }
}

// 重构后: 策略模式
class PremiumPricing {
  calculate(basePrice) { return basePrice * 0.8; }
}
```

### SOLID原则检查

```
S - 单一责任原则
├─ 每个类承担单一责任
├─ 变更理由限定为1个
└─ 责任边界明确

O - 开放/封闭原则
├─ 对扩展开放
├─ 对修改封闭
└─ 新增功能时保护现有代码

L - 里氏替换原则
├─ 派生类的可替换性
├─ 契约遵守
└─ 维持预期行为

I - 接口隔离原则
├─ 适当粒度的接口
├─ 避免依赖未使用的方法
└─ 按角色定义接口

D - 依赖倒置原则
├─ 依赖抽象
├─ 与具体实现分离
└─ 利用依赖注入
```

### 重构步骤

1. **现状分析**
   - 复杂度测量（循环复杂度）
   - 重复代码检测
   - 依赖关系分析

2. **逐步执行**
   - 小步骤（15-30分钟单位）
   - 每次变更后执行测试
   - 频繁提交

3. **质量确认**
   - 维持测试覆盖率
   - 性能测量
   - 代码评审

### 常见代码异味

- **上帝对象（God Object）**: 承担过多职责的类
- **长方法（Long Method）**: 超过50行的长方法
- **重复代码（Duplicate Code）**: 相同逻辑的重复
- **大类（Large Class）**: 超过300行的大类
- **长参数列表（Long Parameter List）**: 4个以上参数

### 自动化支持

```bash
# 静态分析
npx complexity-report src/
sonar-scanner

# 代码格式化
npm run lint:fix
prettier --write src/

# 执行测试
npm test
npm run test:coverage
```

### 注意事项

- **禁止功能变更**: 不改变外部行为
- **测试优先**: 重构前添加测试
- **逐步方法**: 避免一次性大变更
- **持续验证**: 每个步骤执行测试
```