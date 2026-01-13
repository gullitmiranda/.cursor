# Linear Create Issue

## Overview

Create a new Linear issue using Linearis CLI with intelligent inference for labels and priority.

## Steps

1. **Parse Arguments**:
   - Extract title from arguments (required)
   - Extract description (optional)
   - Extract team (default: PLTFRM)
   - Extract project (optional)
   - Extract labels (optional, or auto-detect)
   - Extract priority (optional, or auto-detect)
   - Extract status (default: Backlog)

2. **Auto-Detect Labels from Title**:
   - `feat:`, `feat(`, `feature` → Label: Feature
   - `fix:`, `fix(`, `bug` → Label: Bug
   - `chore:`, `chore(` → Label: Chore
   - `docs:`, `docs(` → Label: Docs
   - `refactor:`, `refactor(` → Label: Improvement

3. **Auto-Detect Priority from Keywords**:
   - `urgent`, `critical`, `broken`, `production` → Priority 1 (Urgent)
   - `important`, `high`, `asap` → Priority 2 (High)
   - Default → Priority 3 (Normal)
   - `low`, `minor`, `nice-to-have` → Priority 4 (Low)

4. **Create Issue with Linearis CLI**:

   ```bash
   linearis issues create "Title" \
     --team PLTFRM \
     --status Backlog \
     -a me \
     -d "Description" \
     --labels "Label1,Label2" \
     -p 3
   ```

5. **Parse JSON Response**:
   - Extract issue identifier (e.g., PLTFRM-123)
   - Extract issue URL
   - Extract issue title

6. **Generate Output**:
   - Display created issue details
   - Provide full markdown URL for references

## Default Settings

| Setting | Default | Notes |
|---------|---------|-------|
| Team | PLTFRM | Self Driven Platform |
| Status | Backlog | Use `/linear-triage` for Triage |
| Assignee | me | Current user |
| Priority | 3 (Normal) | Unless detected from keywords |
| Labels | Auto-detected | Based on title prefix |

## Output Format

```markdown
## Issue Created

**Issue**: [PLTFRM-123: Issue Title](https://linear.app/cloudwalk/issue/PLTFRM-123/issue-slug)
**Team**: Self Driven Platform
**Status**: Backlog
**Priority**: Normal (3)
**Labels**: Feature
**Assignee**: @me

### Use in Commits/PRs

```
Closes [PLTFRM-123: Issue Title](https://linear.app/cloudwalk/issue/PLTFRM-123/issue-slug)
```
```

## Examples

```bash
# Basic issue (auto-detects Feature label)
/linear-create "feat: add user authentication"

# Issue with description
/linear-create "fix: login timeout" "Users are experiencing timeouts after 30 seconds"

# Issue with explicit options
/linear-create "chore: update dependencies" --priority 4 --labels "Chore,maintenance"

# Issue in specific project
/linear-create "feat: new dashboard" --project "Q1 2025"

# Urgent issue (auto-detects priority 1)
/linear-create "fix: critical production bug breaking payments"
```

## Arguments

Arguments: $ARGUMENTS

- First argument: Issue title (required)
- Second argument: Issue description (optional)
- `--team`: Team key (default: PLTFRM)
- `--project`: Project name or ID
- `--labels`: Comma-separated labels
- `--priority` or `-p`: Priority 1-4
- `--status`: Status name (default: Backlog)

## Safety Checks

- ✅ Always use PLTFRM team unless explicitly specified
- ✅ Always set status to Backlog (not Triage/Todo)
- ✅ Always assign to current user
- ✅ Auto-detect labels and priority when not specified
- ✅ Generate full markdown URL for issue reference
- ❌ Never create issue without a title
