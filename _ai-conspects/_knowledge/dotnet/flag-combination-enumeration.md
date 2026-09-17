# Enumerating flag combinations with bit masks

Knowledge ID: `dotnet.flag-combination-enumeration`

Topic: `dotnet`

Independent `[Flags]` values use one bit each and combine with OR. Inclusion is tested with `(value & flag) == flag`; explicit checks avoid the zero-flag ambiguity of `HasFlag`.

For `n` atomic flags there are `2^n` subsets and `2^n - 1` non-empty subsets. Each mask from 1 through `(1L << n) - 1` selects one combination:

```text
001 -> C
010 -> B
011 -> B + C
100 -> A
101 -> A + C
110 -> A + B
111 -> A + B + C
```

```csharp
for (long mask = 1; mask < (1L << n); mask++)
{
    long combined = 0;
    for (int i = 0; i < n; i++)
        if ((mask & (1L << i)) != 0)
            combined |= values[i];

    yield return combined;
}
```

`yield return` emits each combination lazily and preserves the iterator state so enumeration can continue with later masks; it avoids materializing the full result by itself.

Generic enum code converts atomic values to an integral representation, combines them, then uses `(TEnum)Enum.ToObject(typeof(TEnum), combined)`. Filter out zero, aliases, duplicates, and pre-combined members; validate `[Flags]` intent and exactly-one-bit atomic values. Choose a width that fits every bit (`long` has 63 practical positive positions; consider `ulong`). The algorithm is exponential: about one million combinations at 20 flags and one billion at 30, so do not materialize large power sets.

## Sources

- Workspace: `_ai-conspects/Bitwise checking for all combinations/`
- Processed source: `01-final-transcript.md`, complete transcript
