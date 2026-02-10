# Commands Documentation

This document provides detailed information about all available Cursor commands in this repository.

> **Note:** Command behavior is implemented as **Agent Skills** in `.cursor/skills/` (git, k8s, linear, pr, plan, workspace-status). Skills are the canonical source; original command files were removed and are in git history. This doc remains as reference.

## 📋 Command Overview

| Command         | Category | Description                                  | Complexity |
| --------------- | -------- | -------------------------------------------- | ---------- |
| `/commit`       | Git      | Smart git commit with conventional format    | Medium     |
| `/pr`           | GitHub   | Create pull request with quality checks      | High       |
| `/pr check`     | GitHub   | Validate PR quality and completeness         | Medium     |
| `/pr ready`     | GitHub   | Mark PR ready for review                     | Low        |
| `/linear-issue` | Linear   | Create, list, view, and update Linear issues | Medium     |

## 🔧 Git Commands

### `/commit` - Smart Git Commit

**Purpose**: Automatically creates conventional commits with safety checks and Linear integration.

**Features**:

- Automatic commit type detection (feat, fix, chore, etc.)
- Branch safety (prevents commits to main/master)
- **Auto branch creation** when on main/master branch
- Linear issue auto-linking
- Staged changes validation
- Conventional commit format enforcement

**Usage**:

```bash
# Commit staged changes only (default)
/commit

# Stage and commit all changes
/commit --all

# Emergency fix directly to main branch
/commit --main

# Emergency fix with all changes to main branch
/commit --main --all

# With additional message details
/commit "Add error handling for edge cases"
```

**Safety Checks**:

- ✅ Never commits to main/master branch (unless using `--main` flag)
- ✅ **Automatically creates feature branch** when on main/master
- ✅ Only commits staged changes by default (unless using `--all` flag)
- ✅ Validates conventional commit format
- ✅ Creates backups before destructive operations
- ⚠️ `--main` flag bypasses main/master protection - use only for emergency fixes

**Examples**:

```bash
# Feature commit
feat(auth): add JWT token validation middleware

# Bug fix commit
fix(api): resolve CORS error in authentication endpoint

# Chore commit
chore(deps): update dependencies to latest versions
```

### Command Workflow

1. **Branch Safety Check**

   - Verifies not on main/master branch
   - **If on main/master**: Automatically creates feature branch based on changes
   - Creates feature branch if needed

2. **Change Analysis**

   - Runs `git status` and `git diff --cached`
   - Detects commit type from changes
   - Identifies affected components

3. **Message Generation**

   - Formats as `<type>(<scope>): <description>`
   - Includes Linear issue references
   - Uses present tense, imperative mood

4. **Execution**
   - Commits only staged changes (unless `--all` flag is used)
   - Validates conventional format
   - Confirms successful commit

## 🚀 Pull Request Commands

### `/pr` - Create Pull Request

**Purpose**: Creates GitHub pull requests with automatic title generation and quality checks.

**Features**:

- Automatic PR title generation from commits
- Quality gate validation (tests, linting, build)
- GitHub PR template support
- Linear issue integration
- Smart reviewer assignment

**Usage**:

```bash
# Create PR with auto-detected title
/pr

# Create PR with custom title
/pr "feat(auth): add OAuth2 integration"

# Create PR with specific base branch
/pr --base develop
```

**Workflow**:

1. **Pre-flight Checks**

   - Verifies feature branch (not main/master)
   - Checks for commits ahead of base
   - Ensures branch is pushed to remote

2. **Change Analysis**

   - Analyzes commit history
   - Identifies primary change type
   - Determines affected scope

3. **Title Generation**

   - Uses conventional commit format
   - Summarizes overall changes
   - Keeps under 72 characters

4. **Description Building**

   - Uses GitHub PR template if available
   - Generates summary from commits
   - Adds test plan checklist
   - Includes Linear issue links

5. **PR Creation**
   - Uses `gh pr create` with proper formatting
   - Sets appropriate base branch
   - Returns PR URL for reference

### `/pr check` - PR Validation

**Purpose**: Validates PR quality, completeness, and readiness for review.

**Features**:

- Comprehensive quality gate checks
- CI/CD status verification
- PR metadata validation
- Content quality assessment

**Usage**:

```bash
# Run all validation checks
/pr check

# Alternative commands (same functionality)
/pr validate
/pr review
```

**Quality Gates**:

1. **Project Quality Checks**

   - Tests (auto-detected from project structure)
   - Linting (eslint, prettier, etc.)
   - Build validation
   - Security scans

2. **PR Quality Validation**

   - Title format (conventional commits)
   - Description completeness
   - Metadata (assignees, labels, reviewers)
   - CI/CD status

