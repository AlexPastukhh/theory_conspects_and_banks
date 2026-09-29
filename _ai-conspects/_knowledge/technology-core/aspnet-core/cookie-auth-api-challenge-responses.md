# Cookie authentication responses for pages and APIs

Knowledge ID: `aspnet-core.cookie-auth-api-challenge-responses`

Topic: `aspnet-core`

Cookie authentication normally redirects challenge/forbid to login/access-denied pages. That suits interactive MVC/Razor navigation but not JSON APIs. Through a dev proxy, a backend `302` with an absolute login `Location` can be followed cross-origin, fail CORS, or return HTML where the client expects JSON.

In cookie events, keep redirects for page endpoints and classify API endpoints with stable metadata (or a path prefix when necessary). API challenge returns `401`; an authenticated user lacking permission returns `403`. Create `ProblemDetails` through `ProblemDetailsFactory` and write through `IProblemDetailsService` so configured writers/defaults participate:

```csharp
var written = await problemDetailsService.TryWriteAsync(
    new ProblemDetailsContext { HttpContext = http, ProblemDetails = problem });

if (!written) {
    http.Response.ContentType = "application/problem+json";
    await http.Response.WriteAsJsonAsync(problem);
}
```

Choose redirect or JSON once, then stop the event/pipeline path. Validate custom return URLs as local, avoid sensitive authentication detail, and keep status/body aligned.

Only one component should own the response body. An authentication event can translate an API challenge/forbid into Problem Details; a resource authorization handler still owns a resource-specific policy denial. Set the status before writing, write once, and do not continue into a second redirect/body path.

## What should be recallable

- Explain the core model of **Cookie authentication responses for pages and APIs** without opening the Unit.
- Reconstruct this Unit-grounded rule: Cookie authentication normally redirects challenge/forbid to login/access-denied pages.
- Reconstruct this Unit-grounded rule: In cookie events, keep redirects for page endpoints and classify API endpoints with stable metadata (or a path prefix when necessary).
- Reconstruct this Unit-grounded rule: Choose redirect or JSON once, then stop the event/pipeline path.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources
- Workspace: `_ai-conspects/cookies auth ON REDIRECT  probmem details returning/`
- Processed source: `regions/R01-cookie-auth-redirects-api-problemdetails-final.md`, complete transcript
- Workspace: `_ai-conspects/CORS/`
- Authoritative processed source: `regions/R01R02-origin-preflight-aspnet-usecases.md`, R02
- Original SVG: `source/CORS.svg`
- Workspace: `_ai-conspects/AUTH EVENTS/`
- Authoritative processed source: `02-corrected-semantic-transcript-v002.md`, R01 and R03
- Original SVG: `source/AUTH EVENTS.svg`
- Workspace: `_ai-conspects/problem details/`
- Authoritative conceptual source: `09-stage9-integrated-study-transcript-v003.md`, section 12
- Original source identity: `problem details.svg`; canonical extracted PNG placements are present, but the full SVG is not tracked or resolvable from the current branch tree (`12-export-canonical-source-instructions-v003.md`)
- Exact screenshot sources: `06-stage6-source-preserving-transcript-pass1-v002.md` and `13-final-near-literal-source-closure-v004.md`; together they certify all 77 unique contents / 86 placements
