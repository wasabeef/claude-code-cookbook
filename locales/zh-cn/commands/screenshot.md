## 截图

在 macOS 上截取屏幕并分析图像。

### 使用方法

```bash
/screenshot [选项]
```

### 选项

- 无 : 选择窗口(Claude 会确认选项)
- `--window` : 指定窗口截图
- `--full` : 截取整个屏幕
- `--crop` : 选择范围截图

### 基本示例

```bash
# 截取窗口并分析
/screenshot --window
"分析截取的画面"

# 选择范围并分析
/screenshot --crop
"说明选中范围的内容"

# 全屏截图并分析
/screenshot --full
"分析整个屏幕的构成"
```

### 与 Claude 的协作

```bash
# 无特定问题 - 情况分析
/screenshot --crop
(Claude 会自动分析屏幕内容，说明元素和构成)

# UI/UX 问题分析
/screenshot --window
"提出这个 UI 的问题点和改进方案"

# 错误分析
/screenshot --window
"告诉我这个错误消息的原因和解决方法"

# 设计审查
/screenshot --full
"从 UX 角度评估这个设计"

# 代码分析
/screenshot --crop
"指出这段代码的问题"

# 数据可视化分析
/screenshot --crop
"分析从这个图表中可以读取的趋势"
```

### 详细示例

```bash
# 从多个角度分析
/screenshot --window
"分析这个画面的以下方面：
1. UI 的一致性
2. 可访问性问题
3. 改进建议"

# 为比较分析多次截图
/screenshot --window
# (保存 before 图像)
# 进行更改
/screenshot --window
# (保存 after 图像)
"比较 before 和 after 图像，分析变更点和改进效果"

# 聚焦特定元素
/screenshot --crop
"评估选中按钮的设计是否与其他元素协调"
```

### 禁止事项

- **禁止在未截图的情况下说"已截图"**
- **禁止尝试分析不存在的图像文件**
- **`/screenshot` 命令不会实际执行截图**

### 注意事项

- 未指定选项时，请提示以下选择：

  ```
  "请选择截图方式？
  1. 选择窗口 (--window) → screencapture -W
  2. 整个屏幕 (--full) → screencapture -x
  3. 选择范围 (--crop) → screencapture -i"
  ```

- 请在用户执行 screencapture 命令后开始图像分析
- 指定具体问题或观点可以进行更有针对性的分析
