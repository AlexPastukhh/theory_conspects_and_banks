# CORS middleware and preflight handling

Knowledge ID: `aspnet-core.cors-middleware-preflight`

Topic: `aspnet-core`

## Core model

Use ASP.NET Core CORS middleware for browser preflight rather than manually reproducing the CORS decision protocol in controller actions.

```csharp
builder.Services.AddCors(options =>
{
    options.AddPolicy("spa", policy =>
    {
        policy
            .WithOrigins("https://app.example")
            .WithMethods("GET", "POST", "PATCH", "DELETE")
            .WithHeaders("Content-Type", "Authorization", "If-Match")
            .AllowCredentials()
            .SetPreflightMaxAge(TimeSpan.FromMinutes(10));
    });
});
```

The policy explicitly controls allowed origins, methods, request headers, credentials, and preflight cache duration.

`WithHeaders(...)` permits selected request headers; `WithExposedHeaders(...)` makes selected response headers readable to cross-origin JavaScript. They control opposite directions and are not interchangeable:

```csharp
policy
    .WithHeaders("Content-Type", "If-Match")
    .WithExposedHeaders("ETag", "Content-Disposition");
```

The builder also supports predicates and explicit reversals such as `SetIsOriginAllowed(...)`, `AllowAnyOrigin()`, and `DisallowCredentials()`. Never combine wildcard origin with credentials. When a response reflects an allowed origin, it must emit exactly one origin value and append `Origin` to `Vary`; a comma-separated origin list is not a valid substitute.

During local SPA development, a dev-server proxy can present the page and API through one browser-visible origin even when it forwards to a separate backend. That changes the browser topology; it does not remove the need for a deliberate deployed-origin policy.

## Pipeline placement

```csharp
app.UseRouting();
app.UseCors("spa");
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
```

Middleware order matters. CORS must run early enough to handle the request before endpoint authorization rejects the preflight.

In ordinary controller applications, a dedicated `[HttpOptions]` action is unnecessary for browser preflight because the middleware can short-circuit it. Add an explicit `OPTIONS` endpoint only when the API intentionally exposes resource-capability metadata beyond CORS.

## Manual-handling risk

Manual code would need to process `Origin`, requested method and headers, allowed origins/methods/headers, credentials policy, preflight cache duration, and cache variation. Omitting one dimension can produce policy or caching errors. A handwritten example can explain the control flow, but built-in middleware is the production default.

Conceptually, an approved preflight is answered and short-circuited by the CORS layer. An approved actual request continues through the application and receives the appropriate CORS response headers on the way out; CORS does not replace the endpoint.

## What should be recallable

- Why should CORS middleware normally handle browser preflights?
- Which policy dimensions are configured in `AddCors`?
- Where does `UseCors` belong relative to authentication and authorization in this source's pipeline?
- When is an explicit `[HttpOptions]` endpoint justified?
- What responsibilities make manual preflight handling error-prone?

## Related knowledge

- `http.options-and-cors-preflight` — protocol semantics handled by the middleware.
- `http.vary-origin-cache-variants` — cache variation required for reflected origins.

## Sources

- Workspace: `_ai-conspects/options requ/`
- Processed source: `01-final-transcript.md`, R02 — ASP.NET Core handling
- Original SVG: `source/options requ.svg`
- Workspace: `_ai-conspects/CORS/`
- Authoritative processed source: `regions/R01R02-origin-preflight-aspnet-usecases.md` and `regions/R03R04R05-policy-builder-headers-middleware.md`, R02-R05
- Original SVG: `source/CORS.svg`
