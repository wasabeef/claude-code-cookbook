## Refactor

安全で段階的なコードリファクタリングを実施し、SOLID 原則の遵守状況を定量的に評価します。技術的負債を可視化し、改善の優先順位を明確にします。

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

#### Extract Method(メソッド抽出)

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
    case "premium":
      return basePrice * 0.8;
    case "regular":
      return basePrice;
  }
}

// After: Strategy パターン
class PremiumPricing {
  calculate(basePrice) {
    return basePrice * 0.8;
  }
}
```

### SOLID 原則スコアリング (0-100 点)

#### 評価基準と配点

```text
S - Single Responsibility(20 点)
├─ クラスの責任数: 1 個 (20 点) | 2 個 (15 点) | 3 個 (10 点) | 4 個以上 (5 点)
├─ メソッド数: <7 個 (+5 点) | 7-15 個 (+3 点) | >15 個 (0 点)
├─ 変更理由の明確性: 明確 (+5 点) | 曖昧 (0 点)
└─ スコア例: UserService(認証+データ処理) = 10 点

O - Open/Closed(20 点)
├─ 拡張ポイント: Strategy/Template Method(20 点) | 継承のみ (10 点) | なし (5 点)
├─ 新機能追加時の既存コード変更: 不要 (+5 点) | 最小限 (+3 点) | 必要 (0 点)
├─ インターフェース利用: 適切 (+5 点) | 部分的 (+3 点) | なし (0 点)
└─ スコア例: PaymentProcessor(Strategy) = 20 点

L - Liskov Substitution(20 点)
├─ 派生クラスの契約遵守: 完全 (20 点) | 部分的 (10 点) | 違反 (0 点)
├─ 事前条件の強化: なし (+5 点) | あり (-5 点)
├─ 事後条件の弱化: なし (+5 点) | あり (-5 点)
└─ スコア例: Square extends Rectangle = 0 点 (違反)

I - Interface Segregation(20 点)
├─ インターフェースサイズ: 1-3 メソッド (20 点) | 4-7(15 点) | 8+(5 点)
├─ 未使用メソッド実装: なし (+5 点) | 1-2 個 (+2 点) | 3 個以上 (0 点)
├─ 役割の明確性: 単一役割 (+5 点) | 複数役割 (0 点)
└─ スコア例: Readable/Writable 分離 = 20 点

D - Dependency Inversion(20 点)
├─ 依存方向: 抽象のみ (20 点) | 混在 (10 点) | 具象のみ (5 点)
├─ DI 利用: Constructor Injection(+5 点) | Setter(+3 点) | なし (0 点)
├─ テスタビリティ: Mock 可能 (+5 点) | 困難 (0 点)
└─ スコア例: Repository Pattern = 20 点

総合スコア = S + O + L + I + D
├─ 90-100 点: Excellent(SOLID 完全準拠)
├─ 70-89 点: Good(軽微な改善余地)
├─ 50-69 点: Fair(リファクタリング推奨)
├─ 30-49 点: Poor(大規模改善必要)
└─ 0-29 点: Critical(設計見直し必須)
```

### 技術的負債の定量化

#### 負債計算式

```text
技術的負債 (時間) = 複雑度スコア × 影響範囲 × 修正難易度

複雑度スコア:
├─ 循環的複雑度: 1-5(低) | 6-10(中) | 11-20(高) | 21+(危険)
├─ 認知的複雑度: ネスト深度 × 条件分岐数
├─ コード行数: <50(1 点) | 50-200(2 点) | 200-500(3 点) | 500+(5 点)
└─ 重複率: 0-10%(1 点) | 10-30%(2 点) | 30-50%(3 点) | 50%+(5 点)

影響範囲:
├─ 依存モジュール数: 直接依存 + 間接依存 × 0.5
├─ 利用頻度: API 呼び出し回数/日
├─ ビジネス重要度: Critical(×3) | High(×2) | Medium(×1) | Low(×0.5)
└─ チーム知識: 理解者 1 名 (×3) | 2-3 名 (×2) | 4 名以上 (×1)

修正難易度:
├─ テストカバレッジ: 0%(×3) | <50%(×2) | 50-80%(×1.5) | >80%(×1)
├─ ドキュメント: なし (×2) | 不十分 (×1.5) | 十分 (×1)
├─ 依存関係: 密結合 (×3) | 中程度 (×2) | 疎結合 (×1)
└─ 変更リスク: Breaking Change(×3) | 互換性考慮 (×2) | 安全 (×1)

