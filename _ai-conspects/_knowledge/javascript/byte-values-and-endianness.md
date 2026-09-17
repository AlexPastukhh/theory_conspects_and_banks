# Byte values and endianness

Knowledge ID: `javascript.byte-values-and-endianness`

Topic: `javascript`

Eight bits form one byte. For an unsigned `n`-bit value, the range is `0..2^n - 1`, so unsigned 8-, 16-, and 32-bit ranges are `0..255`, `0..65535`, and `0..4294967295`.

```text
11111111
= 128 + 64 + 32 + 16 + 8 + 4 + 2 + 1
= 255
```

Endianness determines how the bytes of a multi-byte value map to significance. For `0x12345678`, `12` is the most significant byte and `78` the least significant:

```text
big-endian     12 34 56 78
little-endian  78 56 34 12
```

A one-byte value has no byte-order issue. Endianness matters for multi-byte integers, floating-point fields, binary files, network protocols, CPU instructions, and raw memory formats. Network formats often use big-endian, or "network byte order," but a parser must follow the specification of the particular format.

The same bytes can yield different valid-looking values:

```text
memory 34 12

little-endian -> 0x1234
big-endian    -> 0x3412
```

Likewise, the four bytes:

```text
00000001 00000000 00000000 00000000
```

represent `1` when the first byte is least significant, but `16777216` when it is most significant. The bits did not change; only byte-position significance changed.

Multi-byte typed-array elements use the host's native byte order and do not select an order per read. `Uint8Array` simply exposes bytes, so byte order does not alter an individual element. Use `DataView` when a file or protocol defines an explicit order.

Typed arrays work well when every grouped element has the same width. A layout such as:

```text
bytes 0..3   length
bytes 4..5   type
byte 6       flags
bytes 7..14  timestamp
```

needs mixed-width, offset-based parsing rather than one `Uint32Array` view.

## Sources
- Workspace: `_ai-conspects/uintarray,blob, arraybuffer,dataview,endianness/`
- Authoritative processed source: `01-final-transcript.md`, R02-R03

