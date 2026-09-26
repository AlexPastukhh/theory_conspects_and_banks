# Contains, StartsWith, and EndsWith

Knowledge ID: `dotnet.string-contains-startswith-endswith`

Topic: `dotnet`

```csharp
var s = "Hello World";
bool contains = s.Contains("World");
bool starts = s.StartsWith("Hello", StringComparison.Ordinal);
bool ends = s.EndsWith("world", StringComparison.OrdinalIgnoreCase);
```

`Contains` searches anywhere, `StartsWith` only the beginning, and `EndsWith` only the end. The one-argument `Contains(string)` is case-sensitive and ordinal/culture-insensitive—not culture-sensitive. Prefer explicit `StringComparison` for machine contracts.

Do not lowercase merely to compare; use an ignore-case overload. Substring containment is not whole-string equality; use `string.Equals` for that. These are instance methods and throw on null receivers; guard nullable values with `s?.StartsWith(... ) == true` when appropriate.

## What should be recallable

- Explain the core model of **Contains, StartsWith, and EndsWith** without opening the Unit.
- Reconstruct this Unit-grounded rule: `Contains` searches anywhere, `StartsWith` only the beginning, and `EndsWith` only the end.
- Reconstruct this Unit-grounded rule: Do not lowercase merely to compare; use an ignore-case overload.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources
- Workspace: `_ai-conspects/CONTAINS STARTSWITH ENDSWITH/`
- Processed source: `01-final-transcript.md`, corrected source-preserving transcript
