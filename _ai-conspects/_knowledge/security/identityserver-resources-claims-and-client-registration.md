# IdentityServer resources, claims, and client registration

Knowledge ID: `security.identityserver-resources-claims-and-client-registration`

Topic: `security`

Identity resources describe identity claims requested through OIDC scopes, such as `openid`, profile, or email. API scopes describe permissions a client requests for an API. API resources describe the protected API/audience and can associate claims with access tokens. Keep the concepts separate: a claim describes the subject/client; a scope is delegated permission; an audience identifies the intended resource server.

`IProfileService` selects claims for the current subject, client, requested claim types, and authorization context. Claims may be placed in the ID token, access token, or UserInfo according to configuration. Keeping the ID token compact and retrieving additional permitted profile claims through UserInfo can be useful; registering a scope alone does not guarantee every desired claim is emitted.

Client registration must match the client type and flow:

- interactive server clients use authorization code, exact redirect/post-logout URIs, and confidential credentials;
- browser/native public clients use code + PKCE and no trusted static secret;
- machine clients use client credentials and no user identity;
- allowed scopes should be the minimal identity/API permissions required;
- token lifetimes are part of the client registration and should match the client and grant.

Do not confuse a client secret with user authentication or PKCE, and do not grant broad scopes merely because the client can request them.

For step-up authorization, request only baseline scopes during normal login. When a sensitive operation needs more permission:

```text
inspect currently granted scopes
-> challenge for the additional scope and consent
-> receive a token reflecting the added permission
-> require that permission in the API policy
```

Both the resulting access token and the protected API policy must reflect the extra scope.

## Sources

- Workspace: `_ai-conspects/OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties/`
- Authoritative processed source: `13-full-combined-final-transcript.md`, sections 7-9 and 13
- Original SVG: `source/OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties.svg`
