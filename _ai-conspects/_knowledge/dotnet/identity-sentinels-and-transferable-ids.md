# .NET identity sentinels and transferable IDs

Knowledge ID: `dotnet.identity-sentinels-and-transferable-ids`

Topic: `dotnet`

.NET has no direct JavaScript Symbol primitive. Choose by identity boundary: a private `static readonly object` is a process-local reference sentinel, `Guid.NewGuid()` is serializable probabilistically unique data for storage/network boundaries, and an enum is a closed named numeric set rather than a fresh unique marker.

```csharp
private static readonly object MissingValue = new();

if (ReferenceEquals(value, MissingValue))
{
    // Handle sentinel.
}
```

Type initialization safely publishes the shared readonly reference. `readonly` prevents field reassignment, not mutation of the referenced object, so a sentinel should carry no mutable state. Keep internal markers private; for a public protocol prefer a typed token or dedicated result/union type. A public sentinel can be reused by any holder, and GUIDs are forgeable data rather than property-key primitives.

## Sources
- Workspace: `_ai-conspects/symbol/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
