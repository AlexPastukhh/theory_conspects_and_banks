# MemberNotNull nullable-flow contracts

Knowledge ID: `dotnet.membernotnull-flow-contracts`

Topic: `dotnet`

`[MemberNotNull(nameof(Member))]` tells nullable flow analysis that a helper establishes the named member when it returns normally. It can name several members. It performs no runtime check, so a method that fails to establish the promise lies to the compiler.

```csharp
private Dictionary<string, int> _dict = null!;

[MemberNotNull(nameof(_dict))]
private void Initialize() => _dict = new();
```

`null!` suppresses the declaration warning but does not initialize anything. After the annotated call, constructors/later code treat the member as non-null. If the method throws, there is no normally returned post-state.

For conditional initialization use `[MemberNotNullWhen(true, nameof(_value))]`; after a true result the member is known non-null. Prefer direct constructor assignment when possible, `required`/constructor parameters for caller-supplied state, and these attributes only for precise delegated postconditions.

## Sources

- Workspace: `_ai-conspects/membernotnull attribute,NULL/`
- Processed source: `01-final-transcript.md`, complete transcript
