## Screenshot

macOS でスクリーンショットを撮影し、画像を解析します。

### 使い方

```bash
/screenshot [オプション]
```

### オプション

- なし : ウィンドウを選択（Claude がオプションを確認）
- `--window` : ウィンドウを指定して撮影
- `--full` : 画面全体を撮影
- `--crop` : 範囲を選択して撮影

### 基本例

```bash
# ウィンドウを撮影して解析
/screenshot --window
「撮影した画面を解析して」

# 範囲を選択して解析
/screenshot --crop
「選択した範囲の内容を説明して」

# 全画面を撮影して解析
/screenshot --full
「画面全体の構成を分析して」
```

### Claude との連携

```bash
# 特定の問題なし - 状況解析
/screenshot --crop
（Claude が自動的に画面の内容を解析し、要素や構成を説明）

# UI/UX の問題分析
/screenshot --window
「この UI の問題点と改善案を提案して」

# エラー解析
/screenshot --window
「このエラーメッセージの原因と解決方法を教えて」

# デザインレビュー
/screenshot --full
「このデザインを UX の観点から評価して」

# コード解析
/screenshot --crop
「このコードの問題点を指摘して」

# データ可視化の分析
/screenshot --crop
「このグラフから読み取れる傾向を分析して」
```

### 詳細例

```bash
# 複数の観点から分析
/screenshot --window
「この画面について以下を分析して：
1. UI の一貫性
2. アクセシビリティの問題
3. 改善提案」

# 比較分析用に複数撮影
/screenshot --window
# （before の画像を保存）
# 変更を加える
/screenshot --window
# （after の画像を保存）
「before と after の画像を比較して、変更点と改善効果を分析して」

# 特定要素にフォーカス
/screenshot --crop
「選択したボタンのデザインが他の要素と調和しているか評価して」
```

### 禁止事項

- **スクリーンショットを撮影していないのに「撮影しました」と言うことは禁止**
- **存在しない画像ファイルの解析を試みることは禁止**
- **`/screenshot` コマンドは実際のスクリーンショット撮影を行わない**

### 注意事項

- オプションを指定しない場合、以下の選択肢を提示してください：

  ```
  「どの方法でスクリーンショットを撮影しますか？
  1. ウィンドウを選択 (--window) → screencapture -W
  2. 画面全体 (--full) → screencapture -x
  3. 範囲を選択 (--crop) → screencapture -i」
  ```