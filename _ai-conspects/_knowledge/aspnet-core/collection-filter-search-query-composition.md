# Collection filtering and search query composition

Knowledge ID: `aspnet-core.collection-filter-search-query-composition`

Topic: `aspnet-core`

Structured filters constrain known fields; search applies a free-text term across fields. Both normally belong in collection GET query parameters. Group optional instructions in a resource-parameters type and bind it with `[FromQuery]`; it is not a resource DTO or GET body. Accidentally binding a GET parameters object from the body can produce unexpected behavior, including `415 Unsupported Media Type`.

The complete flow keeps retrieval instructions together and composes before materialization:

```csharp
public sealed class AuthorsResourceParameters
{
    public string? MainCategory { get; init; }
    public string? SearchQuery { get; init; }
    public int PageNumber { get; init; } = 1;
    public int PageSize { get; init; } = 20;
}

[HttpGet]
public async Task<IActionResult> GetAuthors(
    [FromQuery] AuthorsResourceParameters parameters,
    CancellationToken cancellationToken)
{
    IQueryable<Author> query = context.Authors.AsNoTracking();

    if (!string.IsNullOrWhiteSpace(parameters.MainCategory))
        query = query.Where(a =>
            a.MainCategory == parameters.MainCategory.Trim());

    if (!string.IsNullOrWhiteSpace(parameters.SearchQuery))
    {
        string search = parameters.SearchQuery.Trim();
        query = query.Where(a =>
            a.FirstName.Contains(search) ||
            a.LastName.Contains(search) ||
            a.MainCategory.Contains(search));
    }

    var result = await query
        .OrderBy(a => a.LastName)
        .ThenBy(a => a.Id)
        .Skip((parameters.PageNumber - 1) * parameters.PageSize)
        .Take(parameters.PageSize)
        .ToListAsync(cancellationToken);

    return Ok(result);
}
```

Deferred execution translates filtering, searching, stable ordering, and paging into one database query rather than loading all rows and filtering in memory.

Page collections by default because an unbounded collection increases database work, allocation, serialization, transfer size, and client rendering cost. Reject or consistently normalize page numbers and sizes below one, enforce a maximum page size, and keep `Skip`/`Take` in the data-store query before materialization. Ordering must be deterministic and include a unique tie-breaker, for example `OrderBy(LastName).ThenBy(Id)`, so equal values do not drift unpredictably between pages.

UI metadata can include total count, page size, current page, and total pages. Embedding that metadata changes the resource-body representation; a custom `X-Pagination` header is one alternative, while hypermedia `previous`/`next` links provide navigation controls.

Whitelist dynamic sort/field names; never concatenate raw identifiers into SQL. Validate page size and search length and return clear errors for unsupported fields. Document case/collation, contains-versus-prefix, wildcard escaping, tokenization/full-text behavior. Use a dedicated POST search endpoint only for genuinely large/advanced search payloads.

That POST boundary also applies when a request contains many identifiers, exceeds practical URL limits, needs complex body validation, or includes sensitive structured criteria that should not be exposed in URLs and routine URL logs. It is an explicit search-request contract, not permission to turn ordinary collection filtering into RPC.

## Sources
- Workspace: `_ai-conspects/FILTERING AND SEARCHING/`
- Processed source: `regions/final-transcript.md`, complete transcript and query example
- Workspace: `_ai-conspects/REST API BASICS/`
- Authoritative processed source: `regions/R03-filtering-searching-pagination-sorting.md`, filtering/searching/resource-parameter/paging claims
- Original SVG: `source/REST API BASICS.svg`
- Workspace: `_ai-conspects/PAGING/`
- Authoritative processed source: `01-final-transcript.md`, R01
- Original SVG: `source/PAGING.svg`
- Workspace: `_ai-conspects/ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED/`
- Authoritative processed source: `01-final-transcript.md`, R01-R03 (query-string composition and complex POST search boundary)
- Original SVG: `source/ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED.svg`
