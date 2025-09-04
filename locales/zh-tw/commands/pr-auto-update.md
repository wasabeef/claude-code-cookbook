## PR 自動更新

## 概述

自動更新 Pull Request 描述和標簽的命令。通過分析 Git 更改內容，生成並設置適当的描述文本和標簽。

## 使用方法

```bash
/pr-auto-update [選項] [PR 編号]
```

### 選項

- `--pr <編号>` : 指定目標 PR 編号(省略時從當前分支自動檢測)
- `--description-only` : 仅更新描述(不修改標簽)
- `--labels-only` : 仅更新標簽(不修改描述)
- `--dry-run` : 不執行實際更新，仅顯示生成的內容
- `--lang <語言>` : 指定語言(zh-tw, en)

### 基本示例

```bash
# 自動更新當前分支的 PR
/pr-auto-update

# 更新特定的 PR
/pr-auto-update --pr 1234

# 仅更新描述
/pr-auto-update --description-only

# 預演模式確認
/pr-auto-update --dry-run
```

## 功能詳情

### 1. PR 自動檢測

從當前分支自動檢測對應的 PR：

```bash
# 從分支搜索 PR
gh pr list --head $(git branch --show-current) --json number,title,url
```

### 2. 更改內容分析

收集和分析以下資訊：

- **文件更改**: 添加、刪除、修改的文件
- **代碼分析**: import 語句、函數定義、類定義的更改
- **測試**: 測試文件的存在與內容
- **文檔**: README、docs 的更新
- **配置**: package.json、pubspec.yaml、配置文件的更改
- **CI/CD**: GitHub Actions、workflow 的更改

### 3. 描述文本自動生成

#### 模板處理優先級

1. **現有 PR 描述**: **完全遵循**已存在的內容
2. **項目模板**: 從 `.github/PULL_REQUEST_TEMPLATE.md` 獲取結構
3. **默認模板**: 上述不存在時的後備方案

#### 現有內容保留規則

**重要**: 不修改現有內容

- 保留已寫的部分
- 仅補充空白部分
- 保留功能性注釋(如 Copilot review rule 等)

#### 項目模板的使用

```bash
# 解析 .github/PULL_REQUEST_TEMPLATE.md 的結構
parse_template_structure() {
  local template_file="$1"
  
  if [ -f "$template_file" ]; then
    # 提取部分結構
    grep -E '^##|^###' "$template_file"
    
    # 識別注釋佔位符
    grep -E '<!--.*-->' "$template_file"
    
    # 完全遵循現有模板結構
    cat "$template_file"
  fi
}
```

### 4. 標簽自動設置

#### 標簽獲取機制

**優先級**:

1. **`.github/labels.yml`**: 從項目特定的標簽定義獲取
2. **GitHub API**: 使用 `gh api repos/{OWNER}/{REPO}/labels --jq '.[].name'` 獲取現有標簽

#### 自動判定規則

**基于文件模式**:

- 文檔: `*.md`, `README`, `docs/` → 包含 `documentation|docs|doc` 的標簽
- 測試: `test`, `spec` → 包含 `test|testing` 的標簽
- CI/CD: `.github/`, `*.yml`, `Dockerfile` → 包含 `ci|build|infra|ops` 的標簽
- 依賴: `package.json`, `pubspec.yaml`, `requirements.txt` → 包含 `dependencies|deps` 的標簽

**基于更改內容**:

- Bug 修復: `fix|bug|error|crash|修復` → 包含 `bug|fix` 的標簽
- 新功能: `feat|feature|add|implement|新功能|實裝` → 包含 `feature|enhancement|feat` 的標簽
- 重構: `refactor|clean|重構` → 包含 `refactor|cleanup|clean` 的標簽
- 性能: `performance|perf|optimize|性能` → 包含 `performance|perf` 的標簽
- 安全: `security|secure|安全` → 包含 `security` 的標簽

#### 約束

- **最多 3 個**: 自動選擇的標簽數量上限
- **仅限現有標簽**: 禁止創建新標簽
- **部分匹配**: 根據標簽名是否包含關鍵詞判定

#### 實際使用示例

**存在 `.github/labels.yml` 時**:

```bash
# 從標簽定義自動獲取
grep "^- name:" .github/labels.yml | sed "s/^- name: '\\?\\([^']*\\)'\\?/\\1/"

# 例：使用項目特定的標簽體系
```

**從 GitHub API 獲取時**:

