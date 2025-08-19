## 語義化提交

將大型變更拆分為有意義的最小單位，並按顺序使用語義化提交消息進行提交。不依賴外部工具，仅使用 git 標準命令。

### 使用方法

```bash
/semantic-commit [選項]
```

### 選項

- `--dry-run` : 不實際提交，仅顯示建議的提交拆分
- `--lang <語言>` : 強制指定提交消息語言（en, zh-tw）
- `--max-commits <數>` : 指定最大提交數（默認: 10）

### 基本示例

```bash
# 分析當前變更並按邏輯單位提交
/semantic-commit

# 仅確認拆分方案（不實際提交）
/semantic-commit --dry-run

# 用繁体字中文生成提交消息
/semantic-commit --lang zh-tw

# 最多拆分為 5 個提交
/semantic-commit --max-commits 5
```

### 工作流程

1. **變更分析**: 通過 `git diff HEAD` 獲取所有變更
2. **文件分類**: 將變更的文件邏輯分組
3. **提交建議**: 為各組生成語義化提交消息
4. **顺序執行**: 用戶確認後，按顺序提交各組

### 變更拆分的核心功能

#### "大型變更"的檢測

以下條件被檢測為大型變更：

1. **變更文件數**: 5 個以上文件的變更
2. **變更行數**: 100 行以上的變更
3. **多功能**: 跨越 2 個以上功能區域的變更
4. **混合模式**: feat + fix + docs 混合

```bash
# 變更規模分析
CHANGED_FILES=$(git diff HEAD --name-only | wc -l)
CHANGED_LINES=$(git diff HEAD --stat | tail -1 | grep -o '[0-9]\+ insertions\|[0-9]\+ deletions' | awk '{sum+=$1} END {print sum}')

if [ $CHANGED_FILES -ge 5 ] || [ $CHANGED_LINES -ge 100 ]; then
  echo "檢測到大型變更: 建議拆分"
fi
```

#### "有意義的最小單位"拆分策略

##### 1. 按功能邊界拆分

```bash
# 從目錄結構識別功能單位
git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq
# → src/auth, src/api, components/ui 等
```

##### 2. 按變更類型分離

```bash
# 新文件 vs 現有文件修改
git diff HEAD --name-status | grep '^A' # 新文件
git diff HEAD --name-status | grep '^M' # 修改文件
git diff HEAD --name-status | grep '^D' # 刪除文件
```

##### 3. 依賴關系分析

```bash
# 檢測導入關系的變更
git diff HEAD | grep -E '^[+-].*import|^[+-].*require' | \
cut -d' ' -f2- | sort | uniq
```

#### 文件單位的詳细分析

```bash
# 獲取變更文件列表
git diff HEAD --name-only

# 分別分析各文件的變更內容
git diff HEAD -- <file>

# 判定文件的變更類型
git diff HEAD --name-status | while read status file; do
  case $status in
    A) echo "$file: 新建" ;;
    M) echo "$file: 修改" ;;
    D) echo "$file: 刪除" ;;
    R*) echo "$file: 重命名" ;;
  esac
done
```

#### 邏輯分組的標準

1. **功能單位**: 相關功能的文件
   - `src/auth/` 下的文件 → 認證功能
   - `components/` 下的文件 → UI 組件

2. **變更類型**: 相同類型的變更
   - 仅測試文件 → `test:`
   - 仅文檔 → `docs:`
   - 仅配置文件 → `chore:`

3. **依賴關系**: 相互關聯的文件
   - 模型 + 遷移
   - 組件 + 樣式

4. **變更規模**: 保持適当的提交大小
   - 每個提交 10 個文件以下
   - 高關聯性文件分組

### 輸出示例

```bash
$ /semantic-commit

變更分析中...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

檢測到的變更:
• src/auth/login.ts (修改)
• src/auth/register.ts (新建)
• src/auth/types.ts (修改)
• tests/auth.test.ts (新建)
• docs/authentication.md (新建)

建議的提交拆分:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
提交 1/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
消息: feat: 實現用戶注冊和登錄系統
包含文件:
  • src/auth/login.ts
  • src/auth/register.ts  
  • src/auth/types.ts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
提交 2/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
消息: test: 添加認證系統的全面測試
包含文件:
  • tests/auth.test.ts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
提交 3/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
消息: docs: 添加認證系統文檔
包含文件:
  • docs/authentication.md

是否按此拆分方案執行提交？ (y/n/edit): 
```

