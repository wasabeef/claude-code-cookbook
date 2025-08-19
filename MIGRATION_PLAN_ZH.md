# 🇨🇳🇹🇼 中国語分離対応実装計画書

## 📋 概要

### 目的
現在の中国語対応を簡体字（zh-cn）と繁体字（zh-tw）に分離し、それぞれの言語圏のユーザーに適切な体験を提供する。

### 現状
- **現在**: `locales/zh/` に簡体字のみ（部分的な翻訳）
- **ファイル**: README_zh.md（簡体字）

### 目標
- **簡体字**: `locales/zh-cn/`（中国本土向け）
- **繁体字**: `locales/zh-tw/`（台湾・香港向け）
- **README**: README_zh-cn.md と README_zh-tw.md

## 📊 影響範囲

### 対象ファイル数
- **ルート README**: 7 ファイル（6 言語 + 新規繁体字）
- **locales 配下**: 98 ファイル（49 × 2 言語）
- **合計**: 105 ファイル

### ディレクトリ構造
```
claude-code-cookbook/
├── README_zh-cn.md     (旧: README_zh.md)
├── README_zh-tw.md     (新規)
└── locales/
    ├── zh-cn/          (旧: zh/)
    │   ├── CLAUDE.md
    │   ├── COMMAND_TEMPLATE.md
    │   ├── agents/roles/ (8 files)
    │   └── commands/ (38 files)
    └── zh-tw/          (新規)
        ├── CLAUDE.md
        ├── COMMAND_TEMPLATE.md
        ├── agents/roles/ (8 files)
        └── commands/ (38 files)
```

## 🚀 実装フェーズ

### Phase 1: 準備作業
1. 現状のバックアップ作成
2. ブランチ作成: `feature/zh-cn-tw-separation`
3. 作業ディレクトリの確認

### Phase 2: ディレクトリ整備
1. `locales/zh` → `locales/zh-cn` リネーム
2. `locales/zh-tw` ディレクトリ作成
3. 構造の検証

### Phase 3: ファイル移行
1. `README_zh.md` → `README_zh-cn.md` リネーム
2. `locales/zh-cn` の内容を `locales/zh-tw` へコピー
3. `README_zh-tw.md` を作成（zh-cn から変換）

### Phase 4: コンテンツ変換
1. zh-tw 配下の全ファイルを繁体字変換
2. 台湾・香港向けの用語調整
3. 文字コードの確認（UTF-8）

### Phase 5: リンク更新
1. 全 README の言語切替リンク更新
2. locales 内の相互参照確認
3. 外部リンクの検証

### Phase 6: 品質保証
1. 全ファイルのパス整合性確認
2. 言語切替動作テスト
3. 表示確認

## ✅ 実装チェックリスト（合計 116 項目）

### 🔧 準備フェーズ
- [ ] Git ブランチ作成
- [ ] 現在の zh ディレクトリのバックアップ
- [ ] 作業環境の確認

### 📁 ディレクトリ作業
- [ ] `locales/zh` → `locales/zh-cn` リネーム実行
- [ ] `locales/zh-tw` ディレクトリ作成
- [ ] ディレクトリ構造の確認

### 📄 README ファイル作業（7 ファイル）
- [ ] `README_zh.md` → `README_zh-cn.md` リネーム
- [ ] `README_zh-tw.md` 新規作成（繁体字版）
- [ ] `README.md` の言語リンク更新
- [ ] `README_en.md` の言語リンク更新
- [ ] `README_es.md` の言語リンク更新
- [ ] `README_ko.md` の言語リンク更新
- [ ] `README_pt.md` の言語リンク更新
- [ ] `README_zh-cn.md` の言語リンク更新（簡体字版）
- [ ] `README_zh-tw.md` の言語リンク更新（繁体字版）

### 📝 locales ファイル作業

#### zh-cn（簡体字）チェック - 49 ファイル
##### 基本ファイル（2）
- [ ] `locales/zh-cn/CLAUDE.md`
- [ ] `locales/zh-cn/COMMAND_TEMPLATE.md`

##### agents/roles/（8）
- [ ] `locales/zh-cn/agents/roles/analyzer.md`
- [ ] `locales/zh-cn/agents/roles/architect.md`
- [ ] `locales/zh-cn/agents/roles/frontend.md`
- [ ] `locales/zh-cn/agents/roles/mobile.md`
- [ ] `locales/zh-cn/agents/roles/performance.md`
- [ ] `locales/zh-cn/agents/roles/qa.md`
- [ ] `locales/zh-cn/agents/roles/reviewer.md`
- [ ] `locales/zh-cn/agents/roles/security.md`

