# SequenceReader segmented protocol parsing

Knowledge ID: `dotnet.sequencereader-segmented-protocol-parsing`

Topic: `dotnet`

## `SequenceReader<T>` is a synchronous cursor over a segmented sequence

`SequenceReader<T>` is a mutable `ref struct` over `ReadOnlySequence<T>`. It is stack-only and cannot survive across `await`. The usual split is:

```text
PipeReader -> await more bytes
SequenceReader<byte> -> synchronously parse current sequence
```

Important cursor state includes `Remaining`, `Consumed`, `Position`, `CurrentSpan`, and `UnreadSpan`. `UnreadSpan` is only the remainder of the current physical segment, not the entire logical suffix.

`TryRead` advances only on success; `TryPeek` does not advance. `TryCopyTo` can inspect a fixed-size header across segments without consuming it. Integer helpers can parse protocol-defined endianness across segment boundaries.

## Delimiters and frames can cross segments

`TryReadTo` can extract data up to a delimiter without first flattening the sequence. Sequence-aware patterns also handle multi-byte delimiters and escaped delimiters. Manual delimiter search in only `FirstSpan` is incorrect when the boundary straddles segments.

For length-prefixed frames, snapshot the reader before consuming the header. If the full payload is not yet available, restore the snapshot so a partial frame is not committed. Validate lengths before allocation/advance to prevent malformed input from driving excessive memory use.

First frame bytes, then decode text. UTF-8 code points can cross physical segments, so independently decoding each segment is unsafe unless decoder state is preserved.

## Feed parser progress back to the pipe

After parsing complete frames, use the cursor's `Position` as the consumed boundary and the pipe buffer end as the examined boundary when all available bytes were inspected. Store durable protocol state separately; do not retain the `SequenceReader` itself across the next asynchronous read.

## What should be recallable

- Why can a `SequenceReader` not cross `await`?
- How do `TryRead`, `TryPeek`, and `TryCopyTo` differ?
- Why are sequence-aware delimiter APIs important?
- Why snapshot/restore a reader around an incomplete length-prefixed frame?
- Why should framing happen before text decoding?
- How does cursor position become the next `PipeReader.AdvanceTo` consumed boundary?

## Related knowledge

- `dotnet.pipereader-consumed-examined-and-segmented-framing`
- `dotnet.binary-primitives-endianness`
- `dotnet.incremental-text-decoding`

## Sources

- Workspace: `_ai-conspects/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer/`
- Authoritative semantic transcript: `14-full-transcript.md`
- Closure audit: `15-coverage-audit.md`
- Exact source: `source/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer.svg` (present on the checked branch)
- Source region: R13
