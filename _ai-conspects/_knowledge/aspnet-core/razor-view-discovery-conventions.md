# Razor view discovery conventions

Knowledge ID: `aspnet-core.razor-view-discovery-conventions`

Topic: `aspnet-core`

When an MVC action returns `View()` without a name, the action name becomes the view name. Discovery prefers the controller-specific location and then the shared fallback:

```text
Views/{Controller}/{Action}.cshtml
Views/Shared/{Action}.cshtml
```

`View("Something")` uses the same search order for `Something.cshtml`. If discovery fails, MVC reports the searched locations at runtime. A full application-relative path bypasses discovery:

```csharp
return View("~/Views/Shared/SpecialEdit.cshtml");
```

## Partials and layouts

Partial views follow the controller-then-shared pattern. The leading underscore is a naming convention rather than a different file type:

```text
Views/{Controller}/_ProductRow.cshtml
Views/Shared/_ProductRow.cshtml
```

An explicit path such as `~/Views/Shared/_ProductRow.cshtml` selects that exact file. `_ViewStart.cshtml` commonly assigns `Layout = "_Layout"`; the layout name is then resolved through ordinary view locations, with `Views/Shared/_Layout.cshtml` as the usual shared choice.

## Areas and View Components

Areas add a more specific search root before the global shared fallback. For `Admin`, `UsersController`, and `Index`:

```text
Areas/Admin/Views/Users/Index.cshtml
Areas/Admin/Views/Shared/Index.cshtml
Views/Shared/Index.cshtml
```

A View Component named `FeaturedProducts` uses its own component folder:

```text
Views/Shared/Components/FeaturedProducts/Default.cshtml
```

Returning `View("Compact", model)` from the component selects `Compact.cshtml` under that folder. An Area can provide an Area-specific `Views/Shared/Components/{Component}/...` view.

Use explicit paths for deliberate one-off overrides. When the whole application follows a different directory structure, customize Razor view-engine locations rather than scattering explicit paths.

## Related knowledge

- `aspnet-core.mvc-display-editor-templates`
- `aspnet-core.view-components-server-rendered-widgets`
- `aspnet-core.razor-tag-helpers-and-partials`

## Sources

- Workspace: `_ai-conspects/view discovery conventions/`
- Authoritative processed source: `regions/R01R02-view-discovery-and-templates-final.md`, R01 and discovery cheat sheet
- Original SVG: `source/view discovery conventions.svg`
