# LazyThreadSafetyMode semantics and exception caching

Knowledge ID: `dotnet.lazy-thread-safety-modes-and-exception-caching`

Topic: `dotnet`

## Thread-safety modes overview

`LazyThreadSafetyMode` controls synchronization, publication, and exception behavior under concurrent access:

```csharp
var lazy = new Lazy<T>(factory, mode);
```

| Mode | Concurrency model | Factory executions | Exception caching | Best used for |
|---|---|---|---|---|
| `ExecutionAndPublication` | Synchronized (locks) | Exactly 1 | Yes (with factory) | Expensive init, singletons, shared caches (default) |
| `PublicationOnly` | Race to publish | Multiple in parallel | No | Cheap/idempotent factories, retry-on-failure |
| `None` | No synchronization | Unsafe under concurrency | Yes (with factory) | Single-threaded local variables / hot paths |

## Detailed mode mechanics

### 1. LazyThreadSafetyMode.ExecutionAndPublication (Default in multithreaded code)
- **Execution:** Only one thread enters the factory at a time; all other concurrent callers block and wait on the synchronization lock.
- **Publication:** The single computed value is published and reused for all future `.Value` reads.
- **Exception behavior:** If the factory throws, `Lazy<T>` permanently caches the exception. Subsequent calls to `.Value` re-throw the same cached exception immediately without re-executing the factory.
- **Lock contention:** Under high concurrency, waiting threads contend on the lock. However, for expensive operations (database queries, network requests, CPU-intensive parsing), serialized waiting is vastly preferable to duplicate executions.

### 2. LazyThreadSafetyMode.PublicationOnly (Optimistic publication)
- **Execution:** Multiple threads reaching uninitialized `.Value` may execute the factory simultaneously in parallel.
- **Publication:** The first thread to finish successfully stores its value in the `Lazy<T>` instance. Results from other completing threads are discarded.
- **Exception behavior:** Exceptions are **never cached**. If a thread's factory throws, that thread receives the exception, but another concurrent thread or a subsequent `.Value` access can attempt initialization again.
- **Factory constraints:** Because the factory can execute multiple times, it **must be idempotent and side-effect-free** (e.g. no sending emails, debiting accounts, or mutating shared state).
- **When to use:**
  - Lightweight object construction where lock contention costs more than running the factory twice.
  - Retriable lazy initialization (e.g. transient network/API client creation) where transient failures should not permanently poison the instance.
- **Why avoid in expensive shared caches (Pattern C):** In a cache of expensive operations (DB, HTTP, file I/O), duplicated execution under load wastes significant system resources with little latency benefit.

### 3. LazyThreadSafetyMode.None (No thread safety)
- Provides zero synchronization and is completely unsafe for concurrent access by multiple threads.
- If multiple threads access `.Value` concurrently, no thread-safety guarantee exists.
- Caches factory exceptions.
- Only appropriate for local variables or strictly single-threaded execution contexts. Avoid in ASP.NET Core shared services or concurrent dictionaries.

## Exception caching matrix

Exception caching rules depend on both constructor type and mode:

```text
Constructor with factory (Func<T>):
  - ExecutionAndPublication : Caches exception (fail-fast, no retry)
  - None                    : Caches exception (fail-fast, no retry)
  - PublicationOnly         : Never caches exception (retries allowed)

Parameterless constructor (new Lazy<T>() using new T()):
  - ExecutionAndPublication : Does NOT cache exception
  - PublicationOnly         : Does NOT cache exception
  - None                    : Does NOT cache exception
```

## Retriable lazy initialization example

Using `PublicationOnly` to allow self-healing from transient initialization failures:

```csharp
public sealed class ResilientServiceClient
{
    private readonly Lazy<ApiClient> _client =
        new(
            () => ApiClientFactory.Create(),
            LazyThreadSafetyMode.PublicationOnly);

    public ApiClient Client => _client.Value;
}
```
If `ApiClientFactory.Create()` throws due to a temporary network blip, the exception is not cached; the next caller accessing `Client` executes the factory again and can recover without restarting the process.

## Decision checklist

- **Use `ExecutionAndPublication` when:**
  - Initialization failure indicates a permanent configuration/deployment defect (e.g. missing required config, broken dependency).
  - Initialization is expensive (I/O, database, heavy parsing).
  - The instance is shared across threads (ASP.NET Core singletons, ConcurrentDictionary caches).
- **Use `PublicationOnly` when:**
  - Initialization failure may be transient (network, DNS, cloud service availability) and retry without process restart is required.
  - Factory is cheap, fast, and strictly idempotent.
- **Use `None` only when:**
  - Access is guaranteed to remain on a single thread (method-local lazy variables).

## What should be recallable

- What are the three `LazyThreadSafetyMode` options and how do they differ?
- Which mode is the standard default for multithreaded code?
- How does exception caching behave in `ExecutionAndPublication` vs `PublicationOnly`?
- What requirements does `PublicationOnly` place on the factory function?
- Why is `PublicationOnly` typically unsuitable for expensive shared caches (Pattern C)?
- Which constructor/mode combinations cache exceptions vs permit retries?
- Why is `LazyThreadSafetyMode.None` dangerous in shared web application services?

## Related knowledge

- `dotnet.lazy-initialization-and-argument-patterns` - Lazy<T> lifecycle, async tasks, and Patterns A/B/C
- `dotnet.per-key-async-single-flight` - Async single-flight caching with in-flight Lazy task cleanup

## Sources

- Workspace: `_ai-conspects/Lazy/`
- Authoritative processed source: `04-source-preserving-transcript-v002.md`, sections S-006, S-007, S-008, S-009, S-010, S-011, S-012, S-016, S-017, S-018, S-019, S-020, S-021, S-023, S-024, S-027, S-033, S-036
- Quality audit: `06-corrected-closure-audit-v002.md`
- Original SVG: `source/Lazy.svg` (Git blob SHA: 61bcdd37d8a715fb3db9736ccf87e3bd19baafdd)
