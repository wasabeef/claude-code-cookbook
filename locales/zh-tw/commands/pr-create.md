## PR 創建（已不推薦）

> 不再推薦：請優先使用 `/pr-create-smart` 生成高質量的 PR 描述草稿，然後使用 gh/GUI 創建 PR。本命令属于“端到端自動創建 PR（保留模板、自動打標簽、創建 Draft）”的旧方案，仅為兼容保留。

基于 Git 變更分析的自動 PR 創建，實現高效的 Pull Request 工作流程。

### 使用方法

```bash
# 基于變更分析的自動 PR 創建
git add . && git commit -m "feat: 實現用戶認證功能"
"分析變更內容並使用適当的描述和標簽創建 Draft PR"

# 保留現有模板的更新
cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
"完全保留模板結構並補充變更內容"

# 逐步提升質量
gh pr ready
"質量確認完成後，更改為 Ready for Review"
```

### 基本示例

```bash
# 1. 創建分支並提交
git checkout main && git pull
git checkout -b feat-user-profile
git add . && git commit -m "feat: 實現用戶檔案功能"
git push -u origin feat-user-profile

# 2. PR 創建
"請按以下步骤創建 PR：
1. 使用 git diff --cached 確認變更內容
2. 使用 .github/PULL_REQUEST_TEMPLATE.md 創建描述
3. 從變更內容選擇最多 3 個適当的標簽
4. 創建 Draft PR（保留 HTML 注釋）"

# 3. CI 確認後轉為 Ready
"CI 通過後將 PR 更改為 Ready for Review"
```

### 執行步骤

#### 1. 分支創建

```bash
# 遵循準則的命名規則: {type}-{subject}
git checkout main
git pull
git checkout -b feat-user-authentication

# 確認分支（顯示當前分支名）
git branch --show-current
```

#### 2. 提交

```bash
# 暂存變更
git add .

# 遵循準則的提交消息
git commit -m "feat: 實現用戶認證 API"
```

#### 3. 推送到远程

```bash
# 首次推送（設置 upstream）
git push -u origin feat-user-authentication

# 後續推送
git push
```

#### 4. 基于自動分析創建 Draft PR

**步骤 1: 分析變更內容**

```bash
# 獲取文件變更（確認已暂存的變更）
git diff --cached --name-only

# 內容分析（最多 1000 行）
git diff --cached | head -1000
```

**步骤 2: 自動生成描述**

```bash
# 模板處理優先級
# 1. 現有 PR 描述（完全保留）
# 2. .github/PULL_REQUEST_TEMPLATE.md
# 3. 默認模板

cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
# 保留 HTML 注釋·分隔線，仅補充空白部分
```

**步骤 3: 自動選擇標簽**

```bash
# 獲取可用標簽（非交互式）
"從 .github/labels.yml 或 GitHub 倉庫獲取可用標簽，根據變更內容自動選擇適当的標簽"

# 通過模式匹配自動選擇（最多 3 個）
# - 文檔: *.md, docs/ → documentation|docs
# - 測試: test, spec → test|testing
# - Bug 修復: fix|bug → bug|fix
# - 新功能: feat|feature → feature|enhancement
```

**步骤 4: 通過 GitHub API 創建 PR（保留 HTML 注釋）**

```bash
# PR 創建
"使用以下資訊創建 Draft PR：
- 標題: 從提交消息自動生成
- 描述: 使用 .github/PULL_REQUEST_TEMPLATE.md 適当填寫
- 標簽: 從變更內容自動選擇（最多 3 個）
- 基礎分支: main
- 完全保留 HTML 注釋"
```

**方法 B: GitHub MCP（備用）**

```javascript
// 保留 HTML 注釋的 PR 創建
mcp_github_create_pull_request({
  owner: 'organization',
  repo: 'repository',
  base: 'main',
  head: 'feat-user-authentication',
  title: 'feat: 實現用戶認證',
  body: prBodyContent, // 包含 HTML 注釋的完整內容
  draft: true,
  maintainer_can_modify: true,
});
```

