## Refactor

安全で段階的なコードリファクタリングを実施し、SOLID 原則の遵守状況を評価します。

### 使い方

```bash
# 複雑なコードの特定とリファクタリング計画
find . -name "*.js" -exec wc -l {} + | sort -rn | head -10
「大きなファイルをリファクタリングして複雑度を削減してください」

# 重複コードの検出と統合
grep -r "function processUser" . --include="*.js"
「重複した関数を Extract Method で共通化してください」

# SOLID 原則違反の検出
grep -r "class.*Service" . --include="*.js" | head -10
「これらのクラスが単一責任の原則に従っているか評価してください」
```

### 基本例

```bash
# 長いメソッドの検出
grep -A 50 "function" src/*.js | grep -B 50 -A 50 "return" | wc -l
"50 行以上のメソッドを Extract Method で分割してください"

# 条件分岐の複雑度
grep -r "if.*if.*if" . --include="*.js"
"ネストした条件文を Strategy パターンで改善してください"

# コードの臭いの検出
grep -r "TODO\|FIXME\|HACK" . --exclude-dir=node_modules
"技術的負債となっているコメントを解決してください"
```

### リファクタリング技法

#### Extract Method（メソッド抽出）

```javascript
// Before: 長大なメソッド
function processOrder(order) {
  // 50 行の複雑な処理
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
// Before: switch 文
function getPrice(user) {
  switch (user.type) {
    case 'premium': return basPrice * 0.8;
    case 'regular': return basePrice;
  }
}

// After: Strategy パターン
class PremiumPricing {
  calculate(basePrice) { return basePrice * 0.8; }
}
```

### SOLID 原則チェック

```
S - Single Responsibility
├─ 各クラスが単一の責任を持つ
├─ 変更理由が 1 つに限定される
└─ 責任の境界が明確

O - Open/Closed
├─ 拡張に対して開かれている
├─ 修正に対して閉じている
└─ 新機能追加時の既存コード保護

L - Liskov Substitution
├─ 派生クラスの置換可能性
├─ 契約の遵守
└─ 期待される動作の維持

I - Interface Segregation
├─ 適切な粒度のインターフェース
├─ 使用しないメソッドへの依存回避
└─ 役割別インターフェース定義

D - Dependency Inversion
├─ 抽象への依存
├─ 具象実装からの分離
└─ 依存性注入の活用
```

### リファクタリング手順

1. **現状分析**
   - 複雑度測定（循環的複雑度）
   - 重複コード検出
   - 依存関係の分析

2. **段階的実行**
   - 小さなステップ（15-30 分単位）
   - 各変更後のテスト実行
   - 頻繁なコミット

3. **品質確認**
   - テストカバレッジ維持
   - パフォーマンス測定
   - コードレビュー

### よくあるコードの臭い

- **God Object**: 過度に多くの責務を持つクラス
- **Long Method**: 50 行を超える長いメソッド
- **Duplicate Code**: 同じロジックの重複
- **Large Class**: 300 行を超える大きなクラス
- **Long Parameter List**: 4 個以上のパラメータ

### 自動化支援

```bash
# 静的解析
npx complexity-report src/
sonar-scanner

# コードフォーマット
npm run lint:fix
prettier --write src/

# テスト実行
npm test
npm run test:coverage
```

### 注意事項

- **機能変更の禁止**: 外部動作を変えない
- **テストファースト**: リファクタリング前にテスト追加
- **段階的アプローチ**: 一度に大きな変更をしない
- **継続的検証**: 各ステップでのテスト実行
