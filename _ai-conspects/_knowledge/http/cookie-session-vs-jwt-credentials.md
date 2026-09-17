# Cookie sessions versus JWT credentials

Knowledge ID: `http.cookie-session-vs-jwt-credentials`

Topic: `http`

In classic cookie authentication, login produces a server-side session identifier or encrypted authentication ticket; the browser automatically returns it. This is often the simplest first-party React + ASP.NET Core default: JavaScript need not store the credential, but automatic attachment creates a CSRF boundary requiring antiforgery/SameSite strategy.

A backend-issued JWT is a signed credential explicitly sent as `Authorization: Bearer …`. It suits non-browser clients, shared validation across APIs/services, or a genuine stateless/distributed requirement. Browser-readable local/session storage increases XSS exposure, and JWT revocation is less direct than invalidating server state.

A JWT may instead travel in an HttpOnly cookie. Its semantics remain JWT validation; the cookie is only browser transport. This reduces JavaScript access but restores automatic attachment and therefore CSRF concerns. It can reuse a token format across browser/mobile or services, with short expiry, refresh flow, and possibly deny-lists.

Choose based on concrete portability and validation topology, not fashion. Credential format and transport mechanism are independent decisions.

## Sources
- Workspace: `_ai-conspects/cookies vs tokens sheet jswt in cookies/`
- Processed source: `regions/R01R02-final-coverage.md`, complete transcript

