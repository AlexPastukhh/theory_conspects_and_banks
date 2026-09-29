# A03 — Concurrency & Asynchrony

This index is a physical/navigation projection. Finer semantic placement remains in the semantic hierarchy.

## Async Execution & Scheduling

### Area-owned Units

- [`dotnet.async-failure-ordering-and-server-safety` — Async failure policy, ordering, and server safety](async-execution-and-scheduling/async-failure-ordering-and-server-safety.md)
- [`dotnet.server-threadpool-async-io-and-background-work` — Server thread pool, asynchronous I/O, and background-work ownership](async-execution-and-scheduling/server-threadpool-async-io-and-background-work.md)
- [`dotnet.valuetask-synchronous-completion-and-consumption` — ValueTask synchronous completion and consumption](async-execution-and-scheduling/valuetask-synchronous-completion-and-consumption.md)

### Technology Core links

- [`dotnet.async-concurrency-and-task-start` — Async concurrency, parallelism, and when tasks start](../../technology-core/dotnet/async-concurrency-and-task-start.md)
- [`javascript.timers-tasks-microtasks-and-abortable-delay` — JavaScript timers, tasks, microtasks, and abortable delay](../../technology-core/javascript/timers-tasks-microtasks-and-abortable-delay.md)
- [`javascript.pending-promises-and-external-completion` — Pending promises and external completion](../../technology-core/javascript/pending-promises-and-external-completion.md)
- [`javascript.promise-all-concurrency-and-outcomes` — Promise.all concurrency and outcomes](../../technology-core/javascript/promise-all-concurrency-and-outcomes.md)

## Cancellation & Time Bounds

### Area-owned Units

- [`dotnet.cancellation-tokens-linked-sources-and-causes` — Cancellation tokens, linked sources, and cause detection](cancellation-and-time-bounds/cancellation-tokens-linked-sources-and-causes.md)
- [`aspnet-core.request-cancellation-and-pipeline-short-circuiting` — Request cancellation and pipeline short-circuiting](cancellation-and-time-bounds/request-cancellation-and-pipeline-short-circuiting.md)
- [`aspnet-core.request-aborted-propagation` — RequestAborted propagation in middleware and filters](cancellation-and-time-bounds/request-aborted-propagation.md)

### Technology Core links

- [`javascript.async-generators-and-cancellation` — Async generators and responsive cancellation](../../technology-core/javascript/async-generators-and-cancellation.md)

## Synchronization & Memory Ordering

### Area-owned Units

- [`dotnet.interlocked-atomic-transitions` — Interlocked atomic transitions and flag operations](synchronization-and-memory-ordering/interlocked-atomic-transitions.md)
- [`dotnet.lazy-initialization-and-argument-patterns` — Lazy<T> initialization, async tasks, and argument patterns](synchronization-and-memory-ordering/lazy-initialization-and-argument-patterns.md)
- [`dotnet.lazy-thread-safety-modes-and-exception-caching` — LazyThreadSafetyMode semantics and exception caching](synchronization-and-memory-ordering/lazy-thread-safety-modes-and-exception-caching.md)
- [`dotnet.monitor-condition-waiting-and-signaling` — Monitor condition waiting and signaling](synchronization-and-memory-ordering/monitor-condition-waiting-and-signaling.md)
- [`dotnet.monitor-mutual-exclusion-and-lock-ownership` — Monitor mutual exclusion and lock ownership](synchronization-and-memory-ordering/monitor-mutual-exclusion-and-lock-ownership.md)

### Technology Core links

- [`javascript.async-semaphore-permits-and-waiter-lifecycle` — JavaScript async semaphore permits and waiter lifecycle](../../technology-core/javascript/async-semaphore-permits-and-waiter-lifecycle.md)

## Work Coordination & Backpressure

### Area-owned Units

- [`dotnet.bounded-async-concurrency` — Bounded async concurrency with SemaphoreSlim and Parallel.ForEachAsync](work-coordination-and-backpressure/bounded-async-concurrency.md)
- [`dotnet.channels-producer-consumer-lifecycle` — Channel<T> producer-consumer lifecycle](work-coordination-and-backpressure/channels-producer-consumer-lifecycle.md)
- [`dotnet.per-key-async-single-flight` — Per-key async single-flight with gates and shared tasks](work-coordination-and-backpressure/per-key-async-single-flight.md)
- [`dotnet.semaphore-vs-channel` — SemaphoreSlim versus Channel<T>](work-coordination-and-backpressure/semaphore-vs-channel.md)
