# .NET text encoding APIs and destination sizing

Knowledge ID: `dotnet.encoding-conversion-overloads-and-buffer-sizing`

Topic: `dotnet`

`System.Text.Encoding` converts between .NET characters and encoded bytes. Select the encoding deliberately: UTF-8 is the normal interoperable choice for modern APIs, JSON, files, HTTP, and web data, but arbitrary bytes are not automatically UTF-8. ASCII, UTF-16 little-endian (`Encoding.Unicode`), big-endian UTF-16, and UTF-32 have different repertoires or byte layouts.

## Choose an API by ownership and value completeness

For a complete independent value, the allocating APIs are simplest:

```csharp
byte[] bytes = Encoding.UTF8.GetBytes(text);
string text = Encoding.UTF8.GetString(bytes);
string part = Encoding.UTF8.GetString(bytes, index, count);
```

Array overloads write into caller-owned storage using source and destination indexes. Span overloads express the same operation without requiring an array-shaped API:

```csharp
int bytesWritten = Encoding.UTF8.GetBytes(
    text.AsSpan(), destinationBytes.AsSpan());

int charsWritten = Encoding.UTF8.GetChars(
    sourceBytes.AsSpan(), destinationChars.AsSpan());
```

A `Memory<T>` value exposes a span through `.Span`. `GetString` always constructs a string, whereas `GetChars` writes decoded characters into an existing destination.

These `Encoding` calls treat the supplied value as complete. If byte or character chunks belong to one logical value and may divide a multi-unit character, preserve state with a `Decoder` or `Encoder` instead of converting chunks independently.

## Exact counts, upper bounds, and bounded writes

Sizing APIs answer different questions:

- `GetByteCount(text)` gives the exact encoded byte count for that complete text.
- stateless `GetCharCount(bytes)` gives the exact decoded character count for the supplied complete bytes under the encoding and fallback policy.
- `GetMaxCharCount(byteCount)` gives a safe upper bound and can over-allocate.
- a stateful `Decoder.GetCharCount` also accounts for partial input retained from prior calls.

An exact count can justify a preliminary pass when the downstream writer requires enough contiguous capacity:

```csharp
int byteCount = Encoding.UTF8.GetByteCount(text);
Span<byte> destination = writer.GetSpan(byteCount);
int written = Encoding.UTF8.GetBytes(text.AsSpan(), destination);
writer.Advance(written);
```

When the caller already has a bounded destination, `TryGetBytes` makes the fit decision explicit:

```csharp
if (Encoding.UTF8.TryGetBytes(text.AsSpan(), destination, out int written))
{
    writer.Advance(written);
}
else
{
    // Request more capacity or calculate the exact count.
}
```

Use an exact count when avoiding slack matters, a maximum for a reusable one-pass buffer when modest over-allocation is acceptable, and `TryGetBytes` when failure-to-fit is an ordinary control-flow outcome.

## What should be recallable

- Which complete-value methods allocate and which write into caller-owned arrays or spans.
- Why `GetString` and `GetChars` have different destination ownership.
- The difference between exact counts, safe maximums, and a bounded `TryGetBytes` write.
- Why complete-value `Encoding` APIs and stateful chunk conversion are separate models.

## Sources

- Workspace: `_ai-conspects/encoding, utf8, chunk processing/`
- Authoritative processed source: `regions/full-semantic-transcript-v001.md`, sections 1-3 and 12
- Original SVG: source artifact verified by `CURRENT_SOURCE_OF_TRUTH.md` as Git blob `5763263be84e2e28658314edf49351c6b07ec35e`
