# Polly pipeline execution and ResilienceContext

Knowledge ID: `dotnet.polly-pipeline-execution-and-resilience-context`

Topic: `dotnet`

## A pipeline executes a callback

A Polly v8 `ResiliencePipeline` is a policy executor, not an HTTP message handler. `ExecuteAsync` runs a callback through the configured strategies:

```csharp
await pipeline.ExecuteAsync(async token =>
{
    using var request = new HttpRequestMessage(HttpMethod.Post, uri);
    await using var stream = File.OpenRead(path);
    request.Content = new StreamContent(stream);

    using var response = await client.SendAsync(request, token);
    response.EnsureSuccessStatusCode();
}, ct);
```

When a retry can repeat an upload, create a fresh stream, content, and request inside the execution callback. Reusing a consumed stream or already-sent request makes later attempts non-replayable or invalid.

## Context carries per-execution metadata

`ResilienceContext` can carry cancellation and typed properties used by strategies and callbacks. Request-specific decisions can place a stable key/value in that context before execution rather than depend on ambient global state.

Contexts obtained from the pool must be returned in `finally`:

```csharp
var context = ResilienceContextPool.Shared.Get(ct);
try
{
    context.Properties.Set(OperationKey, operation);
    await pipeline.ExecuteAsync(context, static async ctx => { /* work */ });
}
finally
{
    ResilienceContextPool.Shared.Return(context);
}
```

A provider/registry selects a named or keyed pipeline; it does not execute work until the caller invokes the pipeline.

## What should be recallable

- Why a resilience pipeline is not an HTTP handler.
- Why request bodies and messages often must be recreated inside each attempt.
- What `ResilienceContext` properties are for.
- Why a pooled context must be returned even when execution fails.
- The difference between selecting a pipeline and executing it.

## Sources

- Workspace: `_ai-conspects/shared-polly-cheat-sheet-production-ready-verions-exceptions-from-pipeline-and-handling/`
- Authoritative processed source: `regions/R03-pipeline-execute-provider-ratelimiter-partitions.md`, pipeline/provider/context portions; `regions/R04R05R06-manual-classic-exception-bubbling.md`, manual/provider portions
- Original SVG: `source/shared-polly-cheat-sheet-production-ready-verions-exceptions-from-pipeline-and-handling.svg`
