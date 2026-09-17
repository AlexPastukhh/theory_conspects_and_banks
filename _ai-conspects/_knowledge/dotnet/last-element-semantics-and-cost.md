# LINQ and indexed last-element semantics

Knowledge ID: `dotnet.last-element-semantics-and-cost`

Topic: `dotnet`

`Last` throws for empty/no matching element; `LastOrDefault` returns the type default, or an explicit fallback on supported frameworks. A legitimate default value makes absence ambiguous, so use nullable projection, explicit existence, or an option/result when needed.

Arrays/lists use `[^1]` or count-minus-one after an empty check; `^0` is the boundary after the last item, not an element. Direct access is O(1), though concurrent mutation can invalidate a previously observed count. LINQ-to-Objects can optimize `IList<T>`, but a general enumerable traverses O(n); predicates retain the latest match. Calling `Any()` first can add an extra pass, so prefer one-pass result shapes for streams. Infinite sources never complete, single-use streams should not be enumerated twice, and repeated calls repeat work.

For `IQueryable`, “last” requires deterministic `OrderBy`; providers may reject/rewrite shapes. `OrderByDescending(key).FirstOrDefault()` or `MaxBy` may express latest-by-key better. Order/limit on the server rather than materializing, and inspect generated SQL for provider-specific translation. Avoid `Count()` then `Last()` on general sequences.

## Sources
- Workspace: `_ai-conspects/sheet get last/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
