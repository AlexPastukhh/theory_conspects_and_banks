# Identity account and JWT flows

Knowledge ID: `aspnet-core.identity-account-and-jwt-flows`

Topic: `aspnet-core`

ASP.NET Core Identity supplies users, roles, stores, managers, lockout controls, and default UI/API account workflows. Email confirmation and password reset use generated tokens delivered through `IEmailSender`; encode tokens safely for URLs and keep recovery flows bounded and validated.

External login begins with an authentication challenge, then consumes the provider's login information. Link it to an existing local user or create the required local account explicitly; an external identity alone does not automatically establish the application's account model.

Identity manages accounts; bearer JWT is a separate transport. A token endpoint can verify credentials with `UserManager`/`SignInManager`, collect user claims, roles, and role claims, deduplicate them, then sign a JWT with configured issuer, audience, and lifetime. Signing keys belong in secret storage, never source/config committed as ordinary data.

```text
verify password → load user claims and roles → add role claims
→ deduplicate → sign token → API validates issuer/audience/key/lifetime
```

Choose default endpoints or custom flows deliberately, and keep authorization decisions server-side even when claims are carried to clients.

## Sources
- Workspace: `_ai-conspects/identity/`
- Processed source: `01-final-transcript.md`, complete transcript

