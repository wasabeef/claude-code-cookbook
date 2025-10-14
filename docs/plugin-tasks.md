# Claude Code Cookbook - Plugin 化タスクリスト

**作成日**: 2025-10-14
**ブランチ**: `feat-plugins`
**ステータス**: Phase 0 (準備中)

## 📋 全体の進捗

| Phase | 期間 | ステータス | 進捗 |
|:---|:---:|:---:|---:|
| Phase 0: 準備 | Week 1 | 🟡 進行中 | 30% |
| Phase 1: リポジトリ構築 | Week 2 | ⚪ 未着手 | 0% |
| Phase 2: 言語プラグイン作成 | Week 3 | ⚪ 未着手 | 0% |
| Phase 3: マーケットプレイス統合 | Week 4 | ⚪ 未着手 | 0% |
| Phase 4: テスト・改善 | Week 5 | ⚪ 未着手 | 0% |
| Phase 5: 正式リリース | Week 6 | ⚪ 未着手 | 0% |
| **全体** | **6 週間** | **🟡 進行中** | **5%** |

---

## Phase 0: 準備 (Week 1)

### タスク一覧

#### 0-1. 技術検証

- [x] Claude Code Plugin システムの調査
- [x] プラグイン構造の設計
- [x] ディレクトリ構造の策定
- [x] ドキュメント作成
  - [x] plugin-migration-plan-simple.md
  - [x] plugin-directory-structure.md
  - [x] plugin-installation-guide.md
- [ ] Claude Code 2.0.13+ の動作確認
- [ ] `claude plugin validate` コマンドの動作確認
- [ ] プラグインローカルテスト環境の構築

**進捗**: 4/7 タスク完了 (57%)

---

#### 0-2. リポジトリ戦略の決定

- [x] `feat-plugins` ブランチ作成
- [ ] マーケットプレイスリポジトリ名の最終決定
  - 候補: `claude-code-cookbook-marketplace`
- [ ] マーケットプレイスリポジトリの作成 (GitHub)
- [ ] ブランチ戦略の確定
  - main: 本番環境
  - develop: 開発環境
  - feat-*: 機能追加
- [ ] Git タグ戦略の確定
  - v1.0.0: 正式リリース
  - v1.0.0-beta1: ベータ版
  - v1.0.0-rc1: リリース候補

**進捗**: 1/5 タスク完了 (20%)

---

#### 0-3. ファイル棚卸し

- [ ] 英語版の確認 (`locales/en/`)
  - [ ] Commands 39 個の存在確認
  - [ ] Roles 9 個の存在確認
  - [ ] 内容の品質チェック
- [ ] 日本語版の確認 (`commands/`, `agents/`)
  - [ ] Commands 39 個の存在確認
  - [ ] Roles 9 個の存在確認
  - [ ] 内容の品質チェック
- [ ] 韓国語版の確認 (`locales/ko/`)
  - [ ] Commands 39 個の存在確認
  - [ ] Roles 9 個の存在確認
  - [ ] 内容の品質チェック
- [ ] ファイル名の一貫性確認
- [ ] フロントマター形式の統一確認

**進捗**: 0/5 タスク完了 (0%)

---

#### 0-4. 自動化スクリプトの準備

- [ ] `scripts/generate-plugin.sh` 作成
  - [ ] 言語コードからプラグイン生成
  - [ ] plugin.json の自動生成
  - [ ] ファイルコピーの自動化
- [ ] `scripts/validate-all.sh` 作成
  - [ ] 全プラグインの検証
  - [ ] エラーレポート生成
- [ ] スクリプトのテスト

**進捗**: 0/3 タスク完了 (0%)

---

### Phase 0 の成果物

- [x] 技術仕様書 (ドキュメント 3 点)
- [ ] マーケットプレイスリポジトリ (空)
- [ ] ファイル棚卸しレポート
- [ ] 自動化スクリプト (2 点)

**Phase 0 進捗**: 30%

---

## Phase 1: リポジトリ構築 (Week 2)

### タスク一覧

#### 1-1. マーケットプレイスリポジトリ作成

- [ ] GitHub リポジトリ作成
  - リポジトリ名: `claude-code-cookbook-marketplace`
  - 説明: Official marketplace for Claude Code Cookbook plugins
  - ライセンス: Apache-2.0
  - .gitignore 設定
