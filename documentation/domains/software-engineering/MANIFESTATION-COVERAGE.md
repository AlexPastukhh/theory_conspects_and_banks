# Cross-Runtime Manifestation Coverage

Status: current cross-runtime coverage projection derived from the responsibility catalog. It exists to expose symmetric gaps, not to make technology names part of the canonical Area hierarchy.

Columns are deliberately broad ecosystems: `.NET`, JavaScript language, Browser, Node.js, Python, Go, and Rust. Go and Rust are newly selected expansion ecosystems; their initial `MISSING` values record the absence of durable baseline coverage after an applicability pass, not a requirement for one-to-one framework analogues. Framework/tool comparisons are secondary and should be introduced only when they clarify an underlying responsibility.

`MISSING` can therefore appear for .NET even when the repository is .NET-heavy; existing framework-specific knowledge does not automatically cover runtime/language/application foundations.

| ID | Area | Responsibility | Generic | .NET | JS language | Browser | Node.js | Python | Go | Rust |
|---|---|---|---|---|---|---|---|---|---|---|
| `M01` | `A01` | Values / type / object model | `PARTIAL` | `PARTIAL` | `PARTIAL` | `NOT_APPLICABLE` | `PARTIAL` | `MISSING` | `MISSING` | `MISSING` |
| `M02` | `A01` | Scope, closures and binding | `MISSING` | `MISSING` | `MISSING` | `NOT_APPLICABLE` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M03` | `A01` | Modules, imports and name resolution | `MISSING` | `MISSING` | `MISSING` | `NOT_APPLICABLE` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M04` | `A01` | Error / exception / result model | `MISSING` | `MISSING` | `MISSING` | `NOT_APPLICABLE` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M05` | `A03` | Async abstraction: task/promise/coroutine | `PARTIAL` | `PARTIAL` | `PARTIAL` | `PARTIAL` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M06` | `A03` | Event loop / scheduler / execution queues | `PARTIAL` | `PARTIAL` | `PARTIAL` | `PARTIAL` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M07` | `A03` | Cancellation / time bounds | `PARTIAL` | `PARTIAL` | `PARTIAL` | `PARTIAL` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M08` | `A03` | Structured concurrency / failure propagation | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M09` | `A03` | Threads / workers / processes | `MISSING` | `PARTIAL` | `PARTIAL` | `PARTIAL` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M10` | `A03` | Synchronization and memory-ordering model | `PARTIAL` | `PARTIAL` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M11` | `A03` | Channels / queues / bounded concurrency / backpressure | `PARTIAL` | `PARTIAL` | `PARTIAL` | `PARTIAL` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M12` | `A04` | Runtime / compiler / interpreter / toolchain model | `PARTIAL` | `PARTIAL` | `MISSING` | `NOT_APPLICABLE` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M13` | `A04` | Process lifecycle, environment, signals, startup/shutdown | `MISSING` | `MISSING` | `NOT_APPLICABLE` | `NOT_APPLICABLE` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M14` | `A04` | Filesystem / handles / permissions | `MISSING` | `MISSING` | `NOT_APPLICABLE` | `NOT_APPLICABLE` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M15` | `A04` | Memory management / GC / reachability | `PARTIAL` | `PARTIAL` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M16` | `A04` | Deterministic resource cleanup / ownership | `PARTIAL` | `PARTIAL` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M17` | `A04` | Native / FFI boundary | `MISSING` | `PARTIAL` | `MISSING` | `NOT_APPLICABLE` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M18` | `A04` | Clock / timezone / timer model | `PARTIAL` | `PARTIAL` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M19` | `A05` | Streams / file I/O / incremental I/O | `PARTIAL` | `PARTIAL` | `MISSING` | `PARTIAL` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M20` | `A05` | Serialization / schema / compatibility model | `PARTIAL` | `PARTIAL` | `PARTIAL` | `PARTIAL` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M21` | `A06` | HTTP client and connection semantics | `PARTIAL` | `PARTIAL` | `PARTIAL` | `PARTIAL` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M22` | `A07` | Application host / startup / shutdown lifecycle | `MISSING` | `MISSING` | `NOT_APPLICABLE` | `NOT_APPLICABLE` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M23` | `A07` | Request pipeline / routing / binding / validation | `PARTIAL` | `PARTIAL` | `NOT_APPLICABLE` | `NOT_APPLICABLE` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M24` | `A07` | Dependency composition / configuration | `PARTIAL` | `PARTIAL` | `NOT_APPLICABLE` | `NOT_APPLICABLE` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M25` | `A07` | Background jobs / schedulers / recurring work | `MISSING` | `MISSING` | `NOT_APPLICABLE` | `NOT_APPLICABLE` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M26` | `A09` | Data-access / ORM responsibility model | `PARTIAL` | `PARTIAL` | `NOT_APPLICABLE` | `NOT_APPLICABLE` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M27` | `A13` | Testing strategy / design baseline | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M28` | `A13` | Debugging / profiling / diagnosis baseline | `PARTIAL` | `MISSING` | `PARTIAL` | `PARTIAL` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M29` | `A14` | Package / dependency / build workflow | `PARTIAL` | `MISSING` | `PARTIAL` | `PARTIAL` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |
| `M30` | `A15` | Logging / metrics / tracing / telemetry integration | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` | `MISSING` |

## Interpretation

- A generic responsibility is assessed before framework analogies.
- `NOT_APPLICABLE` means the manifestation is not meaningful at that layer, not a gap.
- Node.js and Python are currently almost entirely missing as technology manifestations; this is explicit rather than inferred from absence of folders.
- Go and Rust are now selected expansion ecosystems. The applicability pass found all 30 current manifestation responsibilities meaningful at ecosystem level, and the initial baseline is `MISSING` because no durable Go/Rust Knowledge Units exist yet.
- Important reverse gaps also appear: `.NET` is `MISSING` for coherent scope/closures, module/import semantics, process lifecycle, filesystem foundations, structured concurrency, host lifecycle, testing strategy, and observability integration despite the large .NET corpus.
