# C# string sorting and comparer choice

Knowledge ID: `dotnet.string-sorting-and-comparers`

Topic: `dotnet`

`Array.Sort` and `List<T>.Sort` mutate; LINQ `OrderBy` returns a new ordered sequence. Supply a comparer deliberately: ordinal for technical identifiers, ordinal-ignore-case for case-insensitive identifiers, current culture for localized user text, and invariant culture for stable linguistic behavior across environments. Do not approximate comparison by lowercasing values.

```csharp
Array.Sort(words, StringComparer.OrdinalIgnoreCase);
var sorted = words.OrderBy(x => x, comparer)
                  .ThenBy(x => x, StringComparer.Ordinal);
```

Add a secondary key when comparer-equal values still need deterministic order. `OrderByDescending` follows the same comparer model.

## Sources

- Workspace: `_ai-conspects/STRING SORT/`
- Processed source: `regions/R01-semantic-transcript-final-v001.md`, complete transcript
