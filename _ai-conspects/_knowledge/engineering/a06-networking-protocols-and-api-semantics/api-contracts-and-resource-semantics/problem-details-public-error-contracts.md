# Problem Details as a public error contract

Knowledge ID: `http.problem-details-public-error-contracts`

Topic: `http`

`application/problem+json` gives clients one stable error representation:

```text
type      -> stable problem-category/documentation URI
title     -> short public summary
status    -> HTTP status
detail    -> safe occurrence-specific explanation
instance  -> request/occurrence identifier
extensions-> traceId, stable application code, other public metadata
```

These fields belong to the API contract, not merely generic descriptions of status codes. A consistent shape helps web, mobile, and service clients; a trace identifier connects public failure to private logs; stable types/codes make errors actionable; and ASP.NET Core validation can share the same family of response.

Problem Details is especially useful for validation/client mistakes, unexpected 5xx responses, multi-client APIs, and public versioned contracts. A detailed body can be lower-value for prototypes, intentionally minimal first-party contracts, responses whose body cannot be changed because it started, or clients that ignore it (some redirects, HEAD, and browser-driven challenges). Status and headers remain a valid contract even with no body.

Never expose production stack traces, connection strings, secrets, raw SQL, internal paths, or unsafe raw exception messages. Prefer a generic public title/detail, stable error code, `traceId`, and documentation URI; retain implementation diagnostics only in correlated logs.

The status still carries HTTP semantics and related headers remain part of the contract: `401` means no acceptable authenticated principal, `403` means authenticated but forbidden, `405` should preserve `Allow`, `406` concerns `Accept`, and `415` concerns request `Content-Type`. `409` fits a current-state conflict; an API may use `400` or a documented `422` policy for validation after parsing. Problem Details does not choose these meanings automatically.

## What should be recallable

- What does each standard Problem Details field communicate?
- Why are stable type/code and traceId useful to different audiences?
- When can an empty error body still be deliberate?
- Which diagnostics must never cross the public error boundary?

## Sources

- Workspace: `_ai-conspects/REST API BASICS/`
- Authoritative processed source: `regions/R02-problem-details-error-contracts.md`
- Original SVG: `source/REST API BASICS.svg`
- Workspace: `_ai-conspects/problem details/`
- Authoritative conceptual source: `09-stage9-integrated-study-transcript-v003.md`, sections 1-2, 11-17
- Original source identity: `problem details.svg`; canonical extracted PNG placements are present, but the full SVG is not tracked or resolvable from the current branch tree (`12-export-canonical-source-instructions-v003.md`)
- Exact screenshot sources: `06-stage6-source-preserving-transcript-pass1-v002.md` and `13-final-near-literal-source-closure-v004.md`; together they certify all 77 unique contents / 86 placements
