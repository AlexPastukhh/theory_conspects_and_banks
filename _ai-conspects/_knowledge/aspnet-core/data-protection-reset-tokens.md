# Data Protection password-reset tokens

Knowledge ID: `aspnet-core.data-protection-reset-tokens`

Topic: `aspnet-core`

`IDataProtectionProvider.CreateProtector` creates a purpose-isolated protector. `Protect` authenticates/encrypts a payload; `Unprotect` validates/decrypts it. Use stable specific purpose strings/chains so one workflow's tokens cannot be replayed in another. `ITimeLimitedDataProtector` embeds and validates expiration for reset/verification links.

The flow is payload → protect → URL-safe HTTPS link → email → unprotect/validate → reset. `Unprotect` may throw for tampering, expiry, wrong purpose, or invalid input; map failure without leaking account existence. Bind tokens to user/action, expire/invalidate them, and persist/protect the key ring appropriately.

Wrap named protectors, purposes, URL encoding, and exception mapping behind focused services rather than scattering them through handlers. Hash when only comparison is needed; use reversible protection only when the payload must be recovered. A database-backed alternative stores a random token hash plus expiry/used state.

## Sources
- Workspace: `_ai-conspects/adddataprotection, encryption, password recovery/`
- Processed source: `regions/final-transcript.md`, complete structured transcript
