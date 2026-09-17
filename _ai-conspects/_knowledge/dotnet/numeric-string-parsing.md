# Parsing numeric strings in .NET

Knowledge ID: `dotnet.numeric-string-parsing`

Topic: `dotnet`

Use `TryParse` for expected invalid/user input: it returns `true`/`false` and writes the parsed value or the target type's default to `out` on failure. It avoids using exceptions for ordinary invalid input, including their cost in repeated validation scenarios. Use `Parse` when invalid/null/overflow is exceptional, and remember `Convert.ToInt32(null)` returns zero while invalid non-null text still throws.

```csharp
bool ok = double.TryParse(text,
    NumberStyles.Float | NumberStyles.AllowThousands,
    CultureInfo.InvariantCulture,
    out double value);
```

Use current culture for localized input and invariant culture for protocol/file/API formats. `float` has less precision than `double`; `decimal` often fits base-10 financial work. Floating types may accept NaN/infinities depending on input/styles.

C# does not parse `"123abc"` like JavaScript `parseInt`. Explicitly extract a prefix, then `TryParse`; anchored `^[+-]?\d+` finds a prefix, while unanchored `[+-]?\d+` finds a number anywhere. A deliberate parser is needed for signs, decimals, and exponents. Validate overflow using the target type and choose type by required range/precision.

## Sources

- Workspace: `_ai-conspects/parse string to int,float,double/`
- Processed source: `01-final-transcript.md`, complete transcript
