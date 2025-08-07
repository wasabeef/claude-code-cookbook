## Analyze Performance

アプリケーションのパフォーマンス問題を分析し、技術的負債の観点から改善策を提案します。

### 使い方

```bash
# パフォーマンス問題の包括的分析
find . -name "*.js" -o -name "*.ts" | xargs wc -l | sort -rn | head -10
「大きなファイルとパフォーマンス問題を特定して改善案を提示して」

# 非効率なコードパターンの検出
grep -r "for.*await\|forEach.*await" . --include="*.js"
「N+1 クエリ問題とパフォーマンスボトルネックを分析して」

# メモリリークの可能性
grep -r "addEventListener\|setInterval" . --include="*.js" | grep -v "removeEventListener\|clearInterval"
「メモリリークのリスクと対策を評価して」
```

### 基本例

```bash
# バンドルサイズとロード時間
npm ls --depth=0 && find ./public -name "*.js" -o -name "*.css" | xargs ls -lh
"バンドルサイズとアセット最適化の改善点を特定して"

# データベースパフォーマンス
grep -r "SELECT\|findAll\|query" . --include="*.js" | head -20
"データベースクエリの最適化ポイントを分析して"

# 依存関係のパフォーマンス影響
npm outdated && npm audit
"古い依存関係がパフォーマンスに与える影響を評価して"
```

### 分析観点

#### 1. コードレベルの問題

- **O(n²) アルゴリズム**: 非効率な配列操作の検出
- **同期 I/O**: ブロッキング処理の特定
- **重複処理**: 不要な計算やリクエストの削除
- **メモリリーク**: イベントリスナーやタイマーの管理

#### 2. アーキテクチャレベルの問題

- **N+1 クエリ**: データベースアクセスパターン
- **キャッシュ不足**: 繰り返し計算や API 呼び出し
- **バンドルサイズ**: 不要なライブラリやコード分割
- **リソース管理**: 接続プールやスレッド使用量

#### 3. 技術的負債による影響

- **レガシーコード**: 古い実装による性能劣化
- **設計の問題**: 責任分散不足による結合度の高さ
- **テスト不足**: パフォーマンス回帰の検出漏れ
- **監視不足**: 問題の早期発見体制

### 改善優先度

```
🔴 Critical: システム障害リスク
├─ メモリリーク (サーバークラッシュ)
├─ N+1 クエリ (データベース負荷)
└─ 同期 I/O (レスポンス遅延)

🟡 High: ユーザー体験影響
├─ バンドルサイズ (初回ロード時間)
├─ 画像最適化 (表示速度)
└─ キャッシュ戦略 (反応速度)

🟢 Medium: 運用効率
├─ 依存関係更新 (セキュリティ)
├─ コード重複 (保守性)
└─ 監視強化 (運用負荷)
```

### 測定とツール

#### Node.js / JavaScript

```bash
# プロファイリング
node --prof app.js
clinic doctor -- node app.js

# バンドル分析
npx webpack-bundle-analyzer
lighthouse --chrome-flags="--headless"
```

#### データベース

```sql
-- クエリ分析
EXPLAIN ANALYZE SELECT ...
SHOW SLOW LOG;
```