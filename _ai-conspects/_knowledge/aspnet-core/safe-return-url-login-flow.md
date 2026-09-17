# Safe returnUrl flow for Razor login

Knowledge ID: `aspnet-core.safe-return-url-login-flow`

Topic: `aspnet-core`

A login flow can preserve the page the user originally requested, but the eventual redirect must not trust arbitrary input.

On GET, accept an optional `returnUrl` and pass it to the Razor view through a view model or `ViewData`. Persist it through the login form in a hidden input and include antiforgery protection.

On POST, authenticate first. Redirect only when `Url.IsLocalUrl(returnUrl)` succeeds; otherwise fall back to a known local route. Never blindly redirect to an attacker-controlled absolute URL, because that creates an open redirect.

```text
GET /login?returnUrl=...
  -> preserve returnUrl in view/form
  -> antiforgery-protected POST
  -> authenticate
  -> local URL: redirect there
  -> nonlocal/missing URL: redirect to safe fallback
```

The hidden field preserves state but supplies no trust. Local-URL validation at the redirect decision is the security boundary.

## What should be recallable

- How GET, hidden form state, antiforgery, POST authentication, and redirect compose.
- Why hidden input does not make `returnUrl` trustworthy.
- How `Url.IsLocalUrl` prevents an open redirect and when the fallback is used.

## Sources

- Workspace: `_ai-conspects/return url implementation razor/`
- Processed source: `regions/final-transcript.md`, complete structured transcript
- Original SVG: `source/return url implementation razor.svg`
