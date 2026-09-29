# ASCII codes and UTF-8 compatibility

Knowledge ID: `dotnet.ascii-and-utf8-compatibility`

Topic: `dotnet`

ASCII is a 7-bit set of 128 codes (`0`–`127`). Examples include `A = 65`, `a = 97`, `0 = 48`, and space `= 32`. Codes `0`–`31` and `127` are controls; `32`–`126` are printable. Tab is `9`, line feed `10`, and carriage return `13`.

In C#, an ASCII `char` converts to the same integer code and back because .NET `char` stores a UTF-16 code unit and ASCII characters use the same Unicode scalar values:

```csharp
char ch = 'A';
int code = ch;       // 65
char again = (char)65;
```

UTF-8 encodes Unicode, and code points `U+0000`–`U+007F` use one byte equal to the ASCII numeric value. Thus ASCII bytes are valid UTF-8 and ASCII-only English text has identical bytes. Outside that range, UTF-8 uses multibyte sequences while ASCII cannot represent the characters.

```csharp
Encoding.ASCII.GetBytes("Alice:secret");
Encoding.UTF8.GetBytes("Alice:secret");
```

These match for ASCII-only input. For non-ASCII input, UTF-8 preserves the text while `Encoding.ASCII` uses replacement fallback and loses information. Use ASCII only when a protocol explicitly guarantees its repertoire; use UTF-8 for general text. UTF-8 is not ASCII—it preserves ASCII as a compatible subset.

## What should be recallable

- ASCII size, control/printable ranges, and common numeric examples.
- Why C# char/integer conversion agrees in the ASCII range.
- Why ASCII bytes are valid UTF-8, and what changes beyond code point 127.
- The information-loss difference between `Encoding.ASCII` and UTF-8.

## Sources

- Workspace: `_ai-conspects/ascii/`
- Processed source: `regions/R01-ascii-encoding-utf8-comparison-final.md`, R01
- Original SVG: `source/ascii.svg`
