## Tech Debt

Analyze project technical debt and create a prioritized improvement plan.

### Usage

```bash
# Check project structure and analyze technical debt
ls -la
"Analyze the technical debt of this project and create an improvement plan"
```

### Basic Examples

```bash
# Analyze TODO/FIXME comments
grep -r "TODO\|FIXME\|HACK\|XXX\|WORKAROUND" . --exclude-dir=node_modules --exclude-dir=.git
"Organize these TODO comments in priority order and create an improvement plan"

# Check project dependencies
ls -la | grep -E "package.json|Cargo.toml|pubspec.yaml|go.mod|requirements.txt"
"Analyze the project dependencies, identify outdated ones and their risks"

# Detect large files and complex functions
find . -type f -not -path "*/\.*" -not -path "*/node_modules/*" -exec wc -l {} + | sort -rn | head -10
"Identify oversized files and complex structures, then suggest improvements"
```

### Collaboration with Claude

```bash
# Comprehensive technical debt analysis
ls -la && find . -name "*.md" -maxdepth 2 -exec head -20 {} \;
"Analyze this project's technical debt from the following perspectives:
1. Code quality (complexity, duplication, maintainability)
2. Dependency health
3. Security risks
4. Performance issues
5. Test coverage gaps"

# Architectural debt analysis
find . -type d -name "src" -o -name "lib" -o -name "app" | head -10 | xargs ls -la
"Identify architectural-level technical debt and propose a refactoring plan"

# Prioritized improvement plan
"Evaluate technical debt using the following criteria and present in table format:
- Impact (High/Medium/Low)
- Fix cost (time)
- Business risk
- Improvement benefit
- Recommended implementation time"
```

### Detailed Examples

```bash
# Automatic project type detection and analysis
find . -maxdepth 2 -type f \( -name "package.json" -o -name "Cargo.toml" -o -name "pubspec.yaml" -o -name "go.mod" -o -name "pom.xml" \)
"Based on the detected project type, analyze:
1. Language/framework-specific technical debt
2. Deviations from best practices
3. Modernization opportunities
4. Phased improvement strategy"

# Code quality metrics analysis
find . -type f -name "*" | grep -E "\.(js|ts|py|rs|go|dart|kotlin|swift|java)$" | wc -l
"Analyze project code quality and provide the following metrics:
- Functions with high cyclomatic complexity
- Detection of duplicate code
- Files/functions that are too long
- Lack of proper error handling"

# Security debt detection
grep -r "password\|secret\|key\|token" . --exclude-dir=.git --exclude-dir=node_modules | grep -v ".env.example"
"Detect security-related technical debt and propose correction priorities and countermeasures"

# Test insufficiency analysis
find . -type f \( -name "*test*" -o -name "*spec*" \) | wc -l && find . -type f -name "*.md" | xargs grep -l "test"
"Analyze the technical debt of test coverage and propose a testing strategy"
```

### Notes

- Automatically detects the project's language and framework and performs analysis accordingly
- Technical debt is categorized into "critical issues that need immediate fixing" and "items to improve in the long term"
- Provides realistic plans that balance business value and technical improvement
- Also considers the ROI (return on investment) of improvements