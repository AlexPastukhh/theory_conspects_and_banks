# C# string replacement choices

Knowledge ID: `dotnet.string-replacement`

Topic: `dotnet`

Use `string.Replace` for literal character or string replacement:

```csharp
string result = input.Replace("old", "new");
string normalized = input.Replace('-', '_');
```

Strings are immutable, so assign the return value. Modern target frameworks also provide comparison-aware overloads such as `StringComparison.OrdinalIgnoreCase`; confirm availability for the project's target framework.

Use `Regex.Replace` for patterns, captures, or computed replacement:

```csharp
string result = Regex.Replace(input, Regex.Escape(search), replacement,
    RegexOptions.IgnoreCase, TimeSpan.FromMilliseconds(200));
string transformed = Regex.Replace(input, pattern, match => Transform(match));
```

Regex replacement strings interpret `$1`, `${name}`, and `$$` specially. Use a `MatchEvaluator` when literal replacement data may contain `$`. For many one-pass transformations, consider a parser or `StringBuilder`.

## What should be recallable

- Literal replacement, comparison-aware replacement, and immutability.
- When regex escaping, a timeout, captures, or a match evaluator are required.
- Why arbitrary `$` data is unsafe as a regex replacement string.

## Sources

- Workspace: `_ai-conspects/REPLACE/`
- Processed source: `regions/R01-semantic-transcript-final-v001.md`, complete transcript
- Original SVG: `source/REPLACE.svg`
