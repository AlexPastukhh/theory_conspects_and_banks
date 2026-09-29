# C# string index search

Knowledge ID: `dotnet.string-index-search`

Topic: `dotnet`

`IndexOf` searches forward and `LastIndexOf` backward; both return `-1` when absent. Choose `StringComparison` explicitly for substrings. Range overloads accept start and count; `LastIndexOf` starts a backward scan.

```csharp
int index = text.IndexOf("token", StringComparison.OrdinalIgnoreCase);
int limited = text.IndexOf(value, startIndex, count, comparison);
char last = text[^1];       // requires non-empty string
string suffix = text[^3..];
```

`string` has no `FindIndex(Func<char,bool>)`. LINQ can carry indexes through a projection, but a loop is normally clearer and faster for predicate search.

```csharp
int digitIndex = -1;

for (int i = 0; i < text.Length; i++)
{
    if (char.IsDigit(text[i]))
    {
        digitIndex = i;
        break;
    }
}
```

## What should be recallable

- Explain the core model of **C# string index search** without opening the Unit.
- Reconstruct this Unit-grounded rule: `IndexOf` searches forward and `LastIndexOf` backward; both return `-1` when absent.
- Reconstruct this Unit-grounded rule: `string` has no `FindIndex(Func<char,bool>)`.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources

- Workspace: `_ai-conspects/STRING INDEX/`
- Processed source: `regions/R01-semantic-transcript-final-v001.md`, complete transcript
