# Polly HTTP policy helpers and HttpClient integration

Knowledge ID: `dotnet.polly-http-policy-helpers-and-httpclient-integration`

Topic: `dotnet`

## Classic helpers have a precise default scope

Classic `HttpPolicyExtensions.HandleTransientHttpError()` is an opinionated shortcut for:

- `HttpRequestException`;
- HTTP `5xx` responses;
- HTTP `408 Request Timeout`.

It does not mean every response an application might call transient. Additional status handling must be explicit, and non-retryable failures should bubble to the caller's mapping/handling boundary.

Classic policies can be composed from retry, timeout, circuit breaker, fallback, and bulkhead, then attached with `AddPolicyHandler` or resolved from a registry. A request-aware selector can choose a policy from request information before execution.

Newer resilience handlers/pipelines express classification with `ShouldHandle` and outcome/context callbacks. Migrating syntax does not remove the core obligations: define the handled set, order strategies, recreate non-replayable bodies, and state the final outcome after exhaustion.

## What should be recallable

- Exactly which failures `HandleTransientHttpError()` handles by default.
- Why “transient” remains an application policy outside that helper.
- How classic policies attach to an `HttpClient` handler pipeline.
- Why request-dependent policy selection occurs before executing the chosen policy.
- Which correctness questions remain when moving to newer pipelines.

## Sources

- Workspace: `_ai-conspects/shared-polly-cheat-sheet-production-ready-verions-exceptions-from-pipeline-and-handling/`
- Authoritative processed source: `regions/R04R05R06-manual-classic-exception-bubbling.md`, R04/R05 and R06 boundary; `regions/R01R02R07-final-options-hedging-cheatsheet.md`, R02/R07 standard/custom and production mapping
- Original SVG: `source/shared-polly-cheat-sheet-production-ready-verions-exceptions-from-pipeline-and-handling.svg`