- [ ] ディレクトリ構造構築

  ```
  .claude-plugin/
  plugins/
  scripts/
  README.md
  LICENSE
  ```

- [ ] `.claude-plugin/marketplace.json` 作成 (空)
- [ ] README.md 作成 (英語・日本語・韓国語)
- [ ] Git 初期コミット
- [ ] GitHub へプッシュ

**進捗**: 0/6 タスク完了 (0%)

---

#### 1-2. 英語版プラグイン作成

- [ ] `plugins/en/` ディレクトリ作成
- [ ] `plugins/en/.claude-plugin/plugin.json` 作成
  - name: claude-code-cookbook-en
  - version: 1.0.0-beta1
  - description, author, keywords など
- [ ] Commands 39 個を配置
  - [ ] `locales/en/commands/*.md` → `plugins/en/commands/*.md`
  - [ ] ファイル数確認 (39 個)
  - [ ] フロントマター確認
- [ ] Roles 9 個を配置
  - [ ] `locales/en/agents/roles/*.md` → `plugins/en/agents/roles/*.md`
  - [ ] ファイル数確認 (9 個)
  - [ ] フロントマター確認
- [ ] `plugins/en/README.md` 作成
- [ ] `plugins/en/LICENSE` コピー
- [ ] 検証: `claude plugin validate plugins/en`
- [ ] Git コミット

**進捗**: 0/8 タスク完了 (0%)

---

#### 1-3. ローカルテスト (英語版)

- [ ] プラグインをローカルインストール

  ```bash
  /plugin marketplace add ./claude-code-cookbook-marketplace
  /plugin install claude-code-cookbook-en
  ```

- [ ] コマンドテスト
  - [ ] `/help` でコマンド一覧表示確認
  - [ ] `/plan` 実行テスト
  - [ ] `/pr-create` 実行テスト
  - [ ] その他主要コマンド 10 個テスト
- [ ] ロールテスト
  - [ ] `/role architect` 実行テスト
  - [ ] `/role security` 実行テスト
  - [ ] その他ロール 5 個テスト
- [ ] 問題点の記録と修正

**進捗**: 0/4 タスク完了 (0%)

---

### Phase 1 の成果物

- [ ] マーケットプレイスリポジトリ (GitHub)
- [ ] `claude-code-cookbook-en` v1.0.0-beta1
- [ ] テストレポート (英語版)

**Phase 1 進捗**: 0%

---

## Phase 2: 言語プラグイン作成 (Week 3)

### タスク一覧

#### 2-1. 日本語版プラグイン作成

- [ ] `plugins/ja/` ディレクトリ作成
- [ ] `plugins/ja/.claude-plugin/plugin.json` 作成
  - name: claude-code-cookbook-ja
  - version: 1.0.0-beta1
  - keywords に "japanese", "日本語" を追加
- [ ] Commands 39 個を配置
  - [ ] `commands/*.md` → `plugins/ja/commands/*.md`
  - [ ] ファイル数確認 (39 個)
  - [ ] 日本語内容確認
- [ ] Roles 9 個を配置
  - [ ] `agents/roles/*.md` → `plugins/ja/agents/roles/*.md`
  - [ ] ファイル数確認 (9 個)
  - [ ] 日本語内容確認
- [ ] `plugins/ja/README_ja.md` 作成
- [ ] `plugins/ja/LICENSE` コピー
- [ ] 検証: `claude plugin validate plugins/ja`
- [ ] Git コミット

**進捗**: 0/8 タスク完了 (0%)

---

#### 2-2. 日本語版ローカルテスト

- [ ] 英語版プラグインをアンインストール

  ```bash
  /plugin uninstall claude-code-cookbook-en
  ```

- [ ] 日本語版プラグインをインストール

  ```bash
  /plugin install claude-code-cookbook-ja
  ```

- [ ] コマンドテスト (日本語)
  - [ ] `/help` でコマンド一覧表示確認
  - [ ] `/plan` 実行テスト (日本語応答確認)
  - [ ] `/pr-create` 実行テスト
  - [ ] その他主要コマンド 10 個テスト
- [ ] ロールテスト (日本語)
  - [ ] `/role architect` 実行テスト
  - [ ] `/role security` 実行テスト
  - [ ] その他ロール 5 個テスト
- [ ] 問題点の記録と修正

**進捗**: 0/5 タスク完了 (0%)

---

