---
name: Commit docs update
overview: Commit the staged documentation changes to the release notes generator prompt file on the v3-beta branch.
todos: []
---

# Commit Documentation Changes

## Analysis

**Branch**: `v3-beta` (safe to commit - not main/master)
**Staged file**: `scripts/release-notes/v3-beta-prompt.md`
**Change type**: `docs` - documentation improvements

## Changes Summary

The staged changes improve the release notes generator prompt:

1. Added markdownlint disable comment for inline HTML
2. Added `gcloud auth login` step to installation instructions (was missing)
3. Fixed nested markdown code block formatting (changed to `<markdown>` tags to avoid escaping issues)
4. Added authentication comments to example output

## Commit Details

**Type**: `docs`
**Scope**: `release-notes`
**Message**:

```
docs(release-notes): improve v3-beta prompt with auth step and formatting fixes

- Add gcloud auth login step to installation instructions
- Fix nested markdown code block formatting in example output
- Add markdownlint disable comment for inline HTML
```

## Execution

1. Run git commit with the message above
2. Verify commit was successful with `git log -1`
