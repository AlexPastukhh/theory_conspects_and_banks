# Token validation, signing, and identity deployment

Knowledge ID: `security.token-validation-signing-and-identity-deployment`

Topic: `security`

An API validates an access token's signature, issuer, audience, lifetime, and authorization requirements. Discovery metadata and JWKS provide the identity provider's current public signing keys. Configure name and role claims deliberately; automatic inbound transformations can rename claims and make policies inspect the wrong type.

Production identity deployments need stable protected signing keys or certificates, planned rotation, and correct publication through discovery/JWKS. Developer signing credentials are not a production strategy.

Reverse proxies must forward scheme and host correctly so issuer values, redirects, and HTTPS links match the public origin. Persist client/resource configuration, operational grants, signing material, and Data Protection keys instead of relying on in-memory development state.

```text
public HTTPS origin + exact redirect URIs
-> persistent signing/Data Protection/operational stores
-> discovery and JWKS reachable
-> API validates issuer/audience/signature/lifetime
-> authorization maps only intended claims/scopes
```

Require HTTPS, secure cookies, strict redirect URI matching, and secret rotation.

## Sources

- Workspace: `_ai-conspects/OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties/`
- Authoritative processed source: `13-full-combined-final-transcript.md`, sections 10-11 and 14
- Original SVG: `source/OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties.svg`
- Workspace: `_ai-conspects/jwt auth/`
- Authoritative processed source: `01-final-transcript.md`, R03-R04 (issuer/audience/lifetime/signature validation and high-level JWKS/key rotation)
- Original SVG: `source/jwt auth.svg`
