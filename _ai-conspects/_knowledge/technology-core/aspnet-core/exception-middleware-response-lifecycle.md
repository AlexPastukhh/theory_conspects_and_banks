# Exception middleware response lifecycle and status mapping

Knowledge ID: `aspnet-core.exception-middleware-response-lifecycle`

Topic: `aspnet-core`

## Exception middleware owns only the downstream pipeline

A typical application uses the developer exception page only in development and a production exception handler otherwise:

```csharp
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}
else
{
    app.UseExceptionHandler(errorApp =>
    {
        errorApp.Run(async context =>
        {
            // write production error response
        });
    });
}
```

`UseExceptionHandler` wraps the pipeline that runs after the middleware is registered. Exceptions thrown before that point are not inside its protection boundary.

Middleware order therefore determines which failures the handler can observe.

## Detecting an exception and replacing its response are separate capabilities

A production callback can retrieve the captured exception from `IExceptionHandlerFeature` and then build a safe error representation.

That typed feature contract is already covered by `aspnet-core.exception-handler-features`.

The additional lifecycle rule is `HttpResponse.HasStarted`.

```csharp
if (context.Response.HasStarted)
{
    return;
}
```

`HasStarted == true` means the server has already begun sending the response: at least headers, and possibly part of the body.

After that point the application cannot reliably:

- replace the status code;
- replace response headers such as `Content-Type`;
- clear already-sent output;
- replace a partial body with a clean `ProblemDetails` envelope.

The exception may still be observed and logged, but observing a failure does not guarantee that a new HTTP response can be produced.

## Streaming and early writes create a point of no return

Examples that can start the response include:

- a streaming file or large response;
- an early body write such as `Response.BodyWriter.WriteAsync(...)`;
- earlier middleware writing headers or body bytes before a later exception occurs.

Once bytes are on the wire, the server cannot rewind them into a new JSON error response.

The remaining actions may be limited to logging, aborting the connection when appropriate, or writing nothing further.

## Clear stale response state only before the response starts

Before writing a replacement error body, a handler can clear unsent response state:

```csharp
if (context.Response.HasStarted)
{
    return;
}

context.Response.Clear();
context.Response.StatusCode = statusCode;
context.Response.ContentType = "application/problem+json";
```

`Clear()` removes stale headers, content type, and partially prepared response intent, but it is only safe while the response is still replaceable.

A common manual flow creates a `ProblemDetails` object with `ProblemDetailsFactory`, adds safe diagnostics such as `traceId`, clears the response, sets the status/content type, and writes JSON.

Detailed exception text belongs in development output, not ordinary production responses.

## Known exceptions can map to stable HTTP contracts

Unexpected failures normally remain `500 Internal Server Error`.

Known failures can map to more useful API status codes, for example:

```csharp
var statusCode = ex switch
{
    KeyNotFoundException =>
        StatusCodes.Status404NotFound,

    _ =>
        StatusCodes.Status500InternalServerError
};
```

The source also gives domain validation as an example that can map to `422`.

The goal is to distinguish expected lookup/domain failures from unexpected server failures instead of returning 500 for every exception.

## Built-in Problem Details flow versus a manually written handler

`AddProblemDetails(...)` registers an `IProblemDetailsService`.

With the built-in exception handler:

```csharp
app.UseExceptionHandler();
```

and no custom handler body replacing the response, an unhandled exception can flow through that Problem Details service.

A configured `CustomizeProblemDetails` callback is then part of the writer pipeline.

A custom `UseExceptionHandler(errorApp => ...)` callback that writes its own body bypasses that service unless it explicitly invokes it.

If the response has already started, the normal replacement Problem Details flow cannot safely run.

## Default exception output is deliberately generic

When an unhandled exception is written through the standard Problem Details path, the source describes the typical result as:

- status `500` unless mapped differently;
- a generic error title;
- a generic server-error type/default;
- no full production exception detail;
- request path as `instance`;
- diagnostics such as `traceId` in extensions.

Domain-specific mapping, development detail, and extra extensions are application choices.

## What should be recallable

- Why does middleware order determine which exceptions `UseExceptionHandler` can catch?
- What does `Response.HasStarted` mean?
- Why can an exception be observed after response start while the response still cannot be replaced?
- Which kinds of writes can create the response point of no return?
- Why must `Response.Clear()` happen only before the response starts?
- What should production Problem Details avoid exposing?
- Why map `KeyNotFoundException` or domain validation separately from unexpected exceptions?
- When does `CustomizeProblemDetails` participate in exception responses?
- How can a custom exception-handler callback bypass the Problem Details service?
- What does the default unhandled-exception Problem Details response intentionally keep generic?

## Related knowledge

- `aspnet-core.exception-handler-features`
- `aspnet-core.problem-details-writers-context-and-metadata`
- `aspnet-core.status-code-pages-and-problem-details`
- `aspnet-core.middleware-ordering-short-circuit-and-json`
- `aspnet-core.request-response-streams-and-pipelines`

## Sources

- Workspace: `_ai-conspects/EXCEPTIONHANDLERS/`
- Authoritative processed source: `04-stage4-corrected-source-preserving-transcript.md`, S-001/S-002, S-005 through S-008, S-023/S-024
- Current source of truth: `CURRENT_SOURCE_OF_TRUTH.md`
- Closure evidence: `03-closure-audit.md`
- Provenance caveat: the current SOT says preserved source images remain authoritative, but `_ai-conspects/EXCEPTIONHANDLERS/source/` is not physically resolvable on the current branch
- Workspace: `_ai-conspects/filters/`
- Authoritative processed source: `regions/R01-main-filters-theory-ordering-exception-di-factories.md`, S-008, S-023, S-032-S-033, S-038, S-052; `regions/R02R03-concrete-examples-lower-addendum-final.md`, S-113
- Original SVG: `source/filters.svg`
- Workspace: `_ai-conspects/FULL CONTENT NEG + VALIDATION FLOW/`
- Authoritative processed source: `13-corrected-study-transcript-v002.md`, section 5, with exact evidence in `11-exact-canvas-text-transcript-v002.md` R03 and `12-screenshot-evidence-cards-v002.md`, S-020-S-027
- Original SVG: `source/FULL CONTENT NEG + VALIDATION FLOW.svg`
- Workspace: `_ai-conspects/problem details/`
- Authoritative conceptual source: `09-stage9-integrated-study-transcript-v003.md`, sections 7, 11, and 15
- Original source identity: `problem details.svg`; canonical extracted PNG placements are present, but the full SVG is not tracked or resolvable from the current branch tree (`12-export-canonical-source-instructions-v003.md`)
- Exact screenshot sources: `06-stage6-source-preserving-transcript-pass1-v002.md` and `13-final-near-literal-source-closure-v004.md`; together they certify all 77 unique contents / 86 placements
