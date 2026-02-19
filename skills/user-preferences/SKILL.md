---
name: user-preferences
description: Always apply guma's personal preferences across projects (user-level). Use when interacting with the user in any repo.
---

#

# User Preferences (User-Level)

#

# This file is the canonical place to persist "scope=user" learns until ~/.claude is configured

# and becomes the shared user-level memory store across tools.

#

# Keep this concise and actionable. Prefer one rule per bullet.

## Learned preferences

- Do not push unless the user explicitly requests it; be especially cautious with `main`/`master`.
- When instructed to use a git worktree, create/use the worktree and avoid making changes in the primary worktree.
