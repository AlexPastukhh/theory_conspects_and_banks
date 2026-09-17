# DataView offsets and mixed binary layouts

Knowledge ID: `javascript.dataview-offsets-and-binary-layouts`

Topic: `javascript`

`DataView` reads and writes mixed numeric types at byte offsets in an `ArrayBuffer`. Multi-byte methods take an explicit endian flag:

```text
true   little-endian
false  big-endian
```

One-byte methods need no byte-order flag.

```js
const buffer = new ArrayBuffer(8);
const view = new DataView(buffer);

view.setUint8(0, 255);
view.setUint16(1, 0x1234, true);
view.setUint32(3, 0xDEADBEEF, false);
```

Available method families include signed and unsigned 8/16/32-bit integers, 32/64-bit floats, and signed/unsigned 64-bit `BigInt` values:

```text
getInt8 / setInt8       getUint8 / setUint8
getInt16 / setInt16     getUint16 / setUint16
getInt32 / setInt32     getUint32 / setUint32
getFloat32 / setFloat32
getFloat64 / setFloat64
getBigInt64 / setBigInt64
getBigUint64 / setBigUint64
```

The same bytes can be interpreted both ways:

```js
const buffer = new ArrayBuffer(4);
const view = new DataView(buffer);

view.setUint32(0, 0x12345678, true);

console.log(view.getUint32(0, true));
console.log(view.getUint32(0, false));
```

## Offsets are byte offsets

`view.getUint32(4, true)` starts at byte offset 4 and reads four bytes. It does not mean "the fourth 32-bit element." This byte-oriented addressing is what supports file and protocol layouts with mixed field widths.

A `DataView` can cover a window of a larger buffer without copying:

```js
const buffer = new ArrayBuffer(20);
const metadata = new DataView(buffer, 8, 6);

metadata.getUint16(2, true);
```

Here the view covers original bytes `8..13`; method offsets are relative to that view, so offset `2` starts at original buffer byte `10`. The view's `byteOffset` and `byteLength` describe this shared window.

## Combine raw-byte and structured views

One view can inspect or copy bytes while another parses fields from the same storage:

```js
const buffer = new ArrayBuffer(6);
const bytes = new Uint8Array(buffer);
const view = new DataView(buffer);

bytes.set([
  0x34, 0x12,
  0x78, 0x56,
  0x01, 0x02,
]);

console.log(view.getUint16(0, true));
console.log(view.getUint16(2, true));
```

Use `Uint8Array` for raw-byte inspection and copying; use `DataView` for structured numeric fields, mixed widths, byte offsets, and explicit file/protocol endianness.

## Sources
- Workspace: `_ai-conspects/uintarray,blob, arraybuffer,dataview,endianness/`
- Authoritative processed source: `01-final-transcript.md`, R04 (with the mixed-layout boundary from R03)

