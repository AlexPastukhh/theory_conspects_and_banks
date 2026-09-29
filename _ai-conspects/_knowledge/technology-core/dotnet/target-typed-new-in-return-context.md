# Target-typed new in return expressions

Knowledge ID: `dotnet.target-typed-new-in-return-context`

Topic: `dotnet`

When the expected type is unambiguous, C# can infer the constructed type for `new(...)`. In a method returning `ValueTask<InterceptionResult<int>>`:

```csharp
return new(
    InterceptionResult<int>.SuppressWithResult(0)
);
```

is equivalent to:

```csharp
return new ValueTask<InterceptionResult<int>>(
    InterceptionResult<int>.SuppressWithResult(0)
);
```

The return context supplies the outer constructed type. Normal constructor-overload resolution still chooses a constructor from the argument.

In this EF Core interceptor example, `SuppressWithResult(0)` creates an `InterceptionResult<int>` that suppresses the normal save and supplies zero as the result. Because that result is already available, the method returns a completed `ValueTask` directly; no `async` state machine is needed.

Target-typed construction also works in variable declarations, property initializers, argument positions, and other return expressions with a clear expected type. Prefer the abbreviation when the type remains obvious; write the explicit type when context is distant, nested generics reduce readability, or overload behavior should be visible.

## What should be recallable

- How the compiler derives the constructed type from a return context.
- What the abbreviated and explicit `ValueTask<InterceptionResult<int>>` forms mean.
- Why `SuppressWithResult(0)` avoids the save and why no async state machine is required.
- Where target-typed `new` works and when explicit construction is clearer.

## Sources

- Workspace: `_ai-conspects/return new ()/`
- Processed source: `03-full-combined-final-transcript.md`, complete transcript
- Original SVG: `source/return new ().svg`
