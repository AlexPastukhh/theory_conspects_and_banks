# Expression-tree members, parameters, and binary operators

Knowledge ID: `dotnet.expression-tree-members-parameters-and-binary-operators`

Topic: `dotnet`

`Expression.Property`/`PropertyOrField` builds member access over another expression. Nested paths are a chain, not one dotted member name:

```csharp
var p = Expression.Parameter(typeof(Order), "order");
Expression current = p;

foreach (var segment in "Customer.Address.City".Split('.'))
    current = Expression.PropertyOrField(current, segment);
```

When extracting a path, walk `MemberExpression.Expression` back toward the root, collect member names, then reverse them. Strip only conversions your contract expects. Nested access is not automatically null-safe. Runtime string paths are late-bound and can fail on rename or at runtime; prefer captured member metadata or typed selectors where possible.

Binary factories such as `Equal`, `GreaterThan`, `AndAlso`, and `Coalesce` require operand types compatible with that operator. Parameter identity and conversion placement determine whether the final lambda is valid:

```csharp
var user = Expression.Parameter(typeof(User), "user");
var age = Expression.Property(user, nameof(User.Age));
var limit = Expression.Constant(18);
var body = Expression.GreaterThanOrEqual(age, limit);
var lambda = Expression.Lambda<Func<User, bool>>(body, user);
```

`BinaryExpression` exposes `Left`, `Right`, optional implementing `Method`, and conversion metadata for relevant node types. User-defined operators can attach a `MethodInfo`; lifted nullable operators have additional semantics. `AndAlso`/`OrElse` short-circuit, while bitwise `And`/`Or` do not necessarily express the same logic. Lambda parameter order determines delegate argument order: renaming a node changes no semantics, but reordering the parameter list does.

Compilation proves the CLR tree can execute, not that an external query provider can translate it. Keep provider-bound trees within the supported node/operator subset and inspect generated commands.

## Sources

- Workspace: `_ai-conspects/EXPRESSION TREES/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R02-R04
- Original SVG: `source/EXPRESSION TREES.svg`
