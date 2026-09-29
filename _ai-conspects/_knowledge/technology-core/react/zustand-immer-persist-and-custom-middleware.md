# Zustand Immer, persistence, and custom middleware boundaries

Knowledge ID: `react.zustand-immer-persist-and-custom-middleware`

Topic: `react`

Zustand middleware wraps or enhances a store initializer. Immer changes nested-update syntax, persistence adds storage and rehydration, and custom middleware can wrap store operations. Each changes a specific boundary; none makes selector or lifecycle design automatic.

## Manual copying, `produce`, and Immer middleware

Without middleware, preserve nested state immutably:

```ts
set(state => ({
  user: {
    ...state.user,
    address: {
      ...state.user.address,
      city: "Kaunas",
    },
  },
}));
```

Calling Immer's `produce` directly does not require Zustand's Immer middleware because `produce` itself returns the new immutable state:

```ts
import { produce } from "immer";

set(
  produce(state => {
    state.user.address.city =
      "Kaunas";
  }),
);
```

The middleware is useful when mutation-style callbacks are passed directly to Zustand `set`:

```ts
import { create } from "zustand";
import { immer } from "zustand/middleware/immer";

export const useStore = create(
  immer<State>(set => ({
    user: initialUser,

    setCity: city =>
      set(state => {
        state.user.address.city =
          city;
      }),
  })),
);
```

Immer changes update syntax. It does not make selectors focused, prevent notifications, or choose store boundaries.

## Persistence and rehydration

```ts
import { persist }
  from "zustand/middleware";

export const useAuthStore = create(
  persist<AuthState>(
    set => ({
      token: "",
      setToken: token =>
        set({ token }),
      logout: () =>
        set({ token: "" }),
    }),
    {
      name: "auth-storage",
    },
  ),
);
```

`persist` stores selected state and rehydrates it later. Source-captured options include:

```text
name
storage
partialize
version
migrate
onRehydrateStorage
```

Persist only state that should survive reloads. Browser storage is not secure storage for sensitive credentials; a security design may instead use server-managed HttpOnly cookies.

Other built-in middleware includes `devtools`, `immer`, and `subscribeWithSelector`.

Middleware can also expose action/update metadata to Redux DevTools; that observability role is distinct from persistence or Immer's update syntax.

## Custom middleware shape

Conceptually, middleware receives one initializer and returns another:

```ts
const middleware =
  config =>
  (set, get, api) => {
    return config(
      wrappedSet,
      wrappedGet,
      api,
    );
  };
```

A logger can inspect state before and after forwarding an update:

```ts
const logger =
  config =>
  (set, get, api) => {
    const wrappedSet = (
      partial,
      replace,
    ) => {
      const previousState = get();

      set(partial, replace);

      const nextState = get();

      console.log({
        partial,
        replace,
        previousState,
        nextState,
      });
    };

    return config(
      wrappedSet,
      get,
      api,
    );
  };
```

`partial` may be an object or functional update. `replace = false` requests the normal shallow merge; `replace = true` replaces the whole state. A wrapper must forward both arguments correctly.

## Read API boundaries

The read surfaces are related but not interchangeable:

```text
get()
    initializer/action read function
    middleware can pass a wrapped version to config

api.getState()
    external store API method
    changed only if middleware explicitly decorates/replaces it

useStore(selector)
    React subscription API
    separate from get/getState wrappers
```

Wrapping `get` inside the initializer does not automatically wrap `useStore.getState()`. Middleware that must instrument external reads must deliberately replace or decorate `api.getState` as well.

## Additional authoritative persistence transcript

## 4. Zustand `persist`

### Basic store

```ts
type AuthState = {
  token: string | null;
  user: User | null;
  theme: "light" | "dark";
  loginCount: number;

  setAuth:
    (
      token: string,
      user: User,
    ) => void;

  logout: () => void;
};

export const useAuthStore =
  create<AuthState>()(
    persist(
      set => ({
        token: null,
        user: null,
        theme: "light",
        loginCount: 0,

        setAuth:
          (token, user) =>
            set({
              token,
              user,
            }),

        logout:
          () =>
            set({
              token: null,
              user: null,
            }),
      }),
      {
        name: "auth-storage",
        storage:
          createJSONStorage(
            () => localStorage,
          ),
      },
    ),
  );
```

Important options:

```text
name
    storage key; changing it starts using another persisted bucket

storage
    storage adapter

partialize
    choose which state fields are written

version
    current persisted schema version

migrate
    convert older snapshots into current shape

onRehydrateStorage
    hook around restoration
```

### `partialize`

```ts
partialize: state => ({
  token: state.token,
  user: state.user,
  theme: state.theme,
})
```

