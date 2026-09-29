# ASP.NET Core request and response streams with pipelines

Knowledge ID: `aspnet-core.request-response-streams-and-pipelines`

Topic: `aspnet-core`

## Request-body stream contract

`HttpRequest.Body` is a `Stream`. One successful read can return fewer bytes than the requested buffer size, so keep reading until the count is `0`:

```csharp
var buffer = new byte[8192];
int read;

while ((read = await Request.Body.ReadAsync(buffer)) != 0)
{
    Process(buffer.AsSpan(0, read));
}
```

`ReadExactly` and `ReadAtLeast` are specialized alternatives when the protocol requires a fixed length or minimum. Ordinary request-body consumption must not assume one read fills the buffer. Pass `HttpContext.RequestAborted` to asynchronous reads. Reads can fail with `IOException` or request-abort `OperationCanceledException`, so handle the exception contract around the operation that owns it.

Failure types follow the API phase: acquiring an HTTP response can raise `HttpRequestException`, consuming a stream can raise `IOException`, and a WebSocket receive can raise `WebSocketException`. Do not collapse all later streaming failures into the request-acquisition exception type.

## `PipeReader` consumption

A `PipeReader` exposes a possibly segmented `ReadOnlySequence<byte>`. After inspecting it, report both the consumed and examined positions with `AdvanceTo(consumed, examined)`. Bytes before `consumed` can be released; bytes not consumed remain available on the next read. Incorrect positions can retain memory, repeat data, or lose protocol progress.

```text
ReadAsync -> inspect sequence -> identify complete input
-> AdvanceTo(consumed, examined) -> next ReadAsync
```

`ReadResult` can signal cancellation or completion. Process any remaining buffered data before exiting; completion means no more bytes will arrive, not that the current buffer is empty. `SequenceReader<byte>` is a cursor over a potentially segmented `ReadOnlySequence<byte>` and can advance, rewind, read values, or find a delimiter without first copying the sequence into one contiguous array:

```csharp
var cursor = new SequenceReader<byte>(buffer);
if (cursor.TryReadTo(out ReadOnlySequence<byte> line, (byte)'\n'))
{
    Process(line);
}
```

## Response `BodyWriter`

`HttpResponse.BodyWriter` is a `PipeWriter` for efficient response construction:

```csharp
Span<byte> destination = Response.BodyWriter.GetSpan(requiredLength);
int written = WriteFrame(destination);
Response.BodyWriter.Advance(written);
await Response.BodyWriter.FlushAsync();
```

Advance by the exact number of bytes actually written. Obtaining a span does not commit its capacity as output. Writing directly to the supplied memory avoids unnecessary temporary arrays while keeping ownership and written-length accounting explicit.

For a producer that owns a `PipeWriter`, `FlushAsync` publishes written bytes and can report cancellation/completion/backpressure. When no more data will be produced, finish explicitly with `CompleteAsync()`; pass the failure exception to `CompleteAsync(exception)` when the writer terminates abnormally so the reader can observe the error boundary.

## What should be recallable

- Why must a stream read loop continue after a short positive read?
- When do `ReadExactly` or `ReadAtLeast` express a better contract?
- What do the `consumed` and `examined` positions tell a `PipeReader`?
- Why must `PipeWriter.Advance` use the actual written length?
- Where can request-abort cancellation and I/O failures surface?

## Sources

- Workspace: `_ai-conspects/processing data as stream in dif situations, httpclient,endpoint,browser,websockets/`
- Authoritative processed source: `regions/full-svg-reconciliation-v002.md`, R01, R02 request-side claims, and R04
- Original SVG: `source/source-complete-v002.svg`
- Workspace: `_ai-conspects/processing-data-as-stream-in-dif-situations-httpclient-endpoint-browser-websockets/`
- Authoritative processed sources: `regions/PDS01-aspnet-request-body-stream-reading.md` and `regions/PDS04-pipelines-pipereader-pipewriter-sequencereader.md`
- Source preservation: regional evidence and materialized source images recorded by the workspace coverage audit
