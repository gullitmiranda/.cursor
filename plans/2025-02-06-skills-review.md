# Skills Review (2025-02-06)

Post-migration review of all Agent Skills in `.cursor/skills/`.

## Summary

| Skill            | Frontmatter | Description trigger                                    | disable-model-invocation             | Content                                 | Issues                |
| ---------------- | ----------- | ------------------------------------------------------ | ------------------------------------ | --------------------------------------- | --------------------- |
| safety           | OK          | Clear (commit, push, kubectl, multi-repo, destructive) | Not set (rule – apply when relevant) | Complete                                | None                  |
| workflow         | OK          | Clear (English, commit, PR, plans)                     | Not set (rule)                       | Complete                                | None                  |
| integration      | OK          | Clear (Linearis, gh, Trunk, MCP, APIs)                 | Not set (rule)                       | Complete                                | Fixed: link to linear |
| quality          | OK          | Clear (code, commit, PR, any text)                     | Not set (rule)                       | Complete, includes character-hygiene    | None                  |
| linear           | OK          | Clear (issues, commits/PRs, projects)                  | true (command-like)                  | Complete, rule + 8 command sections     | None                  |
| git              | OK          | Clear (commit, branch, reset, status)                  | true (command-like)                  | Complete, 4 command sections            | None                  |
| k8s              | OK          | Clear (inspect, validate, diff; never delete/apply)    | true (command-like)                  | Complete, 3 command sections            | None                  |
| pr               | OK          | Clear (create PR, quality checks, ready)               | true (command-like)                  | Complete, full workflow + quality gates | None                  |
| plan             | OK          | Clear (create/update plan, tasks)                      | true (command-like)                  | Complete                                | None                  |
| workspace-status | OK          | Clear (workspace state, repo boundaries)               | true (command-like)                  | Complete                                | None                  |

## Fixes Applied

- **integration/SKILL.md**: Replaced broken link `[rules/linear.md](linear.md)` (resolved to non-existent integration/linear.md) with text: "See the **linear** skill for full Linear rules and CLI commands (skills/linear/)."

## Conventions Verified

- **Rules** (safety, workflow, integration, quality): No `disable-model-invocation`; agent may apply when context matches description.
- **Command-like** (linear, git, k8s, pr, plan, workspace-status): `disable-model-invocation: true` so they are used on explicit user intent (e.g. /command or clear request).
- All skills have `name` (kebab-case) and `description` with "Use when..." for trigger clarity.
- Content preserved verbatim from source rules/commands; no gremlin characters observed.

## Recommendation

No further changes required. Skills are ready for use; User Rules in Cursor settings can be cleared after confirming behavior in practice.