### 執行時的選項

- `y` : 按建議的拆分執行
- `n` : 取消
- `edit` : 逐個編輯提交消息
- `merge <編号 1> <編号 2>` : 合並指定的提交
- `split <編号>` : 進一步拆分指定的提交

### Dry Run 模式

```bash
$ /semantic-commit --dry-run

變更分析中... (DRY RUN)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[顯示提交拆分建議]

ℹ️  DRY RUN 模式: 不會實際執行提交
💡 要執行請去掉 --dry-run 選項重新運行
```

### 智能分析功能

#### 1. 項目結構理解

- 從 `package.json`, `Cargo.toml`, `pom.xml` 等判斷項目類型
- 從文件夹結構推測功能單位

#### 2. 變更模式識別

```bash
# 檢測 Bug 修復模式
- "fix", "bug", "error" 等關鍵詞
- 異常處理的添加
- 條件分支的修改

# 檢測新功能模式  
- 新文件創建
- 新方法添加
- API 端點添加
```

#### 3. 依賴關系分析

- 導入語句的變更
- 類型定義的添加/修改
- 與配置文件的關聯性

### 技術實現

#### 使用 Git 標準命令的顺序提交實現

##### 1. 預處理: 保存當前狀態

```bash
# 如有未暂存的變更則先重置
git reset HEAD
git status --porcelain > /tmp/original_state.txt

# 確認工作分支
CURRENT_BRANCH=$(git branch --show-current)
echo "工作分支: $CURRENT_BRANCH"
```

##### 2. 按組顺序執行提交

```bash
# 讀取拆分計劃
while IFS= read -r commit_plan; do
  group_num=$(echo "$commit_plan" | cut -d':' -f1)
  files=$(echo "$commit_plan" | cut -d':' -f2- | tr ' ' '\n')
  
  echo "=== 執行提交 $group_num ==="
  
  # 仅暂存相關文件
  echo "$files" | while read file; do
    if [ -f "$file" ]; then
      git add "$file"
      echo "暂存: $file"
    fi
  done
  
  # 確認暂存狀態
  staged_files=$(git diff --staged --name-only)
  if [ -z "$staged_files" ]; then
    echo "警告: 没有暂存的文件"
    continue
  fi
  
  # 生成提交消息（LLM 分析）
  commit_msg=$(generate_commit_message_for_staged_files)
  
  # 用戶確認
  echo "建議的提交消息: $commit_msg"
  echo "暂存的文件:"
  echo "$staged_files"
  read -p "執行此提交？ (y/n): " confirm
  
  if [ "$confirm" = "y" ]; then
    # 執行提交
    git commit -m "$commit_msg"
    echo "✅ 提交 $group_num 完成"
  else
    # 取消暂存
    git reset HEAD
    echo "❌ 跳過提交 $group_num"
  fi
  
done < /tmp/commit_plan.txt
```

##### 3. 錯誤處理和回滾

```bash
# 預提交钩子失败時的處理
commit_with_retry() {
  local commit_msg="$1"
  local max_retries=2
  local retry_count=0
  
  while [ $retry_count -lt $max_retries ]; do
    if git commit -m "$commit_msg"; then
      echo "✅ 提交成功"
      return 0
    else
      echo "❌ 提交失败 (尝試 $((retry_count + 1))/$max_retries)"
      
      # 合並預提交钩子的自動更正
      if git diff --staged --quiet; then
        echo "預提交钩子自動更正了變更"
        git add -u
      fi
      
      retry_count=$((retry_count + 1))
    fi
  done
  
  echo "❌ 提交失败。請手動確認。"
  return 1
}

# 從中斷恢復
resume_from_failure() {
  echo "檢測到中斷的提交處理"
  echo "當前暂存狀態:"
  git status --porcelain
  
  read -p "繼續處理？ (y/n): " resume
  if [ "$resume" = "y" ]; then
    # 從最後的提交位置恢復
    last_commit=$(git log --oneline -1 --pretty=format:"%s")
    echo "最後的提交: $last_commit"
  else
    # 完全重置
    git reset HEAD
    echo "處理已重置"
  fi
}
```

