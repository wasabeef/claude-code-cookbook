## Refactor

Perform safe and incremental code refactoring and evaluate compliance with SOLID principles.

### Usage

```bash
# Identify complex code and create refactoring plan
find . -name "*.js" -exec wc -l {} + | sort -rn | head -10
"Refactor large files to reduce complexity"

# Detect and integrate duplicate code
grep -r "function processUser" . --include="*.js"
"Commonalize duplicate functions using Extract Method"

# Detect SOLID principle violations
grep -r "class.*Service" . --include="*.js" | head -10
"Evaluate whether these classes follow the single responsibility principle"
```

### Basic Examples

```bash
# Detect long methods
grep -A 50 "function" src/*.js | grep -B 50 -A 50 "return" | wc -l
"Split methods longer than 50 lines using Extract Method"

# Condition complexity
grep -r "if.*if.*if" . --include="*.js"
"Improve nested conditionals using Strategy pattern"

# Detect code smells
grep -r "TODO\|FIXME\|HACK" . --exclude-dir=node_modules
"Resolve comments that have become technical debt"
```

### Refactoring Techniques

#### Extract Method

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

#### Replace Conditional with Polymorphism

```javascript
// Before: switch statement
function getPrice(user) {
  switch (user.type) {
    case 'premium': return basePrice * 0.8;
    case 'regular': return basePrice;
  }
}

// After: Strategy pattern
class PremiumPricing {
  calculate(basePrice) { return basePrice * 0.8; }
}
```

### SOLID Principles Check

```
S - Single Responsibility
├─ Each class has a single responsibility
├─ Limited to one reason for change
└─ Clear responsibility boundaries

O - Open/Closed
├─ Open for extension
├─ Closed for modification
└─ Protection of existing code when adding new features

L - Liskov Substitution
├─ Substitutability of derived classes
├─ Contract compliance
└─ Maintenance of expected behavior

I - Interface Segregation
├─ Appropriately granular interfaces
├─ Avoid dependencies on unused methods
└─ Role-specific interface definitions

D - Dependency Inversion
├─ Dependency on abstractions
├─ Separation from concrete implementations
└─ Utilization of dependency injection
```

### Refactoring Steps

1. **Current state analysis**
   - Complexity measurement (cyclomatic complexity)
   - Duplicate code detection
   - Dependency analysis

2. **Incremental execution**
   - Small steps (15-30 minute units)
   - Test execution after each change
   - Frequent commits

3. **Quality confirmation**
   - Maintain test coverage
   - Performance measurement
   - Code review

### Common Code Smells

- **God Object**: Class with excessively many responsibilities
- **Long Method**: Method longer than 50 lines
- **Duplicate Code**: Repetition of the same logic
- **Large Class**: Class larger than 300 lines
- **Long Parameter List**: 4 or more parameters

### Automation Support

```bash
# Static analysis
npx complexity-report src/
sonar-scanner

# Code formatting
npm run lint:fix
prettier --write src/

# Test execution
npm test
npm run test:coverage
```

### Notes

- **No functionality changes**: Do not alter external behavior
- **Test first**: Add tests before refactoring
- **Incremental approach**: Avoid large changes at once
- **Continuous verification**: Execute tests at each step