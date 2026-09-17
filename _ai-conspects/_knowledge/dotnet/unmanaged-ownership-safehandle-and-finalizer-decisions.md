# Unmanaged ownership, SafeHandle, and finalizer decisions

Knowledge ID: `dotnet.unmanaged-ownership-safehandle-and-finalizer-decisions`

Topic: `dotnet`

## Direct ownership follows the acquisition/release contract

Unmanaged resources live outside ordinary GC-managed memory and require an explicit release operation.

Examples include:

- OS handles;
- native memory;
- native pointers or library objects;
- low-level socket/device handles;
- GPU/native buffers.

Direct ownership exists when code acquires the native resource and is responsible for the matching release.

Examples:

```text
Marshal.AllocHGlobal
    -> FreeHGlobal

P/Invoke raw handle
    -> matching Close

native pointer/object
    -> matching Free / Release

GPU-created buffer
    -> matching native destruction
```

Ownership follows that acquire/release pair rather than the fact that some field eventually refers to native state.

## Managed wrappers already own their native state

`FileStream`, `SqlConnection`, and SafeHandle-based wrappers can encapsulate native resources and already provide the cleanup/finalization boundary.

A class that merely owns such a managed wrapper normally disposes the wrapper. It does not duplicate the native release logic or add another finalizer merely because the wrapper contains a native handle.

## Custom finalizers are a last resort

A custom finalizer is justified only when all of these are true:

- the object directly owns unmanaged resources;
- no suitable managed wrapper or `SafeHandle` is available;
- a fallback is required if callers miss deterministic disposal.

Do not add a custom finalizer merely because the class contains managed `IDisposable` objects.

Preferred order:

```text
existing managed wrapper
-> custom SafeHandle when a native handle needs wrapping
-> owning-object finalizer only as a last resort
```

## SafeHandle localizes native ownership

A representative pattern is:

```csharp
internal sealed class MySafeHandle
    : SafeHandleZeroOrMinusOneIsInvalid
{
    private MySafeHandle()
        : base(true)
    {
    }

    protected override bool ReleaseHandle()
    {
        return CloseHandle(handle);
    }

    [DllImport("kernel32.dll")]
    private static extern bool CloseHandle(IntPtr h);
}
```

`base(true)` states that the SafeHandle owns the native handle.

`ReleaseHandle()` performs the matching native release.

The wrapper centralizes ownership and runtime fallback behavior, so consuming classes usually need only deterministic disposal of the SafeHandle rather than their own repeated finalizer logic.

## What should be recallable

- What distinguishes unmanaged state from managed memory?
- What establishes direct unmanaged ownership?
- Why must every acquisition have a known matching release?
- Why does a `FileStream` field not imply that the containing class needs a finalizer?
- Under which conditions is a custom finalizer justified?
- What is the preferred order between managed wrappers, SafeHandle, and custom finalizers?
- What does `base(true)` mean in a SafeHandle subclass?
- Which method releases the native handle?
- Why does SafeHandle reduce the need for finalizers in consuming classes?

## Related knowledge

- `dotnet.disposable-ownership-and-deterministic-cleanup`
- `dotnet.dispose-pattern-and-suppress-finalize`
- `dotnet.finalizer-lifecycle-costs-and-failure-boundaries`
- `dotnet.csharp-pointers-pinning-and-alternatives`
- `dotnet.unmanaged-size-and-struct-layout`

## Sources

- Workspace: `_ai-conspects/scopes and idisposable/`
- Authoritative processed source: `05-stage5-corrected-source-preserving-transcript-v002.md`, R04 S-014 through S-016 and S-018
- Closure evidence: `07-stage7-corrected-closure-audit-v002.md`
- Provenance caveat: `CURRENT_SOURCE_OF_TRUTH.md` records `source/scopes and idisposable.svg` and Git blob SHA `8cd3795aae0bc29337018d6fc42d57281a5c8fa8`, but that path is not physically resolvable on the current branch
