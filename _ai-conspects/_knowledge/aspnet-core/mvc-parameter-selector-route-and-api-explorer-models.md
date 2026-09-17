# MVC parameter, selector, route, and API Explorer models

Knowledge ID: `aspnet-core.mvc-parameter-selector-route-and-api-explorer-models`

Topic: `aspnet-core`

The lower parts of MVC's startup application model describe binding targets, endpoint selection, attribute routes, and API documentation metadata. Conventions configure these objects before requests arrive; they do not perform binding, validation, or business logic themselves.

## Parameters, parameter-like models, and properties

`ParameterModel` represents one action parameter:

```csharp
parameter.Action
parameter.Attributes
parameter.BindingInfo
parameter.DisplayName
parameter.Name
parameter.ParameterInfo
parameter.ParameterName
parameter.ParameterType
parameter.Properties
```

It lets a convention inspect the parameter name/type/attributes and set binder source, binder type, binder name, or custom metadata. A route-binding default can be expressed as:

```csharp
public void Apply(ParameterModel parameter)
{
    if (parameter.ParameterType == typeof(CancellationToken))
    {
        return;
    }

    if (parameter.ParameterName?.EndsWith("Id") == true)
    {
        parameter.BindingInfo ??= new BindingInfo();
        parameter.BindingInfo.BindingSource = BindingSource.Path;
    }
}
```

This configures where later binding should look; validation still happens after binding through validation/filter mechanisms.

The focused `id` convention from the source is:

```csharp
public void Apply(ParameterModel parameter)
{
    if (parameter.ParameterName == "id")
    {
        parameter.BindingInfo ??= new BindingInfo();
        parameter.BindingInfo.BindingSource = BindingSource.Path;
    }
}
```

`ParameterModelBase` is the shared base for parameter-like and property-like models. Its common surface is:

```csharp
model.BindingInfo
model.Name
model.ParameterType
model.Properties
```

It supports one convention across MVC and Razor Pages parameter/property shapes. `PropertyModel` represents a bindable controller property and adds property reflection information. Constructor injection, action parameters, or ordinary input models are usually clearer than controller-property binding unless that feature is deliberate.

## Selection and endpoint metadata

`SelectorModel` describes how a controller/action can be selected:

```csharp
selector.AttributeRouteModel
selector.ActionConstraints
selector.EndpointMetadata
```

A convention can change attribute routes, add action constraints, or attach endpoint metadata:

```csharp
foreach (var selector in action.Selectors)
{
    selector.EndpointMetadata.Add(new MyCustomMetadata());
}
```

This model concerns routing, HTTP-method/action selection, and metadata—not business logic.

`AttributeRouteModel` represents an attribute route and exposes:

```csharp
route.Template
route.Name
route.Order
route.SuppressLinkGeneration
route.SuppressPathMatching
AttributeRouteModel.CombineAttributeRouteModel(...)
```

Prefixing composes a new controller prefix with each existing action/controller route:

```csharp
var prefix = new AttributeRouteModel(
    new RouteAttribute("api/v1"));

selector.AttributeRouteModel =
    AttributeRouteModel.CombineAttributeRouteModel(
        prefix,
        selector.AttributeRouteModel);
```

Conventions fit application-wide prefix/normalization/version rules. A simple local route is often clearer as `[Route]`, `[HttpGet]`, a route group, or direct endpoint-routing configuration.

## API Explorer and binding metadata

`ApiExplorerModel` provides the startup metadata consumed by API Explorer and Swagger/OpenAPI tooling:

```csharp
apiExplorer.IsVisible
apiExplorer.GroupName
```

```csharp
action.ApiExplorer.IsVisible = false;
action.ApiExplorer.GroupName = "internal";
```

Use it to hide endpoints or group/version generated documentation. For one controller or action, `[ApiExplorerSettings(IgnoreApi = true, GroupName = "...")]` can be clearer.

`BindingInfo` contains binding metadata:

```csharp
bindingInfo.BinderModelName
bindingInfo.BinderType
bindingInfo.BindingSource
bindingInfo.EmptyBodyBehavior
bindingInfo.PropertyFilterProvider
bindingInfo.RequestPredicate
```

A convention can set a query default:

```csharp
parameter.BindingInfo ??= new BindingInfo();
parameter.BindingInfo.BindingSource = BindingSource.Query;
```

Use `[FromRoute]`, `[FromQuery]`, `[FromBody]`, `[FromHeader]`, or `[ModelBinder]` for a one-parameter declaration. Implement `IModelBinder`/`IModelBinderProvider` for actual custom binding. A parameter convention supplies metadata; it does not execute the binder.

## What should be recallable

- Which reflection and binding members are exposed by `ParameterModel`?
- Why is a parameter convention different from validation or binding execution?
- What common contract does `ParameterModelBase` provide?
- When is `PropertyModel` relevant, and why is controller-property binding often avoidable?
- Which three concerns are represented by `SelectorModel`?
- How does `AttributeRouteModel.CombineAttributeRouteModel` preserve an existing route while adding a prefix?
- Which fields control API Explorer visibility/grouping?
- Which `BindingInfo` members describe source, binder, body, property-filter, and request-predicate behavior?

## Related knowledge

- `aspnet-core.mvc-application-model-convention-lifecycle`
- `aspnet-core.mvc-application-controller-and-action-models`
- `aspnet-core.action-parameter-binding-sources`
- `aspnet-core.endpoint-metadata-and-mvc-action-descriptors`

## Sources

- Workspace: `_ai-conspects/conventions/`
- Authoritative processed source: `FINAL_TRANSCRIPT.md`, S-017–S-029 and S-041–S-044
- Original SVG: `source/conventions.svg`
