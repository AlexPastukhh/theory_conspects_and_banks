# Redis server facades and key scanning

Knowledge ID: `redis.server-key-scanning`

Topic: `redis`

`IServer` exposes endpoint-local info, configuration, database size, and key enumeration. `IServer.Keys` uses cursor scanning when possible; enumeration is lazy, may issue many calls, and is not a stable snapshot. It is safer than blocking full `KEYS`, but still expensive.

Avoid keyspace scans in production request paths. Maintain explicit sets/indexes when workflows require enumeration. In replicas or clusters, one server facade does not necessarily cover every key or node.

## Sources

- Workspace: `_ai-conspects/redis, idatabase,iserver/`
- Processed source: `08-full-combined-final-transcript.md`, section 07
