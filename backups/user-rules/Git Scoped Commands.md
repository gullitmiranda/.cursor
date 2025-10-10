# Git Scoped Commands

## /git-commit

**Description**: Smart commit with automatic conventional commit detection and formatting

**Workflow**:

1. Check if currently on main/master branch - if yes, create feature branch first
2. Analyze staged changes to detect conventional commit type (feat, fix, chore, etc.)
3. Format commit message as: `<type>(<scope>): <description>`
4. Validate commit message against conventional commit standards
5. Commit only staged changes by default
6. Provide feedback on commit format and suggest improvements

**Safety checks**:

- Never commit directly to main/master
- Only commit staged changes
- Require conventional commit format

---

## /git-branch

**Description**: Safe branch creation following project conventions

**Workflow**:

1. Create feature branches from main/master unless specified otherwise
2. Use descriptive branch names following project conventions
3. Ensure branch is created from correct base branch
4. Switch to new branch after creation
5. Provide feedback on branch naming and setup

**Naming conventions**:

- `feature/description`
- `fix/description`
- `chore/description`
- `hotfix/description`

---

## /git-status

**Description**: Multi-repository aware status check

**Workflow**:

1. Check current working directory and understand repository boundaries
2. Never assume single git repository in multi-repo workspace
3. Identify which specific repository changes belong to
4. Show status for current repo and detect other repos in workspace
5. Provide clear indication of which repo each change belongs to

---

## /git-reset

**Description**: Safe reset with automatic backup

**Workflow**:

1. Create backup/stash before any destructive operations
2. Use git status and git log to understand current state
3. Offer different reset options (soft, mixed, hard) with explanations
4. Always confirm before executing destructive operations
5. Provide recovery instructions if something goes wrong

**Safety measures**:

- Always stash uncommitted changes first
- Never run without understanding current state
- Require explicit user approval for --hard reset

---

## /git-review

**Description**: Review recent commits and validate formatting

**Workflow**:

1. Check conventional commit format in recent commits
2. Validate that changes are properly staged and committed
3. Show commit history with formatting analysis
4. Suggest improvements for non-standard commit messages
5. Verify branch is ready for PR creation
