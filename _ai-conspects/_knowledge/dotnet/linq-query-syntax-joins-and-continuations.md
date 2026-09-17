# LINQ query syntax, joins, and continuations

Knowledge ID: `dotnet.linq-query-syntax-joins-and-continuations`

Topic: `dotnet`

LINQ query expressions are compiler syntax over LINQ operators. `from` introduces a range variable, `where` filters it, and `select` defines the result shape:

```csharp
var query =
    from item in source
    where Predicate(item)
    select Projection(item);

var equivalent = source
    .Where(item => Predicate(item))
    .Select(item => Projection(item));
```

Query syntax is often easier to read for several joins or range variables. Method syntax is often clearer for short pipelines and operators without a query-expression keyword.

## Inner join and group join

`join ... on ... equals ...` produces inner-join pairs. Adding `into` captures all inner matches for the current outer element as a sequence:

```csharp
var grouped =
    from customer in customers
    join order in orders
        on customer.Id equals order.CustomerId
        into customerOrders
    select new { Customer = customer, Orders = customerOrders };
```

`customerOrders` is the group of matched orders, not one `order`. `into` can also continue after `select` or `group`, making that result the new range variable for later clauses.

## Left join pattern

Query syntax builds a left join from a group join, `DefaultIfEmpty`, and a second `from`:

```csharp
var leftJoin =
    from customer in customers
    join order in orders
        on customer.Id equals order.CustomerId
        into customerOrders
    from order in customerOrders.DefaultIfEmpty()
    select new
    {
        Customer = customer,
        Order = order
    };
```

The sequence is important:

```text
group matching inner elements
-> turn an empty group into one default element
-> flatten with the second from
-> project an outer item plus a possibly-null/default inner item
```

Projection must account for the missing inner side. Multiple `from` clauses flatten/navigate a sequence in a `SelectMany`-like shape. They introduce another range variable; they do not create the grouped continuation that `join ... into`, `group ... into`, or `select ... into` creates.

## Concrete grouped-to-flat timeline

For customers Ann, Bob, and Cara, a grouped join can first produce:

```text
Ann  -> [Book, Pen]
Bob  -> [Bag]
Cara -> []
```

The second `from` then operates per outer item. Ann's group yields `Ann - Book` and `Ann - Pen`; Bob's yields `Bob - Bag`. Cara's empty group would produce no iteration at all, but `DefaultIfEmpty()` changes it to `[null]`, so it yields `Cara - null`.

```csharp
var leftJoin =
    from c in customers
    join o in orders on c.Id equals o.CustomerId into orderGroup
    from o in orderGroup.DefaultIfEmpty()
    select new
    {
        CustomerName = c.Name,
        Product = o?.Product
    };
```

The null-conditional access is part of the missing-inner boundary: for the preserved Cara row, `o` is `null`. Omitting the null handling and reading `o.Product` would fail for that row.

## What should be recallable

- How `from`/`where`/`select` correspond to method syntax.
- Inner join versus `join ... into` grouped matches.
- The four-stage left-join pattern and nullable inner result.
- How the empty group `[]` becomes one `null` row in the concrete left-join timeline.
- Multiple `from` flattening versus an `into` continuation.

## Sources

- Workspace: `_ai-conspects/linq-query-syntax/`
- Authoritative processed source: `regions/R01R02R03-linq-query-syntax-final.md`, R01-R03
- Original SVG: `source/linq-query-syntax.svg`
- Workspace: `_ai-conspects/linq-join-groupjoin-groupby-selectmany-selectmany-second-callback/`
- Authoritative processed source: `regions/LJG01-join-groupjoin-and-left-join-v001.md`, sections 1–3
- Materialized source SVG: `assets/raw/full.svg`
- Original source identity: `linq join groupjoin groupby selectmany,selectmany second callback.svg`
