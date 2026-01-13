# Linear Project Create (from Plan)

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

## Plan File Format Expected

```markdown
---
name: Feature X Implementation
overview: Implement feature X with components A, B, C
todos:
  - id: task-1
    content: Implement component A
    status: pending
  - id: task-2
    content: Implement component B
    status: pending
    dependencies:
      - task-1
  - id: task-3
    content: Write tests for A and B
    status: pending
    dependencies:
      - task-1
      - task-2
---

# Feature X Implementation Plan

## Overview

Description of the feature...

## Tasks

### Task 1: Implement component A
Details...

### Task 2: Implement component B
Details...
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
