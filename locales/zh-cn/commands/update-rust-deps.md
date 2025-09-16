## Rust 依赖更新

安全地更新 Rust 项目的依赖关系。

### 使用方法

```bash
# 确认依赖状态并请求 Claude
cargo tree
「将 Cargo.toml 的依赖更新到最新版本」
```

### 基本示例

```bash
# 确认当前依赖
cat Cargo.toml
「分析这个 Rust 项目的依赖并告诉我可更新的 crate」

# 确认可更新列表
cargo update --dry-run
「分析这些 crate 更新的危险度」
```

### 与 Claude 配合

```bash
# 全面的依赖更新
cat Cargo.toml
「分析 Rust 的依赖并执行以下操作：
1. 调查各 crate 的最新版本
2. 确认是否有破坏性变更
3. 评估危险度(安全・注意・危险)
4. 提出必要的代码更改
5. 生成更新版 Cargo.toml」

# 安全的分阶段更新
cargo tree
「避免主版本升级，只更新可以安全升级的 crate」

# 特定 crate 的更新影响分析
「告诉我将 tokio 更新到最新版本的影响和必要的更改」
```

### 详细示例

```bash
# 包含 Release Notes 的详细分析
cat Cargo.toml && cargo tree
「分析依赖，为每个 crate 提供：
1. 当前 → 最新版本
2. 危险度评估(安全・注意・危险)
3. 主要变更(来自 CHANGELOG)
4. trait 边界的变更
5. 必要的代码修改
以表格形式展示」

# 异步运行时的迁移分析
cat Cargo.toml src/main.rs
「展示从 async-std 迁移到 tokio，或 tokio 主版本升级所需的所有更改」
```

### 危险度标准

```text
安全(🟢)：
- 补丁版本升级(0.1.2 → 0.1.3)
- 仅修复 bug
- 保证向后兼容

注意(🟡)：
- 次版本升级(0.1.0 → 0.2.0)
- 新增功能
- 有弃用警告

危险(🔴)：
- 主版本升级(0.x.y → 1.0.0、1.x.y → 2.0.0)
- 破坏性变更
- API 的删除或更改
- trait 边界的变更
```

### 执行更新

```bash
# 创建备份
cp Cargo.toml Cargo.toml.backup
cp Cargo.lock Cargo.lock.backup

# 执行更新
cargo update

# 更新后确认
cargo check
cargo test
cargo clippy
```

### 注意事项

更新后必须进行功能测试。如果出现问题，使用以下命令恢复：

```bash
cp Cargo.toml.backup Cargo.toml
cp Cargo.lock.backup Cargo.lock
cargo build
```
