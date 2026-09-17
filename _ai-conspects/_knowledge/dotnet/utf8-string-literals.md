# C# UTF-8 string literals

Knowledge ID: `dotnet.utf8-string-literals`

Topic: `dotnet`

A normal literal is a UTF-16 `string`; the `u8` suffix creates compile-time UTF-8 bytes exposed as `ReadOnlySpan<byte>`:

```csharp
string text = "hello";
ReadOnlySpan<byte> bytes = "hello"u8;
```

This fits byte-oriented APIs such as `PipeReader`, `SequenceReader<byte>`, sockets, files, wire protocols, and parsers, avoiding repeated `Encoding.UTF8.GetBytes` for constant tokens.

```csharp
private static ReadOnlySpan<byte> Ping => "PING"u8;

if (reader.IsNext(Ping, advancePast: true))
{
    // matched P I N G bytes
}
```

Comparisons such as `reader.IsNext("POST "u8, true)` remain byte-to-byte.

`ReadOnlySpan<byte>` is a ref struct and cannot be a normal class instance field. Use a static span-returning property for constant data, or owned storage when a normal field/lifetime is required:

```csharp
private static readonly byte[] Prefix = "PING"u8.ToArray();
```

The array allocates once and is storable; the property avoids owned storage for short static literals. The value is bytes, `Length` counts bytes, and no implicit zero terminator is appended. Use string/char APIs for text manipulation, and convert to owned memory when bytes must outlive a span-safe scope.

## What should be recallable

- Normal UTF-16 string versus `u8` compile-time UTF-8 byte span.
- Byte-parser use cases and avoided repeated encoding.
- Ref-struct storage limitation, static property pattern, and owned-array alternative.
- Byte length, no terminator, and the text-processing/lifetime boundaries.

## Sources

- Workspace: `_ai-conspects/utf8 string  literal/`
- Processed source: `regions/R01-final-coverage-transcript.md`, R01
- Original SVG: `source/utf8 string  literal.svg`
