# HATEOAS link generation and resource envelopes

Knowledge ID: `aspnet-core.hateoas-link-generation-and-resource-envelopes`

Topic: `aspnet-core`

An ASP.NET Core HATEOAS response needs two layers: stable link semantics for the client and route-aware link generation on the server. A course-style link model includes the target, the relation and the intended method:

```csharp
public sealed record LinkDto(
    string Href,
    string Rel,
    string Method);
```

`href` is the current target. `rel` is the stable client contract. `method` is useful in this representation, but it is a course-specific field rather than a required property of every hypermedia format. Prefer a registered relation such as `self`, `next`, `prev`, `first` or `last` when it fits; document stable intent-based domain relations such as `reserve-course` or `partially-update-author`.

A relation may also be a URI when a vocabulary needs a globally unambiguous identifier. Human-readable links still help debugging and exploratory clients, even though the primary contract is machine-facing.

## Generate item links from routes and business state

Named routes and `Url.Link` keep generated targets coupled to routing instead of duplicated URI strings. Centralize construction so GET, POST, update and delete responses use the same relations and route values.

```csharp
private IReadOnlyList<LinkDto> CreateLinksForAuthor(
    Author author,
    string? fields)
{
    var links = new List<LinkDto>
    {
        new(
            Url.Link("GetAuthor", new { authorId = author.Id, fields })!,
            "self",
            "GET")
    };

    if (author.CanBeUpdated)
    {
        links.Add(new(
            Url.Link("PartiallyUpdateAuthor", new { authorId = author.Id })!,
            "partially-update-author",
            "PATCH"));
    }

    if (author.CanBeDeleted)
    {
        links.Add(new(
            Url.Link("DeleteAuthor", new { authorId = author.Id })!,
            "delete-author",
            "DELETE"));
    }

    return links;
}
```

Conditional links are the important part of this composition: omit an action when state, permissions, archival status, concurrency requirements or workflow rules do not allow it. Clients still need documentation for relation meaning, request bodies, errors and preconditions such as `If-Match`.

## Shape the representation without losing identity

A single-resource action can validate requested fields, load the entity, generate links from its stable identity, shape the representation and attach the links:

```csharp
[HttpGet("{authorId}", Name = "GetAuthor")]
public async Task<ActionResult> GetAuthor(
    Guid authorId,
    [FromQuery] string? fields,
    CancellationToken cancellationToken)
{
    if (!propertyMappingService.ValidFor<AuthorDto>(fields))
        return BadRequest();

    var author = await repository.GetAuthorAsync(authorId, cancellationToken);
    if (author is null)
        return NotFound();

    var links = CreateLinksForAuthor(author, fields);
    var shaped = mapper.Map<AuthorDto>(author).ShapeData(fields);

    ((IDictionary<string, object?>)shaped)["links"] = links;
    return Ok(shaped);
}
```

An `ExpandoObject` can be treated as `IDictionary<string, object?>` when a `links` member must be added. Do not obtain the identifier by indexing the shaped result: callers may omit `Id`. Generate links from the original entity, retain identity internally or force identity into the internal shaping pipeline.

The same linked representation can be returned after creation:

```csharp
var created = mapper.Map<AuthorDto>(author).ShapeData(fields: null);
((IDictionary<string, object?>)created)["links"] =
    CreateLinksForAuthor(author, fields: null);

return CreatedAtRoute(
    "GetAuthor",
    new { authorId = author.Id },
    created);
```

A statically typed linked DTO gives a stronger schema and clearer OpenAPI output. Dynamic shaping is appropriate when the selected fields truly vary at runtime; both approaches still need stable route and identity ownership.

## Collection links and a valid envelope

A collection has two different control scopes:

- every item carries its own resource/action links;
- the collection carries `self`, `next` and `previous` navigation links.

Count and page values describe state; links are the navigation controls. A page URI changes the page number while preserving the rest of the public query state:

```csharp
private string? CreateAuthorsResourceUri(
    AuthorsResourceParameters p,
    ResourceUriType type)
{
    var pageNumber = type switch
    {
        ResourceUriType.PreviousPage => p.PageNumber - 1,
        ResourceUriType.NextPage => p.PageNumber + 1,
        _ => p.PageNumber
    };

    return Url.Link("GetAuthors", new
    {
        pageNumber,
        p.PageSize,
        p.Fields,
        p.OrderBy,
        p.SearchQuery,
        p.MainCategory
    });
}

private IReadOnlyList<LinkDto> CreateLinksForAuthors(
    AuthorsResourceParameters p,
    bool hasPrevious,
    bool hasNext)
{
    var links = new List<LinkDto>
    {
        new(CreateAuthorsResourceUri(p, ResourceUriType.Current)!, "self", "GET")
    };

    if (hasPrevious)
        links.Add(new(CreateAuthorsResourceUri(p, ResourceUriType.PreviousPage)!, "prev", "GET"));

    if (hasNext)
        links.Add(new(CreateAuthorsResourceUri(p, ResourceUriType.NextPage)!, "next", "GET"));

    return links;
}
```

After loading the page, build each item's links from its original entity before or while shaping it, then return valid JSON with separate item and collection control levels:

```csharp
var linkedItems = authors.Select(author =>
{
    var shaped = mapper.Map<AuthorDto>(author)
        .ShapeData(parameters.Fields);

    ((IDictionary<string, object?>)shaped)["links"] =
        CreateLinksForAuthor(author, parameters.Fields);

    return shaped;
});

var envelope = new
{
    value = linkedItems,
    links = CreateLinksForAuthors(
        parameters,
        authors.HasPrevious,
        authors.HasNext)
};

return Ok(envelope);
```

The envelope `{ value: [...], links: [...] }` avoids trying to append collection properties to a JSON array. Preserve filtering, search, sorting, shaping fields, page size and other query state in navigation targets.

## Adoption boundary

HATEOAS reduces hardcoded URI and workflow coupling; it does not make arbitrary semantics self-explanatory. Stateful, permission-sensitive workflows usually gain more from conditional controls than a simple public CRUD API. The extra response and documentation complexity makes partial adoption a valid design choice.

## What should be recallable

- Why should relation names describe stable intent rather than repeat the HTTP verb?
- How do named routes and centralized helpers keep link targets consistent?
- Why must links be built from stable entity identity rather than an optionally shaped `Id` field?
- How do item links differ from collection pagination links?
- Which query parameters must page links preserve?
- Why does a collection response use a `{ value, links }` envelope?
- When should an action link be omitted?

## Related knowledge

- `http.hypermedia-links-and-representation-negotiation`
- `aspnet-core.dynamic-data-shaping`
- `aspnet-core.createdat-route-generation`
- `aspnet-core.link-generator-and-public-origin`

## Sources

- Workspace: `_ai-conspects/hateoas/`
- Authoritative processed source: `regions/R01R06-hateoas-full-coverage-v001.md`, R01–R06
- Original SVG: `source/source-complete-v001.svg`
