---
name: persist-agent-constraints
description: Persists agent constraints (what not to do) in the project's canonical place for agent instructions. Use when the user states constraints, prohibitions, or things to avoid (e.g. não faça, evite, don't, never, avoid, não quero que, proibido).
---
# Persist Agent Constraints

**Terminology**: In the community, **constraints** (or "agent constraints") are the rules that limit what the agent should do—the "what not to do" instructions. Guardrails often refer to runtime checks; constraints here are the persistent, user-defined rules you store in project docs.

When the user states **constraints** (prohibitions, restrictions, things to avoid), persist them wherever the project keeps **agent instructions** so future sessions respect them. The agent decides the best location; the file name is not fixed.

## When to Apply

Apply this skill when the user:

- Says what **not** to do (e.g. "não faça X", "don't do Y", "never Z")
- Adds **restrictions** or **prohibitions** (e.g. "evite", "avoid", "não quero que", "proibido")
- Corrects behavior by stating what to **avoid** or **stop doing**

## Workflow

1. **Parse the instruction**  
   Turn the user's message into one or more short, clear bullet lines (imperative; the section title already implies "don't").

2. **Choose where to persist**  
   Decide the best place for agent constraints in this project:
   - **Prefer existing agent-instruction artifacts**: e.g. `AGENTS.md`, `CLAUDE.md`, `.cursor/rules/*.mdc`, `.cursorrules`, or similar at repo/project root or in `.cursor/`
   - **Context**: If the workspace has multiple projects, prefer the one the user is working in (open files, path mentioned, or obvious focus)
   - **If none exists**: Create a single, obvious file for agent instructions (e.g. `AGENTS.md` or `CLAUDE.md` at project root) with a minimal structure and add the constraints section there
   - **Rule of thumb**: Use the same place this project already uses for "how the AI should behave"; only create a new file if there is no such place

3. **Add or update the constraints section**  
   - Section title: `## Don't / Avoid` or `## Constraints` (or `## O que não fazer` if the file/project uses Portuguese for headings)
   - Use a bullet list; one bullet per constraint
   - Append the new item(s). If an equivalent rule already exists, do not duplicate; optionally refine the existing one
   - Keep each line concise and actionable

4. **Confirm**  
   Tell the user what was added and **where** (exact path), e.g. "Added to `my-project/AGENTS.md` under Constraints: …".

## Section Format

Same structure regardless of target file:

```markdown
## Constraints

- Do not commit to main without a PR
- Do not use Linear for this project (use GitHub Issues)
- Do not add timelines or cronograms to plans
```

Alternative heading (same content):

```markdown
## Don't / Avoid

- Do not commit to main without a PR
...
```

Or in Portuguese:

```markdown
## O que não fazer

- Não fazer commit direto na main sem PR
- Não usar Linear neste projeto (usar GitHub Issues)
- Não incluir prazos ou cronogramas em planos
```

Match the language and heading style of the rest of the target file when adding the section or items.

## Rules

- **One concern per bullet**: Split long constraints into separate bullets
- **No duplication**: Before adding, scan the section for the same or overlapping rule
- **Preserve file structure**: Do not remove or reorganize other sections; only add/update the constraints section and its bullets
- **Character hygiene**: Avoid gremlin/control characters in the text you write
