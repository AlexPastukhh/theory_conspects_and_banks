# EF Core substring and LIKE search

Knowledge ID: `ef-core.search-with-like`

Topic: `ef-core`

## Core model

LINQ `Contains` generally translates to substring matching such as `LIKE '%term%'`; it is not SQL Server full-text `CONTAINS`. Prefix patterns can often use B-tree indexes more effectively than leading-wildcard patterns.

Escape `%`, `_`, `[`, and the chosen escape character before passing user input to `EF.Functions.Like`. Case behavior follows provider and collation; avoid applying `ToLower()` to an indexed column without understanding index effects.

Build a composable `AsNoTracking` query, apply selective tenant/category filters where possible, then broad text predicates, ordering, paging, and projection.

## What should be recallable

- `Contains` translation; prefix versus leading wildcard; LIKE escaping; collation impact; query composition order.

## Sources

- Workspace: `_ai-conspects/searching impl, ef core, full text search,sql server/`
- Processed source: `02-corrected-semantic-transcript-v002.md`, sections 1–5 and 15
- Original SVG: `source/searching impl, ef core, full text search,sql server.svg`
