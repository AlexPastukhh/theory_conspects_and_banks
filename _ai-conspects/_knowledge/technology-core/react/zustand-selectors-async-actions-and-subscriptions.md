# Zustand selectors, async actions, and subscriptions

Knowledge ID: `react.zustand-selectors-async-actions-and-subscriptions`

Topic: `react`

Zustand runs a subscriber's selector after store updates and compares the new selected value with its previous value. Primitive selections normally compare through `Object.is` semantics.

```ts
const count = useStore(
  state => state.count,
);
```

## Selected reference identity

A selector that constructs a new object returns a different reference whenever it runs:

```ts
const selection = useStore(state => ({
  count: state.count,
  increment: state.increment,
}));
```

Even unchanged fields now live in a new outer object. Use separate selectors or an explicit shallow-equality form. The captured source shows:

```ts
import { shallow } from "zustand/shallow";

const {
  count,
  increment,
} = useStore(
  state => ({
    count: state.count,
    increment: state.increment,
  }),
  shallow,
);
```

The exact equality/helper API is Zustand-version and store-configuration dependent; use the equivalent supported helper for the installed version. `shallow` compares top-level selected values, not a whole nested graph. A selected nested object with a new reference is changed under shallow comparison.

## Derived values and store boundaries

Inexpensive derived data can remain in a selector:

```ts
const total = useCartStore(
  state =>
    state.items.reduce(
      (sum, item) => sum + item.price,
      0,
    ),
);
```

Expensive derivations may need memoization, precomputed state or a more focused store. Several domain stores can reduce unrelated selector work; one store with slices can centralize cross-domain actions. Choose boundaries from domain ownership and update frequency rather than assuming one layout is always faster.

## Async actions and latest state

No special async middleware is required:

```ts
const useProductsStore = create<ProductsState>(
  (set, get) => ({
    loading: false,
    products: [],
    error: null,

    fetchProducts: async () => {
      if (get().loading) {
        return;
      }

      set({
        loading: true,
        error: null,
      });

      try {
        const response =
          await api.get("/products");

        set({
          products: response.data,
          loading: false,
        });
      } catch (error) {
        set({
          error,
          products: [],
          loading: false,
        });
      }
    },
  }),
);
```

`get()` reads current store state when the action executes. It can guard a duplicate request, read authentication state, or make the next decision from the latest values. A single global `loading` flag is insufficient when independent requests may overlap; use domain-specific request state.

## External subscriptions

Non-React integrations can subscribe and later remove the listener:

```ts
const unsubscribe =
  useCounterStore.subscribe(
    state => state.count,
    (count, previousCount) => {
      console.log(
        previousCount,
        count,
      );
    },
  );

unsubscribe();
```

Depending on the Zustand version and configuration, selector-style subscriptions require `subscribeWithSelector` or the relevant helper. Subscriptions can connect analytics, logging, storage synchronization, WebSockets, audio or other non-React systems. Always unsubscribe when ownership ends.

## What should be recallable

- When does Zustand run selectors and compare their results?
- Why does returning a new object defeat reference equality?
- What does shallow comparison inspect, and what does it not inspect?
- When should a derived value remain in a selector versus be precomputed?
- Why does an async action use `get()` before or after an await?
- Why can one loading flag be wrong for independent operations?
- Which lifecycle obligation belongs to an external subscription?

## Related knowledge

- `react.zustand-store-creation-and-update-semantics`
- `react.zustand-immer-persist-and-custom-middleware`
- `react.use-sync-external-store-contract`

## Sources

- Workspace: `_ai-conspects/zustand/`
- Authoritative processed source: `01-final-transcript.md`, R03 and R04
- Identical regional transcript: `regions/R01R02R03R04R05-semantic-transcript-final-v001.md`, R03 and R04
- Original SVG: `source/zustand.svg`
