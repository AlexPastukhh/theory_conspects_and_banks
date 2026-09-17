# EF Core database-view and defining-query mapping

Knowledge ID: `ef-core.database-view-and-defining-query-mapping`

Topic: `ef-core`

EF Core can expose a database view as a query-oriented model. The complete flow keeps the SQL object, CLR shape, mapping, and query aligned.

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

```csharp
public sealed class MovieSummary
{
    public int Id { get; set; }
    public string Title { get; set; } = null!;
    public string GenreName { get; set; } = null!;
    public DateTime ReleaseDate { get; set; }
}

modelBuilder.Entity<MovieSummary>(builder =>
{
    builder.HasNoKey();
    builder.ToView("MovieSummaries");
});

var summaries = await context.Set<MovieSummary>()
    .Where(x => x.ReleaseDate >= new DateTime(2000, 1, 1))
    .ToListAsync();
```

The CLR properties match the view columns. `ToView` points EF to an existing database object whose SQL definition is owned by the database.

## `ToView` versus `ToSqlQuery`

```text
ToView("MovieSummaries")
    SQL lives in the database view
    EF maps to that database object

ToSqlQuery("SELECT ...")
    SQL lives in EF model configuration
    no database view object is required
```

```csharp
modelBuilder.Entity<MovieSummary>()
    .HasNoKey()
    .ToSqlQuery("""
        SELECT m.Id, m.Title, g.Name AS GenreName
        FROM Movies AS m
        JOIN Genres AS g ON g.Id = m.GenreId
        """);
```

Choose based on who owns and deploys the stable query contract, not because the two mappings have the same syntax.

## Identity and write boundaries

Most view read models use `HasNoKey()` because their result has no real primary key. EF then does not track them as normal insert/update/delete entities. If the result truly exposes a stable unique identifier, a key can be configured:

```csharp
builder.HasKey(x => x.Id);
builder.ToView("MovieSummaries");
```

That key can enable identity/tracking behavior. Do not manufacture one from a non-unique projection merely to obtain tracking. Even though some simple SQL views can be updatable, the normal application rule is to map real table entities for writes and keep view models as read/query surfaces.

## Related knowledge

- `ef-core.keyless-models-vs-direct-sql-results`
- `sql-server.views-read-contracts-and-query-abstractions`

## What should be recallable

- Which four artifacts form the create-model-map-query flow?
- Where does the SQL definition live with `ToView` and `ToSqlQuery`?
- Why is `HasNoKey` common for view read models?
- When is configuring a key honest?
- Why should ordinary writes target real mapped table entities?

## Sources

- Workspace: `_ai-conspects/views-idexed-views/`
- Authoritative processed sources: `regions/VIV01-views-concept-ef-core-mapping-toview-tosqlquery.md`, VIV01B-VIV01C, and `regions/VIV02-good-bad-use-cases-for-views.md`, VIV02C plus entity-behavior claims
- Materialized source: `assets/raw/full.svg`