#### 2-3. 韓国語版プラグイン作成

- [ ] `plugins/ko/` ディレクトリ作成
- [ ] `plugins/ko/.claude-plugin/plugin.json` 作成
  - name: claude-code-cookbook-ko
  - version: 1.0.0-beta1
  - keywords に "korean", "한국어" を追加
- [ ] Commands 39 個を配置
  - [ ] `locales/ko/commands/*.md` → `plugins/ko/commands/*.md`
  - [ ] ファイル数確認 (39 個)
  - [ ] 韓国語内容確認
- [ ] Roles 9 個を配置
  - [ ] `locales/ko/agents/roles/*.md` → `plugins/ko/agents/roles/*.md`
  - [ ] ファイル数確認 (9 個)
  - [ ] 韓国語内容確認
- [ ] `plugins/ko/README_ko.md` 作成
- [ ] `plugins/ko/LICENSE` コピー
- [ ] 検証: `claude plugin validate plugins/ko`
- [ ] Git コミット

**進捗**: 0/8 タスク完了 (0%)

---

#### 2-4. 韓国語版ローカルテスト

- [ ] 日本語版プラグインをアンインストール
- [ ] 韓国語版プラグインをインストール
- [ ] コマンドテスト (韓国語)
  - [ ] 主要コマンド 10 個テスト
- [ ] ロールテスト (韓国語)
  - [ ] 主要ロール 5 個テスト
- [ ] 問題点の記録と修正

**進捗**: 0/4 タスク完了 (0%)

---

### Phase 2 の成果物

- [ ] `claude-code-cookbook-ja` v1.0.0-beta1
- [ ] `claude-code-cookbook-ko` v1.0.0-beta1
- [ ] テストレポート (日本語版・韓国語版)

**Phase 2 進捗**: 0%

---

## Phase 3: マーケットプレイス統合 (Week 4)

### タスク一覧

#### 3-1. marketplace.json の作成

- [ ] `.claude-plugin/marketplace.json` 作成
  - name: claude-code-cookbook-marketplace
  - owner 情報
  - metadata
- [ ] 3 プラグインの登録
  - [ ] claude-code-cookbook-en
  - [ ] claude-code-cookbook-ja
  - [ ] claude-code-cookbook-ko
- [ ] Featured プラグイン設定 (3 つとも featured: true)
- [ ] カテゴリ・キーワード設定
- [ ] 検証: `claude plugin validate .claude-plugin/marketplace.json`
- [ ] Git コミット

**進捗**: 0/6 タスク完了 (0%)

---

#### 3-2. マーケットプレイス README 作成

- [ ] README.md 作成 (英語)
  - Available Plugins セクション
  - Installation セクション
  - Features セクション
- [ ] README_ja.md 作成 (日本語)
- [ ] README_ko.md 作成 (韓国語)
- [ ] ライセンス情報の追加
- [ ] Git コミット

**進捗**: 0/5 タスク完了 (0%)

---

#### 3-3. マーケットプレイステスト

- [ ] GitHub からマーケットプレイス追加テスト

  ```bash
  /plugin marketplace add wasabeef/claude-code-cookbook-marketplace
  ```

- [ ] プラグイン一覧表示テスト

  ```bash
  /plugin
  ```

- [ ] 各プラグインのインストールテスト
  - [ ] 英語版インストール
  - [ ] 日本語版インストール
  - [ ] 韓国語版インストール
- [ ] プラグイン切り替えテスト
  - [ ] 日本語 → 英語
  - [ ] 英語 → 韓国語
  - [ ] 韓国語 → 日本語
- [ ] 問題点の記録と修正

**進捗**: 0/5 タスク完了 (0%)

---

#### 3-4. ドキュメント整備

- [ ] インストールガイドの更新
  - 実際の URL に更新
  - スクリーンショット追加 (オプション)
- [ ] トラブルシューティングの更新
  - 実際に発生した問題を追加
- [ ] FAQ の更新
- [ ] Git コミット

**進捗**: 0/4 タスク完了 (0%)

---

### Phase 3 の成果物

- [ ] マーケットプレイス v1.0.0-rc1
- [ ] 3 言語対応ドキュメント
- [ ] マーケットプレイステストレポート

**Phase 3 進捗**: 0%

---

## Phase 4: テスト・改善 (Week 5)

### タスク一覧

#### 4-1. 包括的テスト

