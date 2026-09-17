# Reducer state transitions and lazy initialization

Knowledge ID: `react.reducer-state-transitions-and-initialization`

Topic: `react`

`useReducer` separates the current state, an action that describes intent, and a pure transition function:

```tsx
const [state, dispatch] = useReducer(reducer, initialState);
```

```text
state             -> current reducer snapshot
dispatch(action)  -> request a transition
reducer(state, action) -> calculate the next state
```

The UI dispatches intent while the reducer centralizes what each intent means:

```tsx
type State = { count: number };
type Action =
  | { type: "increment" }
  | { type: "decrement" }
  | { type: "reset" };

function reducer(state: State, action: Action): State {
  switch (action.type) {
    case "increment": return { count: state.count + 1 };
    case "decrement": return { count: state.count - 1 };
    case "reset": return { count: 0 };
  }
}

function Counter() {
  const [state, dispatch] = useReducer(reducer, { count: 0 });
  return (
    <>
      <p>{state.count}</p>
      <button onClick={() => dispatch({ type: "increment" })}>+</button>
    </>
  );
}
```

Prefer `useState` for simple, independent values with obvious updates. A reducer fits several related fields, many current-state-dependent transitions, centralized rules, or useful action history—such as a form with validation, submission, and error states.

## Purity and immutable updates

A reducer should satisfy:

```text
same state + same action -> same next state
```

It participates in render work, which React may start, replay, or discard. Do not perform network requests, timers, subscriptions, DOM/storage writes, current-time/random generation, or external mutation inside it. The event handler or effect owns the side effect and dispatches state-transition actions around it:

```ts
async function onSave() {
  dispatch({ type: "save_started" });
  try {
    await api.save(state);
    dispatch({ type: "save_succeeded" });
  } catch (error) {
    dispatch({ type: "save_failed", error });
  }
}
```

Create nondeterministic input before dispatch so the action fully describes the transition:

```ts
dispatch({ type: "add", id: crypto.randomUUID(), text });
```

Return new state rather than mutating and returning the same reference:

```ts
case "add":
  return {
    ...state,
    todos: [...state.todos, { id: action.id, text: action.text, done: false }]
  };
```

## Typed actions and exhaustiveness

A discriminated union gives each action exactly the data it needs:

```ts
type Action =
  | { type: "add"; id: string; text: string }
  | { type: "toggle"; id: string }
  | { type: "remove"; id: string }
  | { type: "setFilter"; filter: State["filter"] };
```

The switch narrows the payload by `type`. An exhaustiveness assignment exposes a newly added but unhandled action:

```ts
default: {
  const neverAction: never = action;
  return state;
}
```

Representative immutable transitions include `map` to replace one matching item, `filter` to remove one, and spreading the state for a field update.

```ts
case "toggle":
  return {
    ...state,
    todos: state.todos.map(todo =>
      todo.id === action.id
        ? { ...todo, done: !todo.done }
        : todo),
  };

case "remove":
  return {
    ...state,
    todos: state.todos.filter(todo => todo.id !== action.id),
  };
```

## Lazy initialization and reset

This expression executes whenever the component function renders, even though React uses the resulting initial state only for the first mount:

```tsx
useReducer(reducer, computeInitialState(props.items));
```

Pass the input plus a third-argument initializer to avoid repeated computation:

```tsx
const [state, dispatch] = useReducer(
  reducer,
  props.items,
  computeInitialState,
);

function computeInitialState(items: Item[]): State {
  return { items, filter: "all" };
}
```

Keep the initializer pure because development checks may invoke pure functions more than once. A reset action can reuse the same rule:

```ts
case "reset":
  return computeInitialState(action.items);
```

## Dispatch timing and state snapshots

Conceptually:

```text
handler dispatches action
-> React schedules update
-> component renders
-> reducer receives current state + action
-> reducer returns next state
-> React commits resulting UI
```

After `dispatch`, the local `state` variable still refers to the snapshot captured by the current render:

```ts
dispatch({ type: "increment" });
console.log(state.count); // current render's value
```

Observe the next state in the next render. Put transition logic in the reducer; use an effect only when committed state must synchronize an external system. Compute derived lists during render rather than storing another synchronized copy.

## What should be recallable

- What separate responsibilities belong to state, dispatch, and reducer?
- When is a reducer preferable to independent `useState` calls?
- Why must reducers avoid side effects, current time, and randomness?
- How should nondeterministic data enter the transition?
- How do discriminated actions and `never` provide exhaustiveness?
- Why does the third `useReducer` argument avoid repeated initialization work?
- Why does reading `state` immediately after dispatch show the old snapshot?

## Sources

- Workspace: `_ai-conspects/useReducer/`
- Authoritative processed source: `01-final-transcript.md`, R01 through R04
- Original SVG: `source/useReducer.svg`
