## Core Rules

### Language

- By default always write documentation, comments and code in English

### Integrated Terminal

- Always use the default shell (zsh)
- Prefer terminal commands over GUI operations when possible

### Temporary Files Management

- When creating temporary files, use temporary directories (`./tmp` or system tmp)
- Automatically clean up temporary files after use
- Never commit temporary files to version control

## Workspace & Multi-Repository Rules

### Workspace Structure Awareness

- Always check current working directory and understand repository boundaries
- Never assume single git repository when working in multi-repo workspace
- Always verify which repository operations are targeting before execution

### Multi-Repository Handling

- When working with staged changes, identify which specific repository they belong to
- Navigate to correct repository directory before running git operations
- Treat each repository as separate entity with its own git state

### Error Prevention

- Always ask for clarification when workspace structure is unclear
- Confirm target repository before running git commands
- Use non-destructive commands first (git stash, git log) to understand situation

## Git Safety Rules

### Absolute Rules (Cannot be broken)

- Do not commit unless explicitly requested
- Do not push unless explicitly requested
- Never commit to main/master branch unless explicitly requested
- Never run `git reset --hard` without explicit user approval

### Core Safety Guidelines

- Do not change git stage without being asked
- Do not make commits without reviews unless explicitly requested
- When asked to commit, commit only staged changes by default
- Always use [Conventional Commits](https://www.conventionalcommits.org/) style
- Always create backups or stashes before attempting to "fix" git issues
- Use `git status` and `git log` to understand current state before making changes

## Available Slash Commands

### Git Commands (Scoped: /git-)

- `/git-commit` - Smart commit with conventional commit formatting
- `/git-branch` - Safe branch creation following conventions
- `/git-status` - Multi-repository aware status check
- `/git-reset` - Safe reset with automatic backup
- `/git-review` - Review commits and validate formatting

### PR Commands (Scoped: /pr-)

- `/pr-create` - Complete PR creation workflow with templates
- `/pr-validate` - Validate PR format and completeness
- `/pr-prepare` - Full preparation workflow (test + commit + PR)
- `/pr-ready` - Mark PR as ready for review

### Kubernetes Commands (Scoped: /k8s-)

- `/k8s-check` - Safe resource inspection without changes
- `/k8s-validate` - Validate manifests without applying
- `/k8s-diff` - Preview changes without applying

### Global Commands

- `/plan` - Create or update project plan in .cursor/plans/
- `/workspace-status` - Multi-repository workspace status overview

## Security & Safety Hooks

### Blocked Commands (Automatic Prevention)

- `kubectl delete` - Use `/k8s-check` instead
- `kubectl apply` - Use `/k8s-validate` and `/k8s-diff` instead
- `git reset --hard` - Use `/git-reset` instead
- Direct pushes to main/master - Create PRs with `/pr-create` instead

### Pre-commit Validations

- Conventional commit format validation
- Branch protection (prevents direct commits to main/master)
- Staged changes verification

## Planning Rules

When building plans:

- Always create or update plan file in `.cursor/plans/` folder
- Use clear, actionable task breakdown
- Don't add time estimation unless requested
- Format as markdown with clear sections
- Include dependencies and acceptance criteria

## Command Usage Guidelines

1. **Use scoped commands** for organized workflows
2. **Follow safety-first approach** - commands include built-in validations
3. **Leverage hooks** for automatic prevention of dangerous operations
4. **Multi-repo awareness** - commands understand workspace boundaries
5. **Conventional commits** - automatic formatting and validation
