# Plan: Skills Revamp (Enable Proactive Invocation)

## Objective

Allow the agent to proactively load skills when the context matches, so that workflow guidelines (git, Linear, k8s, PR, plan, workspace) are applied whenever relevant, not only when the user explicitly invokes a "command". This is done by removing `disable-model-invocation: true` from those skills and, where useful, tightening their `description` so they work well as triggers.

---

## Tasks

### 1. Remove `disable-model-invocation: true` from domain skills

Remove the line `disable-model-invocation: true` from the YAML frontmatter of:

| Skill                | Current role                                          | After revamp                                                                                     |
| -------------------- | ----------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| **git**              | Commit, branch, reset, status workflows               | Loaded when user is committing, creating branches, resetting, or checking git status             |
| **linear**           | Linear rules + create/update/list/triage/view/project | Loaded when user creates or manages Linear issues, or references issues in commits/PRs           |
| **k8s**              | Safe k8s check/validate/diff                          | Loaded when user inspects k8s resources, validates manifests, or previews apply                  |
| **pr**               | Create PR, validate, ready                            | Loaded when user creates a PR, runs quality checks, or marks PR ready                            |
| **plan**             | Create/update plans in .cursor/plans/                 | Loaded when user asks to create or update a plan or break down work                              |
| **workspace-status** | Multi-repo workspace overview                         | Loaded when user checks workspace state, repo boundaries, or before git operations in multi-repo |

No change to skills that already have no `disable-model-invocation`: **safety**, **workflow**, **integration**, **quality**. No change to **persist-agent-constraints** unless it currently has the flag (check and leave consistent with intent).

### 2. Review and sharpen descriptions (optional but recommended)

For each skill that had invocation disabled, ensure the `description` in the frontmatter:

- Starts with what the skill provides (e.g. "Safe Git workflow…", "Linear integration with Linearis CLI…").
- Includes a clear "Use when…" (or equivalent) so the model knows when to load it.
- Is specific enough to avoid loading in unrelated contexts (e.g. "Use when committing…" not "Use when working with code").

Adjust only if the current description is vague or too broad; otherwise leave as is.

### 3. Smoke-check after changes

- Confirm all six skills no longer contain `disable-model-invocation` in frontmatter.
- Confirm safety, workflow, integration, quality (and persist-agent-constraints if present) are unchanged or intentionally updated.
- Optionally: in Cursor, run a short scenario (e.g. "I want to commit my changes" or "Create a Linear issue for this") and verify the relevant skill appears to be in use (e.g. agent follows conventional commit or Linearis).

---

## Dependencies

- None. Changes are frontmatter and optional description edits only.

---

## Acceptance Criteria

- `disable-model-invocation: true` is removed from git, linear, k8s, pr, plan, and workspace-status.
- Descriptions for those skills remain clear and specific (or are improved where needed).
- No unintended edits to other skills or to skill body content.
- Agent can proactively apply guidelines from these skills when context matches (validated by manual check or usage).

---

## Notes

- If in practice a skill loads too often or in the wrong context, re-add `disable-model-invocation: true` only for that skill.
- Rule-style skills (safety, workflow, integration, quality) stay invocation-enabled so they continue to apply broadly.
