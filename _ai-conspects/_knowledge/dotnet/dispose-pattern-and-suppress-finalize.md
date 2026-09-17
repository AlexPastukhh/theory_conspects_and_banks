# Dispose pattern and SuppressFinalize

Knowledge ID: `dotnet.dispose-pattern-and-suppress-finalize`

Topic: `dotnet`

## Shared cleanup keeps deterministic and finalizer paths consistent

When a type requires both deterministic disposal and a finalizer fallback, the traditional pattern routes both paths through one idempotent cleanup implementation:

```csharp
public void Dispose()
{
    Dispose(true);
    GC.SuppressFinalize(this);
}

protected virtual void Dispose(bool disposing)
{
    if (_disposed)
        return;

    if (disposing)
    {
        _stream?.Dispose();
    }

    // release directly owned unmanaged state here

    _disposed = true;
}

~MyResource()
{
    Dispose(false);
}
```

The `_disposed` guard prevents repeated cleanup from double-releasing the same state.

## `disposing` separates managed cleanup from finalizer-safe cleanup

`Dispose(true)` is the deterministic path. It may dispose owned managed collaborators and release unmanaged state.

`Dispose(false)` is the finalizer path. It must not rely on managed collaborators still being usable; it releases only directly owned unmanaged state that is safe to release during finalization.

The boolean therefore represents which cleanup environment is available, not merely whether cleanup should happen.

## Successful disposal suppresses the fallback

If the type has a finalizer and deterministic cleanup completed, call:

```csharp
GC.SuppressFinalize(this);
```

This prevents an unnecessary later finalization pass for the same object.

Without suppression, the finalizer may still be scheduled even though deterministic cleanup already released the resource.

## Do not infer ownership from the pattern alone

A field such as an injected `Stream` can appear in a Dispose-pattern example, but an actual API still needs an ownership contract.

If the type borrows the stream rather than owns it, deterministic cleanup must not dispose the borrowed object just because the implementation uses `Dispose(bool)`.

The pattern coordinates cleanup paths; it does not decide ownership.

## What should be recallable

- Why should `Dispose()` and a finalizer share one cleanup implementation?
- What problem does an idempotent `_disposed` guard solve?
- What may `Dispose(true)` clean up?
- Why must `Dispose(false)` avoid relying on managed collaborators?
- When should `GC.SuppressFinalize(this)` be called?
- What does suppression change?
- Why does the canonical pattern not prove ownership of constructor-injected disposables?

## Related knowledge

- `dotnet.disposable-ownership-and-deterministic-cleanup`
- `dotnet.finalizer-lifecycle-costs-and-failure-boundaries`
- `dotnet.unmanaged-ownership-safehandle-and-finalizer-decisions`

## Sources

- Workspace: `_ai-conspects/scopes and idisposable/`
- Authoritative processed source: `05-stage5-corrected-source-preserving-transcript-v002.md`, R02 S-006/S-007 and R05 S-021
- Closure evidence: `07-stage7-corrected-closure-audit-v002.md`
- Provenance caveat: `CURRENT_SOURCE_OF_TRUTH.md` records `source/scopes and idisposable.svg` and Git blob SHA `8cd3795aae0bc29337018d6fc42d57281a5c8fa8`, but that path is not physically resolvable on the current branch
