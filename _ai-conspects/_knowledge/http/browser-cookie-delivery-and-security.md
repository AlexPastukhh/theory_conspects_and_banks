# Browser cookie delivery and security

Knowledge ID: `http.browser-cookie-delivery-and-security`

Topic: `http`

The server emits `Set-Cookie`; the browser stores the value and later attaches it as a `Cookie` header only when name/domain/path/SameSite/Secure rules match. `CookieOptions`/`CookieBuilder` define browser attributes including `Expires`, `MaxAge`, and `IsEssential`, while `CookieAuthenticationOptions` additionally controls authentication-ticket behavior such as events, paths, ticket storage, and sliding expiration. Cookie Policy can apply broader consent and minimum security rules.

`HttpOnly` blocks `document.cookie` access but does not stop automatic request attachment; a non-HttpOnly credential is more exposed to XSS. `Secure` restricts delivery to HTTPS but does not control JavaScript access. Plain HTTP can expose cookie headers and response bodies to observers on the network path, while HTTPS protects the transport. Cookie names and paths must avoid collisions across applications/schemes.

- `SameSite=Strict` has strongest cross-site restriction and greatest navigation friction.
- `Lax` permits same-site use and many top-level navigations but blocks many cross-site background/form cases.
- `None` enables cross-site delivery and requires `Secure` in modern browsers.

CORS credentials and SameSite answer different questions: CORS may permit a credentialed cross-origin request while SameSite still prevents cookie attachment. A credentialed CORS flow needs client credential mode plus an explicit allowed origin and `Access-Control-Allow-Credentials: true`; it cannot use wildcard origin. Even then, `SameSite`, `Secure`, and browser third-party-cookie policy independently decide whether the cookie is sent. First/third-party and partitioned-cookie rules can further scope embedded/iframe flows.

## Sources
- Workspace: `_ai-conspects/cookies-general-theo-plain-cookie-options/`
- Processed source: `regions/R01R02R03-cookies-options-theory-samesite-final.md`, complete transcript
- Workspace: `_ai-conspects/cookie auth, antiforgery/`
- Authoritative processed source: `regions/R02-cookie-authentication-basics-and-browser-semantics.md` and `regions/R03-spa-antiforgery-and-cookie-policy.md`
- Original SVG: `source/cookie auth, antiforgery.svg`
- Workspace: `_ai-conspects/CORS/`
- Authoritative processed source: `regions/R01R02-origin-preflight-aspnet-usecases.md`, R01
- Original SVG: `source/CORS.svg`
- Workspace: `_ai-conspects/donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable/`
- Authoritative processed source: `01-final-transcript.md`, R03 (cookie-authenticated navigation and fetch selection)
- Original SVG: `source/donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable.svg`
- Workspace: `_ai-conspects/jwt auth/`
- Authoritative processed source: `01-final-transcript.md`, R03 (HttpOnly/Secure/SameSite renewal cookie and cross-site credential axes)
- Original SVG: `source/jwt auth.svg`
