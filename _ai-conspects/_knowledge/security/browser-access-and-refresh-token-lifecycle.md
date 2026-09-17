# Browser access-token and refresh-session lifecycle

Knowledge ID: `security.browser-access-and-refresh-token-lifecycle`

Topic: `security`

A browser access/refresh design can separate the two credentials:

```text
access token
    short lived
    returned in JSON
    kept in memory
    sent explicitly as Authorization: Bearer

refresh token
    random opaque value
    longer lived than the access token
    stored in a Secure HttpOnly cookie
    rotated and tracked on the server
```

The main HTTP operations are login, refresh, logout, and protected API calls:

```text
POST /api/auth/login
POST /api/auth/refresh
POST /api/auth/logout
GET/POST protected APIs with Authorization: Bearer ...
```

For same-site applications, refresh-cookie settings commonly include `HttpOnly`, `Secure`, and `SameSite=Strict` or `Lax`. A cross-site SPA/API deployment requires deliberate `SameSite=None; Secure` plus credentialed CORS configuration.

## Server issuance and validation

Login validates credentials, creates a signed short-lived access token, generates a random refresh token, stores only its hash and state server-side, and sends the raw refresh value as the cookie. Refresh validates and rotates that cookie token, returns a new access token, and replaces the cookie. Logout revokes the session/family and deletes the cookie.

The bearer handler validates issuer, audience, lifetime, and signing key before protected endpoints run. The token-creation descriptor captures issuer, audience, subject claims, validity window, and signing credentials. Parsing a token is not a substitute for that validation.

## Restore memory state after reload

Because page reload discards the in-memory access token, boot authentication calls the refresh endpoint once:

```text
valid refresh cookie
    -> receive access token
    -> store it in memory
    -> render authenticated application

missing or invalid refresh cookie
    -> render login state
```

JavaScript never needs to read the refresh-token cookie; browser credential handling attaches it to the refresh request.

## Reactive token ownership

React Query can technically own the access token when every reader and writer shares one `QueryClient`, but it is primarily server-state infrastructure. An independent module store can make synchronous API-wrapper access, auth-specific clearing, and UI subscriptions easier to reason about.

Such a store exposes `get`, `set`, `clear`, and `subscribe`. `useSyncExternalStore` lets components observe its current snapshot:

```ts
export function useIsAuthed() {
  return useSyncExternalStore(
    tokenStore.subscribe,
    () => Boolean(tokenStore.get()),
  );
}
```

`subscribe` must register the listener and return its unsubscribe function. When the store changes it notifies listeners, React reads the new snapshot, and the root, navigation, protected routes, and profile UI can update after login, refresh, or logout.

## End-to-end timeline

```text
app starts
    -> boot refresh
    -> store access token when a refresh session exists

login
    -> server sets refresh cookie
    -> client stores access token

normal API call
    -> attach Bearer access token

access token expires
    -> first 401 starts one shared refresh
    -> concurrent 401s await it
    -> refresh cookie rotates
    -> fresh access token is stored
    -> each failed request retries once

logout
    -> server revokes session/family
    -> refresh cookie is deleted
    -> access token and protected cached data are cleared
```

An unbounded `401` retry loop is not part of the model.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`
- `react.use-sync-external-store-contract`
- `security.refresh-token-family-rotation-and-reuse-detection`
- `dotnet.jwt-descriptors-handlers-and-validation`

## What should be recallable

- Why are access and refresh credentials given different lifetimes and browser locations?
- Which operations create, rotate, and revoke the refresh session?
- How is memory auth state restored after reload?
- Why may a dedicated external token store be clearer than a server-state cache?
- How do concurrent expired-access-token failures share one refresh?
- Why does each request retry only once?
- Which client and server state must logout clear?

## Sources

- Workspace: `_ai-conspects/jwt auth/`
- Authoritative processed source: `regions/R01R02R03R04-jwt-auth-corrected-final-v002.md`, R03 plus lifecycle boundaries from R01-R02
- Original SVG: `source/jwt auth.svg`
