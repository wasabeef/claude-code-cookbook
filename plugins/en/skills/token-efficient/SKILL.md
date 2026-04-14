---
description: "Compress responses to reduce context usage by 30-50%"
---

# Token Efficiency Mode

Reduces AI response context usage by 30-50% through compression efficiency mode.

## Compress responses to reduce context usage by 30-50%

Token Efficiency Mode leverages visual symbols and abbreviation systems to compress Claude's responses.
**Generated code quality and content remain unchanged**. Only the explanation method changes.

## Usage

```bash
# Enable mode
"Respond in Token Efficiency Mode"
"--uc mode"
"Concise mode"
```

## How It Works

### 1. Symbol System

#### Logic & Flow

| Symbol | Meaning          | Example                         |
| ------ | ---------------- | ------------------------------- |
| →      | leads to, causes | `auth.js:45 → 🛡️ security risk` |
| ⇒      | converts to      | `input ⇒ validated_output`      |
| ←      | rollback, revert | `migration ← rollback`          |
| ⇄      | bidirectional    | `sync ⇄ remote`                 |
| &      | and, combine     | `🛡️ security & ⚡ performance`  |
| \|     | or, separator    | `react\|vue\|angular`           |
| :      | define, specify  | `scope: file\|module`           |
| »      | then, sequence   | `build » test » deploy`         |
| ∴      | therefore        | `tests ❌ ∴ code broken`        |
| ∵      | because          | `slow ∵ O(n²) algorithm`        |

#### Status & Progress

| Symbol | Meaning           | Usage                   |
| ------ | ----------------- | ----------------------- |
| ✅     | complete, success | Task completed normally |
| ❌     | failed, error     | Immediate action needed |
| ⚠️     | warning           | Review recommended      |
| 🔄     | in progress       | Currently active        |
| ⏳     | pending           | Scheduled for later     |
| 🚨     | urgent, critical  | High priority           |

#### Technical Domains

| Symbol | Domain        | Usage                 |
| ------ | ------------- | --------------------- |
| ⚡     | Performance   | Speed, optimization   |
| 🔍     | Analysis      | Search, investigation |
| 🔧     | Configuration | Setup, tools          |
| 🛡️     | Security      | Protection, safety    |
| 📦     | Deployment    | Package, bundle       |
| 🎨     | Design        | UI, frontend          |
| 🏗️     | Architecture  | System structure      |
| 🗄️     | Database      | Data persistence      |
| ⚙️     | Backend       | Server processing     |
| 🧪     | Testing       | Quality assurance     |

### 2. Abbreviation System

#### System & Architecture

- `cfg` → configuration
- `impl` → implementation
- `arch` → architecture
- `perf` → performance
- `ops` → operations
- `env` → environment

#### Development Process

- `req` → requirements
- `deps` → dependencies
- `val` → validation
- `auth` → authentication
- `docs` → documentation
- `std` → standards

#### Quality & Analysis

- `qual` → quality
- `sec` → security
- `err` → error
- `rec` → recovery
- `sev` → severity
- `opt` → optimization

## Example Comparisons

### Example 1: Error Report

**Normal Mode (85 chars)**

```text
Security vulnerability found in the user validation function at line 45 of the auth system.
```

**Token Efficient (39 chars)**

```text
auth.js:45 → 🛡️ sec vuln in user val()
```

### Example 2: Build Status

**Normal Mode (112 chars)**

```text
Build process completed successfully. Tests are currently running, followed by deployment.
```

**Token Efficient (35 chars)**

```text
build ✅ » test 🔄 » deploy ⏳
```

### Example 3: Performance Analysis

**Normal Mode (95 chars)**

```text
Performance analysis revealed slow processing due to O(n²) algorithm complexity.
```

**Token Efficient (42 chars)**

```text
⚡ perf: slow ∵ O(n²) → optimize to O(n)
```

## Use Cases

### ✅ Effective Scenarios

- **Long debugging sessions**: Efficiently maintaining history
- **Large code reviews**: Concise analysis of many files
- **CI/CD monitoring**: Real-time status updates
- **Project progress reports**: Overview of multiple task states
- **Error tracking**: Visual representation of problem chains

### ❌ Scenarios to Avoid

- Explanations for beginners
- Detailed documentation creation
- Initial requirements definition
- Communication with non-technical stakeholders

## Implementation Examples

### Debugging Session

```text
[14:23] breakpoint → vars: {user: null, token: expired}
[14:24] step → auth.validate() ❌
[14:25] check → token.exp < Date.now() ∴ expired
[14:26] fix → refresh() → ✅
[14:27] continue → main flow 🔄
```

### File Analysis Results

```text
/src/auth/: 🛡️ issues × 3
/src/api/: ⚡ bottleneck in handler()
/src/db/: ✅ clean
/src/utils/: ⚠️ deprecated methods
/tests/: 🧪 coverage 78%
```

### Project Status

```text
Frontend: 🎨 ✅ 100%
Backend: ⚙️ 🔄 75%
Database: 🗄️ ✅ migrated
Tests: 🧪 ⚠️ 68% (target: 80%)
Deploy: 📦 ⏳ scheduled
Security: 🛡️ 🚨 1 critical
```

## Configuration Options

```javascript
// Compression levels
--uc; // Ultra Compressed: Maximum compression
--mc; // Moderate Compressed: Medium compression
--lc; // Light Compressed: Light compression

// Domain-specific
--dev; // Development-focused compression
--ops; // Operations-focused compression
--sec; // Security-focused compression
```

## Benefits

1. **Context saving**: 30-50% token reduction
2. **Visual understanding**: Intuitive grasp through symbols
3. **Information density**: More information in the same space
4. **History retention**: Maintain longer conversation history
5. **Pattern recognition**: Easier problem detection through visual patterns

## Notes

- This mode only changes **AI response style**
- **Code quality** remains unchanged
- Can switch with "explain in normal mode" as needed
- Normal mode recommended for beginners and non-technical users

## Command Examples

```bash
# Enable
"Token Efficient Mode on"
"Respond concisely"
"Analyze with --uc"

# Disable
"Return to normal mode"
"Explain in detail"
"Token Efficient Mode off"
```

## Implementation Impact

| Item                    | Impact              |
| ----------------------- | ------------------- |
| Generated code quality  | No change ✅        |
| Implementation accuracy | No change ✅        |
| Functionality           | No change ✅        |
| AI explanation method   | Compressed 🔄       |
| Context usage           | 30-50% reduction ⚡ |

---

💡 **Pro Tip**: For long work sessions, start with normal mode to build understanding, then switch to Token Efficient Mode to optimize efficiency and context retention.
