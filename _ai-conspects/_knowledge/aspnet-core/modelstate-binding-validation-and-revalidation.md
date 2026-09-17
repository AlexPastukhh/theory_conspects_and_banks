# ModelState binding, validation, and revalidation

Knowledge ID: `aspnet-core.modelstate-binding-validation-and-revalidation`

Topic: `aspnet-core`

MVC populates `ModelStateDictionary` during binding and validation. Errors can come from JSON/type conversion, missing bodies, DataAnnotations, integrated validators, `TryValidateModel`, or `AddModelError`. Keys preserve paths such as `Address.Street` and `Items[0].Price`; entries may hold raw/attempted values and several errors. Extract a non-empty `ErrorMessage`, then `Exception.Message`, then a safe fallback.

`[ApiController]` normally returns automatic 400 before the action. Customize formatting with `InvalidModelStateResponseFactory`; suppress the filter only when the action must inspect errors or deliberately return another contract such as 422. Responses can use `ValidationProblem(ModelState)`, `ValidationProblemDetails`, or a controlled custom Problem Details extension.

`TryValidateModel(model, prefix)` runs configured validators and writes to `ModelState`; it does not bind, read JSON, run authorization, or throw for ordinary invalidity. Use it for models created/modified after binding, mapping/service results, nested objects, or PATCH flows. Supply nested/indexed prefixes so keys remain meaningful.

Revalidation appends errors. Clear the entire dictionary or remove the targeted entries before validating again to avoid duplicates. `ValidateModel` is similar but returns `void`; `TryValidateModel` returns success.

`InvalidModelStateResponseFactory` accepts the full `ActionContext`, not only `ModelState`, because response policy may need `HttpContext`, route and action metadata, request services, the request path, and the accumulated errors. `ControllerContext` derives from `ActionContext` and adds controller-specific members such as `ControllerActionDescriptor` and `ValueProviderFactories`, so it can be passed to the factory.

With nullable reference types enabled, MVC can treat a non-nullable reference property as implicitly required. This convention can be disabled without weakening explicit required rules:

```csharp
builder.Services.AddControllers()
    .AddMvcOptions(options =>
    {
        options.SuppressImplicitRequiredAttributeForNonNullableReferenceTypes =
            true;
    });
```

Explicit `[Required]` attributes still express requiredness after this option is enabled.

## Sources
- Workspace: `_ai-conspects/modelstate/`
- Processed source: `regions/modelstate-final.md`, complete transcript
- Workspace: `_ai-conspects/automatic-problem-details-from-modelstate-apicontroller-filter-invalidmodelstateresponsefactory/`
- Authoritative processed source: `regions/full-source-near-literal-v002.md`, S-016–S-019 and S-024
- Original SVG: `source/automatic-problem-details-from-modelstate-apicontroller-filter-invalidmodelstateresponsefactory.svg`
