## Multi Role

複数のロールで同じ対象を並行分析し、統合レポートを生成するコマンド。

### 使い方

```bash
/multi-role <ロール 1>,<ロール 2> [分析対象] [--agent|-a]
/multi-role <ロール 1>,<ロール 2>,<ロール 3> [分析対象] [--agent|-a]
```

### オプション

- `--agent` または `-a` : 各ロールをサブエージェントとして並列実行（大規模分析時推奨）

### 基本例

```bash
# セキュリティとパフォーマンスの両面分析（通常）
/multi-role security,performance
「この API エンドポイントを評価して」

# 大規模システムの並列分析（サブエージェント）
/multi-role security,performance --agent
「システム全体のセキュリティとパフォーマンスを包括的に分析」

# フロントエンド・モバイル・パフォーマンスの統合分析
/multi-role frontend,mobile,performance
「この画面の最適化案を検討して」

# アーキテクチャ設計の多角的評価
/multi-role architect,security,performance
「マイクロサービス化の設計を評価して」
```

### 分析プロセス

### Phase 1: 並行分析

各ロールが独立して同じ対象を分析

- 専門視点からの評価実行
- ロール固有の基準で判定
- 独立した推奨事項の生成

### Phase 2: 統合分析

結果を構造化して統合

- 各ロールの評価結果整理
- 重複・矛盾点の特定
- 補完関係の明確化

### Phase 3: 統合レポート

最終的な推奨事項の生成

- 優先度付きアクションプラン
- トレードオフの明示
- 実装ロードマップ提示

### 出力フォーマット例

### 2 ロール分析の場合

```
マルチロール分析: Security + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

分析対象: API エンドポイント /api/users

Security 分析結果:
認証: JWT 検証が適切に実装
認可: ロールベースアクセス制御が不完全
暗号化: API キーが平文でログ出力

評価スコア: 65/100
重要度: High（機密データアクセスのため）

Performance 分析結果:
レスポンス時間: 平均 180ms（目標 200ms 以内）
データベースクエリ: N+1 問題を検出
キャッシュ: Redis キャッシュ未実装

評価スコア: 70/100
重要度: Medium（現状は許容範囲内）

相互関連分析:
相乗効果の機会:
- Redis キャッシュ実装時に暗号化も同時考慮
- ログ出力の改善でセキュリティ＋パフォーマンス向上

トレードオフポイント:
- 認可チェック強化 ↔ レスポンス時間への影響
- ログ暗号化 ↔ デバッグ効率の低下

統合優先度:
Critical: API キー平文出力の修正
High: N+1 クエリの解決
Medium: Redis キャッシュ + 暗号化の実装
Low: 認可制御の詳細化

実装ロードマップ:
週 1: API キーのマスキング実装
週 2: データベースクエリ最適化
週 3-4: キャッシュレイヤーの設計・実装
月 2: 認可制御の段階的強化
```

### 3 ロール分析の場合

```
マルチロール分析: Frontend + Mobile + Performance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

分析対象: ユーザープロフィール画面

Frontend 分析結果:
ユーザビリティ: 直感的なレイアウト
アクセシビリティ: WCAG 2.1 準拠率 85%
レスポンシブ: タブレット表示に課題

Mobile 分析結果:
タッチターゲット: 44pt 以上確保
片手操作: 重要ボタンが上部に配置
オフライン対応: 未実装

Performance 分析結果:
初期表示: LCP 2.1 秒（良好）
画像最適化: WebP 未対応
遅延読み込み: 未実装

統合推奨事項:
1. モバイル最適化（片手操作 + オフライン対応）
2. 画像最適化（WebP + 遅延読み込み）
3. タブレット UI の改善

優先度: Mobile > Performance > Frontend
実装期間: 3-4 週間
```

### 効果的な組み合わせパターン

### セキュリティ重視

```bash
/multi-role security,architect
「認証システムの設計」

/multi-role security,frontend  
「ログイン画面のセキュリティ」

/multi-role security,mobile
「モバイルアプリのデータ保護」
```

### パフォーマンス重視

```bash
/multi-role performance,architect
「スケーラビリティ設計」

/multi-role performance,frontend
「Web ページの高速化」

/multi-role performance,mobile
「アプリの動作最適化」
```

### ユーザー体験重視

```bash
/multi-role frontend,mobile
「クロスプラットフォーム UI」

/multi-role frontend,performance
「UX とパフォーマンスのバランス」

/multi-role mobile,performance
「モバイル UX の最適化」
```

### 包括的分析

```bash
/multi-role architect,security,performance
「システム全体の評価」

/multi-role frontend,mobile,performance
「ユーザー体験の総合評価」

/multi-role security,performance,mobile
「モバイルアプリの総合診断」
```

### Claude との連携

```bash
# ファイル分析と組み合わせ
cat src/components/UserProfile.tsx
/multi-role frontend,mobile
「このコンポーネントを複数の視点で評価して」

# 設計ドキュメントの評価
cat architecture-design.md
/multi-role architect,security,performance
「この設計を複数の専門分野で評価して」

# エラー分析
cat performance-issues.log
/multi-role performance,analyzer
「パフォーマンス問題を多角的に分析して」
```

### multi-role vs role-debate の使い分け

### multi-role を使う場面

- 各専門分野の独立した評価が欲しい
- 統合的な改善計画を立てたい
- 矛盾や重複を整理したい
- 実装優先度を決めたい

### role-debate を使う場面

- 専門分野間でトレードオフがある
- 技術選定で意見が分かれそう
- 設計方針を議論で決めたい
- 異なる視点での議論を聞きたい

### サブエージェント並列実行（--agent）

`--agent` オプションを使用すると、各ロールが独立したサブエージェントとして並列実行されます。

#### 実行フロー
```
通常実行:
ロール 1 → ロール 2 → ロール 3 → 統合
（順次実行、約 3-5 分）

--agent 実行:
ロール 1 ─┐
ロール 2 ─┼→ 統合
ロール 3 ─┘
（並列実行、約 1-2 分）
```

#### 効果的な使用例
```bash
# 大規模システムの総合評価
/multi-role architect,security,performance,qa --agent
「新システムの包括的評価」

# 複数観点での詳細分析
/multi-role frontend,mobile,performance --agent
「全画面の UX 最適化分析」
```

#### パフォーマンス比較
| ロール数 | 通常実行 | --agent 実行 | 短縮率 |
|---------|----------|-------------|-------|
| 2 ロール | 2-3 分 | 1 分 | 50% |
| 3 ロール | 3-5 分 | 1-2 分 | 60% |
| 4 ロール | 5-8 分 | 2-3 分 | 65% |

### 注意事項

- 3 つ以上のロールを同時実行すると出力が長くなります
- 複雑な分析ほど実行時間が長くなる可能性があります
- 相互矛盾する推奨事項が出た場合は、role-debate も検討してください
- 最終的な判断は統合結果を参考にユーザーが行ってください
- **--agent 使用時**: より多くのリソースを使用しますが、大規模分析では効率的です
