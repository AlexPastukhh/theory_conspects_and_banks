# A12 — Security & Identity

This index is a physical/navigation projection. Finer semantic placement remains in the semantic hierarchy.

## Application & Browser Security

### Area-owned Units

- [`aspnet-core.cookie-policy-callbacks-and-deletion` — Cookie policy callbacks and deletion symmetry](application-and-browser-security/cookie-policy-callbacks-and-deletion.md)
- [`security.cors-and-antiforgery-boundaries` — CORS and antiforgery solve different browser boundaries](application-and-browser-security/cors-and-antiforgery-boundaries.md)
- [`security.cross-origin-embedding-and-side-channels` — Cross-origin embedding and limited browser side channels](application-and-browser-security/cross-origin-embedding-and-side-channels.md)
- [`security.csp-trusted-types-and-browser-storage-boundaries` — CSP, Trusted Types, and browser-storage boundaries](application-and-browser-security/csp-trusted-types-and-browser-storage-boundaries.md)
- [`security.html-sanitization-and-contextual-output` — HTML sanitization and contextual output](application-and-browser-security/html-sanitization-and-contextual-output.md)
- [`security.recaptcha-server-verification-and-risk-policy` — reCAPTCHA server verification and risk policy](application-and-browser-security/recaptcha-server-verification-and-risk-policy.md)
- [`aspnet-core.safe-return-url-login-flow` — Safe returnUrl flow for Razor login](application-and-browser-security/safe-return-url-login-flow.md)
- [`security.xss-sources-sinks-and-attack-flows` — XSS sources, sinks, and attack flows](application-and-browser-security/xss-sources-sinks-and-attack-flows.md)

### Technology Core links

- [`aspnet-core.antiforgery-token-lifecycle` — ASP.NET Core antiforgery token lifecycle](../../technology-core/aspnet-core/antiforgery-token-lifecycle.md)
- [`react.recaptcha-v2-v3-widget-and-token-lifecycle` — React reCAPTCHA v2/v3 widget and token lifecycle](../../technology-core/react/recaptcha-v2-v3-widget-and-token-lifecycle.md)

## Cryptography & Credential Protection

### Area-owned Units

- [`security.jwt-signing-keys-kid-and-jwks-rotation` — JWT signing keys, KID, and JWKS rotation](cryptography-and-credential-protection/jwt-signing-keys-kid-and-jwks-rotation.md)
- [`dotnet.password-hashing-verification-and-upgrades` — Password hashing, verification, and upgrades](cryptography-and-credential-protection/password-hashing-verification-and-upgrades.md)
- [`dotnet.totp-secret-generation-and-base32-encoding` — TOTP secret generation and Base32 encoding](cryptography-and-credential-protection/totp-secret-generation-and-base32-encoding.md)

### Technology Core links

- [`aspnet-core.data-protection-reset-tokens` — Data Protection password-reset tokens](../../technology-core/aspnet-core/data-protection-reset-tokens.md)
- [`dotnet.cryptographic-randomness-and-unbiased-ranges` — Cryptographic randomness and unbiased ranges](../../technology-core/dotnet/cryptographic-randomness-and-unbiased-ranges.md)

## Identity & Access

### Area-owned Units

- [`aspnet-core.account-activation-email-confirmation-flow` — Account activation email confirmation flow](identity-and-access/account-activation-email-confirmation-flow.md)
- [`aspnet-core.account-lockout-and-failed-login-throttling` — Account lockout and failed-login throttling](identity-and-access/account-lockout-and-failed-login-throttling.md)
- [`architecture.bff-token-storage-and-refresh-lifecycle` — BFF token storage and refresh lifecycle](identity-and-access/bff-token-storage-and-refresh-lifecycle.md)
- [`security.browser-access-and-refresh-token-lifecycle` — Browser access-token and refresh-session lifecycle](identity-and-access/browser-access-and-refresh-token-lifecycle.md)
- [`security.identityserver-resources-claims-and-client-registration` — IdentityServer resources, claims, and client registration](identity-and-access/identityserver-resources-claims-and-client-registration.md)
- [`dotnet.jwt-descriptors-handlers-and-validation` — JWT descriptors, handlers, and validation in .NET](identity-and-access/jwt-descriptors-handlers-and-validation.md)
- [`security.mfa-factor-selection-trusted-devices-and-recovery` — MFA factor selection, trusted devices, and recovery](identity-and-access/mfa-factor-selection-trusted-devices-and-recovery.md)
- [`security.oauth-oidc-token-roles-and-code-pkce` — OAuth, OIDC, token roles, and authorization code with PKCE](identity-and-access/oauth-oidc-token-roles-and-code-pkce.md)
- [`security.refresh-token-family-rotation-and-reuse-detection` — Refresh-token family rotation and reuse detection](identity-and-access/refresh-token-family-rotation-and-reuse-detection.md)
- [`dotnet.sockets-http-handler-cookies-and-credentials` — SocketsHttpHandler cookies, credentials, and authentication ownership](identity-and-access/sockets-http-handler-cookies-and-credentials.md)
- [`security.token-validation-signing-and-identity-deployment` — Token validation, signing, and identity deployment](identity-and-access/token-validation-signing-and-identity-deployment.md)
- [`aspnet-core.totp-enrollment-and-verification` — TOTP enrollment and verification](identity-and-access/totp-enrollment-and-verification.md)
- [`security.windows-integrated-authentication-and-domain-infrastructure` — Windows integrated authentication and domain infrastructure](identity-and-access/windows-integrated-authentication-and-domain-infrastructure.md)

