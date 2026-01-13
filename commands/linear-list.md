# Linear List Issues

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
