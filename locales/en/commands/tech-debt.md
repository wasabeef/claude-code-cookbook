## Tech Debt

Quantitatively analyzes technical debt in projects, visualizes health scores and impact on development efficiency. Tracks improvement status through trend analysis and creates prioritized improvement plans with calculated time costs.

### Usage

```bash
# Analyze project structure for technical debt
ls -la
"Analyze technical debt in this project and create improvement plan"
```

### Project Health Dashboard

```
Project Health Score: 72/100
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Category-wise Scores
├─ Dependency freshness: ████████░░ 82% (Up-to-date: 45/55)
├─ Documentation completeness: ███░░░░░░░ 35% (Missing README, API docs)
├─ Test coverage: ██████░░░░ 65% (Target: 80%)
├─ Security: ███████░░░ 78% (Vulnerabilities: 2 Medium)
├─ Architecture: ██████░░░░ 60% (Circular dependencies: 3 locations)
└─ Code quality: ███████░░░ 70% (High complexity: 12 files)

📈 Trends (Past 30 days)
├─ Overall score: 68 → 72 (+4) ↗️
├─ Improvements: 12 items ✅
├─ New debt: 3 items ⚠️
├─ Resolved debt: 8 items 🎉
└─ Improvement rate: +0.13/day

⏱️ Time Impact of Debt
├─ Development speed reduction: -20% (New features take 1.25x normal time)
├─ Bug fix time increase: +15% (Average fix time 2h → 2.3h)
├─ Code review overhead: +30% (Increased understanding time due to complexity)
├─ Onboarding delay: +50% (Time for new members to understand)
└─ Cumulative delay: 40 hours/week equivalent

🎯 Expected Benefits from Improvement (Time-based)
├─ Immediate effect: +10% development speed (After 1 week)
├─ Short-term effect: -25% bug rate (After 1 month)
├─ Medium-term effect: +30% development speed (After 3 months)
├─ Long-term effect: -50% maintenance time (After 6 months)
└─ ROI: Invest 40 hours → Recover 120 hours (3 months)
```

### Basic Examples

```bash
# Detailed health score analysis
find . -name "*.js" -o -name "*.ts" | xargs wc -l | sort -rn | head -10
"Calculate project health score and evaluate by category"

# TODO/FIXME debt impact analysis
grep -r "TODO\|FIXME\|HACK\|XXX\|WORKAROUND" . --exclude-dir=node_modules --exclude-dir=.git
"Evaluate these TODOs by debt impact (time × importance)"

# Dependency health check
ls -la | grep -E "package.json|Cargo.toml|pubspec.yaml|go.mod|requirements.txt"
"Calculate dependency freshness score and analyze update risks and benefits"
```

### Collaboration with Claude

```bash
# Comprehensive technical debt analysis
ls -la && find . -name "*.md" -maxdepth 2 -exec head -20 {} \;
"Analyze technical debt in this project from the following perspectives:
1. Code quality (complexity, duplication, maintainability)
2. Dependency health
3. Security risks
4. Performance issues
5. Test coverage gaps"

# Architecture debt analysis
find . -type d -name "src" -o -name "lib" -o -name "app" | head -10 | xargs ls -la
"Identify architecture-level technical debt and propose refactoring plan"

# Prioritized improvement plan
"Evaluate technical debt using the following criteria and present in table format:
- Impact level (High/Medium/Low)
- Fix cost (time)
- Technical risk (system failure, data loss potential)
- Time savings from improvement
- Recommended implementation timing"
```

### Detailed Examples

