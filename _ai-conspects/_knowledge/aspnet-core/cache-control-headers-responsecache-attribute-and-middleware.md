# Cache-Control headers, ResponseCacheAttribute, and Response Caching middleware

Knowledge ID: `aspnet-core.cache-control-headers-responsecache-attribute-and-middleware`

Topic: `aspnet-core`

ASP.NET Core provides three tools to emit and manage HTTP cache policy: `ResponseCacheAttribute` (MVC filter that sets headers), named cache profiles (configuration reuse), and Response Caching middleware (optional in-process storage). This unit covers their mechanics, configuration patterns, and common mistakes.

For foundational HTTP Cache-Control semantics, freshness, validation, Vary correctness, and authentication safety, see related units below.

## ResponseCacheAttribute – MVC filter, not storage

`ResponseCacheAttribute` is an MVC filter that sets cache-related response headers. It does not itself store response bodies and does not generate ETags; it only emits the HTTP policy headers.

A single `[ResponseCache(...)]` attribute is allowed per class or method. Two separate attributes on the same class/method is invalid:

```csharp
// WRONG: only one ResponseCacheAttribute allowed
[ResponseCache(CacheProfileName = "Public5Min")]
[ResponseCache(VaryByHeader = "Accept")]
public IActionResult GetCatalog() => Ok(...);
```

Correct approach:

```csharp
// RIGHT: combine in one attribute
[ResponseCache(
    CacheProfileName = "Public5Min",
    VaryByHeader = "Accept")]
public IActionResult GetCatalog() => Ok(...);
```

### Per-action example

```csharp
[HttpGet("{courseId}", Name = "GetCourseForAuthor")]
[ResponseCache(
    Duration = 120,
    Location = ResponseCacheLocation.Any)]
public IActionResult GetCourseForAuthor(
    Guid authorId,
    Guid courseId)
{
    return Ok(new
    {
        authorId,
        courseId,
        title = "Example"
    });
}
```

Expected HTTP response header:

```http
Cache-Control: public, max-age=120
```

The header permits and controls cache behavior; it does not prove the API process itself stored the response body.

### Named cache profiles

Named profiles centralize repeated duration/location/vary settings:

```csharp
builder.Services.AddControllers(options =>
{
    options.CacheProfiles.Add(
        "Public5Min",
        new CacheProfile
        {
            Duration = 300,
            Location = ResponseCacheLocation.Any,
            VaryByHeader = "Accept"
        });

    options.CacheProfiles.Add(
        "Private30Sec",
        new CacheProfile
        {
            Duration = 30,
            Location = ResponseCacheLocation.Client
        });

    options.CacheProfiles.Add(
        "NoStore",
        new CacheProfile
        {
            NoStore = true,
            Location = ResponseCacheLocation.None
        });
});
```

Usage:

```csharp
[ResponseCache(CacheProfileName = "Public5Min")]
public IActionResult GetCatalog() => Ok(...);
```

An attribute can select a profile and override one property:

```csharp
[ResponseCache(
    CacheProfileName = "Public5Min",
    VaryByHeader = "Accept-Language")]
```

## Response Caching middleware

Response Caching middleware implements an in-process, HTTP-semantic response cache:

```csharp
builder.Services.AddResponseCaching();

var app = builder.Build();

app.UseResponseCaching();
app.MapControllers();
```

This middleware stores only eligible responses:

- successful GET/HEAD requests;
- anonymous/public responses;
- explicit cacheability;
- no unsafe user-specific headers.

Enabling the middleware does not cache every endpoint; eligibility depends on response headers and request context.

## Global MVC safety default

```csharp
builder.Services.AddControllers(options =>
{
    options.Filters.Add(
        new ResponseCacheAttribute
        {
            NoStore = true,
            Location = ResponseCacheLocation.None
        });
});
```

This combination intentionally produces a strong no-storage policy. `NoStore = true` is the part that forbids storage. `Location = ResponseCacheLocation.None` alone means `no-cache` (validation required), not `no-store` (no storage). The combination is common for APIs that default to private or ephemeral responses.

## Conditional caching middleware

When cache policy depends on status, authentication, content type, or downstream response headers, use custom middleware:

```csharp
app.Use(async (context, next) =>
{
    await next();

    if (context.Response.StatusCode is >= 200 and < 300 &&
        context.User.Identity?.IsAuthenticated == true &&
        !context.Response.Headers.ContainsKey("Cache-Control"))
    {
        context.Response.Headers.CacheControl = "no-store";
    }
});
```

Call `next()` first when the policy depends on response properties. Do not overwrite an explicit endpoint policy unless the global rule deliberately has higher precedence.

## Vary in ASP.NET Core context

Use the `VaryByHeader` property of `ResponseCache` to declare which request headers select different representations:

```csharp
[HttpGet("{id:int}")]
[Produces("application/json", "application/xml")]
[ResponseCache(
    Duration = 60,
    VaryByHeader = "Accept")]
public IActionResult<ProductDto> Get(int id)
{
    return Ok(new ProductDto
    {
        Id = id,
        Name = "Phone"
    });
}
```

Or set the header manually:

```csharp
app.MapGet(
    "/api/products/{id:int}",
    (HttpContext http, int id) =>
    {
        http.Response.Headers.Vary = "Accept";

        return Results.Ok(new ProductDto
        {
            Id = id,
            Name = "Phone"
        });
    })
    .Produces<ProductDto>("application/json")
    .Produces<ProductDto>("application/xml");
```

