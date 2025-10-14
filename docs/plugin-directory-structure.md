# Claude Code Cookbook - Plugin ディレクトリ構造

**作成日**: 2025-10-14
**バージョン**: 3.0.0
**更新**: 全 8 言語対応完了 (Phase 2 完了)

## 目次

1. [概要](#概要)
2. [ディレクトリ構造](#ディレクトリ構造)
3. [プラグイン詳細](#プラグイン詳細)
4. [インストール方法](#インストール方法)

---

## 概要

### 採用方式

**サブディレクトリ方式**: 1 つのリポジトリ内に言語ごとのプラグインディレクトリを配置

### メリット

- ✅ **管理が簡単** - 1 つのリポジトリで全言語を管理
- ✅ **更新が容易** - 一括更新が可能
- ✅ **シンプルな構造** - マーケットプレイスリポジトリ不要
- ✅ **バージョン統一** - 全言語で同じバージョン番号

### 対応言語

1. **日本語** (`plugins/ja/`)
2. **英語** (`plugins/en/`)
3. **韓国語** (`plugins/ko/`)
4. **スペイン語** (`plugins/es/`)
5. **フランス語** (`plugins/fr/`)
6. **ポルトガル語** (`plugins/pt/`)
7. **簡体中国語** (`plugins/zh-cn/`)
8. **繁体中国語** (`plugins/zh-tw/`)

---

## ディレクトリ構造

### リポジトリ全体像

```
wasabeef/claude-code-cookbook/
├── plugins/
│   ├── ja/                           # 日本語版プラグイン
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json           # プラグインメタデータ
│   │   ├── commands/                 # コマンド 39 個
│   │   │   ├── compact.md
│   │   │   ├── task.md
│   │   │   ├── plan.md
│   │   │   └── ... (36 more)
│   │   ├── agents/
│   │   │   └── roles/                # ロール 9 個
│   │   │       ├── security.md
│   │   │       ├── analyzer.md
│   │   │       └── ... (7 more)
│   │   └── README.md
│   │
│   ├── en/                           # 英語版プラグイン
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/                 # 39 commands
│   │   ├── agents/
│   │   │   └── roles/                # 9 roles
│   │   └── README.md
│   │
│   ├── ko/                           # 韓国語版プラグイン
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/                 # 39 명령어
│   │   ├── agents/
│   │   │   └── roles/                # 9 역할
│   │   └── README.md
│   │
│   ├── es/                           # スペイン語版プラグイン
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/                 # 39 comandos
│   │   ├── agents/
│   │   │   └── roles/                # 9 roles
│   │   └── README.md
│   │
│   ├── fr/                           # フランス語版プラグイン
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/                 # 39 commandes
│   │   ├── agents/
│   │   │   └── roles/                # 9 rôles
│   │   └── README.md
│   │
│   ├── pt/                           # ポルトガル語版プラグイン
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/                 # 39 comandos
│   │   ├── agents/
│   │   │   └── roles/                # 9 funções
│   │   └── README.md
│   │
│   ├── zh-cn/                        # 簡体中国語版プラグイン
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/                 # 39 命令
│   │   ├── agents/
│   │   │   └── roles/                # 9 角色
│   │   └── README.md
│   │
│   └── zh-tw/                        # 繁体中国語版プラグイン
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── commands/                 # 39 命令
│       ├── agents/
│       │   └── roles/                # 9 角色
│       └── README.md
│
├── docs/                             # ドキュメント (プラグインに含まれない)
│   ├── plugin-installation-guide.md
│   ├── plugin-directory-structure.md
│   └── plugin-migration-plan-simple.md
│
├── commands/                         # オリジナル日本語版 (main ブランチ用)
├── agents/                           # オリジナル日本語版 (main ブランチ用)
├── locales/                          # 翻訳ファイル (main ブランチ用)
├── README.md                         # リポジトリ README
└── LICENSE                           # Apache-2.0
```

---

## プラグイン詳細

### 日本語版プラグイン (`plugins/ja/`)

#### ディレクトリ構造

```
plugins/ja/
├── .claude-plugin/
│   └── plugin.json                   # 120 bytes
├── commands/                         # 39 files (~150 KB)
│   ├── analyze-dependencies.md
│   ├── analyze-performance.md
│   ├── check-fact.md
│   ├── check-github-ci.md
│   ├── commit-message.md
│   ├── compact.md
│   ├── compare-solutions.md
│   ├── create-gif.md
│   ├── create-video.md
│   ├── debug-analyzer.md
│   ├── deny-check.md
│   ├── extract-code.md
│   ├── generate-diagram.md
│   ├── generate-readme.md
│   ├── gen-deny-log.md
│   ├── merge-request.md
│   ├── plan.md
│   ├── pr-create.md
│   ├── pr-feedback.md
│   ├── pr-issue.md
│   ├── pr-list.md
│   ├── pr-review.md
│   ├── refactor.md
│   ├── release-note.md
│   ├── role.md
│   ├── semantic-commit.md
│   ├── smart-review.md
│   ├── spec.md
│   ├── summarize.md
│   ├── task.md
│   ├── tech-debt.md
│   ├── translate.md
│   ├── ultrathink.md
│   ├── update-dependency.md
│   ├── web-accessibility-audit.md
│   ├── workspace-map.md
│   ├── write-diary.md
│   ├── write-document.md
│   └── write-test.md
├── agents/
│   └── roles/                        # 9 files (~30 KB)
│       ├── analyzer.md
│       ├── architect.md
│       ├── backend.md
│       ├── frontend.md
│       ├── mobile.md
│       ├── performance.md
│       ├── qa.md
│       ├── reviewer.md
│       └── security.md
└── README.md                         # 1 KB
```

**合計サイズ**: 約 181 KB (51 ファイル)

#### plugin.json

```json
{
  "name": "claude-code-cookbook-ja",
  "version": "1.0.0",
  "description": "Claude Code の強力なコマンド・ロール集（日本語版）",
  "author": "wasabeef",
  "repository": "wasabeef/claude-code-cookbook",
  "license": "Apache-2.0",
  "keywords": [
    "japanese",
    "commands",
    "roles",
    "productivity",
    "development"
  ]
}
```

---

### 英語版プラグイン (`plugins/en/`)

#### ディレクトリ構造

```
plugins/en/
├── .claude-plugin/
│   └── plugin.json                   # 120 bytes
├── commands/                         # 39 files (~150 KB)
│   ├── analyze-dependencies.md
│   ├── analyze-performance.md
│   ├── ... (same 39 commands in English)
│   └── write-test.md
├── agents/
│   └── roles/                        # 9 files (~30 KB)
│       ├── analyzer.md
│       ├── ... (same 9 roles in English)
│       └── security.md
└── README.md                         # 1 KB
```

**合計サイズ**: 約 181 KB (51 ファイル)

#### plugin.json

```json
{
  "name": "claude-code-cookbook-en",
  "version": "1.0.0",
  "description": "Powerful commands and roles collection for Claude Code (English)",
  "author": "wasabeef",
  "repository": "wasabeef/claude-code-cookbook",
  "license": "Apache-2.0",
  "keywords": [
    "english",
    "commands",
    "roles",
    "productivity",
    "development"
  ]
}
```

---

### 韓国語版プラグイン (`plugins/ko/`)

#### ディレクトリ構造

```
plugins/ko/
├── .claude-plugin/
│   └── plugin.json                   # 120 bytes
├── commands/                         # 39 files (~150 KB)
│   ├── analyze-dependencies.md
│   ├── analyze-performance.md
│   ├── ... (same 39 commands in Korean)
│   └── write-test.md
├── agents/
│   └── roles/                        # 9 files (~30 KB)
│       ├── analyzer.md
│       ├── ... (same 9 roles in Korean)
│       └── security.md
└── README.md                         # 1 KB
```

**合計サイズ**: 約 181 KB (51 ファイル)

#### plugin.json

```json
{
  "name": "claude-code-cookbook-ko",
  "version": "1.0.0",
  "description": "Claude Code를 위한 강력한 명령어 및 역할 모음 (한국어)",
  "author": "wasabeef",
  "repository": "wasabeef/claude-code-cookbook",
  "license": "Apache-2.0",
  "keywords": [
    "korean",
    "commands",
    "roles",
    "productivity",
    "development"
  ]
}
```

---

## インストール方法

### 基本インストール

```bash
# 日本語版
/plugin install wasabeef/claude-code-cookbook/plugins/ja

# 英語版
/plugin install wasabeef/claude-code-cookbook/plugins/en

# 韓国語版
/plugin install wasabeef/claude-code-cookbook/plugins/ko

# スペイン語版
/plugin install wasabeef/claude-code-cookbook/plugins/es

# フランス語版
/plugin install wasabeef/claude-code-cookbook/plugins/fr

# ポルトガル語版
/plugin install wasabeef/claude-code-cookbook/plugins/pt

# 簡体中国語版
/plugin install wasabeef/claude-code-cookbook/plugins/zh-cn

# 繁体中国語版
/plugin install wasabeef/claude-code-cookbook/plugins/zh-tw
```

### 言語切り替え

```bash
# 現在のプラグインを無効化
/plugin disable claude-code-cookbook-ja

# 新しい言語をインストール
/plugin install wasabeef/claude-code-cookbook/plugins/en
```

### ローカルテスト (開発者向け)

```bash
# リポジトリをクローン
git clone https://github.com/wasabeef/claude-code-cookbook.git
cd claude-code-cookbook

# ローカルパスからインストール
/plugin install ./plugins/ja
/plugin install ./plugins/en
/plugin install ./plugins/ko
/plugin install ./plugins/es
/plugin install ./plugins/fr
/plugin install ./plugins/pt
/plugin install ./plugins/zh-cn
/plugin install ./plugins/zh-tw
```

---

## ファイルサイズまとめ

### プラグインごとのサイズ

| プラグイン | ファイル数 | サイズ |
|:---|---:|---:|
| 日本語版 (`plugins/ja/`) | 51 | ~181 KB |
| 英語版 (`plugins/en/`) | 51 | ~181 KB |
| 韓国語版 (`plugins/ko/`) | 51 | ~181 KB |
| スペイン語版 (`plugins/es/`) | 51 | ~181 KB |
| フランス語版 (`plugins/fr/`) | 51 | ~181 KB |
| ポルトガル語版 (`plugins/pt/`) | 51 | ~181 KB |
| 簡体中国語版 (`plugins/zh-cn/`) | 51 | ~181 KB |
| 繁体中国語版 (`plugins/zh-tw/`) | 51 | ~181 KB |
| **合計** | **408** | **~1.4 MB** |

### ファイル内訳

| カテゴリ | ファイル数 | サイズ (1 言語) |
|:---|---:|---:|
| plugin.json | 1 | ~120 bytes |
| Commands | 39 | ~150 KB |
| Roles | 9 | ~30 KB |
| README.md | 1 | ~1 KB |
| **合計** | **51** | **~181 KB** |

---

## プラグイン管理

### インストール済みプラグイン確認

```bash
/plugin list
```

**表示例**:

```
Installed Plugins:

1. claude-code-cookbook-ja (v1.0.0)
   Status: ✅ Enabled
   Commands: 39
   Roles: 9
   Path: wasabeef/claude-code-cookbook/plugins/ja
```

### プラグイン情報確認

```bash
/plugin info claude-code-cookbook-ja
```

**表示例**:

```
Plugin: claude-code-cookbook-ja
Version: 1.0.0
Author: wasabeef
License: Apache-2.0
Repository: wasabeef/claude-code-cookbook

Description:
Claude Code の強力なコマンド・ロール集（日本語版）

Contents:
- Commands: 39
- Roles: 9

Status: ✅ Enabled
```

---

## まとめ

### 構造の特徴

1. **1 リポジトリ管理** - wasabeef/claude-code-cookbook で全言語を管理
2. **サブディレクトリ方式** - 8 言語対応 (`plugins/ja/`, `plugins/en/`, `plugins/ko/`, `plugins/es/`, `plugins/fr/`, `plugins/pt/`, `plugins/zh-cn/`, `plugins/zh-tw/`)
3. **独立したプラグイン** - 各言語は完全に独立
4. **シンプルなインストール** - パス指定だけでインストール可能

---

**文書管理**

| 項目 | 内容 |
|:---|:---|
| 作成者 | Claude (Sonnet 4.5) |
| 最終更新 | 2025-10-14 |
| バージョン | 3.0.0 |
| 変更内容 | Phase 2 完了：全 8 言語対応 (ja, en, ko, es, fr, pt, zh-cn, zh-tw) |
| 関連文書 | plugin-installation-guide.md, plugin-migration-plan-simple.md |
