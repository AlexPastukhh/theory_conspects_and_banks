# Explicit ASP.NET Core HEAD endpoints

Knowledge ID: `aspnet-core.explicit-head-endpoints`

Topic: `aspnet-core`

In current ASP.NET Core controller/endpoint routing, `[HttpGet]` declares GET only; map HEAD explicitly with `[HttpHead]` or explicitly map both verbs. A metadata-only HEAD action is useful when it measurably avoids an expensive GET path.

The action can query version metadata, return 404, compute the same quoted ETag as GET, evaluate `If-None-Match`, and return 304 or 200 without content. Do not test raw header text with `Contains`; parse entity tags, handle `*`, and use weak comparison. Do not emit an estimated `Content-Length`.

Helpers typed as `object` cannot access `.Version`; accept a concrete type/interface or the version value. GET should also evaluate validators, and validator design must include negotiated representation variants.

## Corrected implementation pattern

```csharp
public sealed record ItemMetadata(
    int Id,
    long Version,
    string ContentType,
    long? ExactContentLength);

private static EntityTagHeaderValue CreateETag(long version) =>
    EntityTagHeaderValue.Parse($"\"v{version}\"");

private static bool IfNoneMatchMatches(
    HttpRequest request,
    EntityTagHeaderValue current)
{
    var candidates = request.GetTypedHeaders().IfNoneMatch;

    return candidates?.Any(candidate =>
        candidate == EntityTagHeaderValue.Any
        || candidate.Compare(current, useStrongComparison: false))
        == true;
}

[HttpHead("{id:int}")]
public IActionResult Head(int id)
{
    ItemMetadata? metadata = repository.GetMetadata(id);
    if (metadata is null)
        return NotFound();

    EntityTagHeaderValue etag = CreateETag(metadata.Version);
    Response.GetTypedHeaders().ETag = etag;
    Response.ContentType = metadata.ContentType;

    if (metadata.ExactContentLength is long exactLength)
        Response.ContentLength = exactLength;

    if (IfNoneMatchMatches(Request, etag))
        return StatusCode(StatusCodes.Status304NotModified);

    return Ok();
}
```

Here `CreateETag` returns a typed, quoted `EntityTagHeaderValue`. The example composes the metadata query, typed request/response headers, wildcard handling, weak comparison, optional exact length, and 304/200 outcomes without a body.

## Sources

- Workspace: `_ai-conspects/HEAD REQUEST/`
- Processed source: `04-source-preserving-corrected-transcript-v003.md`
- Implementation companion: `05-corrected-aspnet-core-implementation-v003.md`
