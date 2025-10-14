## 代码解释

详细解释代码的运行机制。

### 使用方法

```bash
# 显示文件内容并请求 Claude
cat <file>
"解释这段代码的运行机制"
```

### 基本示例

```bash
# 理解 Rust 的所有权
cat main.rs
"从 Rust 的所有权和生命周期角度解释"

# 算法解释
grep -A 50 "quicksort" sort.rs
"解释这个排序算法的机制和时间复杂度"

# 设计模式说明
cat factory.rs
"说明使用的设计模式及其优点"
```

### 与 Claude 的协作

```bash
# 初学者友好的解释
cat complex_function.py
"用初学者也能理解的方式逐行解释这段代码"

# 性能分析
cat algorithm.rs
"指出这段代码的性能问题并提出改进方案"

# 带图解的说明
cat state_machine.js
"用 ASCII 艺术图解说明这段代码的处理流程"

# 安全审查
cat auth_handler.go
"指出这段代码的安全隐患"
```

### 详细示例

```bash
# 复杂逻辑的解释
cat recursive_parser.rs
"从以下角度解释这个递归解析器的运行机制：
1. 整体处理流程
2. 各函数的角色和职责
3. 边界情况处理
4. 可改进的地方"

# 异步处理的解释
cat async_handler.ts
"解释这个异步处理的以下方面：
1. Promise 链的流程
2. 错误处理机制
3. 是否有并发处理
4. 死锁的可能性"

# 架构说明
ls -la src/ && cat src/main.rs src/lib.rs
"解释这个项目的架构和模块结构"
```

### 注意事项

代码解释不仅说明运行机制，还会解释为什么这样实现、有什么优点、潜在问题是什么等深层洞察。
