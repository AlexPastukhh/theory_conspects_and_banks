# Service injection and request context in Razor views

Knowledge ID: `aspnet-core.razor-service-injection`

Topic: `aspnet-core`

## Core model

`@inject` gives a Razor view a service from ASP.NET Core dependency injection, analogous to constructor injection for the view.

```cshtml
@inject Microsoft.AspNetCore.Antiforgery.IAntiforgery Antiforgery
@inject ILogger<MyView> Logger
```

Any registered service can be injected, but views should normally depend only on small presentation-oriented services such as formatters, localization, antiforgery helpers, or feature flags.

Razor MVC views already expose the current request and principal:

```cshtml
<p>Path: @Context.Request.Path</p>

@if (User.Identity?.IsAuthenticated == true)
{
    <p>Hello @User.Identity.Name</p>
}
```

`Context` is the current `HttpContext`; `User` is `HttpContext.User`. Consequently, `IHttpContextAccessor` is rarely necessary inside a view.

Database queries and complex data preparation in the view are design smells. Perform them in a controller, application service, view component, or prepared view model.

## What should be recallable

- What does `@inject` do in a Razor view?
- Which services are appropriate presentation dependencies?
- What do `Context` and `User` refer to?
- Why is `IHttpContextAccessor` usually unnecessary in a view?
- Where should complex data access and preparation occur?

## Related knowledge

- `aspnet-core.razor-presentation-security-boundary` — display decisions versus actual enforcement.

## Sources

- Workspace: `_ai-conspects/injecting into razor/`
- Processed source: `FINAL_TRANSCRIPT.md`, S-001 and S-002 plus the data-access boundary in S-003
- Original SVG: `source/injecting into razor.svg`
