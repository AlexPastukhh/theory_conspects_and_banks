# LINQ element selection and set semantics

Knowledge ID: `dotnet.linq-element-selection-and-set-semantics`

Topic: `dotnet`

`First` means at least one result is required. Use it when several matches are valid and one representative is enough. `Single` asserts exactly one result and therefore checks for a second match; use it when multiple matches mean broken invariants or invalid data, not merely because today's dataset happens to contain one row. The `OrDefault` variants replace the no-result exception with `default`; they do not hide the multiple-result error of `SingleOrDefault`. A legitimate default value can make absence ambiguous, so use nullable/option/result-shaped output when the distinction matters.

`ElementAt` selects by position and throws outside the sequence; `ElementAtOrDefault` returns default. `Last` may use indexed access for lists but must traverse a general enumerable. Predicate overloads apply the same cardinality rule after filtering.

`Distinct`, `Union`, `Intersect`, and `Except` use equality semantics and remove duplicates from their set-shaped results. They do not promise semantic sorting. `SequenceEqual` instead compares length, order, and pairwise equality. Select a comparer deliberately, and use key-selector variants such as `DistinctBy` when identity is one projection rather than whole-object equality.

These methods operate on enumeration order and equality contracts, not database constraints. `IQueryable` translation, ordering, and comparer support are provider-specific.

## Sources

- Workspace: `_ai-conspects/-all/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R04
- Original SVG: `source/-all.svg`
