## Error Fix

Analyzes error messages to identify root causes, predict resolution time, and suggest proven fixes. Learns patterns from similar errors to provide immediate solutions.

### Usage

```bash
/fix-error [options]
```

### Options

- None: Standard error analysis
- `--deep`: Deep dive including dependencies and environment
- `--preventive`: Focus on preventing future occurrences
- `--quick`: Quick fixes only

### Basic Examples

```bash
# Standard error analysis
npm run build 2>&1
/fix-error
"Analyze this build error and suggest fixes"

# Deep analysis mode
python app.py 2>&1
/fix-error --deep
"Find the root cause, including environment issues"

# Quick fixes only
cargo test 2>&1
/fix-error --quick
"Just give me a quick fix"

# Prevention-focused
./app 2>&1 | tail -50
/fix-error --preventive
"Fix this and help me prevent it next time"
```

### Collaboration with Claude

```bash
# Analyze error logs
cat error.log
/fix-error
"What's causing this error and how do I fix it?"

# Resolve test failures
npm test 2>&1
/fix-error --quick
"These tests are failing - need a quick fix"

# Analyze stack traces
python script.py 2>&1
/fix-error --deep
"Dig into this stack trace and check for environment issues"

# Handle multiple errors
grep -E "ERROR|WARN" app.log | tail -20
/fix-error
"Sort these by priority and tell me how to fix each one"
```

### Error Resolution Time Prediction

```
🚀 Immediate Fix (< 5 minutes)
├─ Typos, missing imports
├─ Environment variables not set
├─ Undefined variable references
└─ Predicted time: 2-5 minutes

⚡ Quick Fix (< 30 minutes)
├─ Dependency version conflicts
├─ Configuration file errors
├─ Type mismatches
└─ Predicted time: 10-30 minutes

🔧 Investigation Required (< 2 hours)
├─ Complex logic errors
├─ Async processing race conditions
├─ API integration issues
└─ Predicted time: 30 minutes-2 hours

🔬 Deep Analysis (Half day or more)
├─ Architecture-related issues
├─ Multi-system integration problems
├─ Performance degradation
└─ Predicted time: 4 hours-several days
```

### Similar Error Pattern Database

```
Common Errors and Immediate Solutions
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 "Cannot read property 'X' of undefined/null" (Frequency: Extremely High)
├─ Primary cause: Insufficient null checks on objects
├─ Resolution time: 5-10 minutes
└─ Solution: Add Optional chaining (?.) or null checks

📊 "ECONNREFUSED" / "ENOTFOUND" (Frequency: High)
├─ Primary cause: Service not running or URL misconfiguration
├─ Resolution time: 5-15 minutes
└─ Solution: Check service startup, environment variables

📊 "Module not found" / "Cannot resolve" (Frequency: High)
├─ Primary cause: Package not installed, incorrect path
├─ Resolution time: 2-5 minutes
└─ Solution: Run npm install, check relative paths

📊 "Unexpected token" / "SyntaxError" (Frequency: Medium)
├─ Primary cause: Bracket/quote mismatch, reserved word usage
├─ Resolution time: 2-10 minutes
└─ Solution: Check syntax highlighting, run linter

📊 "CORS policy" / "Access-Control-Allow-Origin" (Frequency: Medium)
├─ Primary cause: Insufficient CORS configuration on server
├─ Resolution time: 15-30 minutes
└─ Solution: Configure server CORS, setup proxy

📊 "Maximum call stack size exceeded" (Frequency: Low)
├─ Primary cause: Infinite loops/recursion, circular references
├─ Resolution time: 30 minutes-2 hours
└─ Solution: Check recursion termination conditions, resolve circular references
```

### Error Analysis Priority Matrix

| Priority          | Icon                | Impact Range | Resolution Difficulty | Response Deadline      | Description                                      |
| ----------------- | ------------------- | ------------ | --------------------- | ---------------------- | ------------------------------------------------ |
| **Critical**      | 🔴 Emergency        | Wide         | Low                   | Start within 15 min    | System-wide outage, data loss risk               |
| **High Priority** | 🟠 Early Response   | Wide         | High                  | Start within 1 hour    | Major feature outage, many users affected        |
| **Medium**        | 🟡 Planned Response | Narrow       | High                  | Address same day       | Partial feature limitation, workaround available |
| **Low**           | 🟢 Monitor          | Narrow       | Low                   | Next maintenance cycle | Minor bugs, minimal UX impact                    |

