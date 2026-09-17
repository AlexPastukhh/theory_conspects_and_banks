# Problem Details writers, context, and endpoint metadata

Knowledge ID: `aspnet-core.problem-details-writers-context-and-metadata`

Topic: `aspnet-core`

## Factory, service, and writer have different responsibilities

A generic Problem Details flow can involve both:

```text
ProblemDetailsFactory
    -> creates/populates the ProblemDetails model

IProblemDetailsService
    -> selects a registered writer and asks it to write

IProblemDetailsWriter
    -> decides whether it can write and performs the output
```

A helper can accept both the factory and service because creating the model and selecting/rendering an output format are separate responsibilities.

Response lifecycle safety remains the caller's responsibility. The source explicitly notes that `ProblemDetailsService` itself does not guard `HttpResponse.HasStarted`.

## `ProblemDetailsContext` is the writer-pipeline input

The basic context contains the request and response model:

```csharp
var problem = problemDetailsFactory.CreateProblemDetails(
    httpContext: context,
    statusCode: statusCode,
    title: title,
    detail: detail,
    instance: context.Request.Path);

var pdContext = new ProblemDetailsContext
{
    HttpContext = context,
    ProblemDetails = problem
};

var written =
    await problemDetailsService.TryWriteAsync(pdContext);
```

The fuller context model can also contain:

- `Exception`, when available;
- `AdditionalMetadata`, such as endpoint metadata.

A writer can therefore make decisions from the HTTP request, the problem model, the failure, and endpoint metadata together.

## `TryWriteAsync` is an attempt, not a serialization guarantee

`TryWriteAsync(...)` returns a boolean result:

```text
true
    -> a registered writer handled the response

false
    -> no writer could handle it
```

The service tries writers in sequence and uses the first one that can write.

One reason a writer can decline is content negotiation. For example, an `Accept` header that does not match a supported Problem Details representation can leave no matching writer.

If the application requires an error body in all cases, it can provide a fallback before the response starts:

```csharp
if (!written)
{
    context.Response.ContentType = "text/plain";

    await context.Response.WriteAsync(
        $"{statusCode} {title}: {detail}");
}
```

This is the same generic writer/fallback mechanic that specialized middleware such as Status Code Pages can also use.

## The default writer is the JSON Problem Details writer

The source describes the built-in default writer as:

- checking `Accept` compatibility, including JSON/problem+json/wildcards;
- applying defaults;
- adding `traceId`;
- applying `CustomizeProblemDetails`;
- writing JSON as `application/problem+json`.

`IProblemDetailsService` orchestrates writer selection; it does not directly mean "serialize JSON".

## Rich context enables endpoint-aware custom writers

A complete context can include the exception and current endpoint metadata:

```csharp
var pdContext = new ProblemDetailsContext
{
    HttpContext = httpContext,
    Exception = exception,
    ProblemDetails = new ProblemDetails
    {
        Status = StatusCodes.Status500InternalServerError,
        Title = "Unhandled server error",
        Detail = "An unexpected error occurred.",
        Instance = httpContext.Request.Path
    },
    AdditionalMetadata =
        httpContext.GetEndpoint()?.Metadata
};

var written = await _pds.TryWriteAsync(pdContext);
```

This allows a custom writer to inspect both the failure and declarative metadata attached to the endpoint.

## `CanWrite` can make a writer opt-in through metadata

The source uses a marker attribute:

```csharp
public sealed class CustomMetadataProblemDetailsWriter
    : IProblemDetailsWriter
{
    public bool CanWrite(ProblemDetailsContext context)
    {
        var hasMarker = context.AdditionalMetadata?
            .OfType<UseCustomProblemWriterAttribute>()
            .Any() == true;

        return hasMarker;
    }
}
```

If the marker is absent, the writer declines and later/default writers remain eligible.

The marker can target methods or classes:

```csharp
[AttributeUsage(
    AttributeTargets.Method | AttributeTargets.Class)]
public sealed class UseCustomProblemWriterAttribute : Attribute
{
}
```

This turns an alternative error representation into an endpoint-level opt-in contract rather than a controller-by-controller imperative branch.

## A writer can enrich the existing Problem Details model

The custom writer can inspect `context.Exception` and endpoint metadata, then add controlled extensions:

```csharp
if (context.Exception is not null)
{
    pd.Extensions["exceptionType"] =
        context.Exception.GetType().Name;
}

var endpointName = context.AdditionalMetadata?
    .OfType<EndpointNameMetadata>()
    .FirstOrDefault()?
    .EndpointName;

if (!string.IsNullOrWhiteSpace(endpointName))
{
    pd.Extensions["endpoint"] = endpointName;
}
```

It then writes the same enriched `ProblemDetails` object as `application/problem+json`.

Exception-type output is a diagnostic example and should be reviewed or removed for production when it exposes information the public API should not reveal.

## Writer customization stays inside the service pipeline

`CustomizeProblemDetails` applies when a response is written through the Problem Details service/writer path.

A component that manually writes a response without invoking the service bypasses those configured writers and customizations.

That boundary is important: registering a customization does not automatically modify every response that happens to contain JSON shaped like Problem Details.

## Registration and customization are separate decisions

