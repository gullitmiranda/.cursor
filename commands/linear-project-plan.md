# Linear Project Plan (from Project)

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
|--------|-------|
| Backlog | 3 |
| Todo | 2 |
| In Progress | 2 |
| Done | 1 |

### Next Steps

1. Review the generated plan
2. Start working on tasks using the plan
3. Update Linear issues as you progress
```

## Generated Plan Format

```markdown
---
name: Project Name
overview: Project description from Linear
source: linear-project
project_id: abc-123
todos:
  - id: pltfrm-123
    content: "Issue title 1"
    status: pending
    linear_url: "https://linear.app/cloudwalk/issue/PLTFRM-123"
  - id: pltfrm-124
    content: "Issue title 2"
    status: in_progress
    linear_url: "https://linear.app/cloudwalk/issue/PLTFRM-124"
---

# Project Name

> Generated from Linear project on 2025-01-13

## Overview

Project description from Linear...

## Tasks

### PLTFRM-123: Issue title 1
**Status**: Backlog | **Priority**: Normal
**Link**: [View in Linear](https://linear.app/cloudwalk/issue/PLTFRM-123)

Issue description...

---

### PLTFRM-124: Issue title 2
**Status**: In Progress | **Priority**: High
**Link**: [View in Linear](https://linear.app/cloudwalk/issue/PLTFRM-124)

Issue description...
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
