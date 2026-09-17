# LINQ projection, flattening, and ordering

Knowledge ID: `dotnet.linq-projection-flattening-and-ordering`

Topic: `dotnet`

`Select` maps each input to one output. `SelectMany` maps each input to a sequence and flattens those sequences. Its result-selector overload keeps both the outer item and each flattened inner item available:

```csharp
var lines = orders.SelectMany(
    order => order.Lines,
    (order, line) => new { order.Id, Line = line });
```

Without a result selector, only the flattened inner elements are returned. For example:

```csharp
var children = parents.SelectMany(parent => parent.Children);
```

Given `P1 -> [C1, C2]`, `P2 -> [C3]`, and `P3 -> [C4, C5]`, this produces `[C1, C2, C3, C4, C5]`.

The two-callback overload separates two decisions:

```csharp
var rows = parents.SelectMany(
    parent => parent.Children,                    // collection selector
    (parent, child) => new                        // result selector
    {
        ParentName = parent.Name,
        ChildName = child.Name
    });
```

The collection selector chooses the inner sequence to flatten for each outer value. The result selector then runs once for every outer/flattened-inner pair, so it can retain information from both. For `P1 -> [C1, C2]` and `P2 -> [C3]`, the results are `(P1,C1)`, `(P1,C2)`, and `(P2,C3)` projected into three flat objects.

The same mechanics explain a flattened grouped join:

```csharp
.SelectMany(
    x => x.orderGroup.DefaultIfEmpty(),
    (x, order) => new
    {
        CustomerName = x.c.Name,
        Product = order?.Product
    })
```

Here the first callback supplies `[Book, Pen]`, `[Bag]`, or `[null]` for an outer customer. The second callback combines the customer-bearing object `x` with each flattened order; it runs twice for Ann and once with `null` for an unmatched Cara.

`OrderBy`/`OrderByDescending` start an ordering. `ThenBy`/`ThenByDescending` add tie-breakers; a second `OrderBy` starts over instead of extending the previous keys. LINQ-to-Objects ordering is stable, so equal keys retain source order. `Reverse` merely reverses the current sequence; it is not a substitute for specifying a descending key.

Ordering is deferred but buffered: the source is consumed and its elements retained before ordered results can be produced. Re-enumeration repeats that work. Comparers define ordering semantics, so text ordering should select an intentional culture/ordinal and case policy. For `IQueryable`, only provider-supported comparers and expressions translate. Never rely on database row order without explicit ordering, and give pagination a deterministic order.

## What should be recallable

- Why does `SelectMany` change cardinality while `Select` does not?
- When is the result-selector overload useful?
- What separate roles do the collection selector and result selector play?
- How does the parent/child example preserve outer data while still producing one flat sequence?
- Why does `ThenBy` preserve earlier keys but another `OrderBy` not?
- How can ordering be deferred and still require buffering?

## Sources

- Workspace: `_ai-conspects/-all/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R01
- Original SVG: `source/-all.svg`
- Workspace: `_ai-conspects/linq-join-groupjoin-groupby-selectmany-selectmany-second-callback/`
- Authoritative processed source: `regions/LJG03-selectmany-flattening-and-result-selector-v001.md`, sections 1–3
- Materialized source SVG: `assets/raw/full.svg`
- Original source identity: `linq join groupjoin groupby selectmany,selectmany second callback.svg`
