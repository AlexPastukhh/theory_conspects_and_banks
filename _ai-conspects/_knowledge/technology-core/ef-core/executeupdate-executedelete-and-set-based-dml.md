# EF Core ExecuteUpdate, ExecuteDelete, and set-based DML

Knowledge ID: `ef-core.executeupdate-executedelete-and-set-based-dml`

Topic: `ef-core`

## ExecuteUpdateAsync and ExecuteDeleteAsync

These APIs perform set-based database work without materializing entities into application memory.

Update example:

```csharp
await db.Employees
    .Where(x => x.CompanyId == companyId)
    .ExecuteUpdateAsync(setters => setters
        .SetProperty(
            x => x.Salary,
            x => x.Salary * 1.10m));
```

Delete example:

```csharp
await db.Sessions
    .Where(x => x.ExpiresAt < DateTime.UtcNow)
    .ExecuteDeleteAsync();
```

Properties:

- execute immediately;
- normally produce one SQL `UPDATE` or `DELETE`;
- avoid loading rows into application memory;
- bypass the change tracker;
- do not require `SaveChanges`.

## SetProperty describes SQL, not an in-memory mutation

Inside `ExecuteUpdateAsync`, `SetProperty` describes the target column and a SQL-translatable value or expression:

```csharp
await db.Users
    .Where(x => !x.IsActive)
    .ExecuteUpdateAsync(setters => setters
        .SetProperty(x => x.Status, UserStatus.Deactivated)
        .SetProperty(x => x.DeactivatedAt, DateTime.UtcNow));
```

There is no `User` instance on which arbitrary C# code executes. Domain methods are not valid:

```csharp
// invalid — EF cannot translate a domain method into SQL
.SetProperty(x => x.Deactivate())
```

A domain method is application logic, not a column/value expression EF can translate into SQL.

## Change-tracker staleness

If an entity is already tracked and a set-based update changes its row directly, the in-memory object is not automatically refreshed:

```csharp
var employee = await db.Employees.FindAsync(id);

await db.Employees
    .Where(x => x.Id == id)
    .ExecuteUpdateAsync(setters => setters
        .SetProperty(x => x.Salary, x => x.Salary + 100));

// employee.Salary still contains the old value
```

The application may need to reload the entity, clear tracking, or avoid mixing tracked and set-based changes in the same workflow. Similarly, `ExecuteDeleteAsync` does not automatically detach a matching tracked entity.

## Domain rules and set-based DML

Set-based DML does not invoke:

- entity methods;
- validation implemented in entity code;
- domain invariants;
- domain events;
- per-entity policy checks;
- application-side side effects.

Use tracked entities, domain methods, and `SaveChanges` when business behavior must run for each aggregate:

```csharp
order.Cancel(policy, clock);
await db.SaveChangesAsync();
```

Use `ExecuteUpdateAsync` or `ExecuteDeleteAsync` when the change is simple, set-based, and completely described by a translated database expression.

Good fit:

- revoke all expired sessions;
- mark old notifications as archived;
- increment a simple column across a filtered set.

Poor fit without additional design:

- cancel orders while issuing refunds, restoring inventory, raising events, and enforcing per-order rules.

## What should be recallable

- How do `ExecuteUpdateAsync` and `ExecuteDeleteAsync` differ from the change-tracker workflow?
- Why can `SetProperty` not call a domain method?
- What happens to a tracked entity's in-memory state after `ExecuteUpdateAsync` changes its row?
- When should set-based DML be avoided in favor of domain methods and `SaveChanges`?
- Give two examples where `ExecuteDeleteAsync` is a good fit.

## Related knowledge

- `ef-core.fromsql-and-sqlquery-apis`
- `ef-core.changetracker-detection-cascade-and-save-lifecycle`
- `ef-core.savechanges-interceptor-lifecycle-and-audit`

## Sources

- Workspace: `_ai-conspects/dbset fromsql fromsqlraw fromsqlinterpolated and LINQ executeupdateasync and executedelete async,database.executesql executeraw,fromsqlquery/`
- Authoritative processed source: `regions/full-semantic-transcript-v001.md`, sections 11-14
- Original SVG: `source/source-complete-v002.svg`, SHA-256 `6cd7d851e1faf6da4ebadbdd509713f7a552b5b52769d44c084ccc10da70ab8d`, Git blob `38a2d5583e5fda228cfcb9e511297aaf0c86a989`
