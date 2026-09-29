# Iterator disposal and finally cleanup

Knowledge ID: `dotnet.iterator-disposal-and-finally-cleanup`

Topic: `dotnet`

C# iterator `finally` blocks are for cleanup. They cannot emit another element:

```csharp
IEnumerable<int> Generate()
{
    try
    {
        yield return 1;
        yield return 2;
    }
    finally
    {
        yield return 3; // compile error
    }
}
```

This differs from a JavaScript generator pattern that yields during cleanup; C# has no direct equivalent.

When enumeration ends early, disposing the enumerator runs its `finally` blocks:

```csharp
IEnumerable<int> Generate()
{
    try
    {
        yield return 1;
        yield return 2;
    }
    finally
    {
        Console.WriteLine("cleanup");
    }
}

var enumerator = Generate().GetEnumerator();
Console.WriteLine(enumerator.MoveNext()); // true; Current is 1
enumerator.Dispose();                     // prints "cleanup"
```

The cleanup runs even though the sequence was not exhausted, but it cannot turn disposal into another yielded value.

Async iterators follow the same central rule: `yield return` is not allowed in `finally`, while cleanup code can run there when async enumeration is disposed. The captured source also warns that awaiting inside an async iterator's `finally` can be problematic depending on the iterator shape:

```csharp
async IAsyncEnumerable<int> GenerateAsync()
{
    try
    {
        yield return 1;
        await Task.Delay(100);
        yield return 2;
    }
    finally
    {
        Console.WriteLine("async cleanup");
        await Task.Delay(100); // shape-dependent caveat in the source
    }
}
```

## What should be recallable

- Why is `yield return` illegal inside an iterator `finally` block?
- What happens to `finally` when enumeration stops before exhaustion?
- How does manual enumerator disposal demonstrate the cleanup path?
- Which cleanup rule is shared by synchronous and asynchronous iterators?
- What async-`finally` caveat does the captured source call out?

## Related knowledge

- `dotnet.deferred-enumeration-replay-and-materialization`
- `dotnet.async-enumerable-replay-and-single-use-streams`
- `javascript.async-generators-and-cancellation`

## Sources

- Workspace: `_ai-conspects/returning-iqueryable-problems-when-returning-ienumerable-without-tolist-async-enumerable-problems-yield/`
- Authoritative processed source: `regions/RIQ05-yield-iterator-cleanup-finally.md`
- Original SVG: `assets/raw/returning-iqueryable-ienumerable-async-yield.svg`
