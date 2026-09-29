# SQL Server views as read contracts and query abstractions

Knowledge ID: `sql-server.views-read-contracts-and-query-abstractions`

Topic: `sql-server`

A normal SQL Server view stores a named query definition rather than a materialized copy of its result:

```sql
CREATE VIEW dbo.MovieSummaries AS
SELECT
    m.Id,
    m.Title,
    g.Name AS GenreName,
    m.ReleaseDate
FROM dbo.Movies AS m
JOIN dbo.Genres AS g ON g.Id = m.GenreId;
```

Consumers query the database object with a table-shaped interface:

```sql
SELECT * FROM dbo.MovieSummaries;
```

For a normal view, SQL Server normally expands the saved definition into the outer query. Moving a slow query behind a view name does not automatically make it faster. The main gains are organization, reuse, and contract stability; physical result storage appears only with features such as indexed views.

## Good read-contract uses

A view can:

- supply a reporting/read model with joins and aggregates;
- hide repeated complex joins behind a reusable name;
- expose only selected safe columns when callers are granted access to the view rather than broad table access;
- preserve an existing legacy database contract;
- provide a stable shape to several applications while base tables evolve behind it.

These are interface and maintainability benefits, not a promise that the underlying plan is cheaper.

## Poor uses

A view should not merely conceal bad performance. It is also a poor dumping ground for large conditional domain rules that belong in application/domain behavior. Creating a database object for every one-off simple filter adds ceremony without a stable reuse or contract benefit.

Do not assume a view-mapped result behaves like an ordinary writable aggregate. SQL Server can update some simple views, but application read models should normally write through the real table/entity path instead of treating a reporting or joined view as an insert/update/delete surface.

## Additional CREATE VIEW transcript

## 13. Views

A view is a saved SELECT definition.

Create view:

```sql
CREATE VIEW dbo.ActiveUsers
AS
SELECT Id, Name, Email
FROM dbo.Users
WHERE IsActive = 1;
```

Use:

```sql
SELECT *
FROM dbo.ActiveUsers;
```

Views are useful for:

```text
reusable query shape
security boundary
simplifying joins
presenting a stable read model
```

A normal view is not necessarily stored as data. It is usually expanded into the query plan.

## Related knowledge

- `ef-core.database-view-and-defining-query-mapping`
- `sql-server.indexed-view-materialization-and-write-cost`

## What should be recallable

- What does a normal view store physically?
- Why can callers query it like a table-shaped object?
- Which reporting, reuse, exposure, legacy, and stability needs fit a view?
- Why does hiding a query in a normal view not optimize it automatically?
- Which business-logic and trivial-query uses add the wrong abstraction?
- Why should a view read model normally write through real tables/entities?

## Sources
- Workspace: `_ai-conspects/sql-syntax-sql-server/`
- Authoritative processed source: `regions/R05-upsert-merge-transactions-indexes-alter-constraints-views.md`, section 13
- Original SVG: `source/sql-syntax-sql-server.svg`


- Workspace: `_ai-conspects/views-idexed-views/`
- Authoritative processed sources: `regions/VIV01-views-concept-ef-core-mapping-toview-tosqlquery.md`, VIV01A, and `regions/VIV02-good-bad-use-cases-for-views.md`, VIV02A-VIV02B plus the read/write boundary
- Materialized source: `assets/raw/full.svg`
