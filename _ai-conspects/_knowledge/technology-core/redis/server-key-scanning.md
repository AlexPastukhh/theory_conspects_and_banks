# Redis server facades and key scanning

Knowledge ID: `redis.server-key-scanning`

Topic: `redis`

`IServer` exposes endpoint-local info, configuration, database size, and key enumeration. `IServer.Keys` uses cursor scanning when possible; enumeration is lazy, may issue many calls, and is not a stable snapshot. It is safer than blocking full `KEYS`, but still expensive.

Avoid keyspace scans in production request paths. Maintain explicit sets/indexes when workflows require enumeration. In replicas or clusters, one server facade does not necessarily cover every key or node.

## What should be recallable

- Explain the core model of **Redis server facades and key scanning** without opening the Unit.
- Reconstruct this Unit-grounded rule: `IServer` exposes endpoint-local info, configuration, database size, and key enumeration.
- Reconstruct this Unit-grounded rule: Avoid keyspace scans in production request paths.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources

- Workspace: `_ai-conspects/redis, idatabase,iserver/`
- Processed source: `08-full-combined-final-transcript.md`, section 07
