# ASP.NET Core dynamic data shaping

Knowledge ID: `aspnet-core.dynamic-data-shaping`

Topic: `aspnet-core`

Data shaping lets a client select public representation fields, for example `GET /api/authors?fields=id,name`. It reduces payload size and over-fetching, supports list/detail-style representations from one endpoint, and lets DTOs gain fields without forcing existing clients to receive them. Treat names as DTO/resource properties, never arbitrary entity/internal members. Validate the comma-separated whitelist before reflection so bad fields become a controlled 400 Problem Details response rather than an exception/500.

```csharp
bool TypeHasProperties<T>(string? fields) =>
    string.IsNullOrWhiteSpace(fields) ||
    fields.Split(',', StringSplitOptions.RemoveEmptyEntries |
                      StringSplitOptions.TrimEntries)
          .All(name => typeof(T).GetProperty(name,
              BindingFlags.Public | BindingFlags.Instance |
              BindingFlags.IgnoreCase) is not null);
```

After repository retrieval and DTO mapping, resolve the selected `PropertyInfo` values into an `ExpandoObject` through `IDictionary<string, object?>`. When `fields` is null, empty, or whitespace, select all public instance properties. Provide distinct collection and single-object helpers; do not wrap one resource in a collection merely to reuse code. The public checker validates early, while the shaping extension should still reject an unknown field when called independently.

```csharp
[HttpGet(Name = "GetAuthors")]
public async Task<IActionResult> GetAuthors(
    [FromQuery] AuthorsResourceParameters parameters)
{
    if (!_propertyChecker.TypeHasProperties<AuthorDto>(parameters.Fields))
    {
        var problem = _problemDetailsFactory.CreateProblemDetails(
            HttpContext,
            statusCode: StatusCodes.Status400BadRequest,
            title: "Invalid fields parameter",
            detail: $"Unknown resource fields: '{parameters.Fields}'.");
        return BadRequest(problem);
    }

    var entities = await _repository.GetAuthorsAsync(parameters);
    var dtos = entities.Select(entity => _mapper.Map<AuthorDto>(entity));
    var shaped = dtos.ShapeData(parameters.Fields);
    return Ok(shaped);
}
```

The corresponding single-resource flow validates fields, loads by ID, returns 404 when absent, maps one DTO, and calls the single-object `ShapeData(fields)` overload. Pagination-link generation must carry `fields` together with filtering, sorting, page number, and page size.

```csharp
var shaped = new ExpandoObject();
var values = (IDictionary<string, object?>)shaped;
foreach (var property in selectedProperties)
    values[property.Name] = property.GetValue(dto);
return Ok(shaped);
```

`ExpandoObject` communicates dynamic-object intent and supports both dictionary and `dynamic` access. Casting it to `IDictionary<string, object?>` does not copy or convert it; both references view the same underlying instance. Ordinary dictionaries serialize similarly, while anonymous types are compile-time fixed and suit predefined shapes rather than a runtime field list.

Dictionary access is preferable when a key comes from the request; missing `dynamic` members fail through the runtime binder. `System.Text.Json` emits the current keys and runtime-typed nested values, and the same dictionary view can add `_links`. Because the contract is runtime-shaped, OpenAPI/client generation may need explicit modeling. Apply field-level authorization before inserting properties.

Choose the representation by intent: a named DTO defines a stable public contract; an anonymous type is a fixed local projection and its generated type is unsuitable as a public method contract; `Dictionary<string, object?>` fits a result that is conceptually a map; `ExpandoObject` fits a runtime-selected but object-like resource. Cache validated reflection metadata when shaping repeatedly rather than rediscovering properties per item.

The reflection helper can technically shape classes, records, structs, and anonymous objects. A `where TSource : class` constraint excludes value types but does not enforce a DTO-only boundary. Use a marker such as `IShapeable`, or keep the helper inside the API layer and invoke it only after mapping to approved DTOs. Preserve `fields` in pagination links so navigation does not silently change representation.

Data shaping and database projection solve different costs. Shaping removes response properties after materialization; projection reduces columns/joins transferred by the database. A sorting map (resource name to `OrderBy` path) cannot normally serve as a projection map (resource name to a DTO-construction expression). Projection can use predefined list/detail DTOs for a small fixed set of shapes, or runtime expression trees/dynamic LINQ/a dedicated selection-mapping service for truly dynamic fields. Prefer post-mapping shaping for moderate results and rich DTOs; prefer constrained database projection when rows, blobs, latency, or DB/network cost dominate.

## Sources
- Workspace: `_ai-conspects/data shaping,expando/`
- Processed source: `02-code-preserving-integrated-transcript-v002.md`, complete transcript
- Workspace: `_ai-conspects/REST API BASICS/`
- Authoritative processed source: `regions/R04-data-shaping-hateoas-content-negotiation.md`, data-shaping claims
- Original SVG: `source/REST API BASICS.svg`
- Workspace: `_ai-conspects/hateoas/`
- Authoritative processed source: `regions/R01R06-hateoas-full-coverage-v001.md`, R04
- Original SVG: `source/source-complete-v001.svg`
- Workspace: `_ai-conspects/CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON/`
- Authoritative processed source: `01-final-transcript.md`, R02 data-shaping validation boundary
- Original SVG: `source/CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON.svg`
