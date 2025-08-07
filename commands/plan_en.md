## Plan

Launches pre-implementation planning mode to develop detailed implementation strategies. Supports efficient development by creating structured plans before code implementation.

### Usage

```bash
# Request Plan Mode from Claude
"Create an implementation plan for [implementation content]"
```

### Basic Examples

```bash
# Implementation plan for new feature
"Create an implementation plan for user authentication functionality"

# System design plan
"Create an implementation plan for microservice splitting"

# Refactoring plan
"Create a refactoring plan for legacy code"
```

### Collaboration with Claude

```bash
# Complex feature implementation
"Create an implementation plan for chat functionality, including WebSocket, real-time notifications, and history management"

# Database design
"Create a database design plan for an e-commerce site, including product, order, and user management"

# API design
"Create an implementation plan for GraphQL API, including authentication, caching, and rate limiting"

# Infrastructure design
"Create an implementation plan for Dockerization, including development environment, production environment, and CI/CD"
```

### Features of Plan Mode

**Automatic Activation**

- Plan Mode automatically activates when detecting implementation tasks
- Can be explicitly activated with keywords like "Create an implementation plan"

**Structured Specifications**

- Requirements definition (user stories, acceptance criteria)
- Design documents (architecture, data design, UI design)
- Implementation plan (task decomposition, progress tracking, quality assurance)
- Risk analysis and countermeasures

**Approval Process**

- Present plan with `exit_plan_mode` tool
- **Important**: Always wait for explicit user approval regardless of tool return value
- Implementation without approval is prohibited
- Plan modifications and adjustments are possible
- Task management with TodoWrite starts only after approval

### Detailed Examples

```bash
# Complex system implementation
"Create an implementation plan for an online payment system, including Stripe integration, security, and error handling"

# Frontend implementation
"Create an implementation plan for a React dashboard, including state management, component design, and testing"

# Backend implementation
"Create an implementation plan for a RESTful API, including authentication, validation, and logging"

# DevOps implementation
"Create an implementation plan for a CI/CD pipeline, including test automation, deployment, and monitoring"
```

### 3-Stage Workflow

#### Phase 1: Requirements

- **User Stories**: Clarify purpose and value of functionality
- **Acceptance Criteria**: Define completion conditions and quality standards
- **Constraints & Prerequisites**: Organize technical and time constraints
- **Prioritization**: Classify as Must-have/Nice-to-have

#### Phase 2: Design

- **Architecture Design**: System configuration and technology selection
- **Data Design**: Schema, API specifications, data flow
- **UI/UX Design**: Screen configuration and operation flow
- **Risk Analysis**: Potential issues and countermeasures

#### Phase 3: Implementation

- **Task Decomposition**: Break down into implementable units
- **Progress Tracking**: Status management with TodoWrite
- **Quality Assurance**: Test strategy and verification methods
- **Approval Process**: Plan presentation with exit_plan_mode and waiting for explicit approval

### Notes

**Scope of Application**

- Plan Mode is optimal for complex implementation tasks
- For simple fixes or small changes, use normal implementation format
- Recommended for tasks with 3+ steps or new feature development

**Technical Constraints**

- Do not trust return values from `exit_plan_mode` tool
- Approval process is determined by explicit user indication
- Different functionality from CLI plan mode

**Operational Notes**

- Strictly prohibit starting implementation before approval
- Always wait for user response after presenting plan
- Present alternative means in case of errors

### Execution Example

```bash
# Usage example
"Create an implementation plan for a user management system"

# Expected behavior
# 1. Plan Mode automatically activates
# 2. Requirements analysis and technology selection
# 3. Structuring of implementation steps
# 4. Plan presentation with exit_plan_mode
# 5. Implementation starts after approval
```