### Technology Core links

- [`aspnet-core.authentication-schemes-oidc-events-and-tickets` — ASP.NET Core authentication schemes, OIDC events, and tickets](../../technology-core/aspnet-core/authentication-schemes-oidc-events-and-tickets.md)
- [`aspnet-core.basic-authentication-handler-and-clients` — ASP.NET Core Basic authentication handler and clients](../../technology-core/aspnet-core/basic-authentication-handler-and-clients.md)
- [`aspnet-core.claims-transformation-lifecycle` — ASP.NET Core claims transformation lifecycle](../../technology-core/aspnet-core/claims-transformation-lifecycle.md)
- [`aspnet-core.authentication-properties-operation-and-session-state` — AuthenticationProperties operation and session state](../../technology-core/aspnet-core/authentication-properties-operation-and-session-state.md)
- [`aspnet-core.authentication-ticket-principal-and-request-user` — AuthenticationTicket, ClaimsPrincipal, and the request user](../../technology-core/aspnet-core/authentication-ticket-principal-and-request-user.md)
- [`aspnet-core.authorization-middleware-policy-evaluator-and-result-handler` — Authorization middleware, policy evaluator, and result-handler flow](../../technology-core/aspnet-core/authorization-middleware-policy-evaluator-and-result-handler.md)
- [`aspnet-core.authorization-policy-requirements-and-pending-lifecycle` — Authorization policy requirements and the PendingRequirements lifecycle](../../technology-core/aspnet-core/authorization-policy-requirements-and-pending-lifecycle.md)
- [`aspnet-core.cookie-authentication-event-lifecycle` — Cookie authentication event lifecycle](../../technology-core/aspnet-core/cookie-authentication-event-lifecycle.md)
- [`aspnet-core.cookie-auth-api-challenge-responses` — Cookie authentication responses for pages and APIs](../../technology-core/aspnet-core/cookie-auth-api-challenge-responses.md)
- [`aspnet-core.cookie-authentication-ticket-and-principal-lifecycle` — Cookie authentication ticket and principal lifecycle](../../technology-core/aspnet-core/cookie-authentication-ticket-and-principal-lifecycle.md)
- [`aspnet-core.identity-account-and-jwt-flows` — Identity account and JWT flows](../../technology-core/aspnet-core/identity-account-and-jwt-flows.md)
- [`aspnet-core.jwt-bearer-event-lifecycle` — JWT bearer event lifecycle](../../technology-core/aspnet-core/jwt-bearer-event-lifecycle.md)
- [`aspnet-core.otpauth-uri-construction` — otpauth URI construction for TOTP provisioning](../../technology-core/aspnet-core/otpauth-uri-construction.md)
- [`aspnet-core.windows-authentication-negotiate-hosting` — Windows Authentication with Negotiate and hosting](../../technology-core/aspnet-core/windows-authentication-negotiate-hosting.md)
- [`sql-server.logins-users-roles-and-permissions` — SQL Server logins, users, roles, and permissions](../../technology-core/sql-server/logins-users-roles-and-permissions.md)

## Security Architecture

### Area-owned Units

- [`aspnet-core.forwarded-headers-and-client-ip-trust` — Forwarded headers and client-IP trust](security-architecture/forwarded-headers-and-client-ip-trust.md)
- [`aspnet-core.razor-presentation-security-boundary` — Presentation decisions versus security enforcement in Razor](security-architecture/razor-presentation-security-boundary.md)
- [`security.signed-download-url-handoff` — Short-lived signed download URL handoff](security-architecture/signed-download-url-handoff.md)
