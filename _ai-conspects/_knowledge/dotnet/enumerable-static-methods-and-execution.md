# Enumerable static methods and execution

Knowledge ID: `dotnet.enumerable-static-methods-and-execution`

Topic: `dotnet`

Most LINQ-to-Objects extension methods are static methods on `System.Linq.Enumerable`; extension syntax is sugar:

```csharp
Enumerable.Where(values, value => value > 0);
values.Where(value => value > 0);
```

`Enumerable.Empty<T>()` supplies an empty enumerable without allocating a new list, `Range(start, count)` produces consecutive integers, and `Repeat(value, count)` repeats a value.

Many sequence operators are deferred: their pipeline runs during enumeration, and repeated enumeration can repeat source work. Materializers and terminal operators such as `ToList`, `ToArray`, `ToDictionary`, and typically `Count`, `First`, `Single`, or `Aggregate` execute the pipeline. Materialize deliberately at API/lifetime boundaries or before repeated traversal of an expensive/stateful source.

## Sources
- Workspace: `_ai-conspects/Enumerable static methods/`
- Processed source: `01-final-transcript.md`, complete transcript

