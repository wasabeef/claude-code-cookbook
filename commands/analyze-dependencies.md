## Dependency Analysis

Analyzes project dependencies and evaluates architecture health.

### Usage

```bash
/dependency-analysis [options]
```

### Options

- `--visual`: Visually display dependencies
- `--circular`: Detect only circular dependencies
- `--depth <number>`: Specify analysis depth (default: 3)
- `--focus <path>`: Focus on specific module/directory

### Basic Examples

```bash
# Analyze dependencies for entire project
/dependency-analysis

# Detect circular dependencies
/dependency-analysis --circular

# Detailed analysis of specific module
/dependency-analysis --focus src/core --depth 5
```

### Analysis Items

#### 1. Dependency Matrix

Quantifies and displays dependencies between modules:

- Direct dependencies
- Indirect dependencies
- Dependency depth
- Fan-in/fan-out

#### 2. Architecture Violation Detection

- Layer violations (lower layers depending on upper layers)
- Circular dependencies
- Excessive coupling (high dependency degree)
- Isolated modules

#### 3. Clean Architecture Compliance Check

- Domain layer independence
- Proper separation of infrastructure layer
- Dependency direction of use case layer
- Interface application status

### Output Example

```
Dependency Analysis Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Metrics Overview
├─ Total modules: 42
├─ Average dependencies: 3.2
├─ Maximum dependency depth: 5
└─ Circular dependencies: 2 detected

⚠️  Architecture Violations
├─ [HIGH] src/domain/user.js → src/infra/database.js
│  └─ Domain layer directly depends on infrastructure layer
├─ [MED] src/api/auth.js ⟲ src/services/user.js
│  └─ Circular dependency detected
└─ [LOW] src/utils/helper.js → 12 modules
   └─ Excessive fan-out

✅ Recommended Actions
1. Introduce UserRepository interface
2. Redesign authentication service responsibilities
3. Split helper functions by functionality

📈 Dependency Graph
[Visual dependency diagram displayed in ASCII art]
```

### Advanced Usage Examples

```bash
# Automatic checks in CI/CD pipeline
/dependency-analysis --circular --fail-on-violation

# Define and verify architecture rules
/dependency-analysis --rules .architecture-rules.yml

# Track changes in dependencies over time
/dependency-analysis --compare HEAD~10
```

### Configuration File Example (.dependency-analysis.yml)

```yaml
rules:
  - name: "Domain Independence"
    source: "src/domain/**"
    forbidden: ["src/infra/**", "src/api/**"]

  - name: "API Layer Dependencies"
    source: "src/api/**"
    allowed: ["src/domain/**", "src/application/**"]
    forbidden: ["src/infra/**"]

thresholds:
  max_dependencies: 8
  max_depth: 4
  coupling_threshold: 0.7

ignore:
  - "**/test/**"
  - "**/mocks/**"
```

### Integrated Tools

- `madge`: JavaScript/TypeScript dependency visualization
- `dep-cruiser`: Dependency rule validation
- `nx`: Monorepo dependency management
- `plato`: Integrated analysis of complexity and dependencies

### Collaboration with Claude

```bash
# Analysis including package.json
cat package.json
/analyze-dependencies
"Analyze the dependency issues in this project"

# Combine with source code of specific module
ls -la src/core/
/analyze-dependencies --focus src/core
"Evaluate the dependencies of the core module in detail"

# Compare with architecture documentation
cat docs/architecture.md
/analyze-dependencies --visual
"Check for discrepancies between design documentation and implementation"
```

### Notes

- **Prerequisite**: Must be executed at project root
- **Limitations**: Analysis may take time for large-scale projects
- **Recommendation**: If circular dependencies are found, consider addressing them immediately

### Best Practices

1. **Regular Analysis**: Check dependency health weekly
2. **Explicit Rules**: Manage architecture rules in configuration files
3. **Incremental Improvement**: Avoid large-scale refactoring, improve gradually
4. **Metrics Tracking**: Monitor dependency complexity over time