# Linear Update Issue

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
