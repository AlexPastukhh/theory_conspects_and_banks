# Cross-origin embedding and limited browser side channels

Knowledge ID: `security.cross-origin-embedding-and-side-channels`

Topic: `security`

Browser primitives such as `<img>`, `<script>`, `<link>`, navigation, and forms can initiate cross-origin requests even when Fetch/XHR JavaScript would not be allowed to read the response. Request delivery, response readability, and small observable signals are separate capabilities.

An image can trigger a request and may receive cookies subject to SameSite:

```html
<img src="https://bank.com/account/balance" />
```

The embedding origin cannot normally read the response bytes or cross-origin pixels; drawing an unapproved cross-origin image to a canvas taints it. It may still observe limited `load`/`error` or timing differences when the server produces distinguishable responses:

```html
<img
  src="https://bank.com/user/exists?name=alice"
  onload="hit('exists')"
  onerror="hit('nope')"
/>
```

If one case returns compatible image bytes and another returns a 404 or non-image body, the result can reveal a yes/no fact. Redirect differences can leak login state, and cache/timing probes have historically exposed other signals; modern browsers mitigate many techniques, but CORS is not a universal no-read shield against all side channels.

`<script>` is more dangerous because the response is executed as JavaScript. A server that returns sensitive data as executable JavaScript or JSONP can leak it without Fetch/XHR CORS access:

```html
<script src="https://bank.com/api/balance?callback=steal"></script>
<script>
  function steal(data) {
    exfiltrate(data);
  }
</script>
```

Modern APIs should not support JSONP for sensitive data. Return `Content-Type: application/json`, add `X-Content-Type-Options: nosniff`, keep sensitive data out of GET endpoints that can be embedded/executed, and enforce authentication and authorization independently. CORS restricts the standard Fetch/XHR response-access channel; endpoint design must also account for classic tags and observable behavior.

## What should be recallable

- Which classic browser primitives can cause cross-origin requests outside the normal Fetch/XHR read model?
- Why can an image leak a small signal without exposing its response bytes?
- Why can executable JavaScript/JSONP leak much more than an image?
- What roles do JSON media types and `nosniff` play in response hygiene?
- Why does CORS not eliminate redirect, load/error, cache, or timing side channels?

## Related knowledge

- `security.cors-and-antiforgery-boundaries` — request sending, preflight, response access, and CSRF.

## Sources

- Workspace: `_ai-conspects/cors vs anti forgery/`
- Authoritative processed source: `FINAL_TRANSCRIPT.md`, S-012 through S-015 and S-018 through S-020
- Original SVG: `source/cors vs anti forgery.svg`
