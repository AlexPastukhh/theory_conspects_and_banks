# ObjectPool, ArrayPool, and MemoryPool ownership

Knowledge ID: `dotnet.pooling-objects-arrays-and-memory`

Topic: `dotnet`

`ObjectPool<T>` reuses expensive resettable objects. `Get` transfers exclusive temporary use and `Return` gives the object back after reset; never use an object after returning it. The pool is not a semaphore or hard capacity limit: when retained objects are checked out it may create more, while the retention limit controls only how many returned objects are cached.

`DefaultObjectPoolProvider` creates pools and is normally shared as a singleton; create and register the concrete `ObjectPool<T>` once for its consumers. `IPooledObjectPolicy<T>` defines `Create()` for a new clean object and `Return(obj)` to reset it and decide whether to retain it. Use `try/finally`, and let the policy reject invalid or oversized objects.

`ArrayPool<T>.Rent(n)` returns length ≥ n, so track logical length. Return the exact array once after every consumer finishes; arrays are not guaranteed cleared, so clear sensitive/reference data deliberately. Never return during async/parallel use.

```csharp
byte[] rented = ArrayPool<byte>.Shared.Rent(required);
try { Span<byte> used = rented.AsSpan(0, required); }
finally { ArrayPool<byte>.Shared.Return(rented, clearArray: true); }
```

`MemoryPool<T>.Rent` returns `IMemoryOwner<T>` for transferable ownership across awaits/queues/components; the final consumer disposes it. A `Memory<T>` slice is only a view and dies with its owner. Prefer ArrayPool for locally controlled lifetime, memory owners for transferred lifetime, ObjectPool for stateful resettable objects, and stack allocation for small synchronous scratch. Measure: pooling trades allocations for retained memory and correctness risk.

## Sources
- Workspace: `_ai-conspects/objectpool,arraypool,memorypool/`
- Processed source: `09-full-combined-final-transcript.md`, complete transcript
