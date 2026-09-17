# Cross-slice and async reactions with extraReducers

Knowledge ID: `redux.extra-reducers`

Topic: `redux`

## Core model

Use `reducers` for actions owned by a slice. Use `extraReducers` when reacting to another slice's action, a thunk lifecycle action, or another external action creator.

For example, a burger slice can react to an action generated and owned by the pizza slice:

```js
const burgerSlice = createSlice({
  name: "burger",
  initialState: { burgerBuns: 20 },
  reducers: {
    burgerOrdered(state) {
      state.burgerBuns -= 1;
    },
  },
  extraReducers: (builder) => {
    builder.addCase(pizzaOrdered, (state) => {
      state.burgerBuns -= 1;
    });
  },
});
```

The burger slice does not own the pizza action, but it can respond to the same dispatched action object.

## `builder.addCase`

```js
builder.addCase(
  someActionCreator,
  (state, action) => {
    // update draft state
  },
);
```

The first argument may also be an exact action type string, but the action creator preserves type information and avoids string duplication. The callback receives this slice's Immer draft and the dispatched action, and runs only for a matching type.

## Async lifecycle cases

```js
extraReducers: (builder) => {
  builder
    .addCase(fetchProducts.pending, (state) => {
      state.loading = true;
      state.error = null;
    })
    .addCase(fetchProducts.fulfilled, (state, action) => {
      state.loading = false;
      state.products = action.payload;
    })
    .addCase(fetchProducts.rejected, (state, action) => {
      state.loading = false;
      state.error = action.payload ?? action.error.message;
    });
}
```

The same lifecycle action may be observed by multiple slices when several features need to react to one request.

## Practical checks

```text
[ ] mount Provider around components
[ ] export each slice reducer and register it under the intended key
[ ] dispatch action creator results, not an uncalled action creator
[ ] dispatch thunk action creators through thunk-capable middleware
[ ] use reducers for owned actions
[ ] use extraReducers for external actions and thunk lifecycle actions
[ ] centralize state paths in selectors
[ ] keep logging-only middleware development-only
[ ] handle controlled rejected payloads and unexpected errors
```

## What should be recallable

- The ownership boundary between `reducers` and `extraReducers` and a cross-slice reaction.
- `addCase` matching, callback inputs, and action creator versus exact string.
- All three async lifecycle cases and multiple-slice observation.
- Provider, registration, dispatch, middleware, selector, and failure-handling checks.

## Sources

- Workspace: `_ai-conspects/redux rtk/`
- Processed source: `01-final-transcript.md`, R04
- Original SVG: `source/redux rtk.svg`
