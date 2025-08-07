## Commit Message

Generates appropriate commit messages from staged changes (git diff --staged). Does not execute git commands, only generates messages and copies them to the clipboard.

### Usage

```bash
/commit-message [options]
```

### Options

- `--format <format>`: Specify message format (conventional, gitmoji, angular)
- `--lang <language>`: Force message language (en, ja)
- `--breaking`: Detect and mark breaking changes

### Basic Examples

```bash
# Generate message from staged changes (automatic language detection)
# Main candidate is automatically copied to clipboard
/commit-message

# Force language specification
/commit-message --lang ja
/commit-message --lang en

# Detect breaking changes
/commit-message --breaking
```

### Prerequisites

**Important**: This command only analyzes staged changes. You must stage changes with `git add` beforehand.

```bash
# Warning will be displayed if no changes are staged
$ /commit-message
No staged changes found. Please run git add first.
```

### Automatic Clipboard Function

The generated main candidate is automatically copied to the clipboard in the complete format `git commit -m "message"`. You can paste and execute it directly in the terminal.

**Implementation Notes**:

- When passing the commit command to `pbcopy`, execute it in a separate process from message output
- Use `printf` instead of `echo` to avoid trailing newlines

### Automatic Detection of Project Conventions

**Important**: If project-specific conventions exist, they take precedence.

#### 1. CommitLint Configuration Check

Automatically detects settings from the following files:

- `commitlint.config.js`
- `commitlint.config.mjs`
- `commitlint.config.cjs`
- `commitlint.config.ts`
- `.commitlintrc.js`
- `.commitlintrc.json`
- `.commitlintrc.yml`
- `.commitlintrc.yaml`
- `commitlint` section in `package.json`

```bash
# Search for configuration files
find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
```

#### 2. Custom Type Detection

Examples of project-specific types:

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
        'wip',      // Work in progress
        'hotfix',   // Emergency fix
        'release',  // Release
        'deps',     // Dependency update
        'config'    // Configuration change
      ]
    ]
  }
}
```

#### 3. Language Setting Detection

```javascript
// When project uses Japanese messages
export default {
  rules: {
    'subject-case': [0],  // Disabled for Japanese support
    'subject-max-length': [2, 'always', 72]  // Adjust character limit for Japanese
  }
}
```

#### 4. Existing Commit History Analysis

```bash
# Learn usage patterns from recent commits
git log --oneline -50 --pretty=format:"%s"

# Type statistics
git log --oneline -100 --pretty=format: