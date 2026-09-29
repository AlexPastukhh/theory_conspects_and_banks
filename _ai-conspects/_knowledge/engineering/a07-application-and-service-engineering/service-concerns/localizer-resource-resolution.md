# IStringLocalizer and IViewLocalizer resource resolution

Knowledge ID: `aspnet-core.localizer-resource-resolution`

Topic: `aspnet-core`

Register localization with `AddLocalization(options => options.ResourcesPath = "Resources")`, MVC view localization with `AddViewLocalization`, and validation localization with `AddDataAnnotationsLocalization`. Configure supported/default cultures and place `UseRequestLocalization` before routing endpoints that need culture selection.

Culture providers can select a supported culture such as `en` or `fr`; the query-string provider can use `?culture=fr`. If no provider chooses another supported culture, the default applies.

Inject `IStringLocalizer<HomeController>` in a controller and request keys such as `localizer["PageTitle"]`. Lookup is anchored to the generic type, so `.resx` naming/location under `Resources` must match that controller/type.

Inject `IViewLocalizer` in a Razor view. It resolves resources from the view path rather than a controller type; for example, `Views/Home/Index.cshtml` uses matching view resource files. This supports localized view text and culture-selection links independently of controller resources.

`.resx` files contain XML `<data name="...">` entries with translated `<value>` elements. Requested keys must match, and controller and view resources follow different path conventions.

## What should be recallable

- Localization registrations, supported/default culture configuration, and middleware ordering.
- Query-string culture selection and default fallback.
- Type-based `IStringLocalizer<T>` versus path-based `IViewLocalizer` lookup.
- Resource path/naming differences and `.resx` key/value structure.

## Sources

- Workspace: `_ai-conspects/istringlocalizer iviewlocalizer/`
- Processed source: `regions/R01-final-transcript.md`, complete verified transcript
- Original SVG: `source/istringlocalizer iviewlocalizer.svg`
