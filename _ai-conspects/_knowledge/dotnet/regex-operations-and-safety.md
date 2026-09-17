# .NET Regex operations and safety

Knowledge ID: `dotnet.regex-operations-and-safety`

Topic: `dotnet`

Core operations are `Regex.IsMatch`, `Match`, `Matches`, `Replace`, and `Split`. Read captures through `Match.Groups`, including named groups. Escape a dynamic literal before embedding it:

```csharp
bool matched = Regex.IsMatch(input, pattern);
Match match = Regex.Match(input, @"(?<name>[A-Za-z]+)");
MatchCollection matches = Regex.Matches(input, pattern);
string name = match.Groups["name"].Value;
string replaced = Regex.Replace(input, pattern, replacement);
string[] parts = Regex.Split(input, pattern);
```

```csharp
string pattern = $@"\b{Regex.Escape(searchText)}\b";
```

Options include `IgnoreCase`, `Multiline`, `Singleline`, `CultureInvariant`, `ExplicitCapture`, `Compiled`, and compatible `NonBacktracking`. Configure a timeout for complex patterns or untrusted input:

```csharp
var regex = new Regex(
    pattern,
    RegexOptions.IgnoreCase | RegexOptions.CultureInvariant,
    TimeSpan.FromMilliseconds(200));
```

A match evaluator supports conditional/computed replacement. Replacement-string `$` semantics are retained in `dotnet.string-replacement`.

## Sources

- Workspace: `_ai-conspects/sheet regex sharp/`
- Processed source: `regions/R01-semantic-transcript-final-v001.md`, complete transcript
