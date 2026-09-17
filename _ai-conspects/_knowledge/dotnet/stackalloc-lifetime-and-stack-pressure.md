# `stackalloc` lifetime, stack pressure, and heap-safe fallback

Knowledge ID: `dotnet.stackalloc-lifetime-and-stack-pressure`

Topic: `dotnet`

`stackalloc` reserves raw element storage in the current stack frame. The storage disappears when the method returns and is not managed by the GC:

```csharp
Span<byte> buffer = stackalloc byte[256];
```

It fits small, bounded scratch buffers in hot synchronous parsing, formatting, or encoding paths. Large or user-controlled lengths should use an array or pool.

## Threshold and ownership pattern

A threshold can select stack storage for small inputs and rented storage for larger inputs:

```csharp
byte[]? rented = null;
Span<byte> buffer = length <= 256
    ? stackalloc byte[length]
    : (rented = ArrayPool<byte>.Shared.Rent(length));

try
{
    buffer = buffer[..length];
    // Use only the logical length.
}
finally
{
    if (rented is not null)
        ArrayPool<byte>.Shared.Return(rented, clearArray: true);
}
```

The threshold is application-specific. Account for total frame size, nesting and recursion, and the platform's thread-stack size. Pooled storage must remain rented until every consumer is finished; return it in `finally`, and clear sensitive data or references when required.

## Stack pressure and escape rules

Large or repeated stack allocation can exhaust the thread stack. Stack overflow is generally not recoverable inside the process. Avoid `stackalloc` inside a loop when iterations may accumulate pressure in the same method frame; allocate once outside the loop and reuse the span where possible.

Moving the allocation into a helper does not make its memory escapable. The helper can consume the span completely and return an ordinary result, but it cannot return a view over its own stack frame.

A span or stack-backed reference cannot remain live across `await`: the async state machine is heap-stored. Use array-backed `Memory<T>`, `ArrayPool<T>`, `MemoryPool<T>`/`IMemoryOwner<T>`, or another explicit heap-safe owner when data must survive an asynchronous boundary.

## Selection boundary

```text
small + bounded + synchronous scratch -> stackalloc
larger/repeated local buffer          -> ArrayPool<T>
ownership crosses components/await    -> MemoryPool<T> / IMemoryOwner<T>
ordinary simplicity is sufficient     -> array
```

## Related knowledge

- `dotnet.span-memory-and-ref-safety` — stack-only span restrictions and ownership of views.
- `dotnet.pooling-objects-arrays-and-memory` — rental, return, and ownership-transfer contracts.

## What should be recallable

- What owns `stackalloc` storage and when it expires.
- Why thresholds must consider the whole stack, not only one buffer.
- Why allocating repeatedly in a loop and returning a helper's stack view are unsafe.
- Which heap-safe owners can cross `await` and how rented storage is returned.

## Sources

- Workspace: `_ai-conspects/span,memory,stackalloc,stackoverflow,calculate bytes, unmanaged types/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, sections 05–07
- Original SVG: `source/span,memory,stackalloc,stackoverflow,calculate bytes, unmanaged types.svg`