##### 4. 完成後的驗證

```bash
# 確認所有變更都已提交
remaining_changes=$(git status --porcelain | wc -l)
if [ $remaining_changes -eq 0 ]; then
  echo "✅ 所有變更都已提交"
else
  echo "⚠️  還有未提交的變更:"
  git status --short
fi

# 顯示提交歷史
echo "創建的提交:"
git log --oneline -n 10 --graph
```

##### 5. 抑制自動推送

```bash
# 注意: 不執行自動推送
echo "📝 注意: 不會自動推送"
echo "如需推送請執行以下命令:"
echo "  git push origin $CURRENT_BRANCH"
```

#### 拆分算法的詳细說明

##### 步骤 1: 初始分析

```bash
# 獲取所有變更文件並分類
git diff HEAD --name-status | while read status file; do
  echo "$status:$file"
done > /tmp/changes.txt

# 按功能目錄統計變更
git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq -c
```

##### 步骤 2: 基于功能邊界的初始分組

```bash
# 基于目錄的分組
GROUPS=$(git diff HEAD --name-only | cut -d'/' -f1-2 | sort | uniq)
for group in $GROUPS; do
  echo "=== 組別: $group ==="
  git diff HEAD --name-only | grep "^$group" | head -10
done
```

##### 步骤 3: 變更內容相似性分析

```bash
# 分析各文件的變更類型
git diff HEAD --name-only | while read file; do
  # 檢測新函數/類的添加
  NEW_FUNCTIONS=$(git diff HEAD -- "$file" | grep -c '^+.*function\|^+.*class\|^+.*def ')
  
  # 檢測 Bug 修復模式
  BUG_FIXES=$(git diff HEAD -- "$file" | grep -c '^+.*fix\|^+.*bug\|^-.*error')
  
  # 判斷是否為測試文件
  if [[ "$file" =~ test|spec ]]; then
    echo "$file: TEST"
  elif [ $NEW_FUNCTIONS -gt 0 ]; then
    echo "$file: FEAT"
  elif [ $BUG_FIXES -gt 0 ]; then
    echo "$file: FIX"
  else
    echo "$file: REFACTOR"
  fi
done
```

##### 步骤 4: 基于依賴關系的調整

```bash
# 分析導入關系
git diff HEAD | grep -E '^[+-].*import|^[+-].*from.*import' | \
while read line; do
  echo "$line" | sed 's/^[+-]//' | awk '{print $2}'
done | sort | uniq > /tmp/imports.txt

# 相關文件的分組
git diff HEAD --name-only | while read file; do
  basename=$(basename "$file" .js .ts .py)
  related=$(git diff HEAD --name-only | grep "$basename" | grep -v "^$file$")
  if [ -n "$related" ]; then
    echo "相關文件組: $file <-> $related"
  fi
done
```

##### 步骤 5: 提交大小優化

```bash
# 調整組別大小
MAX_FILES_PER_COMMIT=8
current_group=1
file_count=0

git diff HEAD --name-only | while read file; do
  if [ $file_count -ge $MAX_FILES_PER_COMMIT ]; then
    current_group=$((current_group + 1))
    file_count=0
  fi
  echo "提交 $current_group: $file"
  file_count=$((file_count + 1))
done
```

##### 步骤 6: 最終分組確定

```bash
# 驗證拆分結果
for group in $(seq 1 $current_group); do
  files=$(grep "提交 $group:" /tmp/commit_plan.txt | cut -d':' -f2-)
  lines=$(echo "$files" | xargs git diff HEAD -- | wc -l)
  echo "提交 $group: $(echo "$files" | wc -w) 個文件, $lines 行變更"
done
```

### Conventional Commits 規範

#### 基本格式

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

#### 標準類型

