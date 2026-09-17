# Refresh-token family rotation and reuse detection

Knowledge ID: `security.refresh-token-family-rotation-and-reuse-detection`

Topic: `security`

Refresh-token rotation needs durable server-side state. A database remains the source of truth for session/user/device identity, token-family identity, token hash, creation/expiration, revocation, replacement, reuse detection, and last use. A separate session/token table supports several browsers or devices better than one refresh-token field on the user row.

Store a hash of each refresh token rather than its raw value. A family links every one-time token issued for one session:

```text
R1 -> R2 -> R3 -> R4
```

Representative row fields include:

```text
FamilyId
ParentTokenId
TokenHash
ReplacedByTokenId
RevokedAtUtc
ReuseDetectedAtUtc
DeviceId / device name
CreatedAtUtc
ExpiresAtUtc
```

## Rotation is one atomic state transition

```text
receive the current refresh token
-> hash it and locate its row
-> verify active, unexpired, and not already replaced
-> consume/revoke the old row
-> create a new token in the same family
-> link old row to new row
-> commit atomically
-> return a new access token and refresh cookie
```

A database transaction or concurrency control must prevent two nearly simultaneous requests from both rotating the same old token successfully.

## Reappearance after replacement is a security signal

If an older token appears after it was rotated, one-time credential material was copied or replayed. The observation does not prove that the caller possesses only that old token; it may also possess the newest token, current cookies, browser storage, the device, or later family members.

Stale material can come from a one-time XSS/storage capture, request logging, a memory snapshot, malware, a limited network leak, or a copied profile/backup. The important signal is not merely that an old token is invalid; it is that a rotating credential reappeared after replacement.

The safest normal response is to revoke the whole family and require a new login.

## Redis accelerates but does not own correctness

Redis can hold fast revocation hints, token status, per-user family indexes, attempt counters, and short-lived family locks:

```text
refresh:family:{familyId}:revoked
refresh:token:{tokenHash}
refresh:user:{userId}:families
refresh:attempts:{ip|userId|familyId}
lock:refresh:{familyId}
```

A short lock can serialize refresh attempts:

```csharp
var acquired = await db.StringSetAsync(
    $"lock:refresh:{familyId}",
    requestId,
    expiry: TimeSpan.FromSeconds(5),
    when: When.NotExists);
```

The lock needs an expiry, and release must verify ownership before deleting it. The database still enforces the final atomic token transition. Cache eviction, restart, or failover must not erase durable revocation history or make an otherwise invalid token valid.

## Related knowledge

- `redis.cache-stampede-and-token-owned-locks`
- `security.browser-access-and-refresh-token-lifecycle`

## What should be recallable

- Why is a separate refresh-session table preferable to one field on a user?
- Which facts make token-family rotation auditable?
- Which rotation steps must commit atomically?
- What does reuse of a replaced token prove, and what does it not prove?
- Why is whole-family revocation the conservative response?
- Which refresh responsibilities can Redis accelerate?
- Why must database correctness survive Redis loss?

## Sources

- Workspace: `_ai-conspects/jwt auth/`
- Authoritative processed source: `regions/R01R02R03R04-jwt-auth-corrected-final-v002.md`, R02
- Original SVG: `source/jwt auth.svg`