##### commands/（38）
- [ ] `locales/zh-cn/commands/analyze-dependencies.md`
- [ ] `locales/zh-cn/commands/analyze-performance.md`
- [ ] `locales/zh-cn/commands/check-fact.md`
- [ ] `locales/zh-cn/commands/check-github-ci.md`
- [ ] `locales/zh-cn/commands/check-prompt.md`
- [ ] `locales/zh-cn/commands/commit-message.md`
- [ ] `locales/zh-cn/commands/context7.md`
- [ ] `locales/zh-cn/commands/design-patterns.md`
- [ ] `locales/zh-cn/commands/explain-code.md`
- [ ] `locales/zh-cn/commands/fix-error.md`
- [ ] `locales/zh-cn/commands/multi-role.md`
- [ ] `locales/zh-cn/commands/plan.md`
- [ ] `locales/zh-cn/commands/pr-auto-update.md`
- [ ] `locales/zh-cn/commands/pr-create.md`
- [ ] `locales/zh-cn/commands/pr-feedback.md`
- [ ] `locales/zh-cn/commands/pr-issue.md`
- [ ] `locales/zh-cn/commands/pr-list.md`
- [ ] `locales/zh-cn/commands/pr-review.md`
- [ ] `locales/zh-cn/commands/refactor.md`
- [ ] `locales/zh-cn/commands/role-debate.md`
- [ ] `locales/zh-cn/commands/role-help.md`
- [ ] `locales/zh-cn/commands/role.md`
- [ ] `locales/zh-cn/commands/screenshot.md`
- [ ] `locales/zh-cn/commands/search-gemini.md`
- [ ] `locales/zh-cn/commands/semantic-commit.md`
- [ ] `locales/zh-cn/commands/sequential-thinking.md`
- [ ] `locales/zh-cn/commands/show-plan.md`
- [ ] `locales/zh-cn/commands/smart-review.md`
- [ ] `locales/zh-cn/commands/spec.md`
- [ ] `locales/zh-cn/commands/style-ai-writting.md`
- [ ] `locales/zh-cn/commands/task.md`
- [ ] `locales/zh-cn/commands/tech-debt.md`
- [ ] `locales/zh-cn/commands/ultrathink.md`
- [ ] `locales/zh-cn/commands/update-dart-doc.md`
- [ ] `locales/zh-cn/commands/update-doc-string.md`
- [ ] `locales/zh-cn/commands/update-flutter-deps.md`
- [ ] `locales/zh-cn/commands/update-node-deps.md`
- [ ] `locales/zh-cn/commands/update-rust-deps.md`

#### zh-tw（繁体字）作成 - 49 ファイル
##### 基本ファイル（2）
- [ ] `locales/zh-tw/CLAUDE.md` 繁体字変換
- [ ] `locales/zh-tw/COMMAND_TEMPLATE.md` 繁体字変換

##### agents/roles/（8）
- [ ] `locales/zh-tw/agents/roles/analyzer.md` 繁体字変換
- [ ] `locales/zh-tw/agents/roles/architect.md` 繁体字変換
- [ ] `locales/zh-tw/agents/roles/frontend.md` 繁体字変換
- [ ] `locales/zh-tw/agents/roles/mobile.md` 繁体字変換
- [ ] `locales/zh-tw/agents/roles/performance.md` 繁体字変換
- [ ] `locales/zh-tw/agents/roles/qa.md` 繁体字変換
- [ ] `locales/zh-tw/agents/roles/reviewer.md` 繁体字変換
- [ ] `locales/zh-tw/agents/roles/security.md` 繁体字変換

