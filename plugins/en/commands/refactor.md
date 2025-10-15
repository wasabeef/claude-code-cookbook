## Refactor

Performs safe, step-by-step code refactoring with quantitative SOLID principles evaluation. Visualizes technical debt and clarifies improvement priorities.

### Usage

```bash
# Identify complex code and create refactoring plan
find . -name "*.js" -exec wc -l {} + | sort -rn | head -10
"Refactor large files to reduce complexity"

# Detect and consolidate duplicate code
grep -r "function processUser" . --include="*.js"
"Consolidate duplicate functions using Extract Method"

# Evaluate SOLID principles violations
grep -r "class.*Service" . --include="*.js" | head -10
"Assess whether these classes follow Single Responsibility Principle"
```

### Basic Examples

```bash
# Find long methods
grep -A 50 "function" src/*.js | grep -B 50 -A 50 "return" | wc -l
"Split methods over 50 lines using Extract Method"

# Find complex conditions
grep -r "if.*if.*if" . --include="*.js"
"Improve nested conditions using Strategy pattern"

# Find code smells
grep -r "TODO\|FIXME\|HACK" . --exclude-dir=node_modules
"Resolve technical debt in comments"
```

### Refactoring Techniques

#### Extract Method (Split Big Functions)

```javascript
// Before: Long method
function processOrder(order) {
  // 50 lines of complex processing
}

// After: Separation of responsibilities
function processOrder(order) {
  validateOrder(order);
  calculateTotal(order);
  saveOrder(order);
}
```

#### Replace Conditional with Polymorphism (Remove Switch/If Chains)

```javascript
// Before: switch statement
function getPrice(user) {
  switch (user.type) {
    case "premium":
      return basePrice * 0.8;
    case "regular":
      return basePrice;
  }
}

// After: Strategy pattern
class PremiumPricing {
  calculate(basePrice) {
    return basePrice * 0.8;
  }
}
```

### SOLID Principles Scoring (0-100 points)

#### Evaluation Criteria and Scoring

```text
S - Single Responsibility (20 points)
├─ Number of responsibilities: 1 (20pts) | 2 (15pts) | 3 (10pts) | 4+ (5pts)
├─ Method count: <7 (+5pts) | 7-15 (+3pts) | >15 (0pts)
├─ Clear reasons for change: Clear (+5pts) | Unclear (0pts)
└─ Example score: UserService (auth + data processing) = 10 points

O - Open/Closed (20 points)
├─ Extension points: Strategy/Template Method (20pts) | Inheritance only (10pts) | None (5pts)
├─ Existing code changes for new features: Not needed (+5pts) | Minimal (+3pts) | Required (0pts)
├─ Interface usage: Appropriate (+5pts) | Partial (+3pts) | None (0pts)
└─ Example score: PaymentProcessor (Strategy) = 20 points

L - Liskov Substitution (20 points)
├─ Derived class contract compliance: Complete (20pts) | Partial (10pts) | Violated (0pts)
├─ Precondition strengthening: None (+5pts) | Present (-5pts)
├─ Postcondition weakening: None (+5pts) | Present (-5pts)
└─ Example score: Square extends Rectangle = 0 points (violated)

I - Interface Segregation (20 points)
├─ Interface size: 1-3 methods (20pts) | 4-7 (15pts) | 8+ (5pts)
├─ Unused method implementations: None (+5pts) | 1-2 (+2pts) | 3+ (0pts)
├─ Role clarity: Single role (+5pts) | Multiple roles (0pts)
└─ Example score: Readable/Writable separation = 20 points

D - Dependency Inversion (20 points)
├─ Dependency direction: Abstractions only (20pts) | Mixed (10pts) | Concretions only (5pts)
├─ DI usage: Constructor Injection (+5pts) | Setter (+3pts) | None (0pts)
├─ Testability: Mockable (+5pts) | Difficult (0pts)
└─ Example score: Repository Pattern = 20 points

Total Score = S + O + L + I + D
├─ 90-100 points: Excellent (SOLID compliant)
├─ 70-89 points: Good (Minor improvements needed)
├─ 50-69 points: Fair (Refactoring recommended)
├─ 30-49 points: Poor (Major improvements required)
└─ 0-29 points: Critical (Design overhaul required)
```

### Technical Debt Quantification

#### Debt Calculation Formula

```text
Technical Debt (time) = Complexity Score × Impact Range × Fix Difficulty

Complexity Score:
├─ Cyclomatic complexity: 1-5 (low) | 6-10 (med) | 11-20 (high) | 21+ (critical)
├─ Cognitive complexity: Nesting depth × conditional branches
├─ Lines of code: <50 (1pt) | 50-200 (2pts) | 200-500 (3pts) | 500+ (5pts)
└─ Duplication rate: 0-10% (1pt) | 10-30% (2pts) | 30-50% (3pts) | 50%+ (5pts)

Impact Range:
├─ Dependent modules: Direct dependencies + Indirect × 0.5
├─ Usage frequency: API calls/day
├─ Business importance: Critical (×3) | High (×2) | Medium (×1) | Low (×0.5)
└─ Team knowledge: 1 person knows (×3) | 2-3 (×2) | 4+ (×1)

Fix Difficulty:
├─ Test coverage: 0% (×3) | <50% (×2) | 50-80% (×1.5) | >80% (×1)
├─ Documentation: None (×2) | Insufficient (×1.5) | Adequate (×1)
├─ Dependencies: Tightly coupled (×3) | Moderate (×2) | Loosely coupled (×1)
└─ Change risk: Breaking change (×3) | Backward compatibility (×2) | Safe (×1)

Cost Conversion:
├─ Time cost: Debt time × Developer hourly rate
├─ Opportunity cost: New feature delay days × Daily revenue impact
├─ Quality cost: Bug probability × Fix cost × Frequency
└─ Total cost: Time + Opportunity + Quality costs
```

