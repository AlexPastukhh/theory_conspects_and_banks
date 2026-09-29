# C# string padding and alignment

Knowledge ID: `dotnet.string-padding-and-alignment`

Topic: `dotnet`

`PadLeft(totalWidth, char)` and `PadRight(totalWidth, char)` produce simple fixed-width strings:

```csharp
string value = "42";
string left = value.PadLeft(5, '0');  // "00042"
string right = value.PadRight(5, '.'); // "42..."
```

Without a padding character, `PadLeft(5)` uses spaces. If requested width is less than or equal to the original length, the original value is returned.

For numbers, numeric formatting may state intent better:

```csharp
string result = number.ToString("D5");
```

Composite/interpolated alignment can align columns:

```csharp
string row = $"{name,-20}{count,8}";
```

Padding measures UTF-16 code units, not terminal display columns. Emoji, combining marks, and East Asian wide characters may not align visually. Use padding for simple fixed-width text, not complex tables or localization.

## What should be recallable

- `PadLeft`/`PadRight`, default space, custom characters, and short-width behavior.
- Numeric `D5` and interpolation alignment alternatives.
- Why UTF-16 length can differ from terminal width and where padding becomes inappropriate.

## Sources

- Workspace: `_ai-conspects/STRING PADDING/`
- Processed source: `regions/R01-semantic-transcript-final-v001.md`, complete transcript
- Original SVG: `source/STRING PADDING.svg`
