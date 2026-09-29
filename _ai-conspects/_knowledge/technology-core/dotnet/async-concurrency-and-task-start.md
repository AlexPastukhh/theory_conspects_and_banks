# Async concurrency, parallelism, and when tasks start

Knowledge ID: `dotnet.async-concurrency-and-task-start`

Topic: `dotnet`

Concurrency means operations overlap in time; parallelism means at least two execute simultaneously, normally on different cores or workers. Awaited HTTP/database I/O is mainly concurrency: while an external system works, the .NET thread returns to the pool. CPU work such as hashing, compression, imaging, and numerical computation can benefit from true parallelism; synchronous `Parallel.ForEach` targets that measured CPU-bound case.

Most .NET I/O APIs return hot tasks: calling `GetAsync` starts the request, while awaiting observes completion. But LINQ is deferred:

```csharp
var tasks = urls.Select(url => client.GetAsync(url));
```

The selector runs only when enumerated by `Task.WhenAll`, `ToList`, or iteration. A loop that calls `GetAsync` and stores each task starts each call immediately. A loop with `await` inside starts the next call only after the prior one finishes; it minimizes downstream pressure and preserves simple ordering, but total latency approximates the sum of call latencies.

Unbounded `Task.WhenAll` starts all operations and returns `TResult[]` in input-task order, not completion order. It is suitable only when that fan-out is safe for input size and downstream capacity.

`Task.WhenAll` and `Task.WhenAny` coordinate asynchronous operations; they do not by themselves make CPU work execute in parallel. `WhenAll` waits for the group, while `WhenAny` identifies a task that completed and leaves observation/coordination of the remaining tasks to the caller.

## What should be recallable

- Concurrency versus parallelism and I/O-bound versus CPU-bound work.
- The async invocation start point, hot tasks, LINQ deferred enumeration, and sequential-await behavior.
- What unbounded `WhenAll` does and which order its returned results use.

## Sources

- Workspace: `_ai-conspects/async processing of multiple calls,parallelism/`
- Processed source: `09-full-combined-final-transcript.md`, sections 02–03 and ordering material
- Original SVG: `source/async processing of multiple calls,parallelism.svg`
- Workspace: `_ai-conspects/cancellation,async/`
- Authoritative processed source: `regions/full-source-near-literal-v003.md`, S-032
- Original SVG: `source/source-complete-v002.svg`
