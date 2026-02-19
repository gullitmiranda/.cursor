# My ~/.cursor settings

A comprehensive collection of Cursor AI editor settings, commands, and rules designed for professional development workflows. This repository contains reusable configurations that can be shared across teams and projects.

**Important:** This repository **is** your **user-level** Cursor config. When you clone it and symlink it as `~/.cursor`, the paths in this repo (e.g. `skills/`, `hooks/`, `examples/`) are the contents of `~/.cursor`. We use **skills** and **commands** (`commands/`), not `.cursor/rules/` in this repo; project-level `.cursor/rules/` in other repos are legacy/optional. See [Rules documentation](docs/rules.md#skills-are-canonical-no-cursorrules-in-this-repo) for the distinction.

## 📁 Repository Structure

```
.cursor/   (this repo = ~/.cursor when symlinked)
├── commands/           # Slash commands (→ ~/.cursor/commands/; appear in Cursor's / menu)
├── skills/            # Agent Skills (canonical source; Cursor loads these)
│   ├── safety/       # Git, command, k8s, data, workspace safety
│   ├── workflow/     # Language, branch, commit, PR, planning workflow
│   ├── integration/  # Linear, GitHub, Trunk, MCP integration
│   ├── quality/      # Code quality, gates, docs, character hygiene
│   ├── linear/       # Linear rules + all Linear CLI commands
│   ├── git/          # commit, git-branch, git-reset, git-status
│   ├── k8s/          # k8s-check, k8s-validate, k8s-diff
│   ├── pr/           # Pull request create, check, ready
│   ├── plan/         # Project plan creation
│   ├── workspace-status/
│   └── persist-agent-constraints/
├── backups/          # Backups (if needed)
├── hooks/            # Safety hooks (5 hooks)
├── docs/             # Detailed documentation
├── examples/         # Usage examples and templates
├── plans/            # Migration and project plans
├── .gitignore
├── CHANGELOG.md
└── README.md
```

**Skills** in `.cursor/skills/` are loaded by Cursor as user-level skills (this repo is `~/.cursor`). You do not need to copy content into Cursor's User Rules; the agent uses the skills automatically when relevant. If you previously pasted rules into User Rules, you can clear that field in Cursor Settings after confirming skills work.

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
3. Customize the skills in `skills/` as needed for your project

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
/learn "In this repo, we use pnpm."  # Persist a project rule (AGENTS.md + .claude shim)

# Kubernetes operations
/k8s-check pods                  # Safe resource inspection
/k8s-validate deployment.yaml   # Validate manifests
/k8s-diff deployment.yaml       # Preview changes

# Planning and workspace
/plan "Add authentication"       # Create project plan
/workspace-status               # Check multi-repo workspace
/gremlin-clean                  # Strip invisible/gremlin Unicode from current file or paths
```

## 📋 Available Commands

### Git Commands

| Command       | Description                                  | Usage                                        |
| ------------- | -------------------------------------------- | -------------------------------------------- |
| `/commit`     | Smart git commit with auto-branch creation   | `/commit`, `/commit --all`, `/commit --main` |
| `/git-branch` | Safe branch creation with naming conventions | `/git-branch feature/auth`                   |
| `/git-reset`  | Safe git reset with automatic backup         | `/git-reset --soft HEAD~1`                   |
| `/git-status` | Multi-repository status check                | `/git-status`                                |

### Learning Commands

| Command  | Description                                            | Usage              |
| -------- | ------------------------------------------------------ | ------------------ |
| `/learn` | Persist rules with scope: project, project-local, user | `/learn "rule..."` |

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

## 📋 Skills (Rules + Commands)

Behavior is defined by **Agent Skills** in `.cursor/skills/`. Each skill has a `SKILL.md` with when to use it and the full instructions. Cursor loads these automatically; no need to paste anything into User Rules.

| Skill                | Purpose                                                        |
| -------------------- | -------------------------------------------------------------- |
| **safety**           | Git, command, k8s, data, workspace safety                      |
| **workflow**         | Language, branch, commit, PR, planning workflow                |
| **integration**      | Linear, GitHub, Trunk, MCP integration                         |
| **quality**          | Code quality, gates, docs, character hygiene                   |
| **linear**           | Linear rules + create/update/list/triage/view/project commands |
| **git**              | commit, git-branch, git-reset, git-status                      |
| **k8s**              | k8s-check, k8s-validate, k8s-diff                              |
| **pr**               | Create PR, validate, mark ready for review                     |
| **plan**             | Create/update project plans in .cursor/plans/                  |
| **workspace-status** | Multi-repo workspace overview                                  |

To change behavior, edit the corresponding `skills/<name>/SKILL.md` file. Skills are the only source; previous `rules/` and `commands/` content was removed and is preserved in git history.

## 🛠️ Customization

### Adding or Changing Skills

1. Edit or create `skills/<skill-name>/SKILL.md`
2. Use YAML frontmatter: `name`, `description` (clear "Use when..." so the agent loads the skill when context matches)
3. Keep content in one place; Cursor loads from `.cursor/skills/` (this repo is `~/.cursor`)

For more details on Cursor agent capabilities, see:

- [Cursor Agent Overview](https://cursor.com/docs/agent/overview)
- [Cursor Agent Hooks](https://cursor.com/docs/agent/hooks)

### Slash commands vs skills

**Slash commands** (e.g. `/gremlin-clean`, `/quality`) must be defined in **`commands/*.md`** in this repo (→ `~/.cursor/commands/`) so they appear in Cursor's command list. The content of each file is the instruction sent when the user runs that command. Do not define new commands only inside skill text—add a `.md` file under `commands/` as well.

### Project-specific rules (optional)

Projects can add their own `.cursor/rules/` or `AGENTS.md`; we treat that as optional. Our canonical source is skills and commands in this repo.

## 📚 Documentation

- [Commands Documentation](docs/commands.md) - Detailed command reference
- [Rules Documentation](docs/rules.md) - Rules and guidelines
- [Hooks Documentation](docs/hooks.md) - Safety hooks and automation
- [Gremlin characters (Cursor/LLM)](docs/gremlin-characters-cursor-llm.md) - Why invisible Unicode appears and what to do
- [Examples](examples/) - Usage examples and templates
- [Changelog](CHANGELOG.md) - Recent changes and updates
- [Contributing](CONTRIBUTING.md) - How to contribute to this repository

## 🔧 Configuration Files

### `.gitignore`

Excludes Cursor-specific files that shouldn't be shared:

- Local extensions
- Interpreter notebooks
- IDE state files
- Personal configuration files

### Skill Files

Each skill is a `SKILL.md` file with YAML frontmatter (`name`, `description`) and markdown instructions. The agent loads skills when the context matches the description (e.g. when you discuss commits, the git skill applies).

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
