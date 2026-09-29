# CORS and antiforgery solve different browser boundaries

Knowledge ID: `security.cors-and-antiforgery-boundaries`

Topic: `security`

CORS controls cross-origin browser JavaScript access to responses and gates non-simple requests through preflight. Antiforgery validates intent for unsafe cookie-authenticated requests. Authentication and authorization remain separate requirements.

```text
CORS          -> may cross-origin JavaScript send/read this request/response flow?
antiforgery   -> did an unsafe cookie-authenticated request carry the trusted-origin token?
authentication -> who is the caller?
authorization  -> may that caller perform the operation?
```

CORS is not a universal server-side boundary that prevents every cross-site request. A classic form can submit to another origin without using Fetch/XHR CORS:

```html
<form action="https://bank.com/transfer" method="POST">
  <input name="to" value="attacker" />
  <input name="amount" value="1000" />
</form>
<script>document.forms[0].submit()</script>
```

If the victim is signed in with a cookie, the browser may attach it subject to `SameSite`. The attacker does not need to read the result; causing the state change is enough. That is why cookie-authenticated unsafe endpoints need antiforgery tokens, appropriate SameSite policy, and optionally origin checks rather than relying on CORS.

CORS is browser enforcement for script response access; it does not stop arbitrary HTTP clients, malware, phishing, or failures in DNS/TLS trust. Those threats need authentication, authorization, transport security, host/origin validation where appropriate, and separate user/security controls.

## Sending and reading are separate

Without an appropriate `Access-Control-Allow-Origin` response (and credentials approval for a credentialed request), cross-origin Fetch/XHR JavaScript cannot read the response. The request can still reach the server in cases that do not require a successful preflight. The browser can therefore hide the response from the attacker after the server has already changed state.

For a non-simple request such as JSON POST:

```js
fetch("https://api.bank.com/payments", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ amount: 10 }),
  credentials: "include"
});
```

the browser first sends `OPTIONS`. If the server does not approve the requested origin/method/headers, the preflight fails and the actual POST is not sent. By contrast, a CORS-simple request or classic form can be sent without that preflight; absent response permission then prevents reading rather than the state change.

This distinction yields the practical rule:

```text
failed required preflight -> actual non-simple request is not sent
simple/form request       -> can reach server; response may remain unreadable
```

When the browser blocks the cross-origin flow, Fetch commonly rejects with a generic network-style `TypeError`; application code may not receive the server's ordinary status/body. That symptom does not by itself tell whether a required preflight stopped the actual request or an actual response was later hidden.

Do not expose sensitive changes through GET. Require authentication/authorization, use antiforgery for unsafe cookie flows, apply deliberate SameSite/origin policy, and do not treat secret URLs as authorization.

## What should be recallable

- Which distinct questions do CORS, antiforgery, authentication, and authorization answer?
- Why can a form-based CSRF attack work without CORS permission?
- When does failed CORS preflight prevent the actual request?
- When can a request change server state even though JavaScript cannot read its response?
- Why is CORS not a substitute for antiforgery on cookie-authenticated unsafe endpoints?

## Related knowledge

- `http.options-and-cors-preflight` — the wire exchange for a non-simple cross-origin request.
- `aspnet-core.antiforgery-token-lifecycle` — paired cookie/request-token mechanics.
- `security.cross-origin-embedding-and-side-channels` — requests and limited leakage through classic browser primitives.

## Sources

- Workspace: `_ai-conspects/cors vs anti forgery/`
- Authoritative processed source: `FINAL_TRANSCRIPT.md`, S-001 through S-004, S-008 through S-011, S-014, S-016 through S-017, and the integrated conclusion
- Original SVG: `source/cors vs anti forgery.svg`
- Workspace: `_ai-conspects/CORS/`
- Authoritative processed source: `regions/R01R02-origin-preflight-aspnet-usecases.md`, R01 and R02
- Original SVG: `source/CORS.svg`
