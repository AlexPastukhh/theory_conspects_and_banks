# reCAPTCHA server verification and risk policy

Knowledge ID: `security.recaptcha-server-verification-and-risk-policy`

Topic: `security`

reCAPTCHA is an abuse signal for public operations such as registration, login, password reset, contact forms, and comments. It is not authentication and does not replace validation, rate limiting, account lockout, or authorization.

## The browser obtains a token; the server decides

```text
public site key in browser
-> v2 challenge or v3 execute(action)
-> short-lived token
-> application request
-> server posts secret + token to Google siteverify
-> application validates response and applies its own policy
```

The site key is intentionally public and may appear in HTML, JavaScript, environment-provided frontend configuration, or a site-key-only API response. The secret key belongs only on the server and should come from User Secrets, environment variables, or a secrets manager—not source control or a client-accessible configuration endpoint.

A client callback or non-empty token proves nothing by itself. Treat the token as untrusted request data until the application server verifies it with Google's private-key endpoint.

## Keep the verification protocol behind a service

An ASP.NET Core controller can depend on an `IRecaptchaVerifier`, while a typed client owns the form-encoded call to `https://www.google.com/recaptcha/api/siteverify`:

```csharp
builder.Services.AddHttpClient<
    IRecaptchaVerifier,
    GoogleRecaptchaVerifier>();
```

The request always carries `secret` and `response`; `remoteip` is optional. Reject an empty token, fail fast when server secret configuration is missing, check the HTTP response, and deserialize a response model containing the fields the policy needs:

```text
success
challenge_ts
hostname
error-codes
score       (v3)
action      (v3)
```

Map Google's hyphenated `error-codes` name explicitly instead of inventing multiple competing DTO properties.

## v2 and v3 have different acceptance rules

For a v2 checkbox, require `success`; preferably also enforce the expected hostname and a reasonable token age. Handle Google/network failure as a denied or unavailable verification according to endpoint policy.

For v3, `success` alone is insufficient. Also require:

- the exact endpoint action, compared ordinally;
- a score decision tuned for that operation;
- preferably an exact allowed hostname;
- a sufficiently recent challenge timestamp when age is part of policy.

An action such as `register` binds a token to its intended operation. Do not accept a token minted for another action. A score is not a universal Google-defined pass/fail value; use bands such as allow, add friction, or require a stronger v2 challenge, and tune them from observed traffic.

## Validate origin and token lifecycle

Google returns a hostname such as `example.com`, `www.example.com`, or `localhost`—not a URL with scheme or path. Compare it against an explicit host allowlist, typically case-insensitively. Avoid broad suffix checks that accidentally admit unrelated domains.

Generate v3 tokens immediately before the protected operation. Treat both versions' tokens as short-lived and effectively single-use for application UX: after a rejected v2 submission reset the widget, and after a failed v3 attempt execute again rather than reusing an old token.

## ASP.NET Core and Razor boundary

For v2, a Razor view loads Google's `api.js` and renders `<div class="g-recaptcha" data-sitekey="...">`. The widget submits the fixed field `g-recaptcha-response`. Because dashes do not map naturally to a C# identifier, read it from `Request.Form` or configure explicit binding. Verify before performing registration work. If the action returns the Razor view after failure, restore the public site key required to render it again.

For v3, pause form submission, call `grecaptcha.execute(siteKey, { action: "register" })`, place the result in a hidden model-bound token field, and then submit. The POST passes the same expected action to the verifier and applies its configured score policy. Anti-forgery protection remains necessary because CAPTCHA and CSRF solve different problems.

Return a generic failure on sensitive forms. Detailed distinctions such as “bot detected” versus “email exists” can leak account or policy information; log diagnostic error codes and correlation data server-side instead.

A separate frontend can obtain the public value from a narrow configuration endpoint such as `GET /api/config/recaptcha-site-key`, backed by an options object and returning only `{ siteKey }`. Never return the secret through the same options projection.

## What should be recallable

- Which key is public, and which key establishes server trust?
- Why is a browser success callback insufficient?
- Which fields are posted to `siteverify`, and which response fields matter?
- How do v2 and v3 acceptance rules differ?
- Why must v3 action and score be checked separately from success?
- How should hostname and token age be validated?
- Why should tokens be freshly generated or reset after failure?
- Why do rate limiting, lockout, validation, and anti-forgery remain necessary?
- What belongs in the verifier service rather than the controller?

## Related knowledge

- `aspnet-core.account-lockout-and-failed-login-throttling`
- `security.cors-and-antiforgery-boundaries`
- `aspnet-core.basic-authentication-handler-and-clients`
- `aspnet-core.forwarded-headers-and-client-ip-trust`

## Sources

- Workspace: `_ai-conspects/google recapcha and recapchas/`
- Authoritative processed source: `03-source-preserving-transcript-v003.md`, S-001-S-018, S-024, S-032-S-043, S-059-S-065, S-068-S-077
- Semantic reconciliation: `04-full-svg-semantic-transcript-v002.md`, R01-R03
- Original SVG: `source/source-complete-v002.svg`
