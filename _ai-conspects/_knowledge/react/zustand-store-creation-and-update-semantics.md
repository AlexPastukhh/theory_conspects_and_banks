# Zustand store creation and update semantics

Knowledge ID: `react.zustand-store-creation-and-update-semantics`

Topic: `react`

```bash
npm i zustand
```

Zustand exposes an external store through store actions and selector hooks. The default store API does not require a React Provider.

```ts
import { create } from "zustand";

type CounterState = {
  count: number;
  increment: () => void;
  add: (amount: number) => void;
};

export const useCounterStore =
  create<CounterState>((set, get) => ({
    count: 0,

    increment: () =>
      set(state => ({
        count: state.count + 1,
      })),

    add: amount =>
      set(state => ({
        count: state.count + amount,
      })),
  }));
```

`set` updates store state. `get` reads the current state inside actions or middleware.

## Subscribe to the needed state

Select fields independently when that is what a component uses:

```tsx
const count = useCounterStore(
  state => state.count,
);

const increment = useCounterStore(
  state => state.increment,
);
```

Selecting the whole store subscribes the component to every store update:

```tsx
const state = useCounterStore();
```

The selected slice, not the mere existence of one store, determines which updates schedule component work.

## Object and functional updates

An object update supplies a partial value directly:

```ts
set({
  loading: true,
});
```

When the next value depends on current state, use a functional update:

```ts
set(state => ({
  count: state.count + 1,
}));
```

By default, Zustand shallow-merges the returned partial object into the top-level store. Unmentioned top-level keys remain. Nested objects are not deeply merged:

```ts
set({
  user: {
    name: "B",
  },
});
```

That update can replace the entire `user` object. Preserve nested data explicitly:

```ts
set(state => ({
  user: {
    ...state.user,
    name: "B",
  },
}));
```

## Replacement and notification boundaries

The second `set` argument requests whole-state replacement:

```ts
set(
  {
    count: 0,
  },
  true,
);
```

Replacement is deliberately stronger than the default merge and can remove actions or unrelated fields.

Each `set` is a store update and notifies subscribers. Four calls can therefore produce four rounds of selector comparison and notification:

```ts
setLoading(true);
increment();
increment();
setLoading(false);
```

When the changes are one logical transaction, combine them:

```ts
set(state => ({
  loading: false,
  count: state.count + 2,
}));
```

This concerns Zustand store notifications and render work; it is not merely React local-state batching.

## What should be recallable

- What roles do `set` and `get` have inside a store initializer?
- Why select fields instead of the whole store?
- When is a functional update safer than an object update?
- Which level does the default merge preserve?
- How can `replace = true` remove actions?
- Why can several `set` calls cause more selector and render work?

## Related knowledge

- `react.zustand-selectors-async-actions-and-subscriptions`
- `react.zustand-immer-persist-and-custom-middleware`
- `react.use-sync-external-store-contract`

## Sources

- Workspace: `_ai-conspects/zustand/`
- Authoritative processed source: `01-final-transcript.md`, R01
- Identical regional transcript: `regions/R01R02R03R04R05-semantic-transcript-final-v001.md`, R01
- Original SVG: `source/zustand.svg`
