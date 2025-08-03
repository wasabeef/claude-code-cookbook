## Error Fix

Identifies root causes from error messages and suggests proven solutions.

### Usage

```bash
/fix-error [options]
```

### Options

- None: Standard error analysis
- `--deep`: Deep analysis mode (includes dependencies and environmental factors)
- `--preventive`: Analysis focused on preventive measures
- `--quick`: Show only immediately applicable fixes

### Basic Examples

```bash
# Standard error analysis
npm run build 2>&1
/fix-error
"Analyze build errors and suggest fixes"

# Deep analysis mode
python app.py 2>&1
/fix-error --deep
"Analyze root cause including environmental factors"

# Focus on immediate fixes
cargo test 2>&1
/fix-error --quick
"Suggest fixes that can be applied immediately"

# Focus on preventive measures
./app 2>&1 | tail -50
/fix-error --preventive
"Suggest fixes and future preventive measures"
```

### Collaboration with Claude

```bash
# Analyze error logs
cat error.log
/fix-error
"Identify root cause and suggest fixes"

# Resolve test failures
npm test 2>&1
/fix-error --quick
"Analyze failed tests and suggest immediate fixes"

# Analyze stack traces
python script.py 2>&1
/fix-error --deep
"Identify issues from this stack trace including environmental factors"

# Solve multiple errors at once
grep -E "ERROR|WARN" app.log | tail -20
/fix-error
"Classify these errors and warnings by priority and suggest solutions for each"
```

### Error Analysis Priorities

#### Urgency: High (Immediate action required)

- **Application downtime**: Crashes, infinite loops, deadlocks
- **Data loss risk**: Database errors, file corruption
- **Security vulnerabilities**: Authentication failures, permission errors, injections
- **Production impact**: Deployment failures, service outages

#### 🟡 Urgency: Medium (Early action recommended)

- **Performance issues**: Memory leaks, delays, timeouts
- **Partial functionality failure**: Errors in specific features, UI glitches
- **Reduced development efficiency**: Build errors, test failures

#### 🟢 Urgency: Low (Planned action)

- **Warning messages**: Deprecation, lint errors
- **Development environment only**: Issues only in local environments
- **Future risks**: Technical debt, maintainability issues

### Analysis Process

#### Phase 1: Error Information Collection

```bash
🔴 Must execute:
- Obtain complete error messages
- Check stack traces
- Identify occurrence conditions (reproducibility)

🟡 Early execution:
- Collect environment information (OS, versions, dependencies)
- Recent change history (git log, recent commits)
- Check related logs

🟢 Additional execution:
- System resource status
- Network status
- External service status
```

#### Phase 2: Root Cause Analysis

1. **Organize surface symptoms**
   - Exact error message content
   - Timing and patterns of occurrence
   - Identification of impact scope

2. **Identify deep causes**
   - Apply 5 Whys analysis
   - Track dependencies
   - Check environmental differences

3. **Verify hypotheses**
   - Create minimal reproduction code
   - Run isolation tests
   - Narrow down causes

#### Phase 3: Solution Implementation

```bash
🔴 Immediate response (hotfix):
- Minimal fixes to suppress symptoms
- Apply temporary workarounds
- Prepare for emergency deployment

🟡 Fundamental solution:
- Essential fixes for the root cause
- Add test cases
- Update documentation

🟢 Implement preventive measures:
- Strengthen error handling
- Set up monitoring and alerts
- Improve CI/CD pipeline
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