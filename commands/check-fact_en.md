## Check Fact

A command to verify the accuracy of given information by referring to the project's codebase, documents (docs/, README.md, etc.).

### Usage

```bash
# Basic usage
/check-fact "The Flutter app uses Riverpod"

# Verify multiple pieces of information at once
/check-fact "This project uses GraphQL and manages routing with auto_route"

# Check specific technical specifications
/check-fact "JWT is used for authentication, and Firebase Auth is not used"
```

### Verification Process

1. **Information Source Priority**
   - Codebase (most reliable)
   - README.md, documents in docs/
   - Configuration files like package.json, pubspec.yaml
   - Issue and Pull Request discussion history

2. **Classification of Judgment Results**
   - `✅ Correct` - Information completely matches the codebase
   - `❌ Incorrect` - Information is clearly wrong
   - `⚠️ Partially correct` - Partially accurate but incomplete
   - `❓ Cannot determine` - Insufficient information for verification

3. **Explicit Evidence**
   - Relevant file name and line number
   - Related code snippets
   - Corresponding parts of documents

### Report Format

```
## Fact Check Results

### Verification Target
"[User-provided information]"

### Conclusion
[✅/❌/⚠️/❓] [Judgment result]

### Evidence
- **File**: `path/to/file.dart:123`
- **Content**: [Relevant code/text]
- **Supplement**: [Additional explanation]

### Detailed Explanation
[If incorrect, present correct information]
[If partially correct, point out inaccurate parts]
[If cannot determine, explain missing information]
```

### Basic Examples

```bash
# Check project technology stack
/check-fact "This app is built with Flutter + Riverpod + GraphQL"

# Check implementation status
/check-fact "Dark mode is implemented and can be switched from user settings"

# Check architecture
/check-fact "All state management is done with Riverpod, BLoC is not used"

# Check security implementation
/check-fact "Authentication tokens are encrypted and stored in secure storage"
```

### Collaboration with Claude

```bash
# Check after analyzing the entire codebase
ls -la && find . -name "pubspec.yaml" -exec cat {} \;
/check-fact "The main dependencies used in this project are..."

# Check implementation status of specific feature
grep -r "authentication" . --include="*.dart"
/check-fact "Authentication is custom implemented, third-party authentication is not used"

# Check consistency with documentation
cat README.md
/check-fact "All features described in the README are implemented"
```

### Use Cases

- When creating technical specifications: Verify accuracy of content
- When taking over a project: Confirm understanding of existing implementation
- Before client reporting: Verify facts about implementation status
- When writing technical blogs: Validate accuracy of article content
- When creating interview/explanatory materials: Confirm accuracy of project overview

### Notes

- The codebase is the most reliable information source
- If documentation is outdated, implementation takes precedence
- If information necessary for judgment is insufficient, honestly state "Cannot determine"
- Exercise particular caution when verifying security-related information