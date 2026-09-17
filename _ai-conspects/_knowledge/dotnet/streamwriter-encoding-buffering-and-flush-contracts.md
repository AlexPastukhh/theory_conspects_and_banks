# StreamWriter encoding, buffering, and flush contracts

Knowledge ID: `dotnet.streamwriter-encoding-buffering-and-flush-contracts`

Topic: `dotnet`

## `StreamWriter` batches character-to-byte encoding

The layer is:

```text
chars/strings -> char buffer -> Encoding encoder -> byte Stream
```

It is useful when application code emits many text fragments or lines. Internal buffering can reduce small underlying writes, but a larger buffer is not automatically faster and does not inherently reduce total allocation.

`Write` and `WriteLine` compose text; async forms are appropriate when the underlying destination is asynchronous. `leaveOpen` controls whether disposing the writer also closes the underlying stream.

## Flush is a visibility boundary, not a packet guarantee

`FlushAsync` pushes buffered characters through the encoder into the underlying stream. Lower layers may still buffer. Flush when protocol or latency semantics require current data to become observable, not after every tiny fragment by habit.

`AutoFlush` trades batching for immediacy. It can fit interactive protocols but is often poor for throughput.

Disposal flushes final encoder state. `DisposeAsync` is appropriate when final output can require asynchronous I/O.

Mixing direct `BaseStream` byte writes with a buffered `StreamWriter` is unsafe unless the writer is flushed and encoding/framing boundaries are intentionally controlled.

## Choosing a server output abstraction

One text string normally needs only the destination stream/response text API. Many fragments may justify `StreamWriter`. Exact binary frames require byte APIs or `PipeWriter`; text encoding cannot preserve arbitrary binary layout.

## What should be recallable

- What does `StreamWriter` buffer?
- Why can many small writes benefit from it?
- What does `FlushAsync` guarantee and not guarantee?
- Why can `AutoFlush` hurt throughput?
- What does `leaveOpen` control?
- Why is mixing writer output and direct base-stream bytes risky?

## Related knowledge

- `dotnet.streamreader-decoding-buffering-and-read-contracts`
- `dotnet.pipewriter-buffer-advance-flush-and-batching`
- `aspnet-core.response-body-shapes-and-streaming-output`

## Sources

- Workspace: `_ai-conspects/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer/`
- Authoritative semantic transcript: `14-full-transcript.md`
- Closure audit: `15-coverage-audit.md`
- Exact source: `source/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer.svg` (present on the checked branch)
- Source region: R09
