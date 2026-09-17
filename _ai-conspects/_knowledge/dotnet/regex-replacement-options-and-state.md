# Regex replacement options and per-call state

Knowledge ID: `dotnet.regex-replacement-options-and-state`

Topic: `dotnet`

Case-insensitivity can be supplied as `RegexOptions.IgnoreCase`, inline `(?i)`, or a scoped group such as `(?i:...)`. Use `Regex.Escape` when dynamic input must be matched literally rather than interpreted as regex syntax. Machine identifiers usually call for `CultureInvariant`; user-facing text may deliberately use culture-aware matching.

Replacement strings support numbered (`$1`) and named (`${name}`) captures; `$$` emits a literal dollar sign. Use a `MatchEvaluator` when the replacement depends on the match:

```csharp
string result = Regex.Replace(input, pattern, match =>
    ShouldReplace(match) ? Transform(match.Value) : match.Value,
    RegexOptions.IgnoreCase,
    TimeSpan.FromSeconds(1));
```

An Nth-occurrence replacement needs state local to that operation. A simple counter counts matches globally; capture-aware logic is needed when one match contains several captures. For per-line numbering, split while preserving the intended newline form, apply a fresh counter to each line, then join. A single-pass expression is possible but usually harder to audit.

Reusable expressions can be cached when reuse is significant. `Compiled` trades startup and memory for repeated execution; source-generated regex is another option. Stateful data must not leak between calls. Always use a realistic timeout for untrusted or complex input because catastrophic backtracking can otherwise consume unbounded time. A timeout only limits damage; it does not make a poor expression efficient, so prefer deterministic or non-backtracking designs where possible.

## Sources
- Workspace: `_ai-conspects/sharp regex options  + COND REPLACE/`
- Processed source: `01-final-transcript.md`, complete transcript
