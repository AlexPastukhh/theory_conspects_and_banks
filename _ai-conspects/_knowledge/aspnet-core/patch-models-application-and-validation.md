# ASP.NET Core PATCH models, application, and validation

Knowledge ID: `aspnet-core.patch-models-application-and-validation`

Topic: `aspnet-core`

## Manual DTO and three field states

A manual PATCH DTO changes only properties supplied by the client. Plain nullable properties cannot distinguish an omitted field from a field explicitly set to JSON `null`. An `Optional<T>` wrapper adds presence:

```csharp
public readonly record struct Optional<T>(bool IsSet, T? Value);
```

That produces three states:

```text
property absent              -> IsSet = false
property present, non-null   -> IsSet = true, Value = value
property present, null       -> IsSet = true, Value = null
```

A `System.Text.Json` converter factory can create converters for `Optional<T>`. The property converter runs only when the JSON property is present, so omission leaves `IsSet=false`. This preserves strong typing and business validation while allowing an explicit clear.

## JSON Patch target mechanics

JSON Patch paths must make sense for the target document:

- `replace` targets an existing scalar/property;
- `add` can insert or append to an existing collection and set an existing nullable/reference property;
- it cannot invent a CLR property absent from a strongly typed DTO;
- `remove` removes/resets the target according to the model;
- arrays have index-sensitive behavior;
- `copy`, `move`, and `test` remain available in the RFC representation.

These operations are powerful but more complex to validate and reason about than a business-focused partial DTO.

## Controller flow

Patch a mutable API DTO rather than the persistence entity:

```text
load current entity
-> map entity to update DTO
-> apply patch document to DTO and ModelState
-> validate final DTO
-> map accepted changes back to entity
-> save
-> return 204 or a representation
```

This prevents the external patch contract from exposing the storage model. For an explicit upsert policy, a missing resource follows a separate create branch: create a DTO, apply and validate the patch, create the entity, and return `201 Created`. An update-only PATCH returns `404 Not Found` instead.

## Operation errors and final-object validation

`ApplyTo(dto, ModelState)` records invalid patch operations, but valid individual operations can still produce an invalid object. Validate again after application.

With `[ApiController]`, ordinary binding validation can short-circuit automatically through `ApiBehaviorOptions.InvalidModelStateResponseFactory`. Manual validation discovered inside a PATCH action should call `ValidationProblem(ModelState)` or deliberately invoke the configured factory so the response uses consistent Problem Details.

The factory receives an `ActionContext` and returns an `IActionResult`; `ControllerContext` is valid because it derives from `ActionContext`. An override of `ValidationProblem` can route manually detected patch errors through the same global response format.

```csharp
[ApiController]
public abstract class ApiControllerBase : ControllerBase
{
    public override ActionResult ValidationProblem(
        [ActionResultObjectValue]
        ModelStateDictionary modelStateDictionary)
    {
        var behavior = HttpContext.RequestServices
            .GetRequiredService<IOptions<ApiBehaviorOptions>>();

        return (ActionResult)behavior.Value
            .InvalidModelStateResponseFactory(ControllerContext);
    }
}
```

`ActionResultObjectValue` is analyzer/tooling metadata identifying the result's object-value parameter; it also appears on result helpers such as Created, Accepted, and StatusCode overloads. It does not change runtime validation behavior. The configured factory may return the default 400, a 422 result, or another controlled `ObjectResult`, so the override keeps manual and automatic paths aligned.

Preserve the two validation stages with either JSON Patch implementation. The Newtonsoft MVC overload can write operation errors directly to `ModelState`:

```csharp
patchDocument.ApplyTo(dto, ModelState);

if (!ModelState.IsValid)
    return ValidationProblem(ModelState);

if (!TryValidateModel(dto))
    return ValidationProblem(ModelState);
```

The System.Text.Json patch API can use its callback to transfer operation errors before validating the final DTO:

```csharp
patchDocument.ApplyTo(dto, error =>
{
    var key = error.AffectedObject?.GetType().Name ?? string.Empty;
    ModelState.AddModelError(key, error.ErrorMessage);
});

if (!ModelState.IsValid)
    return ValidationProblem(ModelState);

if (!TryValidateModel(dto))
    return ValidationProblem(ModelState);
```

## What should be recallable

- Why does nullable alone fail to distinguish omission from explicit null?
- Why does a converter invoked only for present properties preserve `Optional<T>.IsSet`?
- Which JSON Patch operations require existing paths or collections?
- Why should patching target an API DTO rather than an EF entity?
- Why must the final DTO be validated after operation application?
- How can manual PATCH errors reuse global Problem Details formatting?

## Sources

- Workspace: `_ai-conspects/PUT,PATCH/`
- Authoritative processed source: `regions/R01R07-put-patch-full-coverage-v001.md`, R03–R04 and R06–R07
- Original SVG: `source/source-complete-v001.svg`
- Workspace: `_ai-conspects/REST API BASICS/`
- Authoritative processed source: `regions/R01-rest-constraints-methods-validation.md`, two-stage PATCH validation
- Original SVG: `source/REST API BASICS.svg`
- Workspace: `_ai-conspects/automatic-problem-details-from-modelstate-apicontroller-filter-invalidmodelstateresponsefactory/`
- Authoritative processed source: `regions/full-source-near-literal-v002.md`, S-001 and S-006–S-015
- Original SVG: `source/automatic-problem-details-from-modelstate-apicontroller-filter-invalidmodelstateresponsefactory.svg`
