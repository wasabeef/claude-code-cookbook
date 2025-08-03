## Design Patterns

Suggests applicable design patterns for codebases and evaluates compliance with SOLID principles.

### Usage

```bash
/design-patterns [analysis_target] [options]
```

### Options

- `--suggest`: Suggest applicable patterns (default)
- `--analyze`: Analyze existing pattern usage
- `--refactor`: Generate refactoring proposals
- `--solid`: Check compliance with SOLID principles
- `--anti-patterns`: Detect anti-patterns

### Basic Examples

```bash
# Analyze patterns for entire project
/design-patterns

# Suggest patterns for specific file
/design-patterns src/services/user.js --suggest

# Check SOLID principles
/design-patterns --solid

# Detect anti-patterns
/design-patterns --anti-patterns
```

### Analysis Categories

#### 1. Creational Patterns

- **Factory Pattern**: Abstracts object creation
- **Builder Pattern**: Step-by-step construction of complex objects
- **Singleton Pattern**: Ensures only one instance exists
- **Prototype Pattern**: Creates object clones

#### 2. Structural Patterns

- **Adapter Pattern**: Converts interfaces
- **Decorator Pattern**: Dynamically adds functionality
- **Facade Pattern**: Simplifies complex subsystems
- **Proxy Pattern**: Controls access to objects

#### 3. Behavioral Patterns

- **Observer Pattern**: Implements event notifications
- **Strategy Pattern**: Switches algorithms
- **Command Pattern**: Encapsulates operations
- **Iterator Pattern**: Traverses collections

### SOLID Principles Check Items

```
S - Single Responsibility Principle
O - Open/Closed Principle
L - Liskov Substitution Principle
I - Interface Segregation Principle
D - Dependency Inversion Principle
```

### Output Example

```
Design Pattern Analysis Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Currently Used Patterns
├─ Observer Pattern: EventEmitter (12 instances)
├─ Factory Pattern: UserFactory (3 instances)
├─ Singleton Pattern: DatabaseConnection (1 instance)
└─ Strategy Pattern: PaymentProcessor (5 instances)

Recommended Patterns
├─ [HIGH] Repository Pattern
│  └─ Target: src/models/*.js
│  └─ Reason: Separation of data access logic
│  └─ Example:
│      class UserRepository {
│        async findById(id) { ... }
│        async save(user) { ... }
│      }
│
├─ [MED] Command Pattern
│  └─ Target: src/api/handlers/*.js
│  └─ Reason: Standardization of request processing
│
└─ [LOW] Decorator Pattern
   └─ Target: src/middleware/*.js
   └─ Reason: Improved combination of functionalities

SOLID Principle Violations
├─ [S] UserService: Handles both authentication and authorization
├─ [O] PaymentGateway: Requires modification when adding new payment methods
├─ [D] EmailService: Directly depends on concrete classes
└─ [I] IDataStore: Contains unused methods

Refactoring Proposals
1. Split UserService into authentication and authorization
2. Introduce PaymentStrategy interface
3. Define EmailService interface
4. Split IDataStore by usage
```

### Advanced Usage Examples

```bash
# Analyze impact of pattern application
/design-patterns --impact-analysis Repository

# Generate implementation example for specific pattern
/design-patterns --generate Factory --for src/models/Product.js

# Suggest pattern combinations
/design-patterns --combine --context "API with caching"

# Evaluate architectural pattern
/design-patterns --architecture MVC
```

### Pattern Application Example

#### Before (Problematic Code)

```javascript
class OrderService {
  processOrder(order, paymentType) {
    if (paymentType === "credit") {
      // Credit card processing
    } else if (paymentType === "paypal") {
      // PayPal processing
    }
    // Other payment methods...
  }
}
```

#### After (Applying Strategy Pattern)

```javascript
// Strategy interface
class PaymentStrategy {
  process(amount) {
    throw new Error("Must implement process method");
  }
}

// Concrete strategies
class CreditCardPayment extends PaymentStrategy {
  process(amount) {
    /* Implementation */
  }
}

// Context
class OrderService {
  constructor(paymentStrategy) {
    this.paymentStrategy = paymentStrategy;
  }

  processOrder(order) {
    this.paymentStrategy.process(order.total);
  }
}
```

### Anti-Pattern Detection

- **God Object**: Classes with excessively many responsibilities
- **Spaghetti Code**: Code with complex, tangled control flow
- **Copy-Paste Programming**: Excessive use of duplicated code
- **Magic Numbers**: Hard-coded constants
- **Callback Hell**: Deeply nested callbacks

### Best Practices

1. **Gradual Application**: Don't apply too many patterns at once
2. **Verify Necessity**: Patterns are means to solve problems, not ends
3. **Team Agreement**: Discuss with team before applying patterns
4. **Documentation**: Record the intent of applied patterns