コスト換算:
├─ 時間コスト: 負債時間 × 開発者時給
├─ 機会損失: 新機能開発遅延日数 × 日次売上影響
├─ 品質コスト: バグ発生確率 × 修正コスト × 発生頻度
└─ 総コスト: 時間 + 機会損失 + 品質コスト
```

#### 優先順位マトリクス

| 優先度                    | 影響度 | 修正コスト | 対応期限   | 具体例                               | 推奨アクション               |
| ------------------------- | ------ | ---------- | ---------- | ------------------------------------ | ---------------------------- |
| **Critical(即座対応)**    | 高     | 低         | 1 週間以内 | God Object、循環依存                 | 即座にリファクタリング開始   |
| **Important(計画的対応)** | 高     | 高         | 1 ヶ月以内 | 大規模な責務分離、アーキテクチャ変更 | スプリント計画に組み込み     |
| **Watch(監視対象)**       | 低     | 高         | 3 ヶ月以内 | 複雑度の高い内部処理                 | メトリクス監視、悪化時対応   |
| **Acceptable(許容範囲)**  | 低     | 低         | 対応不要   | 軽微なコードの臭い                   | 通常のリファクタリングで対応 |

### リファクタリング手順

1. **現状分析と測定**
   - 複雑度測定 (循環的・認知的)
   - SOLID スコア算出 (0-100 点)
   - 技術的負債の定量化 (時間/コスト)
   - 優先順位マトリクス作成

2. **段階的実行**
   - 小さなステップ (15-30 分単位)
   - 各変更後のテスト実行
   - 頻繁なコミット
   - SOLID スコアの継続測定

3. **品質確認**
   - テストカバレッジ維持
   - パフォーマンス測定
   - 技術的負債の削減確認
   - コードレビュー

### よくあるコードの臭いと負債スコア

| コードの臭い            | 検出基準                 | 負債スコア  | 改善手法                |
| ----------------------- | ------------------------ | ----------- | ----------------------- |
| **God Object**          | 責務 >3, メソッド >20    | 高 (15-20h) | Extract Class, SRP 適用 |
| **Long Method**         | 行数 >50, 複雑度 >10     | 中 (5-10h)  | Extract Method          |
| **Duplicate Code**      | 重複率 >30%              | 高 (10-15h) | Extract Method/Class    |
| **Large Class**         | 行数 >300, メソッド >15  | 高 (10-20h) | Extract Class           |
| **Long Parameter List** | パラメータ >4            | 低 (2-5h)   | Parameter Object        |
| **Feature Envy**        | 他クラス参照 >5          | 中 (5-10h)  | Move Method             |
| **Data Clumps**         | 同じ引数群の繰り返し     | 低 (3-5h)   | Extract Class           |
| **Primitive Obsession** | プリミティブ型の過度使用 | 中 (5-8h)   | Replace with Object     |
| **Switch Statements**   | case >5                  | 中 (5-10h)  | Strategy Pattern        |
| **Shotgun Surgery**     | 変更時の影響箇所 >3      | 高 (10-15h) | Move Method/Field       |

### 実践例：SOLID スコア評価

```javascript
// 評価対象: UserService クラス
class UserService {
  constructor(db, cache, logger, emailService) { // 4 つの依存
    this.db = db;
    this.cache = cache;
    this.logger = logger;
    this.emailService = emailService;
  }

  // 責務 1: 認証
  authenticate(username, password) { /* ... */ }
  refreshToken(token) { /* ... */ }

  // 責務 2: ユーザー管理
  createUser(data) { /* ... */ }
  updateUser(id, data) { /* ... */ }
  deleteUser(id) { /* ... */ }

  // 責務 3: 通知
  sendWelcomeEmail(user) { /* ... */ }
  sendPasswordReset(email) { /* ... */ }
}

// SOLID スコア評価結果
S: 10 点 (責務 3 つ: 認証、CRUD、通知)
O: 5 点 (拡張ポイントなし、直接実装)
L: 15 点 (継承なし、該当せず)
I: 10 点 (インターフェース未分離)
D: 10 点 (具象クラス依存)
総合: 50 点 (Fair - リファクタリング推奨)

// 技術的負債
複雑度: 15 (メソッド 7 個、責務 3 つ)
影響範囲: 8 (認証は全機能で使用)
修正難易度: 2 (テストあり、ドキュメント不足)
負債時間: 15 × 8 × 2 = 240 時間
優先度: Critical (認証系は即座対応)
```

### 改善後の実装例

```javascript
// SOLID 原則適用後 (スコア: 90 点)

// S: 単一責任 (20 点)
class AuthenticationService {
  authenticate(credentials) { /* ... */ }
  refreshToken(token) { /* ... */ }
}

// O: 開放閉鎖 (20 点)
class UserRepository {
  constructor(storage) { // Strategy Pattern
    this.storage = storage;
  }
  save(user) { return this.storage.save(user); }
}

// I: インターフェース分離 (20 点)
interface Readable {
  find(id);
  findAll();
}
interface Writable {
  save(entity);
  delete(id);
}

// D: 依存性逆転 (20 点)
class UserService {
  constructor(
    private auth: IAuthService,
    private repo: IUserRepository,
    private notifier: INotificationService
  ) {}
}

// 負債削減: 240 時間 → 20 時間 (92% 削減)
```

### 自動化支援

```bash
# SOLID スコア測定
npx solid-analyzer src/ --output report.json

# 複雑度分析
npx complexity-report src/ --format json
sonar-scanner -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info

# 技術的負債の可視化
npx code-debt-analyzer --config .debt.yml

# コードフォーマット
npm run lint:fix
prettier --write src/

# テスト実行とカバレッジ
npm test -- --coverage
npm run test:mutation  # 変異テスト
```

### 注意事項

- **機能変更の禁止**: 外部動作を変えない
- **テストファースト**: リファクタリング前にテスト追加
- **段階的アプローチ**: 一度に大きな変更をしない
- **継続的検証**: 各ステップでのテスト実行
