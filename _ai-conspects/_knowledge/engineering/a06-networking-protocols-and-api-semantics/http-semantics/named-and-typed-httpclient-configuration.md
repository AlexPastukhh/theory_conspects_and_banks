# Named and typed HttpClient configuration

Knowledge ID: `dotnet.named-and-typed-httpclient-configuration`

Topic: `dotnet`

## Named clients identify a configuration

Named registrations centralize a logical remote service's base address, default headers, timeout, and handler pipeline:

```csharp
services.AddHttpClient("movies", client =>
{
    client.BaseAddress = new Uri(configuration["Movies:BaseUrl"]!);
    client.DefaultRequestHeaders.Accept.ParseAdd("application/json");
});

var client = factory.CreateClient("movies");
```

The string name is the lookup boundary. It is useful when one consumer selects among multiple configured clients, but mistyped names remain a runtime concern.

## Typed clients put operations behind a domain API

```csharp
services.AddHttpClient<MoviesClient>(client =>
    client.BaseAddress = new Uri(configuration["Movies:BaseUrl"]!));

public sealed class MoviesClient(HttpClient client)
{
    public Task<MovieDto[]?> GetMoviesAsync(CancellationToken ct) =>
        client.GetFromJsonAsync<MovieDto[]>("movies", ct);
}
```

A typed client should progressively hide raw transport details behind operations meaningful to its caller. Merely exposing a public `HttpClient` property gives DI configuration but little domain abstraction.

## Manual JSON needs its own canonical options

MVC/Minimal API JSON configuration does not automatically flow into every manual `JsonSerializer` or `HttpClient` JSON helper call. Integration code can inject one canonical `JsonSerializerOptions` wrapper and pass the same options to manual serialization/deserialization. This prevents casing, enum, null, number, date/time, and reference behavior from drifting between calls.

The wrapper is not magic global state: code must actually use its options.

## What should be recallable

- How named and typed clients differ as lookup and abstraction boundaries.
- Why a typed client becomes valuable when it exposes API-specific methods.
- Which configuration belongs in `AddHttpClient`.
- Why server JSON configuration does not automatically control manual/client serialization.
- Why a shared options wrapper works only when callers pass its options.

## Sources

- Workspace: `_ai-conspects/httpclient,summary,theory,base usage,jsonoptions wrapper,handlers/`
- Authoritative processed source: `regions/R03R04-typed-httpclient-jsonoptions-wrapper.md`, complete transcript; `regions/R05AB-httpclientfactory-lifetime-dns-named-typed-clients.md`, named/typed-client material
- Original source identity: `httpclient,summary,theory,base usage,jsonoptions wrapper,handlers.svg` (named by `00-source-check-and-boundary-review.md`; not tracked or resolvable from the current branch tree)
