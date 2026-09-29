# A05 — Data Representation, Serialization & I/O

This index is a physical/navigation projection. Finer semantic placement remains in the semantic hierarchy.

## Data Representation

### Area-owned Units

- [`dotnet.format-strings-culture-and-round-trip` — .NET format strings, culture, and round-trip output](data-representation/format-strings-culture-and-round-trip.md)
- [`dotnet.encoding-conversion-overloads-and-buffer-sizing` — .NET text encoding APIs and destination sizing](data-representation/encoding-conversion-overloads-and-buffer-sizing.md)
- [`dotnet.ascii-and-utf8-compatibility` — ASCII codes and UTF-8 compatibility](data-representation/ascii-and-utf8-compatibility.md)
- [`dotnet.binary-to-text-encodings` — Binary-to-text encodings for storage and transport](data-representation/binary-to-text-encodings.md)
- [`dotnet.binary-primitives-endianness` — BinaryPrimitives and explicit endianness](data-representation/binary-primitives-endianness.md)
- [`dotnet.utf8-decoding-prefixes` — UTF-8 decoding prefixes and byte boundaries](data-representation/utf8-decoding-prefixes.md)

### Technology Core links

- [`dotnet.hexadecimal-byte-representation` — Hexadecimal and byte representation](../../technology-core/dotnet/hexadecimal-byte-representation.md)
- [`dotnet.incremental-text-decoding` — Incremental text decoding across arbitrary byte chunks](../../technology-core/dotnet/incremental-text-decoding.md)
- [`javascript.binary-storage-arraybuffer-typedarrays-and-blob` — Binary storage with ArrayBuffer, typed arrays, and Blob](../../technology-core/javascript/binary-storage-arraybuffer-typedarrays-and-blob.md)
- [`javascript.byte-values-and-endianness` — Byte values and endianness](../../technology-core/javascript/byte-values-and-endianness.md)
- [`javascript.collation-sort-vs-search` — Collation for sorting versus search matching](../../technology-core/javascript/collation-sort-vs-search.md)
- [`javascript.dataview-offsets-and-binary-layouts` — DataView offsets and mixed binary layouts](../../technology-core/javascript/dataview-offsets-and-binary-layouts.md)
- [`javascript.intl-collator` — Locale-aware comparison with Intl.Collator](../../technology-core/javascript/intl-collator.md)

## I/O & Streaming

### Area-owned Units

- [`dotnet.httpcontent-read-stream-buffering` — HttpContent ReadAsStream buffering and direct stream creation](io-and-streaming/httpcontent-read-stream-buffering.md)
- [`dotnet.sequencereader-segmented-protocol-parsing` — SequenceReader segmented protocol parsing](io-and-streaming/sequencereader-segmented-protocol-parsing.md)
- [`dotnet.stream-partial-reads-and-bounded-loops` — Stream partial reads and bounded read loops](io-and-streaming/stream-partial-reads-and-bounded-loops.md)
- [`dotnet.stream-readexactly-readatleast-fixed-count-reads` — Stream ReadExactly, ReadAtLeast, and fixed-count reads](io-and-streaming/stream-readexactly-readatleast-fixed-count-reads.md)
- [`dotnet.stream-whole-content-buffering-and-byte-arrays` — Stream whole-content buffering and byte arrays](io-and-streaming/stream-whole-content-buffering-and-byte-arrays.md)
- [`dotnet.streaming-byte-object-and-memory-models` — Streaming byte, object, and memory models](io-and-streaming/streaming-byte-object-and-memory-models.md)
- [`dotnet.streamreader-decoding-buffering-and-read-contracts` — StreamReader decoding, buffering, and read contracts](io-and-streaming/streamreader-decoding-buffering-and-read-contracts.md)
- [`dotnet.streamwriter-encoding-buffering-and-flush-contracts` — StreamWriter encoding, buffering, and flush contracts](io-and-streaming/streamwriter-encoding-buffering-and-flush-contracts.md)
- [`dotnet.stringreader-line-processing-and-memory` — StringReader line processing and memory](io-and-streaming/stringreader-line-processing-and-memory.md)
- [`javascript.text-encoding-and-stream-framing` — Text encoding and stream framing](io-and-streaming/text-encoding-and-stream-framing.md)
- [`javascript.transformstream-pipelines-and-flush` — TransformStream pipelines, buffering, and flush](io-and-streaming/transformstream-pipelines-and-flush.md)

