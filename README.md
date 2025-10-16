# My ~/.cursor settings

A comprehensive collection of Cursor AI editor settings, commands, and rules designed for professional development workflows. This repository contains reusable configurations that can be shared across teams and projects.

## 📁 Repository Structure

```
.cursor/
├── commands/           # Custom Cursor commands (10 commands)
│   ├── commit.md      # Git commit automation
│   ├── git-branch.md  # Safe branch creation
│   ├── git-reset.md   # Safe git reset with backup
│   ├── git-status.md  # Multi-repository status check
│   ├── k8s-check.md   # Safe Kubernetes resource inspection
│   ├── k8s-diff.md    # Kubernetes deployment diff preview
│   ├── k8s-validate.md # Kubernetes manifest validation
│   ├── plan.md        # Project planning and task breakdown
│   ├── pr.md          # Pull request management (consolidated)
│   └── workspace-status.md # Multi-repository workspace overview
├── hooks/             # Safety hooks (5 hooks)
│   ├── block-dangerous-kubectl.sh    # Block dangerous kubectl commands
│   ├── block-git-push-main.sh        # Block direct pushes to main/master
│   ├── block-git-reset-hard.sh       # Block destructive git reset
│   ├── check-branch-protection.sh    # Warn about edits on main/master
│   └── suggest-safe-commands.sh      # Suggest safe command alternatives
├── rules/             # Development rules (4 rule files)
│   ├── safety.md      # Safety rules and protections
│   ├── quality.md     # Code quality standards
│   ├── workflow.md    # Development workflow rules
│   └── integration.md # Linear/GitHub/MCP integration rules
├── docs/              # Detailed documentation
├── examples/          # Usage examples and templates
├── backups/           # Backup of original rules
├── plans/             # Migration plans and documentation
├── .gitignore         # Git ignore rules for Cursor files
└── README.md          # This file
```

## 🚀 Quick Start

### 1. Clone and Setup

```bash
# Clone this repository to your home directory
git clone https://github.com/gullitmiranda/.cursor

# Navigate to your project directory
cd .cursor

# make a backup of the existing .cursor directory
mv ~/.cursor ~/.cursor.backup

# Create symbolic link to .cursor
ln -s $PWD/.cursor ~/.cursor
```

### 2. Configure Cursor

1. Open Cursor in your project directory
2. The settings will be automatically detected from the `.cursor/` folder
3. Customize the commands and rules as needed for your project

### 3. Start Using Commands

```bash
# In Cursor chat, try these commands:

# Git workflow
/git-branch feature/user-auth    # Create feature branch
/git-status                      # Check repository status
/commit                          # Smart commit with conventional format
/commit --all                    # Stage and commit all changes
/commit --main                   # Emergency fix to main branch
/pr                              # Create pull request

# Kubernetes operations
/k8s-check pods                  # Safe resource inspection
/k8s-validate deployment.yaml   # Validate manifests
/k8s-diff deployment.yaml       # Preview changes

# Planning and workspace
/plan "Add authentication"       # Create project plan
/workspace-status               # Check multi-repo workspace
```

## 📋 Available Commands

### Git Commands

| Command       | Description                                  | Usage                                        |
| ------------- | -------------------------------------------- | -------------------------------------------- |
| `/commit`     | Smart git commit with conventional format    | `/commit`, `/commit --all`, `/commit --main` |
| `/git-branch` | Safe branch creation with naming conventions | `/git-branch feature/auth`                   |
| `/git-reset`  | Safe git reset with automatic backup         | `/git-reset --soft HEAD~1`                   |
| `/git-status` | Multi-repository status check                | `/git-status`                                |

### Pull Request Commands

| Command        | Description                             | Usage                         |
| -------------- | --------------------------------------- | ----------------------------- |
| `/pr`          | Create pull request with auto-detection | `/pr` or `/pr "custom title"` |
| `/pr check`    | Validate PR quality and completeness    | `/pr check`                   |
| `/pr validate` | Alternative to `/pr check`              | `/pr validate`                |
| `/pr review`   | Alternative to `/pr check`              | `/pr review`                  |
| `/pr ready`    | Mark PR ready for review                | `/pr ready`                   |

### Kubernetes Commands

| Command         | Description                         | Usage                           |
| --------------- | ----------------------------------- | ------------------------------- |
| `/k8s-check`    | Safe Kubernetes resource inspection | `/k8s-check pods`               |
| `/k8s-validate` | Kubernetes manifest validation      | `/k8s-validate deployment.yaml` |
| `/k8s-diff`     | Kubernetes deployment diff preview  | `/k8s-diff deployment.yaml`     |

### Planning Commands

