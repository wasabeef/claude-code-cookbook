## Task

Launches a dedicated agent to autonomously execute complex search, investigation, and analysis tasks. It emphasizes context efficiency in large-scale information processing that combines multiple tools.

### Usage

```bash
# Request Task from Claude
"Investigate [task] using Task"
```

### Features of Task

**Autonomous Execution**

- Automatically combines and executes multiple tools
- Step-by-step information collection and analysis
- Integration of results and structured reporting

**Efficient Information Processing**

- Optimization of context consumption
- Large-scale file search and analysis
- Data collection from external sources

**Quality Assurance**

- Reliability checks of information sources
- Verification from multiple perspectives
- Automatic completion of missing information

### Basic Examples

```bash
# Complex codebase investigation
"Investigate which files implement this feature using Task"

# Large-scale file search
"Identify configuration file inconsistencies using Task"

# External information collection
"Investigate the latest AI technology trends using Task"
```

### Collaboration with Claude

```bash
# Complex problem analysis
"Analyze the cause of memory leaks using Task, including profiling results and logs"

# Dependency investigation
"Investigate vulnerabilities of this npm package using Task"

# Competitor analysis
"Investigate API specifications of competing services using Task"

# Architecture analysis
"Analyze dependencies of this microservice using Task"
```

### Differentiation from Other Commands

#### Task vs Other Commands

| Command | Main Use Case | Execution Method | Information Collection |
|---------|---------------|-----------------|------------------------|
| **Task** | Investigation, analysis, search | Autonomous execution | Multiple sources |
| ultrathink | Deep thinking, judgment | Structured thinking | Existing knowledge-focused |
| sequential-thinking | Problem-solving, design | Step-by-step thinking | As needed |
| plan | Implementation planning | Approval process | Requirement analysis |

#### Decision Flowchart

```
Is information collection needed?
├─ Yes → Multiple sources or large-scale?
│          ├─ Yes → **Task**
│          └─ No → Normal question
└─ No → Is deep thinking needed?
          ├─ Yes → ultrathink/sequential-thinking
          └─ No → Normal question
```

### Effective and Ineffective Cases

**Effective Cases**

- Complex codebase investigation (dependencies, architecture analysis)
- Large-scale file search (specific implementation patterns, configuration files)
- External information collection and organization (technology trends, library investigation)
- Information integration from multiple sources (log analysis, metrics analysis)
- Repetitive investigation tasks (security audits, technical debt investigation)
- Large-scale analysis where context consumption should be avoided

**Ineffective Cases**

- Simple questions or content answerable with existing knowledge
- One-off tasks that complete quickly
- Tasks requiring interactive confirmation or consultation
- Implementation or design decisions (plan or thinking commands are more appropriate)

### Detailed Examples by Category

#### System Analysis and Investigation

```bash
# Complex system analysis
"Identify bottlenecks in the EC site using Task, investigating database, API, and frontend"

# Architecture analysis
"Analyze dependencies of this microservice using Task, including API communication and data flow"

# Technical debt investigation
"Analyze technical debt in legacy code using Task, including refactoring priorities"
```

#### Security and Compliance

```bash
# Security audit
"Investigate vulnerabilities in this application using Task, based on OWASP Top 10"

# License investigation
"Investigate license issues in project dependencies using Task"

# Configuration file audit
"Identify security configuration inconsistencies using Task, including environment differences"
```

#### Performance and Optimization

```bash
# Performance analysis
"Identify heavy queries in the application using Task, including execution plans and optimization proposals"

# Resource usage investigation
"Investigate causes of memory leaks using Task, including profiling results and code analysis"

# Bundle size analysis
"Investigate frontend bundle size issues using Task, including optimization suggestions"
```

#### External Information Collection

```bash
# Technology trend investigation
"Investigate 2024 JavaScript framework trends using Task"

# Competitor analysis
"Investigate API specifications of competing services using Task, including feature comparison table"

# Library evaluation
"Compare state management libraries using Task, including performance and learning costs"
```

### Execution Flow and Quality Assurance

#### Task Execution Flow

```
1. Initial Analysis
   ├─ Decomposition of task and identification of investigation scope
   ├─ Selection of necessary tools and information sources
   └─ Development of execution plan

2. Information Collection
   ├─ File search and code analysis
   ├─ Collection of external information
   └─ Data structuring

3. Analysis and Integration
   ├─ Relevance analysis of collected information
   ├─ Identification of patterns and issues
   └─ Verification of hypotheses

4. Reporting and Proposal
   ├─ Structuring of results
   ├─ Creation of improvement proposals
   └─ Presentation of next actions
```

#### Quality Assurance

- **Reliability check of information sources**: Fact confirmation from multiple sources
- **Completeness check**: Verification of no gaps in investigation targets
- **Consistency verification**: Confirmation of consistency in conflicting information
- **Practicality evaluation**: Assessment of feasibility and effectiveness of proposals

### Error Handling and Constraints

#### Common Constraints

- **External API usage limits**: Rate limits and authentication errors
- **Large file processing limits**: Memory and timeout constraints
- **Access permission issues**: Restrictions on file and directory access

#### Error Handling

- **Partial result reporting**: Analysis with only obtainable information
- **Alternative proposals**: Suggestion of alternative investigation methods under constraints
- **Stepwise execution**: Division of large-scale tasks for execution

### Notes

- Task is optimal for complex, autonomous investigation and analysis tasks
- For simple questions or when immediate answers are needed, use normal question format
- Treat investigation results as reference information and always verify important decisions
- When collecting external information, pay attention to the freshness and accuracy of information

### Execution Example

```bash
# Usage example
"Investigate issues in GraphQL schema using Task"

# Expected behavior
# 1. Dedicated agent starts
# 2. Search for GraphQL-related files
# 3. Analyze schema definitions
# 4. Compare with best practices
# 5. Identify issues and propose improvements
# 6. Create structured report
```