3. **Content Quality**
   - Commit message format
   - Change focus and relevance
   - No WIP or debugging commits

### `/pr ready` - Mark Ready for Review

**Purpose**: Marks PR as ready for review with proper setup and validation.

**Features**:

- Removes draft status
- Assigns appropriate reviewers
- Applies relevant labels
- Validates readiness criteria

**Usage**:

```bash
# Mark PR ready for review
/pr ready

# With specific reviewers
/pr ready --reviewers @user1,@user2

# With priority level
/pr ready --priority high
```

**Workflow**:

1. **Status Check**

   - Verifies PR exists and is accessible
   - Checks current status (draft, open, etc.)
   - Confirms branch association

2. **Quality Validation**

   - Runs validation checks
   - Ensures template completion
   - Verifies conventional commit format

3. **CI/CD Verification**

   - Checks all required checks
   - Waits for in-progress checks
   - Identifies blocking issues

4. **Reviewer Assignment**

   - Detects reviewers from CODEOWNERS
   - Suggests based on changed files
   - Assigns PR to author

5. **Ready Status Update**
   - Removes draft status
   - Applies "ready-for-review" label
   - Adds change-type labels
   - Updates PR status

## 🔍 Quality Gates

### Project Detection

Commands automatically detect project type and quality check commands:

**Node.js Projects**:

```bash
npm test          # Tests
npm run lint      # Linting
npm run build     # Build
npm audit         # Security
```

**Python Projects**:

```bash
pytest            # Tests
flake8            # Linting
python -m build   # Build
pip-audit         # Security
```

**Rust Projects**:

```bash
cargo test        # Tests
cargo clippy      # Linting
cargo build       # Build
cargo audit       # Security
```

### Documentation-Based Detection

Commands look for quality check commands in:

1. `CONTRIBUTING.md`
2. `.github/CONTRIBUTING.md`
3. `README.md`
4. Auto-detection based on project structure

## 🛡️ Safety Features

### Git Safety

- **Branch Protection**: Prevents commits to main/master
- **Staged Changes Only**: Only commits staged changes by default
- **Backup Creation**: Creates stashes before destructive operations
- **Validation**: Validates commit format before execution

### PR Safety

- **Quality Gates**: Multiple validation checkpoints
- **CI/CD Verification**: Ensures all checks pass
- **Reviewer Assignment**: Prevents PRs without reviewers
- **Template Compliance**: Ensures proper PR formatting

### Error Handling

- **Clear Error Messages**: Descriptive error output
- **Recovery Instructions**: Steps to fix issues
- **Rollback Options**: Safe ways to undo changes
- **Validation Feedback**: Detailed validation reports

## 📋 Linear Issue Commands

### `/linear-issue` - Linear Issue Management

**Purpose**: Manages Linear issues throughout their lifecycle: creation, listing, viewing, updating, and commenting.

**Features**:

- Create issues with automatic defaults (PLTFRM team, assignee "me", status "Todo")
- List issues with advanced filtering
- View detailed issue information
- Update issue fields (status, priority, assignee, labels, etc.)
- Add comments to issues
- Auto-detect issue type from title/description
- Generate proper Linear URLs for references

**Usage**:

```bash
# Create basic issue
/linear-issue "feat(auth): add JWT token validation"

# Create issue with description
/linear-issue "fix(api): resolve timeout" "The API times out after 30s. Need retry logic."

# List my issues
/linear-issue list

# View issue details
/linear-issue view PLTFRM-123

# Update issue status
/linear-issue update PLTFRM-123 --status "In Progress"

# Add comment
/linear-issue comment PLTFRM-123 "Ready for review"
```

**Default Settings**:

- **Team**: Self Driven Platform (PLTFRM) - default
- **Alternative Team**: Platform ICEBOX (PLAI) - only if explicitly requested
- **Assignee**: me (current user)
- **Status**: Todo
- **Priority**: Auto-detected based on issue type
- **Labels**: Auto-assigned based on content analysis

**Subcommands**:

1. **Create**: `/linear-issue "title"` or `/linear-issue create "title"`
2. **List**: `/linear-issue list [--filters]`
3. **View**: `/linear-issue view PLTFRM-123` or `/linear-issue get PLTFRM-123`
4. **Update**: `/linear-issue update PLTFRM-123 [--fields]`
5. **Status**: `/linear-issue status PLTFRM-123 "In Progress"`
6. **Comment**: `/linear-issue comment PLTFRM-123 "Comment text"`

**Issue Reference Format**:

