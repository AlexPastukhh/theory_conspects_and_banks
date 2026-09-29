# LinkGenerator, named endpoints, and public origin

Knowledge ID: `aspnet-core.link-generator-and-public-origin`

Topic: `aspnet-core`

Inside controllers/Razor Pages, use contextual helpers such as `Url.Action`, `Url.RouteUrl`, `Url.Page`, and `Url.Link`. In services, middleware, and reusable link factories, inject routing's `LinkGenerator`; normal routing/controller/page/minimal-API setup usually registers it.

Named endpoints provide stable addresses independent of path templates:

```csharp
var http = httpContextAccessor.HttpContext
    ?? throw new InvalidOperationException("No active HTTP request");

var link = linkGenerator.GetUriByName(
    httpContext: http,
    endpointName: UserEndpoints.VerifyEmail,
    values: new { token = verificationToken.Id });
```

Supply all required route values and handle null when no endpoint matches.

`GetPathByName`/`GetPathByAction` return relative paths. `GetUriByName`/`GetUriByAction` create absolute URIs and require scheme/host from `HttpContext` or explicit arguments.

Background jobs have no request, so use configured public-origin data:

```csharp
linkGenerator.GetUriByName(
    httpContext: null,
    endpointName: UserEndpoints.VerifyEmail,
    values: new { token = verificationToken.Id },
    scheme: "https",
    host: new HostString("api.example.com"));
```

This is predictable for email links and avoids deriving the public origin from an untrusted Host header. Validate forwarded-host configuration before trusting request-derived absolute URLs. Ambient route values can affect contextual generation; explicit names and values are more predictable for infrastructure links.

## What should be recallable

- Contextual `Url.*` helpers versus DI `LinkGenerator` use locations.
- Named endpoint stability, required route values, and nullable generation results.
- Path versus absolute URI methods and their origin requirements.
- Background public-origin configuration, Host/forwarding safety, and ambient-value predictability.

## Sources

- Workspace: `_ai-conspects/link generator/`
- Processed source: `regions/R01-final-coverage-transcript.md`, R01
- Original SVG: `source/link generator.svg`
- Workspace: `_ai-conspects/hateoas/`
- Authoritative processed source: `regions/R01R06-hateoas-full-coverage-v001.md`, R03
- Original SVG: `source/source-complete-v001.svg`
