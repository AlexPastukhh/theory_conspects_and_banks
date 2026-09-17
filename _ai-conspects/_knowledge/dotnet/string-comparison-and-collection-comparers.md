# String comparison and collection comparers

Knowledge ID: `dotnet.string-comparison-and-collection-comparers`

Topic: `dotnet`

`string.Compare` returns negative/zero/positive for ordering; use `string.Equals` when only equality matters. Choose rules by domain:

```text
technical identifiers      Ordinal / OrdinalIgnoreCase
localized user text        CurrentCulture / CurrentCultureIgnoreCase
stable linguistic rules    InvariantCulture / InvariantCultureIgnoreCase
```

Ordinal is deterministic code-unit-oriented behavior and avoids locale casing surprises. Invariant is linguistic but stable across environments; it is not every user's locale and is usually wrong for machine identifiers. Current culture intentionally varies with user/environment.

Collections accept the corresponding `StringComparer` so equality and compatible hashing are centralized:

```csharp
var map = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
var set = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
names.Sort(StringComparer.CurrentCultureIgnoreCase);
```

Avoid `a.ToLower() == b.ToLower()`: it allocates, obscures semantics, and risks culture errors.

## Sources
- Workspace: `_ai-conspects/STRINGCOMPARER,compare strings case insens/`
- Processed source: `regions/final-transcript.md`, complete transcript
