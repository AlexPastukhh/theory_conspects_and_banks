# Redux Persist reducers, transforms, migrations, and rehydration

Knowledge ID: `redux.persist-reducers-transforms-and-rehydration`

Topic: `redux`

## 5. Redux Persist

### Basic configuration

```ts
import {
  persistReducer,
  persistStore,
} from "redux-persist";

import storage from
  "redux-persist/lib/storage";

const persistConfig = {
  key: "root",
  storage,
};

const persistedReducer =
  persistReducer(
    persistConfig,
    rootReducer,
  );

export const store =
  configureStore({
    reducer: persistedReducer,
  });

export const persistor =
  persistStore(store);
```

`persistor` controls the persistence lifecycle.

### `PersistGate`

```tsx
<Provider store={store}>
  <PersistGate
    loading={<Loading />}
    persistor={persistor}
  >
    <App />
  </PersistGate>
</Provider>
```

The gate delays rendering until persisted Redux state is rehydrated, preventing an initial UI based on defaults followed by a second UI based on restored state.

### Core configuration fields

```text
key
storage key prefix/root key

storage
local/session/custom adapter

whitelist
persist only selected direct reducer keys

blacklist
persist every direct reducer key except selected keys

version
persisted schema version

migrate
upgrade old snapshots

transforms
change values before save and after load

stateReconciler
control merge with reducer initial state

throttle
coalesce write frequency
```

Whitelist/blacklist apply at the reducer level wrapped by `persistReducer`.

```ts
const persistConfig = {
  key: "root",
  storage,
  whitelist: [
    "auth",
    "settings",
  ],
};
```

A root whitelist cannot select `auth.token` directly. Options:

```text
wrap the auth reducer separately
use nested persist configuration
use a transform that persists only part of auth
```

### Nested persistence

```ts
const authPersistConfig = {
  key: "auth",
  storage,
  whitelist: [
    "token",
    "user",
  ],
};

const rootPersistConfig = {
  key: "root",
  storage,
  blacklist: [
    "auth",
  ],
};

const rootReducer =
  combineReducers({
    auth:
      persistReducer(
        authPersistConfig,
        authReducer,
      ),

    ui:
      uiReducer,
  });

export default
  persistReducer(
    rootPersistConfig,
    rootReducer,
  );
```

Nested configuration gives a child reducer its own policy while preventing the root persister from duplicating it.

### Transforms

A transform has two directions:

```text
inbound
    reducer state → serialized persisted state

outbound
    persisted state → Redux reducer state
```

```ts
const authTransform =
  createTransform(
    inbound => ({
      token: inbound.token,
      user: inbound.user,
    }),

    outbound => ({
      token:
        outbound.token ?? null,

      user:
        outbound.user ?? null,

      loading: false,
      error: null,
    }),

    {
      whitelist: ["auth"],
    },
  );
```

Transforms support:

```text
field-level persistence
Set/Map conversion
encryption/decryption
compression
TTL filtering
```

For a `Set`, convert to an array inbound and restore a `Set` outbound.

### Migrations

Redux Persist versioning follows the same high-level idea as Zustand:

```text
stored snapshot version
current configured version
migration converts old state to current shape
```

```ts
const migrations = {
  1: state => ({
    ...state,
    theme: "light",
  }),

  2: state => ({
    ...state,
    auth: {
      ...state.auth,
      token:
        state.auth?.token
        ?? null,
    },
  }),
};

const persistConfig = {
  key: "root",
  storage,
  version: 2,
  migrate:
    createMigrate(
      migrations,
      {
        debug: false,
      },
    ),
};
```

Migration occurs during restore/rehydration, not on every save.

### State reconcilers

```text
hardSet
    replace the target slice completely with persisted state

autoMergeLevel1
    shallow merge one level

autoMergeLevel2
    shallow merge two levels
```

A persisted object can omit fields that exist in reducer defaults. The reconciler determines whether omitted defaults survive.

Choose `hardSet` when the persisted object is complete and authoritative. Choose an auto-merge reconciler when reducer defaults should fill missing keys.

### Persistor methods

```ts
await persistor.flush();
await persistor.purge();

persistor.pause();
persistor.persist();
```

```text
flush
    force pending serialized writes now

purge
    delete persisted storage

pause
    temporarily stop writes

persist
    resume/start persistence
```

A logout/reset flow can explicitly reset memory, flush or discard pending writes, and purge storage in a deliberate order.

### TTL for Redux Persist

Redux Persist does not have one universal `maxAge` field analogous to React Query persistence.

Implement TTL with an inbound/outbound transform:

```ts
const authExpiryTransform =
  createTransform(
    inbound => ({
      token: inbound.token,
      user: inbound.user,
      expiresAt:
        Date.now() + ONE_DAY,
    }),

    outbound => {
      if (
        !outbound.expiresAt
        || Date.now()
           > outbound.expiresAt
      ) {
        return emptyAuthState;
      }

      return {
        token:
          outbound.token
          ?? null,

        user:
          outbound.user
          ?? null,

        loading: false,
        error: null,
      };
    },

    {
      whitelist: ["auth"],
    },
  );
```

Migration can also reject expired snapshots, but a transform is often clearer when expiration is part of serialization policy rather than schema conversion.

## What should be recallable

- How persistReducer, persistStore, PersistGate, whitelist/blacklist, and nested persistence define persisted Redux boundaries.
- How inbound/outbound transforms, migrations, state reconcilers, TTL, and persistor methods affect save and restore.
- How flush, purge, pause, and persist participate in deliberate logout/reset ordering.

## Related knowledge

- `architecture.client-state-persistence-snapshot-lifecycle`

## Sources

- Workspace: `_ai-conspects/persistance, zustand,rquery,redux/`
- Authoritative processed source: `01-final-transcript.md`
- Original source identity: `persistance, zustand,rquery,redux.svg` (canonical and raw SVGs exist locally under `source/` but are not tracked/resolvable from the current branch tree).
