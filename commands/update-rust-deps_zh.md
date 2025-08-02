## Rust依赖更新

安全更新Rust项目的依赖关系。

### 使用方法

```bash
# 检查依赖状态并请求Claude帮助
cargo tree
「请将Cargo.toml的依赖关系更新到最新版本」
```

### 基本示例

```bash
# 检查当前依赖
cat Cargo.toml
「请分析这个Rust项目的依赖关系，并告诉我哪些库可以更新」

# 检查可更新列表
cargo update --dry-run
「请分析这些库更新的风险程度」
```

### 与Claude协作

```bash
# 全面依赖更新
cat Cargo.toml
「请分析Rust依赖，并执行以下操作：
1. 研究每个库的最新版本
2. 确认是否有破坏性变更
3. 评估风险程度（安全・注意・危险）
4. 建议必要的代码变更
5. 生成更新后的Cargo.toml」

# 安全的逐步更新
cargo tree
「请避开主版本升级，只更新安全的库」

# 特定库的更新影响分析
「请告诉我将tokio更新到最新版本的影响和必要的变更」
```

### 详细示例

```bash
# 包含发布说明的详细分析
cat Cargo.toml && cargo tree
「请分析依赖，并为每个库提供：
1. 当前 → 最新版本
2. 风险评估（安全・注意・危险）
3. 主要变更（来自CHANGELOG）
4. 特性边界的变更
5. 必要的代码修正
请以表格形式呈现」

# 异步运行时迁移分析
cat Cargo.toml src/main.rs
「请提供从async-std迁移到tokio，或tokio主版本升级所需的所有变更」
```

### 风险程度标准

```
安全（🟢）：
- 补丁版本升级（0.1.2 → 0.1.3）
- 仅包含bug修复
- 保证向后兼容性

注意（🟡）：
- 次版本升级（0.1.0 → 0.2.0）
- 添加新功能
- 包含弃用警告

危险（🔴）：
- 主版本升级（0.x.y → 1.0.0，1.x.y → 2.0.0）
- 破坏性变更
- API删除或更改
- 特性边界变更
```

### 执行更新

```bash
# 创建备份
cp Cargo.toml Cargo.toml.backup
cp Cargo.lock Cargo.lock.backup

# 执行更新
cargo update

# 更新后检查
cargo check
cargo test
cargo clippy
```

### 注意事项

更新后务必进行功能测试。如果出现问题，请使用以下命令恢复：

```bash
cp Cargo.toml.backup Cargo.toml
cp Cargo.lock.backup Cargo.lock
cargo build
```