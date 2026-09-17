# EF Core many-to-many join entities and delete behavior

Knowledge ID: `ef-core.many-to-many-join-entities-and-delete-behavior`

Topic: `ef-core`

An implicit many-to-many mapping hides the join row when it has no domain meaning. EF can use a shared-type join entity and configure table/FK names. Use an explicit CLR join entity when the association has payload, identity, lifecycle, auditing, or behavior of its own.

```csharp
builder.HasMany(x => x.Tags)
    .WithMany(x => x.Posts)
    .UsingEntity<PostTag>(
        right => right.HasOne(x => x.Tag).WithMany().HasForeignKey(x => x.TagId),
        left  => left.HasOne(x => x.Post).WithMany().HasForeignKey(x => x.PostId),
        join  => join.HasKey(x => new { x.PostId, x.TagId }));
```

Delete behavior describes what happens to dependents/foreign keys when the principal relationship is severed. `Cascade` and `SetNull` request database cascade-like actions when valid; client variants affect tracked dependents without guaranteeing behavior for unloaded rows; `Restrict`/`NoAction` rely on constraint enforcement and provider timing. `SetNull` requires a nullable FK. Optional versus required relationship, loaded/tracked graph, disconnected workflow, database cascade paths, and provider rules all affect the observed result.

Treat the join-table shape and delete rule as schema/domain decisions rather than interchangeable conventions.

## Sources

- Workspace: `_ai-conspects/onmodelcreating/`
- Authoritative processed source: `13-full-combined-final-transcript.md`, section 8
- Original SVG: `source/onmodelcreating.svg`
