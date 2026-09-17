# .NET allocations, GC pressure, and hot-path decisions

Knowledge ID: `dotnet.allocations-gc-pressure-and-hot-paths`

Topic: `dotnet`

A managed heap allocation costs more than object construction: the runtime must track the object and eventually reclaim it. Classes, arrays, strings, delegates/closures, iterator state machines, and some asynchronous state machines allocate. An unboxed struct does not require a separate heap object; its data may live in a local or inline inside another heap object/array. Boxing creates a separate heap object. `List<int>` itself is still a heap object, while `Span<T>` is a stack-only view rather than owned heap storage.

Stack storage is thread-local and does not create GC work; the managed heap is shared and coordinated. Contiguous arrays can also have better locality than pointer-linked structures in tight iteration, although data shape and workload still decide the result.

Heap allocation is not inherently wrong. Startup, configuration, one-time scripts, and cold paths usually favor clarity. Allocation rate and lifetime become important in hot loops, large-data work, interactive latency, and high-throughput servers.

## Generations, pauses, and process-wide effects

```text
Gen 0 -> new and usually short-lived objects
Gen 1 -> survivors of Gen 0
Gen 2 -> long-lived survivors and retained graphs
```

Frequent request allocations create Gen 0 pressure. Objects retained across collections can be promoted; expensive Gen 2 work can produce latency spikes and timeouts. The source identifies Server GC as the ASP.NET Core default: it uses multiple heaps and optimizes throughput, but collection/coordination still affects request-processing threads.

Requests have separate execution contexts but share the process's managed heap. One allocation-heavy endpoint or an unbounded static cache can therefore hurt unrelated requests. A fast handler can appear slow when a GC pause occurs inside its request timeline.

Allocation pressure can participate in a feedback loop:

```text
high allocation rate
-> GC pauses and less useful CPU time
-> request backlog / ThreadPool pressure
-> more concurrent work and thread injection
-> more allocation and GC pressure
```

GC is not process failure, and eventual reclamation does not make high allocation rate harmless. Retained request graphs, large caches, and other long-lived references increase the live set and promotion cost.

## Reduce rate first, then lifetime

Useful measured techniques include:

- pre-size lists/dictionaries and reusable buffers when the size is knowable;
- remove accidental boxing, closures, and allocation-heavy LINQ from demonstrated hot paths;
- keep request data out of static/long-lived containers and bound caches;
- use spans/stack allocation only for bounded synchronous scratch work;
- rent buffers or reusable objects when size/frequency justifies the ownership complexity;
- use `ValueTask` only where synchronous completion is common and measurement supports it.

Heap churn is rapid creation and disposal of short-lived objects. Repeated string concatenation in a loop is a common example because strings are immutable. `StringBuilder` reduces intermediate strings for many appends; pooling builders or character buffers can reduce repeated buffer creation, but shared static mutation is unsafe and oversized pooled objects retain memory.

A request that creates `Guid.NewGuid().ToString()`, formats `DateTime.UtcNow`, and builds a temporary `List<int>` illustrates churn: each object may live for milliseconds while a high request rate makes aggregate cleanup expensive. Safer reuse choices named by the source include `ArrayPool<char>`, a bounded `StringBuilder` cache, and object-pool policies. Tune `ThreadPool.MinThreads` only conservatively; it does not remove the allocation/GC cause of backlog.

Measure before and after with realistic load. Relevant tools include `dotnet-counters`, `dotnet-trace`, `dotnet-gcdump`, PerfView, and allocation profilers. Optimize the hot allocation path rather than imposing low-level ownership rules everywhere.

## Related knowledge

- `dotnet.span-memory-and-ref-safety`
- `dotnet.pooling-objects-arrays-and-memory`
- `dotnet.stringbuilder-mutation-and-sizing`
- `architecture.execution-memory-and-failure-boundaries`

## Sources

- Workspace: `_ai-conspects/allocations/`
- Authoritative processed source: `regions/R01R02R03R04-allocations-gc-low-allocation-patterns-final.md`, R01-R04
- Original SVG: `source/allocations.svg`
