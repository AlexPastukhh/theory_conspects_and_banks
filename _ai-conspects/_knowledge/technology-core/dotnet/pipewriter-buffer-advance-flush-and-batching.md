# PipeWriter buffer ownership, Advance, Flush, and batching

Knowledge ID: `dotnet.pipewriter-buffer-advance-flush-and-batching`

Topic: `dotnet`

## Get memory, initialize it, then report exactly what was written

The core contract is:

```text
GetSpan/GetMemory(sizeHint)
-> initialize a prefix
-> Advance(actualWritten)
-> FlushAsync when publication is needed
```

`sizeHint` is a minimum request; returned capacity can be larger. `Advance(count)` must equal bytes actually initialized. Advancing too far exposes stale/uninitialized bytes; advancing too little drops intended output.

The returned span/memory belongs to the pipe. Do not retain it as independent long-lived storage after advancing and continuing writer operations.

Direct encoding into pipe memory can avoid intermediate `byte[]` allocations. Exact binary framing can place a length prefix and payload into the same destination buffer.

## Flush and batching

`FlushAsync` makes written data available according to pipeline scheduling and returns `FlushResult`. `IsCanceled` and `IsCompleted` are coordination signals; a flush does not promise one socket packet, immediate remote delivery, or durable storage.

Batch several records/fragments and flush on a byte/item threshold, latency boundary, or protocol boundary. Flushing every tiny item can increase scheduling, TLS framing, syscalls, and CPU work.

`CancelPendingFlush()` coordinates a blocked flush; it does not erase written bytes.

Only the component that owns a `PipeWriter` should complete it. Framework-owned writers such as ASP.NET Core `Response.BodyWriter` are normally written/flushed but not completed by endpoint code.

## What should be recallable

- Why must `Advance` use actual written bytes rather than capacity?
- What ownership rule applies to memory returned by `GetSpan`/`GetMemory`?
- Why can direct encoding reduce allocations?
- What does `FlushResult` communicate?
- Why is frequent flushing not automatically an optimization?
- Who should call `CompleteAsync`?

## Related knowledge

- `aspnet-core.request-response-streams-and-pipelines`
- `dotnet.pipereader-consumed-examined-and-segmented-framing`
- `aspnet-core.response-body-shapes-and-streaming-output`

## Sources

- Workspace: `_ai-conspects/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer/`
- Authoritative semantic transcript: `14-full-transcript.md`
- Closure audit: `15-coverage-audit.md`
- Exact source: `source/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer.svg` (present on the checked branch)
- Source region: R10