- [ ] 全 Commands の動作確認 (39 × 3 言語 = 117 ケース)
  - [ ] 英語版: 39 コマンド
  - [ ] 日本語版: 39 コマンド
  - [ ] 韓国語版: 39 コマンド
- [ ] 全 Roles の動作確認 (9 × 3 言語 = 27 ケース)
  - [ ] 英語版: 9 ロール
  - [ ] 日本語版: 9 ロール
  - [ ] 韓国語版: 9 ロール
- [ ] プラグイン切り替えテスト
  - [ ] 5 回以上の切り替えテスト
  - [ ] データの整合性確認
- [ ] クロスプラットフォームテスト
  - [ ] macOS でのテスト
  - [ ] Linux でのテスト
  - [ ] Windows でのテスト (オプション)
- [ ] テストレポート作成

**進捗**: 0/5 タスク完了 (0%)

---

#### 4-2. フィードバック収集

- [ ] 内部レビュー
  - [ ] 開発者自身での最終確認
  - [ ] ドキュメントの再確認
- [ ] クローズドベータテスト
  - [ ] テスター 5-10 名の募集
  - [ ] テスト用 Issue テンプレート作成
  - [ ] フィードバック収集
- [ ] Issue トラッキング
  - [ ] 報告された問題の記録
  - [ ] 優先度付け
  - [ ] 修正計画の作成

**進捗**: 0/3 タスク完了 (0%)

---

#### 4-3. 改善・修正

- [ ] 報告されたバグの修正
  - [ ] クリティカルバグ (P0): 全て修正
  - [ ] 高優先度バグ (P1): 80% 以上修正
  - [ ] 中優先度バグ (P2): 50% 以上修正
- [ ] ドキュメントの改善
  - [ ] 誤字脱字の修正
  - [ ] 不明瞭な説明の改善
  - [ ] FAQ の追加
- [ ] パフォーマンスの最適化
  - [ ] プラグインロード時間の測定
  - [ ] 必要に応じて最適化
- [ ] バージョン更新: v1.0.0-rc2
- [ ] Git タグ付け

**進捗**: 0/5 タスク完了 (0%)

---

### Phase 4 の成果物

- [ ] v1.0.0-rc2 (リリース候補)
- [ ] テストレポート (144 ケース)
- [ ] 改善レポート

**Phase 4 進捗**: 0%

---

## Phase 5: 正式リリース (Week 6)

### タスク一覧

#### 5-1. リリース準備

- [ ] バージョン番号確定
  - 全プラグイン: v1.0.0
  - マーケットプレイス: v1.0.0
- [ ] リリースノート作成
  - [ ] 英語版
  - [ ] 日本語版
  - [ ] 韓国語版
- [ ] CHANGELOG 作成
  - v1.0.0-beta1 からの変更履歴
  - v1.0.0-rc1 からの変更履歴
  - v1.0.0-rc2 からの変更履歴
- [ ] 最終動作確認
  - [ ] 全機能の動作確認
  - [ ] ドキュメントの最終確認

**進捗**: 0/4 タスク完了 (0%)

---

#### 5-2. GitHub Release 作成

- [ ] 英語版プラグイン
  - [ ] GitHub Release 作成
  - [ ] タグ: v1.0.0-en
  - [ ] リリースノート添付
- [ ] 日本語版プラグイン
  - [ ] GitHub Release 作成
  - [ ] タグ: v1.0.0-ja
  - [ ] リリースノート添付
- [ ] 韓国語版プラグイン
  - [ ] GitHub Release 作成
  - [ ] タグ: v1.0.0-ko
  - [ ] リリースノート添付
- [ ] マーケットプレイス
  - [ ] GitHub Release 作成
  - [ ] タグ: v1.0.0
  - [ ] リリースノート添付

**進捗**: 0/4 タスク完了 (0%)

---

#### 5-3. 告知・公開

- [ ] 既存リポジトリの更新
  - [ ] README.md に Plugin インストール方法を追加
  - [ ] 従来の手動インストール方法も残す
  - [ ] 移行ガイドへのリンク
- [ ] SNS 告知
  - [ ] Twitter/X での告知
  - [ ] Bluesky での告知 (オプション)
  - [ ] Reddit での告知 (オプション)
- [ ] GitHub Discussions 投稿
  - [ ] リリースアナウンス
  - [ ] Q&A スレッド作成
