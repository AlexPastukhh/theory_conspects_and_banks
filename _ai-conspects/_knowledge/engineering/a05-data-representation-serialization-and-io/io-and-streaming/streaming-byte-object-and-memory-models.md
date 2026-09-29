# Streaming byte, object, and memory models

Knowledge ID: `dotnet.streaming-byte-object-and-memory-models`

Topic: `dotnet`

## Streaming means bounded progressive work

A `Stream` is a read/write abstraction over a sequence of bytes. It can hide file, memory, device, compression, or network details and lets code process data over time instead of first creating one complete string or byte array.

That does not make every stream non-buffered. A `MemoryStream` already holds its bytes in memory; wrapping it in `StreamContent` changes the API shape, not the source's memory model. A file/network/custom producer can supply bytes progressively.

| Contract | Unit of progress | Typical role |
|---|---|---|
| `Stream` / `ReadAsStreamAsync` | bytes | response/file/device reading |
| `IAsyncEnumerable<T>` | objects/items | deferred asynchronous production |
| `StreamContent` | request bytes | upload/request-body source |

They can be combined, but none implies the others.

## The main win is stable peak memory

Streaming has overhead: stream objects and wrappers allocate, each layer may buffer, and disposal can flush or close resources. It is valuable when bounded processing avoids large intermediate representations, LOH/Gen2 pressure, GC pauses, and concurrency-driven memory spikes.

Large payloads, high concurrency, incremental transformation, and early consumer progress are strong use cases. Small CRUD JSON or algorithms that require the full object graph often gain complexity without a meaningful memory/latency benefit.

Network packets and application reads are not semantic records. Protocol framing—length, newline, SSE blank line, JSON structure—determines when a complete value is available.

## What should be recallable

- What abstraction a `Stream` provides and what it does not guarantee.
- Why `MemoryStream` plus `StreamContent` remains memory-buffered.
- The different units represented by `Stream`, `IAsyncEnumerable<T>`, and `StreamContent`.
- Why peak live memory, not zero allocations, is the useful streaming claim.
- When streaming overhead is and is not justified.
- Why transport chunks are not application records.

## Related knowledge

- `dotnet.httpclient-response-streaming`
- `dotnet.async-enumerable-replay-and-single-use-streams`
- `javascript.incremental-streaming-and-ndjson`

## Sources

- Workspace: `_ai-conspects/streaming/`
- Authoritative processed source: `regions/R01-streaming-bytes-and-stream-concepts.md`, complete transcript; `regions/R02-reading-response-stream-and-payload-bytes.md`, stream-type and buffering distinctions; `regions/R06-streaming-benefits-memory-mental-model.md`, complete transcript
- Original SVG: `source/streaming.svg`
