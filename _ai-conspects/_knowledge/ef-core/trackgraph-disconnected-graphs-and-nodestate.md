# TrackGraph, disconnected graphs, and NodeState

Knowledge ID: `ef-core.trackgraph-disconnected-graphs-and-nodestate`

Topic: `ef-core`

`Add`, `Attach`, `Update`, and `Remove` already traverse graphs, but they apply broad rules. `TrackGraph` is for disconnected graphs where EF must decide state per node: the API walks reachable entities and calls your callback for each node. It does not magically know product rules. It gives the callback a place to apply product rules.

Common scenario: an API receives a disconnected graph; some nodes are new, some already exist, some should be modified, some should be deleted. Instead of applying one state to the whole graph, inspect each node and decide.

## Basic callback shape

```csharp
context.ChangeTracker.TrackGraph(rootEntity, node =>
{
    var entry = node.Entry;

    if (entry.IsKeySet)
    {
        entry.State = EntityState.Modified;
    }
    else
    {
        entry.State = EntityState.Added;
    }
});
```

```text
root entity -> related entity -> related entity ...
each visited object gets an EntityEntry
callback decides state
```

## `EntityEntryGraphNode`

The callback receives a graph node. Important node members: `Entry`, `NodeState`, `SourceEntry`, `InboundNavigation`. The most important member is `node.Entry`, because it exposes the `EntityEntry` for the current entity.

The callback usually reads `node.Entry.Entity`, `node.Entry.IsKeySet`, `node.Entry.Metadata`, `node.Entry.State`, then assigns:

```csharp
node.Entry.State = EntityState.Added;
node.Entry.State = EntityState.Modified;
node.Entry.State = EntityState.Unchanged;
node.Entry.State = EntityState.Deleted;
```

## State-assignment examples

Key-based:

```csharp
context.ChangeTracker.TrackGraph(root, node =>
{
    node.Entry.State = node.Entry.IsKeySet
        ? EntityState.Modified
        : EntityState.Added;
});
```

Domain-flag:

```csharp
context.ChangeTracker.TrackGraph(root, node =>
{
    if (node.Entry.Entity is ITrackChanges tracked)
    {
        node.Entry.State = tracked.IsDeleted
            ? EntityState.Deleted
            : tracked.IsNew
                ? EntityState.Added
                : EntityState.Modified;
    }
});
```

Safer: leave existing nodes `Unchanged`, then mark only selected properties as modified:

```csharp
context.ChangeTracker.TrackGraph(root, node =>
{
    node.Entry.State = node.Entry.IsKeySet
        ? EntityState.Unchanged
        : EntityState.Added;
});
```

## `NodeState`

`NodeState` lets traversal carry custom state when parent/relationship context affects child decisions. Use it when the traversal needs extra information that is not directly on the entity itself: current depth, current tenant id, parent decision, whether the current branch is read-only, whether child nodes should be skipped or marked.

The overload that accepts initial state uses a boolean callback:

```csharp
var maxDepth = 3;

context.ChangeTracker.TrackGraph(root, 0, node =>
{
    var depth = node.NodeState;

    node.Entry.State = node.Entry.IsKeySet
        ? EntityState.Unchanged
        : EntityState.Added;

    node.NodeState = depth + 1;
    return depth < maxDepth;
});
```

Its contract is `TrackGraph<TState>(object, TState, Func<EntityEntryGraphNode<TState>, bool>)`. Assigning `node.NodeState` makes the updated custom state available to nodes visited after the current node. Returning `true` continues below the node; returning `false` stops that branch. Because this advanced overload delegates termination to the callback, the caller must prevent infinite traversal through cycles.

## Traversal stopping

If the callback leaves the node `Detached`, EF can stop traversing that branch. Tracked state assignment is not only about `SaveChanges`; it can also affect graph traversal. If code intends to continue into child entities, it must be clear about the state assigned to the current node.

## TrackGraph vs Add / Attach / Update

```text
Add        -> broad graph rule: new graph / insert behavior
Attach     -> broad graph rule: existing graph / unchanged behavior
Update     -> broad graph rule: existing graph / modified behavior
TrackGraph -> custom per-node state decisions
```

Use `TrackGraph` only when the broad APIs do not express the required rules.

For a disconnected graph, existing referenced nodes must be attached or otherwise assigned an existing-state rule explicitly; otherwise EF may treat them as new inserts. Broad `Update` can mark the whole reachable graph modified, so mixed graphs require selective node-state decisions rather than one blanket update rule.

Good fit: mixed new/existing entities, soft-delete flags, client-provided entity states, graph DTOs, generic repository merge code.

Bad fit: simple insert, simple update of one aggregate with known state, normal tracked query + edit + `SaveChanges`.

Application code must define state rules explicitly; `TrackGraph` only supplies the traversal hook.

## What should be recallable

- Why `TrackGraph` exists relative to `Add` / `Attach` / `Update` / `Remove`.
- The callback shape and that `node.Entry` is the decision surface.
- Node members: `Entry`, `NodeState`, `SourceEntry`, `InboundNavigation`.
- Key-based, domain-flag, and Unchanged-then-property-modified patterns.
- What `NodeState` is for.
- Why the generic callback returns `bool`, how that differs from assigning `NodeState`, and who owns traversal termination.
- What leaving a node `Detached` can do to traversal.
- When `TrackGraph` is a good vs bad fit.

## Related knowledge

- `ef-core.entityentry-state-values-and-property-control` - `IsKeySet`, `State`, precise `IsModified`
- `ef-core.changetracker-tracking-and-state-events` - events that can fire during `TrackGraph` traversal
- `ef-core.changetracker-detection-cascade-and-save-lifecycle` - context-level tracking after nodes are attached

## Sources

- Workspace: `_ai-conspects/changetracker/`
- Authoritative processed source: `regions/R03-trackgraph-nodestate-and-member-api.md` sections 1-7
- Authoritative technical correction: `05-technical-correction-trackgraph-generic-callback-v001.md`
- Quality / coverage: `04-stage4-final-coverage-audit.md`
- Original SVG: `source/changetracker.svg` (Git blob SHA: `50d75c751eb9f20252807b6433d90f496b91f960`)
- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr02-constructors-attach-graphs-v002.md`, "Attach and entity state"
