# C# string characters, spans, and runes

Knowledge ID: `dotnet.string-character-views`

Topic: `dotnet`

A C# string implements `IEnumerable<char>`, so it can be processed without creating a collection:

```csharp
foreach (char value in text)
{
    Console.WriteLine(value);
}
```

Materialize only when ownership/collection APIs are needed:

```csharp
char[] array = text.ToCharArray();
List<char> list1 = text.ToList();
var list2 = new List<char>(text);
```

`ToCharArray` allocates an array; both list forms allocate a `List<char>`. For synchronous non-owning processing, use:

```csharp
ReadOnlySpan<char> span = text.AsSpan();
```

A `char` is one UTF-16 code unit, not always one complete Unicode character. Supplementary scalar values use surrogate pairs. Enumerate code points with runes when scalar semantics matter:

```csharp
foreach (Rune rune in text.EnumerateRunes())
{
    Console.WriteLine(rune);
}
```

Use `char` for code-unit processing, `Rune` for Unicode scalar processing, span for a non-owning synchronous view, and owned arrays/lists only when their lifetime or APIs are required.

## What should be recallable

- Allocation-free string enumeration versus array/list materialization.
- `ToCharArray`, `ToList`, list constructor, and `AsSpan` ownership differences.
- Why `char` is not always a character and when `EnumerateRunes` is required.

## Sources

- Workspace: `_ai-conspects/string to char list/`
- Processed source: `regions/R01-semantic-transcript-final-v001.md`, complete transcript
- Original SVG: `source/string to char list.svg`
