# MVC filter activation, DI, and factories

Knowledge ID: `aspnet-core.mvc-filter-activation-di-and-factories`

Topic: `aspnet-core`

Filter placement and filter creation are separate decisions. Global/controller/action scope says where a filter applies; plain attributes, DI registration, `TypeFilter`, `ServiceFilter`, and `IFilterFactory` say how the instance and its dependencies are obtained.

## Global registration

Adding a type lets MVC resolve it through DI; adding an already-created instance does not perform constructor injection:

```csharp
builder.Services.AddControllers(options =>
{
    options.Filters.Add<TimingActionFilter>();
    options.Filters.Add(new HeaderFilter("X-App"));
});
```

Both are global MVC filters, but their construction and lifetime behavior differ.

## Plain filter attributes

A filter attribute is convenient for constant metadata and simple behavior:

```csharp
public sealed class AuditAttribute : ActionFilterAttribute
{
    public AuditAttribute(string operation) => Operation = operation;
    public string Operation { get; }
}

[Audit("Orders.Read")]
public IActionResult Get() => Ok();
```

Attribute constructor arguments and settable attribute properties must be valid compile-time attribute values. The runtime creates the attribute from endpoint metadata rather than treating it as a normal per-request DI object. Do not capture scoped services or mutable per-request state in its fields. `HttpContext.RequestServices` can resolve a service inside a callback, but service-location is less explicit and less testable than constructor injection.

## `TypeFilter` and `ServiceFilter`

`TypeFilterAttribute` uses an object factory to create the filter and resolves constructor services. It does not require the filter type itself to be registered. Its `Arguments` can supply extra constant constructor values:

```csharp
[TypeFilter(
    typeof(RequirePermissionFilter),
    Arguments = new object[] { "Orders.Read" },
    Order = 5)]
public IActionResult Get() => Ok();
```

`Arguments` is weakly typed, positional, awkward to discover, and still cannot contain runtime values.

`ServiceFilterAttribute` asks DI for an already-registered filter and therefore respects that registration's lifetime:

```csharp
builder.Services.AddScoped<AuditFilter>();

[ServiceFilter(typeof(AuditFilter), Order = 5)]
public IActionResult Save() => Ok();
```

It has no arbitrary `Arguments` mechanism. Both wrappers can attach a type implementing any applicable MVC filter interface; the implemented interface still determines the stage.

## A custom `IFilterFactory`

Use a factory attribute when constant endpoint metadata, runtime services, request-time creation, and custom construction logic must coexist:

```csharp
[AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]
public sealed class RequirePermissionAttribute : Attribute, IFilterFactory
{
    public RequirePermissionAttribute(string permission)
        => Permission = permission;

    public string Permission { get; }
    public bool IsReusable => false;

    public IFilterMetadata CreateInstance(IServiceProvider services)
        => new RequirePermissionFilter(
            services.GetRequiredService<IPermissionService>(),
            Permission);
}
```

The attribute retains immutable metadata; the created filter owns service-backed behavior. `IsReusable = false` avoids promising that the runtime may safely reuse the created filter beyond the intended activation boundary.

## Ordering belongs to the registration path

`TypeFilterAttribute` and `ServiceFilterAttribute` already expose `Order`; the underlying class does not also need `IOrderedFilter` unless it is registered another way or needs a consistent default. Use class-level `IOrderedFilter` for global/by-type registration with a stable order; use wrapper-level `Order` when each application needs a different value.

## Selection table

| Mechanism | Constructor DI | Extra attribute values | Lifetime/custom creation |
|---|---:|---:|---|
| Plain attribute | no | compile-time constants/properties | runtime metadata instance |
| Global by type | yes | no attribute arguments | DI-based activation |
| `TypeFilter` | yes | weakly typed `Arguments` | object-factory activation |
| `ServiceFilter` | yes | no | registered DI lifetime |
| `IFilterFactory` attribute | yes | strongly named constant metadata | custom request-time creation |

## What should be recallable

- Why application scope is different from DI lifetime.
- How global by-type and by-instance registration differ.
- Why a plain attribute must not retain scoped services/state.
- The exact creation and argument differences between `TypeFilter` and `ServiceFilter`.
- When `IFilterFactory` is the cleanest boundary.
- Whether order belongs on the wrapper or the filter class.

## Related knowledge

- `aspnet-core.mvc-filter-pipeline-stages-and-ordering`
- `aspnet-core.di-scope-lifetime-and-disposal`

## Sources

- Workspace: `_ai-conspects/filters/`
- Authoritative processed sources: `regions/R01-main-filters-theory-ordering-exception-di-factories.md`, S-021-S-022, S-026, S-029, S-034-S-037, S-040-S-043, S-048, S-050, S-061, S-065, S-075, S-081, S-086, S-088, S-091, S-093; `regions/R02R03-concrete-examples-lower-addendum-final.md`, S-118-S-120; and matching native text in `NATIVE_CANVAS_TEXT.md`
- Integrated source: `FINAL_TRANSCRIPT.md`, sections 4-5
- Original SVG: `source/filters.svg`
