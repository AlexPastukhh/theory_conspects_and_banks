# Repository verification before Lazy correction

Generated: 2026-07-01

## Previous archive status

Successfully present on branch:

```text
js loops:
- CURRENT_SOURCE_OF_TRUTH.md
- 01-source-preserving-transcript-v001.md

SYSTEM.TEXT.JSON SER SER:
- CURRENT_SOURCE_OF_TRUTH.md
- 02-source-preserving-transcript-v002.md

computed columns:
- CURRENT_SOURCE_OF_TRUTH.md
- 02-source-preserving-transcript-v002.md
```

Outstanding inconsistency found:

```text
SYSTEM.TEXT.JSON SER SER/source/SYSTEM.TEXT.JSON SER SER.svg
    declared by Current Source of Truth
    missing from GitHub branch

computed columns/source/computed columns.svg
    declared by Current Source of Truth
    missing from GitHub branch
```

Cause:

```text
the SVG files are ignored by a repository rule and were not staged by ordinary git add
```

This archive contains both files. They must be staged with `git add -f`.
