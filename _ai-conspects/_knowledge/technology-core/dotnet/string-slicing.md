# C# substring, ranges, spans, and text boundaries

Knowledge ID: `dotnet.string-slicing`

Topic: `dotnet`

## Core model

`Substring(start, length)` uses a zero-based start plus character count, not an end index. Ranges use an exclusive end: `text[start..end]`, `text[start..]`, and `text[..end]`; `^` indexes from the end.

Invalid ranges throw. Validate external/search-derived boundaries and check `IndexOf` for `-1`. Modern substring/range operations allocate new strings; `AsSpan` supports transient slicing without immediate string allocation.

Indices address UTF-16 code units, so slicing can split surrogate pairs or combining sequences. Use rune or text-element APIs for user-perceived characters.

## What should be recallable

- Count versus exclusive-end semantics; valid empty slices; boundary validation; allocation behavior; span use; Unicode boundary risk.

## Sources

- Workspace: `_ai-conspects/SUBSTRING/`
- Processed source: `04-full-combined-final-transcript.md`, R01–R03
- Original SVG: `source/SUBSTRING.svg`
