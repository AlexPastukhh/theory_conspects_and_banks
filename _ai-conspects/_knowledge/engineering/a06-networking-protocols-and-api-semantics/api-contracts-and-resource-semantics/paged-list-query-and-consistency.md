# Paged-list query execution and consistency

Knowledge ID: `aspnet-core.paged-list-query-and-consistency`

Topic: `aspnet-core`

## Bound and order the query before paging

Paging limits database work, response size, serialization, memory use, and client transfer. Validate or normalize the request contract so that `pageNumber >= 1` and `1 <= pageSize <= MaxPageSize`; otherwise a client can bypass the intended bound with an extremely large page.

Apply paging to the `IQueryable` before materialization. `Skip` and `Take` also require deterministic ordering. When the requested sort key is not unique, add a unique tie-breaker so equal values cannot drift between pages:

```csharp
IQueryable<Author> query = context.Authors
    .AsNoTracking()
    .OrderBy(author => author.Name)
    .ThenBy(author => author.Id);

query = query
    .Skip((pageNumber - 1) * pageSize)
    .Take(pageSize);
```

Loading the whole table and paging afterward defeats the database-side bound.

## Reusable page result

A reusable page type carries the current items together with the count and navigation state:

```csharp
public sealed class PagedList<T> : List<T>
{
    public int CurrentPage { get; }
    public int TotalPages { get; }
    public int PageSize { get; }
    public int TotalCount { get; }

    public bool HasPrevious => CurrentPage > 1;
    public bool HasNext => CurrentPage < TotalPages;

    public PagedList(
        List<T> items,
        int count,
        int pageNumber,
        int pageSize)
    {
        TotalCount = count;
        PageSize = pageSize;
        CurrentPage = pageNumber;
        TotalPages = (int)Math.Ceiling(
            count / (double)pageSize);

        AddRange(items);
    }
}
```

Ceiling preserves a partial final page: 21 rows at 10 rows per page means 3 pages.

The factory performs a count query and a paged query over the same composed source:

```csharp
public static async Task<PagedList<T>> CreateAsync<T>(
    IQueryable<T> source,
    int pageNumber,
    int pageSize)
{
    var count = await source.CountAsync();

    var items = await source
        .Skip((pageNumber - 1) * pageSize)
        .Take(pageSize)
        .ToListAsync();

    return new PagedList<T>(
        items,
        count,
        pageNumber,
        pageSize);
}
```

The caller is responsible for composing filtering, searching, and deterministic ordering before passing the source:

```csharp
public async Task<PagedList<Author>> GetAuthorsAsync(
    AuthorsResourceParameters parameters)
{
    var collection = context.Authors
        .AsNoTracking()
        .OrderBy(author => author.Id);

    return await PagedList<Author>.CreateAsync(
        collection,
        parameters.PageNumber,
        parameters.PageSize);
}
```

## Consistency and out-of-range policy

The factory normally executes two SQL statements:

```text
COUNT(*) for TotalCount
-> paged SELECT for the current items
```

Rows can change between them. That window is usually acceptable for ordinary browsing. A point-in-time count and page require a suitable transaction/isolation strategy and add cost; a page wrapper does not provide that consistency by itself.

A page number beyond `TotalPages` can be handled as `200` with an empty array, `404`, or normalization to the last page. Pick one policy, apply it consistently, and document it. Do not generate previous/next links when the corresponding page is unavailable.

## Related knowledge

- `aspnet-core.collection-filter-search-query-composition`
- `http.hypermedia-links-and-representation-negotiation`
- `http.browser-header-controls-and-cors-visibility`

## What should be recallable

- Why must ordering be deterministic and include a unique tie-breaker?
- Which work does `CreateAsync` perform, and why can its count and page disagree?
- What does `PagedList<T>` add beyond the item collection?
- Which out-of-range policy choices must an API make explicitly?

## Sources

- Workspace: `_ai-conspects/PAGING/`
- Authoritative processed source: `01-final-transcript.md`, R01-R02 and the R03 navigation-availability boundary
- Original SVG: `source/PAGING.svg`
