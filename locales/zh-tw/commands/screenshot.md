## 截圖

在 macOS 上截取屏幕並分析圖像。

### 使用方法

```bash
/screenshot [選項]
```

### 選項

- 無 : 選擇窗口（Claude 會確認選項）
- `--window` : 指定窗口截圖
- `--full` : 截取整個屏幕
- `--crop` : 選擇範圍截圖

### 基本示例

```bash
# 截取窗口並分析
/screenshot --window
"分析截取的画面"

# 選擇範圍並分析
/screenshot --crop
"說明選中範圍的內容"

# 全屏截圖並分析
/screenshot --full
"分析整個屏幕的構成"
```

### 與 Claude 的協作

```bash
# 無特定問題 - 情况分析
/screenshot --crop
（Claude 會自動分析屏幕內容，說明元素和構成）

# UI/UX 問題分析
/screenshot --window
"提出這個 UI 的問題點和改進方案"

# 錯誤分析
/screenshot --window
"告诉我這個錯誤消息的原因和解決方法"

# 設計審查
/screenshot --full
"從 UX 角度評估這個設計"

# 代碼分析
/screenshot --crop
"指出這段代碼的問題"

# 數據可視化分析
/screenshot --crop
"分析從這個圖表中可以讀取的趨勢"
```

### 詳细示例

```bash
# 從多個角度分析
/screenshot --window
"分析這個画面的以下方面：
1. UI 的一致性
2. 可訪問性問題
3. 改進建議"

# 為比较分析多次截圖
/screenshot --window
# （保存 before 圖像）
# 進行更改
/screenshot --window
# （保存 after 圖像）
"比较 before 和 after 圖像，分析變更點和改進效果"

# 聚焦特定元素
/screenshot --crop
"評估選中按钮的設計是否與其他元素協調"
```

### 禁止事項

- **禁止在未截圖的情况下說"已截圖"**
- **禁止尝試分析不存在的圖像文件**
- **`/screenshot` 命令不會實際執行截圖**

### 注意事項

- 未指定選項時，請提示以下選擇：

  ```
  "請選擇截圖方式？
  1. 選擇窗口 (--window) → screencapture -W
  2. 整個屏幕 (--full) → screencapture -x
  3. 選擇範圍 (--crop) → screencapture -i"
  ```

- 請在用戶執行 screencapture 命令後開始圖像分析
- 指定具體問題或觀點可以進行更有针對性的分析
