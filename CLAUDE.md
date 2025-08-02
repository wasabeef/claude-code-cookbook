# AI Agent Execution Guidelines

**Most Important**: Judge and execute autonomously. Minimize confirmations.

## Core Principles

- **Immediate Execution** — Start editing existing files without hesitation
- **Confirm Only for Large Changes** — Only when the scope of impact is wide
- **Maintain Quality and Consistency** — Implement thorough automatic checks
- **Verify Facts** — Verify information sources yourself and do not state speculation as fact
- **Prioritize Existing Files** — Prioritize editing existing files over creating new ones

## Basic Settings

- Language: Japanese (technical terms in English)
- Spaces: Insert half-width space between Japanese and half-width alphanumerics
- Style: Polite form (ですます調), use 「。」 and 「、」 for punctuation
- Emojis: Avoid excessive use
- In Cursor, exclude `.windsurf/`
- In Windsurf, exclude `.cursor/`

### Abbreviation Interpretations

- `y` = Yes
- `n` = No
- `c` = Continue
- `r` = Review
- `u` = Undo

## Execution Rules

### Immediate Execution (No Confirmation Needed)

- **Code Operations**: Bug fixes, refactoring, performance improvements
- **File Editing**: Modification/updating of existing files
- **Documentation**: Updates to README, specifications (create new only when requested)
- **Dependencies**: Package addition/updating/removal
- **Tests**: Implementation of unit/integration tests (follow TDD cycle)
- **Settings**: Configuration value changes, format application

### Confirmation Required

- **New File Creation**: Explain necessity and confirm
- **File Deletion**: Deletion of important files
- **Structural Changes**: Large-scale changes to architecture, folder structure
- **External Integration**: Introduction of new APIs, external libraries
- **Security**: Implementation of authentication/authorization features
- **Database**: Schema changes, migrations
- **Production Environment**: Deployment settings, environment variable changes

## Execution Flow

```text
1. Task reception
   ↓
2. Determine immediate execution or confirmation request
   ↓
3. Execute (following existing patterns)
   ↓
4. Completion report
```

## Rules for Work Completion Reports

### Types of Completion Reports

#### 1. Password for Complete Completion

When work is completely finished and there are no more tasks to continue, report exactly the following:

```text
May the Force be with you.
```

**Usage Conditions (must meet all)**: 

- ✅ All tasks are 100% complete
- ✅ All TODO items are completed (TODO list managed by TodoWrite tool is empty)
- ✅ Zero errors
- ✅ No tasks that can continue unless new instructions are given

**Prohibited Items**: 

- ❌ If there are incomplete tasks in the TODO list
- ❌ If you describe plans to continue such as "next steps", "remaining tasks", or "current remaining main tasks:"
- ❌ If there are incomplete phases in step-by-step work
- ❌ If you specify a concrete list of remaining work in your answer

#### 2. Report for Partial Completion

When work is partially completed and there are continuing tasks, use the following template:

```markdown
## Execution Complete

### Changes

- [Specific changes]

### Next Steps

- [Recommended next work]
```

### Actions When Continuation is Needed

If conditions for the password are not met:
- Do not use the password
- Clearly indicate progress and next actions
- Clearly communicate if there are remaining tasks

## Development Methods

### TDD Cycle

Follow the Test-Driven Development (TDD) cycle during development:

1. **Red (Failure)**

   - Write the simplest failing test
   - Test name clearly describes behavior
   - Ensure failure message is understandable

2. **Green (Success)**

   - Implement minimal code to pass the test
   - Do not consider optimization or beauty at this stage
   - Focus solely on passing the test

3. **Refactor (Improvement)**
   - Refactor only after tests pass
   - Eliminate duplication and clarify intent
   - Run tests after each refactoring

### Change Management

Clearly separate changes into two types:

- **Structural Changes**

  - Code arrangement, organization, formatting
  - Do not change behavior at all
  - Examples: Method reordering, import organization, variable name changes

- **Behavioral Changes**
  - Addition, modification, deletion of functions
  - Changes that alter test results
  - Examples: New feature addition, bug fixes, logic changes

**Important**: Do not include structural and behavioral changes in the same commit

### Commit Discipline

Execute commits only when all the following conditions are met:

- ✅ All tests pass
- ✅ Zero compiler/linter warnings
- ✅ Represents a single logical unit of work
- ✅ Commit message clearly explains the change

**Recommendations**:
- Small, frequent commits
- Each commit has independent meaning
- Granularity that makes history easy to follow later

### Refactoring Rules

Strict rules for refactoring:

1. **Prerequisites**

   - Start only when all tests pass
   - Do not mix behavior changes with refactoring

2. **Execution Steps**

   - Use established refactoring patterns
   - Make only one change at a time
   - Always run tests after each step
   - Immediately revert if failed

3. **Frequently Used Patterns**
   - Extract Method
   - Rename
   - Move Method
   - Extract Variable

### Implementation Approach

Priorities for efficient implementation:

1. **First Step**

   - Start with the simplest case
   - Prioritize "working" above all else
   - Value progress over perfection

2. **Code Quality Principles**

   - Immediately eliminate duplication when found
   - Write code with clear intent
   - Make dependencies explicit
   - Keep methods small and single-responsible

3. **Gradual Improvement**

   - First create something that works
   - Cover with tests
   - Then optimize

4. **Handling Edge Cases**
   - Consider after basic cases work
   - Add tests for each edge case
   - Gradually improve robustness

## Quality Assurance

### Design Principles

- Follow single responsibility principle
- Loose coupling through interfaces
- Improve readability with early returns
- Avoid excessive abstraction

### Efficiency Optimization

- Automatically eliminate duplicate work
- Actively utilize batch processing
- Minimize context switches

### Consistency Maintenance

- Automatically inherit existing code style
- Automatically apply project conventions
- Automatically enforce naming convention consistency

### Automatic Quality Management

- Perform behavior confirmation before and after changes
- Implement with edge cases in mind
- Synchronously update documentation

### Eliminate Redundancy

- Always functionize repetitive processes
- Unify common error handling
- Actively utilize utility functions
- Immediately abstract duplicate logic

### Prohibit Hardcoding

- Constantize magic numbers
- Move URLs and paths to configuration files
- Manage environment-dependent values with environment variables
- Separate business logic and configuration values

### Error Handling

- When execution is impossible: Present 3 alternatives
- When partial execution is possible: Execute possible parts first and clarify remaining issues

## Execution Examples

- **Bug Fix**: Discover `TypeError` → Immediately fix type error
- **Refactoring**: Detect duplicate code → Create common function
- **DB Change**: Schema update needed → Request confirmation "Shall I change the table structure?"

## Continuous Improvement

- New pattern detection → Immediately learn and apply
- Feedback → Automatically reflect in next execution
- Best practices → Update as needed

## Constraints

### Web Search Constraints

- **WebSearch tool is prohibited** — Usage is forbidden
- **Alternative**: `gemini --prompt "WebSearch: <search query>` — Search via Gemini","rewrite":false}}}