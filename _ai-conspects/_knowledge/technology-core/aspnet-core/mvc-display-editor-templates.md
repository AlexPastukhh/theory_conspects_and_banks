# MVC display and editor templates

Knowledge ID: `aspnet-core.mvc-display-editor-templates`

Topic: `aspnet-core`

`Html.DisplayFor` and `Html.EditorFor` select reusable Razor templates by model/property type or explicit name. Templates live in controller-specific or shared `DisplayTemplates`/`EditorTemplates` directories; controller-specific files take precedence over shared fallback.

A display template renders read-only output:

```cshtml
@* Views/Shared/DisplayTemplates/Money.cshtml *@
@model decimal
@Model.ToString("C")
```

```cshtml
@Html.DisplayFor(model => model.Price, "Money")
```

Explicit names avoid changing every decimal property globally.

An editor template renders controls consistently:

```cshtml
@model decimal?
<input class="form-control"
       name="@ViewData.TemplateInfo.GetFullHtmlFieldName("")"
       value="@(Model?.ToString("0.00") ?? "")" />
```

```cshtml
@Html.EditorFor(model => model.Price, "Money")
<span asp-validation-for="Price"></span>
```

Preserve the generated field prefix/name so nested objects and collections bind. Validation metadata/messages must stay aligned with the property path.

Templates centralize formatting/controls and work naturally for type/property rendering. Use a partial when the reusable unit is a larger UI composition with an explicit model.

## What should be recallable

- Display versus editor selection by type/name and discovery precedence.
- Complete Money display/editor examples and why an explicit name can be safer.
- Field-prefix preservation for nested binding and validation alignment.
- Template versus partial-view boundary.

## Sources

- Workspace: `_ai-conspects/editor,display templates/`
- Processed source: `regions/R01-display-editor-templates-final.md`, R01
- Original SVG: `source/editor,display templates.svg`
- Workspace: `_ai-conspects/view discovery conventions/`
- Authoritative processed source: `regions/R01R02-view-discovery-and-templates-final.md`, R02
- Original SVG: `source/view discovery conventions.svg`
