# DI scope lifetime and disposal ownership

Knowledge ID: `aspnet-core.di-scope-lifetime-and-disposal`

Topic: `aspnet-core`

## A DI scope is both a resolution and disposal boundary

Scoped services belong to a scope. The scope determines both which scoped instances are reused and when container-owned disposable instances are cleaned up.

In ASP.NET Core, the request pipeline creates one scope per request. The request-scoped provider is available through `HttpContext.RequestServices`.

Controllers, Razor Pages, and factory-based middleware resolve scoped dependencies from that request scope.

Outside the request lifecycle, or when code deliberately needs a separate lifetime boundary, create a scope through `IServiceScopeFactory` and dispose that scope.

## Dispose the owner, not arbitrary resolved services

The ownership rule is:

```text
creator / owner
    -> disposes the resource

explicit ownership transfer
    -> transfers that responsibility
```

For container-created scoped services, consumers normally do not dispose each injected service manually. The container owns them through the scope.

A manually created `IServiceScope` is itself disposable. Disposing it causes the container to dispose the disposable scoped services it created in that scope.

This is why a controller normally does not call `Dispose()` on an injected scoped `DbContext`: request-scope ownership belongs to the container.

## Scope lifetime and service lifetime must agree

A scope exists to make scoped dependencies safe outside the normal request boundary as well as inside it.

Longer-lived code should not casually capture a scoped dependency and outlive its owner. Instead, create a scope for the work, resolve the scoped services inside it, finish the work, and dispose the scope.

The important model is:

```text
scope creation
-> scoped resolution
-> work while scope is alive
-> scope disposal
-> container disposes owned scoped IDisposable services
```

## What should be recallable

- What two responsibilities does a DI scope provide?
- Which scope normally owns ASP.NET Core request-scoped services?
- Where is the current request service provider exposed?
- When should `IServiceScopeFactory` be used?
- What happens when a manually created scope is disposed?
- Why should a controller not normally dispose an injected scoped `DbContext`?
- Why is ownership more important than merely seeing an `IDisposable` interface?

## Related knowledge

- `dotnet.disposable-ownership-and-deterministic-cleanup`
- `aspnet-core.options-configuration-pipeline-and-di`

## Sources

- Workspace: `_ai-conspects/scopes and idisposable/`
- Authoritative processed source: `05-stage5-corrected-source-preserving-transcript-v002.md`, R01 S-002 and S-003
- Closure evidence: `07-stage7-corrected-closure-audit-v002.md`
- Provenance caveat: `CURRENT_SOURCE_OF_TRUTH.md` records `source/scopes and idisposable.svg` and Git blob SHA `8cd3795aae0bc29337018d6fc42d57281a5c8fa8`, but that path is not physically resolvable on the current branch
- Workspace: `_ai-conspects/filters/`
- Authoritative processed source: `regions/R02R03-concrete-examples-lower-addendum-final.md`, S-123 and S-125-S-128
- Original SVG: `source/filters.svg`
