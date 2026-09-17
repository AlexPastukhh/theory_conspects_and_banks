# Redis expiring counters, portability, and distributed throttling

Knowledge ID: `redis.expiring-counters-portability-and-distributed-throttling`

Topic: `redis`

`IConnectionMultiplexer` is the shared long-lived StackExchange.Redis connection owner. `GetDatabase()` returns a lightweight command facade and does not open one dedicated socket per call. `IDistributedCache` is a portable byte/string cache abstraction with get/set/remove/refresh and expiration options, but it does not expose Redis-specific atomic increment, remaining TTL, conditional writes, transactions, or scripts.

Create or register one multiplexer for the application lifetime; creating, connecting, and disconnecting one per request defeats its connection management, reconnect, and routing role. `IDatabase` exposes Redis commands such as `StringGet`, `StringSet`, `StringIncrement`, `KeyExpire`, `KeyTimeToLive`, `LockTake`, and `LockRelease`. Prefer it when the design depends on those semantics. A small application service can own key formats, thresholds, and command details so controllers do not become Redis clients.

Redis is a good fit for short-lived operational state such as counters, rate-limit windows, cache entries, lock or deduplication markers, and other TTL-bound values. Keep durable business records and audit history in the database unless the system explicitly gives Redis that ownership:

```text
database -> durable business/audit truth
Redis    -> fast temporary hot-path state
```

A database can store failed attempts, but a high-frequency database-only counter creates repeated writes, cleanup work, primary-database load, and a read-modify-write race unless it is protected. Redis combines automatic expiry with an atomic server-side counter while a database or log can retain security history.

Naive distributed read-modify-write loses updates:

```text
caller A reads 4     caller B reads 4
caller A writes 5    caller B writes 5
expected 6, stored 5
```

Use Redis `INCR` for a failed-attempt counter. On the first increment, attach an expiry to the window key; use a separate lock/block key with its own TTL when the blocked interval differs. Because `INCR` and `EXPIRE` are separate commands, a crash between them can leave a persistent key. Retry missing TTL or combine multi-step invariants in a transaction/Lua script.

```text
failed login
-> INCR fail:{normalized-account}:{partition}
-> if first count, set window expiry
-> when threshold reached, set block key with TTL
-> reject while block TTL exists
-> clear/reset according to successful-login policy
```

Redis makes the state shared across application instances; the built-in ASP.NET Core partition limiter remains local. A practical layered design uses a cheap local limiter for resource protection, Redis for shared failed-attempt state, and Identity lockout for account security. Distributed coordination adds availability and consistency trade-offs, so define fallback behavior when Redis is unavailable.

## Sources

- Workspace: `_ai-conspects/manual account lockout,ratelimiter middleware, idatabase vs idist cache/`
- Authoritative processed source: `regions/R01R09-full-svg-reconciliation-v002.md`, R05-R08
- Original SVG: `source/source-complete-v002.svg`
- Workspace: `_ai-conspects/redis-multiplexer-redis-lock/`
- Authoritative processed sources: `regions/R01-redis-vs-db-failed-attempts-and-cache-choice.md`, `regions/R02-connectionmultiplexer-idatabase-vs-idistributedcache.md`, and `regions/R03-atomic-counters-race-conditions-and-increment-semantics.md`
- Original SVG: `source/redis-multiplexer-redis-lock.svg`
