# TOTP enrollment and verification

Knowledge ID: `aspnet-core.totp-enrollment-and-verification`

Topic: `aspnet-core`

TOTP is HOTP whose counter comes from time: `C = floor((T - T0) / X)`, commonly with a 30-second step. Server and authenticator share a random secret, HMAC the counter, dynamically truncate, and apply a decimal modulus to produce the short code.

Enrollment is two-phase: generate a high-entropy secret; build an `otpauth://` URI/QR with issuer, account, algorithm, digits, period, and Base32 secret; show the manual key only during enrollment; then protect the secret at rest in a pending record. Upsert that record for the user with `CreatedUtc`, `ExpiresUtc`, and a concurrency token. Confirmation loads it, trims the submitted code, unprotects and Base32-decodes the secret, verifies, activates MFA, and consumes the pending record. Never post the raw secret back from the browser.

The login flow is also staged: validate the primary credential first, preserve short-lived MFA session state such as `mfa_userId` plus `rememberMe` or a temporary MFA cookie, then ask for the TOTP code. Use a small explicit previous/current/next-step window for clock drift and rate-limit attempts.

Pending enrollment in durable server storage works across application instances and prevents client secret substitution. GET can create/refresh the pending row and return QR/manual display data; POST sends device name and code, creates the active per-device secret, removes the pending row, and commits the transition.

Razor and React are views over the same server-owned state machine. React fetches enrollment data, renders `qrCodeUri`, and posts only `deviceName` plus `code` (with credentials for cookie auth). Razor adds antiforgery and validation to the same fields and renders the QR from the server URI. Neither UI round-trips the raw secret as authoritative state.

Allow only a narrow drift window such as previous/current/next step and keep server time synchronized. Verification must be bound to the correct user/enrollment, rate-limited, attempt-limited, and expired. Data Protection for the pending secret complements rather than replaces database/key-ring access control, auditing, and recovery/rotation planning.

## Secret handling rules

The Base32 secret is a credential equivalent to a password:

- protect it at rest (encryption or Data Protection);
- do not log it;
- limit how often it is displayed to the user;
- treat a QR code containing it as sensitive material;
- rotate and re-enroll when exposure is suspected.

## Sources
- Workspace: `_ai-conspects/totp, summary,theory/`
- Processed source: `regions/R01-totp-theory-enrollment-verification-final.md`, complete transcript
- Additional provenance: `_ai-conspects/creating base32 secret/`, `regions/full-semantic-transcript-v001.md`, section 3 (secret handling/security rules)
- Workspace: `_ai-conspects/mfa/`
- Authoritative processed sources: `regions/MFA-R01-totp-mfa-theory.md`; `regions/MFA-R02-enrollment-authentication-flow.md`; `regions/MFA-R05-backend-controller-flow.md`; `regions/MFA-R06-react-enrollment-ui.md`; `regions/MFA-R07-razor-views-enabled-state.md`
- Original source identity: `mfa.svg` (named by the workspace boundary review; not physically present in this workspace)
