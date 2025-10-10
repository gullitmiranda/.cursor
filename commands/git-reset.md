# Git Reset Command

## Description

Safe reset with automatic backup and recovery options.

## Workflow

1. Create backup/stash before any destructive operations
2. Use git status and git log to understand current state
3. Offer different reset options (soft, mixed, hard) with explanations
4. Always confirm before executing destructive operations
5. Provide recovery instructions if something goes wrong

## Reset Types

- **Soft**: Keep changes in staging area
- **Mixed**: Keep changes in working directory (default)
- **Hard**: Discard all changes (destructive)

## Safety Measures

- Always stash uncommitted changes first
- Never run without understanding current state
- Require explicit user approval for --hard reset
- Create automatic backups before destructive operations
- Provide recovery instructions

## Examples

```bash
# Safe soft reset
/git-reset --soft HEAD~1

# Safe mixed reset (default)
/git-reset HEAD~1

# Safe hard reset with confirmation
/git-reset --hard HEAD~1

# Reset to specific commit
/git-reset --soft abc1234
```

## Backup Strategy

- Create stash before destructive operations
- Save current state information
- Provide rollback instructions
- Document what will be lost

## Recovery Options

- Restore from stash
- Recover from backup
- Use git reflog for commit recovery
- Provide step-by-step recovery guide

## Integration

- Works with multi-repository workspaces
- Integrates with branch protection
- Supports Linear issue references
- Compatible with PR workflow
