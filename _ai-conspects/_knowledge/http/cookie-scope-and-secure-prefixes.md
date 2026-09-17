# Cookie host scope, path, names, and secure prefixes

Knowledge ID: `http.cookie-scope-and-secure-prefixes`

Topic: `http`

## Host and path scope

Cookie scope follows HTTP attributes, not informal browser labels:

- Omitting `Domain` creates a host-only cookie.
- `Domain=.example.com` permits delivery to the parent domain and eligible subdomains.
- `app.example.com` and `admin.example.com` share a parent domain but remain distinct hosts.
- `www` has no protocol-level magic; it is another subdomain.
- `Path` scopes URL paths, not hosts. Authentication cookies commonly use `/` for application-wide delivery.

There is no literal `Host` attribute in `Set-Cookie`. Developer tools may show a host/domain column, but presence versus absence of `Domain` defines the HTTP behavior. Same-site is also not the same as same-origin: a development proxy can make an SPA request browser-visible as same-origin even when it forwards to another backend.

Choose explicit names when applications, schemes, paths, or environments share a domain. Reusing a default name can make one application overwrite or receive another application's cookie and makes debugging harder.

## Browser-enforced prefixes

Cookie name prefixes turn attribute invariants into browser enforcement:

```text
__Secure-  -> requires Secure
__Host-    -> requires Secure, Path=/, and no Domain
```

Invalid combinations can be rejected by the browser. `__Host-` already includes the secure requirement, so do not concatenate both prefixes. A single `__Host-` name with its required attributes is the strongest host-bound form.

The same attributes without a prefix may be valid, but they remain an application convention that another response could weaken accidentally.

## What should be recallable

- How does a host-only cookie differ from one with `Domain=.example.com`?
- Why does `Path` not control subdomain delivery?
- Why can default cookie-name reuse cause collisions?
- Which invariants do `__Secure-` and `__Host-` enforce?
- How can a browser-visible development proxy change cookie-origin reasoning?

## Sources

- Workspace: `_ai-conspects/cookie auth, antiforgery/`
- Authoritative processed source: `regions/R02-cookie-authentication-basics-and-browser-semantics.md` and `regions/R04-cookie-options-domain-path-prefixes-and-format.md`
- Original SVG: `source/cookie auth, antiforgery.svg`
