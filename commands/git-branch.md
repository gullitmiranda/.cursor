# Git Branch Command

## Description

Safe branch creation following project conventions and best practices.

## Workflow

1. Create feature branches from main/master unless specified otherwise
2. Use descriptive branch names following project conventions
3. Ensure branch is created from correct base branch
4. Switch to new branch after creation
5. Provide feedback on branch naming and setup

## Naming Conventions

- `feature/description` - New features
- `fix/description` - Bug fixes
- `chore/description` - Maintenance tasks
- `hotfix/description` - Critical fixes
- `docs/description` - Documentation updates
- `refactor/description` - Code refactoring
- `test/description` - Test improvements

## Examples

```bash
# Create feature branch
/git-branch feature/user-authentication

# Create fix branch
/git-branch fix/login-bug

# Create chore branch
/git-branch chore/update-dependencies
```

## Safety Features

- Prevents creation of branches with invalid names
- Validates base branch exists
- Checks for existing branch conflicts
- Provides naming suggestions if invalid

## Integration

- Works with Linear issue references
- Integrates with PR creation workflow
- Supports multi-repository workspaces
