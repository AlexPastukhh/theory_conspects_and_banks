# ValueTask synchronous completion and consumption

Knowledge ID: `dotnet.valuetask-synchronous-completion-and-consumption`

Topic: `dotnet`

`Task<T>` is a reference object representing a future result and has simple composition and repeated-consumption rules. `ValueTask<T>` is a small value type that can contain an already available `T` or wrap an asynchronous source such as `Task<T>` or `IValueTaskSource<T>`.

Its main benefit is a measured hot path that completes synchronously often enough to avoid allocating a separate completed `Task<T>`:

```csharp
public ValueTask<UserDto> GetUserAsync(int id, CancellationToken ct)
{
    if (_cache.TryGetValue(id, out var cached))
        return ValueTask.FromResult(cached);

    return new ValueTask<UserDto>(FetchFromDbAsync(id, ct));
}
```

`new ValueTask<T>(value)` and `ValueTask.FromResult(value)` are practically equivalent completed-result forms; the latter emphasizes that the result is already ready. The caller uses the same syntax for both branches:

```csharp
var user = await GetUserAsync(id, ct);
```

On a hit, the await can complete immediately. On a miss, the caller awaits the wrapped operation.

## What the wrapper does and does not save

If `FetchFromDbAsync` or EF Core's `SingleAsync` already returns a `Task<T>`, wrapping it does not remove that task or its async state machine:

```text
cache hit -> completed ValueTask<T>, no separate completed Task<T>
DB miss   -> existing DB Task<T> + a small ValueTask<T> wrapper
```

A non-`async` outer wrapper avoids its own state machine. The inner operation retains all of its normal cost. The asynchronous branch therefore has roughly ordinary Task cost plus the wrapper; there is no double allocation win.

An `async ValueTask<T>` method is valid:

```csharp
public async ValueTask<UserDto> GetUserAsync(int id, CancellationToken ct)
{
    if (_cache.TryGetValue(id, out var cached))
        return cached;

    return await FetchFromDbAsync(id, ct);
}
```

Inside an `async ValueTask<T>` method, `return cached;` returns the result value `T`; the method builder creates the completed wrapper. Returning `ValueTask.FromResult(cached)` there is the wrong shape because the `return` statement expects `T`, not `ValueTask<T>`.

The async version can still finish synchronously, but it pays state-machine/builder machinery. When an await does not complete synchronously, the method must preserve state and may allocate on the heap. For a frequent cache hit, the non-async wrapper is the cheaper shape.

## Consumption rules

Treat a `ValueTask` as a single-consumption value, especially when backed by `IValueTaskSource<T>`. Do not casually cache it, await it repeatedly, or give it to several consumers. Convert once with `.AsTask()` when repeated awaits, caching, or ordinary Task composition are required.

Specialized pooled/reusable operations and `IValueTaskSource<T>` can also complete without a Task on an async-looking path. Typical application-level I/O through EF Core or `HttpClient` is normally task-backed, so that branch does not receive the same benefit.

Public APIs often remain clearer as `Task<T>` because its consumption and composition rules are simpler. Choose `ValueTask<T>` only when measurement shows a hot path with common synchronous completion; confirm the tradeoff with a benchmark rather than applying it mechanically.

## What should be recallable

- Which result/source forms can a `ValueTask<T>` represent?
- Where does the completed-result allocation saving occur?
- Why does wrapping an EF Core/HttpClient Task not eliminate its cost?
- How does a non-`async` cache-first wrapper differ from `async ValueTask<T>`?
- Why is `return cached` correct inside an async ValueTask method?
- When is `.AsTask()` required?
- Why do general public APIs often prefer `Task<T>`?

## Related knowledge

- `dotnet.server-threadpool-async-io-and-background-work` — why `Task.Run` does not convert blocking I/O into true asynchronous I/O.

## Sources

- Workspace: `_ai-conspects/valuetask/`
- Authoritative processed sources: `10-full-source-preserving-transcript-v002.md`, S-001 through S-017, and `11-technical-corrections-v002.md`
- Original SVG: `source/valuetask.svg`
