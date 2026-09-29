# Dictionary capacity and API contracts

Knowledge ID: `dotnet.dictionary-capacity-and-api-contracts`

Topic: `dotnet`

`Dictionary<TKey,TValue>` is a hash table. Average key lookup is `O(1)`; severe collisions can degrade toward `O(n)`. Enumeration order is not a sorted-order contract—use `SortedDictionary` or another ordered abstraction when sorting is part of the requirement.

## Lookup, insertion, and removal

```csharp
var value = dictionary[key];            // throws when key is absent
var found = dictionary.TryGetValue(key, out var value);
var fallback = dictionary.GetValueOrDefault(key);
var hasKey = dictionary.ContainsKey(key);
var hasValue = dictionary.ContainsValue(value); // O(n)
```

```csharp
dictionary.Add(key, value);       // throws when key already exists
var added = dictionary.TryAdd(key, value);
dictionary[key] = value;          // inserts or overwrites
```

```csharp
var removed = dictionary.Remove(key);
if (dictionary.Remove(key, out var removedValue))
{
    // removed value is available
}
dictionary.Clear();
```

`Keys` and `Values` are live collection views, not copied arrays. Normal code should prefer the strongly typed API; operations exposed only through non-generic `IDictionary` or `ICollection<KeyValuePair<TKey,TValue>>` casts are mainly relevant to generic infrastructure.

## Capacity is not a maximum

```csharp
var dictionary = new Dictionary<int, string>(expectedCount);
var set = new HashSet<Guid>(expectedCount);
```

The constructor reserves internal bucket/entry storage for roughly the expected element count. It does not cap the collection; adding more entries grows it. The runtime may round a requested capacity to an implementation-appropriate table size.

Without enough capacity, growth may allocate larger arrays, rehash entries, copy metadata, and leave old arrays for collection. Preallocation can reduce allocations, CPU, GC pressure, and latency spikes for known large counts in hot loops, startup indexing, real-time services, games, and high-throughput ingestion. It is usually negligible for small collections.

```text
Count    -> entries currently stored
capacity -> current internal accommodation
maximum  -> not established by constructor capacity
```

`EnsureCapacity(expectedCount)` ensures at least that accommodation and returns the resulting capacity. `TrimExcess()` or `TrimExcess(targetCapacity)` can shrink storage but requires reallocation/rehashing, so do not call it repeatedly on a hot path.

Provide the comparer during original construction when it is already known:

```csharp
var counts = new Dictionary<string, int>(
    capacity: 1000,
    comparer: StringComparer.OrdinalIgnoreCase);
```

Building under one comparer and then copying into a dictionary with another allocates another table and reinserts every entry.

## What should be recallable

- Which lookup APIs throw, report absence, or scan values?
- How do `Add`, `TryAdd`, and indexer assignment differ?
- What do the two `Remove` forms return?
- Why are `Keys` and `Values` described as live views?
- How do `Count`, capacity, and maximum size differ?
- What work can resizing and trimming perform?
- Why should capacity and comparer be supplied at original construction when known?

## Sources

- Workspace: `_ai-conspects/sheet dict/`
- Authoritative processed source: `01-final-transcript.md`, R02 and R03
- Original SVG: `source/sheet dict.svg`
