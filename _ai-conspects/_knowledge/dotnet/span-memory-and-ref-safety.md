# Span, Memory, and ref safety

Knowledge ID: `dotnet.span-memory-and-ref-safety`

Topic: `dotnet`

`Span<T>` is a mutable contiguous view over arrays, slices, `stackalloc`, or other compatible storage; `ReadOnlySpan<T>` is a read-only view. Slicing copies only view metadata, not elements, so all slices still refer to the same owner.

Because a span may reference stack memory, it is a `ref struct`: it cannot be boxed, stored in ordinary heap fields, captured by lambdas, used across `await`/`yield`, or used as a normal generic argument. A custom `ref struct` propagates these lifetime restrictions. Never return a view over local `stackalloc`; a view over caller-owned memory can safely be returned. `scoped` expresses non-escape intent.

Bound small scratch buffers and fall back to the heap:

```csharp
Span<byte> buffer = requiredLength <= 256
    ? stackalloc byte[requiredLength]
    : new byte[requiredLength];
```

Span-aware parsing avoids substrings. `CopyTo`/`TryCopyTo` copy into existing storage; `ToArray` intentionally creates ownership.

`Memory<T>`/`ReadOnlyMemory<T>` are storable and can cross async boundaries. Their backing storage must outlive the current stack frame, so a `Memory<T>` cannot safely describe `stackalloc` memory. Reacquire `.Span` after an `await`, rather than keeping a span live across it. Copying a span or memory descriptor copies only the descriptor; both values still refer to the same elements.

Views do not own storage: arrays, pool owners, native allocations, strings, or stack frames do. Every API boundary must make clear who owns the buffer, how long it is valid, whether mutation is allowed, whether a consumer may retain it, and when pooled storage is returned. Never retain a view after its producer reuses or returns the owner.

An ordinary property does not expose a stable location for a `ref` argument. A deliberately ref-returning property or method can expose one. A class may also create a temporary span over its own longer-lived storage without storing a span field:

```csharp
public Span<byte> Data => _buffer.AsSpan(0, _length);
```

Any ref or span return must point to storage that outlives the caller's use; local stack storage cannot be returned. Prefer ordinary arrays or strings when allocation savings are unmeasured or irrelevant.

## What should be recallable

- Span mutability, slicing, and shared backing storage.
- Why `Span<T>` is stack-only while `Memory<T>` can be stored and cross `await`.
- Why `Memory<T>` cannot safely describe `stackalloc` storage.
- The ownership/lifetime contract required when views cross producer/consumer boundaries.
- Which storage a ref-returning or span-returning API may safely expose.

## Sources
- Workspace: `_ai-conspects/struct span/`
- Processed source: `01-final-transcript.md`, complete transcript
- Workspace: `_ai-conspects/span,memory,stackalloc,stackoverflow,calculate bytes, unmanaged types/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, sections 02–04, 08, and 12
- Original SVG: `source/span,memory,stackalloc,stackoverflow,calculate bytes, unmanaged types.svg`
