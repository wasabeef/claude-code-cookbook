# Claude Code Cookbook

A collection of commands, roles, and automation scripts for [Claude Code](https://docs.claude.com/claude-code).

Customize Claude Code with slash commands, expert roles, and automation hooks across multiple languages.

## What is Claude Code Cookbook?

Claude Code Cookbook provides a plugin system that extends Claude Code with:

- **Commands**: Custom slash commands for common development tasks
- **Roles**: Expert role presets for specialized assistance
- **Hooks**: Automated scripts that trigger at specific events

## Installation

### Step 1: Add the Marketplace

First, add this repository as a plugin marketplace in Claude Code:

```bash
/plugin marketplace add wasabeef/claude-code-cookbook
```

### Step 2: Install Your Language Plugin

Choose your preferred language plugin and install it:

| Language         | Plugin Name                    | Install Command                                   |
| :--------------- | :----------------------------- | :------------------------------------------------ |
| 🇯🇵 **日本語**    | [plugins/ja](plugins/ja)       | `/plugin install cook@claude-code-cookbook`       |
| 🇺🇸 **English**   | [plugins/en](plugins/en)       | `/plugin install cook-en@claude-code-cookbook`    |
| 🇰🇷 **한국어**    | [plugins/ko](plugins/ko)       | `/plugin install cook-ko@claude-code-cookbook`    |
| 🇨🇳 **简体中文**  | [plugins/zh-cn](plugins/zh-cn) | `/plugin install cook-zh-cn@claude-code-cookbook` |
| 🇹🇼 **繁體中文**  | [plugins/zh-tw](plugins/zh-tw) | `/plugin install cook-zh-tw@claude-code-cookbook` |
| 🇪🇸 **Español**   | [plugins/es](plugins/es)       | `/plugin install cook-es@claude-code-cookbook`    |
| 🇫🇷 **Français**  | [plugins/fr](plugins/fr)       | `/plugin install cook-fr@claude-code-cookbook`    |
| 🇧🇷 **Português** | [plugins/pt](plugins/pt)       | `/plugin install cook-pt@claude-code-cookbook`    |

Each plugin includes:

- Full command documentation in the native language
- Role definitions optimized for that language
- Language-specific customization examples

### Quick Start

After installation:

1. Start using commands with `/` prefix (e.g., `/pr-create`, `/refactor`)
2. Activate expert roles with `/role` command (e.g., `/role security`)
3. See your language plugin for detailed documentation

## Key Features

### Commands

Slash commands for common development workflows:

- **Pull Request Management**: `/pr-create`, `/pr-review`, `/pr-feedback`, `/pr-auto-update`
- **Code Quality**: `/refactor`, `/smart-review`, `/tech-debt`, `/analyze-dependencies`
- **Development Tools**: `/fix-error`, `/commit-message`, `/semantic-commit`, `/explain-code`
- **Planning & Analysis**: `/plan`, `/spec`, `/ultrathink`, `/check-fact`

### Roles

Switch to expert roles for specialized assistance:

- `/role security` - Security vulnerability analysis
- `/role architect` - Software architecture and design
- `/role frontend` - UI/UX and frontend optimization
- `/role backend` - API design and microservices
- `/role performance` - Performance optimization
- `/role qa` - Testing and quality assurance
- `/role mobile` - iOS/Android best practices
- `/role reviewer` - Code review and maintainability
- `/role analyzer` - System and code analysis

## Why Claude Code Cookbook?

- **Multilingual**: Language plugins with native translations
- **Production-ready**: Battle-tested commands and roles
- **Extensible**: Easy to add your own commands and roles
- **Safe**: Built-in safety hooks prevent dangerous operations
- **Efficient**: Reduce repetitive tasks and context switching
- **Open Source**: Apache 2.0 licensed
