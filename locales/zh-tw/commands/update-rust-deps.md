## Rust 依賴更新

安全地更新 Rust 項目的依賴關系。

### 使用方法

```bash
# 確認依賴狀態並請求 Claude
cargo tree
「將 Cargo.toml 的依賴更新到最新版本」
```

### 基本示例

```bash
# 確認當前依賴
cat Cargo.toml
「分析這個 Rust 項目的依賴並告诉我可更新的 crate」

# 確認可更新列表
cargo update --dry-run
「分析這些 crate 更新的危險度」
```

### 與 Claude 配合

```bash
# 全面的依賴更新
cat Cargo.toml
「分析 Rust 的依賴並執行以下操作：
1. 調查各 crate 的最新版本
2. 確認是否有破坏性變更
3. 評估危險度（安全・注意・危險）
4. 提出必要的代碼更改
5. 生成更新版 Cargo.toml」

# 安全的分阶段更新
cargo tree
「避免主版本升級，只更新可以安全升級的 crate」

# 特定 crate 的更新影響分析
「告诉我將 tokio 更新到最新版本的影響和必要的更改」
```

### 詳细示例

```bash
# 包含 Release Notes 的詳细分析
cat Cargo.toml && cargo tree
「分析依賴，為每個 crate 提供：
1. 當前 → 最新版本
2. 危險度評估（安全・注意・危險）
3. 主要變更（來自 CHANGELOG）
4. trait 邊界的變更
5. 必要的代碼修改
以表格形式展示」

# 異步運行時的遷移分析
cat Cargo.toml src/main.rs
「展示從 async-std 遷移到 tokio，或 tokio 主版本升級所需的所有更改」
```

### 危險度標準

```
安全（🟢）：
- 補丁版本升級（0.1.2 → 0.1.3）
- 仅修復 bug
- 保證向後兼容

注意（🟡）：
- 次版本升級（0.1.0 → 0.2.0）
- 新增功能
- 有弃用警告

危險（🔴）：
- 主版本升級（0.x.y → 1.0.0、1.x.y → 2.0.0）
- 破坏性變更
- API 的刪除或更改
- trait 邊界的變更
```

### 執行更新

```bash
# 創建備份
cp Cargo.toml Cargo.toml.backup
cp Cargo.lock Cargo.lock.backup

# 執行更新
cargo update

# 更新後確認
cargo check
cargo test
cargo clippy
```

### 注意事項

更新後必须進行功能測試。如果出現問題，使用以下命令恢復：

```bash
cp Cargo.toml.backup Cargo.toml
cp Cargo.lock.backup Cargo.lock
cargo build
```
