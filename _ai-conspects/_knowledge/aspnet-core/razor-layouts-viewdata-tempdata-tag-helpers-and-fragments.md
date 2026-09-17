# Razor layouts, ViewData, TempData, tag helpers, and reusable view fragments

Knowledge ID: `aspnet-core.razor-layouts-viewdata-tempdata-tag-helpers-and-fragments`

Topic: `aspnet-core`

A Razor MVC page is usually composed of a controller action, a strongly typed model or view model, a view template, and reusable layout or fragment pieces. The central model is: controller chooses data, view decides presentation, and view infrastructure provides the common shell, forms, validation, and short-lived UI state.

```text
request -> controller action -> view model -> Razor view -> layout / partial / component
```

The layout and folder conventions provide a default structure, while Tag Helpers keep markup HTML-like without losing the MVC metadata that powers routing, validation, and form generation.

## Layouts, `_ViewStart`, and `_ViewImports`

MVC views usually live under the controller-specific folder pattern:

```text
Views/{Controller}/{Action}.cshtml
Views/Shared/{Action}.cshtml
```

A layout sits in the shared folder and defines the page shell:

```text
Views/Shared/_Layout.cshtml
```

`_ViewStart.cshtml` runs before a view and can set the default layout for a folder tree, while `_ViewImports.cshtml` centralizes common directives such as namespaces and Tag Helper registration:

```cshtml
@using MyApp.Models
@addTagHelper *, Microsoft.AspNetCore.Mvc.TagHelpers
```

This is why a view can use Tag Helpers and common types without repeating imports on every page. It also keeps layout choice centralized and consistent.

## Strongly typed views and view models

A view is strongest when it is typed to the model or view model it expects:

```cshtml
@model ProductEditVm
```

The controller prepares a view model that matches the page's specific needs, including input fields, validation metadata, and simple UI flags. A view model is preferable when the domain model alone is insufficient for a page-specific view contract.

This is especially clear for forms and edit flows:

```csharp
public class ProductEditVm
{
    [Required, StringLength(60)]
    public string Name { get; set; } = "";

    [Range(0.01, 100000)]
    public decimal Price { get; set; }
}
```

The view can then render `Model.Name`, validation messages, and select lists without inventing ad hoc data structures at the view boundary.

## ViewData, ViewBag, and TempData

Three small pieces of UI state are used in different lifetimes:

```text
ViewData = request-local dictionary; string keys; safe enough for small UI metadata
ViewBag = dynamic wrapper over ViewData; shorter but less type-safe
TempData = one-redirect lifetime; classic PRG success/error message storage
```

Typical usage:

```csharp
ViewData["Title"] = "Products";
ViewBag.PageTitle = "Products";
TempData["SuccessMessage"] = "Product created.";
```

The practical rule is:

```text
main page data -> strongly typed model/view model
small current-request UI metadata -> ViewData or ViewBag
cross-redirect message -> TempData
```

`TempData` is intentionally short-lived. It solves the Post-Redirect-Get pattern: a POST saves the entity, stores a success message, redirects, and the next GET renders the message before it is consumed.

## Validation flow and tag-helper rendering

Validation usually runs as:

```text
HTTP POST -> model binding -> ModelState validation -> action returns same view -> validation helpers render errors
```

ModelState is the canonical place for invalid form data, and the view can render errors with helpers such as:

```cshtml
<div asp-validation-summary="All"></div>
<span asp-validation-for="Name"></span>
```

Tag Helpers keep the HTML-looking syntax but still connect to MVC metadata. They are not middleware and not a replacement for controller behavior. They generate route-aware URLs, field names, validation metadata, and selected values from the model.

Examples of built-in Tag Helpers:

```cshtml
<a asp-controller="Products" asp-action="Edit" asp-route-id="@Model.Id">Edit</a>
<form asp-action="Create" method="post">
    <input asp-for="Name" />
    <select asp-for="Category" asp-items="Model.Categories"></select>
</form>
```

The important part is not just the syntax; it is the metadata connection. `asp-for` uses model metadata to generate `name`, `id`, and validation attributes, and `asp-items` feeds option lists into a `select` without hand-building HTML.

## Partials, view components, and display templates

Partials and view components are both reusable UI fragments, but they have different responsibilities:

```text
partial -> simple shared markup, no independent logic
view component -> own logic, own model preparation, reusable widget
```

A partial is a good fit for repeated markup fragments like a product row or form section. A view component is a better fit for a sidebar, featured list, or dashboard widget that needs its own data retrieval and model preparation.

Display templates provide a consistent rendering rule for a value or type without repeating the same markup across multiple views:

```text
Views/Shared/DisplayTemplates/Money.cshtml
```

They render the same way for all matching values or properties, making repeated formatting and display rules consistent.

## Cache Tag Helper and safe fragment caching

The Cache Tag Helper caches generated HTML fragments for reuse:

```cshtml
<cache vary-by="@Model.Category" expires-after="TimeSpan.FromMinutes(5)">
    @await Component.InvokeAsync("FeaturedProducts")
</cache>
```

This is valuable for stable, expensive, public view output. The key caution is that cache fragmentation is a correctness issue as much as a performance issue: caches must vary correctly for user-specific, route-specific, culture-specific, or authorization-dependent UI.

If the fragment depends on logged-in user state, a cookie, or different route/query values, the cache must vary appropriately or it will leak data across contexts.

## Practical checklist

Use the framework like this:

```text
Layout / _ViewStart / _ViewImports for shared structure and imports
Strongly typed model/view model for page state
ViewData/ViewBag only for tiny request-scoped UI details
TempData only for one-redirect flash messages
Validation helpers/tag helpers for field and summary errors
Partials for simple shared markup
View components for reusable data-bearing widgets
Cache tag helper only for stable, correctly-varied fragments
```

## What should be recallable

- The typical MVC Razor page layout flow and the purpose of `_ViewStart` and `_ViewImports`.
- Why view models are preferred over overloading the main page data into `ViewData` or `ViewBag`.
- The difference between `ViewData`, `ViewBag`, and `TempData` and the correct lifetime for each.
- Why validation data lives in `ModelState` and how validation tag helpers render it.
- Why Tag Helpers keep Razor HTML-like while generating metadata-aware output.
- When to use a partial versus a view component versus a cache fragment.
- Why caching must vary correctly for user-specific or route-specific output.

## Related knowledge

- `aspnet-core.razor-view-discovery-conventions`
- `aspnet-core.razor-tag-helpers-and-partials`
- `aspnet-core.view-components-server-rendered-widgets`
- `aspnet-core.modelstate-binding-validation-and-revalidation`

## Sources

- Workspace: `_ai-conspects/base-mvc-razor-views-example-tempdata-viewdata-viewbag-cache-tag-helper/`
- Authoritative processed source: `10-full-source-preserving-transcript-v002.md`
- Region sources: `regions/R01-base-mvc-razor-products-app-views-layouts.md`, `regions/R02-viewdata-viewbag-tempdata-validation-flow.md`, `regions/R03-built-in-tag-helpers-forms-selects-infrastructure.md`, `regions/R04-cache-tag-helper-view-components-display-validation.md`
- Original SVG: `source/base-mvc-razor-views-example-tempdata-viewdata-viewbag-cache-tag-helper.svg`
