# C# pointers, pinning, and managed alternatives

Knowledge ID: `dotnet.csharp-pointers-pinning-and-alternatives`

Topic: `dotnet`

## Unsafe pointer operations

C# permits raw pointers only in an `unsafe` method, type, or block, and the project must enable unsafe code:

```csharp
unsafe
{
    int x = 10;
    int* p = &x;
    Console.WriteLine(*p);
}
```

`int*` is a pointer to `int`, `&x` takes an address, and `*p` dereferences it. Unsafe code also permits `p + 1`, `p[0]`, and comparisons with `null` or compatible pointers. Arithmetic advances in units of the pointed-to type, not raw bytes; the programmer must remain inside valid memory.

The unsafe boundary exists because invalid addresses, out-of-bounds arithmetic, lifetime errors, corruption, crashes, and security defects fall outside normal CLR safety guarantees.

## GC movement and pinning

The GC may move managed objects. A pointer into an array or object would then become invalid, so pin it only for the access duration:

```csharp
unsafe
{
    int[] values = { 10, 20, 30 };

    fixed (int* p = values)
    {
        Console.WriteLine(p[0]);
        Console.WriteLine(p[1]);
    }
}
```

`fixed` prevents relocation only within its scope. Keep pinning short because long-lived pinned objects can fragment the managed heap. `stackalloc` creates a stack buffer; modern C# commonly exposes it through `Span<T>` instead of a raw pointer.

## Appropriate uses and alternatives

Raw pointers fit native interop/P/Invoke, measured low-level memory processing, custom binary parsers/serializers, unmanaged buffers/device APIs, and runtime or systems-library implementation. Most application, web, and business code does not need them.

Prefer `Span<T>`/`ReadOnlySpan<T>` for bounds-checked contiguous memory, `Memory<T>` for longer-lived or async ownership, and `ref`, `in`, or `ref readonly` for managed references. `IntPtr`, `UIntPtr`, `nint`, and `nuint` hold native-sized values often used at interop boundaries but are not automatically typed C-style pointers.

## What should be recallable

- Pointer declaration, address-of, dereference, arithmetic/indexing, and the unsafe boundary.
- Why managed memory must be pinned, the scope/lifetime rule, and fragmentation cost.
- Suitable pointer use cases and the different guarantees of spans, memory, managed refs, and native-sized values.

## Sources

- Workspace: `_ai-conspects/pointers/`
- Processed source: `regions/R01-csharp-pointers-unsafe-fixed-interop-final.md`, R01
- Original SVG: `source/pointers.svg`
