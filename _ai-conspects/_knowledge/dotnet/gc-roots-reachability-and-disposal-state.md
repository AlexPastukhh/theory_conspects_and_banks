# GC roots, reachability, and disposal state

Knowledge ID: `dotnet.gc-roots-reachability-and-disposal-state`

Topic: `dotnet`

## Reachability is defined by paths from GC roots

An object is unreachable when the GC can no longer find any reference path from a GC root to that object.

Typical root categories include:

- locals and parameters on active stack frames;
- static fields;
- CPU registers;
- runtime or interop GC handles;
- objects referenced by live threads.

If any root can reach an object through a reference path, the object remains reachable.

## Disposal does not control reachability

Disposal state and GC reachability are independent dimensions.

```text
disposed + reachable
    -> resources released, object still referenced

undisposed + unreachable
    -> object may become collectible; external resources still require the correct owner/fallback
```

Calling `Dispose()` does not remove references and does not immediately free the object's managed memory.

Likewise, becoming unreachable does not prove that deterministic resource cleanup occurred.

This is why managed-memory collection and resource-lifetime management must not be treated as the same mechanism.

## Finalization interacts with reachability but does not replace it

A finalizable object has an additional runtime stage after becoming unreachable: it is queued for finalization before ordinary managed-memory reclamation can finish.

That mechanism protects directly owned unmanaged resources only as a fallback. It does not make disposal and reachability equivalent.

## What should be recallable

- What precisely makes an object unreachable?
- Which objects or runtime structures can act as GC roots?
- Does `Dispose()` remove references to an object?
- Can a disposed object remain reachable?
- Can an undisposed object become unreachable?
- Why are resource cleanup and managed-memory reclamation separate concerns?
- How does a finalizer add an extra lifetime stage after unreachability?

## Related knowledge

- `dotnet.disposable-ownership-and-deterministic-cleanup`
- `dotnet.finalizer-lifecycle-costs-and-failure-boundaries`
- `dotnet.conditionalweaktable-lifetime-associations`

## Sources

- Workspace: `_ai-conspects/scopes and idisposable/`
- Authoritative processed source: `05-stage5-corrected-source-preserving-transcript-v002.md`, R05 S-022 with lifecycle context from S-019/S-020
- Closure evidence: `07-stage7-corrected-closure-audit-v002.md`
- Provenance caveat: `CURRENT_SOURCE_OF_TRUTH.md` records `source/scopes and idisposable.svg` and Git blob SHA `8cd3795aae0bc29337018d6fc42d57281a5c8fa8`, but that path is not physically resolvable on the current branch
