# Plan: AI Config Dotfiles Repository (Future)

**Status:** Plan only. Do not execute until explicitly requested.

## Objective

Evolve the current repository from "Cursor-only dotfiles" into a single **AI config dotfiles** repository that holds configuration for all AI coding agents (Cursor, Codex, and any others). One repo, one place to version and sync rules, skills, and agent-specific settings across tools and machines.

---

## Tasks

### 1. Define scope and target agents

- List agents to support initially (e.g. Cursor, Codex).
- Optionally list future agents (e.g. Windsurf, Zed AI, Claude Code, Cline) so the layout can accommodate them without big renames later.
- Document where each agent expects its config (e.g. `~/.cursor`, `~/.codex`) for reference in install/deploy logic.

### 2. Design repository layout

- Choose repo root name: **`ai-config`** (covers dotfiles and any other config—env, scripts, non-dotfile configs).
- Define a directory per agent, e.g.:
  - `cursor/` – contents of current `~/.cursor` (rules, skills, commands, hooks, docs, plans).
  - `codex/` – contents of `~/.codex` (or equivalent) that should be versioned (skills, config; exclude secrets/local state).
  - `shared/` (optional) – rules or snippets reused across agents (e.g. character-hygiene, conventional commits); each agent’s install can copy or symlink what it needs.
- Decide what stays at repo root: README, LICENSE, single install/setup script, and optionally a top-level `.gitignore` that applies to the whole repo.

### 3. Migrate Cursor config into new layout

- **Classify and separate plans** before or during the move: identify which plans are **general Cursor/ai-config** (e.g. rules migration, skills migration, this ai-config repo plan) vs **project-specific** (e.g. GCP, platform tools, CW-sec, other product repos). At some point everything got mixed in `plans/`. Only general plans should live in ai-config; project-specific ones must be moved to their respective project repos or archived elsewhere so the ai-config repo stays about config only. Document criteria (e.g. "applies to any project" = general; "applies to repo X" = move to X).
- Move current repo contents (e.g. everything that is today the “.cursor” project) into `cursor/` (or the chosen agent subdir).
- Adjust paths in docs and scripts so they refer to the new structure (e.g. “Cursor config lives in `cursor/`”).
- Ensure `.gitignore` and any per-agent ignores still exclude secrets and local state (e.g. `cursor/mcp.json`, `cursor/extensions/`).

### 4. Add Codex (and others) config

- Create `codex/` (and optionally other agent dirs) with only the parts that are safe to version (e.g. skills; exclude tokens/local data).
- Add or reuse a `.gitignore` so agent-specific secrets and caches are not committed.
- Document in README what each directory contains and what the agent expects (e.g. “Codex reads from `~/.codex`”).

### 5. Install / deploy mechanism

- Provide a way to “install” the repo so each agent sees its config in the right place:
  - **Option A:** Symlinks – e.g. `~/.cursor` → `repo/cursor`, `~/.codex` → `repo/codex` (or symlink only selected subdirs if the agent allows).
  - **Option B:** Install script – copy or symlink each agent’s directory to its canonical path, with idempotent and safe behavior (backup existing dirs, no overwrite of secrets).
- Document in README how to run install (e.g. `./install` or `make install`) and how to add a new machine (clone repo, run install).

### 6. Shared content (optional)

- If using a `shared/` (or similar) directory, define which files are shared (e.g. character-hygiene, commit message rules) and how each agent consumes them (copy into agent dir at install time, or symlink). Avoid duplication where possible while keeping each agent’s tree self-contained if needed.

### 7. Documentation and README

- Single README at repo root describing:
  - Purpose: one repo for all AI agent configs.
  - Layout: one directory per agent, optional shared.
  - Prerequisites and install steps.
  - How to add a new agent or a new machine.
- Per-agent README or section (e.g. `cursor/README.md`) with agent-specific notes (where Cursor looks for skills, how to add a skill, etc.).
- Document what is **not** versioned (secrets, API keys, local state) and how to configure those per machine.

### 8. Cleanup and validation

- Remove or archive any obsolete “deploy skills” or “symlink to ~/.cursor” steps from plans/docs that assumed a different repo shape.
- Test install on a clean environment (or document manual checks) so that after install, Cursor and Codex (and any other added agents) load config from the repo-backed paths.

---

## Setup process (new machine or first install)

1. **Clone the repo** to a stable path (e.g. `~/Code/ai-config`). No need to clone into `~/.cursor` or `~/.codex`.

2. **Run the install script** from the repo root:
   - `./install` or `make install` (or the chosen entrypoint).
   - Script is **idempotent**: safe to run again (e.g. after pull).

3. **What the install does:**
   - For each agent you enable (e.g. Cursor, Codex):
     - If `~/.cursor` (or `~/.codex`) already exists: **backup** to `~/.cursor.bak.<date>` (or similar), then replace with a **symlink** to `repo/cursor` (or `repo/codex`). Backup must be complete so **nothing is lost** (all files and dirs preserved in the backup).
     - If it does not exist: create the symlink directly.
   - **Never overwrite** files that are listed as “local only” (e.g. `mcp.json`, tokens). Options: skip if present, or symlink only subdirs and leave the rest for the user to create.
   - Optionally: copy or symlink items from `shared/` into each agent tree if the layout requires it.

4. **Per-machine (manual, one-time):**
   - Create or copy any **secrets / local config** the agents need (e.g. `cursor/mcp.json`, API keys, env vars). Document in README what each agent expects and what is not versioned.

5. **Ongoing:** Pull from repo when config changes; re-run install only if the script or symlink layout changes. Normal workflow is edit in `~/Code/ai-config`, commit and push; agents read via the symlinks.

---

## Dependencies

- Current Cursor migration (rules/commands → skills) can be done before or after this refactor; if after, do the migration inside the new `cursor/` layout.
- No dependency on specific OS beyond shell and symlink/copy support; install script should be portable or document OS differences.

---

## Acceptance Criteria

- One repository contains config for at least Cursor and Codex (and is structured to add more agents).
- Layout is clear: one directory per agent, optional shared directory.
- Install/deploy step (script or documented symlinks) makes each agent use the repo-backed config without overwriting secrets.
- README explains purpose, layout, install, and how to add agents or machines.
- Existing Cursor setup continues to work from its new location under the repo (e.g. `cursor/`).

---

## Notes

- **Secrets:** Never commit API keys, tokens, or machine-specific state. Use `.gitignore` and document required env vars or config that must be created locally.
- **Backward compatibility / separation:** Today the repo and `~/.cursor` are the same (e.g. `~/.cursor` → `Gullit/.cursor`). During rollout we must **separate** them: the repo becomes `ai-config` (e.g. `~/Code/ai-config`), and `~/.cursor` becomes a symlink only to `ai-config/cursor`, not to the repo root. **Migration must be done without losing anything** — no files, settings, or local config may be dropped. One-time migration: clone or move repo to `~/Code/ai-config`, move current contents into `cursor/` (preserving everything, including unversioned/local files or backing them up), then point `~/.cursor` → `~/Code/ai-config/cursor`. Document this in README and consider a checklist or script that verifies nothing was left behind.
- **Plans:** After refactor, plans can live under `cursor/plans/` or a top-level `plans/`; decide and keep references consistent. Before that, **plans must be classified**: general (Cursor/ai-config) stay in this repo; project-specific (other repos’ work) are moved to those repos or archived so they are not lost but no longer mixed with config plans.
- This plan is **not** to be executed until you explicitly request it; it is a placeholder for the future AI-config dotfiles repo.
