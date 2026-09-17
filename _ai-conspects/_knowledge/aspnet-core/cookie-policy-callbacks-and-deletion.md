# Cookie policy callbacks and deletion symmetry

Knowledge ID: `aspnet-core.cookie-policy-callbacks-and-deletion`

Topic: `aspnet-core`

`OnAppendCookie` can inspect name, value, request context, and mutable options; enforce global invariants, alter attributes, suppress appends, or apply request-dependent compatibility. Use it only for genuinely global or otherwise inaccessible producers.

Deletion sends an expired `Set-Cookie`. Name, path, and domain must match the original cookie. `OnDeleteCookie` can normalize options, but changing path/domain can prevent deletion. Keep append/delete policy symmetrical, preferably through a shared options factory. Removing the browser cookie does not revoke a server-side session/token.

Keep callbacks small, deterministic, and tested across consent suppression, essential cookies, delete matching, and cross-site SameSite flows. Prefer dedicated component options and local factories for ordinary cases.

## Sources

- Workspace: `_ai-conspects/usecookiepolicy/`
- Processed source: `08-full-combined-final-transcript.md`, sections 05–07