### Analysis Process

#### Phase 1: Error Information Collection

```bash
🔴 Must have:
- Full error message
- Stack trace
- Steps to reproduce

🟡 Should have:
- Environment details (OS, versions, dependencies)
- Recent changes (git log, commits)
- Related logs

🟢 Nice to have:
- System resources
- Network state
- External services
```

#### Phase 2: Root Cause Analysis

1. **Identify symptoms**
   - Exact error message
   - When and how it happens
   - What's affected

2. **Find root causes**
   - Use 5 Whys analysis
   - Check dependencies
   - Compare environments

3. **Test your theory**
   - Create minimal repro
   - Isolate the issue
   - Confirm the cause

#### Phase 3: Solution Implementation

```bash
🔴 Quick fix (hotfix):
- Stop the bleeding
- Apply workarounds
- Get ready to deploy

🟡 Root cause fix:
- Fix the actual problem
- Add tests
- Update docs

🟢 Prevent future issues:
- Better error handling
- Add monitoring
- Improve CI/CD
```

### Output Example

```
🚨 Error Analysis Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📍 Error Overview
├─ Type: [Compilation/Runtime/Logical/Environmental]
├─ Urgency: 🔴 High / 🟡 Medium / 🟢 Low
├─ Impact Scope: [Feature name/Component]
└─ Reproducibility: [100% / Intermittent / Specific conditions]

🔍 Root Cause
├─ Direct Cause: [Specific cause]
├─ Background Factors: [Environment/Configuration/Dependencies]
└─ Trigger: [Occurrence conditions]

💡 Solutions
🔴 Immediate response:
1. [Specific fix command/code]
2. [Temporary workaround]

🟡 Fundamental solution:
1. [Essential fix method]
2. [Necessary refactoring]

🟢 Preventive measures:
1. [Error handling improvement]
2. [Add tests]
3. [Monitoring setup]

📝 Verification Procedure
1. [Method to confirm after applying fix]
2. [Test execution command]
3. [Operation check items]
```

### Analysis Methods by Error Type

#### Compilation/Build Errors

```bash
# TypeScript type errors
Must check (high):
- tsconfig.json settings
- Presence of type definition files (.d.ts)
- Accuracy of import statements

# Rust lifetime errors
Must check (high):
- Ownership movement
- Reference validity periods
- Mutability conflicts
```

#### Runtime Errors

```bash
# Null/Undefined references
Must check (high):
- Insufficient optional chaining
- Initialization timing
- Waiting for async processing completion

# Memory-related errors
Must check (high):
- Heap dump acquisition
- GC log analysis
- Circular reference detection
```

#### Dependency Errors

```bash
# Version conflicts
Must check (high):
- Lock file consistency
- Peer dependencies requirements
- Transitive dependencies

# Module resolution errors
Must check (high):
- NODE_PATH settings
- Path alias configuration
- Symbolic links
```

### Notes

- **Absolutely prohibited**: Making judgments based only on part of an error message, applying Stack Overflow solutions without verification
- **Exception conditions**: Temporary workarounds are only allowed under these 3 conditions:
  1. Emergency response in production environment (root solution required within 24 hours)
  2. External service failures (alternative means while waiting for recovery)
  3. Known framework bugs (waiting for fixed version release)
- **Recommendation**: Prioritize identifying root causes and avoid superficial fixes

### Best Practices

1. **Complete information collection**: Check error messages from beginning to end
2. **Reproducibility confirmation**: Prioritize creating minimal reproduction code
3. **Step-by-step approach**: Start with small fixes and verify
4. **Documentation**: Record the solution process for knowledge sharing

#### Common Pitfalls

- **Symptom treatment**: Superficial fixes that miss root causes
- **Overgeneralization**: Widely applying solutions for specific cases
- **Omitted verification**: Not checking side effects after fixes
- **Knowledge individualization**: Not documenting solution methods

### Related Commands

- `/design-patterns`: Analyze code structure issues and suggest patterns
- `/tech-debt`: Analyze root causes of errors from a technical debt perspective
- `/analyzer`: For cases requiring deeper root cause analysis
