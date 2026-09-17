# C# string trimming boundaries

Knowledge ID: `dotnet.string-trimming-boundaries`

Topic: `dotnet`

`Trim`, `TrimStart`, and `TrimEnd` remove recognized whitespace at boundaries, not inside. Strings are immutable, so assign the result. Character overloads treat their argument as a set of removable boundary characters, not an exact substring.

```csharp
string value = "---hello___";
string result = value.Trim('-', '_');

value.Trim();       // does not mutate value
value = value.Trim();
```

Conceptually, trimming `a` and `b` removes any boundary character in that set; it does not remove the exact substring `"ab"`.

For an exact prefix/suffix, use `StartsWith`/`EndsWith` with explicit `StringComparison`, then slice. For nullable input use `input?.Trim()` and an explicit fallback if required. Preserve whitespace when contractual, as in passwords, fixed-width data, or signed payloads.

```csharp
if (value.StartsWith(prefix, StringComparison.Ordinal))
    value = value[prefix.Length..];

string result = input?.Trim() ?? string.Empty;
```

## Sources

- Workspace: `_ai-conspects/STRING  TRIM/`
- Processed source: `regions/R01-semantic-transcript-final-v001.md`, complete transcript and examples
