# Cancellation tokens, linked sources, and cause detection

Knowledge ID: `dotnet.cancellation-tokens-linked-sources-and-causes`

Topic: `dotnet`

.NET cancellation is cooperative. A source owns and sends the signal; consumers receive a lightweight token and must observe it directly or pass it to an API that does. Stopping abandoned I/O releases capacity for other work, while stopping CPU-bound work releases CPU resources.

## Source and token roles

`CancellationTokenSource` owns a `Token` and triggers it with `Cancel()`. Consumers observe the `CancellationToken` through:

- `IsCancellationRequested`;
- `ThrowIfCancellationRequested()`;
- cancellable APIs that accept the token.

A source can represent a timeout directly, for example `new CancellationTokenSource(TimeSpan.FromSeconds(2))`, while another source may represent caller cancellation or an internal abort.

A source is disposable. Dispose owned and linked sources so their timers and registrations can be released, especially when timeout sources are created repeatedly.

## Link external and operation-owned cancellation

An operation can have more than one reason to stop:

```text
external caller cancellation
OR timeout/internal abort
-> one linked token propagated through the operation
```

```csharp
public async Task<List<BookCoverDto>> GetCoversAsync(
    IEnumerable<string> urls,
    CancellationToken requestCt)
{
    var client = _httpClientFactory.CreateClient();

    using var internalCts = new CancellationTokenSource();
    using var linkedCts =
        CancellationTokenSource.CreateLinkedTokenSource(
            internalCts.Token,
            requestCt);

    var results = new List<BookCoverDto>();

    foreach (var url in urls)
    {
        linkedCts.Token.ThrowIfCancellationRequested();

        using var response =
            await client.GetAsync(url, linkedCts.Token);

        if (!response.IsSuccessStatusCode)
        {
            internalCts.Cancel();
            break;
        }

        var json = await response.Content
            .ReadAsStringAsync(linkedCts.Token);

        var item = JsonSerializer.Deserialize<BookCoverDto>(
            json,
            new JsonSerializerOptions
            {
                PropertyNameCaseInsensitive = true
            });

        if (item is not null)
            results.Add(item);
    }

    return results;
}
```

The same linked token reaches both `GetAsync` and content reading. Passing only the external token would let the caller stop the operation, but it would not let the operation cancel its own batch after a downstream failure.

## Explicit checks and CPU-bound work

An async API that receives the token normally checks it itself, so a loop-top `ThrowIfCancellationRequested()` is not always required. It is still useful because it stops the next iteration before setup/allocation and protects intervening work that has no token parameter, such as parsing, mapping, logging, or request construction.

CPU work does not stop merely because a token was cancelled. The loop must cooperate:

```csharp
for (int i = 0; i < 1_000_000; i++)
{
    cancellationToken.ThrowIfCancellationRequested();
    DoCpuWork(i);
}
```

Checking `IsCancellationRequested` and then `break` or `return` exits normally, which can look like a successful partial result. `ThrowIfCancellationRequested()` represents the operation as cancelled through `OperationCanceledException`, matching other cancellable APIs.

## Exceptions and identifying the cause

Cancellation commonly appears as `OperationCanceledException`. `TaskCanceledException` derives from it, so catching the base type covers both.

A linked token communicates only that at least one source cancelled it. It does not identify which source won. Inspect the original tokens when policies differ:

```csharp
catch (OperationCanceledException)
    when (linkedCts.Token.IsCancellationRequested)
{
    if (requestToken.IsCancellationRequested)
    {
        // External caller or request cancellation.
    }
    else if (timeoutCts.IsCancellationRequested)
    {
        // Internal timeout.
    }

    throw;
}
```

This distinction matters because an external caller may already be gone, while an internal timeout can occur with a still-connected caller and may need a different application policy.

## What should be recallable

- The different ownership roles of `CancellationTokenSource` and `CancellationToken`.
- Why owned and linked sources are disposed.
- What `CreateLinkedTokenSource` combines and why one token is propagated everywhere.
- Why a manual check can still help before a cancellable async call.
- Why CPU loops need explicit cooperative checks.
- How `break` differs from `ThrowIfCancellationRequested()` in the operation's outcome.
- Why `TaskCanceledException` is covered by `OperationCanceledException`.
- Why the linked token alone cannot identify the cancellation reason.

## Sources

- Workspace: `_ai-conspects/cancellation,async/`
- Authoritative processed source: `regions/full-source-near-literal-v003.md`, S-001–S-011, S-015–S-019, S-024–S-026, S-031, S-033–S-034, S-037, and S-039–S-042
- Original corrected SVG: `source/source-complete-v002.svg`
- Workspace: `_ai-conspects/httpclient,summary,theory,base usage,jsonoptions wrapper,handlers/`
- Authoritative processed source: `regions/R06R07-config-primary-delegating-handlers-final.md`, R06 per-request timeout, linked-token, and catch-filter material
- Original source identity: `httpclient,summary,theory,base usage,jsonoptions wrapper,handlers.svg` (named by `00-source-check-and-boundary-review.md`; not tracked or resolvable from the current branch tree)
