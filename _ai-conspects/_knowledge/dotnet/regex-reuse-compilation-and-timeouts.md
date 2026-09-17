# Regex reuse, compilation, and timeouts

Knowledge ID: `dotnet.regex-reuse-compilation-and-timeouts`

Topic: `dotnet`

Reuse an immutable pattern/options/timeout combination instead of constructing it in a hot loop; Regex instances support ordinary concurrent matching.

```csharp
private static readonly Regex SafeRegex = new(
    Pattern,
    RegexOptions.Compiled |
    RegexOptions.IgnoreCase |
    RegexOptions.CultureInvariant,
    TimeSpan.FromMilliseconds(200));
```

`Compiled` raises startup/construction and usually memory cost but can improve repeated execution. Use it for measured hot paths in long-running processes; interpreted regex can be cheaper for one-off/short-lived use. Reuse matters either way.

Choose culture deliberately: invariant case rules suit identifiers/protocols, while natural language may require culture-aware matching. A timeout limits catastrophic backtracking and throws `RegexMatchTimeoutException`, which should be handled distinctly. Compilation cannot repair a pathological pattern; keep pattern design and timeout protection.

## Sources

- Workspace: `_ai-conspects/regex, reusing, compiled/`
- Processed source: `01-final-transcript.md`, complete transcript
