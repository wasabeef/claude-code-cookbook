## 代码解释

详细解说代码的工作原理。

### 使用方法

```bash
# 显示文件内容并向Claude请求
cat <file>
「请解释这段代码的工作原理」
```

### 基本示例

```bash
# 理解Rust所有权
cat main.rs
「从Rust所有权和生命周期的角度进行解释」

# 算法解释
grep -A 50 "quicksort" sort.rs
「请解释这个排序算法的工作原理和时间复杂度」

# 设计模式说明
cat factory.rs
「请说明代码中使用的设计模式及其优点」
```

### 与Claude协作

```bash
# 面向初学者的解释
cat complex_function.py
「请用初学者也能理解的方式逐行解释这段代码」

# 性能分析
cat algorithm.rs
「请指出这段代码在性能方面的问题和改进方案」

# 带图解的说明
cat state_machine.js
「请用ASCII艺术图解说明这段代码的处理流程」

# 安全审查
cat auth_handler.go
「请指出这段代码中的安全隐患」
```

### 详细示例

```bash
# 复杂逻辑的解释
cat recursive_parser.rs
「请从以下角度解释这个递归解析器的工作原理：
1. 整体处理流程
2. 各函数的角色和责任
3. 边界情况的处理
4. 可改进的地方」

# 异步处理的解释
cat async_handler.ts
「请解释这个异步处理的以下内容：
1. Promise链的流程
2. 错误处理机制
3. 是否存在并行处理
4. 死锁的可能性」

# 架构说明
ls -la src/ && cat src/main.rs src/lib.rs
「请解释这个项目的架构和模块结构」
```

### 注意事项

代码解释不仅要说明代码的工作原理，还应提供深入的见解，如为什么采用这种实现方式、有什么优点以及潜在的问题是什么。