For HTTP Vary semantics, correctness rules, and high-cardinality variation risks, see the related HTTP unit.

## Configuration choices matrix

Choose the mechanism by responsibility:

| Need | Tool |
|---|---|
| Safe MVC default headers | Global `ResponseCacheAttribute` filter |
| Reusable named policy | MVC cache profile |
| Endpoint-specific header policy | Single `[ResponseCache(...)]` attribute |
| Route/status/auth conditional logic | Custom middleware |
| Process-local HTTP response storage | Response Caching middleware |
| Server-owned policy and invalidation | Output Caching (separate system) |
| Domain/data result reuse | `IMemoryCache` / distributed cache |

Header policy and body storage are independent concerns. A service can emit cache headers without storing the response locally, or use application caching while the final HTTP response remains `private`/`no-store`.

## When server response caching is useful in ASP.NET

- public anonymous GETs with repeated callers;
- internal service-to-service traffic where a CDN adds little value;
- expensive DB queries/serialization repeated within a short window;
- microcaching for burst smoothing;
- application-controlled tenant/feature dimensions;
- operational constraints prevent gateway/CDN changes;
- origin resource savings matter more than edge delivery.

### When often unnecessary

- authenticated/personalized APIs;
- rapidly changing responses with low repeat rate;
- a CDN/gateway already owns public caching;
- the main goal is bandwidth validation with ETag/Last-Modified;
- a React/mobile client already has a data-fetching cache and the endpoint is not safely reusable across callers.

Measure hit ratio, memory use, origin CPU/DB savings, latency, stale-data incidents, and variant count to decide.

## ASP.NET-specific practical examples

```csharp
// Public catalog; browser 2 min, CDN 10 min
[ResponseCache(
    Duration = 120,
    Location = ResponseCacheLocation.Any,
    VaryByHeader = "Accept-Encoding")]
public IActionResult GetCatalog() => Ok(...);
```

```csharp
// User-specific but safe in client cache
[ResponseCache(
    Duration = 30,
    Location = ResponseCacheLocation.Client)]
public IActionResult GetMyDashboard() => Ok(...);
```

```csharp
// Sensitive endpoint
[ResponseCache(
    NoStore = true,
    Location = ResponseCacheLocation.None)]
public IActionResult GetUserSecrets() => Ok(...);
```

```csharp
// Always validate; client must revalidate before reuse
[ResponseCache(
    Duration = 0,
    Location = ResponseCacheLocation.Any)]
public IActionResult GetCatalogWithValidation()
{
    var etag = "\"catalog-v42\"";
    Response.Headers.ETag = etag;
    return Ok(...);
}
```

## Critical corrections to common ASP.NET mistakes

### Mistake 1: Multiple ResponseCacheAttribute on one method

Invalid:

```csharp
[ResponseCache(CacheProfileName = "Public5Min")]
[ResponseCache(VaryByHeader = "Accept")]
public IActionResult GetCatalog() => Ok(...);
```

Correct:

```csharp
[ResponseCache(
    CacheProfileName = "Public5Min",
    VaryByHeader = "Accept")]
public IActionResult GetCatalog() => Ok(...);
```

or set `VaryByHeader` in the profile.

### Mistake 2: Location = None means no-store

`ResponseCacheLocation.None` maps to `no-cache` policy behavior (storage allowed, but validation required). Storage prohibition requires `NoStore = true`.

Correct safe combination:

```csharp
[ResponseCache(
    NoStore = true,
    Location = ResponseCacheLocation.None)]
```

produces a strong no-storage/no-cache policy. Do not attribute the storage prohibition to `Location = None` alone.

## What should be recallable

- What does ResponseCacheAttribute do, and why does it not store responses on the server?
- Why is only one ResponseCacheAttribute allowed per method?
- When should you use named cache profiles vs. per-action attributes?
- What is the difference between `NoStore = true` and `Location = ResponseCacheLocation.None`?
- When is Response Caching middleware useful?
- How do conditional middleware patterns work when policy depends on response headers?
- How does VaryByHeader work in ASP.NET Core, and when does high-cardinality variation destroy reuse?
- What are the practical ASP.NET recipes for common caching scenarios?
- When is whole-response server caching useful or unnecessary?

## Related knowledge

- [http.cache-validation-headers](../http/cache-validation-headers.md) — HTTP Cache-Control, freshness, validators, directive semantics, request/response flows, authentication safety
- [http.vary-representation-cache-keys](../http/vary-representation-cache-keys.md) — Vary header, cache-key variants, correctness rules, high-cardinality risks
- [aspnet-core.response-and-output-caching-policies](response-and-output-caching-policies.md) — Server-side response/output caching layers comparison, policy builders
- [aspnet-core.output-cache-safety-value-and-locking](output-cache-safety-value-and-locking.md) — OutputCache thread safety and concurrency
- [aspnet-core.middleware-ordering-short-circuit-and-json](middleware-ordering-short-circuit-and-json.md) — Middleware ordering and pipeline control

## Sources

- Workspace: `_ai-conspects/cache control headers and response caching`
- Authoritative processed file: `11-corrected-code-preserving-transcript-v002.md`
- Sections: M02 (ResponseCacheAttribute, profiles, middleware), M04 (Vary usage), M06 (configuration matrix), M07 (when useful/unnecessary), M09 (practical recipes), M10 (critical corrections)
- Original SVG: `source/cache control headers and response caching.svg`
- Evidence: 91 screenshots from source material, complete code examples with corrections for multiple-attribute and Location.None mistakes
