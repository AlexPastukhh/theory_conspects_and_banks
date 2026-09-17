# Expression-tree structure and visitors

Knowledge ID: `dotnet.expression-tree-structure-and-visitors`

Topic: `dotnet`

An `Expression<TDelegate>` represents a lambda as data. Its `Parameters` retain the exact `ParameterExpression` nodes and its `Body` is a tree of typed expression nodes. Compiling turns supported tree data into executable delegate behavior; inspecting/translating keeps it as structure.

```csharp
Expression<Func<User, bool>> predicate = user => user.Age >= 18;

var parameter = predicate.Parameters.Single();
var binary = (BinaryExpression)predicate.Body;
var member = (MemberExpression)binary.Left;
var constant = (ConstantExpression)binary.Right;
```

Inspect `NodeType`, `Type`, and the concrete node class rather than parsing `ToString()`. Compiler-inserted `Convert`/`ConvertChecked` nodes can wrap an operand, so helper code often strips known conversions before looking for a member or constant. Reuse the same `ParameterExpression` instance throughout a constructed lambda; another node with the same name/type is not the same parameter binding.

Common leaf operations are `Constant`, `Parameter`, and `Default`. `MemberAccess`, `Call`, and `Convert` read/invoke/convert; `New`, `MemberInit`, and `NewArrayInit` construct values; `Conditional` is ternary logic. Arithmetic/comparison, `AndAlso`/`OrElse`, `Coalesce`, `Assign`, and blocks expose different concrete child shapes. Expression trees do not represent every modern C# feature, and compiler lowering may differ from the apparent source syntax.

`ExpressionVisitor` provides recursive traversal and immutable rewriting. Override focused visit methods, call `Visit` for children, and return the original node when children are unchanged to preserve sharing. Visitors power query translation, dynamic predicates, rule analysis, instrumentation, and serializers, but every consumer supports only a subset of node kinds.

## Sources

- Workspace: `_ai-conspects/EXPRESSION TREES/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R01 and R04
- Original SVG: `source/EXPRESSION TREES.svg`