### 自動標簽選擇系統

#### 基于文件模式的判定

- **文檔**: `*.md`, `README`, `docs/` → `documentation|docs|doc`
- **測試**: `test`, `spec` → `test|testing`
- **CI/CD**: `.github/`, `*.yml`, `Dockerfile` → `ci|build|infra|ops`
- **依賴**: `package.json`, `pubspec.yaml` → `dependencies|deps`

#### 基于變更內容的判定

- **Bug 修復**: `fix|bug|error|crash|修復` → `bug|fix`
- **新功能**: `feat|feature|add|implement|新功能|實現` → `feature|enhancement|feat`
- **重構**: `refactor|clean|重構` → `refactor|cleanup|clean`
- **性能**: `performance|perf|optimize` → `performance|perf`
- **安全**: `security|secure` → `security`

#### 約束條件

- **最多 3 個**: 自動選擇的上限
- **仅現有標簽**: 禁止新建
- **部分匹配**: 通過關鍵詞包含進行判定

### 項目準則

#### 基本原則

1. **必须以 Draft 開始**: 所有 PR 都以 Draft 狀態創建
2. **逐步提升質量**: 阶段 1（基本實現）→ 阶段 2（添加測試）→ 阶段 3（更新文檔）
3. **適当的標簽**: 必须添加最多 3 种標簽
4. **使用模板**: 必须使用 `.github/PULL_REQUEST_TEMPLATE.md`
5. **中文空格**: 中文與半角英數字之間必须有半角空格

#### 分支命名規則

```text
{type}-{subject}

示例:
- feat-user-profile
- fix-login-error
- refactor-api-client
```

#### 提交消息

```text
{type}: {description}

示例:
- feat: 實現用戶認證 API
- fix: 修復登錄錯誤
- docs: 更新 README
```

### 模板處理系統

#### 處理優先級

1. **現有 PR 描述**: **完全沿用**已編寫的內容
2. **項目模板**: 保持 `.github/PULL_REQUEST_TEMPLATE.md` 結構
3. **默認模板**: 以上不存在時使用

#### 現有內容保留規則

- **一字不改**: 已編寫的內容
- **仅補充空白部分**: 用變更內容填充佔位符部分
- **保留功能性注釋**: 保持 `<!-- Copilot review rule -->` 等
- **保留 HTML 注釋**: 完全保留 `<!-- ... -->`
- **保留分隔線**: 保持 `---` 等結構

#### HTML 注釋保留的處理方法

**重要**: GitHub CLI (`gh pr edit`) 會自動轉義 HTML 注釋，在 Shell 處理中可能混入 `EOF < /dev/null` 等非法字符串。

**根本解決方案**:

1. **使用 GitHub API 的 --field 選項**: 通過適当的轉義處理保留 HTML 注釋
2. **簡化模板處理**: 避免復杂的管道處理和重定向
3. **完全保留方法**: 废除 HTML 注釋刪除處理，完全保留模板

### 審查評論響應

```bash
# 變更後重新提交
git add .
git commit -m "fix: 基于審查反饋的修正"
git push
```

### 注意事項

#### HTML 注釋保留的重要性

- **GitHub CLI 限制**: `gh pr edit` 會轉義 HTML 注釋，混入非法字符串
- **根本規避策略**: 使用 GitHub API 的 `--field` 選項進行適当的轉義處理
- **模板完全保留**: 废除 HTML 注釋刪除處理，完全維護結構

#### 自動化的約束

- **禁止新建標簽**: 不可創建 `.github/labels.yml` 定義外的標簽
- **最多 3 個標簽**: 自動選擇的上限
- **現有內容優先**: 不更改手動編寫的內容

#### 逐步提升質量

- **Draft 必须**: 所有 PR 以 Draft 開始
- **CI 確認**: 使用 `gh pr checks` 確認狀態
- **轉為 Ready**: 質量確認完成後使用 `gh pr ready`
- **完全遵守模板**: 維護項目特有的結構
