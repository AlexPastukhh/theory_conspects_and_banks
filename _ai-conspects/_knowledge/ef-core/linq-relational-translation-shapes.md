# EF Core LINQ relational translation shapes

Knowledge ID: `ef-core.linq-relational-translation-shapes`

Topic: `ef-core`

## Translation pipeline

An EF Core query starts as an expression tree. The provider translates supported server-side operations, parameterizes the command, executes it, and materializes results. `Where` becomes predicates, `Select` determines projection, ordering/pagination map to provider SQL, and scalar `Any` commonly becomes `EXISTS`.

Use `ToQueryString` and EF command logging to inspect the actual SQL for the provider and version. Similar-looking LINQ is not proof of the same relational shape.

## JOIN shapes and filter placement

A query-syntax `join` is an equality join between outer and inner keys. A correlated multiple-`from` whose inner sequence has a `Where` predicate commonly translates to `INNER JOIN`. Adding `DefaultIfEmpty` produces a left-join shape. Independent inner sequences produce `CROSS JOIN`.

Filter placement changes semantics. Applying a null-rejecting `Where` after a left join can remove the null-extended rows and collapse the effective result to an inner join. Correlating/filtering the inner side before `DefaultIfEmpty` preserves the intended outer rows.

## `APPLY` for per-outer-row work

When the right expression depends on the outer row but the dependency is not merely a join predicate, SQL Server commonly uses `CROSS APPLY`. `DefaultIfEmpty` changes that to `OUTER APPLY`.

`APPLY` can represent top-N children per parent, correlated projection or computation, and table-valued work evaluated per outer row. It is not automatically faster than `JOIN`, and not every provider supports it.

## Grouping and the client boundary

`GroupBy` translates reliably when the result has a relational shape: group key plus SQL aggregates. `GroupJoin` or a projection requiring a nested collection usually does not map to one flat relational result.

Custom CLR methods, unmapped computed properties, arbitrary business objects, and unsupported logic before final projection must be rewritten as translatable expressions or evaluated deliberately after materialization. Comparer-based, positional/index, and provider-specific overloads are frequent translation limits. Use database collation or translatable normalization where appropriate, and express index-like logic through explicit ordering, `Skip`, and `Take`.

## Navigations, loading, filters, and mapping capabilities

Navigation predicates and projections translate through joins. `Include` controls related-data loading rather than directly selecting root rows. Split queries can avoid cartesian multiplication but add consistency considerations.

A required navigation combined with a global query filter on the principal can remove parent rows through an inner join. Tracking changes identity/materialization behavior rather than query meaning. Value converters, complex types, and JSON mapping depend on provider capabilities.

For every non-trivial shape, verify support and generated SQL against the exact EF Core/provider version rather than relying on a general operator table.

## What should be recallable

- What stages turn an expression tree into materialized results?
- How do correlated `Where`, `DefaultIfEmpty`, and independent sequences produce JOIN shapes?
- Why can a post-left-join filter remove outer rows?
- When does correlation become `CROSS APPLY` or `OUTER APPLY`?
- Which grouping and custom-logic shapes cross the translation boundary?
- How do `Include`, required navigations/query filters, tracking, and provider capabilities affect the result or loading behavior?

## Related knowledge

- `ef-core.global-query-filters-and-required-navigations`
- `ef-core.split-query-tradeoffs`
- `ef-core.lazy-loading-and-query-shaping`

## Sources

- Workspace: `_ai-conspects/linq to sql/`
- Authoritative processed source: `regions/full-svg-reconciliation-v002.md`, R01–R06
- Original SVG: `source/source-complete-v002.svg`
