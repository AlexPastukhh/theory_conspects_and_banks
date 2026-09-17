# Stream ReadExactly, ReadAtLeast, and fixed-count reads

Knowledge ID: `dotnet.stream-readexactly-readatleast-fixed-count-reads`

Topic: `dotnet`

## Fixed-count helpers exist because ordinary reads are partial

A plain `Stream.Read` / `ReadAsync` call can return fewer bytes than requested. When a protocol or file format says that a specific number of bytes is required, the caller therefore needs repeated reads plus explicit EOF handling.

`ReadExactly` and `ReadAtLeast` are convenience helpers around that repeated-read problem. They do not change transport behavior or make an unknown-length stream suddenly have a known size.

## `ReadExactly`: fill the required destination or fail

Use `ReadExactly` when the input contract requires the complete fixed-size segment.

```text
required destination size = N
  -> keep reading until N bytes are present
  -> if the stream ends before N, treat it as failure
```

Typical source-backed use cases are:

- a fixed binary header;
- a message/frame prefix;
- a known-size protocol field;
- a fixed file-format structure;
- handshake data.

The useful semantic is not “read as much as possible”; it is “this many bytes must exist.” Missing bytes mean the input is truncated or invalid.

Async forms have the same count-guarantee purpose: the helper packages the repeated asynchronous reads instead of requiring the caller to write the loop manually.

## `ReadAtLeast`: require a minimum, possibly receive more

`ReadAtLeast` is appropriate when a parser can proceed once a minimum byte count is available.

```text
destination capacity = C
minimum required = N, where N <= C

ReadAtLeast
  -> reads until at least N bytes are available
  -> may return more than N, up to destination capacity
  -> returns the actual count read
```

The source distinguishes this from `ReadExactly`: exact reads require the destination/fixed count to be satisfied, while minimum reads allow extra bytes when the parser can use them.

### Early EOF

`ReadAtLeast` has behavior controlled by `throwOnEndOfStream`:

- when enabled, EOF before the minimum count is an error;
- when disabled, an early EOF can return fewer than the requested minimum and the caller must inspect the returned count.

This is different from an ordinary partial read while the stream is still continuing. The important question is whether the stream ended before the parser's required minimum was satisfied.

## Count and slice math must describe the intended segment

A count is a number of bytes, not an end index. When using array offsets or buffer slices, keep the segment math explicit:

```text
start + count
```

Passing a destination slice sized to the exact protocol field is useful because the slice itself expresses the allowed write range and prevents accidental writes outside that field.

## Protocol parser pattern

A representative source pattern is:

```text
1. ReadExactly the fixed header.
2. Decode length/type from that header.
3. Validate the decoded length against an allowed maximum.
4. ReadExactly the payload only when that exact size is appropriate,
   or stream/process the payload when it should not be fully materialized.
```

The length validation is part of the safety boundary: a length from input must not be allowed to drive an unbounded allocation or fixed-count read without a limit.

## Choose the weakest count guarantee that matches the format

```text
unknown stream, process until EOF
  -> ordinary bounded read loop;

exact protocol field
  -> ReadExactly;

parser can proceed after a minimum
  -> ReadAtLeast.
```

Do not use `ReadExactly` as a generic “read the entire stream” operation when the total length is unknown. Do not use `ReadAtLeast` merely to hide a read loop when there is no real minimum-count contract.

## What should be recallable

- Why is one `ReadAsync` call insufficient for an exact protocol field?
- What guarantee does `ReadExactly` provide, and what does early EOF mean?
- How does `ReadAtLeast` differ from `ReadExactly`?
- What does `throwOnEndOfStream` change for `ReadAtLeast`?
- Why can `ReadAtLeast` return more than its minimum count?
- Why is `count` not an end index?
- How do slices help express a fixed-size read boundary?
- What is the header → length validation → payload pattern?
- Why are exact/minimum helpers wrong for an unknown unbounded read-all operation?

## Related knowledge

- `dotnet.stream-partial-reads-and-bounded-loops`
- `dotnet.stream-whole-content-buffering-and-byte-arrays`
- `dotnet.binary-primitives-endianness`
- `dotnet.pipereader-consumed-examined-and-segmented-framing`

## Sources

- Workspace: `_ai-conspects/working with bytes, streams to bytes, to array readexactly,readatleast/`
- Authoritative processed source: `regions/BYTES-R01-stream-to-byte-array-toarray-readasbytearray.md`, S-001–S-002, S-005, S-010, S-012–S-013
- Authoritative processed source: `regions/BYTES-R02-readasync-partial-reads-compact-helpers.md`, S-015–S-018, S-020, S-023–S-024
- Authoritative processed source: `regions/BYTES-R03-readatleast-readexactly-fixed-size-reads.md`, S-025–S-038
- Closure audit: `04-closure-audit.md`
- Original SVG identity from Stage0: `working with bytes, streams to bytes, to array readexactly,readatleast.svg` (exact repository path is not established by the checked owner files)
