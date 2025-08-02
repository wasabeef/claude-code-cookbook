## 屏幕截图

在macOS上拍摄屏幕截图并分析图像内容。

### 使用方法

```bash
/screenshot [选项]
```

### 选项

- 无 : 选择窗口（Claude会确认选项）
- `--window` : 指定窗口拍摄
- `--full` : 拍摄整个屏幕
- `--crop` : 选择范围拍摄

### 基本示例

```bash
# 拍摄窗口并分析
/screenshot --window
「分析拍摄的屏幕」

# 选择范围并分析
/screenshot --crop
「说明所选范围的内容」

# 拍摄全屏并分析
/screenshot --full
「分析整个屏幕的构成」
```

### 与Claude的协作

```bash
# 无特定问题 - 状况分析
/screenshot --crop
（Claude会自动分析屏幕内容，说明元素和构成）

# UI/UX问题分析
/screenshot --window
「请提出这个UI的问题点和改善方案」

# 错误分析
/screenshot --window
「请告诉我这个错误消息的原因和解决方法」

# 设计评审
/screenshot --full
「从UX角度评价这个设计」

# 代码分析
/screenshot --crop
「请指出这段代码的问题点」

# 数据可视化分析
/screenshot --crop
「分析这个图表中可以读取的趋势」
```

### 详细示例

```bash
# 从多个角度分析
/screenshot --window
「请从以下方面分析这个画面：
1. UI的一致性
2. 可访问性问题
3. 改善建议」

# 拍摄多张用于比较分析
/screenshot --window
# （保存before图像）
# 进行变更
/screenshot --window
# （保存after图像）
「比较before和after图像，分析变更点和改善效果」

# 聚焦特定元素
/screenshot --crop
「评价所选按钮的设计是否与其他元素协调」
```

### 禁止事项

- **禁止在未拍摄屏幕截图的情况下声称"已拍摄"**
- **禁止尝试分析不存在的图像文件**
- **`/screenshot`命令不会实际拍摄屏幕截图**

### 注意事项

- 未指定选项时，请提供以下选择：

  ```
  「您想使用哪种方法拍摄屏幕截图？
  1. 选择窗口 (--window) → screencapture -W
  2. 全屏 (--full) → screencapture -x
  3. 选择范围 (--crop) → screencapture -i」
  ```

- 请在用户执行screencapture命令后开始图像分析
- 指定具体问题或角度可以进行更有针对性的分析
```