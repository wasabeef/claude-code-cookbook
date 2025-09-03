## Analyze Performance

Analyzes application performance from a user experience perspective and quantifies experience improvements from optimizations. Calculates UX scores based on Core Web Vitals and proposes prioritized optimization strategies.

### UX Performance Score

```
User Experience Score: B+ (78/100)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⏱️ Core Web Vitals
├─ LCP (Loading): 2.3s [Good] Target<2.5s ✅
├─ FID (Interaction): 95ms [Good] Target<100ms ✅
├─ CLS (Visual Stability): 0.08 [Good] Target<0.1 ✅
├─ FCP (First Paint): 1.8s [Good] Target<1.8s ✅
├─ TTFB (Server): 450ms [Needs Work] Target<200ms ⚠️
└─ TTI (Interactive): 3.5s [Needs Work] Target<3.8s ⚠️

📊 Perceived Speed
├─ Initial Load: 2.3s [Industry avg: 3.0s]
├─ Page Navigation: 1.1s [Industry avg: 1.5s]
├─ Search Results: 0.8s [Industry avg: 1.2s]
├─ Form Submission: 1.5s [Industry avg: 2.0s]
└─ Image Loading: Lazy loading implemented ✅

😊 User Satisfaction Prediction
├─ Bounce Rate: 12% (Industry avg: 20%)
├─ Completion Rate: 78% (Target: 85%)
├─ NPS Score: +24 (Industry avg: +15)
└─ Return Rate: 65% (Target: 70%)

📊 User Experience Impact
├─ 0.5s faster display → -7% bounce rate
├─ 5% bounce reduction → +15% session length
├─ Search improvement → +15% time on site
└─ Overall UX improvement: +25%

🎯 Expected Improvement Effects (Priority Order)
├─ [P0] TTFB improvement (CDN) → LCP -0.3s = +15% perceived speed
├─ [P1] JS bundle optimization → TTI -0.8s = -20% interactive time
├─ [P2] Image optimization (WebP) → -40% transfer = -25% load time
└─ [P3] Cache strategy → 50% faster repeat visits
```

### Usage

```bash
# Comprehensive UX score analysis
find . -name "*.js" -o -name "*.ts" | xargs wc -l | sort -rn | head -10
"Calculate UX performance score and evaluate Core Web Vitals"

# Performance bottleneck detection
grep -r "for.*await\|forEach.*await" . --include="*.js"
"Detect async processing bottlenecks and analyze UX impact"

# User experience impact analysis
grep -r "addEventListener\|setInterval" . --include="*.js" | grep -v "removeEventListener\|clearInterval"
"Analyze performance impact on user experience"
```

### Basic Examples

```bash
# Bundle size and load time
npm ls --depth=0 && find ./public -name "*.js" -o -name "*.css" | xargs ls -lh
"Identify bundle size and asset optimization improvements"

# Database performance
grep -r "SELECT\|findAll\|query" . --include="*.js" | head -20
"Analyze database query optimization points"

# Dependency performance impact
npm outdated && npm audit
"Evaluate performance impact of outdated dependencies"
```

### Analysis Perspectives

#### 1. Code-Level Problems

- **O(n²) Algorithms**: Detect inefficient array operations
- **Synchronous I/O**: Identify blocking processes
- **Redundant Processing**: Remove unnecessary calculations or requests
- **Memory Leaks**: Manage event listeners and timers

#### 2. Architecture-Level Problems

- **N+1 Queries**: Database access patterns
- **Missing Cache**: Repeated calculations or API calls
- **Bundle Size**: Unnecessary libraries or code splitting
- **Resource Management**: Connection pools and thread usage

#### 3. Technical Debt Impact

- **Legacy Code**: Performance degradation from old implementations
- **Design Issues**: High coupling from poor responsibility distribution
- **Insufficient Testing**: Missing performance regression detection
- **Monitoring Gaps**: Early problem detection system

### Performance Improvement ROI Matrix

```
Improvement ROI = (Time Savings + Quality Improvement) ÷ Implementation Effort
```

| Priority | UX Impact | Implementation Difficulty | Time Savings | Example | Effort | Effect |
|----------|-----------|-------------------------|-------------|---------|--------|--------|
| **[P0] Implement Now** | High | Low | > 50% | CDN implementation | 8h | Response -60% |
| **[P1] Early Implementation** | High | Medium | 20-50% | Image optimization | 16h | Load -30% |
| **[P2] Planned Implementation** | Low | High | 10-20% | Code splitting | 40h | Initial -15% |
| **[P3] Hold/Monitor** | Low | Low | < 10% | Minor optimizations | 20h | Partial -5% |

#### Priority Criteria

- **P0 (Immediate)**: High UX impact × Low difficulty = Maximum ROI
- **P1 (Early)**: High UX impact × Medium difficulty = High ROI
- **P2 (Planned)**: Low UX impact × High difficulty = Medium ROI
- **P3 (Hold)**: Low UX impact × Low difficulty = Low ROI

### Performance Metrics and UX Improvement Correlation

| Metric | Improvement | Perceived Speed | User Satisfaction | Implementation Effort |
|--------|-------------|-----------------|-------------------|--------------------|
| **LCP (Loading)** | -0.5s | +30% | -7% bounce rate | 16h |
| **FID (Interaction)** | -50ms | +15% | -20% stress | 8h |
| **CLS (Visual Stability)** | -0.05 | +10% | -50% misclicks | 4h |
| **TTFB (Server)** | -200ms | +25% | +40% perceived speed | 24h |
| **TTI (Interactive)** | -1.0s | +35% | +15% completion rate | 32h |
| **Bundle Size** | -30% | +20% | +25% first visit | 16h |

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

- **Regular Audits**: Run weekly performance tests
- **Metrics Collection**: Track response times and memory usage
- **Alert Setup**: Automatic notifications for threshold violations
- **Team Sharing**: Document improvement cases and anti-patterns