# Vary: Origin and CORS cache variants

Knowledge ID: `http.vary-origin-cache-variants`

Topic: `http`

## Core model

When a server reflects an allowed request origin in its response, the CORS response varies according to the request's `Origin`:

```http
Access-Control-Allow-Origin: https://app.example
Vary: Origin
```

Without `Vary: Origin`, a shared cache may reuse a response produced for one origin while serving another origin.

The reflected value is one exact allowed origin, not a comma-separated list. A disallowed origin receives no permissive `Access-Control-Allow-Origin` value.

```text
same URL
same controller/action
different Origin header
different CORS response variant
```

`Vary` is cumulative. Adding `Origin` must not discard an existing dimension:

```http
Vary: Accept-Encoding, Origin
```

## Credentials constraint

A credentialed CORS response cannot combine these values:

```http
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
```

Use an explicit allowed origin when credentials are enabled.

## What should be recallable

- Why does reflecting an allowed origin require `Vary: Origin`?
- What incorrect behavior can a shared cache produce without it?
- Why must a new `Vary` dimension be appended rather than overwrite existing values?
- Why is wildcard origin invalid for a credentialed CORS response?

## Related knowledge

- `http.options-and-cors-preflight` — the request and response exchange that precedes a non-simple cross-origin request.

## Sources

- Workspace: `_ai-conspects/options requ/`
- Processed source: `01-final-transcript.md`, R03 — `Vary: Origin`
- Original SVG: `source/options requ.svg`
- Workspace: `_ai-conspects/CORS/`
- Authoritative processed source: `regions/R03R04R05-policy-builder-headers-middleware.md`, R04 and R05
- Original SVG: `source/CORS.svg`
