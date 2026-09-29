# Async-enumerable replay and single-use streams

Knowledge ID: `dotnet.async-enumerable-replay-and-single-use-streams`

Topic: `dotnet`

A deferred `IAsyncEnumerable<T>` is also a recipe rather than stored results. Creating the sequence does not run its iterator body; every new async enumeration normally starts that body again.

```csharp
async IAsyncEnumerable<int> GetNumbers()
{
    Console.WriteLine("start");
    await Task.Delay(100);
    yield return 1;

    Console.WriteLine("middle");
    await Task.Delay(100);
    yield return 2;
}

var sequence = GetNumbers();

var first = await sequence.ToListAsync();  // first async enumeration
var second = await sequence.ToListAsync(); // body runs again
```

Both `await foreach` and `ToListAsync()` enumerate. Materializing and then traversing the **original** sequence still performs two passes:

```csharp
var sequence = GetUsersAsync();

var list = await sequence.ToListAsync();

await foreach (var user in sequence)
{
    Console.WriteLine(user.Name);
}
```

The second pass can repeat database calls, HTTP calls, delays, file reads, or streaming work. Reusing `list` does not rerun the original async iterator; reusing `sequence` normally does.

Some async enumerables are effectively single-use because they wrap a stream or another external resource. A second pass can rerun, fail, return different data, or be unsupported. When stable reuse is required, consume once and reuse the materialized collection:

```csharp
var users = await GetUsersAsync().ToListAsync();

// Reuse users, not the original async stream.
```

Streaming and materialization are different contracts. Preserve `IAsyncEnumerable<T>` when incremental consumption is the goal and the ownership/lifetime is explicit; materialize when the same result set must be traversed repeatedly.

## What should be recallable

- Why is a deferred `IAsyncEnumerable<T>` a recipe?
- Which operations enumerate an async sequence?
- Why does `ToListAsync()` followed by `await foreach` over the original sequence replay work?
- Which kinds of I/O can repeated async enumeration repeat?
- Why should some stream-backed sequences be treated as single-use?
- What should be reused after one materialization?

## Related knowledge

- `dotnet.deferred-enumeration-replay-and-materialization`
- `dotnet.iterator-disposal-and-finally-cleanup`

## Sources

- Workspace: `_ai-conspects/returning-iqueryable-problems-when-returning-ienumerable-without-tolist-async-enumerable-problems-yield/`
- Authoritative processed source: `regions/RIQ04-async-enumerable-repeated-enumeration.md`
- Original SVG: `assets/raw/returning-iqueryable-ienumerable-async-yield.svg`
