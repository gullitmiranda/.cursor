---
description: Strip gremlin/invisible Unicode from current file or given path(s)
---

# Gremlin Clean

Strip gremlin/invisible Unicode characters from files.

1. **Target**: If the user provided path(s), use those; otherwise use the currently focused or last-edited file.
2. **Run**: `python3 ~/.cursor/scripts/strip-gremlins.py <path> [path ...]` (from the workspace or repo containing the file). If this config is not at ~/.cursor, use the path to `scripts/strip-gremlins.py` in this repo (e.g. `python3 .cursor/scripts/strip-gremlins.py`).
3. **Report**: Say which files were cleaned (script prints "cleaned" or "no change" per file).

The script replaces irregular spaces with U+0020 and removes zero-width/control/separator characters. Use when linters report `no-irregular-whitespace` or when you suspect gremlins in AI-generated text.
