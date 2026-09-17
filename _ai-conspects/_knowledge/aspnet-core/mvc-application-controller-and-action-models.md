# MVC ApplicationModel, ControllerModel, and ActionModel

Knowledge ID: `aspnet-core.mvc-application-controller-and-action-models`

Topic: `aspnet-core`

MVC constructs a startup-time object graph that conventions can inspect and change:

```text
ApplicationModel
└── ControllerModel
    └── ActionModel
        └── ParameterModel
```

These are metadata models, not the current `HttpContext` and not the runtime action invocation.

## `ApplicationModel`

`ApplicationModel` represents the whole discovered MVC application. Its central members are:

```csharp
application.Controllers
application.Filters
application.Properties
```

It is the entry point for walking every controller/action/parameter, adding global filters, comparing several controllers or actions, and storing global custom metadata. Application-wide prefixes, metadata, and naming rules naturally fit this scope.

```csharp
public void Apply(ApplicationModel application)
{
    foreach (var controller in application.Controllers)
    {
        // Apply an application-wide metadata rule.
    }
}
```

## `ControllerModel`

`ControllerModel` represents one controller class. The captured model surface includes:

```csharp
controller.Actions
controller.ApiExplorer
controller.Application
controller.Attributes
controller.ControllerName
controller.ControllerProperties
controller.ControllerType
controller.DisplayName
controller.Filters
controller.Properties
controller.RouteValues
controller.Selectors
```

That surface supports renaming a controller, modifying controller-level route selectors, adding/removing filters, changing API Explorer visibility/grouping, inspecting attributes/type, adding metadata, and traversing its actions.

A controller-wide rule based on class metadata can be concise:

```csharp
public void Apply(ControllerModel controller)
{
    if (controller.ControllerType.Namespace?.Contains(".Admin.") == true)
    {
        controller.Filters.Add(new AuthorizeFilter("AdminOnly"));
    }
}
```

This attaches a configured policy/filter at startup; it does not make the convention a place for per-request authorization decisions.

A route prefix can be combined with every controller selector:

```csharp
public void Apply(ControllerModel controller)
{
    foreach (var selector in controller.Selectors)
    {
        selector.AttributeRouteModel =
            AttributeRouteModel.CombineAttributeRouteModel(
                new AttributeRouteModel(
                    new RouteAttribute("api/v1")),
                selector.AttributeRouteModel);
    }
}
```

Use a controller convention for rules based on namespace, type, or controller attributes. Prefer a local `[Route]`, `[Authorize]`, `[ApiExplorerSettings]`, or `[Area]` when only one controller needs the behavior.

## `ActionModel`

`ActionModel` represents one discovered action method. Its captured surface includes:

```csharp
action.ActionMethod
action.ActionName
action.ApiExplorer
action.Attributes
action.Controller
action.DisplayName
action.Filters
action.Parameters
action.Properties
action.RouteParameterTransformer
action.RouteValues
action.Selectors
```

It supports renaming actions, inspecting parameters and method attributes, adding filters or action descriptor metadata, modifying route selectors, changing API Explorer visibility, and configuring a route token transformer.

For example, a static rule can attach antiforgery validation to discovered POST actions:

```csharp
public void Apply(ActionModel action)
{
    if (action.Attributes.OfType<HttpPostAttribute>().Any())
    {
        action.Filters.Add(new ValidateAntiForgeryTokenAttribute());
    }
}
```

Or a convention can hide a name pattern from API Explorer:

```csharp
public void Apply(ActionModel action)
{
    if (action.ActionName.StartsWith("Internal"))
    {
        action.ApiExplorer.IsVisible = false;
    }
}
```

Use action conventions for metadata rules about methods. Runtime behavior before/after action execution belongs in filters; simple routes normally remain attributes; Minimal API endpoint metadata belongs on endpoint route builders.

## What should be recallable

- How are `ApplicationModel`, `ControllerModel`, and `ActionModel` related?
- Which members let an application convention traverse the whole MVC graph?
- Which controller members expose routes, filters, API Explorer, properties, type, and actions?
- Which action members expose method, parameters, routes, filters, and metadata?
- Why does adding an authorization filter at startup differ from making a request-time authorization decision?
- When is a local attribute clearer than a model convention?

## Related knowledge

- `aspnet-core.mvc-application-model-convention-lifecycle`
- `aspnet-core.mvc-parameter-selector-route-and-api-explorer-models`
- `aspnet-core.endpoint-metadata-and-mvc-action-descriptors`

## Sources

- Workspace: `_ai-conspects/conventions/`
- Authoritative processed source: `FINAL_TRANSCRIPT.md`, S-011–S-016 and S-030–S-040
- Original SVG: `source/conventions.svg`
