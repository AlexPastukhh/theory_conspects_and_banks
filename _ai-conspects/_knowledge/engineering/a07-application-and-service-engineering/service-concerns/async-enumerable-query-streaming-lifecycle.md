# Async-enumerable query streaming lifecycle

Knowledge ID: `aspnet-core.async-enumerable-query-streaming-lifecycle`

Topic: `aspnet-core`

## One query can yield objects progressively

An endpoint returning `IAsyncEnumerable<T>` can let EF Core read rows and the ASP.NET Core serializer produce objects without first building a `List<T>`:

```csharp
static async IAsyncEnumerable<MovieDto> StreamMovies(
    AppDbContext db,
    [EnumeratorCancellation] CancellationToken ct)
{
    await foreach (var movie in db.Movies.AsNoTracking()
        .OrderBy(x => x.Id).AsAsyncEnumerable().WithCancellation(ct))
        yield return new MovieDto(movie.Id, movie.Title);
}
```

This is normally one query and sequential asynchronous row reads, not one database call per yielded item. The `DbContext`, data reader, and connection must remain alive until enumeration ends. Cancellation/client disconnect should reach both enumeration and database I/O.

## Query shape belongs before the stream

Filtering and sorting should be translated at the data source. Stable order is required for cursor/after-id resume. Offset pagination can become expensive or unstable as data changes; a cursor tied to the stable ordering gives a more useful continuation boundary.

Streaming does not remove authorization, negotiated representation, caching, retries, partial failure, or idempotent resume concerns. Retrying after items reached the client can duplicate data unless records have stable IDs and both sides resume from a known boundary.

## What should be recallable

- Why `IAsyncEnumerable<T>` can avoid `ToListAsync` without causing one query per item.
- Which database resources must outlive enumeration.
- Why cancellation must flow through the complete enumeration path.
- Why filtering, stable sorting, and cursor design happen before streaming.
- Why partial delivery makes naive whole-operation retry unsafe.

## Related knowledge

- `aspnet-core.response-body-shapes-and-streaming-output`
- `dotnet.async-enumerable-replay-and-single-use-streams`

## Sources

- Workspace: `_ai-conspects/streaming/`
- Authoritative processed source: `regions/R03-streaming-objects-async-iteration-rest-api-concerns.md`, complete transcript; `regions/R04-iasyncenumerable-ndjson-flushasync.md`, partial-result/resume boundary
- Original SVG: `source/streaming.svg`
