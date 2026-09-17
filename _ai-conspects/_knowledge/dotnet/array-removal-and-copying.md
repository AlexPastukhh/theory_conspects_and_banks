# C# array removal and copying

Knowledge ID: `dotnet.array-removal-and-copying`

Topic: `dotnet`

Arrays cannot shrink. Removing all matching values uses `Where(...).ToArray`; removing one index allocates a length-minus-one result and copies the prefix and shifted suffix with `Array.Copy`. The original remains unchanged, copying is shallow for reference elements, and order-preserving removal costs O(n).

```csharp
static T[] RemoveAt<T>(T[] source, int index)
{
    if ((uint)index >= (uint)source.Length)
        throw new ArgumentOutOfRangeException(nameof(index));

    var result = new T[source.Length - 1];
    Array.Copy(source, 0, result, 0, index);
    Array.Copy(
        source, index + 1,
        result, index,
        source.Length - index - 1);
    return result;
}
```

The copy parameters identify source array/index, destination array/index, and element count. The first call copies the prefix; the second copies the suffix into its shifted position.

Remove-first semantics require state: find `Array.IndexOf` then use the two-copy algorithm, or use a carefully scoped stateful predicate. Stateful LINQ predicates are harder to reason about and must not be reused concurrently. Name helpers `RemoveAll`, `RemoveFirst`, or `RemoveAt`; comparer/equality semantics determine matches.

Use `List<T>` when removal is normal (`Remove`, `RemoveAt`, `RemoveAll`). Manual copying avoids LINQ iterator/predicate overhead for hot code. Linked structures trade locality/indexing for fewer shifts. If order is irrelevant, swap-with-last on a resizable collection enables O(1) removal. Avoid repeated array/list conversions and benchmark realistic sizes.

## Sources
- Workspace: `_ai-conspects/remove from arr, copy/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
