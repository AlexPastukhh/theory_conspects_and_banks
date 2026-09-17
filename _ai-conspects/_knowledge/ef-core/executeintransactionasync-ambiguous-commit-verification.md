# EF Core ExecuteInTransactionAsync and ambiguous commit verification

Knowledge ID: `ef-core.executeintransactionasync-ambiguous-commit-verification`

Topic: `ef-core`

`ExecuteInTransactionAsync` combines an execution strategy with a transaction and adds a verification step for the special case where commit throws but the final database outcome is unknown.

Conceptual shape:

```csharp
var strategy = db.Database.CreateExecutionStrategy();

await strategy.ExecuteInTransactionAsync(
    state: db,
    operation: (context, ct) =>
        context.SaveChangesAsync(acceptAllChangesOnSuccess: false, ct),
    verifySucceeded: (context, ct) =>
        context.Blogs.AsNoTracking()
            .AnyAsync(x => x.BlogId == blogId, ct));

db.ChangeTracker.AcceptAllChanges();
```

The operation has three possible outcomes.

## A. Commit succeeds normally

The helper completes successfully. `verifySucceeded` is not needed on the clean success path. If `SaveChanges(false)` was used, tracked state can now be accepted.

## B. Commit fails clearly

The system knows the transaction did not commit. The attempt is failed and the strategy can retry the operation according to its policy. Verification is not the central issue because the outcome is known.

## C. Commit fails ambiguously

The connection can be lost while commit is in progress. The client receives an exception but cannot know whether the database committed before the connection disappeared.

This is the purpose of `verifySucceeded`:

- if the durable result exists, treat the operation as successful and do not replay it;
- if the durable result does not exist, retry the operation.

Verification should inspect a stable result that uniquely identifies the operation, such as a client-generated key, idempotency record, or other durable marker. Non-idempotent writes are dangerous in this situation: blindly replaying them can create duplicates or apply an action twice.

Natural keys and operation identifiers are additional durable markers when they uniquely identify the intended effect. `SaveChanges(false)` deliberately postpones `AcceptAllChanges` until commit success or verification is known.

## What should be recallable

- What problem does `ExecuteInTransactionAsync` add to normal retry support?
- What are the three possible commit outcomes?
- Why is `verifySucceeded` unnecessary on the clean success path?
- How is a clear commit failure handled?
- What makes a commit outcome ambiguous?
- What should `verifySucceeded` check?
- Why is a client-generated key useful for verification?
- Why can a blind replay of a non-idempotent operation be dangerous?

## Sources

- Workspace: `_ai-conspects/ef core retry, savepoints/`
- Authoritative processed source: `regions/full-semantic-transcript-v001.md`, section 5
- Original SVG: `source/source-complete-v002.svg`
- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr04-transactions-retries-rawsql-v002.md`, "Execution strategies and retry boundaries"
