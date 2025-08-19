## 重構

實施安全且渐進式的代碼重構，評估 SOLID 原則的遵守情况。

### 使用方法

```bash
# 識別復杂代碼並制定重構計劃
find . -name "*.js" -exec wc -l {} + | sort -rn | head -10
"重構大文件以降低復杂度"

# 檢測並整合重復代碼
grep -r "function processUser" . --include="*.js"
"通過 Extract Method 將重復函數共通化"

# 檢測 SOLID 原則违反
grep -r "class.*Service" . --include="*.js" | head -10
"評估這些類是否遵循單一职責原則"
```

### 基本示例

```bash
# 檢測长方法
grep -A 50 "function" src/*.js | grep -B 50 -A 50 "return" | wc -l
"用 Extract Method 拆分 50 行以上的方法"

# 條件分支的復杂度
grep -r "if.*if.*if" . --include="*.js"
"用 Strategy 模式改進嵌套的條件語句"

# 檢測代碼異味
grep -r "TODO\|FIXME\|HACK" . --exclude-dir=node_modules
"解決成為技術债務的注釋"
```

### 重構技法

#### Extract Method（提取方法）

```javascript
// Before: 冗长的方法
function processOrder(order) {
  // 50 行復杂處理
}

// After: 职責分離
function processOrder(order) {
  validateOrder(order);
  calculateTotal(order);
  saveOrder(order);
}
```

#### Replace Conditional with Polymorphism（多態替換條件）

```javascript
// Before: switch 語句
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

### SOLID 原則檢查

```
S - Single Responsibility（單一职責）
├─ 每個類具有單一职責
├─ 變更原因限定為一個
└─ 职責邊界明確

O - Open/Closed（開闭原則）
├─ 對擴展開放
├─ 對修改關闭
└─ 添加新功能時保護現有代碼

L - Liskov Substitution（里氏替換）
├─ 派生類的可替換性
├─ 契約遵守
└─ 維持期望的行為

I - Interface Segregation（接口隔離）
├─ 適当粒度的接口
├─ 避免依賴未使用的方法
└─ 按角色定義接口

D - Dependency Inversion（依賴倒置）
├─ 依賴抽象
├─ 與具體實現分離
└─ 利用依賴注入
```

### 重構步骤

1. **現狀分析**
   - 復杂度測量（循環復杂度）
   - 重復代碼檢測
   - 依賴關系分析

2. **渐進式執行**
   - 小步骤（15-30 分鐘單位）
   - 每次變更後執行測試
   - 頻繁提交

3. **質量確認**
   - 維持測試覆蓋率
   - 性能測量
   - 代碼審查

### 常見的代碼異味

- **God Object**: 承担過多职責的類
- **Long Method**: 超過 50 行的长方法
- **Duplicate Code**: 相同邏輯的重復
- **Large Class**: 超過 300 行的大類
- **Long Parameter List**: 4 個以上的參數

### 自動化支持

```bash
# 靜態分析
npx complexity-report src/
sonar-scanner

# 代碼格式化
npm run lint:fix
prettier --write src/

# 測試執行
npm test
npm run test:coverage
```

### 注意事項

- **禁止功能變更**: 不改變外部行為
- **測試優先**: 重構前添加測試
- **渐進式方法**: 不要一次性大幅變更
- **持續驗證**: 每步都執行測試
