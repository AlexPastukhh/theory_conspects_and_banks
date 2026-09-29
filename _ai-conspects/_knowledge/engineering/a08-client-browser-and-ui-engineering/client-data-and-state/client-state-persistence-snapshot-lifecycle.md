# Client-state persistence snapshots, hydration, and write policy

Knowledge ID: `architecture.client-state-persistence-snapshot-lifecycle`

Topic: `architecture`

## 1. Mental model: memory state versus persisted state

All three libraries maintain an in-memory runtime representation and optionally save a serializable snapshot to external storage.

```text
runtime memory
    React Query cache
    Zustand store
    Redux store

persistence boundary
    selects, serializes and writes a snapshot

restore boundary
    reads, validates/transforms and merges the snapshot back into memory
```

Persisted state is not the live state object. It is a stored representation with its own lifecycle, schema version, expiration policy and write frequency.

## 2. Cross-library mapping

| Concern | React Query | Zustand persist | Redux Persist |
|---|---|---|---|
| persisted unit | dehydrated query/mutation cache | selected store state | selected reducer state |
| save conversion | `dehydrate` | `partialize` plus storage serialization | inbound `transform` |
| restore conversion | `hydrate` | `migrate` and `onRehydrateStorage` | migration, outbound `transform`, reconciler |
| schema invalidation | `buster` | `version` + `migrate` | `version` + `migrate` |
| selective persistence | `shouldDehydrateQuery`, `shouldDehydrateMutation` | `partialize` | whitelist/blacklist, nested persist, transforms |
| write throttling | persister `throttleTime` / persister implementation | custom storage wrapper | persist config `throttle` |
| force pending write | explicit persister save where supported | custom wrapper `flush` | `persistor.flush()` |
| clear persisted data | remove persisted client | `store.persist.clearStorage()` | `persistor.purge()` |

The names are similar but the persisted units differ. React Query persists cache entries; Zustand and Redux Persist primarily persist application state.

## 6. Hydration, migration and transform timing

### React Query

```text
save path
    cache change
    dehydrate/filter
    persister save

restore path
    read persisted client
    check buster and maxAge
    hydrate QueryClient
```

### Zustand

```text
save path
    store change
    partialize
    serialize/write

restore path
    read storage
    compare version
    migrate if necessary
    merge into store
    run rehydration callbacks
```

### Redux Persist

```text
save path
    Redux state update
    select persisted reducer state
    inbound transforms
    serialize/write

restore path
    read storage
    migrate
    outbound transforms
    state reconciliation
    rehydrated Redux state
```

## 7. Throttling and pending writes

Throttling means delaying and coalescing writes to storage.

```text
state changes repeatedly
    persistence layer schedules one pending write
    later write contains the newest snapshot
```

Benefits:

```text
less serialization
less localStorage/AsyncStorage/disk I/O
fewer writes during fast UI updates
```

Risk:

```text
a write is still pending
app closes or storage is cleared
latest snapshot may never reach storage
```

Therefore:

```text
Redux Persist
    await persistor.flush()

Zustand
    expose flush from custom storage wrapper

React Query
    trigger explicit save only through the API supported by the selected persister strategy
```

Do not purge or remove storage while an older delayed write can still run afterward. Cancel/flush pending timers before clearing storage.

## 8. Selective throttling

Different data often needs different persistence policies.

```text
authentication
    small, infrequent, flush at logout/login boundaries

draft editor
    frequent updates, longer throttle

UI preferences
    small and durable

server cache
    query-level filters and cache-specific expiration
```

Strategies:

```text
Redux Persist
    multiple/nested persist reducers with separate configs

Zustand
    separate stores or separate storage wrappers

React Query
    whole-client persistence for one cache blob,
    or supported per-query persister behavior where required
```

## 9. Design checklist

```text
[ ] define exactly what the persisted unit is
[ ] persist only durable state
[ ] keep secrets and transient flags out unless required
[ ] version persisted schemas
[ ] provide migration or an intentional reset path
[ ] align React Query gcTime with persistence maxAge
[ ] use buster for hard cache invalidation
[ ] implement TTL explicitly for Zustand/Redux Persist
[ ] throttle storage writes when updates are frequent
[ ] expose a flush path for critical boundaries
[ ] cancel pending writes before purging storage
[ ] test fresh install, upgrade, expiration, corruption and logout
```

## What should be recallable

- How runtime state, persisted snapshots, restore conversion, schema versioning, TTL, throttling, and pending writes form one lifecycle.
- How React Query, Zustand persist, and Redux Persist map the same concerns onto different persisted units and APIs.
- Why clearing storage must coordinate with pending delayed writes, and when separate persistence policies are useful.

## Related knowledge

- `react-query.persistence-hydration-and-cache-pruning`
- `react.zustand-immer-persist-and-custom-middleware`
- `redux.persist-reducers-transforms-and-rehydration`

## Sources

- Workspace: `_ai-conspects/persistance, zustand,rquery,redux/`
- Authoritative processed source: `01-final-transcript.md`
- Original source identity: `persistance, zustand,rquery,redux.svg` (canonical and raw SVGs exist locally under `source/` but are not tracked/resolvable from the current branch tree).
