# Bounded async concurrency with SemaphoreSlim and Parallel.ForEachAsync

Knowledge ID: `dotnet.bounded-async-concurrency`

Topic: `dotnet`

## SemaphoreSlim plus Task.WhenAll

An async semaphore gates active operations while preserving task composition and returned values:

```csharp
using var gate = new SemaphoreSlim(maxConcurrency);
var tasks = inputs.Select(async input =>
{
    await gate.WaitAsync(cancellationToken);
    try
    {
        return await operation(input, cancellationToken);
    }
    finally
    {
        gate.Release();
    }
}).ToArray();

var results = await Task.WhenAll(tasks);
```

Release in `finally`; a leaked permit can leave all later work waiting forever. Pass cancellation to both admission and the operation. Results remain in input-task order, avoiding concurrent writes to a shared `List<T>`. However, `Select` commonly creates a task/closure per input, so huge sources can consume memory even though active work is bounded.

## Parallel.ForEachAsync

On .NET 6+, `Parallel.ForEachAsync` uses approximately `MaxDegreeOfParallelism` worker bodies and pulls more items as capacity frees. It usually avoids one waiting task per item and can suit very large sources.

It returns one completion task, not per-item results. Aggregate with a pre-sized indexed array for stable order, a thread-safe collection when order is irrelevant, a lock around a small mutation, or a channel/streaming pipeline. A normal `List<T>` is unsafe for concurrent mutation. Processing order is not stable.

## Allocation, backpressure, and selection

Neither approach alone is a full producer/consumer backpressure pipeline. For continuous input or streaming results use bounded `Channel<T>`, `IAsyncEnumerable<T>`, or another bounded-buffer pipeline.

Choose semaphore + `WhenAll` for ordered returned results, non-enormous input, per-item outcomes, `WhenAny`/timeouts composition, or one gate shared across operation types. Choose `Parallel.ForEachAsync` for .NET 6+, very large sources, one operation per item, reconstructable/unimportant order, and lower waiting-task overhead.

Maximum useful concurrency comes from the tightest HTTP limit, remote quota, database pool/locks, memory, or other downstream resource—not CPU count alone. For EF Core, never use one `DbContext` concurrently; create an independent context/unit of work per active operation using a factory or DI scope.

## Integrated bounded HTTP example

This example connects the complete execution path: client reuse through `IHttpClientFactory`, semaphore admission, response disposal and validation, JSON reading, guaranteed permit release, ordered aggregation, and null filtering.

```csharp
public sealed record BookCoverDto(string Url, int BookId);

public sealed class BookCoverClient
{
    private readonly IHttpClientFactory _httpClientFactory;

    public BookCoverClient(IHttpClientFactory httpClientFactory)
        => _httpClientFactory = httpClientFactory;

    public async Task<IReadOnlyList<BookCoverDto>> GetCoversAsync(
        IReadOnlyList<string> urls,
        int maxConcurrency,
        CancellationToken cancellationToken)
    {
        var client = _httpClientFactory.CreateClient();
        using var gate = new SemaphoreSlim(maxConcurrency);

        var tasks = urls.Select(async url =>
        {
            await gate.WaitAsync(cancellationToken);

            try
            {
                using var response =
                    await client.GetAsync(url, cancellationToken);

                response.EnsureSuccessStatusCode();

                return await response.Content
                    .ReadFromJsonAsync<BookCoverDto>(
                        cancellationToken: cancellationToken);
            }
            finally
            {
                gate.Release();
            }
        }).ToArray();

        var results = await Task.WhenAll(tasks);

        return results
            .Where(result => result is not null)
            .Cast<BookCoverDto>()
            .ToArray();
    }
}
```

The calls overlap, but only `maxConcurrency` requests are active. No thread is synchronously blocked, `Task.WhenAll` keeps results aligned with input-task order, each response is disposed, HTTP failures are surfaced, cancellation reaches both admission and I/O, and `finally` prevents a leaked semaphore permit.

## What should be recallable

- Correct semaphore admission/release/cancellation and its per-input allocation tradeoff.
- Worker-driven `Parallel.ForEachAsync`, result aggregation choices, and ordering limitation.
- When to choose each approach, when a channel is needed, and how downstream/DbContext constraints set concurrency.
- How the integrated HTTP implementation composes client reuse, admission, response handling, deserialization, release, aggregation, and filtering.

## Sources

- Workspace: `_ai-conspects/async processing of multiple calls,parallelism/`
- Processed source: `09-full-combined-final-transcript.md`, sections 04–05, 08–09, 12–13
- Original SVG: `source/async processing of multiple calls,parallelism.svg`
