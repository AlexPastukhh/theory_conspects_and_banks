# Execution, memory, and failure boundaries

Knowledge ID: `architecture.execution-memory-and-failure-boundaries`

Topic: `architecture`

Browsers and managed servers both have call stacks and managed heaps, but their isolation and blast radius differ. A page or worker is isolated from a server process; a fatal server-process failure can affect many concurrent requests.

Keep four failure classes distinct:

```text
deep or unbounded synchronous recursion -> stack exhaustion
large retained graphs / repeated allocations / copies -> heap and GC pressure
ordinary exception -> failure within a handled execution path
fatal runtime or unhandled host-level failure -> possible process termination
```

A garbage-collection pause reclaims or compacts memory and temporarily pauses execution; it is not process termination. Memory may eventually be reclaimed while allocation rate, retention, copying, or pauses still create material latency.

Ownership also differs across boundaries. Browser workers normally exchange cloned or transferred data. Server threads execute inside one process and can access shared process memory, so synchronization and explicit ownership matter.

Diagnosis should separate stack overflow, heap growth, GC pauses, ordinary exceptions, and fatal process failure instead of labeling all of them “memory errors.” Responsive systems avoid unbounded recursion, monitor allocation and retention, reduce unnecessary shared state and copies, and keep failure boundaries explicit.

## What should be recallable

- How do browser and server failure blast radii differ?
- Why is eventual garbage collection compatible with serious latency?
- How does worker message isolation differ from shared server-process memory?
- Why is a GC pause not equivalent to process termination?

## Sources

- Workspace: `_ai-conspects/server browser threads,memory, webworkers , runtime vs compiler , es/`
- Authoritative processed source: `regions/R03-memory-model-stack-overflow-heap-pressure-gc-pauses-and-process-termination.md`
- Original SVG: `source/server browser threads,memory, webworkers , runtime vs compiler , es.svg`
