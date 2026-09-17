# Finalizer lifecycle, costs, and failure boundaries

Knowledge ID: `dotnet.finalizer-lifecycle-costs-and-failure-boundaries`

Topic: `dotnet`

## A finalizer is a runtime fallback, not the primary cleanup API

A C# finalizer such as:

```csharp
class MyClass
{
    ~MyClass()
    {
        // unmanaged cleanup fallback
    }
}
```

exists so directly owned unmanaged resources can eventually be released when deterministic disposal was missed.

Application code does not call the finalizer. The runtime schedules it.

The primary cleanup path remains `Dispose()` or a deterministic lifetime construct such as `using`.

## Finalization adds another lifetime stage

For a finalizable object, the simplified lifecycle is:

1. The object becomes unreachable.
2. The GC recognizes that it has a finalizer.
3. The object is not reclaimed immediately and is queued for finalization.
4. The finalizer thread eventually executes the finalizer.
5. The object becomes eligible for collection again.
6. A later GC can reclaim its managed memory.

Consequences include delayed execution, undefined ordering, an additional collection cycle, and the possibility that abrupt process termination prevents the finalizer from running.

A finalizer therefore cannot be treated as an application-shutdown hook.

## Dispose and finalizer have different contracts

| Property | `Dispose()` | Finalizer |
|---|---|---|
| Initiated by | caller / deterministic lifetime | runtime |
| Timing | deterministic | non-deterministic |
| Normal role | primary cleanup | fallback |
| Error environment | controlled call path | dangerous runtime path |
| Cost | comparatively cheap | additional GC/finalizer overhead |

If deterministic cleanup succeeds, `GC.SuppressFinalize(this)` prevents the unnecessary fallback.

## Finalizers must stay minimal

Common mistakes include:

- adding a finalizer "just in case";
- placing business logic in it;
- throwing exceptions from it;
- relying on it for shutdown behavior;
- expecting it to run immediately after an object becomes unreachable.

A finalizer should be minimal, resilient, and restricted to unmanaged fallback cleanup.

## Finalizable objects cost more

Finalizable objects are tracked specially, survive at least one extra GC cycle, delay memory reclamation, and run cleanup through a single finalizer thread.

Large numbers of finalizers can increase memory pressure and turn the finalizer thread into a cleanup bottleneck.

Prefer managed wrappers or `SafeHandle` so finalization stays localized rather than spreading custom finalizers through application objects.

## What should be recallable

- Who invokes a finalizer?
- Why is finalization non-deterministic?
- What happens between first unreachability and eventual managed-memory reclamation?
- Why must finalizer ordering not be relied upon?
- Why is a finalizer not a shutdown hook?
- What is the normal relationship between `Dispose()` and finalization?
- Why are exceptions or business logic dangerous inside finalizers?
- Why do finalizable objects put more pressure on GC?
- How can the finalizer thread become a bottleneck?
- What design usually avoids custom finalizers?

## Related knowledge

- `dotnet.dispose-pattern-and-suppress-finalize`
- `dotnet.unmanaged-ownership-safehandle-and-finalizer-decisions`
- `dotnet.gc-roots-reachability-and-disposal-state`
- `dotnet.allocations-gc-pressure-and-hot-paths`

## Sources

- Workspace: `_ai-conspects/scopes and idisposable/`
- Authoritative processed source: `05-stage5-corrected-source-preserving-transcript-v002.md`, R03 S-008 through S-013
- Closure evidence: `07-stage7-corrected-closure-audit-v002.md`
- Provenance caveat: `CURRENT_SOURCE_OF_TRUTH.md` records `source/scopes and idisposable.svg` and Git blob SHA `8cd3795aae0bc29337018d6fc42d57281a5c8fa8`, but that path is not physically resolvable on the current branch
