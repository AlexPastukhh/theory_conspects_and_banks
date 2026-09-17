# LINQ materialization, casting, and provider boundaries

Knowledge ID: `dotnet.linq-materialization-casting-and-provider-boundaries`

Topic: `dotnet`

`ToList` and `ToArray` execute and snapshot a sequence. `ToDictionary` creates one value per unique key and throws on duplicate keys; `ToLookup` creates a one-to-many index; `ToHashSet` materializes unique values under an equality comparer. Choose the output shape to match duplicate and lookup semantics rather than using every materializer interchangeably.

Deferred pipelines can observe later source changes and repeat expensive or stateful work on every enumeration. Materialization freezes the current results and costs memory. Place that boundary intentionally—commonly before repeated traversal or when values must outlive a source—but avoid early materialization that moves filtering, ordering, or paging from a capable database provider into memory.

`Cast<T>` requires every element to be compatible and throws when one is not; use it when heterogeneous values indicate invalid state. `OfType<T>` filters to compatible non-null elements and fits intentionally mixed sequences. `AsEnumerable` does not execute the query; it changes subsequent operator binding from provider expressions to LINQ-to-Objects. Keep `IQueryable` operations server-side as long as filtering, ordering, and paging must translate, then cross the client boundary deliberately.

## Sources

- Workspace: `_ai-conspects/-all/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R06
- Original SVG: `source/-all.svg`
