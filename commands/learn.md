---
description: Persist learned rules to AGENTS.md / AGENTS.local.md or user preferences
---

# /learn

Persist "learned" instructions in a tool-agnostic way.

Canonical behavior lives in the `learn` skill:

- `skills/learn/SKILL.md`

Usage examples:

- `/learn "In this repo, we use pnpm."`
- `/learn "Only for me in this repo: run tests first"` (project-local)
- `/learn "For all my projects: ask before commits"` (user)
- `/learn "scope=user: only push when explicitly requested"` (explicit scope)
- `/learn "Applies to backend/: prefer pytest fixtures"` (contextual)

When this command is used:

- Apply the `learn` skill workflow.
- Default scope to `project` unless the user explicitly requests `project-local` or `user`.