Both forms below configure `ProblemDetailsOptions`:

```csharp
services.Configure<ProblemDetailsOptions>(options =>
    options.CustomizeProblemDetails = Customize);

services.AddProblemDetails(options =>
    options.CustomizeProblemDetails = Customize);
```

The first form configures options only. `AddProblemDetails` also installs the
Problem Details service and default writer infrastructure used by middleware
and explicit `TryWriteAsync` calls. Configure-only code is appropriate when a
library contributes policy to an application that already registered the
infrastructure; it does not by itself make exception handling or Status Code
Pages start writing problem responses.

There is also an idempotency boundary. If code creates a model through the
default MVC `ProblemDetailsFactory` and later writes it through
`IProblemDetailsService`, the same `CustomizeProblemDetails` callback can run at
creation and again at writing. Set-or-overwrite logic is normally stable;
blind append logic can duplicate values.

## MVC, Minimal APIs, and middleware own different response steps

Controllers normally return `Problem(...)`, `ValidationProblem(...)`, or an
`ObjectResult` and let MVC execute the result, including serialization and
content negotiation. Minimal APIs similarly return `Results.Problem(...)`,
`Results.ValidationProblem(...)`, or `TypedResults.Problem(...)`. These paths
normally should not call `IProblemDetailsService` merely to write the returned
result.

Middleware, authentication events, and other low-level paths have no MVC result
execution step. They can optionally create through `ProblemDetailsFactory`,
then write through `IProblemDetailsService`. An MVC action filter should usually
assign `context.Result` and return rather than write the response directly.

The controller writer/factory route is not identical to the middleware route.
In particular, a middleware-created `ProblemDetailsContext` can carry the
original `Exception`, while MVC's factory-based customization may rebuild the
context without that exception. Customization still runs; the available
context differs by path.

## JSON defaults do not create an XML service writer

The default service writer is JSON-oriented and emits
`application/problem+json` when request negotiation matches a supported JSON
representation. If no registered writer accepts the request, for example an
XML-only `Accept` header with no XML problem writer, `TryWriteAsync` returns
`false` and the caller owns fallback behavior.

Adding MVC XML output formatters does not by itself add an XML
`IProblemDetailsWriter` to the middleware/service pipeline. That path needs a
custom writer registered before MVC services when it must emit
`application/problem+xml`:

```csharp
builder.Services.AddTransient<IProblemDetailsWriter,
    XmlProblemDetailsWriter>();
builder.Services.AddControllers();
builder.Services.AddProblemDetails();
```

The source's simplified XML writer accepts `application/xml` or
`application/problem+xml`, creates a `problem` element containing `type`,
`title`, `status`, `detail`, and `instance`, sets the problem+xml content type,
and writes the XML. Its string-based `Accept` check demonstrates writer-chain
mechanics; a production implementation should use robust media-type parsing.

## What should be recallable

- What is the difference between `ProblemDetailsFactory`, `IProblemDetailsService`, and `IProblemDetailsWriter`?
- Who must check `Response.HasStarted`?
- Which fields can `ProblemDetailsContext` carry?
- What does `TryWriteAsync(false)` mean?
- Why can content negotiation make every writer decline?
- What does the default JSON writer do before writing?
- How can endpoint metadata make a custom writer opt-in?
- What happens when `CanWrite` returns false?
- How can a writer use `Exception` and endpoint metadata to enrich `ProblemDetails`?
- Why should exception-type diagnostics be reviewed for production?
- When does `CustomizeProblemDetails` apply, and how can manual response writing bypass it?
- What does `AddProblemDetails` register beyond configuring options?
- Why should a customization remain idempotent when factory creation is followed by service writing?
- When should controllers, Minimal APIs, middleware, and MVC filters own response writing?
- Why do MVC XML formatters not provide XML support to `IProblemDetailsService`?
- What must a custom XML writer decide and emit?

## Related knowledge

- `aspnet-core.status-code-pages-and-problem-details`
- `aspnet-core.exception-middleware-response-lifecycle`
- `aspnet-core.exception-handler-features`
- `aspnet-core.endpoint-metadata-and-mvc-action-descriptors`

## Sources

- Workspace: `_ai-conspects/EXCEPTIONHANDLERS/`
- Authoritative processed source: `04-stage4-corrected-source-preserving-transcript.md`, S-009 through S-022 and the service-pipeline boundary in S-023
- Current source of truth: `CURRENT_SOURCE_OF_TRUTH.md`
- Closure evidence: `03-closure-audit.md`
- Provenance caveat: the current SOT says preserved source images remain authoritative, but `_ai-conspects/EXCEPTIONHANDLERS/source/` is not physically resolvable on the current branch
- Workspace: `_ai-conspects/problem details/`
- Authoritative conceptual source: `09-stage9-integrated-study-transcript-v003.md`, sections 3-10
- Original source identity: `problem details.svg`; canonical extracted PNG placements are present, but the full SVG is not tracked or resolvable from the current branch tree (`12-export-canonical-source-instructions-v003.md`)
- Exact screenshot sources: `06-stage6-source-preserving-transcript-pass1-v002.md` and `13-final-near-literal-source-closure-v004.md`; together they certify all 77 unique contents / 86 placements
