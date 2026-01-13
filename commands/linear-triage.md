# Linear Triage

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
