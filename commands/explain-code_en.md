## Code Explain

Provides detailed explanations of code behavior.

### Usage

```bash
# Display file contents and request Claude
cat <file>
"Explain how this code works"
```

### Basic Examples

```bash
# Understand Rust ownership
git main.rs
"Explain from the perspective of Rust ownership and lifetimes"

# Algorithm explanation
grep -A 50 "quicksort" sort.rs
"Explain how this sorting algorithm works and its computational complexity"

# Design pattern explanation
cat factory.rs
"Explain the design pattern used and its benefits"
```

### Collaboration with Claude

```bash
# Beginner-friendly explanation
cat complex_function.py
"Explain this code line by line in an easy-to-understand way for beginners"

# Performance analysis
cat algorithm.rs
"Identify performance issues in this code and suggest improvements"

# Explanation with diagrams
cat state_machine.js
"Explain the flow of this code with ASCII art diagrams"

# Security review
cat auth_handler.go
"Identify security concerns in this code"
```

### Detailed Examples

```bash
# Complex logic explanation
cat recursive_parser.rs
"Explain how this recursive parser works from the following perspectives:
1. Overall processing flow
2. Role and responsibility of each function
3. Edge case handling
4. Areas for improvement"

# Asynchronous processing explanation
cat async_handler.ts
"Explain this asynchronous processing including:
1. Flow of the Promise chain
2. Error handling mechanism
3. Presence of parallel processing
4. Potential for deadlocks"

# Architecture explanation
ls -la src/ && cat src/main.rs src/lib.rs
"Explain the architecture and module structure of this project"
```

### Notes

In code explanations, we not only describe what the code does, but also provide deeper insights such as why it's implemented that way, what benefits it offers, and what potential issues might exist.