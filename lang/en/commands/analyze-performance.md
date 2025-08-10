## Analyze Performance

Analyzes application performance issues and proposes improvements from a technical debt perspective.

### Usage

```bash
# Comprehensive analysis of performance issues
find . -name "*.js" -o -name "*.ts" | xargs wc -l | sort -rn | head -10
"Identify large files and performance issues, and suggest improvements"

# Detect inefficient code patterns
grep -r "for.*await\|forEach.*await" . --include="*.js"
"Analyze N+1 query problems and performance bottlenecks"

# Potential memory leaks
grep -r "addEventListener\|setInterval" . --include="*.js" | grep -v "removeEventListener\|clearInterval"
"Evaluate memory leak risks and countermeasures"
```

### Basic Examples

```bash
# Bundle size and load time
npm ls --depth=0 && find ./public -name "*.js" -o -name "*.css" | xargs ls -lh
"Identify improvements for bundle size and asset optimization"

# Database performance
grep -r "SELECT\|findAll\|query" . --include="*.js" | head -20
"Analyze optimization points for database queries"

# Performance impact of dependencies
npm outdated && npm audit
"Evaluate the performance impact of outdated dependencies"
```

### Analysis Perspectives

#### 1. Code-Level Issues

- **O(n²) Algorithms**: Detection of inefficient array operations
- **Synchronous I/O**: Identification of blocking operations
- **Redundant Processing**: Elimination of unnecessary calculations and requests
- **Memory Leaks**: Management of event listeners and timers

#### 2. Architecture-Level Issues

- **N+1 Queries**: Database access patterns
- **Insufficient Caching**: Repeated calculations and API calls
- **Bundle Size**: Unnecessary libraries and code splitting
- **Resource Management**: Connection pools and thread usage

#### 3. Impact of Technical Debt

- **Legacy Code**: Performance degradation due to old implementations
- **Design Issues**: High coupling due to insufficient responsibility distribution
- **Insufficient Testing**: Missed detection of performance regressions
- **Insufficient Monitoring**: Early detection system for issues

### Improvement Priorities

```
🔴 Critical: System failure risk
├─ Memory leaks (server crashes)
├─ N+1 queries (database load)
└─ Synchronous I/O (response delays)

🟡 High: User experience impact
├─ Bundle size (initial load time)
├─ Image optimization (display speed)
└─ Caching strategy (response speed)

🟢 Medium: Operational efficiency
├─ Dependency updates (security)
├─ Code duplication (maintainability)
└─ Enhanced monitoring (operational load)
```

### Measurement and Tools

#### Node.js / JavaScript

```bash
# Profiling
node --prof app.js
clinic doctor -- node app.js

# Bundle analysis
npx webpack-bundle-analyzer
lighthouse --chrome-flags="--headless"
```

#### Database

```sql
-- Query analysis
EXPLAIN ANALYZE SELECT ...
SHOW SLOW LOG;
```

#### Frontend

```bash
# React performance
grep -r "useMemo\|useCallback" . --include="*.jsx"

# Resource analysis
find ./src -name "*.png" -o -name "*.jpg" | xargs ls -lh
```

### Continuous Improvement

- **Regular Audits**: Weekly performance test execution
- **Metrics Collection**: Tracking of response times and memory usage
- **Alert Configuration**: Automatic notifications when thresholds are exceeded
- **Team Sharing**: Documentation of improvement cases and anti-patterns