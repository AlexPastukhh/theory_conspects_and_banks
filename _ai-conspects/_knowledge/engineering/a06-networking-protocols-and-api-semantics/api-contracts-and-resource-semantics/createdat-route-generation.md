# CreatedAt route generation for creation endpoints

Knowledge ID: `aspnet-core.createdat-route-generation`

Topic: `aspnet-core`

`CreatedAtAction`, `CreatedAtRoute`, and `Created` return `201 Created`, a `Location`, and an optional response body. Route-based helpers keep the URI tied to a real retrieval endpoint.

```csharp
[HttpPost]
public async Task<ActionResult<WidgetDto>> Create(
    CreateWidgetDto dto,
    CancellationToken ct)
{
    var widget = new Widget { Name = dto.Name };
    db.Widgets.Add(widget);
    await db.SaveChangesAsync(ct);

    var result = MapToDto(widget);
    return CreatedAtAction(
        nameof(GetById),
        new { id = widget.Id },
        result);
}

[HttpGet("{id}")]
public async Task<ActionResult<WidgetDto>> GetById(int id)
{
    var widget = await db.Widgets.FindAsync(id);
    return widget is null ? NotFound() : Ok(MapToDto(widget));
}
```

Save before building route values when the database generates the identifier. The referenced action and route parameters must be compatible.

For a named route:

```csharp
[HttpGet("{id}", Name = "GetWidget")]
public Task<ActionResult<WidgetDto>> GetById(int id) { /* ... */ }

return CreatedAtRoute(
    "GetWidget",
    new { id = widget.Id },
    resultDto);
```

Use `nameof` for action references where possible. Use `Created(uri, body)` when the URI is already known; prefer route helpers when routing owns address generation.

## Collection creation

A path-based subset endpoint can accept route identifiers and be targeted by `CreatedAtRoute`:

```csharp
[HttpGet("by-ids/{ids}", Name = "GetOrdersByIdsPath")]
public ActionResult<IReadOnlyList<OrderDto>> GetByIds(string ids)
{
    var parsed = ids.Split(',', StringSplitOptions.RemoveEmptyEntries)
        .Select(Guid.Parse)
        .ToArray();
    // load matching orders
}

return CreatedAtRoute(
    "GetOrdersByIdsPath",
    new { ids = string.Join(",", createdIds) },
    response);
```

For a query endpoint, generate the absolute/relative URI deliberately:

```csharp
[HttpGet("by-ids", Name = "GetOrdersByIdsQuery")]
public ActionResult<IReadOnlyList<OrderDto>> GetByIds([FromQuery] Guid[] ids)
    => /* load matching orders */;

var location = linkGenerator.GetUriByRouteValues(
    httpContext,
    "GetOrdersByIdsQuery",
    new { ids = createdIds });

return Created(location!, response);
```

Array route-value serialization depends on model binding and link-generation behavior; test the emitted query URI instead of assuming its shape. A response can expose one collection Location plus each created item's self link when one header cannot encode all items.

## What should be recallable

- What do `CreatedAtAction`, `CreatedAtRoute`, and `Created` return?
- Why must database-generated IDs be saved before route generation?
- What must match between route values and the retrieval endpoint?
- When does a named route make `CreatedAtRoute` appropriate?
- How can a bulk create expose one Location plus per-item links?
- Why must query-array URI generation be tested?

## Related knowledge

- `http.creation-responses-and-operation-resources` — `201`/`202`, bulk results, and operation resources.
- `aspnet-core.link-generator-and-public-origin` — link generation behind proxies and public-origin configuration.

## Sources

- Workspace: `_ai-conspects/CREATION REQUEST,POST REQUEST,LOCACTION HEADER,CREATED AT/`
- Authoritative processed source: `01-final-transcript.md`, R01 and R02 (framework helpers and route generation)
- Original SVG: `source/CREATION REQUEST,POST REQUEST,LOCACTION HEADER,CREATED AT.svg`
- Workspace: `_ai-conspects/hateoas/`
- Authoritative processed source: `regions/R01R06-hateoas-full-coverage-v001.md`, R03
- Original SVG: `source/source-complete-v001.svg`
- Workspace: `_ai-conspects/ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED/`
- Authoritative processed source: `01-final-transcript.md`, R01 and R03 (`CreatedAtRoute`, named retrieval routes and stable creation links)
- Original SVG: `source/ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED.svg`
