# LINQ grouping, lookup, and joins

Knowledge ID: `dotnet.linq-grouping-lookup-and-joins`

Topic: `dotnet`

`GroupBy` is deferred and creates groups as the result is enumerated. Each group exposes a `Key` and an enumerable of matches. Element-selector overloads project values while grouping; result-selector overloads shape the final group result. `ToLookup` executes immediately and builds a reusable one-to-many index. Both allow several values per key; `ToDictionary` requires one value per key and throws on duplicates unless the input is resolved first.

## `Join` versus `GroupJoin` result shape

`Join` receives an outer sequence, an inner sequence, a key selector for each side, and a result selector. It produces one result for every pair whose selected keys are equal; its result selector therefore combines one outer element with one matching inner element. Duplicate keys multiply results.

```csharp
var rows = customers.Join(
    orders,
    customer => customer.Id,
    order => order.CustomerId,
    (customer, order) => new
    {
        CustomerName = customer.Name,
        order.Product,
        order.Price
    });
```

`GroupJoin` keeps one result per outer element and supplies that result with the complete sequence of its inner matches:

```csharp
var grouped = customers.GroupJoin(
    orders,
    customer => customer.Id,
    order => order.CustomerId,
    (customer, customerOrders) => new
    {
        CustomerName = customer.Name,
        Orders = customerOrders
    });
```

An outer element with no matches is still present with an empty sequence. This grouped result can be flattened into either inner-join or left-outer-join shapes. For customers Ann, Bob, and Cara, the intermediate shape can be understood as:

```text
{ c = Ann,  orderGroup = [Book, Pen] }
{ c = Bob,  orderGroup = [Bag] }
{ c = Cara, orderGroup = [] }
```

## Left join by grouped matching and flattening

Because `GroupJoin` preserves that empty group, it is the basis of the usual left-join pattern:

```csharp
var left = outer
    .GroupJoin(inner, o => o.Id, i => i.ParentId,
        (o, matches) => new { o, matches })
    .SelectMany(
        x => x.matches.DefaultIfEmpty(),
        (x, i) => new { Outer = x.o, Inner = i });
```

The stages have distinct effects:

```text
GroupJoin
-> one outer item plus its sequence of matches
-> DefaultIfEmpty changes [] into [default]
-> SelectMany flattens the per-outer sequences
-> result selector combines the outer and possibly-default inner value
```

For Ann, `[Book, Pen]` becomes two rows; for Bob, `[Bag]` becomes one. Cara's empty group becomes `[null]`, so flattening yields one `Cara - null` row instead of dropping Cara. A reference-type projection must therefore handle the absent inner item, for example with `o?.Product`.

## `GroupBy` groups and summary projection

`GroupBy` partitions one input sequence into `IGrouping<TKey,TElement>` values. Each group exposes its grouping key as `Key` and is itself the enumerable of elements in that bucket:

```csharp
var groups = orders.GroupBy(order => order.CustomerId);
```

For `Book(CustomerId = 1)`, `Pen(CustomerId = 1)`, and `Bag(CustomerId = 2)`, the raw groups are:

```text
Group Key = 1, Elements = [Book, Pen]
Group Key = 2, Elements = [Bag]
```

A following projection can turn every group into one summary row:

```csharp
var summary = orders
    .GroupBy(o => o.CustomerId)
    .Select(g => new
    {
        CustomerId = g.Key,
        Count = g.Count(),
        Total = g.Sum(x => x.Price)
    });
```

With `Book(10)` and `Pen(2)` in group 1, `g.Key`, `g.Count()`, and `g.Sum(...)` produce `CustomerId 1 -> Count 2, Total 12`. A second group containing one item priced at 25 produces `CustomerId 2 -> Count 1, Total 25`.

## Choosing by result shape and execution boundary

Choose by result shape: grouping partitions one sequence, joining correlates two sequences, and a lookup supports repeated key-based retrieval. Hash-based lookup/join work is normally linear on average but still consumes memory and depends on a matching equality comparer. The query provider may translate relational joins but not an in-memory comparer or a nested grouping shape.

## What should be recallable

- Which five inputs define `Join`, and why can it emit several rows for one outer item?
- How does the result shape of `GroupJoin` differ from `Join`, including an outer item with no matches?
- Why do `DefaultIfEmpty` and `SelectMany` together preserve and flatten a left-join row?
- What does an `IGrouping<TKey,TElement>` expose, and how does `Select` turn a group into an aggregate summary?
- When do grouping, joining, and a reusable lookup solve different result-shape needs?

## Sources

- Workspace: `_ai-conspects/-all/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R02
- Original SVG: `source/-all.svg`
- Workspace: `_ai-conspects/linq-join-groupjoin-groupby-selectmany-selectmany-second-callback/`
- Authoritative processed sources: `regions/LJG01-join-groupjoin-and-left-join-v001.md`, sections 1–3; `regions/LJG02-groupby-group-shape-and-projection-v001.md`, sections 1–2
- Materialized source SVG: `assets/raw/full.svg`
- Original source identity: `linq join groupjoin groupby selectmany,selectmany second callback.svg`
