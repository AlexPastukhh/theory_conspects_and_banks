# createAsyncThunk lifecycle and request state

Knowledge ID: `redux.async-thunk-lifecycle`

Topic: `redux`

## Creating a thunk

`createAsyncThunk` wraps async work in a thunk action creator:

```js
import { createAsyncThunk } from "@reduxjs/toolkit";
import axios from "axios";

export const fetchProducts = createAsyncThunk(
  "product/fetchProducts",
  async (categoryId, thunkApi) => {
    const response = await axios.get("/products", {
      params: { categoryId },
      signal: thunkApi.signal,
    });

    return response.data;
  },
);
```

`product/fetchProducts` is an action-type prefix, not a URL. Toolkit derives three ordinary Redux action types:

```text
product/fetchProducts/pending
product/fetchProducts/fulfilled
product/fetchProducts/rejected
```

The payload creator receives the dispatched argument and `thunkApi`. Passing `thunkApi.signal` into the request allows cancellation to propagate to the HTTP client.

## Dispatch flow

```js
dispatch(fetchProducts(categoryId));
```

The sequence is:

```text
1. pending is dispatched immediately
2. the payload creator runs
3. its resolved return value becomes fulfilled action.payload
4. a thrown or rejected failure creates a rejected action
```

Reducers do not watch a Promise. They react to the normal lifecycle actions dispatched around the async work.

## Lifecycle action shapes

Pending carries request metadata:

```js
{
  type: "product/fetchProducts/pending",
  meta: {
    arg: categoryId,
    requestId: "...",
    requestStatus: "pending"
  }
}
```

Fulfilled also carries the returned data:

```js
{
  type: "product/fetchProducts/fulfilled",
  payload: result,
  meta: {
    arg: categoryId,
    requestId: "...",
    requestStatus: "fulfilled"
  }
}
```

Rejected commonly carries serialized error information:

```js
{
  type: "product/fetchProducts/rejected",
  error: { message: "Network Error" },
  meta: {
    arg: categoryId,
    requestId: "...",
    requestStatus: "rejected"
  }
}
```

`meta.arg` is the original argument, `requestId` identifies this request instance, and `requestStatus` records its lifecycle phase.

## Controlled and unexpected failures

When the server supplies a deliberate domain error, return `rejectWithValue`:

```js
return thunkApi.rejectWithValue({
  message: "Validation failed",
});
```

The controlled failure is available as `action.payload`. Unexpected or thrown failures are represented through `action.error`, so rejected handling commonly covers both:

```js
state.error = action.payload ?? action.error.message;
```

## Request state transitions

```js
const initialState = {
  loading: false,
  products: [],
  error: null,
};
```

```text
pending
    loading = true
    error = null

fulfilled
    loading = false
    products = action.payload

rejected
    loading = false
    error = action.payload ?? action.error.message
```

A component can dispatch the thunk on mount and render loading, error, or data state.

Choose the async abstraction by responsibility. `createAsyncThunk` standardizes pending/fulfilled/rejected lifecycle actions. RTK Query is often a better fit for server fetching, caching, invalidation, and deduplication. A manual thunk remains useful for conditional dispatch, chained or multi-step workflows, and async work that is not naturally a server-cache query.

## What should be recallable

- How to declare and dispatch a thunk, pass its argument into a request, and propagate `thunkApi.signal`.
- Why the first string is a type prefix and which lifecycle types it generates.
- The exact dispatch order and why reducers observe actions rather than a Promise.
- The meaningful fields in pending, fulfilled, and rejected action shapes.
- The distinction between controlled `rejectWithValue` payloads and unexpected `action.error` failures.
- The loading/error/data state transitions for all three lifecycle cases.

## Sources

- Workspace: `_ai-conspects/redux rtk/`
- Processed source: `01-final-transcript.md`, R03
- Original SVG: `source/redux rtk.svg`
- Workspace: `_ai-conspects/redux basics/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R04
- Original SVG: `source/redux basics.svg`
