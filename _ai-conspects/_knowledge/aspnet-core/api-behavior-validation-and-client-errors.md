# API behavior, validation, and client errors

Knowledge ID: `aspnet-core.api-behavior-validation-and-client-errors`

Topic: `aspnet-core`

With API-controller conventions, binding/validation can populate invalid `ModelState` and short-circuit before the action body. `InvalidModelStateResponseFactory` customizes that automatic result; it neither validates input nor handles arbitrary exceptions.

Set `SuppressModelStateInvalidFilter = true` to disable automatic 400 and allow the action to inspect invalid state. This supports custom per-action validation, partial/autosave input, or aggregation with domain errors; the action then owns the response contract.

A custom validation contract may deliberately use `422 Unprocessable Entity` instead of the default automatic 400. Keep automatic validation failures and manually detected PATCH validation failures on the same Problem Details shape and status-code policy.

A representative global policy obtains the framework `ProblemDetailsFactory`, then sets the application-specific status and metadata:

```csharp
builder.Services.AddProblemDetails();

builder.Services
    .AddControllers()
    .ConfigureApiBehaviorOptions(options =>
    {
        options.InvalidModelStateResponseFactory = context =>
        {
            var factory = context.HttpContext.RequestServices
                .GetRequiredService<ProblemDetailsFactory>();

            var problem = factory.CreateValidationProblemDetails(
                context.HttpContext,
                context.ModelState);

            problem.Status = StatusCodes.Status422UnprocessableEntity;
            problem.Title = "Validation failed";
            problem.Detail = "See the errors property for details.";
            problem.Instance = context.HttpContext.Request.Path;

            return new UnprocessableEntityObjectResult(problem);
        };
    });
```

With `[ApiController]`, invalid binding or validation state invokes this delegate before the action body. Common cases include an empty/missing JSON body for a complex body parameter, formatter errors, missing required fields, and DataAnnotations failures. Plain MVC without `[ApiController]` normally still enters the action with invalid `ModelState` and possibly a null parameter; application code owns the response.

Invalid `ModelState` is normally a validation outcome, not an exception for an exception filter or middleware to catch. `InvalidModelStateResponseFactory` expects the real MVC `ActionContext` after binding/validation. Middleware can fabricate an `ActionContext` and `ModelStateDictionary`, but it does not naturally possess the selected action's true metadata or populated validation state. When only a consistent Problem Details shape is needed outside MVC, use `ProblemDetailsFactory` or `IProblemDetailsService` rather than pretending middleware is inside MVC validation.

When a controller/action or MVC filter already owns a domain-validation failure, it can add the domain errors to the real `context.ModelState`, obtain `ApiBehaviorOptions.InvalidModelStateResponseFactory`, and invoke that delegate with the real action context. MVC services and formatters can then execute the returned `IActionResult`. Reconstructing those objects and services in generic middleware is possible but crosses the natural abstraction boundary.

`ApiBehaviorOptions` also controls inference conventions. `SuppressInferBindingSourcesForParameters` disables implicit body/route/query/service source inference. `DisableImplicitFromServicesParameters` specifically prevents registered service types from silently becoming service-bound parameters and is meaningful while binding-source inference is enabled. `SuppressConsumesConstraintForFormFileParameters` changes the automatic consumes constraint for form-file parameters.

Client-error mapping is separate from validation response creation. `SuppressMapClientErrors` disables automatic conversion of client-error results to Problem Details-style payloads; use it when middleware/custom envelopes or intentionally empty bodies own the contract. `ClientErrorMapping[statusCode]` customizes only default metadata: `Title` maps to the Problem Details title and `Link` normally maps to its type URI. It does not directly set `Detail`, `Instance`, or `Extensions`; use a factory, `IProblemDetailsService`, validation factory, or middleware for richer output.

A representative status-mapping policy keeps stable documentation and titles
at this layer:

```csharp
options.ClientErrorMapping[StatusCodes.Status404NotFound].Link =
    "https://docs.mycompany.com/problems/not-found";
options.ClientErrorMapping[StatusCodes.Status404NotFound].Title =
    "Resource was not found";

options.ClientErrorMapping[StatusCodes.Status409Conflict].Link =
    "https://docs.mycompany.com/problems/conflict";
options.ClientErrorMapping[StatusCodes.Status409Conflict].Title =
    "Conflict with current state";
```

Mapping targets MVC client-error results such as parameterless `NotFound()`/`BadRequest()` that implement the client-error contract. An explicit body such as `NotFound(myObject)` is normally retained rather than replaced. This behavior is not successful-response mapping or general exception handling.

## What should be recallable

- Explain the core model of **API behavior, validation, and client errors** without opening the Unit.
- Reconstruct this Unit-grounded rule: With API-controller conventions, binding/validation can populate invalid `ModelState` and short-circuit before the action body.
- Reconstruct this Unit-grounded rule: Set `SuppressModelStateInvalidFilter = true` to disable automatic 400 and allow the action to inspect invalid state.
- Reconstruct this Unit-grounded rule: A custom validation contract may deliberately use `422 Unprocessable Entity` instead of the default automatic 400.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources
- Workspace: `_ai-conspects/apibehavioroptions/`
- Processed source: `04-source-preserving-transcript-v002.md`, complete transcript
- Workspace: `_ai-conspects/REST API BASICS/`
- Authoritative processed source: `regions/R01-rest-constraints-methods-validation.md`, automatic/custom validation claims
- Original SVG: `source/REST API BASICS.svg`
- Workspace: `_ai-conspects/automatic-problem-details-from-modelstate-apicontroller-filter-invalidmodelstateresponsefactory/`
- Authoritative processed source: `regions/full-source-near-literal-v002.md`, S-002–S-005 and S-020–S-023
- Original SVG: `source/automatic-problem-details-from-modelstate-apicontroller-filter-invalidmodelstateresponsefactory.svg`
- Workspace: `_ai-conspects/filters/`
- Authoritative processed source: `regions/R01-main-filters-theory-ordering-exception-di-factories.md`, S-045, S-053, S-059, S-062, S-064, S-069-S-070
- Original SVG: `source/filters.svg`
- Workspace: `_ai-conspects/problem details/`
- Authoritative conceptual source: `09-stage9-integrated-study-transcript-v003.md`, sections 6 and 13-14
- Original source identity: `problem details.svg`; canonical extracted PNG placements are present, but the full SVG is not tracked or resolvable from the current branch tree (`12-export-canonical-source-instructions-v003.md`)
- Exact screenshot sources: `06-stage6-source-preserving-transcript-pass1-v002.md` and `13-final-near-literal-source-closure-v004.md`; together they certify all 77 unique contents / 86 placements
