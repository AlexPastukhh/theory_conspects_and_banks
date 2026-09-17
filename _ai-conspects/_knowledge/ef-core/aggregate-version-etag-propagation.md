# Aggregate-version ETags across root and child changes

Knowledge ID: `ef-core.aggregate-version-etag-propagation`

Topic: `ef-core`

When children may be changed only through an aggregate root, one aggregate version can represent the consistency boundary that a client edits:

```text
Order
  └─ OrderLines

Student
  └─ Enrollments
```

A client reads the aggregate at version `V1`. Any intervening change to the root or a protected child must advance the aggregate version so a later write carrying `V1` is rejected.

## Why a root rowversion alone is insufficient

SQL Server changes a `rowversion` only on the row that is updated. Updating an `OrderLine` can change a token on the child row, but it does not automatically update `Orders.RowVersion`. EF noticing a child change does not make the database touch the parent row.

A root-only rowversion therefore protects the whole aggregate only when every aggregate mutation also causes a root-row update.

## Application-managed aggregate version

Use a meaningful root property and configure it as a concurrency token:

```csharp
public Guid AggregateVersion { get; private set; }

public void BumpVersion()
{
    AggregateVersion = Guid.NewGuid();
}

builder.Property(order => order.AggregateVersion)
    .IsConcurrencyToken();
```

A numeric version is another option. When a child changes, bumping the root property forces a real root-row update and makes the exposed ETag represent the entire aggregate.

Before saving, collect the union of directly changed roots and roots referenced by changed children, deduplicate it, and bump each root exactly once:

```csharp
var directRootIds = ChangeTracker.Entries<Order>()
    .Where(entry => entry.State is EntityState.Added
        or EntityState.Modified
        or EntityState.Deleted)
    .Select(entry => entry.Entity.Id);

var childRootIds = ChangeTracker.Entries<OrderLine>()
    .Where(entry => entry.State is EntityState.Added
        or EntityState.Modified
        or EntityState.Deleted)
    .Select(entry => entry.Entity.OrderId);

var rootIds = directRootIds
    .Concat(childRootIds)
    .Distinct()
    .ToList();

foreach (var rootId in rootIds)
{
    var rootEntry = ChangeTracker.Entries<Order>()
        .SingleOrDefault(entry => entry.Entity.Id == rootId);

    if (rootEntry is null)
        continue;

    rootEntry.Entity.BumpVersion();
    rootEntry.Property(order => order.AggregateVersion).IsModified = true;
}
```

For several aggregate types, a `SaveChangesInterceptor` can centralize the convention: inspect tracked changes, map each changed child type to its aggregate root, resolve roots when required, deduplicate them, and bump one version per root before saving. Keep the child-to-root mapping explicit. A meaningful version property is easier to reason about and expose as an ETag than an opaque shadow toggle.

Database `rowversion` remains an excellent choice when every protected change updates the root row. An application-managed version is useful when child mutations must intentionally propagate to the root. In either case, the validator must follow the actual consistency boundary promised to clients.

## What should be recallable

- Why does updating a child not automatically change a root rowversion?
- Which changed entries must be unioned before aggregate versions are bumped?
- Why must each root be bumped only once per save?
- When is a `SaveChangesInterceptor` a useful place for this convention?
- When should an aggregate use a database rowversion versus an application-managed version?

## Related knowledge

- [[rowversion-http-etag-concurrency]]
- [[../http/put-patch-and-update-preconditions]]

## Sources

- Workspace: `_ai-conspects/ETAG, e tag/`
- Authoritative processed source: `01-final-transcript.md`, R03
- Original SVG: `source/ETAG, e tag.svg`
