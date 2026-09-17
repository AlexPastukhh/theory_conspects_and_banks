# Redux middleware chains and manual thunk orchestration

Knowledge ID: `redux.middleware-chain-and-manual-thunks`

Topic: `redux`

Redux middleware runs between `dispatch` and reducers. Its canonical shape is:

```js
const middleware = storeApi => next => action => result;
```

`storeApi` supplies long-lived `dispatch` and `getState` references. Redux composes the returned middle functions into a chain, and the innermost function handles each dispatched value. The closures retain store access and configuration without globals.

`next(action)` forwards to the next middleware or reducer. `dispatch(action)` starts again at the beginning of the middleware chain. Returning `next(action)` preserves the downstream return value:

```js
const logger = ({ getState }) => next => action => {
  console.log("before", action, getState());
  const result = next(action);
  console.log("after", getState());
  return result;
};
```

Middleware order matters because every middleware wraps the next. A logger can observe state before and after forwarding; analytics can observe selected action types; permission middleware can block an action from reaching reducers. Logging/telemetry effects should catch their own failures and filter large or sensitive payloads instead of making dispatch fail.

Classic Redux installs middleware through `applyMiddleware`, normally as part of the same enhancer composition as DevTools:

```js
const store = createStore(
  rootReducer,
  applyMiddleware(logger, thunk)
);
```

Redux Toolkit's `configureStore` already installs thunk and development checks. Extend its defaults with the `middleware` callback and `.concat(...)`; replacing the returned default list is a separate deliberate choice.

## What thunk middleware changes

Ordinary Redux `dispatch` expects an action object. Thunk middleware adds one controlled alternative: if the dispatched value is a function, invoke it with `(dispatch, getState)`; otherwise forward it.

```js
const thunk = ({ dispatch, getState }) => next => action =>
  typeof action === "function"
    ? action(dispatch, getState)
    : next(action);
```

A normal action creator returns a plain object and needs no thunk middleware. A thunk action creator returns a function that may perform I/O, inspect current state, and dispatch zero or more plain actions.

## Classic async request lifecycle

Manual thunks commonly expose start, success, and failure as explicit state transitions:

```js
export const fetchProducts = () => async (dispatch, getState) => {
  if (getState().products.loading) return;

  dispatch({ type: "FETCH_REQUEST" });

  try {
    const { data } = await axios.get("/products");
    dispatch({ type: "FETCH_SUCCESS", payload: data });
  } catch (error) {
    dispatch({
      type: "FETCH_ERROR",
      payload: error.message
    });
  }
};
```

The reducer sets `loading` and clears an earlier error on request, stores data on success, and stores a serializable failure on rejection. `getState` can prevent an equivalent request already in flight, supply current auth/filter/paging/search values, or decide which action follows success. Components then dispatch `fetchProducts()` and select `loading`, `data`, and `error` instead of owning orchestration.

Classic connected components can map the thunk action creator like another dispatching callback:

```js
const mapDispatchToProps = dispatch => ({
  fetchProducts: () => dispatch(fetchProducts()),
});

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(ProductsPage);
```

Calling `dispatch` from middleware or a thunk can recurse indefinitely when the emitted action comes back through the same branch without a distinguishable stop condition. Async dispatch also does not deduplicate requests by itself, and raw `Error` objects should not be put into actions/state when serializability is required.

`createAsyncThunk` standardizes pending/fulfilled/rejected actions, and RTK Query often fits server-state fetching and caching better. Manual thunks remain useful for conditional, chained, multi-step, or non-query workflows.

## What should be recallable

- Why does middleware have three nested functions?
- How do `next(action)` and `dispatch(action)` traverse the chain differently?
- Why should middleware return the downstream result and guard recursive dispatch?
- How does thunk middleware distinguish functions from ordinary action objects?
- Which request/success/failure transitions compose a manual async thunk?
- Which current-state guards, error-shape rules, and modern Toolkit alternatives affect the choice?

## Sources

- Workspace: `_ai-conspects/redux basics/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R03-R04
- Original SVG: `source/redux basics.svg`
