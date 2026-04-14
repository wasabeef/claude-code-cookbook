---
description: "從暫存變更生成提交訊息"
---

## 提交消息

從暂存的更改 (git diff --staged) 生成合適的提交消息。仅生成消息並復制到剪贴板，不執行 git 命令。

### 使用方法

```bash
/commit-message [選項]
```

### 選項

- `--format <格式>` : 指定消息格式 (conventional, gitmoji, angular)
- `--lang <語言>` : 強制指定消息語言 (en, zh-tw)
- `--breaking` : 檢測並記錄 Breaking Change

### 基本示例

```bash
# 從暂存的更改生成消息 (自動判定語言)
# 主要候選會自動復制到剪贴板
/commit-message

# 強制指定語言
/commit-message --lang zh-tw
/commit-message --lang en

# 檢測 Breaking Change
/commit-message --breaking
```

### 前提條件

**重要**: 此命令仅分析暂存的更改。需要先使用 `git add` 暂存更改。

```bash
# 如果没有暂存更改，會顯示警告
$ /commit-message
没有暂存的更改。請先執行 git add。
```

### 自動剪贴板功能

生成的主要候選會以 `git commit -m "消息"` 的完整格式自動復制到剪贴板。可以直接在終端粘贴執行。

**實現注意事項**:

- 將提交命令傳遞給 `pbcopy` 時，應與消息輸出分開執行
- 使用 `printf` 而不是 `echo` 以避免末尾換行

### 項目規範自動檢測

**重要**: 如果存在項目特有的規範，將優先使用。

#### 1. CommitLint 配置檢查

從以下文件自動檢測配置：

- `commitlint.config.js`
- `commitlint.config.mjs`
- `commitlint.config.cjs`
- `commitlint.config.ts`
- `.commitlintrc.js`
- `.commitlintrc.json`
- `.commitlintrc.yml`
- `.commitlintrc.yaml`
- `package.json` 的 `commitlint` 部分

```bash
# 搜索配置文件
find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
```

#### 2. 自定義類型檢測

項目特有類型示例：

```javascript
// commitlint.config.mjs
export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      [
        "feat",
        "fix",
        "docs",
        "style",
        "refactor",
        "test",
        "chore",
        "wip", // 進行中
        "hotfix", // 紧急修復
        "release", // 發布
        "deps", // 依賴更新
        "config", // 配置更改
      ],
    ],
  },
};
```

#### 3. 語言設置檢測

```javascript
// 項目使用繁体字中文消息時
export default {
  rules: {
    "subject-case": [0], // 為支持繁体字中文而禁用
    "subject-max-length": [2, "always", 72], // 為繁体字中文調整字符數限制
  },
};
```

#### 4. 現有提交歷史分析

```bash
# 從最近的提交學習使用模式
git log --oneline -50 --pretty=format:"%s"

# 使用類型統計
git log --oneline -100 --pretty=format:"%s" | \
grep -oE '^[a-z]+(\([^)]+\))?' | \
sort | uniq -c | sort -nr
```

### 語言自動判定

根據以下條件自動切換繁体字中文/英文：

1. **CommitLint 配置**中的語言設置
2. **git log 分析**的自動判定
3. **項目文件**的語言設置
4. **更改文件**中的注釋和字符串分析

默認為英文。判定為繁体字中文項目時生成繁体字中文消息。

### 消息格式

#### Conventional Commits (默認)

```text
<type>: <description>
```

**重要**: 必须生成單行提交消息。不生成多行消息。

**注意**: 如果項目有特有規範，將優先使用。

### 標準類型

**必须類型**:

- `feat`: 新功能 (用戶可見的功能添加)
- `fix`: 缺陷修復

**可選類型**:

- `build`: 構建系統或外部依賴的更改
- `chore`: 其他更改 (不影響發布)
- `ci`: CI 配置文件或腳本的更改
- `docs`: 仅文檔更改
- `style`: 不影響代碼含義的更改 (空格、格式、分号等)
- `refactor`: 既不修復缺陷也不添加功能的代碼更改
- `perf`: 性能改進
- `test`: 添加或更正測試

### 輸出示例 (英文項目)

