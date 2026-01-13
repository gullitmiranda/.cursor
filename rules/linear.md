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
| `low`, `minor`, `nice-to-have`, `someday`    | 4 (Low)    |

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
