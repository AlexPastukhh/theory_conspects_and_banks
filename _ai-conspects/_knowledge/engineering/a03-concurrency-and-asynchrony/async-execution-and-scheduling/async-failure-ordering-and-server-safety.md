# Async failure policy, ordering, and server safety

Knowledge ID: `dotnet.async-failure-ordering-and-server-safety`

Topic: `dotnet`

## Do not block asynchronous I/O

`Parallel.ForEach` expects synchronous CPU-bound work. An async lambda converted to `async void` cannot be normally awaited and has unsafe exception handling. Calling `.GetAwaiter().GetResult()`, `.Result`, `.Wait()`, or `Task.WaitAll` blocks a ThreadPool thread while the external system works.

On servers, blocked request threads cannot serve others; under load this can starve the pool, increase latency, and collapse throughput. Keep I/O async end-to-end, bound fan-out, propagate cancellation, reuse `HttpClient` rather than constructing one per request, and coordinate retries with the concurrency limit.

A `try/catch` around starting `Task.Run` or another asynchronous operation does not observe an exception that occurs later when the returned task is never awaited. Awaiting returns the exception to a structured catch point:

```csharp
try
{
    await DoWorkAsync(cancellationToken);
}
catch (Exception ex)
{
    // Handle at the local, action, or global layer that owns the policy.
}
```

This is another reason to keep async end-to-end instead of using `.Result`, `.Wait()`, or `Task.WaitAll`, which block and may expose aggregate-wrapped failure shapes.

Handle a failure at the layer that owns its policy: locally, in an action/filter, or through global exception handling. An exception filter can narrow handling when the action/MVC boundary is the intended owner.

## Failure and cancellation policy

A semaphore controls admission, not failure policy. If one task in `Task.WhenAll` fails, siblings continue unless cancellation is explicitly requested. Best-effort processing catches per item and returns an outcome containing success/value/error. Do not convert `OperationCanceledException` into an ordinary failure.

For fail-fast intent, use a linked cancellation source and cancel after the first observed failure. Cancellation is cooperative: completed work cannot be undone and remote side effects may already have happened.

An unhandled body exception faults `Parallel.ForEachAsync` and normally prevents further scheduling; already-running bodies may finish or observe cancellation. Catch inside the body when all items must be attempted.

## Four different orders

Distinguish input order, operation start order, completion order, and returned-result order. `WhenAll<TResult>` returns input-task order. `ConcurrentBag<T>` or append-on-completion records nondeterministic race/completion order. `Parallel.ForEachAsync` promises no stable processing order; carry indexes and write indexed slots to preserve input alignment. Sorting/reversing after completion is post-processing and says nothing about completion order.

## What should be recallable

- Why synchronous parallel/wait APIs are wrong around async I/O and particularly dangerous on servers.
- Sibling-task behavior, best-effort outcomes, fail-fast linked cancellation, cooperative limits, and `Parallel.ForEachAsync` failure behavior.
- The four orders and how `WhenAll`, concurrent collections, indexed slots, and post-processing affect them.

## Sources

- Workspace: `_ai-conspects/async processing of multiple calls,parallelism/`
- Processed source: `09-full-combined-final-transcript.md`, sections 06–07, 10–11
- Original SVG: `source/async processing of multiple calls,parallelism.svg`
- Workspace: `_ai-conspects/cancellation,async/`
- Authoritative processed source: `regions/full-source-near-literal-v003.md`, S-027–S-030, S-032, and S-035–S-036
- Original SVG: `source/source-complete-v002.svg`