```bash
$ /commit-message

📝 提交消息建議
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 主要候選:
feat: implement JWT-based authentication system

📋 備選方案:
1. feat: add user authentication with JWT tokens
2. fix: resolve token validation error in auth middleware
3. refactor: extract auth logic into separate module

✅ `git commit -m "feat: implement JWT-based authentication system"` 已復制到剪贴板
```

**實現示例 (更正版)**:

```bash
# 先將提交命令復制到剪贴板 (無換行)
printf 'git commit -m "%s"' "$COMMIT_MESSAGE" | pbcopy

# 然後顯示消息
cat << EOF
📝 提交消息建議
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 主要候選:
$COMMIT_MESSAGE

📋 備選方案:
1. ...
2. ...
3. ...

✅ `git commit -m "$COMMIT_MESSAGE"` 已復制到剪贴板
EOF
```

### 輸出示例 (繁体字中文項目)

```bash
$ /commit-message

📝 提交消息建議
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 主要候選:
feat: 實作 JWT 認證系統

📋 備選方案:
1. feat: 新增基於 JWT 令牌的使用者認證
2. fix: 解決認證中介軟體的令牌驗證錯誤
3. docs: 將認證邏輯分離到獨立模組

✅ `git commit -m "feat: 實作 JWT 認證系統"` 已復制到剪贴板
```

### 工作概要

1. **分析**: 分析 `git diff --staged` 的內容
2. **生成**: 生成合適的提交消息
3. **復制**: 自動將主要候選復制到剪贴板

**注意**: 此命令不執行 git add 或 git commit。仅生成提交消息並復制到剪贴板。

### 智能功能

#### 1. 更改內容自動分類 (仅暂存文件)

- 新文件添加 → `feat`
- 錯誤修復模式 → `fix`
- 仅測試文件 → `test`
- 配置文件更改 → `chore`
- README/docs 更新 → `docs`

#### 2. 項目規範自動檢測

- `.gitmessage` 文件
- `CONTRIBUTING.md` 中的規範
- 過去提交歷史模式

#### 3. 語言判定詳情 (仅暂存更改)

```bash
# 判定基準 (優先級)
1. 從 git diff --staged 的內容判定語言
2. 暂存文件的注釋分析
3. git log --oneline -20 的語言分析
4. 項目主要語言設置
```

#### 4. 暂存分析詳情

分析使用的資訊 (仅讀取):

- `git diff --staged --name-only` - 更改文件列表
- `git diff --staged` - 實際更改內容
- `git status --porcelain` - 文件狀態

### Breaking Change 檢測時

当有 API 破坏性更改時：

**英文**:

```bash
feat!: change user API response format

BREAKING CHANGE: user response now includes additional metadata
```

或

```bash
feat(api)!: change authentication flow
```

**繁体字中文**:

```bash
feat!: 更改用戶 API 響應格式

BREAKING CHANGE: 響應現在包含额外的元數據
```

或

```bash
feat(api)!: 更改認證流程
```

### 最佳實践

1. **適應項目**: 遵循現有的提交語言
2. **簡洁性**: 50 字符內要清楚
3. **一致性**: 不要混合使用 (英文就統一英文)
4. **OSS**: 開源軟件推薦英文
5. **坚持單行**: 必须單行提交消息 (需要詳细說明時在 PR 中補充)

### 常見模式

**英文**:

```text
feat: add user registration endpoint
fix: resolve memory leak in cache manager
docs: update API documentation
```

**繁体字中文**:

```text
feat: 添加用戶注冊端點
fix: 解決緩存管理器內存洩漏
docs: 更新 API 文檔
```

### 與 Claude 的協作

```bash
# 與暂存更改結合使用
git add -p  # 交互式暂存
/commit-message
"生成最優的提交消息"

# 仅暂存特定文件後分析
git add src/auth/*.js
/commit-message --lang zh-tw
"為認證相關更改生成合適的消息"

# Breaking Change 檢測和應對
git add -A
/commit-message --breaking
"如有破坏性更改請適当標記"
```

### 注意事項

- **前提條件**: 更改需要先通過 `git add` 暂存
- **限制事項**: 未暂存的更改不在分析範圍內
- **推薦事項**: 請事先確認項目現有的提交規範
