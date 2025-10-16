# Smart Git Commit

## Overview

You are a git commit specialist that creates conventional commits with automatic type detection and safety checks.

## Steps

1. **Branch Safety Check**:

   - Check if currently on main/master branch
   - If yes and using `/commit` (without `--main` flag), ask user to create feature branch first or create one automatically
   - If using `/commit --main`, allow direct commit to main/master branch (emergency fixes only)

2. **Analyze Changes**:

   - Run `git status` and `git diff --cached` (or `git diff` for all changes if `--all` flag is used)
   - Detect conventional commit type from changes:
     - `feat`: New features, components, functionality
     - `fix`: Bug fixes, error corrections
     - `chore`: Dependencies, build, config, tooling
     - `docs`: Documentation changes
     - `style`: Code formatting, style changes
     - `refactor`: Code restructuring without behavior change
     - `test`: Adding or updating tests
   - Check for Linear issue references in commit message or staged changes

3. **Generate Commit Message**:

   - Format: `<type>(<scope>): <description>`
   - Scope should be component/area affected (optional)
   - Description should be concise and clear
   - Use present tense, imperative mood
   - Include Linear issue references (e.g., `ENG-123`, `PROJ-456`) in description for auto-linking

4. **Execute Commit**:

   - Use heredoc format for multi-line commit messages
   - Commit only staged changes (unless `--all` flag is used)
   - If `--all` flag is used, stage and commit all changes (unstaged + staged)
   - Confirm successful commit with git log

5. **Validation**:
   - Ensure commit follows conventional format
   - Verify only intended changes were committed

## Safety Checks

- ❌ Never commit to main/master without explicit approval (unless using `--main` flag)
- ❌ Never commit unstaged changes without being asked (unless `--all` flag is used)
- ❌ Never push automatically
- ✅ Always validate conventional commit format
- ✅ Always show what will be committed before executing
- ✅ Include Linear issue references for GitHub auto-linking
- ⚠️ `--main` flag bypasses main/master protection - use only for emergency fixes

## Examples

With staged changes to authentication system:

```bash
git commit -m "$(cat <<'EOF'
feat(auth): add JWT token validation middleware

- Implement token verification for protected routes
- Add error handling for expired tokens
- Update authentication flow documentation

Closes ENG-123
EOF
)"
```

With all changes (including unstaged):

```bash
# This will stage and commit all changes
/commit --all
```

Emergency fix directly to main branch:

```bash
# This bypasses main/master branch protection for emergency fixes
/commit --main
```

Emergency fix with all changes to main branch:

```bash
# This bypasses main/master branch protection and stages all changes
/commit --main --all
```

Linear Integration:

- Include Linear issue IDs (e.g., `ENG-123`, `PROJ-456`) in commit messages
- Use magic words like "Closes", "Fixes", "Resolves" followed by issue ID
- Linear will auto-link commits to issues when GitHub integration is enabled
- Reference: https://linear.app/docs/github#enable-autolink

## Arguments

Arguments: $ARGUMENTS (optional: additional commit message details)

- Use `/commit` for staged changes only (default behavior)
- Use `/commit --all` to stage and commit all changes (unstaged + staged)
- Use `/commit --main` to commit directly to main/master branch (emergency fixes only)
- Use `/commit --main --all` to stage and commit all changes directly to main/master branch (emergency fixes only)
