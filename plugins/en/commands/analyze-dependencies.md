## Analyze project dependencies and evaluate architectural health

Analyzes your project's dependencies and checks architecture health.

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

### What Gets Analyzed

#### 1. Dependency Matrix

Shows how modules connect to each other:

- Direct dependencies
- Indirect dependencies
- Dependency depth
- Fan-in/fan-out

#### 2. Architecture Violations

- Layer violations (when lower layers depend on upper ones)
- Circular dependencies
- Excessive coupling (too many connections)
- Orphaned modules

#### 3. Clean Architecture Check

- Is the domain layer independent?
- Is infrastructure properly separated?
- Do use case dependencies flow correctly?
- Are interfaces being used properly?

### Output Example

```text
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
# Automatic CI/CD checks
/dependency-analysis --circular --fail-on-violation

# Check against architecture rules
/dependency-analysis --rules .architecture-rules.yml

# See how dependencies changed
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

### Tools We Use

- `madge`: Shows JavaScript/TypeScript dependencies visually
- `dep-cruiser`: Checks dependency rules
- `nx`: Manages monorepo dependencies
- `plato`: Analyzes complexity and dependencies together

### Collaboration with Claude

```bash
# Check dependencies with package.json
cat package.json
/analyze-dependencies
"Find dependency issues in this project"

# Deep dive into a specific module
ls -la src/core/
/analyze-dependencies --focus src/core
"Check the core module's dependencies in detail"

# Compare design vs reality
cat docs/architecture.md
/analyze-dependencies --visual
"Does our implementation match the architecture docs?"
```

### Notes

- **Run from**: Project root directory
- **Be patient**: Large projects take time to analyze
- **Act fast**: Fix circular dependencies as soon as you find them

### Best Practices

1. **Check weekly**: Keep an eye on dependency health
2. **Write rules down**: Put architecture rules in config files
3. **Small steps**: Fix things gradually, not all at once
4. **Track trends**: Watch how complexity changes over time