```bash
# 獲取現有標簽列表
gh api repos/{OWNER}/{REPO}/labels --jq '.[].name'

# 例：使用 bug, enhancement, documentation 等標準標簽
```

### 5. 執行流程

```bash
#!/bin/bash

# 1. PR 檢測與獲取
detect_pr() {
  if [ -n "$PR_NUMBER" ]; then
    echo $PR_NUMBER
  else
    gh pr list --head $(git branch --show-current) --json number --jq '.[0].number'
  fi
}

# 2. 更改內容分析
analyze_changes() {
  local pr_number=$1
  
  # 獲取文件更改
  gh pr diff $pr_number --name-only
  
  # 內容分析
  gh pr diff $pr_number | head -1000
}

# 3. 描述生成
generate_description() {
  local pr_number=$1
  local changes=$2
  
  # 獲取當前 PR 描述
  local current_body=$(gh pr view $pr_number --json body --jq -r .body)
  
  # 如有現有內容則直接使用
  if [ -n "$current_body" ]; then
    echo "$current_body"
  else
    # 從模板生成新內容
    local template_file=".github/PULL_REQUEST_TEMPLATE.md"
    if [ -f "$template_file" ]; then
      generate_from_template "$(cat "$template_file")" "$changes"
    else
      generate_from_template "" "$changes"
    fi
  fi
}

# 從模板生成
generate_from_template() {
  local template="$1"
  local changes="$2"
  
  if [ -n "$template" ]; then
    # 直接使用模板(保留 HTML 注釋)
    echo "$template"
  else
    # 使用默認格式生成
    echo "## What does this change?"
    echo ""
    echo "$changes"
  fi
}

# 4. 標簽確定
determine_labels() {
  local changes=$1
  local file_list=$2
  local pr_number=$3
  
  # 獲取可用標簽
  local available_labels=()
  if [ -f ".github/labels.yml" ]; then
    # 從 labels.yml 提取標簽名
    available_labels=($(grep "^- name:" .github/labels.yml | sed "s/^- name: '\\?\\([^']*\\)'\\?/\\1/"))
  else
    # 從 GitHub API 獲取標簽
    local repo_info=$(gh repo view --json owner,name)
    local owner=$(echo "$repo_info" | jq -r .owner.login)
    local repo=$(echo "$repo_info" | jq -r .name)
    available_labels=($(gh api "repos/$owner/$repo/labels" --jq '.[].name'))
  fi
  
  local suggested_labels=()
  
  # 通用模式匹配
  analyze_change_patterns "$file_list" "$changes" available_labels suggested_labels
  
  # 限制最多 3 個
  echo "${suggested_labels[@]:0:3}"
}

# 根據更改模式確定標簽
analyze_change_patterns() {
  local file_list="$1"
  local changes="$2"
  local -n available_ref=$3
  local -n suggested_ref=$4
  
  # 根據文件類型判定
  if echo "$file_list" | grep -q "\\.md$\\|README\\|docs/"; then
    add_matching_label "documentation\\|docs\\|doc" available_ref suggested_ref
  fi
  
  if echo "$file_list" | grep -q "test\\|spec"; then
    add_matching_label "test\\|testing" available_ref suggested_ref
  fi
  
  # 根據更改內容判定
  if echo "$changes" | grep -iq "fix\\|bug\\|error\\|crash\\|修復"; then
    add_matching_label "bug\\|fix" available_ref suggested_ref
  fi
  
  if echo "$changes" | grep -iq "feat\\|feature\\|add\\|implement\\|新功能\\|實現"; then
    add_matching_label "feature\\|enhancement\\|feat" available_ref suggested_ref
  fi
}

# 添加匹配的標簽
add_matching_label() {
  local pattern="$1"
  local -n available_ref=$2
  local -n suggested_ref=$3
  
  # 如果已有 3 個則跳過
  if [ ${#suggested_ref[@]} -ge 3 ]; then
    return
  fi
  
  # 添加匹配模式的第一個標簽
  for available_label in "${available_ref[@]}"; do
    if echo "$available_label" | grep -iq "$pattern"; then
      # 重復檢查
      local already_exists=false
      for existing in "${suggested_ref[@]}"; do
        if [ "$existing" = "$available_label" ]; then
          already_exists=true
          break
        fi
      done
      
      if [ "$already_exists" = false ]; then
        suggested_ref+=("$available_label")
        return
      fi
    fi
  done
}

# 為兼容性保留旧函數
find_and_add_label() {
  add_matching_label "$@"
}

# 5. PR 更新
update_pr() {
  local pr_number=$1
  local description="$2"
  local labels="$3"
  
  if [ "$DRY_RUN" = "true" ]; then
    echo "=== DRY RUN ==="
    echo "Description:"
    echo "$description"
    echo "Labels: $labels"
  else
    # 獲取倉庫資訊
    local repo_info=$(gh repo view --json owner,name)
    local owner=$(echo "$repo_info" | jq -r .owner.login)
    local repo=$(echo "$repo_info" | jq -r .name)
    
    # 使用 GitHub API 更新正文(保留 HTML 注釋)
    # 正確處理 JSON 轉義
    local escaped_body=$(echo "$description" | jq -R -s .)
    gh api \
      --method PATCH \
      "/repos/$owner/$repo/pulls/$pr_number" \
      --field body="$description"
    
    # 標簽使用常規 gh 命令即可
    if [ -n "$labels" ]; then
      gh pr edit $pr_number --add-label "$labels"
    fi
  fi
}
```

