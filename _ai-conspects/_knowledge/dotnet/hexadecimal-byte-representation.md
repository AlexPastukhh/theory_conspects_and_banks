# Hexadecimal and byte representation

Knowledge ID: `dotnet.hexadecimal-byte-representation`

Topic: `dotnet`

A number is a quantity; decimal, binary, and hexadecimal are representations of the same value. Hexadecimal uses powers of 16 and digits `0–9`, `A–F`; prefixes such as C# `0x` mark a hexadecimal integer.

In JavaScript, `0x`, `0b`, and `0o` mark hexadecimal, binary, and octal literals respectively; `0x10` means sixteen, not “zero times” another value. Place value expands from the right at exponent zero, for example `0x41 = 4 × 16 + 1`.

One hexadecimal digit has 16 possibilities and therefore represents exactly four bits. One byte has eight bits, so two hex digits align to one byte. Convert each digit to a four-bit nibble and concatenate:

```text
0x41 = 0100 0001 = 65 = ASCII 'A'
42   = 0x2A      = 0b101010
```

Preserve leading zeros when displaying a full byte: `0x01` maps to `0000 0001`. For the reverse operation, group binary digits into four-bit nibbles from the right and map each nibble to a hex digit. This compact alignment makes hex useful for bytes, bit patterns, memory dumps, colors, and binary protocols; for example UTF-8 `é` is commonly shown as `0xC3 0xA9` rather than sixteen binary digits.

## Sources
- Workspace: `_ai-conspects/hexadecimal base16 how  to convert to bytes easily/`
- Processed source: `10-full-source-preserving-transcript-v002.md`, complete source-preserving transcript
