# Response body shapes and streaming output choices

Knowledge ID: `aspnet-core.response-body-shapes-and-streaming-output`

Topic: `aspnet-core`

## Match the output API to the response shape

For ordinary DTO JSON, use framework results or `WriteAsJsonAsync`. They already serialize UTF-8 into the response pipeline and apply configured JSON behavior; a custom `BodyWriter` loop is not automatically better.

For raw bytes or a file, copy from the source stream to `Response.Body`. This keeps a bounded copy buffer rather than materializing the entire file.

For one text value, `Response.WriteAsync` is simpler than introducing `StreamWriter`. For many text fragments, `StreamWriter` can batch encoding and writes; use `leaveOpen: true` because ASP.NET Core owns the response body.

## Streaming protocols need explicit framing and flush policy

NDJSON sends independently serialized JSON values separated by newline. SSE uses `text/event-stream`, event field syntax, and a blank line between events. Both can flush at latency boundaries, but flushing every tiny fragment trades throughput for immediacy.

`IAsyncEnumerable<T>` can avoid first building a giant `List<T>` and can improve time to first item, but total bandwidth and client-side incremental behavior still depend on serializer/proxy/client contracts.

Normal JSON array streaming remains one JSON document: an interruption before the closing bracket can leave invalid JSON. NDJSON makes every newline-delimited item independently parseable, so a client may retain complete earlier items after truncation. A resumable `afterId` or page-token contract limits duplication after reconnect.

For manual NDJSON, serialize one object, write a newline, and flush at the chosen latency boundary. Once the response is started/flushed, status, content type, and headers are effectively committed; a later error cannot be replaced by a clean ordinary JSON envelope. `FlushAsync` pushes application buffers toward the network but cannot force proxies and clients not to buffer.

## Low-level output is for low-level framing

`HttpResponse.BodyWriter` is appropriate for exact binary framing, direct encoding into pipeline memory, length prefixes, or delimiters. `Utf8JsonWriter` is useful when explicit JSON-token control is the requirement. Neither should replace standard DTO serialization without a concrete need.

Framework-owned response pipes should normally be written/flushed, not completed by endpoint code.

## Octet-stream file response example

### S-005 — Download/stream response with octet-stream.

```text
Download/stream response with octet-stream.

Visible code:
- Controller action returns a file/stream.
- `File(stream, "application/octet-stream", fileDownloadName: filename)` pattern.

Meaning:
For returning raw bytes/file content from ASP.NET, application/octet-stream is a common response Content-Type when the exact file type is not otherwise specified.
```

## What should be recallable

- Why is standard JSON serialization already a streaming-capable server path?
- When is `CopyToAsync` the correct response abstraction?
- When does `StreamWriter` improve a response writer?
- What is the latency/throughput tradeoff of frequent flushes?
- What distinguishes NDJSON from SSE framing?
- When is `BodyWriter` justified?

## Related knowledge

- `aspnet-core.request-response-streams-and-pipelines`
- `dotnet.streamwriter-encoding-buffering-and-flush-contracts`
- `dotnet.pipewriter-buffer-advance-flush-and-batching`
- `http.sse-event-stream-reconnection`

## Sources

- Workspace: `_ai-conspects/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer/`
- Authoritative semantic transcript: `14-full-transcript.md`
- Closure audit: `15-coverage-audit.md`
- Exact source: `source/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer.svg` (present on the checked branch)
- Source region: R06
- Workspace: `_ai-conspects/streaming/`
- Authoritative processed source: `regions/R04-iasyncenumerable-ndjson-flushasync.md`, complete transcript
- Original SVG: `source/streaming.svg`
- Workspace: `_ai-conspects/MEDIA TYPES OF REQUESTS/`
- Authoritative processed source: `regions/MEDIA-R01-content-type-accept-media-type-basics.md`, S-005
- Original source identity: `MEDIA TYPES OF REQUESTS.svg` (named by `01-stage0-boundary-review.md`; not physically resolvable in the current workspace/branch).