- [ ] 既存ユーザーへの通知
  - [ ] GitHub Issue での通知
  - [ ] 移行ガイドの提供

**進捗**: 0/4 タスク完了 (0%)

---

#### 5-4. コミュニティマーケットプレイスへの登録 (オプション)

- [ ] ananddtyagi/claude-code-marketplace への PR
  - [ ] ベースプラグイン (英語版) のみ登録
  - [ ] PR 作成
  - [ ] レビュー対応
- [ ] jeremylongshore/claude-code-plugins への PR
  - [ ] ベースプラグイン (英語版) のみ登録
  - [ ] PR 作成
  - [ ] レビュー対応

**進捗**: 0/2 タスク完了 (0%)

---

### Phase 5 の成果物

- [ ] 正式版プラグイン v1.0.0 (3 プラグイン)
- [ ] マーケットプレイス v1.0.0
- [ ] 移行ガイド (3 言語)
- [ ] リリースアナウンス

**Phase 5 進捗**: 0%

---

## Phase 6: 残り言語追加 (Week 7-8) - オプション

### タスク一覧

#### 6-1. 簡体中国語版プラグイン

- [ ] `plugins/zh-cn/` 作成
- [ ] plugin.json 作成
- [ ] Commands/Roles 配置 (39 + 9)
- [ ] README_zh-cn.md 作成
- [ ] 検証とテスト
- [ ] Git コミット・リリース

**進捗**: 0/6 タスク完了 (0%)

---

#### 6-2. 繁体中国語版プラグイン

- [ ] `plugins/zh-tw/` 作成
- [ ] plugin.json 作成
- [ ] Commands/Roles 配置 (39 + 9)
- [ ] README_zh-tw.md 作成
- [ ] 検証とテスト
- [ ] Git コミット・リリース

**進捗**: 0/6 タスク完了 (0%)

---

#### 6-3. スペイン語版プラグイン

- [ ] `plugins/es/` 作成
- [ ] plugin.json 作成
- [ ] Commands/Roles 配置 (39 + 9)
- [ ] README_es.md 作成
- [ ] 検証とテスト
- [ ] Git コミット・リリース

**進捗**: 0/6 タスク完了 (0%)

---

#### 6-4. ポルトガル語版プラグイン

- [ ] `plugins/pt/` 作成
- [ ] plugin.json 作成
- [ ] Commands/Roles 配置 (39 + 9)
- [ ] README_pt.md 作成
- [ ] 検証とテスト
- [ ] Git コミット・リリース

**進捗**: 0/6 タスク完了 (0%)

---

#### 6-5. フランス語版プラグイン

- [ ] `plugins/fr/` 作成
- [ ] plugin.json 作成
- [ ] Commands/Roles 配置 (39 + 9)
- [ ] README_fr.md 作成
- [ ] 検証とテスト
- [ ] Git コミット・リリース

**進捗**: 0/6 タスク完了 (0%)

---

#### 6-6. マーケットプレイス更新

- [ ] marketplace.json に 5 プラグイン追加
- [ ] README 更新 (5 言語追加)
- [ ] Git コミット・リリース (v1.1.0)

**進捗**: 0/3 タスク完了 (0%)

---

### Phase 6 の成果物

- [ ] 5 つの追加プラグイン (v1.0.0)
- [ ] マーケットプレイス v1.1.0
- [ ] 合計 8 言語対応

**Phase 6 進捗**: 0%

---

## 継続的タスク

### メンテナンス

- [ ] 週次: Issue の確認と対応
- [ ] 月次: プラグインの更新確認
- [ ] 四半期: ドキュメントの見直し
- [ ] 年次: 大規模リファクタリング検討

### コミュニティサポート

- [ ] GitHub Discussions の管理
- [ ] Issue への返信 (24-48 時間以内)
- [ ] PR レビュー (1 週間以内)
- [ ] FAQ の更新

---

## タスク統計

### 全体統計

| Phase | 総タスク数 | 完了 | 進捗率 |
|:---|---:|---:|---:|
| Phase 0 | 20 | 4 | 20% |
| Phase 1 | 18 | 0 | 0% |
| Phase 2 | 25 | 0 | 0% |
| Phase 3 | 20 | 0 | 0% |
| Phase 4 | 13 | 0 | 0% |
| Phase 5 | 14 | 0 | 0% |
| Phase 6 | 33 | 0 | 0% |
| **合計** | **143** | **4** | **3%** |