**必需類型**:

- `feat`: 新功能（用戶可見的功能添加）
- `fix`: Bug 修復

**可選類型**:

- `build`: 構建系統或外部依賴的變更
- `chore`: 其他變更（不影響發布）
- `ci`: CI 配置文件和腳本的變更
- `docs`: 仅文檔變更
- `style`: 不影響代碼含義的變更（空白、格式、分号等）
- `refactor`: 既不修復 Bug 也不添加功能的代碼變更
- `perf`: 性能改進
- `test`: 添加或更正測試

#### 作用域（可選）

表示變更的影響範圍：

```
feat(api): 添加用戶認證端點
fix(ui): 解決按钮對齐問題
docs(readme): 更新安裝說明
```

#### Breaking Change

有 API 破坏性變更時：

```
feat!: 更改用戶 API 響應格式

BREAKING CHANGE: 用戶響應現在包含额外的元數據
```

或

```
feat(api)!: 更改認證流程
```

#### 項目規約的自動檢測

**重要**: 如果存在項目特有的規約，優先使用。

##### 1. CommitLint 配置確認

自動檢測以下文件的配置：

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
# 確認配置文件示例
cat commitlint.config.mjs
cat .commitlintrc.json
grep -A 10 '"commitlint"' package.json
```

##### 2. 自定義類型檢測

項目特有類型的示例：

```javascript
// commitlint.config.mjs
export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore',
        'wip',      // 進行中
        'hotfix',   // 紧急修復
        'release',  // 發布
        'deps',     // 依賴更新
        'config'    // 配置變更
      ]
    ]
  }
}
```

##### 3. 語言設置檢測

```javascript
// 項目使用中文消息時
export default {
  rules: {
    'subject-case': [0],  // 為支持中文而禁用
    'subject-max-length': [2, 'always', 72]  // 中文調整字符數限制
  }
}
```

#### 自動分析流程

1. **搜索配置文件**

   ```bash
   find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
   ```

2. **分析現有提交**

   ```bash
   git log --oneline -50 --pretty=format:"%s"
   ```

3. **使用類型統計**

   ```bash
   git log --oneline -100 --pretty=format:"%s" | \
   grep -oE '^[a-z]+(\([^)]+\))?' | \
   sort | uniq -c | sort -nr
   ```

#### 項目規約示例

##### Angular 風格

```
feat(scope): 添加新功能
fix(scope): 修復 Bug
docs(scope): 更新文檔
```

##### Gitmoji 結合風格

```
✨ feat: 添加用戶注冊
🐛 fix: 解決登錄問題
📚 docs: 更新 API 文檔
```

##### 中文項目

```
feat: 新增用戶注冊功能
fix: 修復登錄處理的 Bug
docs: 更新 API 文檔
```

### 語言判定

此命令完整的語言判定邏輯：

1. **從 CommitLint 配置**確認語言設置

   ```bash
   # subject-case 規則被禁用時判定為中文
   grep -E '"subject-case".*\[0\]|subject-case.*0' commitlint.config.*
   ```

2. **通過 git log 分析**自動判定

   ```bash
   # 分析最近 20 個提交的語言（繁体字中文）
   git log --oneline -20 --pretty=format:"%s" | \
   grep -E '[一-龯]' | wc -l
   # 50% 以上是繁体字中文則使用繁体字中文模式
   ```

3. **項目文件**的語言設置

   ```bash
   # 確認 README.md 的語言（繁体字中文）
   head -10 README.md | grep -E '[一-龯]' | wc -l
   
   # 確認 package.json 的 description（繁体字中文）
   grep -E '"description".*[一-龯]' package.json
   ```

4. **變更文件內**的注釋·字符串分析

   ```bash
   # 確認變更文件的注釋語言（繁体字中文）
   git diff HEAD | grep -E '^[+-].*//.*[一-龯]' | wc -l
   ```

#### 判定算法

```bash
# 語言判定分數計算（繁体字中文）
ZH_TW_SCORE=0

# 1. CommitLint 配置（+3 分）
if grep -q '"subject-case".*\[0\]' commitlint.config.* 2>/dev/null; then
  ZH_TW_SCORE=$((ZH_TW_SCORE + 3))
