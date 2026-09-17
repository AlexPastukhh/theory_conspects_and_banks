# BFF token storage and refresh lifecycle

Knowledge ID: `architecture.bff-token-storage-and-refresh-lifecycle`

Topic: `architecture`

A browser-based public client cannot keep a durable client secret. A Backend for Frontend moves OAuth/OIDC protocol handling and tokens to a confidential server component. The browser holds an HttpOnly, Secure session cookie and calls the same-origin BFF; the BFF obtains/refreshes access tokens and calls downstream APIs.

Keeping tokens in the authentication cookie with `SaveTokens` is simple but increases cookie size and sends the protected token material with requests. A server-side ticket/token store keeps only a session key in the cookie. In a multi-instance deployment, the store and Data Protection key ring must be shared and have coordinated expiry and logout cleanup.

Refresh is a state transition, not a blind retry:

```text
read session token set
-> if access token is close to expiry, acquire per-session serialization
-> redeem refresh token
-> atomically replace access + rotated refresh token + expiries
-> release and call API
```

Serializing refresh per session prevents two requests from redeeming the same rotating refresh token. An invalid, revoked, or expired refresh token requires clearing server-side state and starting a new authentication challenge. A downstream `401` may justify one refresh/retry when refresh is possible; never retry indefinitely.

Logout removes both the browser session and corresponding server-side token record. Distributed token updates must be atomic, and record expiration must track the authentication session.

## Sources

- Workspace: `_ai-conspects/OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties/`
- Authoritative processed source: `13-full-combined-final-transcript.md`, sections 3-6
- Original SVG: `source/OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties.svg`
