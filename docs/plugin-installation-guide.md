# Claude Code Cookbook - Plugin インストールガイド

**作成日**: 2025-10-14
**バージョン**: 1.0.0

## 目次

1. [基本的なインストール方法](#基本的なインストール方法)
2. [詳細なインストール手順](#詳細なインストール手順)
3. [言語の切り替え方法](#言語の切り替え方法)
4. [アンインストール方法](#アンインストール方法)
5. [トラブルシューティング](#トラブルシューティング)
6. [よくある質問 (FAQ)](#よくある質問-faq)

---

## 基本的なインストール方法

### 最短インストール手順

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

これだけで、39 個のコマンドと 9 つの役割が利用可能になります。

---

## 詳細なインストール手順

### プラグインのインストール

プラグインをリポジトリのサブディレクトリパスで直接インストールします。

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

**実行例** (日本語版):

```
You: /plugin install wasabeef/claude-code-cookbook/plugins/ja

Claude: Installing claude-code-cookbook-ja v1.0.0...

Downloading plugin files...
✓ plugin.json
✓ 39 commands
✓ 9 roles
✓ README_ja.md
✓ LICENSE

Installing to ~/.claude/...
✓ Commands installed: 39
✓ Roles installed: 9

✅ Plugin installed successfully!

Available commands:
  /analyze-dependencies   /analyze-performance   /check-fact
  /check-github-ci       /commit-message        /plan
  /pr-create             /pr-review             /refactor
  /role                  /task                  /ultrathink
  ... and 27 more

Available roles:
  /role analyzer         /role architect        /role backend
  /role frontend         /role mobile           /role performance
  /role qa               /role reviewer         /role security

Try /help for full command list
```

---

### Step 3: インストールの確認

#### コマンド一覧の表示

```bash
/help
```

**表示例**:

```
Available Commands:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Built-in Commands:
  /help      - Show this help message
  /clear     - Clear conversation history
  /model     - Change AI model

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Plugin Commands (claude-code-cookbook-ja):

開発ワークフロー:
  /plan                  - 実装計画立案
  /spec                  - 仕様書作成
  /task                  - タスクエージェント起動

Pull Request:
  /pr-create             - PR 自動作成
  /pr-review             - PR レビュー
  /pr-feedback           - レビューコメント対応
  /pr-list               - オープン PR 一覧
  /pr-issue              - オープン Issue 一覧

コード品質:
  /refactor              - リファクタリング
  /smart-review          - 高度レビュー
  /analyze-dependencies  - 依存関係分析
  /analyze-performance   - パフォーマンス分析
  /tech-debt             - 技術的負債分析

Git:
  /commit-message        - コミットメッセージ生成
  /semantic-commit       - セマンティックコミット

役割 (Roles):
  /role analyzer         - システム分析専門家
  /role architect        - ソフトウェアアーキテクト
  /role backend          - バックエンド専門家
  /role frontend         - フロントエンド専門家
  /role mobile           - モバイル開発専門家
  /role performance      - パフォーマンス最適化専門家
  /role qa               - QA エンジニア
  /role reviewer         - コードレビュアー
  /role security         - セキュリティ専門家

... and more. Type /help <command> for details.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

#### インストール済みプラグインの確認

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
   Installed: 2025-10-14 10:30:00

[Disable] [Uninstall] [Update]
```

---

## 言語の切り替え方法

### 方法 1: 無効化 + 有効化 (推奨)

現在のプラグインを無効化して、別の言語を有効化します。

```bash
# 現在のプラグインを無効化 (日本語)
/plugin disable claude-code-cookbook-ja

# 新しい言語のプラグインをインストール (韓国語)
/plugin install wasabeef/claude-code-cookbook/plugins/ko
```

**実行例**:

```
You: /plugin disable claude-code-cookbook-ja

Claude: Disabling claude-code-cookbook-ja...
✅ Plugin disabled successfully!

Commands: 39 removed
Roles: 9 removed

You: /plugin install wasabeef/claude-code-cookbook/plugins/ko

Claude: Installing claude-code-cookbook-ko v1.0.0...
✅ Plugin installed successfully!

Commands: 39 added (Korean)
Roles: 9 added (Korean)
```

### 方法 2: アンインストール + インストール

完全にアンインストールしてから新しい言語をインストールします。

```bash
# アンインストール
/plugin uninstall claude-code-cookbook-ja

# 新しい言語をインストール
/plugin install wasabeef/claude-code-cookbook/plugins/en
```

**実行例**:

```
You: /plugin uninstall claude-code-cookbook-ja

Claude: ⚠️  Are you sure you want to uninstall claude-code-cookbook-ja?
This will remove:
  - 39 commands
  - 9 roles

Type 'yes' to confirm: yes

Uninstalling claude-code-cookbook-ja...
✅ Plugin uninstalled successfully!

You: /plugin install wasabeef/claude-code-cookbook/plugins/en

Claude: Installing claude-code-cookbook-en v1.0.0...
✅ Plugin installed successfully!

Commands: 39 added (English)
Roles: 9 added (English)
```

### 言語切り替えチートシート

| 現在の言語 | 切り替え先 | コマンド |
|:---|:---|:---|
| 日本語 | 英語 | `/plugin disable claude-code-cookbook-ja && /plugin install wasabeef/claude-code-cookbook/plugins/en` |
| 日本語 | 韓国語 | `/plugin disable claude-code-cookbook-ja && /plugin install wasabeef/claude-code-cookbook/plugins/ko` |
| 英語 | 日本語 | `/plugin disable claude-code-cookbook-en && /plugin install wasabeef/claude-code-cookbook/plugins/ja` |
| 韓国語 | 英語 | `/plugin disable claude-code-cookbook-ko && /plugin install wasabeef/claude-code-cookbook/plugins/en` |

---

## アンインストール方法

### プラグインのアンインストール

```bash
/plugin uninstall claude-code-cookbook-ja
```

**実行例**:

```
You: /plugin uninstall claude-code-cookbook-ja

Claude: ⚠️  Are you sure you want to uninstall claude-code-cookbook-ja?
This will remove:
  - 39 commands
  - 9 roles
  - All plugin data

Type 'yes' to confirm: yes

Uninstalling claude-code-cookbook-ja...
Removing files...
✓ Commands removed: 39
✓ Roles removed: 9
✓ Plugin data cleared

✅ Plugin uninstalled successfully!
```

### マーケットプレイスの削除

```bash
/plugin marketplace remove wasabeef/claude-code-cookbook-marketplace
```

**実行例**:

```
You: /plugin marketplace remove wasabeef/claude-code-cookbook-marketplace

Claude: Removing marketplace: claude-code-cookbook-marketplace
✅ Marketplace removed successfully!

Note: Installed plugins from this marketplace will remain installed.
Use /plugin uninstall to remove them.
```

---

## プラグイン管理コマンド一覧

### プラグイン管理

| コマンド | 説明 | 例 |
|:---|:---|:---|
| `/plugin` | インタラクティブメニュー | `/plugin` |
| `/plugin install <path>` | プラグインインストール | `/plugin install wasabeef/claude-code-cookbook/plugins/ja` |
| `/plugin uninstall <name>` | プラグインアンインストール | `/plugin uninstall claude-code-cookbook-ja` |
| `/plugin list` | インストール済みプラグイン一覧 | `/plugin list` |
| `/plugin enable <name>` | プラグイン有効化 | `/plugin enable claude-code-cookbook-ja` |
| `/plugin disable <name>` | プラグイン無効化 | `/plugin disable claude-code-cookbook-ja` |
| `/plugin update <name>` | プラグイン更新 | `/plugin update claude-code-cookbook-ja` |
| `/plugin info <name>` | プラグイン詳細情報 | `/plugin info claude-code-cookbook-ja` |

---

## トラブルシューティング

### 問題 1: プラグインがインストールできない

**エラーメッセージ**:

```
❌ Failed to install plugin: Repository path not found
```

**解決策**:

1. インストールパスを確認

```bash
# 正しい形式
/plugin install wasabeef/claude-code-cookbook/plugins/ja

# 間違った形式
/plugin install claude-code-cookbook-ja              # NG
/plugin install wasabeef/claude-code-cookbook       # NG (サブディレクトリが必要)
/plugin install wasabeef/cookbook/plugins/ja        # NG (リポジトリ名が間違い)
```

2. GitHub の接続確認

```bash
# GitHub への接続を確認
gh auth status
```

3. 再試行

```bash
/plugin install wasabeef/claude-code-cookbook/plugins/ja
```

---

### 問題 2: コマンドが認識されない

**症状**:

```bash
You: /plan

Claude: ❌ Unknown command: /plan
```

**解決策**:

1. プラグインがインストールされているか確認

```bash
/plugin list
```

2. プラグインが有効化されているか確認

```bash
/plugin list
# Status が "✅ Enabled" であることを確認
```

3. プラグインを再有効化

```bash
/plugin disable claude-code-cookbook-ja
/plugin enable claude-code-cookbook-ja
```

4. Claude Code を再起動

```bash
# ターミナルの場合
exit
claude

# VS Code の場合
VS Code を再起動
```

---

### 問題 3: 複数言語のプラグインを同時にインストールした場合

**症状**:

```bash
You: /plan

Claude: ⚠️  Multiple definitions found for command: /plan
- claude-code-cookbook-ja
- claude-code-cookbook-en

Which one would you like to use?
```

**解決策**:

1 つの言語のみを有効化します。

```bash
# 日本語を使う場合
/plugin disable claude-code-cookbook-en

# 英語を使う場合
/plugin disable claude-code-cookbook-ja
```

**推奨**: 1 つの言語のみをインストールしてください。

---

### 問題 4: プラグインの更新ができない

**エラーメッセージ**:

```
❌ Failed to update plugin: Already at latest version
```

**解決策**:

1. 最新バージョンを確認

```bash
/plugin info claude-code-cookbook-ja
```

2. 強制再インストール

```bash
/plugin uninstall claude-code-cookbook-ja
/plugin install claude-code-cookbook-ja
```

---

## よくある質問 (FAQ)

### Q1: 複数の言語を同時に使えますか？

**A**: 技術的には可能ですが、**推奨しません**。

理由:

- コマンド名が衝突する可能性
- 混乱を招く可能性
- メモリ使用量の増加

推奨:

- 1 つの言語のみをインストール
- 言語を切り替える場合は、古いプラグインを無効化

```bash
# OK: 1 言語のみ
/plugin install claude-code-cookbook-ja

# NG: 複数言語 (非推奨)
/plugin install claude-code-cookbook-ja
/plugin install claude-code-cookbook-en
```

---

### Q2: プラグインはどこにインストールされますか？

**A**: ユーザーの Claude 設定ディレクトリにインストールされます。

```
~/.claude/
├── commands/          # プラグインのコマンド
├── agents/            # プラグインのロール
└── plugins/           # プラグインデータ
    └── claude-code-cookbook-ja/
```

---

### Q3: プラグインをアンインストールしたら、設定も削除されますか？

**A**: はい、プラグインに関連する全てのファイルが削除されます。

削除される内容:

- ✅ Commands (39 個)
- ✅ Roles (9 個)
- ✅ プラグイン設定
- ✅ プラグインデータ

削除されない内容:

- ❌ ユーザー設定 (`~/.claude/settings.json`)
- ❌ 会話履歴
- ❌ 他のプラグイン

---

### Q4: プラグインは自動更新されますか？

**A**: いいえ、手動で更新する必要があります。

更新方法:

```bash
# 方法 1: update コマンド
/plugin update claude-code-cookbook-ja

# 方法 2: 再インストール
/plugin uninstall claude-code-cookbook-ja
/plugin install claude-code-cookbook-ja
```

更新の確認:

```bash
/plugin info claude-code-cookbook-ja
```

---

### Q5: オフラインでプラグインをインストールできますか？

**A**: いいえ、インストールには GitHub への接続が必要です。

理由:

- プラグインファイルは GitHub から取得
- マーケットプレイスも GitHub でホスト

事前ダウンロード (将来のオフライン使用):

```bash
# プラグインをインストールした状態でオフラインに
/plugin install claude-code-cookbook-ja
# → 以降はオフラインでも使用可能
```

---

### Q6: プラグインのサイズはどれくらいですか？

**A**: 各プラグインは約 **200 KB** です。

内訳:

- Commands: 39 ファイル (約 150 KB)
- Roles: 9 ファイル (約 30 KB)
- 設定・ドキュメント: 約 20 KB

全言語をインストールした場合:

- 8 プラグイン × 200 KB = 約 1.6 MB

---

### Q7: VS Code と Terminal の両方でプラグインを使えますか？

**A**: はい、**共通の設定ディレクトリ** (`~/.claude/`) を使用するため、両方で利用可能です。

```bash
# Terminal でインストール
claude
/plugin install claude-code-cookbook-ja

# VS Code でも自動的に利用可能
# (VS Code の Claude Code 拡張機能を起動)
```

---

### Q8: プラグインの設定をカスタマイズできますか？

**A**: はい、設定ファイルを編集することでカスタマイズできます。

設定ファイルの場所:

```
~/.claude/settings.json
```

カスタマイズ例:

```json
{
  "plugins": {
    "claude-code-cookbook-ja": {
      "enabled": true,
      "priority": 1
    }
  }
}
```

---

### Q9: プラグインが原因で問題が発生した場合、どうすればいいですか？

**A**: プラグインを一時的に無効化して、問題を切り分けます。

```bash
# プラグインを無効化
/plugin disable claude-code-cookbook-ja

# 問題が解決したか確認
# ...

# 問題が解決した場合、プラグインを再インストール
/plugin uninstall claude-code-cookbook-ja
/plugin install claude-code-cookbook-ja

# 問題が続く場合、Issue を報告
# https://github.com/wasabeef/claude-code-cookbook/issues
```

---

### Q10: プラグインの開発に貢献できますか？

**A**: はい、歓迎します！

貢献方法:

1. GitHub リポジトリをフォーク
   - <https://github.com/wasabeef/claude-code-cookbook>

2. 新しいコマンドやロールを追加

3. Pull Request を作成

詳細は貢献ガイドラインを参照:

- <https://github.com/wasabeef/claude-code-cookbook/blob/main/CONTRIBUTING.md>

---

## クイックリファレンス

### インストール (最速)

```bash
# 日本語版
/plugin install wasabeef/claude-code-cookbook/plugins/ja

# 英語版
/plugin install wasabeef/claude-code-cookbook/plugins/en

# 韓国語版
/plugin install wasabeef/claude-code-cookbook/plugins/ko
```

### 言語切り替え

```bash
# 日本語 → 英語
/plugin disable claude-code-cookbook-ja && /plugin install wasabeef/claude-code-cookbook/plugins/en

# 英語 → 韓国語
/plugin disable claude-code-cookbook-en && /plugin install wasabeef/claude-code-cookbook/plugins/ko
```

### アンインストール

```bash
/plugin uninstall claude-code-cookbook-ja
```

### 更新

```bash
/plugin update claude-code-cookbook-ja
```

### 確認

```bash
/plugin list          # インストール済みプラグイン
/help                 # 利用可能なコマンド
```

---

## まとめ

### インストール手順 (2 ステップ)

1. **プラグインインストール**

   ```bash
   /plugin install wasabeef/claude-code-cookbook/plugins/ja
   ```

2. **動作確認**

   ```bash
   /help
   /plan
   ```

### 推奨事項

- ✅ 1 つの言語のみをインストール
- ✅ 定期的に更新を確認
- ✅ 問題があれば Issue を報告
- ❌ 複数言語の同時インストールは非推奨

### サポート

- **ドキュメント**: <https://github.com/wasabeef/claude-code-cookbook>
- **Issue**: <https://github.com/wasabeef/claude-code-cookbook/issues>
- **Discussions**: <https://github.com/wasabeef/claude-code-cookbook/discussions>

---

**文書管理**

| 項目 | 内容 |
|:---|:---|
| 作成者 | Claude (Sonnet 4.5) |
| 最終更新 | 2025-10-14 |
| バージョン | 1.0.0 |
| 関連文書 | plugin-migration-plan-simple.md, plugin-directory-structure.md |
