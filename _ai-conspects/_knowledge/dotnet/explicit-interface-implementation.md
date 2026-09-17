# Explicit interface implementation

Knowledge ID: `dotnet.explicit-interface-implementation`

Topic: `dotnet`

An explicit member uses a qualified name such as `void IDisposable.Dispose()` and has no access modifier. It is absent from the concrete type's ordinary public surface but callable through an interface-typed reference; the cast changes the dispatch view, not the object.

Use it when an operation belongs only to a secondary/framework contract, names collide, or two interfaces require different behavior:

```csharp
sealed class Processor : IReader, IWriter
{
    void IReader.Execute() => Read();
    void IWriter.Execute() => Write();
}
```

It can override a default interface slot or present role-specific capabilities through DI. A collection may keep invariant-preserving domain methods public while implementing advanced collection members explicitly, but throwing from required members can violate expectations; an adapter may be clearer.

Use implicit implementation when the operation is natural and discoverable on the concrete type. When both views need it, put logic in one public method and forward the explicit member. Explicit implementation changes discoverability, not security or accessibility to interface holders; prefer composition when one class accumulates unrelated roles.

## Sources
- Workspace: `_ai-conspects/explicit interface inplementation/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript

