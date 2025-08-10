## PR Create

Automate Pull Request creation based on Git change analysis for an efficient PR workflow.

### Usage

```bash
# Create PR automatically based on change analysis
git add . && git commit -m "feat: Implement user authentication"
"Analyze changes and create a Draft PR with appropriate description and labels"

# Update while preserving existing template
cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
"Complete the change details while fully preserving the template structure"

# Gradual quality improvement
gh pr ready
"Change to Ready for Review after quality confirmation"
```

### Basic Examples

```bash
# 1. Create branch and commit
git checkout main && git pull
git checkout -b feat-user-profile
git add . && git commit -m "feat: Implement user profile feature"
git push -u origin feat-user-profile

# 2. Create PR
"Create a PR with the following steps:
1. Check changes with git diff --cached
2. Create description using .github/PULL_REQUEST_TEMPLATE.md
3. Select up to 3 appropriate labels based on changes
4. Create as Draft PR (preserve HTML comments)"

# 3. Mark as Ready after CI check
"Change PR to Ready for Review once CI passes"
```

### Execution Steps

#### 1. Create Branch

```bash
# Naming convention following guidelines: {type}-{subject}
git checkout main
git pull
git checkout -b feat-user-authentication

# Check branch (display current branch name)
git branch --show-current
```

#### 2. Commit

```bash
# Stage changes
git add .

# Commit message following guidelines
git commit -m "feat: Implement user authentication API"
```

#### 3. Push to Remote

```bash
# First push (set upstream)
git push -u origin feat-user-authentication

# Subsequent pushes
git push
```

#### 4. Create Draft PR with Automatic Analysis

**Step 1: Analyze Changes**

```bash
# Get file changes (check staged changes)
git diff --cached --name-only

# Content analysis (max 1000 lines)
git diff --cached | head -1000
```

**Step 2: Auto-generate Description**

```bash
# Template processing priority
# 1. Existing PR description (fully preserved)
# 2. .github/PULL_REQUEST_TEMPLATE.md
# 3. Default template

cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
# Complete only empty sections while preserving HTML comments and separators
```

**Step 3: Auto-select Labels**

```bash
# Get available labels (non-interactive)
"Retrieve available labels from .github/labels.yml or GitHub repository and automatically select appropriate labels based on changes"

# Auto-selection by pattern matching (max 3)
# - Documentation: *.md, docs/ → documentation|docs
# - Tests: test, spec → test|testing
# - Bug fixes: fix|bug → bug|fix
# - New features: feat|feature → feature|enhancement
```

**Step 4: Create PR via GitHub API (Preserve HTML Comments)**

```bash
# Create PR
"Create a Draft PR with the following information:
- Title: Auto-generated from commit message
- Description: Properly filled using .github/PULL_REQUEST_TEMPLATE.md
- Labels: Auto-selected from changes (max 3)
- Base branch: main
- Preserve all HTML comments"
```

**Method B: GitHub MCP (Fallback)**

```javascript
// Create PR while preserving HTML comments
mcp_github_create_pull_request({
  owner: 'organization',
  repo: 'repository',
  base: 'main',
  head: 'feat-user-authentication',
  title: 'feat: Implement user authentication',
  body: prBodyContent, // Full content including HTML comments
  draft: true,
  maintainer_can_modify: true,
});
```

### Auto Label Selection System

#### File Pattern Based Determination

- **Documentation**: `*.md`, `README`, `docs/` → `documentation|docs|doc`
- **Tests**: `test`, `spec` → `test|testing`
- **CI/CD**: `.github/`, `*.yml`, `Dockerfile` → `ci|build|infra|ops`
- **Dependencies**: `package.json`, `pubspec.yaml` → `dependencies|deps`

#### Content Based Determination

- **Bug fixes**: `fix|bug|error|crash|修正` → `bug|fix`
- **New features**: `feat|feature|add|implement|新機能|実装` → `feature|enhancement|feat`
- **Refactoring**: `refactor|clean|リファクタ` → `refactor|cleanup|clean`
- **Performance**: `performance|perf|optimize` → `performance|perf`
- **Security**: `security|secure` → `security`

#### Constraints

- **Max 3 labels**: Upper limit for automatic selection
- **Existing labels only**: Prohibited from creating new labels
- **Partial match**: Determined by keyword inclusion in label names

### Project Guidelines

#### Basic Approach

1. **Always start as Draft**: All PRs must be created in Draft state
2. **Gradual quality improvement**: Phase 1 (Basic implementation) → Phase 2 (Add tests) → Phase 3 (Update documentation)
3. **Appropriate labels**: Always add up to 3 labels
4. **Use templates**: Always use `.github/PULL_REQUEST_TEMPLATE.md`
5. **Japanese spacing**: Always add half-width space between Japanese text and alphanumerics

#### Branch Naming Convention

```text
{type}-{subject}

Examples:
- feat-user-profile
- fix-login-error
- refactor-api-client
```

#### Commit Messages

```text
{type}: {description}

Examples:
- feat: Implement user authentication API
- fix: Correct login error
- docs: Update README
```

### Template Processing System

#### Processing Priority

1. **Existing PR description**: **Fully follow** any already written content
2. **Project template**: Maintain `.github/PULL_REQUEST_TEMPLATE.md` structure
3. **Default template**: If above don't exist

#### Existing Content Preservation Rules

- **Do not change a single character**: Content already written
- **Complete only empty sections**: Fill placeholder parts with change details
- **Preserve functional comments**: Maintain `<!-- Copilot review rule -->` etc.
- **Preserve HTML comments**: Fully maintain `<!-- ... -->`
- **Preserve separators**: Maintain structures like `---`

#### Handling HTML Comment Preservation

**Important**: GitHub CLI (`gh pr edit`) automatically escapes HTML comments, and shell processing can introduce invalid strings like `EOF < /dev/null`.

**Fundamental Solutions**:

1. **Use GitHub API --field option**: Proper escaping to preserve HTML comments
2. **Simplify template processing**: Avoid complex pipe operations and redirects
3. **Full preservation approach**: Abolish HTML comment removal and fully maintain templates

### Review Comment Responses

```bash
# Re-commit after changes
git add .
git commit -m "fix: Address review feedback"
git push
```

### Notes

#### Importance of HTML Comment Preservation

- **GitHub CLI limitations**: `gh pr edit` escapes HTML comments and may introduce invalid strings
- **Fundamental workaround**: Use GitHub API's `--field` option for proper escaping
- **Full template preservation**: Abolish HTML comment removal and maintain complete structure

#### Automation Constraints

- **Prohibited new labels**: Cannot create labels not defined in `.github/labels.yml`
- **Max 3 labels**: Upper limit for automatic selection
- **Existing content priority**: Never modify manually written content

#### Gradual Quality Improvement

- **Draft required**: All PRs start as Draft
- **CI check**: Verify status with `gh pr checks`
- **Ready transition**: Use `gh pr ready` after quality confirmation
- **Full template compliance**: Maintain project-specific structure