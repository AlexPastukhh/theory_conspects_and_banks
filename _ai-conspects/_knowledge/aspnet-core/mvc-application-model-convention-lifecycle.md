# MVC application-model convention lifecycle and scope

Knowledge ID: `aspnet-core.mvc-application-model-convention-lifecycle`

Topic: `aspnet-core`

ASP.NET Core MVC application-model conventions modify metadata while MVC builds its discovered model at startup. They are appropriate for static rules such as route prefixes, default filters, API Explorer visibility, naming, endpoint metadata, and binding defaults.

They are not request-time decision hooks. A rule that depends on the current user or current request belongs in authorization policies/handlers, middleware, filters, endpoint filters, model binding, or validation according to the job.

## Choose the narrowest entry point

| Convention | Model passed to `Apply` | Natural scope |
|---|---|---|
| `IApplicationModelConvention` | `ApplicationModel` | whole discovered MVC graph |
| `IControllerModelConvention` | `ControllerModel` | one controller |
| `IActionModelConvention` | `ActionModel` | one action |
| `IParameterModelConvention` | `ParameterModel` | one action parameter |

Representative declarations:

```csharp
public sealed class GlobalConvention : IApplicationModelConvention
{
    public void Apply(ApplicationModel application) { }
}

public sealed class ControllerConvention : IControllerModelConvention
{
    public void Apply(ControllerModel controller) { }
}

public sealed class ActionConvention : IActionModelConvention
{
    public void Apply(ActionModel action) { }
}

public sealed class ParameterConvention : IParameterModelConvention
{
    public void Apply(ParameterModel parameter) { }
}
```

Typical selections from the captured source are:

```text
global API prefix or metadata across the graph
    -> IApplicationModelConvention

prefix/filter/API Explorer rule based on controller namespace, type or attributes
    -> IControllerModelConvention

filter, route, constraint or API Explorer rule for selected methods
    -> IActionModelConvention

default binding metadata for parameters named id / ending in Id
    -> IParameterModelConvention
```

Some broad rules have two valid entry points. A global route prefix can be implemented by an application convention that walks controllers or by a controller convention invoked for each controller. A default filter for every action can similarly be added from the application graph or by an action convention. For selected action patterns, action scope is the natural choice; hiding an entire controller from API Explorer naturally uses controller scope, while hiding selected actions uses action scope.

A convention can see nested/outer models even when MVC invokes it at a narrow entry point. A controller convention can traverse `controller.Actions`; an action convention can inspect `action.Controller`. The interface primarily chooses the natural unit and invocation count, so use the narrowest one that expresses the rule clearly.

## Registration and invocation

Register global MVC conventions in controller options:

```csharp
builder.Services.AddControllers(options =>
{
    options.Conventions.Add(new MyControllerConvention());
    options.Conventions.Add(new MyActionConvention());
    options.Conventions.Add(new MyParameterConvention());
});
```

MVC applies them to the model objects discovered at startup:

```text
IApplicationModelConvention -> once for the ApplicationModel
IControllerModelConvention  -> once per ControllerModel
IActionModelConvention      -> once per ActionModel
IParameterModelConvention   -> once per ParameterModel
```

For an application with 3 controllers, 10 actions, and 25 parameters, those calls occur 1, 3, 10, and 25 times respectively.

A convention attribute can narrow application to one target rather than global registration:

```csharp
[MyControllerConvention]
public class ProductsController : ControllerBase
{
}
```

```text
options.Conventions -> global
convention attribute -> local controller/action/parameter target
```

For a simple one-off controller/action rule, ordinary attributes such as `[Route]`, `[Authorize]`, `[ApiExplorerSettings]`, `[Area]`, or a binding attribute may be clearer than a convention.

## Razor Pages convention family

Razor Pages uses related but separate interfaces:

| Interface | Model | Use |
|---|---|---|
| `IPageApplicationModelConvention` | `PageApplicationModel` | page-model/handler metadata |
| `IPageHandlerModelConvention` | `PageHandlerModel` | individual `OnGet`/`OnPost` handlers |
| `IPageRouteModelConvention` | `PageRouteModel` | page routes |
| `IParameterModelBaseConvention` | `ParameterModelBase` | shared controller/page parameter or property rules |
| `IPageConvention` | varies | common page route/application-model convention interface |

Changing controller discovery itself is a different concern: use application parts/providers rather than treating an ordinary application-model convention as a discovery hook.

## What should be recallable

- At what lifecycle stage do MVC application-model conventions run?
- Why should current-user logic not be implemented as a convention?
- Which interface is the natural entry point for application, controller, action, and parameter rules?
- Why can a narrow convention still access related outer/nested models?
- How many times does MVC invoke each convention type?
- How do global registration and convention attributes differ?
- Which separate interfaces cover Razor Pages?

## Related knowledge

- `aspnet-core.mvc-application-controller-and-action-models`
- `aspnet-core.mvc-parameter-selector-route-and-api-explorer-models`
- `aspnet-core.endpoint-metadata-and-mvc-action-descriptors`

## Sources

- Workspace: `_ai-conspects/conventions/`
- Authoritative processed source: `FINAL_TRANSCRIPT.md`, S-001–S-010 and S-030–S-050
- Original SVG: `source/conventions.svg`
