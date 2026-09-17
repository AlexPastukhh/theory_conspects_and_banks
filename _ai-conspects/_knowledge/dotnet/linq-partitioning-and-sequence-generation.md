# LINQ partitioning and sequence generation

Knowledge ID: `dotnet.linq-partitioning-and-sequence-generation`

Topic: `dotnet`

`Skip`/`Take` partition by position. Offset pagination must have a stable order; without one, records can repeat or be skipped between requests. Large offsets still require the data source to pass over earlier rows, so keyset pagination can be more suitable for deep pages.

`SkipWhile` and `TakeWhile` are boundary operators. They evaluate from the start and change behavior at the first predicate failure; they are not equivalent to a `Where` that tests every element independently.

`Chunk(size)` emits non-overlapping arrays of at most `size`; the final chunk may be shorter. It rejects a non-positive size. `Range(start, count)` and `Repeat(value, count)` reject negative counts, while `Empty<T>()` supplies a reusable empty sequence. These construction methods are lazy where applicable, but terminal operations and repeated enumeration still determine work and side effects.

```csharp
var page = source
    .OrderBy(x => x.CreatedUtc)
    .ThenBy(x => x.Id)
    .Skip((pageNumber - 1) * pageSize)
    .Take(pageSize);
```

## Sources

- Workspace: `_ai-conspects/-all/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R05
- Original SVG: `source/-all.svg`