- **Format**: `PLTFRM-123`, `ENG-456`, `PROJ-789`
- **Enhanced Links**: `[PLTFRM-123: Issue Title](https://linear.app/cloudwalk/issue/PLTFRM-123/issue-slug)`
- **Usage**: PR descriptions, commit messages, documentation
- **Magic Words**: "Closes", "Fixes", "Resolves" for auto-linking in GitHub

**Workflow**:

1. **Create Issue**

   - Parse title and optional description
   - Apply default settings (team, assignee, status)
   - Auto-detect issue type and labels
   - Create issue via Linear MCP
   - Return issue URL and reference format

2. **List Issues**

   - Apply filters (assignee, team, status, label, query)
   - Retrieve issues via Linear MCP
   - Format as table with key information
   - Include Linear URLs

3. **View Issue**

   - Parse issue ID (supports PLTFRM-123 or 123 format)
   - Retrieve full issue details
   - Display description, status, assignee, comments
   - Show git branch name if available

4. **Update Issue**

   - Parse issue ID and update fields
   - Merge updates with existing data
   - Update via Linear MCP
   - Confirm changes

5. **Add Comment**
   - Parse issue ID and comment body
   - Support Markdown formatting
   - Support reply to existing comments
   - Create comment via Linear MCP

**Examples**:

```bash
# Create issue with all options
/linear-issue "feat(platform): add new feature" \
  --priority 2 \
  --labels "feature,backend" \
  --project "Q1 2024"

# List issues with filters
/linear-issue list --state "In Progress" --label "bug"

# Update multiple fields
/linear-issue update PLTFRM-123 \
  --status "Done" \
  --priority 0 \
  --labels "completed,verified"
```

## 🔗 Integration Features

### Linear Integration

- **Auto-linking**: Links commits to Linear issues
- **Issue References**: Includes issue IDs in commits
- **Magic Words**: Uses "Closes", "Fixes", "Resolves"
- **GitHub Sync**: Syncs with GitHub for PR visibility
- **Issue Management**: Create, list, view, and update issues via `/linear-issue` command

### GitHub Integration

- **PR Templates**: Uses GitHub PR templates
- **CODEOWNERS**: Respects CODEOWNERS file
- **Labels**: Applies appropriate labels
- **Reviewers**: Smart reviewer suggestions

## 📊 Output Formats

### Commit Output

```bash
✅ Commit created successfully
📝 Type: feat(auth)
📋 Message: add JWT token validation middleware
🔗 Linear: ENG-123
📊 Files: 3 changed, 15 insertions(+)
```

### PR Creation Output

```markdown
# 🚀 PR Created Successfully

**PR**: #123 - feat(auth): add JWT validation
**Branch**: feature/auth-jwt → main
**URL**: https://github.com/org/repo/pull/123
**Status**: Open

## 📝 Changes Summary

- 3 commits ahead of main
- 5 files changed
- Primary change type: feat
```

### Validation Output

```markdown
# 🔍 PR Validation Report

**PR**: #123 - feat(auth): add JWT validation
**Status**: ✅ Ready for Review

## ✅ Quality Gates

- **Tests**: ✅ Pass (12/12 passed)
- **Linting**: ✅ Pass
- **Build**: ✅ Pass
- **Security**: ✅ Pass

## 📊 Validation Results

- **Title Format**: ✅ Conventional commit format
- **Description**: ✅ Complete and informative
- **Metadata**: ✅ Assignees, labels, reviewers
- **CI/CD**: ✅ All checks passing
```

## 🚨 Troubleshooting

### Common Issues

**Commit Issues**:

- **"Cannot commit to main"**: Create feature branch first or use `/commit --main` for emergency fixes
- **"No staged changes"**: Use `/commit --all` or stage changes first
- **"Invalid commit format"**: Check conventional commit format

**PR Issues**:

- **"No commits ahead"**: Make commits before creating PR
- **"Branch not pushed"**: Push branch to remote first
- **"Quality checks failing"**: Fix issues before marking ready

**Validation Issues**:

- **"Tests failing"**: Run tests locally and fix issues
- **"Linting errors"**: Fix code style issues
- **"Build errors"**: Resolve compilation issues

### Debug Commands

```bash
# Check git status
git status

# Check commit history
git log --oneline -5

# Check PR status
gh pr view

# Check CI/CD status
gh pr checks
```

## 📚 Additional Resources

- [Cursor Agent Overview](https://cursor.com/docs/agent/overview)
- [Cursor Agent Hooks](https://cursor.com/docs/agent/hooks)
- [Cursor Commands Documentation](https://cursor.com/docs/agent/chat/commands)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Linear GitHub Integration](https://linear.app/docs/github#enable-autolink)
- [GitHub CLI Documentation](https://cli.github.com/)