### カテゴリ別統計

| カテゴリ | タスク数 |
|:---|---:|
| ドキュメント作成 | 15 |
| プラグイン作成 | 48 |
| テスト | 35 |
| Git 操作 | 25 |
| リリース作業 | 20 |

---

## 重要なマイルストーン

| マイルストーン | 予定日 | ステータス |
|:---|:---:|:---:|
| Phase 0 完了 | Week 1 終了 | 🟡 進行中 |
| 英語版プラグイン完成 | Week 2 終了 | ⚪ 未着手 |
| 3 言語プラグイン完成 | Week 3 終了 | ⚪ 未着手 |
| マーケットプレイス公開 | Week 4 終了 | ⚪ 未着手 |
| ベータテスト完了 | Week 5 終了 | ⚪ 未着手 |
| 正式リリース | Week 6 終了 | ⚪ 未着手 |
| 全 8 言語対応 | Week 8 終了 | ⚪ 未着手 |

---

## 次のアクション

### 今すぐやるべきこと (Phase 0 完了)

1. **Claude Code 2.0.13+ の動作確認**

   ```bash
   claude --version
   claude plugin --help
   ```

2. **`claude plugin validate` コマンドのテスト**

   ```bash
   # テスト用の最小プラグイン作成
   mkdir -p test-plugin/.claude-plugin
   echo '{"name":"test","version":"1.0.0"}' > test-plugin/.claude-plugin/plugin.json
   claude plugin validate test-plugin
   ```

3. **マーケットプレイスリポジトリ名の最終決定**
   - 候補: `claude-code-cookbook-marketplace`
   - 確認事項: GitHub での利用可能性

4. **ファイル棚卸しの実施**

   ```bash
   # 英語版の確認
   ls locales/en/commands/ | wc -l  # 39 個であることを確認
   ls locales/en/agents/roles/ | wc -l  # 9 個であることを確認

   # 日本語版の確認
   ls commands/ | wc -l  # 39 個であることを確認
   ls agents/roles/ | wc -l  # 9 個であることを確認

   # 韓国語版の確認
   ls locales/ko/commands/ | wc -l  # 39 個であることを確認
   ls locales/ko/agents/roles/ | wc -l  # 9 個であることを確認
   ```

5. **自動化スクリプトの作成開始**
   - `scripts/generate-plugin.sh`
   - `scripts/validate-all.sh`

---

## リスクと対応

### 高リスク項目

| リスク | 影響度 | 確率 | 対策 |
|:---|:---:|:---:|:---|
| Claude Code Plugin API の仕様変更 | 高 | 中 | 公式ドキュメント監視、早期検証 |
| 言語切り替え時のデータ損失 | 高 | 低 | 十分なテスト、バックアップ推奨 |
| マーケットプレイス認証問題 | 中 | 低 | GitHub 認証の事前確認 |

### 中リスク項目

| リスク | 影響度 | 確率 | 対策 |
|:---|:---:|:---:|:---|
| プラグインサイズの肥大化 | 中 | 中 | ファイルサイズの監視、最適化 |
| 既存ユーザーの移行抵抗 | 中 | 中 | 詳細な移行ガイド、並行運用 |
| コミュニティからの批判 | 低 | 低 | 透明性の確保、フィードバック対応 |

---

## メモ・備考

### 完了済み項目

- ✅ プラグインシステムの調査完了
- ✅ ドキュメント 3 点作成完了
- ✅ `feat-plugins` ブランチ作成完了
- ✅ 不要なドキュメント削除完了

### 保留項目

- ⏸️ Hooks のプラグイン化 → Phase 2 (Phase 1 リリース後 1-2 ヶ月)
- ⏸️ Scripts のプラグイン化 → Phase 2
- ⏸️ Assets のプラグイン化 → Phase 2

### 今後の検討事項

- カテゴリ別プラグインの提供 (例: PR ワークフローのみ)
- プラグインのバージョン自動更新機能
- プラグイン設定のカスタマイズ UI

---

**文書管理**

| 項目 | 内容 |
|:---|:---|
| 作成者 | Claude (Sonnet 4.5) |
| 最終更新 | 2025-10-14 |
| バージョン | 1.0.0 |
| 更新履歴 | 初版作成 |
