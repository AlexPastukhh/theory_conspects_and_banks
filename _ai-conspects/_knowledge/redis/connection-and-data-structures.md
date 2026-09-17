# Redis connection model and data structures

Knowledge ID: `redis.connection-and-data-structures`

Topic: `redis`

Reuse the long-lived `ConnectionMultiplexer`; it owns sockets, reconnects, discovery, and routing. `IDatabase` is a lightweight logical-database command facade: obtaining it does not create a dedicated connection. `IServer` targets one endpoint for inspection/administration.

`RedisKey` is binary-safe; use stable prefixes and remember TTL applies to the whole key. Strings store text, bytes, numbers, counters, or serialized values. `StringSet` can combine expiry with conditional write modes. Prefer atomic Redis increment/decrement and conditional operations to client-side read-modify-write loops.

Hash fields have no independent TTL. Lists provide ordered push/pop/range operations and can act as queues or stacks. Sets provide uniqueness, membership tests, and set algebra. Sorted sets associate a score with each unique member and support rank and score ranges. Choose the structure by the atomic server-side operation required.

## Sources

- Workspace: `_ai-conspects/manual account lockout,ratelimiter middleware, idatabase vs idist cache/`
- Authoritative processed source: `regions/R01R09-full-svg-reconciliation-v002.md`, R06
- Original SVG: `source/source-complete-v002.svg`

- Workspace: `_ai-conspects/redis, idatabase,iserver/`
- Processed source: `08-full-combined-final-transcript.md`, sections 02–04
- Workspace: `_ai-conspects/cookie auth, antiforgery/`
- Authoritative processed source: `regions/R02-cookie-authentication-basics-and-browser-semantics.md`, source-preserving S-012 side note
- Original SVG: `source/cookie auth, antiforgery.svg`
