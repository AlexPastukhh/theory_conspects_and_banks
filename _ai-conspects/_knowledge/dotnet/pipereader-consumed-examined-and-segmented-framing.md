# PipeReader consumed/examined positions and segmented framing

Knowledge ID: `dotnet.pipereader-consumed-examined-and-segmented-framing`

Topic: `dotnet`

## Reads expose a segmented sequence, not a fresh array

`PipeReader.ReadAsync` returns a `ReadResult` whose `Buffer` is a `ReadOnlySequence<byte>`. The logical bytes can span multiple memory segments. `FirstSpan` is only the first physical segment; use it as the whole frame only when `IsSingleSegment` is true.

`IsCompleted` means the producer will send no more bytes, not that the current buffer is empty. Process remaining buffered data before exiting. `IsCanceled` represents pipe coordination cancellation.

`SequencePosition` is an opaque cursor tied to the sequence. Move and slice through sequence APIs rather than integer arithmetic.

## `consumed` and `examined` are different statements

After parsing, call `AdvanceTo(consumed, examined)`:

- bytes before `consumed` can be released permanently;
- bytes through `examined` were inspected while searching for complete input.

For `hello\nwor`, after processing `hello\n`, consume through that delimiter, retain `wor`, and normally mark the current end as examined. When more data arrives, the retained prefix and new bytes form the next logical buffer without application-side array concatenation.

Advancing consumed too far loses bytes; never moving it retains memory; wrong examined positions can cause needless wakeups or stalls.

## Parse frames before copying or decoding

Search delimiters and slice `ReadOnlySequence<byte>` directly. Avoid `ToArray()` in hot paths unless a bounded contiguous copy is genuinely needed. Alternatives include `SequenceReader<byte>`, small `stackalloc` header copies, pooled buffers, or stateful incremental decoding.

For simple fixed-size reads or pure pipe-to-stream copying, an ordinary `Stream` can be clearer. The main value of `PipeReader` is segmented parser state and leftover management.

## What should be recallable

- Why can `FirstSpan` be incomplete?
- What does `IsCompleted` mean when bytes remain?
- What do `consumed` and `examined` each report?
- What happens when either position is wrong?
- Why can a partial record remain in the pipe without concatenating arrays?
- When is a small bounded copy preferable to complicated zero-copy parsing?

## Related knowledge

- `dotnet.sequencereader-segmented-protocol-parsing`
- `dotnet.incremental-text-decoding`
- `aspnet-core.request-response-streams-and-pipelines`
- `aspnet-core.request-body-binding-raw-access-and-replay-buffering`

## Sources

- Workspace: `_ai-conspects/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer/`
- Authoritative semantic transcript: `14-full-transcript.md`
- Closure audit: `15-coverage-audit.md`
- Exact source: `source/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer.svg` (present on the checked branch)
- Source regions: R11 and R12
