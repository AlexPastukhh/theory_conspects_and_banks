# Action, Func, and Predicate delegate shapes

Knowledge ID: `dotnet.built-in-delegate-shapes`

Topic: `dotnet`

`Action` is the built-in family for void-returning operations:

```text
Action             -> no parameters, returns void
Action<T>          -> one parameter, returns void
Action<T1, T2>     -> two parameters, returns void
Action<T1, T2, T3> -> three parameters, returns void
```

For example, `Action<int, string>` has the same call shape as:

```csharp
delegate void LogUserDelegate(int userId, string name);
```

Use the built-in form when a domain-specific delegate name adds no value.

`Func<TResult>` and `Func<T, TResult>` return a value; the final generic argument is always the result type:

```csharp
Func<int> getCount = () => 42;
Func<string, int> getLength = text => text.Length;
```

Use `Action` when the operation returns `void`, and `Func` when the caller needs a result.

`Predicate<T>` takes `T` and returns `bool`:

```csharp
Predicate<int> isPositive = value => value > 0;
```

It is shape-compatible with `Func<T, bool>`, but its name communicates that the delegate represents a test.

## What should be recallable

- Parameter and return shapes of `Action`, `Func`, and `Predicate`.
- Why the last `Func` generic argument is special.
- When a built-in delegate avoids a custom declaration and when `Predicate<T>` adds semantic intent.

## Sources

- Workspace: `_ai-conspects/events,delegaates,action/`
- Processed source: `01-final-transcript.md`, R03
- Original SVG: `source/events,delegaates,action.svg`
- Workspace: `_ai-conspects/events-delegaates-action/`
- Authoritative processed sources: `10-full-source-preserving-transcript-v003.md`, S-044–S-051; `11-technical-corrections-v002.md`, correction 5
- Original SVG: `source/events,delegaates,action.svg`, SHA-256 `58fe05fdd4d608c36102140c4a25a6f8975bc5d914825d20ebc1aea90364778e`
