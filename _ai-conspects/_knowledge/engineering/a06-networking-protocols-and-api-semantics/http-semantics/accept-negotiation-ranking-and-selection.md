# Accept negotiation ranking and deterministic selection

Knowledge ID: `http.accept-negotiation-ranking-and-selection`

Topic: `http`

An `Accept` header can contain several media ranges. A server-side helper should parse those preferences and select only a representation the server can actually produce:

```text
Accept values
+ supported output media types
+ optional server preference
-> selected representation or explicit no-match result
```

Examples include exact types, vendor types, type/global wildcards, structured suffix ranges, and quality values:

```text
application/json
application/vnd.example+json;q=0.9
application/*;q=0.8
*/*;q=0.1
```

`q=1` is the default preference and `q=0` means not acceptable. Missing or broad input commonly falls back to the server default; a specific unsupported request can produce `406 Not Acceptable` under a strict policy.

## Parse and build candidates

Keep each parsed range's type, subtype, parameters, quality, and original header index. Invalid syntax is a policy choice: a helper may skip invalid fragments or return a structured invalid result, but parser failures must not escape into controller code. When the API contract distinguishes malformed syntax from a valid no-match, return a structured outcome such as `Selected`, `InvalidSyntax`, or `NotAcceptable`; a boolean `TrySelect` result cannot preserve the `400` versus `406` boundary. Under a documented skip-invalid policy, fail only when no valid acceptable supported match remains.

In .NET, `MediaTypeHeaderValue.TryParse` is for one media-type value, while `TryParseList` handles the complete comma-separated `Accept` list. A custom negotiator must parse the list as a list rather than passing it to the single-value API.

Match each acceptable range against the supported output types and record enough information to rank it:

```text
Accept candidate
supported media type
q value
specificity
server preference index
header index
```

The supported-output list must contain only concrete representations the server can emit. `application/*` and `*/*` are client matching ranges, not valid selected response `Content-Type` values. Let those ranges match concrete server entries instead of inserting wildcards into the server preference list.

Possible match classes include:

```text
application/json  -> application/json          exact
application/*     -> application/json          type wildcard
*/*               -> application/json          global wildcard
application/*+json -> application/vnd.x+json   structured suffix
```

A specific `q=0` exclusion must not be bypassed through a broader wildcard. For example, the source policy must not choose JSON from `*/*;q=0.8` when `application/json;q=0` explicitly excludes it.

## Choose the winner

Use a deterministic ordering:

```text
1. higher client q
2. more specific match
3. earlier server-supported preference
4. original Accept-header order
```

At equal quality, an exact or vendor media type beats `application/*`, which beats `*/*`. When the client is equally happy with JSON and XML, the server's declared order provides a stable policy. Header order is a final tie-break rather than the primary rule.

The result should carry more than a raw string when later code needs the distinction:

```text
success / no match
selected media type
representation family or primary type
include-links/HATEOAS flag
diagnostic no-match reason
```

A vendor type such as `application/vnd.myapi.product+json` can select the JSON representation family while preserving the full negotiated media type. If one representation adds hypermedia links, the result can carry `includeLinks` instead of making every controller repeat string comparisons.

## Controller boundary and tests

```text
helper           -> parse, match, rank, select
controller       -> map selection/no-match to response shape and status
output formatter -> perform serialization
```

```csharp
var selected = preference.TrySelect(Request.Headers.Accept, supportedTypes);
if (!selected.Success)
    return StatusCode(StatusCodes.Status406NotAcceptable);

return selected.IncludeLinks ? linkedDto : plainDto;
```

Test multiple values, equal-q specificity, wildcard plus exact `q=0`, unsupported exact types, structured `+json` suffixes, server/header tie-breaks, missing input, invalid fragments, the selected full/primary media type, link flags, and no-match reasons. Keeping candidate construction separate from sorting makes these rules testable without controller infrastructure.

## What should be recallable

- What do missing `q`, `q=0`, and higher q values mean?
- Why may the server choose only from its supported representations?
- Why must the server preference list contain concrete media types rather than wildcards?
- Which fields must survive parsing for deterministic ranking?
- How do exact, type-wildcard, global-wildcard, and `+json` matches differ?
- Why must a specific `q=0` exclusion constrain a broader wildcard?
- Which four tie-break levels select the winner?
- Which responsibilities belong to the helper, controller, and formatter?

## Sources

- Workspace: `_ai-conspects/qs-preference-with-multiple-accept-header-values-helper/`
- Authoritative processed sources: `regions/R01-accept-header-negotiation-result-and-supported-types.md` through `regions/R04-controller-integration-edge-cases-and-tests.md`
- Original SVG: `source/qs-preference-with-multiple-accept-header-values-helper.svg`
- Workspace: `_ai-conspects/CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON/`
- Authoritative processed source: `01-final-transcript.md`, R02
- Original SVG: `source/CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON.svg`
- Workspace: `_ai-conspects/FULL CONTENT NEG + VALIDATION FLOW/`
- Authoritative processed source: `13-corrected-study-transcript-v002.md`, sections 6-7, with exact native text and screenshot evidence in `11-exact-canvas-text-transcript-v002.md` and `12-screenshot-evidence-cards-v002.md`
- Original SVG: `source/FULL CONTENT NEG + VALIDATION FLOW.svg`
