# Redis cache stampede protection and token-owned locks

Knowledge ID: `redis.cache-stampede-and-token-owned-locks`

Topic: `redis`

A cache stampede occurs when a popular entry expires and many concurrent requests all rebuild it from the database or an external service:

```text
popular key expires
-> 100 requests miss
-> 100 expensive rebuilds start
-> the protected dependency is hammered
```

A short Redis lock can make one caller the rebuilder while others wait and retry the cache, serve an acceptable stale value, or fail fast.

## Single-instance lock contract

The conceptual acquisition command is:

```text
SET lock-key unique-token NX PX ttl
```

- `NX` succeeds only when the key does not exist;
- `PX ttl` ensures a dead owner cannot hold the lock forever;
- the random token identifies the caller that acquired this lock instance.

Release must compare the stored token and delete atomically, normally in a Lua script:

```text
if redis.get(lockKey) == myToken:
    redis.del(lockKey)
```

A plain `DEL` is unsafe. The original owner's work may outlive the TTL, another process may acquire the expired lock, and the old owner must not delete the new owner's lock.

TTL selection is a correctness/availability tradeoff:

```text
too short -> work is still running when the lock expires -> duplicate rebuild
too long  -> an owner failure delays every waiter
```

Choose a TTL longer than expected work with a safety margin, while recognizing that a single expiring lock remains best-effort coordination.

## Cache-rebuild flow

```text
read cache
if hit -> return value

try acquire lock
if acquired:
    rebuild value
    store cache entry
    release only the owned token
else:
    wait briefly and retry the cache
    or return stale data
    or fail fast
```

This is a good fit for cache rebuild protection, short-lived operational locks, and best-effort duplicate-work reduction. It is not a universal substitute for a database transaction or durable coordination for financial correctness, long critical sections, or global exactly-once guarantees.

RedLock coordinates across multiple Redis masters and aims at stronger distributed-lock guarantees, but it adds complexity and has debated assumptions. A single-instance token lock can be enough for stampede protection; critical distributed correctness needs a deeper failure-model design.

## What should be recallable

- What sequence produces a cache stampede?
- What does each part of `SET key token NX PX ttl` contribute?
- Why must release compare the owner token atomically?
- What fails when the TTL is too short or too long?
- What may non-owning callers do while a rebuild is in progress?
- Which use cases exceed the guarantees of a best-effort Redis lock?

## Sources

- Workspace: `_ai-conspects/redis-multiplexer-redis-lock/`
- Authoritative processed source: `regions/R04-stampede-protection-single-instance-redis-lock-redlock.md`
- Original SVG: `source/redis-multiplexer-redis-lock.svg`
- Workspace: `_ai-conspects/jwt auth/`
- Authoritative processed source: `01-final-transcript.md`, R02 (`SET NX PX`, owner-token release and TTL boundary around refresh-family rotation)
- Original SVG: `source/jwt auth.svg`
