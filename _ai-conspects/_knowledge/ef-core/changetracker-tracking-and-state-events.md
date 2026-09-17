# ChangeTracker Tracking, Tracked, and state-change events

Knowledge ID: `ef-core.changetracker-tracking-and-state-events`

Topic: `ef-core`

ChangeTracker events are local to one `DbContext` instance and its in-memory lifecycle.

```text
Tracking      -> before an entity becomes tracked
Tracked       -> after an entity becomes tracked
StateChanging -> before an entity state changes
StateChanged  -> after an entity state changes
```

Event args expose the current entity/entry and context about the event. `Tracked` can tell whether tracking came from a query via `FromQuery`. State-change events expose old/new states.

## `Tracking`

`Tracking` fires before EF starts tracking an entity. At `Tracking` time, the entity is in the process of being tracked.

```csharp
context.ChangeTracker.Tracking += (sender, e) =>
{
    Console.WriteLine($"Tracking: {e.Entry.Entity.GetType().Name}");
};
```

Uses: debugging, diagnostics, local context-level validation, teaching/visualizing EF lifecycle.

## `Tracked`

`Tracked` fires after EF has started tracking an entity. Event args include `FromQuery`, which distinguishes:

```text
entity tracked because a query materialized it
entity tracked because code called Add / Attach / Update
```

```csharp
context.ChangeTracker.Tracked += (sender, e) =>
{
    Console.WriteLine($"{e.Entry.Entity.GetType().Name}, FromQuery={e.FromQuery}");
};
```

Typical teaching output:

```text
Tracking Blog
Tracked Blog
```

The exact order can help explain what EF is doing during query materialization or explicit `Attach`. Use `Tracking` for the "about to happen" lifecycle point. Use `Tracked` when you need to inspect the entity after EF has attached tracking metadata.

## `StateChanging` and `StateChanged`

`StateChanging` fires before an entity changes state. It is useful when code needs to observe the old state before EF applies the change.

```csharp
context.ChangeTracker.StateChanging += (sender, e) =>
{
    Console.WriteLine($"{e.Entry.Entity.GetType().Name}: {e.OldState} -> {e.NewState}");
};
```

Example transitions: `Unchanged -> Modified`, `Added -> Unchanged`, `Modified -> Unchanged`, `Unchanged -> Deleted`, `Deleted -> Detached`.

`StateChanged` fires after the new state is already applied. Same `OldState` / `NewState` pair, after the transition.

## What can trigger these events

```text
query materialization
Add
Attach
Update
Remove
DetectChanges
SaveChanges / AcceptAllChanges state cleanup
relationship/cascade state transitions
TrackGraph traversal
```

The exact event sequence depends on the operation. A query can produce `Tracked` events with `FromQuery = true`. An explicit `context.Add(entity)` can produce `Tracked` events with `FromQuery = false`. Editing a property and detecting changes can later produce state-change events.

## Good and bad uses

Good uses: debug output, local diagnostics, teaching EF lifecycle, simple context-scoped hooks, temporary troubleshooting.

Be careful with durable audit, business workflows, external side effects, network calls, and database writes inside handlers.

For durable audit or cross-cutting persistence rules, SaveChanges overrides/interceptors are usually a better boundary.

## Diagnostic setup

```csharp
context.ChangeTracker.Tracked += (sender, e) =>
{
    Console.WriteLine($"Tracked {e.Entry.Entity.GetType().Name}, FromQuery={e.FromQuery}");
};

context.ChangeTracker.StateChanged += (sender, e) =>
{
    Console.WriteLine($"{e.Entry.Entity.GetType().Name}: {e.OldState} -> {e.NewState}");
};

var blog = await context.Blogs.FirstAsync();
blog.Name = "Updated";
await context.SaveChangesAsync();
```

Possible output: entity tracked from query; state changed from `Unchanged` to `Modified`; later accepted back to `Unchanged`.

## Event args mental model

Event args usually provide `Entry`, the entity through `Entry.Entity`, `OldState` / `NewState` for state events, and `FromQuery` for `Tracked`.

```csharp
var entry = e.Entry;
var entity = entry.Entity;
var state = entry.State;
```

The handler can inspect `entry.Metadata` or `entry.Properties`. Avoid heavy work in event handlers unless the cost and side effects are intentional.

`TrackGraph` can cause tracking/state events, but traversal rules and event lifecycle are separate concerns.

## What should be recallable

- The four events and before/after pairing (`Tracking`/`Tracked`, `StateChanging`/`StateChanged`).
- What `FromQuery` distinguishes.
- Example state transitions that state events can report.
- Which operations can fire these events.
- Why durable audit usually belongs at SaveChanges/interceptor boundaries.

## Related knowledge

- `ef-core.changetracker-detection-cascade-and-save-lifecycle` - `DetectChanges`, `AcceptAllChanges`, cascade transitions that can fire events
- `ef-core.trackgraph-disconnected-graphs-and-nodestate` - traversal that can raise tracking/state events
- `ef-core.entityentry-state-values-and-property-control` - `Entry` / `Metadata` / `Properties` inspected from handlers

## Sources

- Workspace: `_ai-conspects/changetracker/`
- Authoritative processed source: `regions/R04-changetracker-events-tracking-tracked-state.md`
- Quality / coverage: `04-stage4-final-coverage-audit.md`
- Original SVG: `source/changetracker.svg` (Git blob SHA: `50d75c751eb9f20252807b6433d90f496b91f960`)
