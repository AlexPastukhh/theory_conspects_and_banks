# RequestAborted propagation in middleware and filters

Knowledge ID: `aspnet-core.request-aborted-propagation`

Topic: `aspnet-core`

`HttpContext.RequestAborted` is cancelled when the client disconnects or the server aborts the request. Propagate it to `HttpClient.SendAsync`, stream reads, database calls, `Task.Delay`, and other cancellable operations. Cancellation is cooperative: CPU loops must check the token or call `ThrowIfCancellationRequested`.

An action `CancellationToken` parameter is bound to `HttpContext.RequestAborted`, so the same token can flow from controller to service to HTTP request and response-content reads:

```csharp
[HttpGet("{id:guid}/covers")]
public async Task<IActionResult> GetCovers(
    Guid id,
    CancellationToken cancellationToken)
{
    var covers = await _covers.GetAsync(id, cancellationToken);
    return Ok(covers);
}
```

Middleware may return immediately when cancellation is already requested, and returning without `next(context)` short-circuits the pipeline. If it awaits work, use `InvokeAsync`, pass the token, and catch cancellation narrowly:

```csharp
catch (OperationCanceledException)
    when (context.RequestAborted.IsCancellationRequested)
{
    return;
}
```

Do not write a response after the client disconnects. Merely checking a token does not itself require an async middleware method; awaited work does.

An async action filter reads `context.HttpContext.RequestAborted`. It can return without `next()` when already cancelled, or set `context.Result` to short-circuit MVC for validation/business reasons. Outbound work should receive the token and use the same narrow cancellation handling.

A client disconnect is normally not an unhandled server 500. Do not log it as such or attempt a late response. The token guard matters because unrelated `OperationCanceledException` instances must not be hidden.

Most controller code can let request cancellation bubble. Catch it only when cleanup, a cancellation metric, or low-severity diagnostics are needed, and normally rethrow so cancellation remains cancellation:

```csharp
catch (OperationCanceledException)
    when (cancellationToken.IsCancellationRequested)
{
    // Increment a metric or log at Debug/Information.
    throw;
}
```

## What should be recallable

- What cancels `RequestAborted` and where to propagate it.
- Cooperative CPU cancellation versus cancellable async APIs.
- Middleware/filter short-circuit behavior and when `InvokeAsync` is necessary.
- Narrow exception filtering and why client disconnects should not become 500s or late writes.

## Sources

- Workspace: `_ai-conspects/FILTER,MIDDLEWARE CANCELLATION,REQUEST ABORTED/`
- Processed source: `regions/R01-final-transcript.md`, complete verified transcript
- Original SVG: `source/FILTER,MIDDLEWARE CANCELLATION,REQUEST ABORTED.svg`
- Workspace: `_ai-conspects/cancellation,async/`
- Authoritative processed source: `regions/full-source-near-literal-v003.md`, S-012–S-014, S-020–S-022, S-027, and S-037–S-040
- Original SVG: `source/source-complete-v002.svg`
