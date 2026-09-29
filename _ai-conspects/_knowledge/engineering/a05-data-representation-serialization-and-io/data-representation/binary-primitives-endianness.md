# BinaryPrimitives and explicit endianness

Knowledge ID: `dotnet.binary-primitives-endianness`

Topic: `dotnet`

Byte sequences do not identify their own byte order. `System.Buffers.Binary.BinaryPrimitives` reads and writes primitive numbers from spans with explicit big- or little-endian semantics, avoiding accidental dependence on machine endianness.

Families include signed/unsigned integer reads and writes, `Half`/`Single`/`Double`, `TryRead...`/`TryWrite...`, and `ReverseEndianness`.

```csharp
ReadOnlySpan<byte> bytes = stackalloc byte[] {
    0x00, 0x00, 0x00, 0x2A
};

int value = BinaryPrimitives.ReadInt32BigEndian(bytes); // 42
```

A 32-bit read requires at least four bytes. Big endian treats the first byte as most significant; little endian treats it as least significant.

```csharp
Span<byte> bytes = stackalloc byte[4];
BinaryPrimitives.WriteInt32BigEndian(bytes, 300);
```

The destination must fit the primitive. `ReverseEndianness` swaps supported numeric values when converting between host and protocol/file representations or correcting an already-read opposite-order value.

Try variants return `false` rather than throw when the source/destination span is too small; reads expose the value through `out`. Use them when partial parser buffers are expected. Use throwing methods when insufficient length indicates a programming error. Spans avoid unnecessary array copies.

## What should be recallable

- Why endianness must be explicit at binary protocol/file boundaries.
- Read/write span requirements and big- versus little-endian interpretation.
- What `ReverseEndianness` does.
- Throwing versus Try behavior for insufficient buffers and why spans help allocations.

## Sources

- Workspace: `_ai-conspects/binary primitives/`
- Processed source: `01-final-transcript.md`, complete semantic transcript
- Original SVG: `source/binary primitives.svg`
