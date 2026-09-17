# Request cancellation and pipeline short-circuiting

Knowledge ID: `aspnet-core.request-cancellation-and-pipeline-short-circuiting`

Topic: `aspnet-core`

`HttpContext.RequestAborted` signals client disconnect. Pass it through every cancellable dependency—`SendAsync`, content reads, EF queries, and delays—and check it before expensive work or response writes. CPU/long loops require cooperative checks such as `ThrowIfCancellationRequested()`.

```csharp
try {
    using var response = await client.SendAsync(request, context.RequestAborted);
    var body = await response.Content.ReadAsStringAsync(context.RequestAborted);
    if (context.RequestAborted.IsCancellationRequested) return;
    context.Items["UpstreamHealth"] = body;
    await _next(context);
}
catch (OperationCanceledException)
    when (context.RequestAborted.IsCancellationRequested) { return; }
```

Client cancellation is normal control flow: do not log it as an application error or attempt a body after disconnect.

Middleware short-circuits the remaining request pipeline by returning without `_next`. An async action filter short-circuits MVC by setting `context.Result` and returning without `next`; earlier/later hosting middleware remains in control. When disconnected, simply return; for a normal policy rejection, set a result such as unauthorized/forbid before returning.

## Sources
- Workspace: `_ai-conspects/filter-middleware-cancellation-request-aborted/`
- Processed source: `10-full-source-preserving-transcript-v003.md`, complete transcript

