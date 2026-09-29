# Browser-controlled headers and CORS visibility

Knowledge ID: `http.browser-header-controls-and-cors-visibility`

Topic: `http`

## Core model

Browser networking has distinct controls over which request headers application JavaScript may set and which response headers it may read. Seeing a field in developer tools does not prove that page JavaScript can access it.

`Origin` identifies the normalized scheme, host, and port in relevant fetch/CORS scenarios. Default ports normalize with the scheme; path, query, and fragment are not part of the origin. Treat it as allow-list input, not proof of user identity.

Cross-origin JavaScript can read safelisted response headers plus fields explicitly exposed by the server:

```http
Access-Control-Expose-Headers: X-Correlation-ID, ETag, Content-Disposition
```

Request-header permission and response-header visibility are different concerns. Allowing a request header through `Access-Control-Allow-Headers` does not expose a response header with the same name. For example, a cross-origin download can succeed while JavaScript still cannot read `Content-Disposition` unless the response exposes it.

A CORS policy also separates sending from reading. A simple cross-origin request may reach the server even when the browser hides its response from JavaScript; a non-simple request first needs a successful preflight.

Application metadata placed in a custom response header has the same visibility rule. For example, a cross-origin paging client can read `X-Pagination` only when the response includes `Access-Control-Expose-Headers: X-Pagination`; putting the value in the header does not expose it automatically.

## Browser-controlled request context

`Expect: 100-continue` allows a client to send headers first and wait for the server before transmitting a potentially large body. Browser JavaScript cannot set `Expect` freely because it is a forbidden request header; non-browser clients such as .NET may control it through their client stack.

`Referer` is the historically misspelled field carrying the referring address according to referrer and privacy policy. It may be reduced or absent and must not be trusted as authorization data.

## What should be recallable

- What distinction exists between sending request headers and reading response headers in a browser?
- How does `Access-Control-Expose-Headers` affect cross-origin script visibility?
- Why are developer-tools visibility and JavaScript visibility different?
- What does `Origin` identify, and why is it not identity proof?
- What are the roles and trust limitations of `Expect` and `Referer`?

## Sources

- Workspace: `_ai-conspects/headers/`
- Integrated source: `FINAL_TRANSCRIPT.md`, sections 2, 3, 5, and relevant rules in section 12
- Regional evidence: `regions/R01-location-origin-exposed-response-headers-and-cross-origin-visibility.md` and `regions/R02-expect-referer-authorization-and-www-authenticate-realm.md`
- Original SVG: `source/headers.svg`
- Workspace: `_ai-conspects/CORS/`
- Authoritative processed source: `regions/R01R02-origin-preflight-aspnet-usecases.md` and `regions/R03R04R05-policy-builder-headers-middleware.md`, R01-R04
- Original SVG: `source/CORS.svg`
- Workspace: `_ai-conspects/PAGING/`
- Authoritative processed source: `01-final-transcript.md`, R03
- Original SVG: `source/PAGING.svg`
