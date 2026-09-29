# Cookie and Set-Cookie header models

Knowledge ID: `http.cookie-and-set-cookie`

Topic: `http`

## Core model

The request and response sides use different header models:

```http
Cookie: theme=dark; session=abc

Set-Cookie: session=abc; Path=/; HttpOnly; Secure; SameSite=Lax
```

`Cookie` is a request header containing cookie pairs. `Set-Cookie` is a response header, and multiple cookies are normally emitted as separate field values. They are related stages of browser cookie handling, not interchangeable wire formats.

## Safe framework handling

Read ASP.NET Core request cookies through the parsed collection:

```csharp
Request.Cookies["name"]
```

Create response cookies through response-cookie APIs or `SetCookieHeaderValue`. Typed parsing exposes name/value, domain, path, expiration, `Max-Age`, `Secure`, `HttpOnly`, and `SameSite` without ad-hoc string manipulation.

`CookieHeaderValue` models request `Cookie` data; `SetCookieHeaderValue` models one response `Set-Cookie` value.

## The comma-splitting trap

Do not collapse or split `Set-Cookie` with generic comma-separated-header helpers. Legal attributes such as date values can contain commas, and separate `Set-Cookie` fields must remain separate. Raw strings are useful for diagnostics but unsafe as a parsing strategy for decisions.

## What should be recallable

- How do the request `Cookie` and response `Set-Cookie` formats differ?
- Why must multiple `Set-Cookie` values remain separate?
- Which ASP.NET Core APIs should read and create cookies?
- Why is generic comma splitting unsafe for `Set-Cookie`?
- How do `CookieHeaderValue` and `SetCookieHeaderValue` differ?

## Sources

- Workspace: `_ai-conspects/headers/`
- Integrated source: `FINAL_TRANSCRIPT.md`, section 11 and the `Set-Cookie` rules in sections 9–10
- Regional evidence: `regions/R03-asp-net-core-header-abstractions-stringvalues-operations-and-common-typed-proper.md`, `regions/R04-typed-headers-cookieheadervalue-setcookieheadervalue-and-comparers.md`, and `regions/R05-inspecting-cookies-safely-and-raw-header-limitations.md`
- Original SVG: `source/headers.svg`
