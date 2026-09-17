# Account lockout and failed-login throttling

Knowledge ID: `aspnet-core.account-lockout-and-failed-login-throttling`

Topic: `aspnet-core`

Account lockout and request rate limiting protect different boundaries. A limiter bounds traffic/resource use by a partition such as IP, client, or route. Lockout tracks authentication failures for an account and blocks credential verification for a window. Layer them rather than treating either as a replacement for the other.

ASP.NET Core Identity exposes lockout configuration and concurrency-aware user storage. Configure `AllowedForNewUsers`, `MaxFailedAccessAttempts`, and `DefaultLockoutTimeSpan` for the intended policy. Password checks must opt into failure counting:

```csharp
var result = await signInManager.CheckPasswordSignInAsync(
    user, password, lockoutOnFailure: true);

if (result.IsLockedOut)
    return LockedOutResponse();
```

A manual model needs explicit fields and transitions: failure count, window start, lockout end, success reset, and concurrent-update handling. An append-only attempt table is useful for audit/risk analysis but costs more than a counter; a hybrid can keep fast current state plus durable security events.

On successful authentication, clear/reset failed-access state. Simultaneous attempts need optimistic concurrency or another atomic transition so one update cannot overwrite another.

Count only failed authentication outcomes, not every request reaching generic middleware. Email-only partitions allow attacker-driven denial of service against a victim; IP-only partitions harm shared networks and distribute poorly; combined keys reduce one problem while increasing cardinality. Normalize identifiers, avoid account-enumeration differences, and place credential-aware logic in the login action or authentication service.

## Sources

- Workspace: `_ai-conspects/manual account lockout,ratelimiter middleware, idatabase vs idist cache/`
- Authoritative processed source: `regions/R01R09-full-svg-reconciliation-v002.md`, R04, R05 and R08
- Original SVG: `source/source-complete-v002.svg`
