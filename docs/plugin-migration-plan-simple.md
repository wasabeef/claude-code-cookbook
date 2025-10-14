# Claude Code Cookbook - Plugin 移行計画書 (簡易版)

**作成日**: 2025-10-14
**バージョン**: 1.1.0 (Simplified - Language Directory Structure)
**ステータス**: 計画策定完了
**対象**: Commands と Roles のみ (Hooks は対象外)

## 目次

1. [エグゼクティブサマリー](#エグゼクティブサマリー)
2. [対象範囲](#対象範囲)
3. [プラグイン構造設計](#プラグイン構造設計)
4. [言語別ディレクトリ構造](#言語別ディレクトリ構造)
5. [マーケットプレイス戦略](#マーケットプレイス戦略)
6. [移行ロードマップ (6 週間)](#移行ロードマップ-6-週間)
7. [実装ガイド](#実装ガイド)

---

## エグゼクティブサマリー

### 概要

Claude Code Cookbook の Commands (39 個) と Roles (9 個) をプラグインシステムに対応させます。

**重要**: 各言語を独立したプラグインとして提供し、言語ごとにディレクトリを完全に分離します。

**対象外**: Hooks、Scripts、Assets (将来的に Phase 2 として実装)

### 期待される成果

- ✅ インストール時間の短縮 (手動 5 分 → 自動 10 秒)
- ✅ ワンコマンドインストール: `/plugin install claude-code-cookbook-en`
- ✅ 言語ごとの独立したプラグイン
- ✅ 段階的な機能追加の基盤確立

---

## 対象範囲

### 対象コンポーネント

| コンポーネント | 数 | 含める |
|:---|---:|:---:|
| Commands | 39 | ✅ |
| Roles | 9 | ✅ |
| Hooks | 12 | ❌ (Phase 2) |
| Scripts | 12 | ❌ (Phase 2) |
| Assets | 3 | ❌ (Phase 2) |

### 対象言語

| 言語 | プラグイン名 | 優先度 |
|:---|:---|:---:|
| 英語 | `claude-code-cookbook-en` | 最高 |
| 日本語 | `claude-code-cookbook-ja` | 高 |
| 韓国語 | `claude-code-cookbook-ko` | 中 |
| 簡体中国語 | `claude-code-cookbook-zh-cn` | 中 |
| 繁体中国語 | `claude-code-cookbook-zh-tw` | 中 |
| スペイン語 | `claude-code-cookbook-es` | 低 |
| ポルトガル語 | `claude-code-cookbook-pt` | 低 |
| フランス語 | `claude-code-cookbook-fr` | 低 |

**Phase 1**: 英語 + 日本語 + 韓国語 (3 言語)
**Phase 2**: 残り 5 言語追加

---

## プラグイン構造設計

### 戦略: 言語別独立プラグイン

各言語を完全に独立したプラグインとして提供します。

#### 利点

- ✅ シンプルな構造 (依存関係なし)
- ✅ 言語ごとの独立した更新
- ✅ ユーザーが必要な言語のみインストール
- ✅ プラグインの衝突がない
- ✅ 明確な命名規則

#### プラグイン一覧

1. `claude-code-cookbook-en` (英語版)
2. `claude-code-cookbook-ja` (日本語版)
3. `claude-code-cookbook-ko` (韓国語版)
4. `claude-code-cookbook-zh-cn` (簡体中国語版)
5. `claude-code-cookbook-zh-tw` (繁体中国語版)
6. `claude-code-cookbook-es` (スペイン語版)
7. `claude-code-cookbook-pt` (ポルトガル語版)
8. `claude-code-cookbook-fr` (フランス語版)

---

## 言語別ディレクトリ構造

### マーケットプレイスリポジトリ全体構造

```
claude-code-cookbook-marketplace/
├── .claude-plugin/
│   └── marketplace.json             # マーケットプレイス定義
│
├── plugins/
│   ├── en/                          # 英語版プラグイン
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/                # 39 コマンド (英語)
│   │   ├── agents/
│   │   │   └── roles/               # 9 ロール (英語)
│   │   ├── README.md
│   │   └── LICENSE
│   │
│   ├── ja/                          # 日本語版プラグイン
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/                # 39 コマンド (日本語)
│   │   ├── agents/
│   │   │   └── roles/               # 9 ロール (日本語)
│   │   ├── README_ja.md
│   │   └── LICENSE
│   │
│   ├── ko/                          # 韓国語版プラグイン
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/                # 39 コマンド (韓国語)
│   │   ├── agents/
│   │   │   └── roles/               # 9 ロール (韓国語)
│   │   ├── README_ko.md
│   │   └── LICENSE
│   │
│   ├── zh-cn/                       # 簡体中国語版プラグイン
│   ├── zh-tw/                       # 繁体中国語版プラグイン
│   ├── es/                          # スペイン語版プラグイン
│   ├── pt/                          # ポルトガル語版プラグイン
│   └── fr/                          # フランス語版プラグイン
│
├── README.md                        # マーケットプレイス説明
├── README_ja.md
├── README_ko.md
└── LICENSE
```

### 各プラグインの詳細構造 (例: 日本語版)

```
plugins/ja/
├── .claude-plugin/
│   └── plugin.json                  # プラグインマニフェスト
│
├── commands/                        # 39 コマンド (日本語)
│   ├── analyze-dependencies.md
│   ├── analyze-performance.md
│   ├── check-fact.md
│   ├── check-github-ci.md
│   ├── check-prompt.md
│   ├── commit-message.md
│   ├── context7.md
│   ├── design-patterns.md
│   ├── explain-code.md
│   ├── fix-error.md
│   ├── multi-role.md
│   ├── plan.md
│   ├── pr-auto-update.md
│   ├── pr-create.md
│   ├── pr-feedback.md
│   ├── pr-issue.md
│   ├── pr-list.md
│   ├── pr-review.md
│   ├── refactor.md
│   ├── role-debate.md
│   ├── role-help.md
│   ├── role.md
│   ├── screenshot.md
│   ├── search-gemini.md
│   ├── semantic-commit.md
│   ├── sequential-thinking.md
│   ├── show-plan.md
│   ├── smart-review.md
│   ├── spec.md
│   ├── style-ai-writing.md
│   ├── task.md
│   ├── tech-debt.md
│   ├── token-efficient.md
│   ├── ultrathink.md
│   ├── update-dart-doc.md
│   ├── update-doc-string.md
│   ├── update-flutter-deps.md
│   ├── update-node-deps.md
│   └── update-rust-deps.md
│
├── agents/
│   └── roles/                       # 9 ロール (日本語)
│       ├── analyzer.md
│       ├── architect.md
│       ├── backend.md
│       ├── frontend.md
│       ├── mobile.md
│       ├── performance.md
│       ├── qa.md
│       ├── reviewer.md
│       └── security.md
│
├── README_ja.md                     # 日本語ドキュメント
└── LICENSE
```

---

## プラグインマニフェスト設計

### 英語版プラグイン (`plugins/en/.claude-plugin/plugin.json`)

```json
{
  "name": "claude-code-cookbook-en",
  "version": "1.0.0",
  "description": "Comprehensive collection of 39 commands and 9 specialized roles for Claude Code (English)",
  "author": {
    "name": "Daichi Furiya (wasabeef)",
    "email": "[email protected]",
    "url": "https://github.com/wasabeef"
  },
  "homepage": "https://github.com/wasabeef/claude-code-cookbook",
  "repository": "https://github.com/wasabeef/claude-code-cookbook-marketplace",
  "license": "Apache-2.0",
  "keywords": [
    "productivity",
    "automation",
    "development",
    "code-review",
    "git-workflow",
    "english"
  ],
  "commands": "./commands/",
  "agents": "./agents/",
  "engines": {
    "claude-code": ">=2.0.13"
  }
}
```

### 日本語版プラグイン (`plugins/ja/.claude-plugin/plugin.json`)

```json
{
  "name": "claude-code-cookbook-ja",
  "version": "1.0.0",
  "description": "Claude Code の開発生産性を向上させる 39 個のコマンドと 9 つの専門家役割 (日本語)",
  "author": {
    "name": "Daichi Furiya (wasabeef)",
    "email": "[email protected]",
    "url": "https://github.com/wasabeef"
  },
  "homepage": "https://github.com/wasabeef/claude-code-cookbook",
  "repository": "https://github.com/wasabeef/claude-code-cookbook-marketplace",
  "license": "Apache-2.0",
  "keywords": [
    "productivity",
    "automation",
    "development",
    "code-review",
    "git-workflow",
    "japanese",
    "日本語"
  ],
  "commands": "./commands/",
  "agents": "./agents/",
  "engines": {
    "claude-code": ">=2.0.13"
  }
}
```

### 韓国語版プラグイン (`plugins/ko/.claude-plugin/plugin.json`)

```json
{
  "name": "claude-code-cookbook-ko",
  "version": "1.0.0",
  "description": "Claude Code를 위한 39개의 명령어와 9개의 전문가 역할 모음 (한국어)",
  "author": {
    "name": "Daichi Furiya (wasabeef)",
    "email": "[email protected]",
    "url": "https://github.com/wasabeef"
  },
  "homepage": "https://github.com/wasabeef/claude-code-cookbook",
  "repository": "https://github.com/wasabeef/claude-code-cookbook-marketplace",
  "license": "Apache-2.0",
  "keywords": [
    "productivity",
    "automation",
    "development",
    "korean",
    "한국어"
  ],
  "commands": "./commands/",
  "agents": "./agents/",
  "engines": {
    "claude-code": ">=2.0.13"
  }
}
```

---

## マーケットプレイス戦略

### marketplace.json (Phase 1: 3 言語)

```json
{
  "name": "claude-code-cookbook-marketplace",
  "owner": {
    "name": "Daichi Furiya (wasabeef)",
    "email": "[email protected]",
    "url": "https://github.com/wasabeef"
  },
  "metadata": {
    "description": "Official marketplace for Claude Code Cookbook plugins - Multilingual development productivity tools",
    "version": "1.0.0",
    "homepage": "https://github.com/wasabeef/claude-code-cookbook-marketplace",
    "pluginRoot": "./plugins"
  },
  "plugins": [
    {
      "name": "claude-code-cookbook-en",
      "source": "./plugins/en",
      "description": "39 commands and 9 roles for enhanced productivity (English)",
      "version": "1.0.0",
      "category": "Productivity",
      "keywords": ["productivity", "automation", "english"],
      "featured": true,
      "author": {
        "name": "wasabeef",
        "url": "https://github.com/wasabeef"
      }
    },
    {
      "name": "claude-code-cookbook-ja",
      "source": "./plugins/ja",
      "description": "開発生産性を向上させる 39 個のコマンドと 9 つの役割 (日本語)",
      "version": "1.0.0",
      "category": "Productivity",
      "keywords": ["productivity", "automation", "japanese", "日本語"],
      "featured": true,
      "author": {
        "name": "wasabeef",
        "url": "https://github.com/wasabeef"
      }
    },
    {
      "name": "claude-code-cookbook-ko",
      "source": "./plugins/ko",
      "description": "생산성 향상을 위한 39개의 명령어와 9개의 역할 (한국어)",
      "version": "1.0.0",
      "category": "Productivity",
      "keywords": ["productivity", "automation", "korean", "한국어"],
      "featured": true,
      "author": {
        "name": "wasabeef",
        "url": "https://github.com/wasabeef"
      }
    }
  ]
}
```

---

## インストール方法

### ユーザー向け

```bash
# マーケットプレイス追加
/plugin marketplace add wasabeef/claude-code-cookbook-marketplace

# 英語版インストール
/plugin install claude-code-cookbook-en

# 日本語版インストール
/plugin install claude-code-cookbook-ja

# 韓国語版インストール
/plugin install claude-code-cookbook-ko
```

### 言語切り替え

```bash
# 日本語から韓国語に切り替え
/plugin disable claude-code-cookbook-ja
/plugin enable claude-code-cookbook-ko

# または一度アンインストールして再インストール
/plugin uninstall claude-code-cookbook-ja
/plugin install claude-code-cookbook-ko
```

---

## 移行ロードマップ (6 週間)

### Phase 0: 準備 (Week 1)

#### タスク

- [ ] 技術検証
  - [ ] Claude Code 2.0.13+ の動作確認
  - [ ] プラグインシステムの動作検証
  - [ ] `claude plugin validate` コマンドの確認

- [ ] リポジトリ構造の設計
  - [ ] マーケットプレイスリポジトリ名の決定
  - [ ] ブランチ戦略の決定
  - [ ] Git タグ戦略の決定

- [ ] ファイル棚卸し
  - [ ] 英語版 Commands/Roles の確認 (`locales/en/`)
  - [ ] 日本語版 Commands/Roles の確認 (`commands/`, `agents/`)
  - [ ] 韓国語版 Commands/Roles の確認 (`locales/ko/`)

**成果物**: 技術仕様書、ディレクトリ構造図

---

### Phase 1: リポジトリ構築 (Week 2)

#### タスク

- [ ] マーケットプレイスリポジトリ作成
  - [ ] `wasabeef/claude-code-cookbook-marketplace` 作成
  - [ ] ディレクトリ構造構築
  - [ ] `.claude-plugin/marketplace.json` 作成
  - [ ] README.md 作成 (英語・日本語・韓国語)

- [ ] 英語版プラグイン作成
  - [ ] `plugins/en/.claude-plugin/plugin.json` 作成
  - [ ] Commands 39 個を `plugins/en/commands/` に配置
  - [ ] Roles 9 個を `plugins/en/agents/roles/` に配置
  - [ ] `plugins/en/README.md` 作成
  - [ ] LICENSE コピー

- [ ] 検証
  - [ ] `claude plugin validate plugins/en` 実行
  - [ ] ローカルインストールテスト

**成果物**: `claude-code-cookbook-en` v1.0.0-beta1

---

### Phase 2: 日本語・韓国語プラグイン作成 (Week 3)

#### 日本語版プラグイン

- [ ] `plugins/ja/.claude-plugin/plugin.json` 作成
- [ ] Commands 39 個を `plugins/ja/commands/` に配置
- [ ] Roles 9 個を `plugins/ja/agents/roles/` に配置
- [ ] `plugins/ja/README_ja.md` 作成
- [ ] LICENSE コピー
- [ ] `claude plugin validate plugins/ja` 実行
- [ ] 動作検証

#### 韓国語版プラグイン

- [ ] `plugins/ko/.claude-plugin/plugin.json` 作成
- [ ] Commands 39 個を `plugins/ko/commands/` に配置
- [ ] Roles 9 個を `plugins/ko/agents/roles/` に配置
- [ ] `plugins/ko/README_ko.md` 作成
- [ ] LICENSE コピー
- [ ] `claude plugin validate plugins/ko` 実行
- [ ] 動作検証

**成果物**:

- `claude-code-cookbook-ja` v1.0.0-beta1
- `claude-code-cookbook-ko` v1.0.0-beta1

---

### Phase 3: マーケットプレイス統合 (Week 4)

#### タスク

- [ ] marketplace.json に 3 プラグイン登録
- [ ] Featured プラグイン設定
- [ ] カテゴリ・キーワード設定
- [ ] マーケットプレイス README 更新 (3 言語)

- [ ] 検証
  - [ ] マーケットプレイス追加テスト
  - [ ] 各プラグインのインストールテスト
  - [ ] プラグイン切り替えテスト

- [ ] ドキュメント作成
  - [ ] インストールガイド (3 言語)
  - [ ] トラブルシューティング (3 言語)

**成果物**:

- マーケットプレイス v1.0.0-rc1
- 3 言語対応ドキュメント

---

### Phase 4: テスト・改善 (Week 5)

#### タスク

- [ ] 包括的テスト
  - [ ] 全 Commands の動作確認 (39 × 3 言語 = 117 ケース)
  - [ ] 全 Roles の動作確認 (9 × 3 言語 = 27 ケース)
  - [ ] プラグイン切り替えテスト
  - [ ] クロスプラットフォームテスト (macOS, Linux, Windows)

- [ ] フィードバック収集
  - [ ] 内部レビュー
  - [ ] クローズドベータテスト (5-10 名)
  - [ ] Issue 収集

- [ ] 改善・修正
  - [ ] バグ修正
  - [ ] ドキュメント改善
  - [ ] パフォーマンス最適化

**成果物**:

- v1.0.0-rc2 (リリース候補)
- テストレポート

---

### Phase 5: 正式リリース (Week 6)

#### タスク

- [ ] リリース準備
  - [ ] バージョン番号確定 (v1.0.0)
  - [ ] リリースノート作成 (英語・日本語・韓国語)
  - [ ] CHANGELOG 作成
  - [ ] 最終動作確認

- [ ] 公開
  - [ ] GitHub Release 作成 (3 プラグイン)
  - [ ] Git タグ付け (`v1.0.0-en`, `v1.0.0-ja`, `v1.0.0-ko`)
  - [ ] マーケットプレイス公開

- [ ] 告知
  - [ ] 既存リポジトリ README 更新
  - [ ] SNS 告知 (Twitter/X, Bluesky など)
  - [ ] GitHub Discussions 投稿
  - [ ] 既存ユーザーへの移行ガイド提供

**成果物**:

- 正式版プラグイン v1.0.0 (3 プラグイン)
- マーケットプレイス v1.0.0
- 移行ガイド (3 言語)

---

### Phase 6 (オプション): 残り 5 言語追加 (Week 7-8)

#### タスク

各言語ごとに以下を実施:

- [ ] 簡体中国語 (`plugins/zh-cn/`)
  - [ ] plugin.json 作成
  - [ ] Commands/Roles 配置
  - [ ] README_zh-cn.md 作成
  - [ ] 検証

- [ ] 繁体中国語 (`plugins/zh-tw/`)
- [ ] スペイン語 (`plugins/es/`)
- [ ] ポルトガル語 (`plugins/pt/`)
- [ ] フランス語 (`plugins/fr/`)

- [ ] マーケットプレイス更新
  - [ ] marketplace.json に 5 プラグイン追加
  - [ ] README 更新 (5 言語追加)

**成果物**: 全 8 プラグイン

---

## 実装ガイド

### Step 1: マーケットプレイスリポジトリ作成

```bash
# 新規リポジトリ作成
mkdir -p claude-code-cookbook-marketplace
cd claude-code-cookbook-marketplace

# ディレクトリ構造作成
mkdir -p .claude-plugin
mkdir -p plugins/{en,ja,ko,zh-cn,zh-tw,es,pt,fr}

# Git 初期化
git init
git add .
git commit -m "Initial repository structure"

# GitHub にプッシュ (事前にリポジトリを作成しておく)
git remote add origin git@github.com:wasabeef/claude-code-cookbook-marketplace.git
git push -u origin main
```

### Step 2: 英語版プラグイン作成

```bash
cd claude-code-cookbook-marketplace

# ディレクトリ構造作成
mkdir -p plugins/en/.claude-plugin
mkdir -p plugins/en/commands
mkdir -p plugins/en/agents/roles

# plugin.json 作成
cat > plugins/en/.claude-plugin/plugin.json << 'EOF'
{
  "name": "claude-code-cookbook-en",
  "version": "1.0.0",
  "description": "Comprehensive collection of 39 commands and 9 specialized roles for Claude Code (English)",
  "author": {
    "name": "Daichi Furiya (wasabeef)",
    "email": "[email protected]",
    "url": "https://github.com/wasabeef"
  },
  "homepage": "https://github.com/wasabeef/claude-code-cookbook",
  "repository": "https://github.com/wasabeef/claude-code-cookbook-marketplace",
  "license": "Apache-2.0",
  "keywords": [
    "productivity",
    "automation",
    "development",
    "english"
  ],
  "commands": "./commands/",
  "agents": "./agents/"
}
EOF

# 既存の英語版ファイルをコピー
# (元のリポジトリから)
cp /path/to/claude-code-cookbook/locales/en/commands/*.md plugins/en/commands/
cp /path/to/claude-code-cookbook/locales/en/agents/roles/*.md plugins/en/agents/roles/

# README.md 作成
cat > plugins/en/README.md << 'EOF'
# Claude Code Cookbook (English)

Comprehensive collection of 39 commands and 9 specialized roles for Claude Code.

## Installation

\`\`\`bash
/plugin marketplace add wasabeef/claude-code-cookbook-marketplace
/plugin install claude-code-cookbook-en
\`\`\`

## Features

- 39 productivity commands
- 9 specialized AI roles
- Pull request automation
- Code quality tools
- Git workflow enhancement

## Documentation

See [main repository](https://github.com/wasabeef/claude-code-cookbook) for full documentation.

## License

Apache-2.0
EOF

# LICENSE コピー
cp /path/to/claude-code-cookbook/LICENSE plugins/en/

# 検証
claude plugin validate plugins/en
```

### Step 3: 日本語版プラグイン作成

```bash
cd claude-code-cookbook-marketplace

# ディレクトリ構造作成
mkdir -p plugins/ja/.claude-plugin
mkdir -p plugins/ja/commands
mkdir -p plugins/ja/agents/roles

# plugin.json 作成
cat > plugins/ja/.claude-plugin/plugin.json << 'EOF'
{
  "name": "claude-code-cookbook-ja",
  "version": "1.0.0",
  "description": "Claude Code の開発生産性を向上させる 39 個のコマンドと 9 つの専門家役割 (日本語)",
  "author": {
    "name": "Daichi Furiya (wasabeef)",
    "email": "[email protected]",
    "url": "https://github.com/wasabeef"
  },
  "homepage": "https://github.com/wasabeef/claude-code-cookbook",
  "repository": "https://github.com/wasabeef/claude-code-cookbook-marketplace",
  "license": "Apache-2.0",
  "keywords": [
    "productivity",
    "automation",
    "development",
    "japanese",
    "日本語"
  ],
  "commands": "./commands/",
  "agents": "./agents/"
}
EOF

# 既存の日本語版ファイルをコピー
cp /path/to/claude-code-cookbook/commands/*.md plugins/ja/commands/
cp /path/to/claude-code-cookbook/agents/roles/*.md plugins/ja/agents/roles/

# README_ja.md 作成
cat > plugins/ja/README_ja.md << 'EOF'
# Claude Code Cookbook (日本語)

Claude Code の開発生産性を向上させる 39 個のコマンドと 9 つの専門家役割。

## インストール

\`\`\`bash
/plugin marketplace add wasabeef/claude-code-cookbook-marketplace
/plugin install claude-code-cookbook-ja
\`\`\`

## 機能

- 39 個の生産性向上コマンド
- 9 つの専門家 AI 役割
- Pull Request 自動化
- コード品質ツール
- Git ワークフロー強化

## ドキュメント

詳細は[メインリポジトリ](https://github.com/wasabeef/claude-code-cookbook)を参照してください。

## ライセンス

Apache-2.0
EOF

# LICENSE コピー
cp /path/to/claude-code-cookbook/LICENSE plugins/ja/

# 検証
claude plugin validate plugins/ja
```

### Step 4: 韓国語版プラグイン作成

```bash
cd claude-code-cookbook-marketplace

# ディレクトリ構造作成
mkdir -p plugins/ko/.claude-plugin
mkdir -p plugins/ko/commands
mkdir -p plugins/ko/agents/roles

# plugin.json 作成
cat > plugins/ko/.claude-plugin/plugin.json << 'EOF'
{
  "name": "claude-code-cookbook-ko",
  "version": "1.0.0",
  "description": "Claude Code를 위한 39개의 명령어와 9개의 전문가 역할 모음 (한국어)",
  "author": {
    "name": "Daichi Furiya (wasabeef)",
    "email": "[email protected]",
    "url": "https://github.com/wasabeef"
  },
  "homepage": "https://github.com/wasabeef/claude-code-cookbook",
  "repository": "https://github.com/wasabeef/claude-code-cookbook-marketplace",
  "license": "Apache-2.0",
  "keywords": [
    "productivity",
    "automation",
    "development",
    "korean",
    "한국어"
  ],
  "commands": "./commands/",
  "agents": "./agents/"
}
EOF

# 既存の韓国語版ファイルをコピー
cp /path/to/claude-code-cookbook/locales/ko/commands/*.md plugins/ko/commands/
cp /path/to/claude-code-cookbook/locales/ko/agents/roles/*.md plugins/ko/agents/roles/

# README_ko.md 作成
cat > plugins/ko/README_ko.md << 'EOF'
# Claude Code Cookbook (한국어)

Claude Code의 개발 생산성을 향상시키는 39개의 명령어와 9개의 전문가 역할.

## 설치

\`\`\`bash
/plugin marketplace add wasabeef/claude-code-cookbook-marketplace
/plugin install claude-code-cookbook-ko
\`\`\`

## 기능

- 39개의 생산성 향상 명령어
- 9개의 전문가 AI 역할
- Pull Request 자동화
- 코드 품질 도구
- Git 워크플로우 강화

## 문서

자세한 내용은 [메인 저장소](https://github.com/wasabeef/claude-code-cookbook)를 참조하세요.

## 라이선스

Apache-2.0
EOF

# LICENSE コピー
cp /path/to/claude-code-cookbook/LICENSE plugins/ko/

# 検証
claude plugin validate plugins/ko
```

### Step 5: marketplace.json 作成

```bash
cd claude-code-cookbook-marketplace

cat > .claude-plugin/marketplace.json << 'EOF'
{
  "name": "claude-code-cookbook-marketplace",
  "owner": {
    "name": "Daichi Furiya (wasabeef)",
    "email": "[email protected]",
    "url": "https://github.com/wasabeef"
  },
  "metadata": {
    "description": "Official marketplace for Claude Code Cookbook plugins - Multilingual development productivity tools",
    "version": "1.0.0",
    "homepage": "https://github.com/wasabeef/claude-code-cookbook-marketplace",
    "pluginRoot": "./plugins"
  },
  "plugins": [
    {
      "name": "claude-code-cookbook-en",
      "source": "./plugins/en",
      "description": "39 commands and 9 roles for enhanced productivity (English)",
      "version": "1.0.0",
      "category": "Productivity",
      "keywords": ["productivity", "automation", "english"],
      "featured": true,
      "author": {
        "name": "wasabeef",
        "url": "https://github.com/wasabeef"
      }
    },
    {
      "name": "claude-code-cookbook-ja",
      "source": "./plugins/ja",
      "description": "開発生産性を向上させる 39 個のコマンドと 9 つの役割 (日本語)",
      "version": "1.0.0",
      "category": "Productivity",
      "keywords": ["productivity", "automation", "japanese", "日本語"],
      "featured": true,
      "author": {
        "name": "wasabeef",
        "url": "https://github.com/wasabeef"
      }
    },
    {
      "name": "claude-code-cookbook-ko",
      "source": "./plugins/ko",
      "description": "생산성 향상을 위한 39개의 명령어와 9개의 역할 (한국어)",
      "version": "1.0.0",
      "category": "Productivity",
      "keywords": ["productivity", "automation", "korean", "한국어"],
      "featured": true,
      "author": {
        "name": "wasabeef",
        "url": "https://github.com/wasabeef"
      }
    }
  ]
}
EOF

# 検証
claude plugin validate .claude-plugin/marketplace.json
```

### Step 6: マーケットプレイス README 作成

```bash
cd claude-code-cookbook-marketplace

cat > README.md << 'EOF'
# Claude Code Cookbook Marketplace

Official marketplace for Claude Code Cookbook plugins.

[日本語](README_ja.md) | [한국어](README_ko.md) | [English](README.md)

## Available Plugins

- **claude-code-cookbook-en** - English version
- **claude-code-cookbook-ja** - 日本語版
- **claude-code-cookbook-ko** - 한국어 버전

## Installation

\`\`\`bash
# Add marketplace
/plugin marketplace add wasabeef/claude-code-cookbook-marketplace

# Install your preferred language
/plugin install claude-code-cookbook-en
/plugin install claude-code-cookbook-ja
/plugin install claude-code-cookbook-ko
\`\`\`

## Features

- 39 productivity commands
- 9 specialized AI roles
- Pull request automation
- Code quality tools
- Git workflow enhancement

## Documentation

See [main repository](https://github.com/wasabeef/claude-code-cookbook) for full documentation.

## License

Apache-2.0
EOF
```

### Step 7: Git コミット・プッシュ

```bash
cd claude-code-cookbook-marketplace

# 全変更をコミット
git add .
git commit -m "Add English, Japanese, and Korean plugins"

# GitHub にプッシュ
git push origin main

# タグ付け
git tag v1.0.0
git push origin v1.0.0
```

### Step 8: ローカルテスト

```bash
# マーケットプレイス追加 (ローカルパス)
/plugin marketplace add ./claude-code-cookbook-marketplace

# または GitHub 経由
/plugin marketplace add wasabeef/claude-code-cookbook-marketplace

# プラグインインストール
/plugin install claude-code-cookbook-ja

# コマンド確認
/help

# 動作確認
/plan
/role architect
```

---

## ファイル移動マッピング

### 既存構造 → プラグイン構造

#### 英語版 (`plugins/en/`)

| 既存パス | プラグインパス |
|:---|:---|
| `locales/en/commands/*.md` | `plugins/en/commands/*.md` |
| `locales/en/agents/roles/*.md` | `plugins/en/agents/roles/*.md` |
| `README_en.md` | `plugins/en/README.md` |
| `LICENSE` | `plugins/en/LICENSE` |

#### 日本語版 (`plugins/ja/`)

| 既存パス | プラグインパス |
|:---|:---|
| `commands/*.md` | `plugins/ja/commands/*.md` |
| `agents/roles/*.md` | `plugins/ja/agents/roles/*.md` |
| `README.md` | `plugins/ja/README_ja.md` |
| `LICENSE` | `plugins/ja/LICENSE` |

#### 韓国語版 (`plugins/ko/`)

| 既存パス | プラグインパス |
|:---|:---|
| `locales/ko/commands/*.md` | `plugins/ko/commands/*.md` |
| `locales/ko/agents/roles/*.md` | `plugins/ko/agents/roles/*.md` |
| `README_ko.md` | `plugins/ko/README_ko.md` |
| `LICENSE` | `plugins/ko/LICENSE` |

---

## 自動化スクリプト

### プラグイン生成スクリプト (`scripts/generate-plugin.sh`)

```bash
#!/bin/bash
# プラグイン自動生成スクリプト

set -e

LANG_CODE=$1
SOURCE_DIR=$2
TARGET_DIR="plugins/${LANG_CODE}"

if [ -z "$LANG_CODE" ] || [ -z "$SOURCE_DIR" ]; then
  echo "Usage: $0 <language-code> <source-directory>"
  echo "Example: $0 ja /path/to/claude-code-cookbook"
  exit 1
fi

echo "🔄 Generating plugin for language: ${LANG_CODE}"

# ディレクトリ作成
mkdir -p "${TARGET_DIR}/.claude-plugin"
mkdir -p "${TARGET_DIR}/commands"
mkdir -p "${TARGET_DIR}/agents/roles"

# Commands コピー
echo "📝 Copying commands..."
if [ "$LANG_CODE" = "en" ]; then
  cp "${SOURCE_DIR}/locales/en/commands/"*.md "${TARGET_DIR}/commands/"
elif [ "$LANG_CODE" = "ja" ]; then
  cp "${SOURCE_DIR}/commands/"*.md "${TARGET_DIR}/commands/"
else
  cp "${SOURCE_DIR}/locales/${LANG_CODE}/commands/"*.md "${TARGET_DIR}/commands/"
fi

# Roles コピー
echo "📝 Copying roles..."
if [ "$LANG_CODE" = "en" ]; then
  cp "${SOURCE_DIR}/locales/en/agents/roles/"*.md "${TARGET_DIR}/agents/roles/"
elif [ "$LANG_CODE" = "ja" ]; then
  cp "${SOURCE_DIR}/agents/roles/"*.md "${TARGET_DIR}/agents/roles/"
else
  cp "${SOURCE_DIR}/locales/${LANG_CODE}/agents/roles/"*.md "${TARGET_DIR}/agents/roles/"
fi

# LICENSE コピー
cp "${SOURCE_DIR}/LICENSE" "${TARGET_DIR}/"

echo "✅ Plugin structure created: ${TARGET_DIR}"
echo ""
echo "Next steps:"
echo "1. Create ${TARGET_DIR}/.claude-plugin/plugin.json"
echo "2. Create ${TARGET_DIR}/README_${LANG_CODE}.md"
echo "3. Run: claude plugin validate ${TARGET_DIR}"
```

### 使用例

```bash
chmod +x scripts/generate-plugin.sh

# 英語版プラグイン生成
./scripts/generate-plugin.sh en /path/to/claude-code-cookbook

# 日本語版プラグイン生成
./scripts/generate-plugin.sh ja /path/to/claude-code-cookbook

# 韓国語版プラグイン生成
./scripts/generate-plugin.sh ko /path/to/claude-code-cookbook
```

---

## チェックリスト

### Phase 0: 準備

- [ ] Claude Code 2.0.13+ インストール確認
- [ ] `claude plugin validate` コマンド動作確認
- [ ] 既存ファイルのバックアップ
- [ ] マーケットプレイスリポジトリ名の決定

### Phase 1: リポジトリ構築

- [ ] GitHub リポジトリ作成
- [ ] ディレクトリ構造構築
- [ ] `.claude-plugin/marketplace.json` 作成
- [ ] 英語版プラグイン作成
  - [ ] plugin.json
  - [ ] Commands 39 個
  - [ ] Roles 9 個
  - [ ] README.md
- [ ] 検証成功

### Phase 2: 日本語・韓国語プラグイン

#### 日本語

- [ ] plugin.json 作成
- [ ] Commands 39 個配置
- [ ] Roles 9 個配置
- [ ] README_ja.md 作成
- [ ] 検証成功

#### 韓国語

- [ ] plugin.json 作成
- [ ] Commands 39 個配置
- [ ] Roles 9 個配置
- [ ] README_ko.md 作成
- [ ] 検証成功

### Phase 3: マーケットプレイス統合

- [ ] marketplace.json に 3 プラグイン登録
- [ ] Featured 設定
- [ ] マーケットプレイス README 作成 (3 言語)
- [ ] Git プッシュ
- [ ] マーケットプレイス追加テスト成功

### Phase 4: テスト

- [ ] 全 Commands 動作確認 (117 ケース)
- [ ] 全 Roles 動作確認 (27 ケース)
- [ ] 言語切り替えテスト
- [ ] macOS テスト
- [ ] Linux テスト
- [ ] Windows テスト

### Phase 5: リリース

- [ ] バージョン v1.0.0 確定
- [ ] リリースノート作成 (3 言語)
- [ ] GitHub Release 作成
- [ ] Git タグ付け (`v1.0.0`)
- [ ] SNS 告知
- [ ] 移行ガイド公開

---

## 想定される課題と対策

### 課題 1: プラグイン数の管理

**課題**: 8 言語で 8 プラグインの管理

**対策**:

- 自動化スクリプトの活用
- CI/CD パイプラインの構築
- テンプレート化

### 課題 2: バージョン管理

**課題**: 8 プラグインの同期的なバージョン管理

**対策**:

- モノレポ構造の採用
- 統一されたバージョニング戦略
- リリース自動化

### 課題 3: 既存ユーザーの移行

**課題**: 既存の手動インストールユーザーの混乱

**対策**:

- 詳細な移行ガイド作成 (3 言語)
- 並行運用期間の設定 (6 ヶ月)
- FAQ の充実

---

## 成功指標

### 定量指標 (3 ヶ月後)

| 指標 | 目標 |
|:---|---:|
| プラグインダウンロード数 (合計) | 500+ |
| GitHub Stars | 300+ |
| Issue 解決率 | 80%+ |
| インストール成功率 | 95%+ |

### 言語別指標

| 言語 | 目標ダウンロード数 |
|:---|---:|
| 日本語 | 200+ |
| 英語 | 150+ |
| 韓国語 | 100+ |

### 定性指標

- ✅ コミュニティからのポジティブなフィードバック
- ✅ 他のマーケットプレイスでの掲載
- ✅ ブログ記事での紹介

---

## まとめ

### 推奨実装方針

**対象**: Commands (39 個) + Roles (9 個) のみ

**アーキテクチャ**: 言語別独立プラグイン (8 プラグイン)

**ディレクトリ構造**: `plugins/<lang>/` で言語ごとに完全分離

**Phase 1 対応言語**: 英語・日本語・韓国語 (3 言語)

**スケジュール**: 6 週間で正式リリース (3 言語)

### プラグイン命名規則

- `claude-code-cookbook-en` (英語)
- `claude-code-cookbook-ja` (日本語)
- `claude-code-cookbook-ko` (韓国語)
- `claude-code-cookbook-zh-cn` (簡体中国語)
- `claude-code-cookbook-zh-tw` (繁体中国語)
- `claude-code-cookbook-es` (スペイン語)
- `claude-code-cookbook-pt` (ポルトガル語)
- `claude-code-cookbook-fr` (フランス語)

### Next Steps

1. **Week 1**: 技術検証とリポジトリ設計
2. **Week 2**: 英語版プラグイン作成
3. **Week 3**: 日本語・韓国語プラグイン作成
4. **Week 4**: マーケットプレイス統合
5. **Week 5**: テスト・改善
6. **Week 6**: 正式リリース

### Hooks は Phase 2 で対応

**理由**:

- Commands/Roles のプラグイン化が優先
- Hooks は技術的に複雑 (Scripts, Assets への依存)
- 段階的な実装でリスク軽減

**Phase 2 対応時期**: Phase 1 リリース後 1-2 ヶ月

---

**文書管理**

| 項目 | 内容 |
|:---|:---|
| 作成者 | Claude (Sonnet 4.5) |
| 最終更新 | 2025-10-14 |
| バージョン | 1.1.0 (Language Directory Structure) |
| ステータス | 計画策定完了 |
| 次回レビュー | Phase 0 完了時 |
