# ConditionalWeakTable lifetime associations

Knowledge ID: `dotnet.conditionalweaktable-lifetime-associations`

Topic: `dotnet`

`ConditionalWeakTable<TKey,TValue>` associates metadata with a reference-type key without keeping that key alive solely because it appears in the table:

```csharp
var table = new ConditionalWeakTable<object, Metadata>();

object key = new();
table.Add(key, new Metadata());

key = null!;
// once no strong key reference remains, the association is eligible for cleanup
```

The key is weak for lifetime purposes. The value stays alive through the association while the key stays alive. After all strong references to the key disappear, the runtime may collect the key and remove the association automatically.

Use it to attach metadata to objects you do not own, cache an expensive value per object, or support framework/runtime bookkeeping without modifying the target type or leaking keys through an ordinary strong-key dictionary:

```csharp
Result GetResult(MyClass key) =>
    cache.GetValue(key, static value => Compute(value));
```

It is intentionally not a normal business-data dictionary: do not depend on enumeration, stable record retention, or observing exactly when garbage collection removes an entry. Its API is limited because exposing size/iteration as a reliable contract would expose GC timing.

The shared idea with JavaScript `WeakMap` is:

```text
metadata lifetime follows a reference/object key
the association does not keep that key alive
```

The concrete runtime and APIs differ, so transfer the lifetime model rather than assuming identical operations.

## What should be recallable

- Which side of a ConditionalWeakTable association is weak for lifetime purposes?
- Why can the value remain alive while the key does?
- Which metadata/cache scenarios fit this structure?
- Why is it not a general-purpose dictionary or a GC-observation API?
- What central lifetime model does it share with JavaScript `WeakMap`?

## Related knowledge

- `javascript.map-and-weakmap-semantics` — JavaScript object-key weak associations.

## Sources

- Workspace: `_ai-conspects/sheet dict/`
- Authoritative processed source: `01-final-transcript.md`, R04
- Original SVG: `source/sheet dict.svg`
