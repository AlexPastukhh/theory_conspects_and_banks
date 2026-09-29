# MVC exception filters and error results

Knowledge ID: `aspnet-core.mvc-exception-filters-and-error-results`

Topic: `aspnet-core`

An exception filter owns a narrow MVC failure boundary: eligible failures from action/result execution. It can use the selected action's metadata and MVC result system, but it is not an application-wide catch-all.

```text
outer exception middleware
    -> routing and endpoint middleware
    -> MVC authorization/resource/model-binding/action/result pipeline
         exception filter maps eligible action/result failures
```

It does not catch exceptions from earlier middleware, routing, authorization filters, or arbitrary non-MVC endpoints. An exception escaping MVC may still be caught by outer exception middleware. Authorization filters should return challenge/forbid/unauthorized results instead of throwing.

## Handling requires a defined replacement

A practical filter maps a known failure to an MVC result and marks it handled:

```csharp
public void OnException(ExceptionContext context)
{
    if (context.Exception is DomainValidationException ex)
    {
        foreach (var error in ex.Errors)
            context.ModelState.AddModelError(error.Field, error.Message);

        context.Result = new BadRequestObjectResult(context.ModelState);
        context.ExceptionHandled = true;
    }
}
```

`ExceptionHandled = true` stops propagation. Setting it without a result or deliberately written response usually leaves an ambiguous/empty outcome. Check `Response.HasStarted` before attempting to replace the response.

A filter can technically return status 200, but that only changes the HTTP representation. The action already threw and did not complete normally; manufacturing success can hide failures. Prefer accurate 400/404/409/422/500 mappings.

## MVC result integration

Exception filters can return `ObjectResult`, `BadRequestObjectResult`, `ViewResult`, or `ChallengeResult`. MVC then executes that result through its normal formatter, view, or authentication conventions:

```csharp
context.Result = new ObjectResult(new ProblemDetails
{
    Title = "An unexpected error occurred.",
    Status = StatusCodes.Status500InternalServerError,
    Instance = context.HttpContext.Request.Path
}) { StatusCode = StatusCodes.Status500InternalServerError };

context.ExceptionHandled = true;
```

An `ObjectResult` preserves MVC output formatting and content negotiation. A page-controller filter can return an error view and carry request diagnostics through view data:

```csharp
var view = new ViewResult { ViewName = "Error" };
view.ViewData["TraceId"] = context.HttpContext.TraceIdentifier;
context.Result = view;
context.ExceptionHandled = true;
```

`ChallengeResult` participates in authentication conventions. Generic middleware can write a body, but it does not automatically re-enter MVC result execution.

## Classify only when policy needs it

A mixed API/view application can classify the selected controller endpoint using:

- `[ApiController]` endpoint metadata as the strongest API signal;
- `ControllerActionDescriptor.ControllerTypeInfo`, where `Controller` suggests views and `ControllerBase` suggests API style;
- explicit application marker metadata;
- `[Produces]` only as an optional heuristic, because APIs may omit it and view actions may declare content types.

Unknown, Minimal API, or non-MVC endpoints should normally remain unhandled so outer middleware owns them. Do not blindly cast every `ActionDescriptor`: Razor Pages and custom MVC descriptors exist.

## Best-of-both error architecture

Use exception filters for known MVC/domain failures that need action/controller metadata, per-controller policy, MVC `ProblemDetails`, content negotiation, views, or authentication results. Use early exception middleware as the global safety net for unexpected failures, static files, routing, Minimal APIs, and middleware errors.

For example, a selected controller can map `DomainException` to 409 while middleware logs everything else and emits generic 500 output. A Minimal-API-only application with one uniform error contract may not need exception filters at all.

Invalid `ModelState` under `[ApiController]` normally produces an automatic 400 without throwing, so it is not exception-filter work unless application code deliberately throws a validation exception. Likewise, generic 404/405/401/403/415/406 responses can arise without an MVC action and belong to status-code/error middleware rather than relying on a filter.

## Result-execution failure boundary

Exception filters can cover eligible result-stage failures, but once headers/body have started, neither a result filter nor exception filter can reliably replace partially written output. Observing/logging a serialization failure and successfully producing a fresh error representation are different capabilities.

## What should be recallable

- Which failures exception filters can and cannot catch.
- Why handled state needs a concrete replacement result.
- Why HTTP 200 does not undo a failed action.
- How MVC result execution differs from direct middleware writing.
- Which endpoint-classification signals are strong, heuristic, or unsafe.
- How exception filters and exception middleware divide expected and unexpected failures.
- Why validation and generic status-code failures often bypass exception filters.

## Related knowledge

- `aspnet-core.exception-middleware-response-lifecycle`
- `aspnet-core.endpoint-metadata-and-mvc-action-descriptors`
- `aspnet-core.media-type-formatters-and-406-415`
- `aspnet-core.status-code-pages-and-problem-details`
- `aspnet-core.api-behavior-validation-and-client-errors`

## Sources

- Workspace: `_ai-conspects/filters/`
- Authoritative processed sources: `regions/R01-main-filters-theory-ordering-exception-di-factories.md`, S-001-S-004, S-006, S-008, S-010-S-013, S-016, S-020, S-023, S-025, S-027-S-033, S-038, S-045-S-047, S-049, S-052-S-064, S-067-S-080, S-082-S-085, S-087, S-089-S-092; `regions/R02R03-concrete-examples-lower-addendum-final.md`, S-111-S-113; and matching native text in `NATIVE_CANVAS_TEXT.md`
- Integrated source: `FINAL_TRANSCRIPT.md`, sections 2 and 7-10
- Original SVG: `source/filters.svg`
