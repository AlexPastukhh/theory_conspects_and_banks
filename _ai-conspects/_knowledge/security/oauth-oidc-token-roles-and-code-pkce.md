# OAuth, OIDC, token roles, and authorization code with PKCE

Knowledge ID: `security.oauth-oidc-token-roles-and-code-pkce`

Topic: `security`

OAuth 2.x delegates access to an API; OpenID Connect adds authentication and identity claims. The resource owner uses a client, the authorization server issues tokens, and the resource server validates an access token. An ID token tells the client about the authentication event; it is not the API credential. An access token authorizes API calls. A refresh token obtains a new token set and needs stronger storage, rotation, and revocation handling.

Authorization Code with PKCE keeps the authorization response free of access tokens:

```text
client creates verifier + challenge, state, nonce
-> browser authorization request carries challenge/state/nonce
-> authorization server authenticates/consents
-> callback receives the short-lived authorization code
-> back channel sends code + verifier (+ client auth for confidential client)
-> token endpoint validates redirect URI/code/verifier/client/grant and returns tokens
```

The request carries `state` and `nonce`. PKCE binds authorization request and code redemption through the challenge/verifier pair. A confidential client also authenticates at the token endpoint; a public client cannot safely keep a static secret.

PKCE does not replace confidential-client authentication and does not by itself protect browser-held tokens from XSS.

## Sources

- Workspace: `_ai-conspects/OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties/`
- Authoritative processed source: `13-full-combined-final-transcript.md`, sections 1-3
- Original SVG: `source/OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties.svg`
