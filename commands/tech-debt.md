## Tech Debt

プロジェクトの技術的負債を分析し、優先順位付けされた改善計画を作成します。

### 使い方

```bash
# プロジェクトの構成を確認して技術的負債を分析
ls -la
「このプロジェクトの技術的負債を分析して改善計画を作成して」
```

### 基本例

```bash
# TODO/FIXME コメントの分析
grep -r "TODO\|FIXME\|HACK\|XXX\|WORKAROUND" . --exclude-dir=node_modules --exclude-dir=.git
「これらの TODO コメントを優先度順に整理して改善計画を立てて」

# プロジェクトの依存関係確認
ls -la | grep -E "package.json|Cargo.toml|pubspec.yaml|go.mod|requirements.txt"
「プロジェクトの依存関係を分析して古くなっているものとリスクを特定して」

# 大きなファイルや複雑な関数の検出
find . -type f -not -path "*/\.*" -not -path "*/node_modules/*" -exec wc -l {} + | sort -rn | head -10
「大きすぎるファイルや複雑な構造を特定して改善案を提示して」
```

### Claude との連携

```bash
# 包括的な技術的負債分析
ls -la && find . -name "*.md" -maxdepth 2 -exec head -20 {} \;
「このプロジェクトの技術的負債を以下の観点で分析して：
1. コード品質（複雑度、重複、保守性）
2. 依存関係の健全性
3. セキュリティリスク
4. パフォーマンス問題
5. テストカバレッジ不足」

# アーキテクチャの負債分析
find . -type d -name "src" -o -name "lib" -o -name "app" | head -10 | xargs ls -la
「アーキテクチャレベルの技術的負債を特定し、リファクタリング計画を提案して」

# 優先順位付けされた改善計画
「技術的負債を以下の基準で評価して表形式で提示：
- 影響度（高/中/低）
- 修正コスト（時間）
- ビジネスリスク
- 改善による効果
- 推奨実施時期」
```

### 詳細例

```bash
# プロジェクトタイプの自動検出と分析
find . -maxdepth 2 -type f \( -name "package.json" -o -name "Cargo.toml" -o -name "pubspec.yaml" -o -name "go.mod" -o -name "pom.xml" \)
「検出されたプロジェクトタイプに基づいて、以下を分析：
1. 言語・フレームワーク固有の技術的負債
2. ベストプラクティスからの逸脱
3. モダナイゼーションの機会
4. 段階的な改善戦略」

# コードの品質メトリクス分析
find . -type f -name "*" | grep -E "\.(js|ts|py|rs|go|dart|kotlin|swift|java)$" | wc -l
「プロジェクトのコード品質を分析し、以下のメトリクスを提示：
- 循環的複雑度が高い関数
- 重複コードの検出
- 長すぎるファイル/関数
- 適切なエラーハンドリングの欠如」

# セキュリティ負債の検出
grep -r "password\|secret\|key\|token" . --exclude-dir=.git --exclude-dir=node_modules | grep -v ".env.example"
「セキュリティに関する技術的負債を検出し、修正優先度と対策を提案して」

# テスト不足の分析
find . -type f \( -name "*test*" -o -name "*spec*" \) | wc -l && find . -type f -name "*.md" | xargs grep -l "test"
「テストカバレッジの技術的負債を分析し、テスト戦略を提案して」
```

### 注意事項

- プロジェクトの言語やフレームワークを自動検出し、それに応じた分析を行います
- 技術的負債は「すぐに修正すべき重要な問題」と「長期的に改善する項目」に分類されます
- ビジネス価値と技術的改善のバランスを考慮した現実的な計画を提供します
- 改善による ROI（投資対効果）も考慮に入れます
