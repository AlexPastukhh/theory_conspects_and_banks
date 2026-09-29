# List range slicing, clamping, chunks, and windows

Knowledge ID: `dotnet.list-range-slicing-and-windows`

Topic: `dotnet`

`GetRange(index,count)` and `list[start..end]` validate bounds and copy into a new list/range. `Skip(start).Take(count)` is lazy and forgiving for user-controlled “as many as possible” semantics; materialize explicitly. `RemoveRange`/`InsertRange` mutate, with later elements shifted.

Clamp external start/count/end to `0..Count`, non-negative count, and end ≥ start before strict APIs. A custom iterator can clamp then `yield return` without allocating a collection; direct generated indexes still throw when invalid.

`Chunk(size)` produces non-overlapping arrays. Full sliding windows of width `w` have `Count - w + 1` starts, clamped at zero, and can be generated then sliced. `GetRange` copies O(selected count); Skip/Take may re-enumerate; range syntax copies; `RemoveRange` shifts. Use direct ranges for controlled indexes and validated/clamped behavior for external values.

## What should be recallable

- Explain the core model of **List range slicing, clamping, chunks, and windows** without opening the Unit.
- Reconstruct this Unit-grounded rule: `GetRange(index,count)` and `list[start..end]` validate bounds and copy into a new list/range.
- Reconstruct this Unit-grounded rule: Clamp external start/count/end to `0..Count`, non-negative count, and end ≥ start before strict APIs.
- Reconstruct this Unit-grounded rule: `Chunk(size)` produces non-overlapping arrays.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources
- Workspace: `_ai-conspects/range operations on list/`
- Processed source: `regions/final-transcript.md`, complete transcript and algorithms
