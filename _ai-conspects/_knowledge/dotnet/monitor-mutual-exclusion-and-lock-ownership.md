# Monitor mutual exclusion and lock ownership

Knowledge ID: `dotnet.monitor-mutual-exclusion-and-lock-ownership`

Topic: `dotnet`

A short, memory-only critical section protected by `lock` is ordinary synchronous coordination. The scalability problem is holding a request thread while waiting for I/O or long work: for example `Thread.Sleep`, `.Result`/`.Wait()` over async I/O, synchronous database/network/file calls when async alternatives exist, or expensive work inside the lock.

## Use a private coordination object

The monitor belongs to the reference object passed to `lock` or `Monitor`. Use a dedicated `private readonly` gate so unrelated code cannot acquire the same monitor accidentally.

```csharp
private readonly object _gate = new();
private int _counter;

public void Increment()
{
    lock (_gate)
    {
        _counter++;
    }
}
```

Avoid locking on `this`, `typeof(...)`, public objects, or interned strings. One gate permits one owning thread in its critical section at a time; different gates are independent.

## `lock` is scoped `Monitor` ownership

Conceptually, C# lowers a `lock` to monitor entry plus guaranteed release:

```csharp
Monitor.Enter(_gate);
try
{
    DoWork();
}
finally
{
    Monitor.Exit(_gate);
}
```

The `finally` is essential: the owner releases the monitor even if protected work throws.

`Monitor.Enter` waits until ownership is available. `TryEnter` supports an immediate attempt or a bounded wait, which enables fallback instead of indefinite blocking:

```csharp
if (Monitor.TryEnter(_gate, TimeSpan.FromMilliseconds(100)))
{
    try
    {
        DoWork();
    }
    finally
    {
        Monitor.Exit(_gate);
    }
}
else
{
    UseFallback();
}
```

The `ref bool lockTaken` overload makes ownership explicit even if acquisition itself fails:

```csharp
bool lockTaken = false;
try
{
    Monitor.TryEnter(
        _gate,
        TimeSpan.FromMilliseconds(100),
        ref lockTaken);

    if (lockTaken)
        DoWork();
}
finally
{
    if (lockTaken)
        Monitor.Exit(_gate);
}
```

Only the owning thread may call `Monitor.Exit`. `Wait`, `Pulse`, and `PulseAll` also require current ownership; violating these ownership rules throws `SynchronizationLockException`.

Monitors are reentrant. The owning thread can enter the same monitor again; the runtime increments a recursion count, and that thread must exit the matching number of times before another thread can acquire it.

## Async boundary

C# does not allow `await` inside `lock`. A monitor is thread-affine, scope-based synchronous ownership, while an await can suspend and resume later. For asynchronous mutual exclusion, use an async-aware primitive and release it in `finally`:

```csharp
await _semaphore.WaitAsync();
try
{
    await DoAsyncWork();
}
finally
{
    _semaphore.Release();
}
```

Keep synchronous monitor sections short and free of async I/O.

## Sources
- Workspace: `_ai-conspects/lock-monitor/`
- Authoritative processed source: `04-source-preserving-transcript-v002.md`, S-001 through S-015 and S-025
- Corrected semantic boundaries: `00-stage0-source-verification-and-corrected-boundaries-v002.md`, R01, R02, and R04

