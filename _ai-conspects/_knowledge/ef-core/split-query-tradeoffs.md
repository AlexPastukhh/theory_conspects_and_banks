# EF Core split-query tradeoffs

Knowledge ID: `ef-core.split-query-tradeoffs`

Topic: `ef-core`

`AsSplitQuery` loads a root and collection Include branches with multiple statements. Sibling collections cross-multiply rows, including repeated wide roots; for 200 roots with sibling collections of 5 and 3 rows, a single query returns about 3,000 rows while split returns about 1,800. A pure deep chain does not create the same sibling explosion and split can return more total rows: a 200 × 5 × 4 chain is about 4,000 joined rows versus about 5,200 split rows. Reference navigations may join within a branch.

Each branch adds round trips, command/startup, reading, materialization, and fix-up. Providers may buffer earlier resultsets; MARS reduces one buffering case, but retry and application buffering can stack. Multiple statements also allow intervening changes; choose single query, suitable snapshot/serializable transaction, projection, or accept the UI-read window.

Affected EF versions require fully unique ordering with split Skip/Take. `IgnoreAutoIncludes` disables model eager loading. Explicit loading chooses what/when for a tracked root; split coordinates an Include graph. Projection is often best for subsets. Prefer split for wide sibling branches and single query for small graphs or one-statement consistency—measure latency, rows, width, and memory.

## Sources
- Workspace: `_ai-conspects/assplitquery/`
- Processed source: `01-final-transcript.md`, complete transcript
