# StreamReader decoding, buffering, and read contracts

Knowledge ID: `dotnet.streamreader-decoding-buffering-and-read-contracts`

Topic: `dotnet`

## `StreamReader` converts bytes into characters

The layer is:

```text
byte Stream -> byte buffer -> Encoding decoder -> char buffer -> text APIs
```

Use it for fundamentally textual data. Do not move binary framing into characters before the byte-level boundaries are known.

Constructor choices matter: `Encoding` defines decoding, BOM detection can select a detected encoding, `bufferSize` tunes internal buffering rather than promising an exact OS read size, and `leaveOpen` controls ownership of the underlying stream.

## Read contracts differ

`Read` consumes one character; `Peek` observes without consuming. `ReadAsync(Memory<char>)` can return fewer characters than requested. `ReadBlockAsync` keeps reading until the requested character block is filled or no more data is available.

`ReadLineAsync` returns one line without the terminator and allocates a string for that line. `ReadToEndAsync` intentionally materializes all remaining text in one string; it is not progressive merely because the source is a stream.

`BaseStream` exposes the underlying bytes, but mixing direct stream seeks/reads with a buffered reader can desynchronize decoder and character-buffer state. After an intentional reposition of a seekable base stream, `DiscardBufferedData()` is required to realign the reader; frequent use usually indicates a better design is available.

## Text versus segmented byte parsing

`StreamReader` is a good default for ordinary newline-oriented text. `PipeReader` becomes useful when frames can be very large, delimiters cross segments, mixed binary/text framing exists, only selected slices should be decoded, or explicit consumed/examined control matters.

## What should be recallable

- What buffers and decoder sit between a stream and returned characters?
- How do `ReadAsync` and `ReadBlockAsync` differ?
- Why does `ReadToEndAsync` still materialize the full text?
- What does `leaveOpen` control?
- Why is direct `BaseStream` access dangerous while the reader has buffered data?
- When should parsing stay byte-oriented instead?

## Related knowledge

- `dotnet.incremental-text-decoding`
- `dotnet.pipereader-consumed-examined-and-segmented-framing`
- `dotnet.streamwriter-encoding-buffering-and-flush-contracts`

## Sources

- Workspace: `_ai-conspects/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer/`
- Authoritative semantic transcript: `14-full-transcript.md`
- Closure audit: `15-coverage-audit.md`
- Exact source: `source/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer.svg` (present on the checked branch)
- Source region: R08