fi

# 2. git log 分析（最大 +2 分）
ZH_TW_COMMITS=$(git log --oneline -20 --pretty=format:"%s" | \
  grep -cE '[一-龯]' 2>/dev/null || echo 0)
if [ $ZH_TW_COMMITS -gt 10 ]; then
  ZH_TW_SCORE=$((ZH_TW_SCORE + 2))
elif [ $ZH_TW_COMMITS -gt 5 ]; then
  ZH_TW_SCORE=$((ZH_TW_SCORE + 1))
fi

# 3. README.md 確認（+1 分）
if head -5 README.md 2>/dev/null | grep -qE '[一-龯]'; then
  ZH_TW_SCORE=$((ZH_TW_SCORE + 1))
fi

# 4. 變更文件內容確認（+1 分）
if git diff HEAD 2>/dev/null | grep -qE '^[+-].*[一-龯]'; then
  ZH_TW_SCORE=$((ZH_TW_SCORE + 1))
fi

# 判定: 3 分以上為繁体字中文模式
if [ $ZH_TW_SCORE -ge 3 ]; then
  LANGUAGE="zh-tw"
else
  LANGUAGE="en"
fi
```

### 設置文件自動加載

#### 執行時的動作

命令執行時按以下顺序確認設置：

1. **搜索 CommitLint 配置文件**

   ```bash
   # 按以下顺序搜索，使用找到的第一個文件
   commitlint.config.mjs
   commitlint.config.js  
   commitlint.config.cjs
   commitlint.config.ts
   .commitlintrc.js
   .commitlintrc.json
   .commitlintrc.yml
   .commitlintrc.yaml
   package.json (commitlint 部分)
   ```

2. **解析配置內容**
   - 提取可用類型列表
   - 確認是否有作用域限制
   - 獲取消息长度限制
   - 確認語言設置

3. **分析現有提交歷史**

   ```bash
   # 從最近的提交學習使用模式
   git log --oneline -100 --pretty=format:"%s" | \
   head -20
   ```

#### 配置示例分析

**標準 commitlint.config.mjs**:

```javascript
export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      ['feat', 'fix', 'docs', 'style', 'refactor', 'perf', 'test', 'chore']
    ],
    'scope-enum': [
      2,
      'always',
      ['api', 'ui', 'core', 'auth', 'db']
    ]
  }
}
```

**中文對應配置**:

```javascript
export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'subject-case': [0],  // 為中文禁用
    'subject-max-length': [2, 'always', 72],
    'type-enum': [
      2,
      'always',
      ['feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore']
    ]
  }
}
```

**包含自定義類型的配置**:

```javascript
export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore',
        'wip',      // Work in Progress
        'hotfix',   // 紧急修復
        'release',  // 發布準備
        'deps',     // 依賴更新
        'config'    // 配置變更
      ]
    ]
  }
}
```

#### 後備行為

找不到配置文件時：

1. **基于 git log 分析**的自動推測

   ```bash
   # 從最近 100 個提交中提取類型
   git log --oneline -100 --pretty=format:"%s" | \
   grep -oE '^[a-z]+(\([^)]+\))?' | \
   sort | uniq -c | sort -nr
   ```

2. **使用 Conventional Commits 標準**作為默認

   ```
   feat, fix, docs, style, refactor, perf, test, chore, build, ci
   ```

3. **語言判定**
   - 中文提交 50% 以上 → 中文模式
   - 其他 → 英文模式

### 先決條件

- 在 Git 倉庫內執行
- 存在未提交的變更
- 已暂存的變更會被重置

### 注意事項

- **無自動推送**: 提交後的 `git push` 需手動執行
- **不創建分支**: 在當前分支提交
- **建議備份**: 重要變更前使用 `git stash` 備份

### 項目規約的優先級

生成提交消息時的優先級：

1. **CommitLint 配置** (最優先)
   - `commitlint.config.*` 文件的設置
   - 自定義類型和作用域限制
   - 消息长度和大小寫限制

2. **現有提交歷史** (第 2 優先)
   - 實際使用的類型統計
   - 消息語言（中文/英文）
   - 作用域使用模式

3. **項目類型** (第 3 優先)
   - `package.json` → Node.js 項目
   - `Cargo.toml` → Rust 項目  
   - `pom.xml` → Java 項目

4. **Conventional Commits 標準** (後備)
   - 未找到配置時的標準行為

#### 規約檢測實例

**Monorepo 的 scope 自動檢測**:

```bash
# 從 packages/ 文件夹推測 scope
ls packages/ | head -10
# → api, ui, core, auth 等作為 scope 建議
```

**框架特定規約**:

```javascript
// Angular 項目情况
{
  'scope-enum': [2, 'always', [
    'animations', 'common', 'core', 'forms', 'http', 'platform-browser',
    'platform-server', 'router', 'service-worker', 'upgrade'
  ]]
}

