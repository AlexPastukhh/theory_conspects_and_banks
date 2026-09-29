# A04 — Runtime, Operating Systems, Memory & Resources

This index is a physical/navigation projection. Finer semantic placement remains in the semantic hierarchy.

## Memory & Resource Lifecycle

### Area-owned Units

- [`dotnet.allocations-gc-pressure-and-hot-paths` — .NET allocations, GC pressure, and hot-path decisions](memory-and-resource-lifecycle/allocations-gc-pressure-and-hot-paths.md)
- [`dotnet.stackalloc-lifetime-and-stack-pressure` — `stackalloc` lifetime, stack pressure, and heap-safe fallback](memory-and-resource-lifecycle/stackalloc-lifetime-and-stack-pressure.md)
- [`dotnet.disposable-ownership-and-deterministic-cleanup` — Disposable ownership and deterministic cleanup](memory-and-resource-lifecycle/disposable-ownership-and-deterministic-cleanup.md)
- [`dotnet.dispose-pattern-and-suppress-finalize` — Dispose pattern and SuppressFinalize](memory-and-resource-lifecycle/dispose-pattern-and-suppress-finalize.md)
- [`dotnet.gc-roots-reachability-and-disposal-state` — GC roots, reachability, and disposal state](memory-and-resource-lifecycle/gc-roots-reachability-and-disposal-state.md)
- [`dotnet.pooling-objects-arrays-and-memory` — ObjectPool, ArrayPool, and MemoryPool ownership](memory-and-resource-lifecycle/pooling-objects-arrays-and-memory.md)
- [`dotnet.span-memory-and-ref-safety` — Span, Memory, and ref safety](memory-and-resource-lifecycle/span-memory-and-ref-safety.md)
- [`dotnet.unmanaged-ownership-safehandle-and-finalizer-decisions` — Unmanaged ownership, SafeHandle, and finalizer decisions](memory-and-resource-lifecycle/unmanaged-ownership-safehandle-and-finalizer-decisions.md)
- [`dotnet.unmanaged-size-and-struct-layout` — Unmanaged types, size APIs, and struct layout](memory-and-resource-lifecycle/unmanaged-size-and-struct-layout.md)

### Technology Core links

- [`dotnet.csharp-pointers-pinning-and-alternatives` — C# pointers, pinning, and managed alternatives](../../technology-core/dotnet/csharp-pointers-pinning-and-alternatives.md)
- [`dotnet.conditionalweaktable-lifetime-associations` — ConditionalWeakTable lifetime associations](../../technology-core/dotnet/conditionalweaktable-lifetime-associations.md)
- [`dotnet.finalizer-lifecycle-costs-and-failure-boundaries` — Finalizer lifecycle, costs, and failure boundaries](../../technology-core/dotnet/finalizer-lifecycle-costs-and-failure-boundaries.md)

## Runtime & Toolchain

### Area-owned Units

- [`architecture.runtime-compiler-and-sdk-responsibilities` — Runtime, compiler, and SDK responsibilities](runtime-and-toolchain/runtime-compiler-and-sdk-responsibilities.md)

## Time & Clocks

### Area-owned Units

- [`dotnet.ticks-unix-time-and-javascript-display` — .NET ticks, Unix time, and JavaScript display](time-and-clocks/ticks-unix-time-and-javascript-display.md)
- [`dotnet.time-types-and-model-selection` — .NET time types and model selection](time-and-clocks/time-types-and-model-selection.md)
- [`dotnet.timezone-conversion-json-and-model-binding` — .NET timezone conversion, JSON, and model binding](time-and-clocks/timezone-conversion-json-and-model-binding.md)
- [`dotnet.ambiguous-local-time-scheduling-and-audit` — Ambiguous local-time scheduling and audit](time-and-clocks/ambiguous-local-time-scheduling-and-audit.md)
- [`dotnet.invalid-local-time-resolution-policies` — Invalid local-time resolution policies](time-and-clocks/invalid-local-time-resolution-policies.md)
- [`dotnet.timezone-date-math-and-dst` — Timezone-aware date math and DST](time-and-clocks/timezone-date-math-and-dst.md)

### Technology Core links

- [`dotnet.datetime-offset-kind-conversion-and-arithmetic` — DateTime offset, Kind, conversion, and arithmetic](../../technology-core/dotnet/datetime-offset-kind-conversion-and-arithmetic.md)
