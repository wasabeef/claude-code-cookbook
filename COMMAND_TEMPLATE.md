## Command Name

A concise description of the command (explain what the command does in one line).

<!--
Notes for using the template:
- Required sections: Title, Description, Usage, Basic Examples, Integration with Claude, Notes
- Optional sections: Options, Detailed Features, Output Examples, Best Practices, Related Commands
- Use only the necessary sections according to the complexity of the command
-->

### Usage

```bash
/command-name [options]
```

### Options

- None : Default behavior
- `--option1` : Description of option 1
- `--option2 <value>` : Description of option that takes a parameter
- `--flag` : Description of flag option

*You can omit this entire section if the command doesn't require options.*

### Basic Examples

```bash
# Basic usage
/command-name
"Explanation when executing"

# Example with option
/command-name --option1
"Explanation when using option 1"

# Example with parameterized option
/command-name --option2 value
"Example of using parameterized option"

# Combination of multiple options
/command-name --option1 --flag
"Example of combining multiple options"
```

### Detailed Features (Optional)

#### Feature Category 1

Detailed description of the feature and its usage scenarios.

```bash
# Specific code example
command example
```

#### Feature Category 2

Detailed description of another feature.

- **Feature 1**: Description
- **Feature 2**: Description
- **Feature 3**: Description

*You can omit this section for simple commands.*

### Output Examples (Optional)

```
Example of expected output format
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Sample actual output content
├─ Item 1: Value
├─ Item 2: Value
└─ Item 3: Value
```

*You can omit this section if the output is simple or sufficiently explained in the basic examples.*

### Integration with Claude

```bash
# Example of usage with files
cat file.txt
/command-name
"Request analysis including file contents"

# Example of usage in a pipeline
command1 | command2
/command-name
"Processing using output from previous command"

# Example of complex analysis
ls -la && cat config.json
/command-name --option1
"Analysis combining multiple information sources"
```

### Notes

- **Prerequisites**: Requirements needed to execute the command
- **Limitations**: Functional limitations and points to note
- **Recommendations**: Recommendations for effective usage

### Best Practices (Optional)

1. **Principle 1**: Explanation of recommended usage
2. **Principle 2**: Explanation of usage to avoid
3. **Principle 3**: Recommendations regarding performance and efficiency
4. **Principle 4**: Recommendations regarding security and safety

*You can omit this section for simple commands with no special considerations.*

### Related Commands (Optional)

- `/related-command1` : Command with related functionality
- `/related-command2` : Command that works effectively in combination
- `/related-command3` : Command that can be used as an alternative

*You can omit this section if there are no related commands.*