# C# String.Split and parser boundaries

Knowledge ID: `dotnet.string-split-and-parser-boundary`

Topic: `dotnet`

Split by one character, several characters, or a string separator:

```csharp
string[] a = input.Split(',');
string[] b = input.Split(new[] { ',', ';' });
string[] c = input.Split("::", StringSplitOptions.None);
```

Combine options when whitespace/empty fields should be normalized:

```csharp
string[] parts = input.Split(
    ',',
    StringSplitOptions.RemoveEmptyEntries
    | StringSplitOptions.TrimEntries);
```

`TrimEntries` trims each result; `RemoveEmptyEntries` discards empty results.

Limit the result count when the remainder must remain intact, such as key/value input:

```csharp
string[] parts = input.Split(separator, count: 2);
```

`Split` is not a CSV parser: quoting, escaped delimiters, and embedded newlines require a CSV parser or state machine. For allocation-sensitive parsing, use spans and delimiter indexes such as `input.AsSpan().IndexOf(',')`. Use `Split` for simple formats with explicit delimiter rules.

## What should be recallable

- Character-array and string separator overloads.
- Trim/remove-empty option semantics.
- Count-limited remainder preservation.
- CSV/parser boundary and span-based allocation alternative.

## Sources

- Workspace: `_ai-conspects/STRING SPLIT/`
- Processed source: `regions/R01-semantic-transcript-final-v001.md`, complete transcript
- Original SVG: `source/STRING SPLIT.svg`
