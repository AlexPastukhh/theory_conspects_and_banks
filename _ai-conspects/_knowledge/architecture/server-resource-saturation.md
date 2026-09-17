# Finite server resources and saturation

Knowledge ID: `architecture.server-resource-saturation`

Topic: `architecture`

## Capacity is multi-dimensional

A server has no universal request capacity. Each request consumes a mixture of finite shared resources, and the first saturated dependency becomes the effective bottleneck.

CPU is shared among runnable request and background work. A request receives scheduled CPU slices rather than owning a core until completion. Parsing, routing, authentication, JSON, validation, compression, TLS, business logic, regex/image work, and database-result mapping all consume CPU. Saturation produces scheduling waits, rising latency and queues, and little throughput gain from added concurrency.

CPU can be treated as a compute-time-per-second budget on a machine with, for example, `4`, `8`, or `32` cores. Requests needing `5 ms`, `20 ms`, `2 ms`, and `50 ms` of CPU consume pieces of the capacity supplied by those cores. One core executes one instruction stream at a time, while the OS and runtime share it among many requests and runtime work over time. Saturation begins when total runnable demand exceeds what the cores can keep up with.

Memory is consumed by request buffers, framework state, caches, sessions, uploads, queues, and application objects. Pressure can increase garbage collection, paging, eviction, and repeated allocation even when CPU does not look saturated.

Network bandwidth covers request/response bodies, uploads/downloads, health checks, internal calls, WebSockets, and database/cache traffic. The whole path can limit it: client, proxy/load balancer, cloud or container limits, congestion, and NIC. Ten downloads cannot each receive a shared `100 MB/s` outbound budget. Reject doomed large requests early so their inbound bytes do not delay valid traffic.

A useful numeric model is that `1 Gbit/s` is roughly `125 MB/s` total before protocol effects. If outbound capacity is `100 MB/s`, one user downloading a `100 MB` file may approach that rate, while ten concurrent large downloads share fractions of the same budget. The limiting segment may be outside the process: the NIC, VM/container or cloud-instance cap, proxy/load balancer, congested path, client, or another service.

Early rejection matters concretely. With `50 MB/s` inbound capacity and `20` clients each uploading `200 MB`, receiving bodies from ten clients that headers already identify as unauthorized wastes half of the attempted traffic on work with no business value. Legitimate uploads slow down and failures take longer to fail. The source compares the shared path to a highway: large uploads and downloads are trucks whose use of finite carrying capacity slows everyone else.

## Other finite resources

Connections consume file descriptors, ephemeral ports, backlog capacity, socket buffers, proxy quotas, and application slots. Slow/open connections can exhaust capacity with little handler CPU; once connection limits are exhausted, new accepts may fail or queue badly.

Blocking calls occupy finite worker threads or execution slots and can cause ThreadPool starvation. Prefer asynchronous I/O, bounded concurrency, timeouts/cancellation, and no sync-over-async.

Disk has finite bandwidth and IOPS for logs, temp files, uploads, local databases, and processing. TLS handshakes and cryptography consume CPU and sometimes dedicated acceleration resources, so connection churn can cost more than pooled long-lived connections.

The limiting resource may be downstream: database and HTTP connection pools, Redis, brokers, third-party quotas, locks, or query capacity. A pool of 100 database connections is the bottleneck once all 100 are busy, regardless of free request threads.

OS/platform limits include file descriptors, TCP backlog, ports, process/container quotas, CPU limits, bandwidth limits, and proxy limits. Applications add semaphores, bounded channels, queues, rate-limit buckets, caches, and connection pools.

## Operating model

```text
incoming request
  -> network / connection capacity
  -> worker or async execution capacity
  -> CPU and memory
  -> database, cache, disk, downstream pools
  -> response network capacity
```

At any stage, finite capacity plus an unbounded arrival rate produces queue growth, latency, timeouts, and failure. Measure the saturated resource, bound queues, apply backpressure, reject excess work early, reuse connections, stream large bodies, cache suitable work, avoid blocking, and scale the actual bottleneck.

## What should be recallable

- Why request capacity is determined by the first saturated shared resource.
- CPU, memory, network, connection, worker, disk, TLS, dependency, OS, and application-level limits and their symptoms.
- Why extra concurrency can reduce throughput and why early rejection, bounded queues, backpressure, streaming, pooling, and measurement matter.

## Sources

- Workspace: `_ai-conspects/server resources,multipleinstances,microservices/`
- Processed source: `01-final-transcript.md`, R01 and end-to-end capacity model
- Original SVG: `source/server resources,multipleinstances,microservices(1).svg`
- Workspace: `_ai-conspects/server-resources-multipleinstances-microservices/`
- Processed source: `regions/SRM01-finite-server-resources-and-bottlenecks-v001.md`, S-001–S-012; `regions/SRM02-shared-bandwidth-cpu-budgets-and-saturation-v001.md`, S-013–S-024
- Original SVG: `assets/raw/full.svg`
