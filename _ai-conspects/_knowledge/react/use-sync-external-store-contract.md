# useSyncExternalStore contract

Knowledge ID: `react.use-sync-external-store-contract`

Topic: `react`

`useSyncExternalStore(subscribe, getSnapshot, getServerSnapshot?)` connects React to state owned outside React. `subscribe` registers the supplied callback and returns an exact, idempotent unsubscribe function; `getSnapshot` synchronously returns current state; `getServerSnapshot` supplies the SSR/hydration value.

An unchanged store must return an `Object.is`-equal snapshot. Immutable stores can return their current state object; mutable stores must cache an immutable derived snapshot and replace it only on real change. Returning a fresh object each read can cause constant rerenders or an update loop. Notify only after state changes; notification alone does not make an unchanged snapshot rerender.

React reads the snapshot during render, establishes the subscription, and then checks the snapshot again. If the store changed in the gap between rendering and subscribing, the re-check schedules the necessary update. This render → subscribe → verify sequence closes the race left by a hand-written effect subscription.

```ts
function subscribe(listener: () => void) {
  listeners.add(listener);
  return () => { listeners.delete(listener); };
}
```

Keep `subscribe` stable or React will resubscribe. Iterate a stable listener snapshot if listeners can unsubscribe while notification runs, and release old subscriptions on unmount, resubscription, or store replacement.

An auth store can replace `{ user, isAuthenticated, isLoading }`, notify after login/logout/restore, and expose the hook directly; Context is optional for injecting store ownership or test instances. SSR snapshots must agree with hydration, and browser token storage needs a server guard. Client auth state never replaces server authorization.

Selectors should observe the smallest useful slice. Primitive selections are naturally stable; object/array selections need caching or deliberate equality. Custom equality must not hide meaningful changes and should cost less than the rerender it avoids.

## Sources
- Workspace: `_ai-conspects/usesyncexternalstore/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
- Workspace: `_ai-conspects/jwt auth/`
- Authoritative processed source: `01-final-transcript.md`, R03 (in-memory token store with `get`, `set`, `clear`, `subscribe` and reactive snapshots)
- Original SVG: `source/jwt auth.svg`