### Technology Core links

- [`dotnet.pipereader-consumed-examined-and-segmented-framing` — PipeReader consumed/examined positions and segmented framing](../../technology-core/dotnet/pipereader-consumed-examined-and-segmented-framing.md)
- [`dotnet.pipewriter-buffer-advance-flush-and-batching` — PipeWriter buffer ownership, Advance, Flush, and batching](../../technology-core/dotnet/pipewriter-buffer-advance-flush-and-batching.md)
- [`javascript.readable-stream-consumption-and-tee` — ReadableStream consumption, locking, and tee branching](../../technology-core/javascript/readable-stream-consumption-and-tee.md)
- [`javascript.readable-stream-producers-backpressure-and-cancellation` — ReadableStream producers, backpressure, and cancellation](../../technology-core/javascript/readable-stream-producers-backpressure-and-cancellation.md)
- [`javascript.writablestream-pipeto-and-sink-lifecycle` — WritableStream, pipeTo, and sink lifecycle](../../technology-core/javascript/writablestream-pipeto-and-sink-lifecycle.md)

## Parsing, Validation & Serialization

### Area-owned Units

- [`dotnet.regex-balancing-groups` — .NET Regex balancing groups](parsing-validation-and-serialization/regex-balancing-groups.md)
- [`dotnet.regex-inline-option-scopes` — .NET Regex inline option scopes](parsing-validation-and-serialization/regex-inline-option-scopes.md)
- [`dotnet.regex-operations-and-safety` — .NET Regex operations and safety](parsing-validation-and-serialization/regex-operations-and-safety.md)
- [`dotnet.datetime-parsing-exactness-and-standard-formats` — Date/time parsing exactness and standard formats](parsing-validation-and-serialization/datetime-parsing-exactness-and-standard-formats.md)
- [`javascript.incremental-streaming-and-ndjson` — Incremental streaming, peak memory, and NDJSON](parsing-validation-and-serialization/incremental-streaming-and-ndjson.md)
- [`dotnet.numeric-string-parsing` — Parsing numeric strings in .NET](parsing-validation-and-serialization/numeric-string-parsing.md)
- [`dotnet.regex-replacement-options-and-state` — Regex replacement options and per-call state](parsing-validation-and-serialization/regex-replacement-options-and-state.md)
- [`dotnet.regex-reuse-compilation-and-timeouts` — Regex reuse, compilation, and timeouts](parsing-validation-and-serialization/regex-reuse-compilation-and-timeouts.md)
- [`dotnet.system-text-json-optional-converter-factory` — System.Text.Json Optional<T> converter factory](parsing-validation-and-serialization/system-text-json-optional-converter-factory.md)
- [`dotnet.utf8jsonwriter-streaming-and-token-control` — Utf8JsonWriter streaming and token control](parsing-validation-and-serialization/utf8jsonwriter-streaming-and-token-control.md)

### Technology Core links

- [`dotnet.jsondocument-jsonelement-readonly-dom` — JsonDocument and JsonElement read-only DOM](../../technology-core/dotnet/jsondocument-jsonelement-readonly-dom.md)
- [`dotnet.jsonnode-mutable-dom` — JsonNode mutable DOM](../../technology-core/dotnet/jsonnode-mutable-dom.md)
- [`javascript.regex-operations-and-state` — JavaScript regex operations and state](../../technology-core/javascript/regex-operations-and-state.md)
- [`typescript.zod-discriminated-union-validation` — Zod discriminated-union validation](../../technology-core/typescript/zod-discriminated-union-validation.md)
- [`typescript.zod-form-input-coercion-and-transforms` — Zod form-input coercion, preprocessing, and transforms](../../technology-core/typescript/zod-form-input-coercion-and-transforms.md)
- [`typescript.zod-refinements-and-cross-field-errors` — Zod refinements and cross-field errors](../../technology-core/typescript/zod-refinements-and-cross-field-errors.md)
- [`typescript.zod-schema-validation-and-inference` — Zod schema validation, composition, and type inference](../../technology-core/typescript/zod-schema-validation-and-inference.md)
