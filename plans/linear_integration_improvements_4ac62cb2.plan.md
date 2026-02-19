---
name: Linear Integration Improvements
overview: Reorganize Linear integration using Linearis CLI as primary tool (instead of unreliable MCP), with split commands, dedicated rules file, Backlog as default status, and bidirectional plan/project integration.
todos:
  - id: install-linearis-cli
    content: Install Linearis CLI globally via mise (npm:linearis)
    status: completed
  - id: create-linear-rules
    content: Create rules/linear.md with Linearis CLI usage, team config, Backlog default
    status: completed
    dependencies:
      - install-linearis-cli
  - id: update-integration-rules
    content: Remove Linear section from rules/integration.md, add reference
    status: completed
    dependencies:
      - create-linear-rules
  - id: create-linear-create-cmd
    content: Create commands/linear-create.md using Linearis CLI with inference
    status: completed
    dependencies:
      - create-linear-rules
  - id: create-linear-view-cmd
    content: Create commands/linear-view.md using Linearis CLI
    status: completed
    dependencies:
      - create-linear-rules
  - id: create-linear-update-cmd
    content: Create commands/linear-update.md using Linearis CLI
    status: completed
    dependencies:
      - create-linear-rules
  - id: create-linear-list-cmd
    content: Create commands/linear-list.md using Linearis CLI
    status: completed
  - id: create-linear-comment-cmd
    content: Create commands/linear-comment.md using Linearis CLI
    status: completed
  - id: create-linear-triage-cmd
    content: Create commands/linear-triage.md as shortcut for Triage status
    status: completed
    dependencies:
      - create-linear-create-cmd
  - id: update-pr-command
    content: Update commands/pr.md to use full markdown URLs for Linear issues
    status: completed
  - id: create-project-create-cmd
    content: Create commands/linear-project-create.md (plan to project)
    status: completed
    dependencies:
      - create-linear-create-cmd
  - id: create-project-plan-cmd
    content: Create commands/linear-project-plan.md (project to plan)
    status: completed
  - id: delete-old-linear-issue
    content: Delete commands/linear-issue.md after all new commands are ready
    status: completed
    dependencies:
      - create-linear-create-cmd
      - create-linear-view-cmd
      - create-linear-update-cmd
      - create-linear-list-cmd
      - create-linear-comment-cmd
      - create-linear-triage-cmd
isProject: false
---

# Linear Integration Improvements Plan

## Context

Current issues with `/linear-issue` command:

- Unreliable MCP execution (errors, auth issues, frequent disconnections)
- Default status is "Todo" but should be "Backlog"
- Project selection failures
- Complex multi-command structure causes ambiguity

## Solution: Linearis CLI

Use [Linearis CLI](https://github.com/czottmann/linearis) as primary tool instead of MCP:

- **Package**: `npm:linearis` (available in npm, installable via mise)
- **Latest version**: 2025.12.3
- **Auth**: Uses `$LINEAR_API_TOKEN` environment variable (already configured)
- **Output**: JSON format, perfect for parsing and LLM agents
- **Fallback**: MCP only for operations not supported by Linearis

### Linearis Commands Available

```
linearis issues create <title>     # Create issue
linearis issues read <issueId>     # View issue
linearis issues update <issueId>   # Update issue
linearis issues list               # List issues
linearis issues search <query>     # Search issues
linearis comments create <issueId> # Add comment
linearis projects list             # List projects
linearis labels list               # List labels
linearis teams list                # List teams
linearis users list                # List users
```

---

## Phase 0: Install Linearis CLI

```bash
mise use -g npm:linearis@2025.12.3
```

Verify installation:

```bash
linearis teams list
```

---

## Phase 1: Rules Reorganization

### Create `[rules/linear.md](rules/linear.md)` (new)

- Linearis CLI as primary tool (not MCP)
- Team configuration (PLTFRM as default)
- Updated defaults: **status: Backlog** (not Todo/Triage)
- Auto-label mapping based on title prefixes
- Always use full markdown URL format for issue references
- Quick option for Triage when explicitly requested

### Update `[rules/integration.md](rules/integration.md)`

- Remove Linear section (moved to dedicated file)
- Add reference to `rules/linear.md`

---

## Phase 2: Split Commands

Replace `[commands/linear-issue.md](commands/linear-issue.md)` with focused commands using Linearis CLI:

| Command | Linearis Command | Purpose |

| ----------------- | ----------------------------------- | ------------------------------------ |

| `/linear-create` | `linearis issues create` | Create issue (Backlog, auto-labels) |

| `/linear-view` | `linearis issues read` | View issue details by ID |

| `/linear-update` | `linearis issues update` | Update existing issue |

| `/linear-list` | `linearis issues list` | List issues with filters |

| `/linear-comment` | `linearis comments create` | Add comments to issues |

| `/linear-triage` | `linearis issues create --status` | Create in Triage status |

---

## Phase 3: Intelligent Inference in `/linear-create`

Auto-detect from title:

- `feat/feature` → Label: Feature
- `fix/bug` → Label: Bug
- `chore` → Label: Chore
- `docs` → Label: Docs
- `refactor` → Label: Improvement

Priority keywords:

- `urgent/critical/broken` → Priority 1
- `important/high` → Priority 2
- Default → Priority 3
- `low/minor` → Priority 4

---

## Phase 4: Plan to/from Project Integration

### `/linear-project-create` (plan to project)

1. Read plan from `.cursor/plans/`
2. Create Linear project with name/description
3. Create issues for each task using `linearis issues create`
4. Link issues to project

### `/linear-project-plan` (project to plan)

1. Fetch Linear project using `linearis projects list`
2. List project issues using `linearis issues list --project`
3. Generate plan in `.cursor/plans/` with tasks from issues
4. Include issue links

---

## Phase 5: Update PR Command

Modify `[commands/pr.md](commands/pr.md)`:

- Always use markdown format for Linear references:
  ```
  Closes [PLTFRM-123: Issue Title](https://linear.app/cloudwalk/issue/PLTFRM-123/slug)
  ```
- Fetch issue title via `linearis issues read` when detecting ID in commits

---

## Files Summary

| File | Action |

| ----------------------------------- | ------ |

| `rules/linear.md` | Create |

| `rules/integration.md` | Modify |

| `commands/linear-create.md` | Create |

| `commands/linear-view.md` | Create |

| `commands/linear-update.md` | Create |

| `commands/linear-list.md` | Create |

| `commands/linear-comment.md` | Create |

| `commands/linear-triage.md` | Create |

| `commands/linear-project-create.md` | Create |

| `commands/linear-project-plan.md` | Create |

| `commands/linear-issue.md` | Delete |

| `commands/pr.md` | Modify |

---

## Execution Order

1. **Phase 0**: Install Linearis CLI via mise
2. **Phase 1**: Create rules/linear.md and update integration.md
3. **Phase 2**: Create core commands (create, view, update)
4. **Phase 5**: Update PR command (immediate benefit)
5. **Phase 2 cont.**: Create secondary commands (list, comment, triage)
6. **Phase 4**: Plan/project integration (most complex)
7. **Cleanup**: Delete old linear-issue.md
