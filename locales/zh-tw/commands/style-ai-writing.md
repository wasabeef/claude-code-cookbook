## AI 寫作檢查

檢測 AI 生成文本的機械化模式，並提供更自然的中文改進建議。

### 使用方法

```bash
/ai-writing-check [選項]
```

### 選項

- 無參數 : 分析當前文件或選中的文本
- `--file <path>` : 分析特定文件
- `--dir <path>` : 批量分析目錄內的文件
- `--severity <level>` : 檢測級別(all/high/medium)
- `--fix` : 自動修復檢測到的模式

### 基本示例

```bash
# 檢查文件的 AI 痕迹
cat README.md
/ai-writing-check
「檢查這個文檔的 AI 痕迹並提供改進方案」

# 分析特定文件
/ai-writing-check --file docs/guide.md
「檢測 AI 風格的表達並建議自然的表達方式」

# 掃描整個項目
/ai-writing-check --dir . --severity high
「只報告項目中重要的 AI 痕迹問題」
```

### 檢測模式

#### 1. 列表格式的機械化模式

```markdown
檢測示例：

- **重要**: 這是重要的項目
- 已完成的項目(带勾選標記)
- 熱門話題(带火焰表情)
- 準備啟動(带火箭表情)

改進示例：

- 重要項目：這是重要的項目
- 已完成的項目
- 熱門話題
- 準備啟動
```

#### 2. 夸张和炒作表達

```markdown
檢測示例：
革命性的技術將改變行業。
這完全解決了問題。
像魔法一樣運行。

改進示例：
有效的技術將為行業带來變化。
解決了许多問題。
運行流畅。
```

#### 3. 機械化的強調模式

```markdown
檢測示例：
**想法**: 有新的提議(带灯泡表情)
**注意**: 重要警告事項(带警告表情)

改進示例：
想法：有新的提議
注意事項：重要警告事項
```

#### 4. 冗余的技術寫作

```markdown
檢測示例：
首先先進行設置。
可以使用這個工具。
大幅提升性能。

改進示例：
首先進行設置。
可以使用這個工具。
性能提升 30%。
```

### 與 Claude 配合

```bash
# 文檔整體的 AI 痕迹分析
cat article.md
/ai-writing-check
「從以下角度分析並提供改進方案：
1. 機械化表達的檢測
2. 自然中文的修改建議
3. 按優先級排列的改進列表」

# 聚焦特定模式
/ai-writing-check --file blog.md
「特別關注夸张表達和冗余表達並提供改進建議」

# 批量檢查多個文件
find . -name "*.md" -type f
/ai-writing-check --dir docs/
「分析整個文檔的 AI 痕迹並創建摘要」
```

### 詳细示例

```bash
# 改進前後對比
/ai-writing-check --file draft.md
「檢測 AI 風格的表達，按以下格式展示：
- 問題位置(带行号)
- 問題類型和原因
- 具體改進方案
- 改進效果」

# 自動修復模式
/ai-writing-check --file report.md --fix
「自動修復檢測到的模式並報告結果」

# 項目 AI 痕迹報告
/ai-writing-check --dir . --severity all
「分析整個項目的 AI 痕迹：
1. 統計資訊(按模式分類的檢測數)
2. 問題最多的文件 TOP 5
3. 改進優先級矩阵
4. 分阶段改進計劃」
```

### 高級用法

```bash
# 應用自定義規則
/ai-writing-check --file spec.md
「作為技術規格書，使用以下额外標準檢查：
- 模糊表達(適当的、根據需要)
- 缺乏具體性(高速 → 具體數值)
- 術語使用不一致」

# CI/CD 集成檢查
/ai-writing-check --dir docs/ --severity high
「以可在 GitHub Actions 執行的格式輸出結果：
- 錯誤數和文件名
- 需要修復的行号
- exit code 設置」

# 風格指南合規檢查
/ai-writing-check --file manual.md
「基于公司風格指南進行额外檢查：
- 敬語使用(統一礼貌用語)
- 專業術語的適当使用
- 對讀者的考虑」
```

### 注意事項

- AI 痕迹的判定因上下文而異，建議仅作參考
- 根據文檔類型(技術文檔、博客、手冊等)調整標準
- 不必接受所有建議，選擇合適的即可
- `--fix` 選項會自動修復檢測到的模式

### 命令執行時的行為

執行 `/ai-writing-check` 命令時，Claude 會進行以下處理：

1. **模式檢測**: 從指定的文件或文本中檢測 AI 風格的模式
2. **具體修改建議**: 為每個問題提供带行号的修改方案
3. **--fix 模式**: 自動修復檢測到的模式，並顯示結果摘要
4. **報告生成**: 提供檢測數、改進優先級、修改前後對比

Claude 會讀取實際文件內容，基于 textlint-rule-preset-ai-writing 的規則進行分析。

### 參考

此命令參考了 [textlint-rule-preset-ai-writing](https://github.com/textlint-ja/textlint-rule-preset-ai-writing) 的規則集創建。這是一個 textlint 規則預設，用于檢測 AI 生成文本的機械化模式，促進更自然的表達。
