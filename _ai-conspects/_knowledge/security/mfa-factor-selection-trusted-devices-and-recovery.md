# MFA factor selection, trusted devices, and recovery

Knowledge ID: `security.mfa-factor-selection-trusted-devices-and-recovery`

Topic: `security`

## MFA combines independent factor categories

Multi-factor authentication requires evidence from different categories: something known, possessed, or inherent. Two passwords are two secrets of the same factor type, not strong MFA merely because there are two prompts.

| Method | Useful property | Main boundary |
|---|---|---|
| email code | easy enrollment/recovery | mailbox compromise defeats the factor; delivery can be delayed |
| authenticator TOTP | offline and widely supported | shared secret protection and clock tolerance |
| push approval | low-friction approve/deny | device registration and approval-fatigue attacks |
| security key/passkey | phishing-resistant designs possible | device/platform enrollment and recovery |

The choice includes deployment, user support, multiple devices, recovery, and phishing resistance—not only cryptographic strength.

## Trusted devices and recovery need explicit lifecycle

“Remember this machine” issues a long-lived trusted-device token/cookie after successful MFA. Later logins can skip the MFA challenge only after the password succeeds and the device token is accepted. The token must expire, be removable by the user, and be cleared/revoked on password reset.

Enrollment can generate a set of one-time recovery codes and store only their hashes. A lost-device user consumes one code once. MFA reset requires strong proof such as password plus email verification or a support process, deletes the active `UserSecrets`, and requires re-enrollment.

Multiple authenticator devices can be separate per-user secret records with device name, activation/revocation state, and timestamps. One lost device can then be revoked without disabling every factor.

## What should be recallable

- Why two same-category credentials are not independent MFA factors.
- The operational tradeoffs of email, TOTP, push, and FIDO2/WebAuthn.
- Why a trusted-device token is a new revocable credential.
- Why recovery codes are one-time values stored as hashes.
- Why recovery and per-device revocation are part of the MFA security model.

## Related knowledge

- `aspnet-core.totp-enrollment-and-verification`

## Sources

- Workspace: `_ai-conspects/mfa/`
- Authoritative processed source: `regions/MFA-R01-totp-mfa-theory.md`, MFA methods and security controls; `regions/MFA-R02-enrollment-authentication-flow.md`, trusted-device, recovery/reset, and multiple-device material
- Original source identity: `mfa.svg` (named by the workspace boundary review; not physically present in the current workspace)
