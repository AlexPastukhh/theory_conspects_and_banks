# Exception-handler features and original request context

Knowledge ID: `aspnet-core.exception-handler-features`

Topic: `aspnet-core`

## Core model

When exception-handler middleware catches an exception, it publishes structured information through `HttpContext.Features`. An error endpoint consumes that framework contract instead of depending on an application-defined magic key.

`IExceptionHandlerFeature` exposes the original exception:

```csharp
var feature =
    context.Features.Get<IExceptionHandlerFeature>();

var exception = feature?.Error;
```

`IExceptionHandlerPathFeature` additionally exposes the original request path.

```csharp
var feature =
    context.Features.Get<IExceptionHandlerPathFeature>();

var exception = feature?.Error;
var path = feature?.Path;
```

## Error-endpoint flow

```csharp
app.UseExceptionHandler("/error");

app.Map("/error", (HttpContext context) =>
{
    var feature =
        context.Features.Get<IExceptionHandlerFeature>();

    return Results.Problem(
        title: "Unhandled exception",
        detail: feature?.Error.Message,
        statusCode: 500);
});
```

The exception data belongs in a feature because middleware and the error endpoint communicate through an explicit typed infrastructure contract.

## What should be recallable

- How does an error endpoint obtain the exception caught by `UseExceptionHandler`?
- What does `IExceptionHandlerPathFeature` add?
- Why are exception details represented as a feature rather than an `Items` string key?
- Which components publish and consume the exception feature?

## Related knowledge

- `aspnet-core.httpcontext-features` — the general typed-feature model used by this contract.

## Sources

- Workspace: `_ai-conspects/httpcontext items and features/`
- Processed source: `FINAL_TRANSCRIPT.md`, S-004, S-010, S-013, S-015, and S-018
- Original SVG: `source/httpcontext items and features.svg`
