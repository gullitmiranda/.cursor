# Git Status Command

## Description

Multi-repository aware status check with comprehensive workspace analysis.

## Workflow

1. Check current working directory and understand repository boundaries
2. Never assume single git repository in multi-repo workspace
3. Identify which specific repository changes belong to
4. Show status for current repo and detect other repos in workspace
5. Provide clear indication of which repo each change belongs to

## Multi-Repository Handling

- When working with staged changes, identify which specific repository they belong to
- Provide clear indication of repository boundaries
- Show status for each repository found in workspace
- Highlight any cross-repository dependencies or conflicts

## Error Prevention

- Always ask for clarification when workspace structure is unclear
- Confirm target repository before running git commands
- Use non-destructive git commands first (git stash, git log) to understand situation

## Output Format

```
Repository: /path/to/repo1
  Branch: main
  Status: clean
  Staged: 2 files
  Modified: 1 file
  Untracked: 3 files

Repository: /path/to/repo2
  Branch: feature/new-feature
  Status: dirty
  Staged: 0 files
  Modified: 2 files
  Untracked: 0 files
```

## Examples

```bash
# Check current repository status
/git-status

# Check specific repository
/git-status /path/to/specific/repo

# Check all repositories in workspace
/git-status --all
```

## Safety Features

- Non-destructive operations only
- Clear repository identification
- Conflict detection and reporting
- Workspace boundary awareness