Only the returned object is persisted. Runtime-only fields such as counters, loading flags and errors remain in memory.

### Version and migration

`version` is schema metadata for the persisted format.

```ts
{
  name: "auth-storage",
  version: 2,
  migrate: (
    persistedState,
    persistedVersion,
  ) => {
    if (persistedVersion === 1) {
      return {
        ...persistedState,
        theme: "light",
      };
    }

    return persistedState;
  },
}
```

Flow:

```text
write
    Zustand stores current configured version

restore
    stored version == configured version
        restore normally

    stored version != configured version
        run migrate

    migration unavailable/incompatible
        reject or reset persisted state
```

Do not manually mutate a `state.version` field inside `migrate`. The version is persistence metadata managed by the middleware.

A breaking schema change usually requires:

```text
1. update persisted shape
2. increment configured version
3. add migration path or intentionally return fresh defaults
```

Changing only actions or non-persisted fields normally does not require migration.

Changing `name` abandons the old storage key. It is a clean reset but leaves old storage unless separately removed.

### Persist middleware methods

The canvas records the imperative API exposed through `store.persist`:

```ts
store.persist.clearStorage();
await store.persist.rehydrate();

store.persist.hasHydrated();

const unsubStart =
  store.persist.onHydrate(
    state => {},
  );

const unsubFinish =
  store.persist.onFinishHydration(
    state => {},
  );

store.persist.setOptions({
  name: "new-name",
});
```

These methods support explicit clearing, forced rehydration, hydration status subscriptions and runtime option changes.

### TTL for Zustand

Zustand persist has schema migration and storage customization but no universal built-in `maxAge` option equivalent to React Query persistence.

A practical TTL stores an expiration timestamp inside the persisted subset and rejects it during restore/migration.

```ts
const ONE_DAY =
  24 * 60 * 60 * 1000;

type PersistedAuth = {
  token: string | null;
  user: User | null;
  expiresAt: number;
};
```

```ts
partialize: state => ({
  token: state.token,
  user: state.user,
  expiresAt:
    Date.now() + ONE_DAY,
})
```

During migration/rehydration:

```ts
if (
  !persisted.expiresAt
  || Date.now()
     > persisted.expiresAt
) {
  return emptyAuthState;
}
```

### Throttling in Zustand

The persistence middleware controls when it asks storage to write. To throttle/coalesce storage writes, wrap the storage adapter.

The wrapper keeps:

```text
pending value
timer
setItem scheduling logic
flush() method
```

Conceptual shape:

```ts
function createThrottledStorage(
  delay: number,
) {
  let timer:
    ReturnType<
      typeof setTimeout
    > | null = null;

  let pending:
    {
      name: string;
      value: string;
    }
    | null = null;

  const flush = () => {
    if (!pending) {
      return;
    }

    localStorage.setItem(
      pending.name,
      pending.value,
    );

    pending = null;

    if (timer) {
      clearTimeout(timer);
      timer = null;
    }
  };

  return {
    getItem:
      (name: string) =>
        localStorage.getItem(name),

    removeItem:
      (name: string) =>
        localStorage.removeItem(name),

    setItem:
      (
        name: string,
        value: string,
      ) => {
        pending = {
          name,
          value,
        };

        if (timer) {
          clearTimeout(timer);
        }

        timer =
          setTimeout(
            flush,
            delay,
          );
      },

    flush,
  };
}
```

Expose `flush` deliberately for logout, route changes or other boundaries where pending writes must reach storage immediately.

Use multiple stores or different storage wrappers when only one part of Zustand state should have a different persistence/throttle policy.

## What should be recallable

- When is manual copying required, and when does direct `produce` suffice?
- What does Zustand's Immer middleware change?
- Which persistence options own selection, versions, migration and rehydration?
- Why is browser-persisted state not automatically safe for credentials?
- What function shape does custom middleware wrap?
- Why must a wrapper forward both `partial` and `replace`?
- Why does wrapping initializer `get` not instrument `api.getState` or selector reads?

## Related knowledge

- `react.zustand-store-creation-and-update-semantics`
- `react.zustand-selectors-async-actions-and-subscriptions`

## Sources
- Workspace: `_ai-conspects/persistance, zustand,rquery,redux/`
- Authoritative processed source: `01-final-transcript.md`, section 4
- Original source identity: `persistance, zustand,rquery,redux.svg` (canonical and raw SVGs exist locally under `source/` but are not tracked/resolvable from the current branch tree).


- Workspace: `_ai-conspects/zustand/`
- Authoritative processed source: `01-final-transcript.md`, R02, R04 middleware overview and R05
- Identical regional transcript: `regions/R01R02R03R04R05-semantic-transcript-final-v001.md`, R02, R04 and R05
- Original SVG: `source/zustand.svg`