#### Priority Matrix

| Priority                   | Impact | Fix Cost | Time Savings | Investment ROI        | Response Deadline |
| -------------------------- | ------ | -------- | ------------ | --------------------- | ----------------- |
| **Critical (Immediate)**   | High   | Low      | > 5x         | Invest 1h → Save 5h+  | Immediately       |
| **Important (Planned)**    | High   | High     | 2-5x         | Invest 1h → Save 2-5h | Within 1 month    |
| **Watch (Monitor)**        | Low    | High     | 1-2x         | Invest 1h → Save 1-2h | Within 3 months   |
| **Acceptable (Tolerable)** | Low    | Low      | < 1x         | Investment = Savings  | No action needed  |

### Refactoring Process

1. **Current Analysis and Measurement**
   - Measure complexity (cyclomatic & cognitive)
   - Calculate SOLID score (0-100 points)
   - Quantify technical debt (time/cost)
   - Create priority matrix

2. **Step-by-Step Execution**
   - Small steps (15-30 minute increments)
   - Run tests after each change
   - Frequent commits
   - Continuous SOLID score measurement

3. **Quality Verification**
   - Maintain test coverage
   - Measure performance
   - Verify technical debt reduction
   - Code review

### Common Code Smells and Debt Scores

| Code Smell              | Detection Criteria               | Debt Score     | Improvement Method       |
| ----------------------- | -------------------------------- | -------------- | ------------------------ |
| **God Object**          | Responsibilities >3, Methods >20 | High (15-20h)  | Extract Class, Apply SRP |
| **Long Method**         | Lines >50, Complexity >10        | Medium (5-10h) | Extract Method           |
| **Duplicate Code**      | Duplication rate >30%            | High (10-15h)  | Extract Method/Class     |
| **Large Class**         | Lines >300, Methods >15          | High (10-20h)  | Extract Class            |
| **Long Parameter List** | Parameters >4                    | Low (2-5h)     | Parameter Object         |
| **Feature Envy**        | Other class references >5        | Medium (5-10h) | Move Method              |
| **Data Clumps**         | Repeated argument groups         | Low (3-5h)     | Extract Class            |
| **Primitive Obsession** | Excessive primitive type usage   | Medium (5-8h)  | Replace with Object      |
| **Switch Statements**   | Cases >5                         | Medium (5-10h) | Strategy Pattern         |
| **Shotgun Surgery**     | Change impact areas >3           | High (10-15h)  | Move Method/Field        |

### Practical Example: SOLID Score Evaluation

```javascript
// Evaluation target: UserService class
class UserService {
  constructor(db, cache, logger, emailService) { // 4 dependencies
    this.db = db;
    this.cache = cache;
    this.logger = logger;
    this.emailService = emailService;
  }

  // Responsibility 1: Authentication
  authenticate(username, password) { /* ... */ }
  refreshToken(token) { /* ... */ }

  // Responsibility 2: User management
  createUser(data) { /* ... */ }
  updateUser(id, data) { /* ... */ }
  deleteUser(id) { /* ... */ }

  // Responsibility 3: Notifications
  sendWelcomeEmail(user) { /* ... */ }
  sendPasswordReset(email) { /* ... */ }
}

// SOLID Score Evaluation Result
S: 10 points (3 responsibilities: auth, CRUD, notifications)
O: 5 points (No extension points, direct implementation)
L: 15 points (No inheritance, not applicable)
I: 10 points (Interfaces not segregated)
D: 10 points (Depends on concrete classes)
Total: 50 points (Fair - Refactoring recommended)

// Technical Debt
Complexity: 15 (7 methods, 3 responsibilities)
Impact Range: 8 (Authentication used across all features)
Fix Difficulty: 2 (Tests exist, documentation lacking)
Debt Time: 15 × 8 × 2 = 240 hours
Priority: Critical (Auth system requires immediate attention)
```

### Improved Implementation Example

```javascript
// After applying SOLID principles (Score: 90 points)

// S: Single Responsibility (20 points)
class AuthenticationService {
  authenticate(credentials) { /* ... */ }
  refreshToken(token) { /* ... */ }
}

// O: Open/Closed (20 points)
class UserRepository {
  constructor(storage) { // Strategy Pattern
    this.storage = storage;
  }
  save(user) { return this.storage.save(user); }
}

// I: Interface Segregation (20 points)
interface Readable {
  find(id);
  findAll();
}
interface Writable {
  save(entity);
  delete(id);
}

// D: Dependency Inversion (20 points)
class UserService {
  constructor(
    private auth: IAuthService,
    private repo: IUserRepository,
    private notifier: INotificationService
  ) {}
}

// Debt reduction: 240 hours → 20 hours (92% reduction)
```

### Automation Support

```bash
# SOLID score measurement
npx solid-analyzer src/ --output report.json

# Complexity analysis
npx complexity-report src/ --format json
sonar-scanner -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info

# Technical debt visualization
npx code-debt-analyzer --config .debt.yml

# Code formatting
npm run lint:fix
prettier --write src/

# Test execution and coverage
npm test -- --coverage
npm run test:mutation  # Mutation testing
```

### Important Rules

- **No functional changes**: Don't alter external behavior
- **Test first**: Add tests before refactoring
- **Step-by-step approach**: No large changes at once
- **Continuous verification**: Run tests at each step
