## PR Auto Update

## Overview

A command that automatically updates Pull Request descriptions and labels. Analyzes Git changes to generate and set appropriate descriptions and labels.

## Usage

```bash
/pr-auto-update [options] [PR number]
```

### Options

- `--pr <number>`: Specify target PR number (automatically detected from current branch if omitted)
- `--description-only`: Update only the description (keep labels unchanged)
- `--labels-only`: Update only labels (keep description unchanged)
- `--dry-run`: Show generated content without making actual updates
- `--lang <language>`: Specify language (ja, en)

### Basic Examples

```bash
# Auto-update PR for current branch
/pr-auto-update

# Update specific PR
/pr-auto-update --pr 1234

# Update description only
/pr-auto-update --description-only

# Check with dry-run
/pr-auto-update --dry-run
```

## Feature Details

### 1. PR Auto Detection

Automatically detects the corresponding PR from the current branch:

```bash
# Search PR from branch
gh pr list --head $(git branch --show-current) --json number,title,url
```

### 2. Change Analysis

Collects and analyzes the following information:

- **File changes**: Added, deleted, or modified files
- **Code analysis**: Changes to imports, function definitions, class definitions
- **Tests**: Presence and content of test files
- **Documentation**: Updates to README, docs
- **Configuration**: Changes to package.json, pubspec.yaml, configuration files
- **CI/CD**: Changes to GitHub Actions, workflows

### 3. Automatic Description Generation

#### Template Processing Priority

1. **Existing PR description**: Completely follows already written content
2. **Project template**: Gets structure from `.github/PULL_REQUEST_TEMPLATE.md`
3. **Default template**: Fallback when above don't exist

#### Rules for Preserving Existing Content

**Important**: Do not modify existing content

- Keep existing sections
- Only complete empty sections
- Keep functional comments (like Copilot review rules)

#### Using Project Templates

```bash
# Parse structure of .github/PULL_REQUEST_TEMPLATE.md
parse_template_structure() {
  local template_file="$1"
  
  if [ -f "$template_file" ]; then
    # Extract section structure
grep -E '^##|^###' "$template_file"
    
    # Identify comment placeholders
grep -E '<!--.*-->' "$template_file"
    
    # Completely follow existing template structure
cat