##### commands/（38）
- [ ] `locales/zh-tw/commands/analyze-dependencies.md` 繁体字変換
- [ ] `locales/zh-tw/commands/analyze-performance.md` 繁体字変換
- [ ] `locales/zh-tw/commands/check-fact.md` 繁体字変換
- [ ] `locales/zh-tw/commands/check-github-ci.md` 繁体字変換
- [ ] `locales/zh-tw/commands/check-prompt.md` 繁体字変換
- [ ] `locales/zh-tw/commands/commit-message.md` 繁体字変換
- [ ] `locales/zh-tw/commands/context7.md` 繁体字変換
- [ ] `locales/zh-tw/commands/design-patterns.md` 繁体字変換
- [ ] `locales/zh-tw/commands/explain-code.md` 繁体字変換
- [ ] `locales/zh-tw/commands/fix-error.md` 繁体字変換
- [ ] `locales/zh-tw/commands/multi-role.md` 繁体字変換
- [ ] `locales/zh-tw/commands/plan.md` 繁体字変換
- [ ] `locales/zh-tw/commands/pr-auto-update.md` 繁体字変換
- [ ] `locales/zh-tw/commands/pr-create.md` 繁体字変換
- [ ] `locales/zh-tw/commands/pr-feedback.md` 繁体字変換
- [ ] `locales/zh-tw/commands/pr-issue.md` 繁体字変換
- [ ] `locales/zh-tw/commands/pr-list.md` 繁体字変換
- [ ] `locales/zh-tw/commands/pr-review.md` 繁体字変換
- [ ] `locales/zh-tw/commands/refactor.md` 繁体字変換
- [ ] `locales/zh-tw/commands/role-debate.md` 繁体字変換
- [ ] `locales/zh-tw/commands/role-help.md` 繁体字変換
- [ ] `locales/zh-tw/commands/role.md` 繁体字変換
- [ ] `locales/zh-tw/commands/screenshot.md` 繁体字変換
- [ ] `locales/zh-tw/commands/search-gemini.md` 繁体字変換
- [ ] `locales/zh-tw/commands/semantic-commit.md` 繁体字変換
- [ ] `locales/zh-tw/commands/sequential-thinking.md` 繁体字変換
- [ ] `locales/zh-tw/commands/show-plan.md` 繁体字変換
- [ ] `locales/zh-tw/commands/smart-review.md` 繁体字変換
- [ ] `locales/zh-tw/commands/spec.md` 繁体字変換
- [ ] `locales/zh-tw/commands/style-ai-writting.md` 繁体字変換
- [ ] `locales/zh-tw/commands/task.md` 繁体字変換
- [ ] `locales/zh-tw/commands/tech-debt.md` 繁体字変換
- [ ] `locales/zh-tw/commands/ultrathink.md` 繁体字変換
- [ ] `locales/zh-tw/commands/update-dart-doc.md` 繁体字変換
- [ ] `locales/zh-tw/commands/update-doc-string.md` 繁体字変換
- [ ] `locales/zh-tw/commands/update-flutter-deps.md` 繁体字変換
- [ ] `locales/zh-tw/commands/update-node-deps.md` 繁体字変換
- [ ] `locales/zh-tw/commands/update-rust-deps.md` 繁体字変換

### 🔄 コンテンツ変換
- [ ] 簡体字→繁体字自動変換ツール選定
- [ ] zh-tw 全ファイル変換実行
- [ ] 専門用語の確認・調整
- [ ] 地域特有表現の調整

### 🔗 リンク更新
- [ ] 言語切替リンクのフォーマット統一
- [ ] 相対パスの確認
- [ ] 外部リンクの動作確認

## ✅ 検証チェックリスト

### 🧪 機能テスト
- [ ] README 間の言語切替動作
- [ ] locales フォルダへのリンク動作
- [ ] 各コマンドファイルの読み込み
- [ ] エージェントロールファイルの読み込み

### 📋 整合性確認
- [ ] ファイル数の一致（zh-cn と zh-tw）
- [ ] ディレクトリ構造の一致
- [ ] 文字エンコーディング（UTF-8）
- [ ] 改行コード統一（LF）

### 🌏 言語品質
- [ ] 簡体字の正確性（zh-cn）
- [ ] 繁体字の正確性（zh-tw）
- [ ] 用語の一貫性
- [ ] 翻訳の完全性

### 📱 表示確認
- [ ] GitHub での表示確認
- [ ] 各種エディタでの表示
- [ ] モバイルでの表示
- [ ] 文字化けがないこと

### 🚢 デプロイ前確認
- [ ] git status でファイル確認
- [ ] git diff で変更内容確認
- [ ] `scripts/check-locales.sh` 実行で整合性確認
- [ ] PR 作成前の最終チェック
- [ ] CI/CD パイプライン通過

## 📅 タイムライン

| フェーズ | 所要時間 | 備考 |
|---------|----------|------|
| Phase 1: 準備 | 10 分 | バックアップ含む |
| Phase 2: ディレクトリ | 5 分 | リネーム作業 |
| Phase 3: ファイル移行 | 15 分 | コピー作業 |
| Phase 4: 変換 | 30 分 | 繁体字変換 |
| Phase 5: リンク更新 | 20 分 | 全 README 更新 |
| Phase 6: 品質保証 | 20 分 | テスト・検証 |
| **合計** | **100 分** | 約 1 時間 40 分 |

## ⚠️ リスクと対策

### リスク
1. **既存リンク切れ**: README_zh.md への既存参照
2. **翻訳品質**: 自動変換による不自然な表現
3. **未翻訳ファイル**: zh に 27 コマンド未翻訳

### 対策
1. **リダイレクト考慮**: README_zh.md から zh-cn.md への案内
2. **手動レビュー**: 重要箇所の手動確認
3. **段階的対応**: 未翻訳は TODO として明記

## 📝 備考

- 将来的に他の中華圏（シンガポール、マレーシア等）対応も考慮
- ISO 639-1 と ISO 3166-1 の組み合わせに準拠
- OpenCC 等の変換ツール使用を推奨

---

作成日: 2025-01-19
作成者: Claude Code Assistant
バージョン: 1.0