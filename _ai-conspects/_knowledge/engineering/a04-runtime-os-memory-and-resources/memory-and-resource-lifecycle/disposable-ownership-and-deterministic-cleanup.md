# Disposable ownership and deterministic cleanup

Knowledge ID: `dotnet.disposable-ownership-and-deterministic-cleanup`

Topic: `dotnet`

## Ownership determines cleanup responsibility

Seeing an `IDisposable` field does not by itself mean the containing class should dispose it or add a finalizer.

The useful rule is:

```text
resource creator / owner
    -> releases it

borrowed or container-owned resource
    -> consumer does not dispose it casually
```

If a class owns managed disposable wrappers such as `FileStream`, `SqlConnection`, `Stream`, or another service, it normally releases those owned wrappers from `Dispose()`.

Constructor injection alone does not prove ownership. APIs that accept an existing disposable object should document whether ownership transfers to the receiving object.

If code directly acquires unmanaged state, a different boundary applies; that ownership is covered by the unmanaged-resource and SafeHandle model.

## `IDisposable` is a deterministic cleanup contract

The interface is:

```csharp
public interface IDisposable
{
    void Dispose();
}
```

Its purpose is prompt release of external or expensive resources rather than waiting for non-deterministic GC/finalization behavior.

Typical disposable resources include:

- files and streams;
- database connections or `DbContext`;
- sockets;
- timers;
- unmanaged-memory owners;
- other owned `IDisposable` objects.

`Dispose()` releases resources. It does not directly reclaim the object's managed memory.

## Deterministic cleanup is the normal path

Typical deterministic forms are:

```csharp
using var resource = ...;
await using var asyncResource = ...;
resource.Dispose();
```

Cleanup runs at a known lifetime boundary.

Finalization is non-deterministic and is only a fallback for directly owned unmanaged resources when a safer wrapper is unavailable.

## Disposing and collecting are different events

If `Dispose()` runs, external resources are released deterministically, but the managed object may remain alive and reachable until ordinary GC rules make it collectible.

If `Dispose()` does not run, managed memory may still eventually be reclaimed. Without a finalizer or another owner wrapper, directly owned unmanaged resources can remain leaked.

The lifecycle distinction is:

```text
Dispose
    -> release owned resources now

reachability + GC
    -> reclaim managed memory later
```

A disposed object can remain reachable. Its methods should therefore follow the type's documented post-disposal behavior rather than assuming disposal destroyed the object.

## What should be recallable

- Why does ownership matter more than merely implementing or containing `IDisposable`?
- Who should normally dispose an owned resource?
- Why does constructor injection not automatically imply ownership transfer?
- What does `IDisposable.Dispose()` guarantee conceptually?
- Does `Dispose()` immediately reclaim managed memory?
- Why are `using` and `await using` preferred for deterministic cleanup?
- Can an undisposed object become unreachable and have its managed memory collected?
- How can unmanaged state still leak after managed memory becomes collectible?

## Related knowledge

- `dotnet.dispose-pattern-and-suppress-finalize`
- `dotnet.unmanaged-ownership-safehandle-and-finalizer-decisions`
- `dotnet.gc-roots-reachability-and-disposal-state`
- `aspnet-core.di-scope-lifetime-and-disposal`
- `dotnet.iterator-disposal-and-finally-cleanup`

## Sources

- Workspace: `_ai-conspects/scopes and idisposable/`
- Authoritative processed source: `05-stage5-corrected-source-preserving-transcript-v002.md`, R01 S-001, S-004, S-005 and R05 S-019, S-020
- Closure evidence: `07-stage7-corrected-closure-audit-v002.md`
- Provenance caveat: `CURRENT_SOURCE_OF_TRUTH.md` records `source/scopes and idisposable.svg` and Git blob SHA `8cd3795aae0bc29337018d6fc42d57281a5c8fa8`, but that path is not physically resolvable on the current branch
