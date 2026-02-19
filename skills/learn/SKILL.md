---
name: learn
description: Persist learned rules in a tool-agnostic way (project / project-local / user scope). Use when the user runs /learn or asks you to remember a preference or project convention.
---

# Learn (Tool-Agnostic Memory)

Persist "learned" instructions so they work across agentic coding tools, not just Cursor.

Principles:

- Default scope is PROJECT (shared, version-controlled) for repo conventions.
- Use USER when the instruction is clearly a personal preference about the assistant's behavior (even if the user did not explicitly write `scope=user:`).
- Keep everything ASCII; avoid invisible Unicode.
- Never update git config.

## Explicit syntax (preferred when you care about scope)

Support these optional prefixes in the user's `/learn` text:

- `scope=user: <rule>`
- `scope=project: <rule>`
- `scope=project-local: <rule>`
- `applies-to=<path-or-glob>: <rule>` (can be combined, e.g. `scope=project applies-to=backend/: ...`)

## Targets by scope

scope = project:

- `./AGENTS.md` (create if missing)
- Ensure Claude compatibility shim: `./.claude/CLAUDE.md` (create if missing)

scope = project-local:

- `./AGENTS.local.md` (create if missing)
- Must not be committed:
  - Add `AGENTS.local.md` to the user's global gitignore (core.excludesfile or default file)
  - Optionally add to repo `.gitignore` if appropriate

scope = user (until ~/.claude is configured):

- Persist in user-level Cursor config:
  - `~/.cursor/skills/user-preferences/SKILL.md` under `## Learned preferences`

## File templates (when creating new files)

`AGENTS.md`:

```markdown
# AGENTS

## Always apply (project)

## Contextual (project)
```

`AGENTS.local.md`:

```markdown
# AGENTS (local)

## Always apply (project-local)

## Contextual (project-local)
```

`.claude/CLAUDE.md` (shim):

```markdown
# Claude instructions

Read and follow `AGENTS.md` as the canonical project rules.

If `AGENTS.local.md` exists, treat it as personal (project-local) preferences.
```

## Workflow

1. Parse the instruction into:

- `rule`: one bullet, imperative, concise
- `appliesTo` (optional): repo path or glob pattern (only when explicitly specified)
- `scope`: default to `project`

2. Decide scope:

- If explicitly "for all my projects" / "global" / "always for me": `user`
- Else if explicitly "only for me in this repo" / "local (do not commit)": `project-local`
- Else: `project`

Heuristic upgrade (avoid wrong default):

- If the rule is about the assistant's behavior/preferences (not a repo convention), prefer `user`.
  - Examples (EN): "only push when requested", "ask before committing", "be concise", "avoid emojis".
  - Examples (PT-BR): "sempre respeite quando eu mandar usar uma git worktree", "nao faca commits na main sem eu pedir", "pergunte antes de commitar".
- If the rule is about a specific repo's conventions/stack, prefer `project`.
  - Examples: "in this repo we use pnpm", "this repo uses pytest", "our CI uses trunk".
- If the rule is personal AND repo-specific (or explicitly says "only for me here"), use `project-local`.

If still ambiguous, ask one question: "scope: project / project-local / user?"

3. Write the rule with de-duplication:

- If equivalent rule already exists in the target section, refine it instead of duplicating.

Section routing:

- If no `appliesTo`: append to `## Always apply (<scope>)`
- If `appliesTo`: ensure `## Contextual (<scope>)` exists and add:
  - `### Applies to: <appliesTo>`
  - `- <rule>`

4. Global gitignore update (only for project-local):

- Read global excludes file path: `git config --get core.excludesfile`
- If empty, use `~/.config/git/ignore` (create file if missing)
- Append `AGENTS.local.md` if not present
- Do NOT change git config

5. Confirm:

- Report what you saved, where (exact path), and which section.
