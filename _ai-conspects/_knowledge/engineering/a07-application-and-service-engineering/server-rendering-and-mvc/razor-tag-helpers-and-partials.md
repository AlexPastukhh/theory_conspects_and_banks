# Built-in Razor Tag Helpers and partials

Knowledge ID: `aspnet-core.razor-tag-helpers-and-partials`

Topic: `aspnet-core`

Tag Helpers attach server behavior to HTML, generating URLs, names, validation metadata, antiforgery fields, and cache-busting values from framework metadata.

Anchor/Form helpers use `asp-action`, `asp-controller`, `asp-area`, `asp-route-*`, `asp-all-route-data`, `asp-page`, `asp-page-handler`, `asp-fragment`, `asp-protocol`, and `asp-host`. Form helpers can generate antiforgery. Do not mix fixed `href`/`action` with competing generation attributes unless precedence is understood.

Form controls use `asp-for`; input also supports `asp-format`, select uses `asp-items`, and label/textarea derive metadata. `OptionTagHelper` supplies option-selection behavior so matching option values are marked selected from the bound model. `asp-for` generates name, ID, current value, and validation attributes. Formatting does not change the model type. Validation uses `asp-validation-for` and `asp-validation-summary="All|ModelOnly|None"`.

```cshtml
<partial name="_Order" model="Model.Order" />
<partial name="_Editor" for="Customer" />
```

Partial inputs are `name`, `model`, `for`, and `view-data`. `model` passes an object; `for` is a model expression retaining metadata/prefix. Partials render reusable markup; use a view component for complex independent behavior.

Environment helper conditionally renders by `include`/`exclude`. Cache helper controls absolute/sliding expiry and variation by route/query/user. Link/script/image helpers support `asp-append-version="true"`, adding a content hash query for cache busting; link/script can also configure CDN fallback.

Prefer route tag helpers to hand-built URLs; use `asp-area`, `asp-fragment`, and route dictionaries for their intended URL parts. Keep endpoint/business logic out of partials.

## What should be recallable

- Navigation/form route attributes, antiforgery behavior, and fixed-URL conflict.
- `asp-for` metadata generation, formatting, select items, option-selection support, and validation helpers.
- Partial `model` versus `for`, prefix preservation, and view-component boundary.
- Environment/cache/asset versioning behavior and CDN fallback.

## Sources

- Workspace: `_ai-conspects/tag helpers razor,partial/`
- Processed source: `regions/R01-final-coverage-transcript.md`, R01
- Original SVG: `source/tag helpers razor,partial.svg`
