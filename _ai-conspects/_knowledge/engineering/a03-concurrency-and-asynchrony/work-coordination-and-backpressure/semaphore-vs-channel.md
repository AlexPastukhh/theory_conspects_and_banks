# SemaphoreSlim versus Channel<T>

Knowledge ID: `dotnet.semaphore-vs-channel`

Topic: `dotnet`

`SemaphoreSlim` and `Channel<T>` solve different dimensions of concurrency.

`SemaphoreSlim` is an asynchronously waitable counter. It limits how many operations execute concurrently but carries no work items. Use it when work should begin as soon as a permit is available and the central concern is preventing too many simultaneous HTTP calls, database operations, or CPU-heavy tasks.

`Channel<T>` is an asynchronous producer-consumer queue. Producers write values; consumers await and read them. It owns queued items, wakes readers as data arrives, and can provide bounded capacity/backpressure. Use it when work is produced now and consumed later, producers and consumers should be decoupled, or one/multiple consumer loops own processing.

A semaphore-gated handler coordinates access to an operation. A WebSocket-style outgoing channel instead queues messages for a dedicated sender loop. The former controls active count; the latter coordinates data flow over time. They can be combined when a queued pipeline also needs a concurrency bound.

## What should be recallable

- Why a semaphore is an access counter rather than a work queue.
- Why a channel stores values and separates producers from consumers.
- When immediate permit-gated execution fits versus queued/backpressured processing.
- How an outgoing-message sender loop differs from several gated concurrent calls.

## Sources

- Workspace: `_ai-conspects/semaphoreslim vs channel/`
- Processed source: `regions/R01-final-transcript.md`, complete verified transcript
- Original SVG: `source/semaphoreslim vs channel.svg`
