# Lazy<T> initialization, async tasks, and argument patterns

Knowledge ID: `dotnet.lazy-initialization-and-argument-patterns`

Topic: `dotnet`

## Basic Lazy<T> lifecycle

`Lazy<T>` provides deferred, cached initialization:

1. **Deferred execution:** The underlying value is not computed when the `Lazy<T>` instance is constructed; initialization runs on the first `.Value` access.
2. **Result caching:** After the first successful execution, the computed instance is stored and subsequent `.Value` reads return the cached object without re-executing the factory.
3. **Publication tracking:** `.IsValueCreated` returns `true` only after successful initialization. If initialization throws, `IsValueCreated` remains `false` even if an exception was thrown and cached.

`Lazy<T>` vs manual null checks (`if (_obj == null) _obj = Create();`): manual null checking is racy under concurrency and fails to guarantee single execution unless explicit synchronization is added. With its thread-safe modes, `Lazy<T>` provides a tested initialization implementation with explicit concurrency semantics.

## Constructors: Parameterless vs Factory

### Parameterless constructor
```csharp
var lazy = new Lazy<MyType>();
```
Uses `new MyType()` on first `.Value` access. Requires `MyType` to expose a public parameterless constructor. Useful for self-contained types (e.g. building an in-memory lookup table), but cannot receive runtime arguments or dependency injection services.

### Factory constructor
```csharp
var lazy = new Lazy<MyType>(() => new MyType(dep1, dep2));
```
Uses a custom `Func<T>` delegate. The factory can pass constructor arguments, resolve dependencies, execute setup code, and choose implementations dynamically. This is the standard form used in application and DI code.

## Asynchronous Lazy initialization: Lazy<Task<T>>

When lazy initialization requires asynchronous I/O (e.g. database access or reading files), wrap a `Task<T>` inside `Lazy<T>`:

```csharp
public sealed class ConfigReader
{
    private readonly Lazy<Task<string>> _content;

    public ConfigReader(string path)
    {
        _content = new Lazy<Task<string>>(
            () => File.ReadAllTextAsync(path));
    }

    public Task<string> GetContentAsync() => _content.Value;
}
```

Never use `Lazy<T>` with a synchronous blocking call like `Task.Result`, as this risks deadlocks or thread starvation. Storing `Lazy<Task<T>>` caches the `Task` itself; all concurrent and subsequent callers await the same shared task.

## Argument patterns for Lazy<T>

`Lazy<T>.Value` accepts no parameters because its factory is `Func<T>`. When initialization depends on arguments, use one of three patterns depending on scope and lifetime:

### Pattern A: Capture fixed arguments in a closure
Used when arguments are known when constructing the `Lazy<T>` instance:

```csharp
string path = "config.json";
var lazyText = new Lazy<string>(() => File.ReadAllText(path));
```
The argument is permanently bound to that `Lazy` instance via compiler-generated closure.

### Pattern B: Factory method / Object-owned lazy field
Used for object-level design where an instance owns its private lazy state tied to its constructor arguments:

```csharp
public sealed class TemplateFile
{
    private readonly Lazy<string> _content;

    public TemplateFile(string path)
    {
        _content = new Lazy<string>(() => File.ReadAllText(path));
    }

    public string Content => _content.Value;
}
```
Each `TemplateFile` instance manages its own lazy lifecycle. There is no shared cross-caller cache unless callers explicitly store and share the `TemplateFile` object.

### Pattern C: Keyed shared cache via ConcurrentDictionary<TKey, Lazy<TValue>>
Used for application-level shared caching where computations must be performed once per key across concurrent requests:

```csharp
var cache = new ConcurrentDictionary<int, Lazy<string>>();

string GetUserData(int userId)
{
    var lazy = cache.GetOrAdd(
        userId,
        id => new Lazy<string>(
            () => ExpensiveLoadUserData(id),
            LazyThreadSafetyMode.ExecutionAndPublication));

    return lazy.Value;
}
```
The dictionary key selects one shared `Lazy` entry. That stored `Lazy` uses `ExecutionAndPublication`, so the expensive initialization runs once for the used stored instance; other callers wait for and reuse the published result. Pattern C is a shared application-level cache / compute-once-per-key model, not merely an object-construction detail.

## What should be recallable

- When does `Lazy<T>` execute its factory?
- What does `.IsValueCreated` return after an initialization failure?
- Why is `if (_obj == null)` unsafe in multithreaded environments compared to `Lazy<T>`?
- What requirement does the parameterless `new Lazy<T>()` constructor impose on `T`?
- Why should async factories use `Lazy<Task<T>>` instead of blocking with `.Result`?
- Name the three argument-binding patterns (Closure capture, Object-owned field, Keyed ConcurrentDictionary cache).
- How does Pattern C share one expensive initialization per key across concurrent callers?

## Related knowledge

- `dotnet.lazy-thread-safety-modes-and-exception-caching` - LazyThreadSafetyMode semantics and exception caching
- `dotnet.per-key-async-single-flight` - Async single-flight caching with in-flight Lazy task cleanup

## Sources

- Workspace: `_ai-conspects/Lazy/`
- Authoritative processed source: `04-source-preserving-transcript-v002.md`, sections S-001, S-002, S-003, S-004, S-005, S-013, S-014, S-015, S-022, S-025, S-026, S-028, S-029, S-030, S-031, S-032, S-034, S-035, S-037, S-038
- Quality audit: `06-corrected-closure-audit-v002.md`
- Original SVG: `source/Lazy.svg` (Git blob SHA: 61bcdd37d8a715fb3db9736ccf87e3bd19baafdd)
