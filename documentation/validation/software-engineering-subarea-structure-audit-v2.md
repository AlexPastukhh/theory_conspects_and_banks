# Software Engineering Subarea Structure Audit v2

Status: current validation evidence for the semantic hierarchy after correction of v1 classifier errors.

## Why v2 was required

The first hierarchy pass was formally complete but over-trusted keyword assignment and then marked every row `CLEAR`. This produced false precision, including state-management `selectors` under CSS selectors, ASP.NET Options under request binding, SQL invariants under query shaping, and four non-host Units under Application Host & Lifecycle.

v2 changes the rule:

```text
Map v3 broad responsibility
+ Unit semantics
+ corpus cluster evidence
→ broad nested Area
→ narrower nested Area only when a durable multi-Unit cluster justifies it
```

A singleton Concept no longer needs a synthetic second nested-Area level.

## Result

- Knowledge IDs: **576 / 576**
- primary root Areas: **15**
- explicit Review Scopes: **576 / 576**
- rows with a structure change from v1: **94**
- root-Area corrections introduced by this review: **17**
- occupied broad nested Areas: **52 / 79**
- missing broad nested Areas: **27**
- distinct occupied logical paths: **106**
- path depth distribution (nested-Area nodes only): **{1: 24, 2: 552}**
- Knowledge Unit file moves: **0**
- repetition-state edits: **0**

## Confirmed correction classes

1. **Lexical collision fixes** — React Query/Zustand/Redux `selector` concepts no longer map to CSS selectors.
2. **Configuration boundary fixes** — ASP.NET Options binding/validation moved from request binding to Composition & Configuration.
3. **Application-host cleanup** — the four false host placements were moved; `Application Host & Lifecycle` is now an explicit corpus gap unless another Unit genuinely covers host/startup/shutdown/background-host semantics.
4. **API semantics corrections** — filtering/search, sorting, shaping and paging moved to A06 API contracts.
5. **Data/storage corrections** — invariants, MARS, database files, schema evolution and EF mapping/index configuration were separated by their actual responsibility.
6. **Concurrency corrections** — Lazy publication/thread-safety and per-key single-flight moved out of generic Task/Promise semantics.
7. **Variable hierarchy depth** — singleton lower nodes were collapsed to their durable broad Area instead of being promoted automatically.

## Representative corrected placements

| Knowledge ID | v1 | v2 |
|---|---|---|
| `react.zustand-selectors-async-actions-and-subscriptions` | CSS selectors | Client Data & State → Local State Stores |
| `react-query.selector-purity-observers-and-performance` | CSS selectors | Client Data & State → Server State & Cache Lifecycle |
| `aspnet-core.options-validation-and-startup-failure` | Request binding/validation | Composition & Configuration → Configuration & Options |
| `javascript.regex-operations-and-state` | A01 expression semantics | A05 Parsing, Validation & Serialization → Parsing & Pattern Processing |
| `sql-server.declarative-invariants-and-cross-row-enforcement` | Query shaping | Data Modeling & Integrity → Constraints & Invariants |
| `sql-server.mars-reader-interleaving-and-yield-points` | Query shaping | Storage & Database Systems → Connections & Sessions |
| `ef-core.composite-keys-relationships-and-indexes` | Query performance | Data Access & ORM → Mapping & Model Configuration |
| `aspnet-core.collection-filter-search-query-composition` | A07 middleware | A06 API Contracts & Resource Semantics → Collection Query, Pagination & Shaping |

## Gate

The v1 hierarchy is historical evidence only. `software-engineering-semantic-hierarchy-v2.csv` and `KNOWLEDGE-MAP.md` are the current logical assignment for subsequent migration work.

This pass validates semantic placement; it does not assign Retention Class, Recall State, review history, or physical folders.
