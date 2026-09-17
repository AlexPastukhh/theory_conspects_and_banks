# Expression-tree method calls and provider boundaries

Knowledge ID: `dotnet.expression-tree-method-calls-and-provider-boundaries`

Topic: `dotnet`

A `MethodCallExpression` separates the receiver from arguments. For an instance method, `Object` is the receiver; for a static method it is null. Extension methods are static calls whose first argument is the apparent receiver.

```csharp
var text = Expression.Parameter(typeof(string), "text");
var startsWith = typeof(string).GetMethod(
    nameof(string.StartsWith),
    new[] { typeof(string), typeof(StringComparison) })!;

var call = Expression.Call(
    text,
    startsWith,
    Expression.Constant("pre"),
    Expression.Constant(StringComparison.Ordinal));

var lambda = Expression.Lambda<Func<string, bool>>(call, text);
```

Resolve the exact overload: name alone is ambiguous, and parameter types, generic arity, static/instance form, and closed generic arguments are part of the call contract. For generic definitions, select the intended definition and close it with `MakeGenericMethod` before constructing the call.

To deconstruct a call, inspect `Method`, `Object`, and `Arguments`; do not assume argument zero is always the receiver. Rewriting a call must preserve the chosen `MethodInfo` and compatible result type.

An in-memory compiled delegate can invoke any accessible CLR method. Query providers translate only recognized calls. A custom helper or even an overload with a comparer may fail translation; keep provider expressions to supported methods or map explicit database functions, then cross to client evaluation deliberately.

## Sources

- Workspace: `_ai-conspects/EXPRESSION TREES/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R05
- Original SVG: `source/EXPRESSION TREES.svg`
