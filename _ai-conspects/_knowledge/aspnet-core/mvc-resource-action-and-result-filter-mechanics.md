# MVC resource, action, and result filter mechanics

Knowledge ID: `aspnet-core.mvc-resource-action-and-result-filter-mechanics`

Topic: `aspnet-core`

Resource, action, and result filters all have around semantics, but they wrap different amounts of MVC work:

```text
resource filter  -> model binding + action + result
action filter    -> bound action invocation
result filter    -> IActionResult formatting/serialization/writing
```

Choose the earliest stage that has enough context. Earlier is not automatically better: a resource filter can avoid binding but cannot inspect action arguments that do not exist yet.

## Resource filters decide whether binding happens

`ResourceExecutingContext` exposes `HttpContext`, `RouteData`, and `ActionDescriptor`, but not bound action arguments or populated validation state. Setting `Result` before continuing prevents model binding and action execution:

```csharp
public void OnResourceExecuting(ResourceExecutingContext context)
{
    var cached = MyCache.Get(context.HttpContext.Request.Path);
    if (cached is not null)
    {
        context.Result = new ContentResult {
            Content = cached,
            ContentType = "application/json"
        };
    }
}
```

This can avoid reading/parsing the body, JSON deserialization, request-model allocation, validation attributes, `ModelState` population, and action invocation. It suits early caching, feature flags, throttling, and request-scoped setup—not business rules requiring a validated model.

An async resource filter wraps the complete downstream MVC execution:

```csharp
public async Task OnResourceExecutionAsync(
    ResourceExecutingContext context,
    ResourceExecutionDelegate next)
{
    BeginScope();
    try
    {
        var executed = await next();
        // binding + action + result have completed or failed
    }
    finally
    {
        EndScope();
    }
}
```

`ResourceExecutedContext` is therefore appropriate for whole-MVC timing, downstream exception observation, short-circuit detection, and cleanup owned by the before path.

## Action filters operate on bound inputs

Action filters see `ActionArguments`, `ModelState`, the controller instance, action metadata, result, and exception state. They can validate/modify inputs, time the action, add metrics, or set `Result` to skip the action:

```csharp
public async Task OnActionExecutionAsync(
    ActionExecutingContext context,
    ActionExecutionDelegate next)
{
    if (!context.ModelState.IsValid)
    {
        context.Result = new BadRequestObjectResult(context.ModelState);
        return;
    }

    var sw = Stopwatch.StartNew();
    var executed = await next();
    sw.Stop();
    // inspect executed.Result or executed.Exception
}
```

An action filter cannot save model-binding cost because binding already happened.

An action filter is also an appropriate MVC-scoped boundary for header syntax that must produce a specific client error. For example, a malformed `Accept` list can be checked with `MediaTypeHeaderValue.TryParseList`; missing `Accept` proceeds normally, malformed syntax can short-circuit with `400 ProblemDetails`, and a successfully parsed but unsupported list remains a separate negotiation/`406` decision. Parsing proves syntax, not formatter overlap.

## Result filters own result execution

Before `next()`, a result filter can replace/wrap an `ObjectResult`, change headers, or choose a different result:

```csharp
public void OnResultExecuting(ResultExecutingContext context)
{
    if (context.Result is ObjectResult value)
    {
        context.Result = new ObjectResult(new { data = value.Value, ok = true })
        {
            StatusCode = value.StatusCode
        };
    }
}
```

After `await next()`, formatting and serialization may have completed and headers/body may already be written. That path is for result-execution timing, cleanup, cancellation, and observing formatter/serialization/write failures—not reliably replacing the payload or status.

`ResultExecutedContext` exposes `Canceled`, `Exception`, `ExceptionHandled`, `Result`, `HttpContext`, and action metadata. Handling a late serialization failure may still be unable to produce a clean replacement once the response has started.

Use `try/finally` when the after operation is required even if downstream result execution throws:

```csharp
BeginSomething();
try
{
    await next();
}
finally
{
    EndSomething();
}
```

Only result filters have the always-run variants `IAlwaysRunResultFilter` and `IAsyncAlwaysRunResultFilter`. They can run for results created by authorization/resource/exception short-circuits; there is no general always-run action- or authorization-filter interface.

## What should be recallable

- Which work each of the three filters wraps.
- Exactly what a resource short-circuit avoids and why action arguments are unavailable there.
- Why action filters can inspect validated inputs but cannot avoid binding.
- How an action filter can distinguish malformed `Accept` syntax from later `406` negotiation.
- Why result transformation belongs before `next()` and what post-`next()` can still observe.
- Which state `ResultExecutedContext` exposes and why cleanup should use `finally`.
- Why always-run is a result-filter concept.

## Related knowledge

- `aspnet-core.mvc-filter-pipeline-stages-and-ordering`
- `aspnet-core.antiforgery-token-lifecycle`

## Sources

- Workspace: `_ai-conspects/filters/`
- Authoritative processed sources: `regions/R01-main-filters-theory-ordering-exception-di-factories.md`, S-003, S-014, S-018, S-024, S-031, S-039, S-044, S-051, S-058, S-066; `regions/R02R03-concrete-examples-lower-addendum-final.md`, S-096, S-098, S-100-S-106, S-108-S-110, S-114-S-115; and matching native code in `NATIVE_CANVAS_TEXT.md`
- Integrated source: `FINAL_TRANSCRIPT.md`, sections 2-3 and 11
- Original SVG: `source/filters.svg`
- Workspace: `_ai-conspects/FULL CONTENT NEG + VALIDATION FLOW/`
- Authoritative processed source: `13-corrected-study-transcript-v002.md`, section 6, with exact evidence in `11-exact-canvas-text-transcript-v002.md` R04 and `12-screenshot-evidence-cards-v002.md`, S-005-S-012
- Original SVG: `source/FULL CONTENT NEG + VALIDATION FLOW.svg`
