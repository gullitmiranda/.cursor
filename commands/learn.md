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
- Default scope to `project` for repo conventions, **but** prefer `scope=user` when the text is clearly a personal preference about the assistant's behavior (not a project convention).
  - Examples that should infer `scope=user` (even without an explicit prefix):
    - "Always respect when I'm told to use a git worktree."
    - "Only push when explicitly requested."
    - "Ask before committing."
    - PT-BR equivalents: "sempre ...", "nunca ...", "nao faça ...", when addressed to the assistant's behavior.
