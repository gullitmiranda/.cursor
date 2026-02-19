# Gremlin Characters: Cursor, Claude, and LLMs

This doc summarizes why invisible/gremlin characters keep appearing in AI-generated text and what helps.

## Known issue (Cursor + LLMs)

- **Cursor forum**: [Irregular Whitespace with AI generated Text](https://forum.cursor.com/t/irregular-whitespace-with-ai-generated-text/96815) — users get `no-irregular-whitespace` lint errors; the problematic characters persist even after deleting and retyping lines. The linter pattern cited is `[\u00A0\u1680\u180E\u2000-\u200A\u202F\u205F\u3000\u200B]`.
- **Related**: [Composer adding spaces and breaks in the applied file](https://forum.cursor.com/t/composer-adding-spaces-and-breaks-in-the-applied-file/26951), [Invisible Characters (BOM)](https://forum.cursor.com/t/invisible-characters-bom/75867), [Trailing whitespaces in generated code](https://forum.cursor.com/t/trailing-whitespaces-in-generated-code/28957).
- **Cause**: LLMs (including Claude) can **emit** these characters as part of tokenization/generation; it is not only a matter of "following rules." So rules in skills/project rules reduce but do not fully eliminate the problem.
- **Security**: Invisible Unicode is also used for prompt injection and backdoors (e.g. [Promptfoo - Invisible Unicode threats](https://www.promptfoo.dev/blog/invisible-unicode-threats/), [LLM Guard - Invisible Text](https://protectai.github.io/llm-guard/input_scanners/invisible_text/)).

## Full list of "irregular" / gremlin characters (match ESLint + extras)

Use only **U+0020** (space) and **LF/CRLF** for spaces and line breaks. Avoid:

| Code point            | Name                                                                                                                                 |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| U+00A0                | Non-breaking space (NBSP)                                                                                                            |
| U+00AD                | Soft hyphen                                                                                                                          |
| U+1680                | Ogham space                                                                                                                          |
| U+180E                | Mongolian vowel separator                                                                                                            |
| U+2000–U+200A         | En quad, em quad, en space, em space, three-per-em, four-per-em, six-per-em, figure space, punctuation space, thin space, hair space |
| U+200B                | Zero-width space (ZWSP)                                                                                                              |
| U+200C                | Zero-width non-joiner (ZWNJ)                                                                                                         |
| U+200D                | Zero-width joiner (ZWJ)                                                                                                              |
| U+2028                | Line separator                                                                                                                       |
| U+2029                | Paragraph separator                                                                                                                  |
| U+202F                | Narrow no-break space                                                                                                                |
| U+205F                | Medium mathematical space                                                                                                            |
| U+2060                | Word joiner (invisible)                                                                                                              |
| U+2063                | Invisible separator                                                                                                                  |
| U+3000                | Ideographic space                                                                                                                    |
| U+FEFF                | BOM / zero-width no-break space                                                                                                      |
| U+0000–U+001F, U+007F | Control characters                                                                                                                   |

## Claude Code (no User Rules)

Claude Code does not have a "User Rules" / "Rules for AI" setting. Use its own mechanism for persistent instructions:

- **Global (all projects):** Put the constraint in **`~/.claude/CLAUDE.md`** or in **`~/.claude/rules/`** (e.g. `~/.claude/rules/character-hygiene.md`). Files in `~/.claude/rules/` are loaded for every session; project-level `.claude/rules/` override for that project.
- **Per project:** Add to the project's **`CLAUDE.md`** or **`.claude/rules/*.md`**.

**Text to add (global or project):**

```markdown
## Output hygiene (gremlin characters)

Never use invisible or zero-width Unicode in any output. Use only standard space (U+0020) and normal line breaks (LF/CRLF). No zero-width (U+200B, U+200C, U+200D, U+2060, U+2063), no non-breaking or other irregular spaces (U+00A0, U+1680, U+180E, U+2000–U+200A, U+202F, U+205F, U+3000, U+FEFF), no line/paragraph separators (U+2028, U+2029). Rewrite pasted content as clean text; do not copy raw.
```

To apply everywhere in Claude Code: create `~/.claude/rules/character-hygiene.md` with the heading and text above.

## What actually helps

1. **Cursor:** Put the constraint in **Settings → Rules for AI** (global). **Claude Code:** Add `~/.claude/rules/character-hygiene.md` with the text above (global).
2. **Skills:** The quality skill defines the constraint; Cursor loads it when relevant. Optional: in a project, add `.cursor/rules/character-hygiene.mdc` with `alwaysApply: true` if you want it always in context there.
3. **Cleanup:** Run **`/gremlin-clean`** (defined in `commands/gremlin-clean.md`) to strip gremlins from files. Linters (e.g. `no-irregular-whitespace`) and [VS Code extension](https://forum.cursor.com/t/i-built-a-vs-code-extension-to-protect-vibe-coders-from-ascii-smuggling-and-hidden-characters/85449) also help.
4. **Don't rely only on the model** — combine rules + linter + cleanup.

## References

- [Cursor Forum: Irregular Whitespace with AI generated Text](https://forum.cursor.com/t/irregular-whitespace-with-ai-generated-text/96815)
- [Promptfoo: Invisible Unicode threats in AI-generated code](https://www.promptfoo.dev/blog/invisible-unicode-threats/)
- [LLM Guard: Invisible Text scanner](https://protectai.github.io/llm-guard/input_scanners/invisible_text/)
- [SageX: Zero-Width Char Obfuscation in LLM Applications](https://sagexai.com/guardrails/llm_zero_width_char_obfuscation)
