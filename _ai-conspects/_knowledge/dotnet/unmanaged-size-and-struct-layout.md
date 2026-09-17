# Unmanaged types, size APIs, and struct layout

Knowledge ID: `dotnet.unmanaged-size-and-struct-layout`

Topic: `dotnet`

An unmanaged type is a value type whose fields recursively contain no managed references. Numeric primitives, enums, pointers, and structs composed only of unmanaged fields qualify. A generic constraint can make that requirement explicit:

```csharp
static void ProcessRaw<T>(T value) where T : unmanaged
{
    // Pointer-oriented or raw-byte operations can be permitted here.
}
```

## Different size questions

Several APIs called “size” answer different questions:

- `sizeof(T)` gives the unmanaged/native in-memory size in an allowed unsafe context;
- `Unsafe.SizeOf<T>()` gives the CLR managed size of a value of `T`;
- `Marshal.SizeOf<T>()` gives marshaling/interoperability size, which may differ;
- `MemoryMarshal.AsBytes` exposes compatible value elements as a byte view.

Raw in-memory bytes include platform endianness and possible padding. They are not automatically a stable serialization format.

## Copying, padding, and alignment

Ordinary structs are copied by value unless passed with `ref`, `in`, or `out`. Large mutable structs can therefore be costly and can produce surprising independent copies.

The runtime may insert padding between fields and at the end of a struct to satisfy alignment. Placing fields with larger alignment requirements before smaller fields can reduce holes, but changing field order or layout can break interoperability or an existing binary contract. Auto-properties also generate backing fields and contribute to size.

A common guideline favors small immutable value types around 16 bytes or less, but this is not a runtime rule. Larger structs may be appropriate when copying is controlled and measurement supports the choice. `readonly struct` and `in` communicate read-only intent and may avoid copies in some cases; validate the actual effect through profiling.

Use unmanaged constraints and raw-byte APIs only when layout, lifetime, endianness, and storage ownership are explicit.

## What should be recallable

- The recursive “no managed references” meaning of `unmanaged`.
- How `sizeof`, `Unsafe.SizeOf`, `Marshal.SizeOf`, and `MemoryMarshal.AsBytes` differ.
- Why raw bytes do not automatically define a portable serialization.
- How value copying, padding, alignment, auto-property fields, and interop contracts affect layout choices.
- Why the small-struct guideline is heuristic rather than a hard limit.
- Why raw-byte access requires explicit layout, lifetime, endianness, and ownership contracts.

## Sources

- Workspace: `_ai-conspects/span,memory,stackalloc,stackoverflow,calculate bytes, unmanaged types/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, sections 09–12
- Original SVG: `source/span,memory,stackalloc,stackoverflow,calculate bytes, unmanaged types.svg`
