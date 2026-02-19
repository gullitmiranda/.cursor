# Plan: Rules and Commands to Skills Migration

## Objective

Migrate Cursor rules and slash commands from `.cursor/rules/` and `.cursor/commands/` into Agent Skills, aggregated by domain where it makes sense. Deploy skills to the user directory (`~/.cursor/skills/`) so Cursor loads them globally and the manual "copy content into User Rules" flow is no longer needed. After migration, clear User Rules in Cursor settings.

This repository **is** `~/.cursor` (same directory). Skills created in `.cursor/skills/` are therefore already in the user directory; no deploy step is needed.

---

## Tasks

### 1. Prepare skill layout and aggregation map

- **Rules** (one skill per rule file; character-hygiene merged into quality):
  - `rules/safety.md` → skill `safety`
  - `rules/workflow.md` → skill `workflow`
  - `rules/quality.md` + `rules/character-hygiene.md` → one skill `quality` (add character-hygiene as a section, e.g. "Output / character hygiene (gremlin characters)")
  - `rules/integration.md` → skill `integration`
  - `rules/linear.md` → merged into fat skill `linear` with Linear commands (see below)

- **Commands** (aggregated by domain into single skills):
  - **linear**: Merge rule `linear` + all Linear commands (`linear-create`, `linear-update`, `linear-comment`, `linear-list`, `linear-triage`, `linear-view`, `linear-project-create`, `linear-project-plan`) into one fat skill `linear` (rules section + command sections under headings).
  - **git**: `commit`, `git-branch`, `git-reset`, `git-status` → one skill `git`
  - **k8s**: `k8s-check`, `k8s-validate`, `k8s-diff` → one skill `k8s`
  - **Standalone** (one skill each): `pr`, `plan`, `workspace-status`

### 2. Create skills in the repository

- Create directory `.cursor/skills/` in the repo (if it does not exist).
- For each rule file **except** `linear.md` and `character-hygiene.md`: create `.cursor/skills/{name}/SKILL.md` with frontmatter and body = exact content. Rules to create as standalone skills: `safety`, `workflow`, `integration`. For **quality**: create one skill that combines `rules/quality.md` and `rules/character-hygiene.md` (e.g. append character-hygiene as a final section in the same SKILL.md).
- For the **linear** skill: create `.cursor/skills/linear/SKILL.md` that merges (1) the full body of `rules/linear.md` and (2) all Linear command files combined under clear headings (e.g. `## /linear-create`, `## /linear-update`, …). Use frontmatter `name: linear`, a single `description` covering rules + Linear CLI usage, and `disable-model-invocation: true` so the skill is used for both context and explicit Linear operations.
- For other aggregated command skills: create one `SKILL.md` per group (`git`, `k8s`, `pr`, `plan`, `workspace-status`). Each must have frontmatter `name`, `description`, and `disable-model-invocation: true`, and combine original command bodies under clear headings, content verbatim.
- For rule files that are plain `.md` (no YAML frontmatter): treat first `# Title` as the title and the rest as body; derive `description` from title or first paragraph.

### 3. Clean User Rules in Cursor settings

- Open Cursor → Settings (Cursor-specific) → Rules / User Rules.
- Remove the manually pasted content (no longer needed; equivalent is in `.cursor/skills/` in this repo).
- Leave User Rules empty or minimal so the manual copy flow is discontinued.

### 4. Handle original rules and commands in the repo

- **Option A (recommended):** Keep `rules/` and `commands/` in the repo as the canonical source; treat `.cursor/skills/` as generated/deployed from them. Document that skills are built from these files so future edits happen in rules/ and commands/, then skills are regenerated or updated.
- **Option B:** After verifying skills work, move contents of `rules/` and `commands/` to `backups/` (e.g. `backups/pre-skills-migration/`) and make `.cursor/skills/` the only source; update docs accordingly.

Choose one option and document it in README or CONTRIBUTING.

### 5. Update documentation

- Update `.cursor/README.md` (and any `docs/`) to describe:
  - That rules and commands have been migrated to skills.
  - Where skills live: `.cursor/skills/` (this repo is `~/.cursor`, so Cursor loads them as user skills).
  - How to add or change behavior: edit skills in this repo.
  - That User Rules in Cursor settings are no longer used for this setup.
- Remove or adjust references to "copy rules into User Rules" and to the old commands list if they are superseded by skills.

---

## Dependencies

- Cursor supports user-level skills in `~/.cursor/skills/`. This repo is `~/.cursor`, so `.cursor/skills/` is that directory.
- No other tooling required; file operations only.

---

## Acceptance Criteria

- All current rule content is available as skills and loaded by Cursor when relevant (no need to paste into User Rules).
- All current command behaviors are available via skills (aggregated by domain); agent follows them when user invokes or context matches.
- User Rules in Cursor settings are cleared; no manual copy from repo to Cursor.
- Single source of truth is clear: either repo `rules/` + `commands/` with skills generated, or repo `.cursor/skills/` only, with docs updated.
- README/docs describe the new model and how to maintain skills.

---

## Notes

- **Dotfiles:** This repo is `~/.cursor`; no deploy or symlink step for skills.
- **Character hygiene:** Preserve body content exactly when migrating; avoid reformatting or “fixing” to prevent gremlin characters or accidental changes.
- **disable-model-invocation:** Use `disable-model-invocation: true` for skills that replace slash commands so they are only applied when the user explicitly invokes them (e.g. via /command or clear intent).
- **Rule vs Linear commands:** One fat `linear` skill (rules + Linear CLI workflow) is preferable to two separate skills so the agent has one coherent context for “anything Linear.”
- **plans/** is in `.cursor/`; if `.cursor/plans/` is ever ignored or not synced to dotfiles, keep a copy of this plan in a location that is versioned and deployed with the rest of the setup.
