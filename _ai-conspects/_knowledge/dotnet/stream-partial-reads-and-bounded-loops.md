# Stream partial reads and bounded read loops

Knowledge ID: `dotnet.stream-partial-reads-and-bounded-loops`

Topic: `dotnet`

## A successful stream read can be shorter than the requested buffer

`Stream.Read` / `ReadAsync` can return fewer bytes than requested. A short read is normal: it can mean that only part of the requested data is currently available.

```text
requested N bytes
  -> read returns 0       => end of stream
  -> read returns 1..N-1  => valid partial read
  -> read returns N       => buffer request happened to be filled
```

Do not treat every short read as EOF and do not assume one `ReadAsync(buffer)` fills the buffer.

## Read-until-EOF processes what was actually returned

For an unknown-length stream, the basic progressive pattern is:

```text
repeat:
  read into a bounded buffer
  if count == 0: stop
  process/write only buffer[0..count]
```

This naturally handles partial reads. It is the right shape when the application can process bytes incrementally—for example forwarding a stream, saving a response to a file, computing a hash while data moves, or parsing a custom stream progressively.

When only transport from stream A to stream B is needed, `CopyTo` / `CopyToAsync` is the higher-level version of the same streaming decision.

## Filling a known destination requires repeated reads

If the caller needs a target segment filled, one ordinary `ReadAsync` call is not a guarantee. A manual loop keeps track of how many bytes have already arrived and reads only into the remaining slice.

Conceptually:

```text
filled = 0

while filled < required:
  read into destination[filled..required]
  handle EOF/failure
  filled += actualRead
```

Using a slice/span for the remaining segment prevents overwriting bytes outside the intended range and keeps count arithmetic attached to the actual remaining capacity.

`ReadExactly` and `ReadAtLeast` package common versions of this repeated-read logic; their separate count/EOF contracts are covered by `dotnet.stream-readexactly-readatleast-fixed-count-reads`.

## Bounded read-all helpers need an upper limit

A convenience method that reads an unknown stream into memory should accept or enforce a maximum size. Without a limit, “read all” can allocate according to untrusted or unexpectedly large input.

The destination does not have to be `MemoryStream`. Depending on the goal and payload size, bytes can be:

- accumulated in memory;
- streamed to a file or temporary storage;
- passed through a pipe/pipeline;
- processed incrementally without retaining the complete payload.

Using `MemoryStream` inside a read loop still means whole-content buffering if every chunk is kept until the end.

## Buffering belongs to a pipeline layer

Before adding another buffer, identify which layer is being read: request body, response body, middleware stream, or a higher-level HTTP helper. Some APIs already materialize content; others expose a stream for progressive consumption.

This distinction matters because replacing one helper with a manual loop does not automatically remove buffering that already happened earlier in the pipeline.

## What should be recallable

- Why can `ReadAsync` return fewer bytes than requested without reaching EOF?
- What does a return count of `0` mean in a read-until-EOF loop?
- Why must processing use only the bytes actually returned?
- How does a loop fill the remaining slice of a fixed destination safely?
- Why should a read-all helper enforce an explicit maximum size?
- Why does writing every chunk into a `MemoryStream` still count as whole-content buffering?
- Why must buffering be reasoned about at the correct pipeline layer?

## Related knowledge

- `dotnet.stream-whole-content-buffering-and-byte-arrays`
- `dotnet.stream-readexactly-readatleast-fixed-count-reads`
- `dotnet.httpclient-response-streaming`
- `dotnet.pipereader-consumed-examined-and-segmented-framing`

## Sources

- Workspace: `_ai-conspects/working with bytes, streams to bytes, to array readexactly,readatleast/`
- Authoritative processed source: `regions/BYTES-R01-stream-to-byte-array-toarray-readasbytearray.md`, S-002, S-004–S-005, S-009, S-013
- Authoritative processed source: `regions/BYTES-R02-readasync-partial-reads-compact-helpers.md`, S-014, S-018–S-024
- Authoritative processed source: `regions/BYTES-R03-readatleast-readexactly-fixed-size-reads.md`, S-026, S-034, S-037–S-038
- Closure audit: `04-closure-audit.md`
- Original SVG identity from Stage0: `working with bytes, streams to bytes, to array readexactly,readatleast.svg` (exact repository path is not established by the checked owner files)
