# Redis values, pipelining, and command atomicity

Knowledge ID: `redis.values-and-command-atomicity`

Topic: `redis`

`RedisValue` carries text, bytes, and numeric representations. Check missing/null before conversion to non-nullable types; missing differs from empty, and binary data should be read as bytes. Operator overloads are library value semantics, not domain validation.

One Redis command is atomic; several commands are not automatically atomic. Issuing async commands before awaiting pipelines them and reduces round trips but adds no isolation. `CreateBatch` coordinates pipelined dispatch; `CreateTransaction` adds conditions and optimistic execution. Dedicated atomic commands or Lua are often preferable for multi-step atomic work. Command flags can influence routing or select fire-and-forget behavior. Fire-and-forget discards completion and errors, so use it only when loss is acceptable.

## What should be recallable

- Explain the core model of **Redis values, pipelining, and command atomicity** without opening the Unit.
- Reconstruct this Unit-grounded rule: `RedisValue` carries text, bytes, and numeric representations.
- Reconstruct this Unit-grounded rule: One Redis command is atomic; several commands are not automatically atomic.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources

- Workspace: `_ai-conspects/manual account lockout,ratelimiter middleware, idatabase vs idist cache/`
- Authoritative processed source: `regions/R01R09-full-svg-reconciliation-v002.md`, R07
- Original SVG: `source/source-complete-v002.svg`

- Workspace: `_ai-conspects/redis, idatabase,iserver/`
- Processed source: `08-full-combined-final-transcript.md`, sections 05–06