```bash
# Auto-detect project type and analyze
find . -maxdepth 2 -type f \( -name "package.json" -o -name "Cargo.toml" -o -name "pubspec.yaml" -o -name "go.mod" -o -name "pom.xml" \)
"Based on detected project type, analyze:
1. Language/framework-specific technical debt
2. Deviations from best practices
3. Modernization opportunities
4. Step-by-step improvement strategy"

# Code quality metrics analysis
find . -type f -name "*" | grep -E "\.(js|ts|py|rs|go|dart|kotlin|swift|java)$" | wc -l
"Analyze project code quality and present these metrics:
- Functions with high cyclomatic complexity
- Duplicate code detection
- Overly long files/functions
- Missing proper error handling"

# Security debt detection
grep -r "password\|secret\|key\|token" . --exclude-dir=.git --exclude-dir=node_modules | grep -v ".env.example"
"Detect security-related technical debt and propose fix priorities and countermeasures"

# Test coverage gap analysis
find . -type f \( -name "*test*" -o -name "*spec*" \) | wc -l && find . -type f -name "*.md" | xargs grep -l "test"
"Analyze technical debt in test coverage and propose testing strategy"
```

### Debt Priority Matrix

```
Priority = (Impact × Frequency) ÷ Fix Cost
```

| Priority | Development Impact | Fix Cost | Time Savings | Investment Efficiency | Response Deadline |
|----------|-------------------|----------|--------------|---------------------|-------------------|
| **[P0] Fix Immediately** | High | Low | > 5x | Invest 1h → Save 5h+ | Immediately |
| **[P1] This Week** | High | Medium | 2-5x | Invest 1h → Save 2-5h | Within 1 week |
| **[P2] This Month** | Low | High | 1-2x | Invest 1h → Save 1-2h | Within 1 month |
| **[P3] This Quarter** | Low | Low | < 1x | Investment = Savings | Within 3 months |

### Debt Type Evaluation Criteria

| Debt Type | Detection Method | Development Impact | Fix Time |
|-----------|------------------|-------------------|----------|
| **Architecture Debt** | Circular dependencies, tight coupling | Large impact scope on changes, testing difficulty | 40-80h |
| **Security Debt** | CVE scans, OWASP | Vulnerability risks, compliance issues | 8-40h |
| **Performance Debt** | N+1 queries, memory leaks | Increased response time, resource consumption | 16-40h |
| **Test Debt** | Coverage < 60% | Delayed bug detection, unstable quality | 20-60h |
| **Documentation Debt** | Missing README, API docs | Increased onboarding time | 8-24h |
| **Dependency Debt** | 2+ years without updates | Security risks, compatibility issues | 4-16h |
| **Code Quality Debt** | Complexity > 10 | Increased understanding/modification time | 2-8h |

### Technical Debt Impact Calculation

```
Impact = Σ(Weight of each factor × Measured value)

📊 Measurable Impact Indicators:
├─ Development Speed Impact
│  ├─ Code understanding time: +X% (proportional to complexity)
│  ├─ Change impact scope: Y files (measured by coupling)
│  └─ Test execution time: Z minutes (CI/CD pipeline)
│
├─ Quality Impact
│  ├─ Bug occurrence rate: +25% per complexity score of 10
│  ├─ Review time: Lines of code × Complexity coefficient
│  └─ Test gap risk: High risk when coverage < 60%
│
└─ Team Efficiency Impact
   ├─ Onboarding time: +100% when documentation lacking
   ├─ Knowledge silos: Caution when single contributor rate >80%
   └─ Code duplication fix locations: Duplication rate × Change frequency
```

### Time-based ROI Calculation

```
ROI = (Time Saved - Investment Time) ÷ Investment Time × 100

Example: Resolving circular dependencies
├─ Investment time: 16 hours (refactoring)
├─ Monthly savings:
│  ├─ Compilation time: -10 min/day × 20 days = 200 min
│  ├─ Debug time: -2 hours/week × 4 weeks = 8 hours
│  └─ New feature development: -30% time reduction = 12 hours
├─ Monthly time savings: 23.3 hours
└─ 3-month ROI: (70 - 16) ÷ 16 × 100 = 337%
```

### Notes

- Automatically detects project language and framework for tailored analysis
- Health score evaluated on 0-100 scale: 70+ healthy, 50 or below needs improvement
- Calculates specific time costs and improvement benefits to support data-driven decision making
- For monetary conversion, specify team average hourly rate or project-specific coefficients separately
