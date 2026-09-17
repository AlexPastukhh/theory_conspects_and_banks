# IN, EXISTS, ANY, and anti-join semantics

Knowledge ID: `sql.subquery-membership-and-existence`

Topic: `sql`

## Core model

SQL offers related constructs for comparing values with subquery results and testing whether related rows exist. Choose the form that expresses the intended relationship clearly.

`IN` compares one value with a literal list or the values returned by a subquery:

```sql
SELECT *
FROM Orders
WHERE customer_id IN
(
    SELECT id
    FROM Customer
    WHERE active = 1
);
```

`EXISTS` tests whether a correlated subquery produces at least one row:

```sql
SELECT c.*
FROM Customer AS c
WHERE EXISTS
(
    SELECT 1
    FROM Orders AS o
    WHERE o.customer_id = c.id
);
```

It naturally expresses relationship or existence checks.

## ANY, SOME, and ALL

`ANY` and its synonym `SOME` apply a comparison against the returned values:

```sql
SELECT *
FROM Product
WHERE price > ANY
(
    SELECT price
    FROM CompetitorProduct
);
```

```text
x = ANY(subquery)
  -> broadly similar to x IN(subquery);

x > ANY(subquery)
  -> greater than at least one returned value;

x > ALL(subquery)
  -> greater than every returned value.
```

For an empty subquery, `comparison ANY (empty set)` is false. With nullable results, one true comparison makes `ANY` true; otherwise an unknown comparison can make the result unknown instead of false.

## NOT IN and NULL

`NOT IN` can produce surprising unknown results when the subquery contains `NULL`. A correlated `NOT EXISTS` expresses an anti-join without that particular trap:

```sql
SELECT c.*
FROM Customer AS c
WHERE NOT EXISTS
(
    SELECT 1
    FROM Orders AS o
    WHERE o.customer_id = c.id
);
```

## Performance boundary

Modern optimizers often transform logically equivalent forms into semi-joins. Select the construct for clear intent first, then inspect execution plans and indexes for significant workloads rather than assuming one spelling is always faster.

## What should be recallable

- How do `IN` and correlated `EXISTS` express different forms of intent?
- What do `ANY`/`SOME` and `ALL` require from the comparison?
- Why can `NOT IN` behave unexpectedly when a subquery contains `NULL`?
- How does correlated `NOT EXISTS` express an anti-join?
- Why should performance decisions be checked with plans and indexes?

## Sources

- Workspace: `_ai-conspects/any in exists/`
- Processed source: `01-final-transcript.md`, complete semantic region
- Original SVG: `source/any in exists.svg`
- Additional workspace: `_ai-conspects/in any exist, some/`
- Additional processed source: `01-final-transcript.md`, R01–R03
- Additional SVG: `source/in any exist, some(1).svg`
