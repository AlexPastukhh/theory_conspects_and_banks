# Deferred enumeration, replay, and materialization

Knowledge ID: `dotnet.deferred-enumeration-replay-and-materialization`

Topic: `dotnet`

An `IEnumerable<T>` is something that can produce an enumerator; it is not necessarily a finished collection. A static `IEnumerable<T>` value can reference either an already materialized list or a deferred recipe whose logic runs on enumeration. The type alone does not distinguish them.

```csharp
IEnumerable<int> GetNumbers()
{
    return Enumerable.Range(1, 5).Select(x =>
    {
        Console.WriteLine($"Processing {x}");
        return x * 2;
    });
}

var numbers = GetNumbers(); // recipe created; body has not run
var first = numbers.First(); // one enumeration, possibly partial
var all = numbers.ToList();  // a new enumeration from the beginning
```

`Any`, `First`, `Count`, `ToList`, `ToArray`, and `foreach` all enumerate. A common accidental replay is:

```csharp
var users = repository.GetActiveUsers();

if (users.Any())
{
    foreach (var user in users)
    {
        Console.WriteLine(user.Name);
    }
}
```

`Any()` starts one pass; `foreach` normally asks for a new enumerator and starts another. `First()` may run only enough logic to obtain one element; a later full pass starts over rather than continuing the first enumerator.

## Replay hazards

Repeating a deferred sequence can:

- issue the same database or remote query more than once;
- repeat CPU-expensive mapping;
- repeat logging, file reads, or other side effects;
- observe different data or time-dependent values on each pass;
- surface exceptions later and in a different application layer;
- fail when the resource behind the sequence has already been disposed.

For example, both operations repeat the line-reading pipeline and its logging:

```csharp
IEnumerable<string> GetLines() =>
    File.ReadLines("data.txt").Select(line =>
    {
        Console.WriteLine("Reading line");
        return line;
    });

var lines = GetLines();
int count = lines.Count();
string[] copy = lines.ToArray();
```

A time-producing projection can also return different values from two `ToList()` calls because each call reevaluates it.

## Place the materialization boundary deliberately

`ToList()` enumerates once and copies the current results into a list:

```csharp
var users = repository.GetActiveUsers().ToList();

if (users.Any())
{
    foreach (var user in users)
    {
        Console.WriteLine(user.Name);
    }
}
```

Reusing `users` now traverses the stored list rather than rerunning the original source logic. Returning that `List<T>` through an `IEnumerable<T>` reference does not make it deferred again.

The exact boundary still matters. LINQ before `ToList()` runs during that one materialization. LINQ added later is a new deferred, in-memory pipeline and can replay on every traversal:

```csharp
var selected = repository.GetUsers()       // repository already returned a list
    .Where(user => user.Name.StartsWith("A"));

foreach (var user in selected) { }
foreach (var user in selected) { } // repeats this in-memory Where
```

Materialization trades memory for stable reuse and a clear execution point. Returning a deferred sequence remains appropriate when laziness or streaming is intentional, later enumeration is safe, repeated work is acceptable, no shorter-lived resource escapes, and the contract makes those semantics clear.

## What should be recallable

- Why does `IEnumerable<T>` not prove that data is materialized?
- Which common LINQ operations start enumeration?
- Why do `Any()` plus `foreach`, or `First()` plus `ToList()`, replay work?
- Which side effects, consistency problems, and resource failures can replay cause?
- What exactly does `ToList()` cache?
- Why can caller-added LINQ still be deferred after the repository materialized its own query?
- When is a deliberately deferred return a reasonable contract?

## Related knowledge

- `ef-core.iqueryable-repository-and-resource-boundaries`
- `dotnet.async-enumerable-replay-and-single-use-streams`
- `dotnet.linq-materialization-casting-and-provider-boundaries`

## Sources

- Workspace: `_ai-conspects/returning-iqueryable-problems-when-returning-ienumerable-without-tolist-async-enumerable-problems-yield/`
- Authoritative processed sources: `regions/RIQ02-ienumerable-tolist-materialization-boundary.md`, `regions/RIQ03-multiple-enumeration-hazards.md`, and the synchronous iterator/materialization portion of `regions/RIQ04-async-enumerable-repeated-enumeration.md`
- Original SVG: `assets/raw/returning-iqueryable-ienumerable-async-yield.svg`
