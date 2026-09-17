# Polly retry outcomes, delays, and request metadata

Knowledge ID: `dotnet.polly-retry-outcomes-delays-and-request-metadata`

Topic: `dotnet`

## Handling decisions inspect an outcome

Polly v8 predicates receive arguments containing a `ResilienceContext` and an `Outcome<T>`. The outcome contains either a result or an exception, so retry policy can classify both response status and transport failure without assuming every failure has both.

```csharp
ShouldHandle = args => ValueTask.FromResult(
    args.Outcome.Exception is HttpRequestException ||
    args.Outcome.Result?.StatusCode is
        HttpStatusCode.RequestTimeout or
        HttpStatusCode.TooManyRequests ||
    (int?)args.Outcome.Result?.StatusCode >= 500)
```

Request-aware decisions can inspect `Result.RequestMessage` when a response exists, or typed `ResilienceContext` properties when decisions must also work for exceptions/no-result outcomes.

## DelayGenerator has an explicit fallback contract

A custom delay generator can derive delay from the outcome—for example, a server retry hint. Returning `null` means “use the strategy's normal delay calculation” only where that nullable delegate contract defines the fallback. It does not universally mean zero delay or stop retrying.

Status/exception selection, attempt count, base delay, backoff, jitter, and server hints are related inputs but separate decisions. The final handling path must also define what bubbles after attempts are exhausted.

## What should be recallable

- How `Outcome<T>` represents result-versus-exception.
- Why response metadata is unavailable for some exception outcomes.
- When request data belongs in the response request message versus `ResilienceContext`.
- What a nullable delay-generator result means.
- Why retry classification and final exception/status mapping are separate.

## Sources

- Workspace: `_ai-conspects/shared-polly-cheat-sheet-production-ready-verions-exceptions-from-pipeline-and-handling/`
- Authoritative processed source: `regions/R01R02R07-final-options-hedging-cheatsheet.md`, R01 and R07
- Original SVG: `source/shared-polly-cheat-sheet-production-ready-verions-exceptions-from-pipeline-and-handling.svg`
