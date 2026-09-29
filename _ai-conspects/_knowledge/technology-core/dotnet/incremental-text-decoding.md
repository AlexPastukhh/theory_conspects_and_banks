# Incremental text decoding across arbitrary byte chunks

Knowledge ID: `dotnet.incremental-text-decoding`

Topic: `dotnet`

Byte-stream chunk boundaries are not character boundaries. A multi-byte UTF-8 character can start in one read and finish in the next, so calling `Encoding.UTF8.GetString` independently for every chunk can replace, reject, or detach the incomplete prefix from its continuation.

Create one stateful `Decoder` for one logical byte stream or message and reuse it across reads. Do not recreate or reset it between fragments: `Reset` discards the partial-sequence and fallback state that makes incremental decoding safe. Reset or replace it only when abandoning that logical input or starting an independent one.

## `GetChars` and `Convert`

Both methods preserve decoder state. `Decoder.GetChars` is convenient when the destination is known to fit; a destination that is too small can produce `ArgumentException`. `Decoder.Convert` is the bounded-buffer primitive because it reports progress on both sides:

```csharp
decoder.Convert(
    byteBuffer,
    byteIndex,
    bytesRead - byteIndex,
    charBuffer,
    0,
    charBuffer.Length,
    flush: false,
    out int bytesUsed,
    out int charsUsed,
    out bool completed);

Process(charBuffer.AsSpan(0, charsUsed));
byteIndex += bytesUsed;
```

- `bytesUsed` is the input consumed by this call. Advance by it; assuming the whole slice was consumed can skip input or prevent progress when the output fills.
- `charsUsed` is the initialized output range.
- `completed` says whether the supplied input slice was fully processed. It does not say that the stream or message has ended.

`Decoder.GetCharCount` answers how many characters exact input would produce while accounting for state retained from earlier calls. That is a different question from a stateless maximum buffer bound.

## Finalization and fallback

`flush: false` means more bytes may arrive, so an incomplete sequence remains buffered. Use `flush: true` only at the real end of the logical input. For a stream, positive reads normally use `false`, followed at EOF by a final conversion—possibly with empty input—using `true`. For fragmented WebSocket text, use `EndOfMessage` as the flush boundary.

Discarding a decoder that still holds an incomplete sequence does not hang; it silently abandons those bytes. A final flush makes truncated input observable according to the configured fallback:

- replacement fallback emits replacement text, commonly `U+FFFD`;
- exception fallback rejects invalid or incomplete input with `DecoderFallbackException`.

Strict UTF-8 is useful when damaged text must not be repaired silently:

```csharp
var strictUtf8 = new UTF8Encoding(
    encoderShouldEmitUTF8Identifier: false,
    throwOnInvalidBytes: true);

Decoder decoder = strictUtf8.GetDecoder();
```

Fallback is an application data-integrity policy. Replacement preserves processing with visible damage; exception fallback makes the boundary fail. Custom `EncoderFallback` and `DecoderFallback` policies can be selected on an encoding, including through `Encoding.GetEncoding`, before creating its stateful converter.

## Stream and WebSocket loop invariants

A robust loop reuses its byte buffer, character buffer, and decoder; processes only the bytes actually read; loops until each supplied range is consumed; publishes only `charsUsed`; and explicitly finalizes the logical input. A WebSocket decoder similarly processes exactly `result.Count` bytes, uses one decoder across the fragments of one text message, flushes on `result.EndOfMessage`, dispatches only the complete message, stops on close, and propagates cancellation through the receive loop.

## The encoder-side symmetry

Complete independent strings can use `Encoding.UTF8.GetBytes`. When character chunks form one logical input, a UTF-16 surrogate pair can be divided between chunks. A persistent `Encoding.UTF8.GetEncoder()` preserves that state just as a decoder preserves a partial UTF-8 byte sequence. Finalize it only at the real end, under the selected `EncoderFallback` policy.

## What should be recallable

- Why independent per-chunk `GetString` calls can break UTF-8.
- When decoder state may be reset and what a premature reset loses.
- The contract difference between `GetChars` and `Convert`.
- What `bytesUsed`, `charsUsed`, and `completed` mean.
- Why `flush: true` belongs to a logical-input boundary and exposes truncated final input.
- How replacement and exception fallback change data-integrity behavior.
- Why a stateful `Encoder` is needed when character chunks can split a surrogate pair.

## Sources

- Workspace: `_ai-conspects/processing-data-as-stream-in-dif-situations-httpclient-endpoint-browser-websockets/`
- Authoritative processed source: `regions/PDS02-browser-fetch-websocket-utf8-decoding.md`, PDS02D
- Source preservation: regional evidence and materialized source images recorded by the workspace coverage audit
- Workspace: `_ai-conspects/encoding, utf8, chunk processing/`
- Authoritative processed source: `regions/full-semantic-transcript-v001.md`, sections 4-12
- Original SVG: source artifact verified by `CURRENT_SOURCE_OF_TRUTH.md` as Git blob `5763263be84e2e28658314edf49351c6b07ec35e`