// React 項目情况  
{
  'scope-enum': [2, 'always', [
    'components', 'hooks', 'utils', 'types', 'styles', 'api'
  ]]
}
```

**企業·團隊特有規約**:

```javascript
// 中國企業常見模式
{
  'type-enum': [2, 'always', [
    'feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore',
    'wip',      // 進行中（Pull Request 用）
    'hotfix',   // 紧急修復
    'release'   // 發布準備
  ]],
  'subject-case': [0],  // 中文對應
  'subject-max-length': [2, 'always', 72]  // 中文設置较长
}
```

### 最佳實践

1. **尊重項目規約**: 遵循現有的設置和模式
2. **小變更單位**: 1 個提交 = 1 個邏輯變更
3. **清晰的消息**: 明確說明變更內容
4. **重視關聯性**: 將功能相關的文件分組
5. **分離測試**: 測試文件單独提交
6. **利用配置文件**: 引入 CommitLint 統一團隊規約

### 實際拆分示例（Before/After）

#### 示例 1: 大規模認證系統添加

**Before（1 個巨大提交）:**

```bash
# 變更文件（15 個文件，850 行變更）
src/auth/login.js          # 新建
src/auth/register.js       # 新建  
src/auth/password.js       # 新建
src/auth/types.js          # 新建
src/api/auth-routes.js     # 新建
src/middleware/auth.js     # 新建
src/database/migrations/001_users.sql  # 新建
src/database/models/user.js            # 新建
tests/auth/login.test.js   # 新建
tests/auth/register.test.js # 新建
tests/api/auth-routes.test.js # 新建
docs/authentication.md    # 新建
package.json              # 依賴添加
README.md                 # 使用方法添加
.env.example             # 環境變量示例添加

# 傳統的問題提交
feat: 實現完整的用戶認證系統，包含登錄、注冊、密碼重置、API 路由、數據庫模型、測試和文檔
```

**After（拆分為有意義的 5 個提交）:**

```bash
# 提交 1: 數據庫基礎
feat(db): 添加用戶模型和認證架構

包含文件:
- src/database/migrations/001_users.sql
- src/database/models/user.js
- src/auth/types.js

理由: 數據庫結構是其他功能的基礎，因此最先提交

# 提交 2: 認證邏輯
feat(auth): 實現核心認證功能  

包含文件:
- src/auth/login.js
- src/auth/register.js
- src/auth/password.js
- src/middleware/auth.js

理由: 認證的核心業務邏輯批量提交

# 提交 3: API 端點
feat(api): 添加認證 API 路由

包含文件:
- src/api/auth-routes.js

理由: API 層依賴認證邏輯，因此後提交

# 提交 4: 全面測試
test(auth): 添加認證系統的全面測試

包含文件:
- tests/auth/login.test.js
- tests/auth/register.test.js  
- tests/api/auth-routes.test.js

理由: 實現完成後批量添加測試

# 提交 5: 配置和文檔
docs(auth): 添加認證文檔和配置

包含文件:
- docs/authentication.md
- package.json
- README.md
- .env.example