| Command             | Description                             | Usage                     |
| ------------------- | --------------------------------------- | ------------------------- |
| `/plan`             | Create project plan with task breakdown | `/plan "Add auth system"` |
| `/workspace-status` | Multi-repository workspace overview     | `/workspace-status`       |

## 🛡️ Safety Hooks

This repository includes 5 safety hooks that automatically protect against dangerous operations:

| Hook                         | Event                  | Protection                                        |
| ---------------------------- | ---------------------- | ------------------------------------------------- |
| `block-dangerous-kubectl.sh` | `beforeShellExecution` | Blocks `kubectl delete` and `kubectl apply`       |
| `block-git-push-main.sh`     | `beforeShellExecution` | Blocks direct pushes to main/master branches      |
| `block-git-reset-hard.sh`    | `beforeShellExecution` | Blocks destructive `git reset --hard`             |
| `check-branch-protection.sh` | `afterFileEdit`        | Warns about edits on main/master branches         |
| `suggest-safe-commands.sh`   | `beforeSubmitPrompt`   | Suggests safe alternatives for dangerous commands |

## 📋 Development Rules

The repository includes 4 comprehensive rule files:

- **`rules/safety.md`** - Git safety, command safety, and data safety rules
- **`rules/quality.md`** - Code quality, quality gates, and documentation standards
- **`rules/workflow.md`** - Language, terminal, workspace, and branch management rules
- **`rules/integration.md`** - Linear, GitHub, and MCP integration guidelines

## 🛠️ Customization

### Adding New Commands

1. Create a new `.md` file in the `commands/` directory
2. Follow the existing command format with proper sections:
   - `<task>` - Command description
   - `<context>` - Rules and constraints
   - `<workflow>` - Step-by-step process
   - `<safety_checks>` - Safety validations
   - `<example_usage>` - Usage examples

For more details on Cursor agent capabilities, see:

- [Cursor Agent Overview](https://cursor.com/docs/agent/overview)
- [Cursor Agent Hooks](https://cursor.com/docs/agent/hooks)

### Modifying Existing Commands

1. Edit the relevant `.md` file in `commands/`
2. Test your changes in a development environment
3. Update documentation if needed
4. Commit changes with conventional commit format

### Project-Specific Rules

Create a `.cursor/rules.md` file in your project to add project-specific rules that complement the base commands.

## 📚 Documentation

- [Commands Documentation](docs/commands.md) - Detailed command reference
- [Rules Documentation](docs/rules.md) - Rules and guidelines
- [Hooks Documentation](docs/hooks.md) - Safety hooks and automation
- [Examples](examples/) - Usage examples and templates
- [Contributing](CONTRIBUTING.md) - How to contribute to this repository

## 🔧 Configuration Files

### `.gitignore`

Excludes Cursor-specific files that shouldn't be shared:

- Local extensions
- Interpreter notebooks
- IDE state files
- Personal configuration files

### Command Files

Each command is defined in a separate `.md` file with structured sections for:

- Task definition
- Context and rules
- Workflow steps
- Safety checks
- Usage examples

## 🎯 Features

### Smart Git Integration

- **Conventional Commits**: Automatic detection and formatting
- **Branch Safety**: Prevents commits to main/master
- **Linear Integration**: Auto-linking with Linear issues
- **Quality Gates**: Pre-commit validation

### Pull Request Automation

- **Auto-Detection**: Analyzes changes to generate PR titles
- **Quality Checks**: Runs tests, linting, and build validation
- **Template Support**: Uses GitHub PR templates
- **Reviewer Assignment**: Smart reviewer suggestions

### Safety First

- **Destructive Operation Prevention**: Blocks dangerous git operations
- **Validation Gates**: Multiple quality checkpoints
- **Backup Creation**: Automatic backups before risky operations
- **Clear Feedback**: Detailed status reports

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Development Workflow

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Make your changes
4. Test thoroughly
5. Commit with conventional format: `feat: add new command`
6. Create a pull request

## 📖 References

- [Cursor Agent Overview](https://cursor.com/docs/agent/overview)
- [Cursor Rules Documentation](https://cursor.com/docs/context/rules#how-rules-work)
- [Cursor Commands Documentation](https://cursor.com/docs/agent/chat/commands)
- [Cursor Agent Hooks](https://cursor.com/docs/agent/hooks)
- [Conventional Commits](https://www.conventionalcommits.org/)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

If you encounter issues or have questions:

1. Check the [documentation](docs/)
2. Look at [examples](examples/)
3. Search existing [issues](https://github.com/gullitmiranda/.cursor/issues)
4. Create a new issue with detailed information

---

**Happy Coding! 🚀**
