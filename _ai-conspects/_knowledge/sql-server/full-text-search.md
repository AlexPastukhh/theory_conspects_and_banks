# SQL Server full-text search model and APIs

Knowledge ID: `sql-server.full-text-search`

Topic: `sql-server`

## Core model

A SQL Server full-text index is token-oriented, unlike a B-tree ordered by complete column values. A unique `KEY INDEX` links token occurrences back to base rows; it is neither searched text nor rank.

`CONTAINS` accepts structured word, phrase, Boolean, prefix-token, proximity, weighted, and inflectional expressions. `FREETEXT` performs broader natural-language matching. `CONTAINSTABLE` and `FREETEXTTABLE` return `KEY` and `RANK` for joins and ordering.

Full-text search is not arbitrary substring search: token `board` does not normally match `keyboard`. Use LIKE for small exact substring needs, SQL full-text for database word search/ranking, and a dedicated engine for typo tolerance, facets, highlighting, synonyms, semantic/vector search, or large scale.

## What should be recallable

- Inverted-index model; purpose of KEY INDEX; CONTAINS versus FREETEXT; table-valued ranking; token versus substring boundary; backend selection.

## Sources

- Workspace: `_ai-conspects/searching impl, ef core, full text search,sql server/`
- Processed source: `02-corrected-semantic-transcript-v002.md`, sections 6–15
- Original SVG: `source/searching impl, ef core, full text search,sql server.svg`
