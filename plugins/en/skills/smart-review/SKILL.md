---
description: "Auto-suggest optimal role and approach"
---

## Auto-suggest optimal role and approach

A command that analyzes the current situation and automatically suggests the optimal role and approach.

### Usage

```bash
/smart-review                    # Analyze current directory
/smart-review <file/directory>   # Analyze specific target
```

### Automatic Analysis Logic

### Analysis by File Extension

- `package.json`, `*.tsx`, `*.jsx`, `*.css`, `*.scss` → **frontend**
- `Dockerfile`, `docker-compose.yml`, `*.yaml` → **architect**
- `*.test.js`, `*.spec.ts`, `test/`, `__tests__/` → **qa**
- `*.rs`, `Cargo.toml`, `performance/` → **performance**

### Security-related File Detection

- `auth.js`, `security.yml`, `.env`, `config/auth/` → **security**
- `login.tsx`, `signup.js`, `jwt.js` → **security + frontend**
- `api/auth/`, `middleware/auth/` → **security + architect**

### Complex Analysis Patterns

- `mobile/` + `*.swift`, `*.kt`, `react-native/` → **mobile**
- `webpack.config.js`, `vite.config.js`, `large-dataset/` → **performance**
- `components/` + `responsive.css` → **frontend + mobile**
- `api/` + `auth/` → **security + architect**

### Error/Problem Analysis

- Stack traces, `error.log`, `crash.log` → **analyzer**
- `memory leak`, `high CPU`, `slow query` → **performance + analyzer**
- `SQL injection`, `XSS`, `CSRF` → **security + analyzer**

### Suggestion Patterns

### Single Role Suggestion

```bash
$ /smart-review src/auth/login.js
→ "Authentication file detected"
→ "Analysis with security role recommended"
→ "Execute? [y]es / [n]o / [m]ore options"
```

### Multiple Role Suggestion

```bash
$ /smart-review src/mobile/components/
→ "📱🎨 Mobile + Frontend elements detected"
→ "Recommended approaches:"
→ "[1] mobile role alone"
→ "[2] frontend role alone"
→ "[3] multi-role mobile,frontend"
→ "[4] role-debate mobile,frontend"
```

### Suggestions for Problem Analysis

```bash
$ /smart-review error.log
→ "⚠️ Error log detected"
→ "Starting root cause analysis with analyzer role"
→ "[Auto-execute] /role analyzer"

$ /smart-review slow-api.log
→ "🐌 Performance issue detected"
→ "Recommended: [1]/role performance [2]/role-debate performance,analyzer"
```

### Suggestions for Complex Design Decisions

```bash
$ /smart-review architecture-design.md
→ "🏗️🔒⚡ Architecture + Security + Performance elements detected"
→ "For complex design decisions, debate format recommended"
→ "[Recommended] /role-debate architect,security,performance"
→ "[Alternative] /multi-role architect,security,performance"
```

### Suggestion Logic Details

### Priority Assessment

1. **Security** - Authentication, authorization, and encryption are top priorities
2. **Critical Errors** - System outages and data loss are urgent
3. **Architecture** - Large-scale changes and technology selection require careful consideration
4. **Performance** - Directly impacts user experience
5. **Frontend/Mobile** - UI/UX improvements
6. **QA** - Quality assurance and testing

### Conditions for Recommending Debate

- When 3 or more roles are involved
- When there's a trade-off between security and performance
- When significant architectural changes are involved
- When both mobile and web are affected

### Basic Examples

```bash
# Analyze current directory
/smart-review
"Suggest the optimal role and approach"

# Analyze specific file
/smart-review src/auth/login.js
"Suggest the best review method for this file"

# Analyze error log
/smart-review error.log
"Suggest the best approach to resolve this error"
```

### Practical Examples

### Project-wide Analysis

```bash
$ /smart-review
→ "📊 Analyzing project..."
→ "React + TypeScript project detected"
→ "Authentication functionality + API + mobile support confirmed"
→ ""
→ "💡 Recommended workflow:"
→ "1. Check authentication with security"
→ "2. Evaluate UI/UX with frontend"
→ "3. Confirm mobile optimization with mobile"
→ "4. Review overall design with architect"
→ ""
→ "Auto-execute? [y]es / [s]elect role / [c]ustom"
```

### Specific Problem Analysis

```bash
$ /smart-review "How to set JWT expiration time"
→ "🤔 Technical design decision detected"
→ "This issue requires multiple expert perspectives"
→ ""
→ "Recommended approach:"
→ "/role-debate security,performance,frontend"
→ "Reason: Balance between security, performance, and UX is important"
```

### Collaboration with Claude

```bash
# Analysis combined with file content
cat src/auth/middleware.js
/smart-review
"Analyze this file from a security perspective"

# Analysis combined with errors
npm run build 2>&1 | tee build-error.log
/smart-review build-error.log
"Suggest ways to resolve build errors"

# Design consultation
/smart-review
"Discuss whether to choose React Native or Progressive Web App"
```

### Notes

- Suggestions are for reference only. The final decision is up to the user
- Debate format (role-debate) is recommended for complex issues
- Single role is often sufficient for simple problems
- Security-related matters should always be confirmed with a specialized role
