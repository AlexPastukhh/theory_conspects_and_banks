# Dictionary equality and key-set operations

Knowledge ID: `dotnet.dictionary-equality-and-key-set-operations`

Topic: `dotnet`

Two dictionaries are equal by content when their counts match, every key from one exists in the other, and corresponding values are equal under the intended value comparer:

```csharp
static bool DictionaryEqual<TKey, TValue>(
    IReadOnlyDictionary<TKey, TValue> left,
    IReadOnlyDictionary<TKey, TValue> right,
    IEqualityComparer<TValue>? valueComparer = null)
    where TKey : notnull
{
    valueComparer ??= EqualityComparer<TValue>.Default;

    if (left.Count != right.Count)
        return false;

    foreach (var (key, leftValue) in left)
    {
        if (!right.TryGetValue(key, out var rightValue))
            return false;

        if (!valueComparer.Equals(leftValue, rightValue))
            return false;
    }

    return true;
}
```

There is no dictionary `SetEquals` because content equality must define both key and value semantics. Key lookup follows each dictionary's configured key comparer; values use `EqualityComparer<TValue>.Default` or an explicit comparer. Ensure the dictionaries agree on key semantics before treating one lookup as the comparison contract.

Dictionary keys can be projected into a comparer-aware `HashSet<TKey>` for set algebra:

```csharp
var allKeys = new HashSet<TKey>(left.Keys, left.Comparer);
allKeys.UnionWith(right.Keys);

var commonKeys = new HashSet<TKey>(left.Keys, left.Comparer);
commonKeys.IntersectWith(right.Keys);

var onlyLeft = new HashSet<TKey>(left.Keys, left.Comparer);
onlyLeft.ExceptWith(right.Keys);
```

Preserving the source comparer matters for rules such as case-insensitive string keys. A dictionary from selected keys can carry the same comparer:

```csharp
var common = left.Keys
    .Intersect(right.Keys, left.Comparer)
    .ToDictionary(
        key => key,
        key => left[key],
        left.Comparer);
```

For a hot path, use `TryGetValue` while building the result to avoid repeated lookup work.

`KeyValuePair<TKey,TValue>` is a struct. Its equality follows component value equality rather than object reference identity.

## What should be recallable

- Which three checks establish dictionary content equality?
- Why must both key and value comparers be considered?
- Why is there no direct dictionary `SetEquals` equivalent?
- How do union, intersection, and difference apply to key sets?
- Why should a derived set/dictionary preserve the source key comparer?
- What equality category applies to `KeyValuePair<TKey,TValue>`?

## Sources

- Workspace: `_ai-conspects/sheet dict/`
- Authoritative processed source: `01-final-transcript.md`, R01
- Original SVG: `source/sheet dict.svg`
