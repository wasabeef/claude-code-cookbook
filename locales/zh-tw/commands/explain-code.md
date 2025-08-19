## 代碼解釋

詳细解釋代碼的運行機制。

### 使用方法

```bash
# 顯示文件內容並請求 Claude
cat <file>
"解釋這段代碼的運行機制"
```

### 基本示例

```bash
# 理解 Rust 的所有權
cat main.rs
"從 Rust 的所有權和生命週期角度解釋"

# 算法解釋
grep -A 50 "quicksort" sort.rs
"解釋這個排序算法的機制和時間復杂度"

# 設計模式說明
cat factory.rs
"說明使用的設計模式及其優點"
```

### 與 Claude 的協作

```bash
# 初學者友好的解釋
cat complex_function.py
"用初學者也能理解的方式逐行解釋這段代碼"

# 性能分析
cat algorithm.rs
"指出這段代碼的性能問題並提出改進方案"

# 带圖解的說明
cat state_machine.js
"用 ASCII 艺術圖解說明這段代碼的處理流程"

# 安全審查
cat auth_handler.go
"指出這段代碼的安全隱患"
```

### 詳细示例

```bash
# 復杂邏輯的解釋
cat recursive_parser.rs
"從以下角度解釋這個遞歸解析器的運行機制：
1. 整體處理流程
2. 各函數的角色和职責
3. 邊界情况處理
4. 可改進的地方"

# 異步處理的解釋
cat async_handler.ts
"解釋這個異步處理的以下方面：
1. Promise 鏈的流程
2. 錯誤處理機制
3. 是否有並發處理
4. 死鎖的可能性"

# 架構說明
ls -la src/ && cat src/main.rs src/lib.rs
"解釋這個項目的架構和模塊結構"
```

### 注意事項

代碼解釋不仅說明運行機制，還會解釋為什么這樣實現、有什么優點、潜在問題是什么等深層洞察。
