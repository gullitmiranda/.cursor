# Linear View Issue

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
