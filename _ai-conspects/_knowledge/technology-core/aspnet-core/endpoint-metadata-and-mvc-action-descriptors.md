# Endpoint metadata and MVC action descriptors

Knowledge ID: `aspnet-core.endpoint-metadata-and-mvc-action-descriptors`

Topic: `aspnet-core`

ASP.NET Core exposes two related introspection models:

```text
Endpoint + Endpoint.Metadata
    -> unified endpoint-routing model after an endpoint is selected

ActionDescriptor / ControllerActionDescriptor
    -> MVC's selected-action model inside MVC contexts
```

Minimal APIs primarily expose `Endpoint.Metadata`. MVC controller endpoints can have both endpoint metadata and an MVC action descriptor; they are not the same object.

## MVC action information

An MVC filter receives the selected `ActionDescriptor`. Cast only when controller-specific reflection data is required:

```csharp
if (context.ActionDescriptor is ControllerActionDescriptor action)
{
    string controller = action.ControllerName;
    string methodName = action.MethodInfo.Name;
    var custom = action.MethodInfo.GetCustomAttributes(inherit: true);
}
```

The base descriptor exposes general fields such as ID/display name, route values, parameters, filter descriptors, endpoint metadata, and properties. `ControllerActionDescriptor` adds controller/action names, `ControllerTypeInfo`, and `MethodInfo`; reflection can inspect parameters, return type, and method attributes. Inside a controller, the same concrete descriptor is available through `ControllerContext.ActionDescriptor`.

## Endpoint metadata timing and sources

After routing has selected an endpoint, middleware can inspect it:

```csharp
app.UseRouting();

app.Use(async (context, next) =>
{
    Endpoint? endpoint = context.GetEndpoint();
    var authorization = endpoint?.Metadata.GetMetadata<IAuthorizeData>();
    await next(context);
});
```

Before selection there is no matched endpoint; a filter constructor also lacks the per-request filter context. Read metadata at the pipeline stage that owns the selected endpoint/action.

`Endpoint` carries a `RequestDelegate`, `DisplayName`, and ordered `EndpointMetadataCollection`. Metadata can come from attributes, framework conventions, groups, and endpoint-builder calls such as `WithMetadata`, `WithName`, `WithTags`, `RequireAuthorization`, and `Produces`. Consumers use it for authorization, CORS, filters, naming, custom behavior, and API description.

API Explorer/OpenAPI infrastructure reads route/method/parameter/response/tag metadata and API-oriented entries such as `IApiEndpointMetadata`. Minimal APIs depend directly on endpoint metadata; MVC additionally retains its action-descriptor model.

Authentication response classification can also look for `IApiEndpointMetadata` on the selected endpoint, with attributes or custom metadata as fallbacks. Depending on framework/version and endpoint style, examples can include `[ApiController]` actions, JSON minimal APIs/`TypedResults`, and SignalR endpoints. Verify the application's actual metadata rather than assuming every API-shaped endpoint carries the marker.

## Classifying selected controller endpoints for MVC policy

When a filter must choose API versus view error behavior, selected endpoint/action metadata is more reliable than assuming every descriptor is a controller action:

```csharp
if (context.ActionDescriptor.EndpointMetadata
    .OfType<ApiControllerAttribute>().Any())
    return EndpointKind.Api;

if (context.ActionDescriptor is ControllerActionDescriptor action)
{
    if (typeof(Controller).IsAssignableFrom(action.ControllerTypeInfo))
        return EndpointKind.MvcView;

    if (typeof(ControllerBase).IsAssignableFrom(action.ControllerTypeInfo))
        return EndpointKind.Api;
}
```

`[ApiController]` is a strong API signal. Controller base type and explicit application metadata are useful additional signals. `[Produces]` is only an optional heuristic: APIs may use defaults, and view endpoints can also declare media types. Razor Pages and custom MVC descriptors are reasons not to cast blindly. If the kind remains unknown, a filter-specific policy can leave it to outer middleware.

## Names and ordered lookup

`IEndpointNameMetadata` identifies an endpoint in the endpoint-routing model. `IRouteNameMetadata` represents a route name used by route/link-generation scenarios. MVC attributes may contribute both, but code should not assume the concepts are interchangeable.

Endpoint metadata is ordered. When several values of a type exist:

```csharp
T? effective = endpoint.Metadata.GetMetadata<T>();
IReadOnlyList<T> all = endpoint.Metadata.GetOrderedMetadata<T>();
```

`GetMetadata<T>()` selects the effective item according to collection order, commonly the latest/most specific matching value. `GetOrderedMetadata<T>()` returns every matching value in configured order. Group/convention metadata and endpoint-local overrides can combine; authorization, CORS, filters, and custom consumers must apply the semantics intended for that metadata type rather than assuming every type is simply last-one-wins.

## What should be recallable

- Endpoint-routing metadata versus MVC action descriptors.
- When a selected endpoint/action becomes available.
- Which reflection details require `ControllerActionDescriptor`.
- Metadata producers and API Explorer/OpenAPI consumers.
- Endpoint name versus route name.
- Effective lookup versus ordered-all lookup.

## Sources

- Workspace: `_ai-conspects/actiondescriptor-controlleractiondescriptor-endpoint-metadata-route-or-endpoint-name-iapiendpointmetadata-ordered-metadata/`
- Authoritative processed sources: `regions/AEM01-actiondescriptor-controlleractiondescriptor-mvc-filter-context.md`, `regions/AEM02-endpoint-metadata-routeendpoint-iapiendpointmetadata.md`, and `regions/AEM03-ordered-endpoint-metadata.md`
- Source preservation: regional evidence and materialized source images recorded by the workspace coverage audit
- Workspace: `_ai-conspects/AUTH EVENTS/`
- Authoritative processed source: `02-corrected-semantic-transcript-v002.md`, R03
- Original SVG: `source/AUTH EVENTS.svg`
- Workspace: `_ai-conspects/filters/`
- Authoritative processed source: `regions/R01-main-filters-theory-ordering-exception-di-factories.md`, S-046-S-049, S-054-S-057, S-060, S-063, S-067, S-071, S-077-S-078, S-082
- Original SVG: `source/filters.svg`
