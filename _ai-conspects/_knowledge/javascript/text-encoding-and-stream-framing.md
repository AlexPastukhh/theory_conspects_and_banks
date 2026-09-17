# Text encoding and stream framing

Knowledge ID: `javascript.text-encoding-and-stream-framing`

Topic: `javascript`

`TextEncoder` converts a JavaScript string to UTF-8 `Uint8Array`; `TextDecoder` converts compatible byte buffers/views back to text. `ArrayBuffer` is raw storage, while a typed-array view identifies the meaningful offset and length. UTF-8 byte order is defined; endianness matters for multi-byte numeric fields read with `DataView`, not ordinary UTF-8 text.

Stream chunks are arbitrary transport chunks, not characters, lines, JSON values, or application frames. A multibyte UTF-8 character may cross chunks, so preserve decoder state and flush it:

```ts
const decoder = new TextDecoder();
let text = "";
text += decoder.decode(chunk1, { stream: true });
text += decoder.decode(chunk2, { stream: true });
text += decoder.decode();
```

Character decoding does not solve message framing. A line parser retains the incomplete tail; a length-prefixed parser accumulates bytes, reads a complete numeric header with explicit endianness, waits for the declared body, consumes exactly it, and retains the remainder.

`TextDecoderStream` performs incremental byte-to-text decoding, but its output chunks remain arbitrary. It can be placed directly after a Fetch body:

```js
const textStream = response.body.pipeThrough(
  new TextDecoderStream()
);
```

Compose responsibilities:

```text
byte stream → TextDecoderStream → text chunks
→ line-splitting TransformStream → complete lines
→ JSON parser TransformStream → objects
```

A line splitter stores pending text in `transform` and emits its final tail in `flush` when the framing protocol permits an unterminated final line. If the protocol requires a complete delimiter-terminated frame, closing with a partial tail should instead be treated as incomplete input. `TextEncoderStream` provides the reverse streaming direction. With `{ fatal: true }`, malformed input throws; otherwise replacement characters may be produced.

## Browser Fetch integration

`fetch` exposes `response.body` as a `ReadableStream`. A reader loop receives `Uint8Array` chunks until `done`; those chunks remain arbitrary byte boundaries. Preserve `TextDecoder` state so a multibyte UTF-8 character divided across two reads is decoded once and correctly:

```js
const reader = response.body.getReader();
const decoder = new TextDecoder();

for (;;) {
  const { value, done } = await reader.read();
  if (done) break;
  consumeText(decoder.decode(value, { stream: true }));
}
consumeText(decoder.decode());
```

Binary protocols can process each `Uint8Array` as bytes, but must still apply their own framing rather than treating a reader chunk as a message.

## Sources
- Workspace: `_ai-conspects/textdecoder, encoder, streaming and processing chunks, textdecoderstream of transformstream/`
- Processed source: `01-final-transcript.md`, complete transcript
- Workspace: `_ai-conspects/processing data as stream in dif situations, httpclient,endpoint,browser,websockets/`
- Authoritative processed source: `regions/full-svg-reconciliation-v002.md`, R05
- Original SVG: `source/source-complete-v002.svg`
- Workspace: `_ai-conspects/processing-data-as-stream-in-dif-situations-httpclient-endpoint-browser-websockets/`
- Authoritative processed source: `regions/PDS02-browser-fetch-websocket-utf8-decoding.md`, browser Fetch and incremental decoding claims
- Source preservation: regional evidence and materialized source images recorded by the workspace coverage audit
- Workspace: `_ai-conspects/pipethrough,transformstream,pipeto,writablestream, readablestream/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R04 plus decoder/framing mechanics used by the R05 line-splitting example
- Original SVG: `source/pipethrough,transformstream,pipeto,writablestream, readablestream.svg`
- Workspace: `_ai-conspects/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison/`
- Authoritative processed source: `01-final-transcript.md`, R02 TextDecoder and line-framing loop
- Original SVG: `source/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison.svg`
