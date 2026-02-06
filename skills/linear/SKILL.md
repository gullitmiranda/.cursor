---
name: linear
description: Linear integration with Linearis CLI - rules, team config, issue format, and all Linear operations (create, update, comment, list, triage, view, project create/plan). Use when creating or managing Linear issues, referencing issues in commits/PRs, or working with Linear projects.
disable-model-invocation: true
---
# Linear Integration Rules

## CLI Tool: Linearis

Use [Linearis CLI](https://github.com/czottmann/linearis) as the primary tool for Linear operations.

### Installation

```bash
mise use -g npm:linearis@2025.12.3
```

### Authentication

Linearis uses the `$LINEAR_API_TOKEN` environment variable for authentication.

### Why Linearis over MCP

- More stable than Linear MCP server (which frequently disconnects)
- JSON output for easy parsing
- No token overhead in LLM context
- Simple CLI commands via terminal

---

## Team Configuration

- **Default Team**: Self Driven Platform
  - Identifier: `PLTFRM`
  - ID: `94fb9928-3874-464a-9f3d-a354d3364f5c`
- **Alternative Team**: Platform ICEBOX
  - Identifier: `PLAI`
  - ID: `7357e730-4a1a-4f1a-8e53-f42a5077dbbd`
  - Use only when explicitly requested

> **IMPORTANT**: Always use PLTFRM as the issue team, unless explicitly requested otherwise.

---

## Default Settings

| Setting  | Default Value                 | Notes                                |
| -------- | ----------------------------- | ------------------------------------ |
| Team     | Self Driven Platform (PLTFRM) | Unless ICEBOX specifically requested |
| Assignee | me (current user)             | Auto-assign to creator               |
| Status   | **Backlog**                   | Not Triage or Todo                   |
| Priority | Based on inference            | See auto-detection rules             |
| Labels   | Based on inference            | See auto-detection rules             |

### Status Options

- **Backlog**: Default for new issues (planned work)
- **Triage**: Use `/linear-triage` or `--status Triage` for unplanned/incoming requests
- **Todo**: Ready to start
- **In Progress**: Currently being worked on
- **In Review**: Awaiting review
- **Done**: Completed
- **Canceled**: Will not be done

---

## Auto-Detection Rules

### Labels from Title Prefix

| Title Pattern                     | Label       |
| --------------------------------- | ----------- |
| `feat:`, `feat(`, `feature`       | Feature     |
| `fix:`, `fix(`, `bug`             | Bug         |
| `chore:`, `chore(`                | Chore       |
| `docs:`, `docs(`, `documentation` | Docs        |
| `refactor:`, `refactor(`          | Improvement |

### Priority from Keywords

| Keywords in Title/Description                | Priority   |
| -------------------------------------------- | ---------- |
| `urgent`, `critical`, `broken`, `production` | 1 (Urgent) |
| `important`, `high`, `asap`                  | 2 (High)   |
| (default)                                    | 3 (Normal) |
| `low`, `minor`, `nice-to-have`, `someday`   | 4 (Low)    |

---

## Issue Reference Format

### Always Use Full Markdown URLs

When referencing Linear issues in PR descriptions, commits, or documentation, always use the full markdown URL format:

```markdown
# Correct

Closes [PLTFRM-123: Issue Title](https://linear.app/cloudwalk/issue/PLTFRM-123/issue-slug)

# Avoid (less informative)

Closes PLTFRM-123
```

### Magic Words for Auto-Linking

- `Closes` - Closes the issue when PR is merged
- `Fixes` - Fixes the issue when PR is merged
- `Resolves` - Resolves the issue when PR is merged

---

## Linearis CLI Commands Reference

### Issues

```bash
# Create issue (use --status Backlog by default)
linearis issues create "Title" --team PLTFRM --status Backlog -a me

# Create with full options
linearis issues create "feat: new feature" \
  --team PLTFRM \
  --status Backlog \
  -a me \
  -d "Description here" \
  --labels "Feature" \
  -p 3 \
  --project "Project Name"

# Read issue details
linearis issues read PLTFRM-123

# Update issue
linearis issues update PLTFRM-123 --status "In Progress"

# List issues
linearis issues list --team PLTFRM --assignee me

# Search issues
linearis issues search "search query"
```

### Comments

```bash
# Add comment
linearis comments create PLTFRM-123 --body "Comment text"
```

### Projects

```bash
# List projects
linearis projects list

# List issues in project
linearis issues list --project "Project Name"
```

### Labels

```bash
# List available labels
linearis labels list
```

### Teams

```bash
# List teams
linearis teams list
```

---

## Workflow Integration

### Creating Issues from Code Context

When working on code and needing to create a related issue:

1. Use `/linear-create` with context from current work
2. Include file paths and relevant code snippets in description
3. Link the created issue in subsequent commits

### Linking Commits to Issues

```bash
git commit -m "feat(auth): add JWT validation

Closes [PLTFRM-123: Add JWT validation](https://linear.app/cloudwalk/issue/PLTFRM-123/add-jwt-validation)"
```

### PR Description Format

```markdown
## Related Issues

Closes [PLTFRM-123: Issue Title](https://linear.app/cloudwalk/issue/PLTFRM-123/issue-slug)

## Summary

- Implementation details here
```

---

## MCP Fallback

Use Linear MCP only when Linearis CLI cannot perform the operation:

- Complex GraphQL queries not supported by Linearis
- Operations requiring real-time subscriptions
- Bulk operations not available in CLI

For most day-to-day operations (create, read, update, list, comment), prefer Linearis CLI.

---

# /linear-create

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

---

# /linear-update

## Overview

Update an existing Linear issue using Linearis CLI.

## Steps

1. **Parse Arguments**:
   - Extract issue ID (required)
   - Extract fields to update:
     - `--title`: New title
     - `--description` or `-d`: New description
     - `--status`: New status
     - `--priority` or `-p`: New priority (1-4)
     - `--assignee` or `-a`: New assignee
     - `--labels`: New labels (comma-separated)
     - `--project`: Add to project

2. **Update Issue with Linearis CLI**:

   ```bash
   linearis issues update PLTFRM-123 \
     --status "In Progress" \
     -p 2
   ```

3. **Parse JSON Response**:
   - Confirm update success
   - Extract updated fields

4. **Display Updated Issue**:
   - Show what changed
   - Provide issue URL

## Output Format

```markdown
## Issue Updated

**Issue**: [PLTFRM-123: Issue Title](https://linear.app/cloudwalk/issue/PLTFRM-123/issue-slug)

### Changes Applied

| Field | Old Value | New Value |
|-------|-----------|-----------|
| Status | Backlog | In Progress |
| Priority | Normal (3) | High (2) |
```

## Common Status Values

| Status | Description |
|--------|-------------|
| Backlog | Planned work, not started |
| Triage | Needs review/prioritization |
| Todo | Ready to start |
| In Progress | Currently being worked on |
| In Review | Awaiting review |
| Done | Completed |
| Canceled | Will not be done |

## Examples

```bash
# Update status
/linear-update PLTFRM-123 --status "In Progress"

# Update priority
/linear-update PLTFRM-123 --priority 1

# Update multiple fields
/linear-update PLTFRM-123 --status "In Review" --labels "Feature,ready-for-review"

# Update description
/linear-update PLTFRM-123 -d "Updated description with more details"

# Move to different status (start working)
/linear-update PLTFRM-123 --status "In Progress"

# Mark as done
/linear-update PLTFRM-123 --status "Done"
```

## Arguments

Arguments: $ARGUMENTS

- First argument: Issue identifier (required)
- `--title`: New title
- `--description` or `-d`: New description
- `--status`: New status
- `--priority` or `-p`: Priority 1-4
- `--assignee` or `-a`: New assignee
- `--labels`: Comma-separated labels
- `--project`: Project name or ID

## Safety Checks

- ✅ Always confirm issue exists before updating
- ✅ Show what will be changed before applying
- ❌ Never update without specifying issue ID

---

# /linear-comment

## Overview

Add a comment to a Linear issue using Linearis CLI.

## Steps

1. **Parse Arguments**:
   - Extract issue ID (required)
   - Extract comment body (required)

2. **Create Comment with Linearis CLI**:

   ```bash
   linearis comments create PLTFRM-123 --body "Comment text here"
   ```

3. **Parse JSON Response**:
   - Confirm comment created
   - Extract comment details

4. **Display Confirmation**:
   - Show comment added
   - Provide issue URL

## Output Format

```markdown
## Comment Added

**Issue**: [PLTFRM-123: Issue Title](https://linear.app/cloudwalk/issue/PLTFRM-123/issue-slug)

### Comment

> Comment text here...

**View**: [See in Linear](https://linear.app/cloudwalk/issue/PLTFRM-123/issue-slug#comment-xyz)
```

## Examples

```bash
# Add simple comment
/linear-comment PLTFRM-123 "Started working on this"

# Add progress update
/linear-comment PLTFRM-123 "Completed initial implementation. Ready for review."

# Add multi-line comment (use quotes)
/linear-comment PLTFRM-123 "Progress update:
- Implemented feature X
- Fixed bug Y
- Need to add tests"

# Add comment with code reference
/linear-comment PLTFRM-123 "Fixed in commit abc123. See PR #456"
```

## Arguments

Arguments: $ARGUMENTS

- First argument: Issue identifier (required)
  - Format: `PLTFRM-123`
- Second argument: Comment body (required)
  - Supports markdown formatting

## Use Cases

- Progress updates during development
- Questions or clarifications
- Review feedback
- Blockers or dependency notes
- Completion notes

---

# /linear-list

## Overview

List Linear issues with filters using Linearis CLI.

## Steps

1. **Parse Filter Arguments**:
   - `--team`: Team filter (default: PLTFRM)
   - `--assignee` or `-a`: Assignee filter (default: me)
   - `--status`: Status filter
   - `--project`: Project filter
   - `--label`: Label filter
   - `--limit` or `-l`: Result limit (default: 20)

2. **List Issues with Linearis CLI**:

   ```bash
   linearis issues list \
     --team PLTFRM \
     --assignee me \
     --limit 20
   ```

3. **Parse JSON Response**:
   - Extract issue list
   - Format for table display

4. **Display Results**:
   - Show issues in table format
   - Include count and filters applied

## Output Format

```markdown
## Issues (15 found)

**Filters**: Team: PLTFRM | Assignee: me | Status: all

| ID | Title | Status | Priority | Updated |
|----|-------|--------|----------|---------|
| PLTFRM-123 | feat: add authentication | In Progress | High | 2h ago |
| PLTFRM-122 | fix: login timeout | Backlog | Normal | 1d ago |
| PLTFRM-121 | chore: update deps | Done | Low | 3d ago |

**View in Linear**: [Team Issues](https://linear.app/cloudwalk/team/PLTFRM/active)
```

## Examples

```bash
# List my issues (default)
/linear-list

# List by status
/linear-list --status "In Progress"

# List by project
/linear-list --project "Q1 2025"

# List all team issues (not just mine)
/linear-list --assignee all

# List with label filter
/linear-list --label "Bug"

# List more results
/linear-list --limit 50

# Combine filters
/linear-list --status "Backlog" --label "Feature" --limit 10
```

## Arguments

Arguments: $ARGUMENTS

- `--team`: Team key (default: PLTFRM)
- `--assignee` or `-a`: Assignee filter (default: me, use "all" for all)
- `--status`: Status name filter
- `--project`: Project name or ID
- `--label`: Label name filter
- `--limit` or `-l`: Max results (default: 20)

## Default Behavior

- Shows issues assigned to current user
- From PLTFRM team
- All statuses (except archived)
- Limited to 20 results

---

# /linear-triage

## Overview

Quick shortcut to create a Linear issue in Triage status (for unplanned/incoming requests).

## When to Use

Use `/linear-triage` instead of `/linear-create` when:
- Receiving ad-hoc requests that need review
- Creating issues from Slack messages or emails
- Capturing bugs reported by users
- Anything that needs prioritization before starting

## Steps

1. **Parse Arguments**:
   - Same as `/linear-create`
   - Status is automatically set to **Triage**

2. **Create Issue with Linearis CLI**:

   ```bash
   linearis issues create "Title" \
     --team PLTFRM \
     --status Triage \
     -a me
   ```

3. **Display Created Issue**:
   - Same output as `/linear-create`
   - Highlights Triage status

## Output Format

```markdown
## Issue Created (Triage)

**Issue**: [PLTFRM-123: Issue Title](https://linear.app/cloudwalk/issue/PLTFRM-123/issue-slug)
**Team**: Self Driven Platform
**Status**: ⚠️ Triage (needs prioritization)
**Assignee**: @me

> This issue is in Triage. Review and move to Backlog when prioritized.
```

## Difference from `/linear-create`

| Aspect | `/linear-create` | `/linear-triage` |
|--------|------------------|------------------|
| Default Status | Backlog | Triage |
| Use Case | Planned work | Incoming requests |
| Priority | Auto-detected | Usually needs review |

## Examples

```bash
# Quick triage issue
/linear-triage "User reported login issue"

# Triage with description
/linear-triage "API timeout from customer" "Customer XYZ reported timeouts on endpoint /api/v1/data"

# Triage with initial label
/linear-triage "Production error in payments" --labels "Bug"
```

## Arguments

Arguments: $ARGUMENTS

- First argument: Issue title (required)
- Second argument: Issue description (optional)
- `--labels`: Comma-separated labels (optional)
- `--priority` or `-p`: Priority 1-4 (optional)
- `--project`: Project name (optional)

## Workflow

1. Create issue with `/linear-triage`
2. Review and prioritize in Linear
3. Move to Backlog when ready to plan
4. Move to Todo when ready to start

---

# /linear-view

## Overview

View detailed information about a Linear issue using Linearis CLI.

## Steps

1. **Parse Issue Identifier**:
   - Extract issue ID from arguments (required)
   - Supports formats: `PLTFRM-123`, `123`, or full UUID

2. **Fetch Issue Details**:

   ```bash
   linearis issues read PLTFRM-123
   ```

3. **Parse JSON Response**:
   - Extract all issue fields
   - Format for readable output

4. **Display Issue Information**:
   - Title and identifier
   - Status and priority
   - Assignee and team
   - Labels and project
   - Description
   - URL

## Output Format

```markdown
## PLTFRM-123: Issue Title

**Status**: In Progress
**Priority**: Normal (3)
**Assignee**: @username
**Team**: Self Driven Platform
**Labels**: Feature, backend
**Project**: Q1 2025
**Created**: 2025-01-10
**Updated**: 2025-01-13

### Description

Issue description content here...

### Links

- **Linear**: [View in Linear](https://linear.app/cloudwalk/issue/PLTFRM-123/issue-slug)
- **Git Branch**: `pltfrm-123-issue-slug`

### Reference for PRs

```
Closes [PLTFRM-123: Issue Title](https://linear.app/cloudwalk/issue/PLTFRM-123/issue-slug)
```
```

## Examples

```bash
# View by identifier
/linear-view PLTFRM-123

# View by number (assumes PLTFRM team)
/linear-view 123
```

## Arguments

Arguments: $ARGUMENTS

- First argument: Issue identifier (required)
  - Format: `PLTFRM-123` or just `123`

## Error Handling

- If issue not found, display error message
- If identifier format invalid, suggest correct format

---

# /linear-project-create

## Overview

Create a Linear project from a Cursor plan file, converting plan tasks into Linear issues.

## Steps

1. **Parse Arguments**:
   - Extract plan file path (required, or detect from `.cursor/plans/`)
   - Extract project name (optional, defaults to plan name)
   - Extract team (default: PLTFRM)

2. **Read Plan File**:
   - Load plan from `.cursor/plans/` directory
   - Parse YAML frontmatter for metadata
   - Extract tasks/todos from plan content

3. **Create Linear Project**:
   - Note: Linearis CLI doesn't support project creation directly
   - Use Linear MCP or create issues with `--project` flag to existing project

4. **Create Issues from Tasks**:
   - For each task in the plan:

   ```bash
   linearis issues create "Task title" \
     --team PLTFRM \
     --status Backlog \
     --project "Project Name" \
     -d "Task description from plan"
   ```

5. **Update Plan with Issue Links**:
   - Add Linear issue IDs to plan tasks
   - Create mapping between plan tasks and issues

6. **Display Results**:
   - List all created issues
   - Show project link
   - Provide summary

## Output Format

```markdown
## Project Created from Plan

**Plan**: `.cursor/plans/2025-01-13-feature-x.md`
**Project**: [Project Name](https://linear.app/cloudwalk/project/project-id)
**Team**: Self Driven Platform

### Issues Created (5)

| # | Issue | Title | Status |
|---|-------|-------|--------|
| 1 | [PLTFRM-123](url) | Task 1 from plan | Backlog |
| 2 | [PLTFRM-124](url) | Task 2 from plan | Backlog |
| 3 | [PLTFRM-125](url) | Task 3 from plan | Backlog |
| 4 | [PLTFRM-126](url) | Task 4 from plan | Backlog |
| 5 | [PLTFRM-127](url) | Task 5 from plan | Backlog |

### Plan Updated

Tasks in plan now include Linear issue references.
```

## Examples

```bash
# Create project from specific plan
/linear-project-create .cursor/plans/2025-01-13-feature-x.md

# Create with custom project name
/linear-project-create .cursor/plans/plan.md --project "Q1 Feature Release"

# Create from most recent plan (auto-detect)
/linear-project-create
```

## Arguments

Arguments: $ARGUMENTS

- First argument: Plan file path (optional, auto-detects most recent)
- `--project`: Project name in Linear (will create issues linked to this project)
- `--team`: Team key (default: PLTFRM)

## Workflow

1. Create plan using `/plan` command
2. Review and refine plan
3. Run `/linear-project-create` to create issues
4. Work on issues, update status
5. Plan file stays in sync (optional)

## Notes

- Requires existing Linear project to link issues to
- Each plan task becomes one Linear issue
- Task dependencies are noted in issue descriptions
- Plan file is updated with issue references after creation

---

# /linear-project-plan

## Overview

Generate a Cursor plan file from an existing Linear project, converting issues into actionable tasks.

## Steps

1. **Parse Arguments**:
   - Extract project name or ID (required)
   - Extract output path (optional, defaults to `.cursor/plans/`)

2. **Fetch Project Details**:

   ```bash
   # List projects to find the one
   linearis projects list
   ```

3. **Fetch Project Issues**:

   ```bash
   linearis issues list --project "Project Name"
   ```

4. **Generate Plan File**:
   - Create YAML frontmatter with project metadata
   - Convert issues to todo items
   - Preserve issue relationships as dependencies
   - Include issue links in task descriptions

5. **Write Plan File**:
   - Save to `.cursor/plans/` directory
   - Use naming convention: `YYYY-MM-DD-project-name.md`

6. **Display Results**:
   - Show created plan file path
   - Summarize tasks imported

## Output Format

```markdown
## Plan Created from Project

**Project**: [Project Name](https://linear.app/cloudwalk/project/project-id)
**Plan File**: `.cursor/plans/2025-01-13-project-name.md`

### Tasks Imported (8)

| Status | Count |
|--------|--------|
| Backlog | 3 |
| Todo | 2 |
| In Progress | 2 |
| Done | 1 |

### Next Steps

1. Review the generated plan
2. Start working on tasks using the plan
3. Update Linear issues as you progress
```

## Examples

```bash
# Generate plan from project name
/linear-project-plan "Q1 2025 Features"

# Generate with custom output path
/linear-project-plan "Project Name" --output .cursor/plans/q1-features.md

# Generate from project with specific team filter
/linear-project-plan "Project Name" --team PLTFRM
```

## Arguments

Arguments: $ARGUMENTS

- First argument: Project name or ID (required)
- `--output`: Custom output file path
- `--team`: Filter issues by team
- `--status`: Filter issues by status (e.g., only active issues)

## Status Mapping

| Linear Status | Plan Status |
|---------------|-------------|
| Backlog | pending |
| Triage | pending |
| Todo | pending |
| In Progress | in_progress |
| In Review | in_progress |
| Done | completed |
| Canceled | cancelled |

## Workflow

1. Identify Linear project to work on
2. Run `/linear-project-plan "Project Name"`
3. Review generated plan
4. Execute tasks using the plan
5. Update Linear issues as you complete work

## Use Cases

- Onboarding to existing project
- Planning sprint work from Linear backlog
- Creating execution roadmap from project issues
- Syncing Linear project state to local plan