## 配置文件(未來擴展用)

`~/.claude/pr-auto-update.config`:

```json
{
  "language": "zh-tw",
  "max_labels": 3
}
```

## 常見模式

### Flutter 項目

```markdown
## What does this change?

實現了{功能名}。解決了用戶的{問題}。

### 主要更改內容

- **UI 實現**: 新建{画面名}
- **狀態管理**: 添加 Riverpod Provider
- **API 集成**: 實現 GraphQL 查询與變更
- **測試**: 添加 Widget 測試和單元測試

### 技術規格

- **架構**: {使用的模式}
- **依賴**: {新增的包}
- **性能**: {優化內容}
```

### Node.js 項目

```markdown
## What does this change?

實現了{API 名}端點。支持{用例}。

### 主要更改內容

- **API 實現**: 新建{端點}
- **驗證**: 添加請求驗證邏輯
- **數據庫**: 實現對{表名}的操作
- **測試**: 添加集成測試和單元測試

### 安全性

- **認證**: JWT 令牌驗證
- **授權**: 基于角色的訪問控制
- **輸入驗證**: SQL 注入防護
```

### CI/CD 改進

```markdown
## What does this change?

改進了 GitHub Actions 工作流。實現了{效果}。

### 改進內容

- **性能**: 構建時間减少{時間}
- **可靠性**: 增強錯誤處理
- **安全性**: 改進密鑰管理

### 技術细节

- **並行化**: {作業名}並行執行
- **緩存**: 優化{緩存對象}的緩存策略
- **監控**: 添加{指標}監控
```

## 注意事項

1. **完全保留現有內容**:
   - **一字不改**現有描述內容
   - 仅補充空白注釋和佔位符
   - 尊重用戶有意編寫的內容

2. **模板優先級**:
   - 現有 PR 描述 > `.github/PULL_REQUEST_TEMPLATE.md` > 默認
   - 完全遵循項目特定的模板結構

3. **標簽約束**:
   - 如存在 `.github/labels.yml` 則優先使用
   - 不存在時從 GitHub API 獲取現有標簽
   - 禁止創建新標簽
   - 自動選擇最多 3 個

4. **安全更新**:
   - 推薦使用 `--dry-run` 預先確認
   - 包含敏感資訊的更改時顯示警告
   - 保存原始描述作為備份

5. **保持一致性**:
   - 符合項目現有 PR 風格
   - 統一語言(中文/英語)
   - 繼承標簽規則

## 故障排除

### 常見問題

1. **找不到 PR**: 檢查分支名與 PR 的關聯
2. **權限錯誤**: 檢查 GitHub CLI 的認證狀態
3. **無法設置標簽**: 檢查倉庫權限
4. **HTML 注釋被轉義**: GitHub CLI 的規格導致 `<!-- -->` 被轉換為 `&lt;!-- --&gt;`

### GitHub CLI 的 HTML 注釋轉義問題

**重要**: GitHub CLI (`gh pr edit`) 會自動轉義 HTML 注釋。此外，Shell 的重定向處理可能混入 `EOF < /dev/null` 等非法字符串。

#### 根本解決方案

1. **使用 GitHub API 的 --field 選項**: 使用 `--field` 進行適当的轉義處理
2. **簡化 Shell 處理**: 避免復杂的重定向和管道處理
3. **簡化模板處理**: 废除 HTML 注釋移除處理，完全保留
4. **正確處理 JSON 轉義**: 正確處理特殊字符

### 調試選項

```bash
# 輸出詳细日誌(實現時添加)
/pr-auto-update --verbose
```
