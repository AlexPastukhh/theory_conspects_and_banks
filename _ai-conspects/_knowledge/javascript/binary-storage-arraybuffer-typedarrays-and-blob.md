# Binary storage with ArrayBuffer, typed arrays, and Blob

Knowledge ID: `javascript.binary-storage-arraybuffer-typedarrays-and-blob`

Topic: `javascript`

In the ordinary `new ArrayBuffer(byteLength)` form covered by this source, an `ArrayBuffer` is a fixed-size block of raw bytes. It supplies storage but does not say whether those bytes represent integers, floats, text, or protocol fields.

```js
const buffer = new ArrayBuffer(8);
const bytes = new Uint8Array(buffer);
const words = new Uint32Array(buffer);
```

Views can share the same backing storage. Writing through one changes the bytes observed through another:

```js
const buffer = new ArrayBuffer(4);
const bytes = new Uint8Array(buffer);

bytes.set([1, 2, 3, 4]);

const words = new Uint32Array(buffer);
```

The storage is still `01 02 03 04`; `bytes` exposes four one-byte elements, while `words` exposes one four-byte element. Its multi-byte numeric value depends on native byte order.

## Typed-array contracts

A typed array is not a normal JavaScript array. In the non-resizable-buffer examples covered here, it has fixed length, homogeneous numeric elements, and a backing buffer. Its name specifies the element interpretation:

```text
Uint8Array   1 byte per element   0..255
Uint16Array  2 bytes per element  0..65535
Uint32Array  4 bytes per element  0..4294967295
```

Other families include signed integer arrays, `Float32Array`, `Float64Array`, `BigInt64Array`, and `BigUint64Array`.

Use `Uint8Array` for raw file or network bytes, WebSocket binary messages, crypto/hash inputs, encoder/decoder input, and custom-protocol buffers. It is the closest browser-side analogue to `byte[]`.

Use `Uint16Array` or `Uint32Array` when the data truly is a homogeneous sequence of fixed-width numeric elements, such as pixels, counters, or indexes. A structured packet with mixed field widths is not one homogeneous `Uint32Array`; parse that layout with `DataView`.

## Blob is file-like browser data

`Blob` is an immutable browser-oriented binary/file-like object:

```js
const blob = new Blob(["hello"], {
  type: "text/plain",
});
```

It fits downloads, object URLs, browser file APIs, file-like uploads, and workflows that delay byte-level parsing. Convert it when raw storage is needed:

```js
const buffer = await blob.arrayBuffer();
const bytes = new Uint8Array(buffer);
```

```text
Blob         immutable file-like browser object
ArrayBuffer  raw in-memory byte storage
typed array  homogeneous numeric view over that storage
```

## Sources
- Workspace: `_ai-conspects/uintarray,blob, arraybuffer,dataview,endianness/`
- Authoritative processed source: `01-final-transcript.md`, R01
