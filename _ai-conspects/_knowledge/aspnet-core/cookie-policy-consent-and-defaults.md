# ASP.NET Core cookie policy, consent, and defaults

Knowledge ID: `aspnet-core.cookie-policy-consent-and-defaults`

Topic: `aspnet-core`

`UseCookiePolicy` governs later append/delete operations, so place it before cookie-producing components. It can require consent, normalize SameSite/Secure/HttpOnly, configure the consent cookie, and invoke callbacks. `MinimumSameSitePolicy` raises effective SameSite behavior according to the framework policy matrix; global Secure and HttpOnly policies similarly apply across cookie producers.

`CheckConsentNeeded` gates non-essential appends; `CookieOptions.IsEssential` bypasses that gate only for genuinely necessary cookies. `ConsentCookie` configures the cookie storing the decision, and `ConsentCookieValue` is the marker recognized as consent. Grant, check, and withdrawal must share that configuration. Withdrawal does not automatically remove existing cookies; delete those no longer permitted explicitly.

Global policies apply broadly and can break auth, session, antiforgery, or protocol cookies. Prefer conservative defaults and configure special cookies at their producer when possible.

`UseCookiePolicy` does not inherit `AddCookie` handler settings; it is a later policy layer over append/delete operations. A manual `Response.Cookies.Append` uses `CookieOptions` such as `Path`, `Domain`, `HttpOnly`, boolean `Secure`, `SameSite`, `Expires`, `MaxAge`, and `IsEssential`. The boolean `CookieOptions.Secure` is not the same API type as cookie authentication's `CookieSecurePolicy`.

## Sources

- Workspace: `_ai-conspects/usecookiepolicy/`
- Processed source: `08-full-combined-final-transcript.md`, sections 02–04
- Workspace: `_ai-conspects/cookie auth, antiforgery/`
- Authoritative processed source: `regions/R03-spa-antiforgery-and-cookie-policy.md`
- Original SVG: `source/cookie auth, antiforgery.svg`