理由: 文檔和配置最後匯總提交
```

#### 示例 2: Bug 修復和重構混合

**Before（混合的問題提交）:**

```bash
# 變更文件（8 個文件，320 行變更）
src/user/service.js       # Bug 修復 + 重構
src/user/validator.js     # 新建（重構）
src/auth/middleware.js    # Bug 修復
src/api/user-routes.js    # Bug 修復 + 錯誤處理改進
tests/user.test.js        # 測試添加
tests/auth.test.js        # Bug 修復測試添加
docs/user-api.md          # 文檔更新
package.json              # 依賴更新

# 問題提交
fix: 解決用戶驗證 Bug 並重構驗證邏輯，改進錯誤處理
```

**After（按類型拆分為 3 個提交）:**

```bash
# 提交 1: 紧急 Bug 修復
fix: 解決用戶驗證和認證 Bug

包含文件:
- src/user/service.js（仅 Bug 修復部分）
- src/auth/middleware.js
- tests/auth.test.js（仅 Bug 修復測試）

理由: 影響生產環境的 Bug 最優先修復

# 提交 2: 驗證邏輯重構  
refactor: 提取並改進用戶驗證邏輯

包含文件:
- src/user/service.js（重構部分）
- src/user/validator.js
- src/api/user-routes.js
- tests/user.test.js

理由: 結構改進按功能單位匯總提交

# 提交 3: 文檔和依賴更新
chore: 更新文檔和依賴

包含文件:
- docs/user-api.md
- package.json

理由: 開發環境整備最後匯總提交
```

#### 示例 3: 多功能並行開發

**Before（跨功能的巨大提交）:**

```bash
# 變更文件（12 個文件，600 行變更）
src/user/profile.js       # 新功能 A
src/user/avatar.js        # 新功能 A  
src/notification/email.js # 新功能 B
src/notification/sms.js   # 新功能 B
src/api/profile-routes.js # 新功能 A 用 API
src/api/notification-routes.js # 新功能 B 用 API
src/dashboard/widgets.js  # 新功能 C
src/dashboard/charts.js   # 新功能 C
tests/profile.test.js     # 新功能 A 用測試
tests/notification.test.js # 新功能 B 用測試  
tests/dashboard.test.js   # 新功能 C 用測試
package.json              # 全功能依賴

# 問題提交  
feat: 添加用戶檔案管理、通知系統和儀表板組件
```

**After（按功能拆分為 4 個提交）:**

```bash
# 提交 1: 用戶檔案功能
feat(profile): 添加用戶檔案管理

包含文件:
- src/user/profile.js
- src/user/avatar.js
- src/api/profile-routes.js
- tests/profile.test.js

理由: 檔案功能是独立的功能單位

# 提交 2: 通知系統
feat(notification): 實現郵件和短信通知

包含文件:
- src/notification/email.js
- src/notification/sms.js  
- src/api/notification-routes.js
- tests/notification.test.js

理由: 通知功能是独立的功能單位

# 提交 3: 儀表板組件
feat(dashboard): 添加交互式組件和圖表

包含文件:
- src/dashboard/widgets.js
- src/dashboard/charts.js
- tests/dashboard.test.js

理由: 儀表板功能是独立的功能單位

# 提交 4: 依賴和基礎設施更新
chore: 為新功能更新依賴

包含文件:
- package.json

理由: 通用依賴更新最後匯總
```

### 拆分效果比较

| 項目 | Before（巨大提交） | After（適当拆分） |
|------|---------------------|-------------------|
| **代碼審查性** | ❌ 非常困難 | ✅ 各提交小巧易審查 |
| **Bug 追蹤** | ❌ 問題位置難以確定 | ✅ 即時定位問題提交 |
| **回滾** | ❌ 必须整體回滾 | ✅ 精準回滾問題部分 |
| **並行開發** | ❌ 容易發生衝突 | ✅ 按功能合並容易 |
| **部署** | ❌ 功能批量部署 | ✅ 可逐步部署 |

### 故障排除

#### 提交失败時

- 確認預提交钩子
- 解決依賴關系
- 逐個文件重試

#### 拆分不当時

- 用 `--max-commits` 選項調整
- 使用手動 `edit` 模式
- 以更小單位重新執行
