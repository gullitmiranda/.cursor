---
name: plan
description: Create or update project plans in .cursor/plans/ with structured task breakdown. Use when creating a new plan, updating an existing plan, or organizing work into actionable tasks.
disable-model-invocation: true
---
# Plan Command

## Description

Create or update project plan in .cursor/plans/ directory with structured task breakdown.

## Workflow

1. Always create or update plan file based on proposed plan inside .cursor/plans/ folder
2. Use clear, actionable task breakdown
3. Don't add time estimation unless explicitly requested
4. Format as markdown with clear sections and checkboxes
5. Include dependencies and prerequisites
6. Maintain plan history and versioning

## Plan Structure

- ## Objective
- ## Tasks
- ## Dependencies
- ## Acceptance Criteria
- ## Notes

## File Naming

`.cursor/plans/YYYY-MM-DD-plan-name.md`

## Examples

```bash
# Create new plan
/plan "Implement user authentication system"

# Update existing plan
/plan "Add OAuth integration to auth system"

# Create plan with specific date
/plan "2024-12-20-database-migration"
```

## Features

- Automatic date formatting
- Structured markdown output
- Task dependency tracking
- Progress monitoring
- Version control integration

## Integration

- Works with Linear issues
- Integrates with PR workflow
- Supports multi-repository projects
- Compatible with documentation system
