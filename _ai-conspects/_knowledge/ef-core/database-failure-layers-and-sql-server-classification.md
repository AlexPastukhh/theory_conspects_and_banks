# Database failure layers and SQL Server classification

Knowledge ID: `ef-core.database-failure-layers-and-sql-server-classification`

Topic: `ef-core`

EF Core and its provider expose failures at different layers. `DbUpdateConcurrencyException` identifies an optimistic-concurrency conflict. Other save failures normally arrive as `DbUpdateException` with a provider exception underneath. Query failures often expose the provider exception directly. Commit is a provider/connection operation and is not guaranteed to fail as `DbUpdateException`. Exhausting an execution strategy can produce `RetryLimitExceededException`.

A practical classification order is concurrency conflict, general update failure, retry exhaustion, then provider/connection failure. The provider detail must still be inspected before assigning meaning.

For SQL Server, common numbers are:

- `2601`: duplicate value in a unique index;
- `2627`: primary-key or unique-constraint violation;
- `547`: foreign-key or check-constraint violation;
- `515`: null inserted into a non-nullable column;
- `1205`: deadlock victim, normally a whole-operation retry candidate;
- `1222`: lock timeout, policy-specific and usually a reason to diagnose blocking;
- `3960`: snapshot update conflict, requiring a new transaction and fresh state;
- `-2`: command timeout, whose outcome and cause may be ambiguous.

Integrity failures are normally mapped to validation/domain results rather than retried. Because one number can represent several rules, explicitly named constraints and indexes provide the stable discriminator. Provider constants and classification logic should remain centralized. Timeout and other ambiguous failures must not blindly replay non-idempotent work.

SQL Server command timeout is specifically the provider `SqlException` case with `Number == -2`; it is not interchangeable with an ordinary .NET `TimeoutException`. Either timeout still needs cause and outcome analysis before replay, including query cost, blocking, and operation idempotency.

Constraints and business-rule failures are non-retriable by default. Bad SQL, invalid database objects, and permission failures are also configuration/code/access problems rather than transient retry candidates. Retrying the same operation unchanged does not repair those classes.

## What should be recallable

- Which exception layers commonly represent concurrency, save, query, commit, and retry-exhaustion failures.
- The meanings and normal dispositions of SQL Server `2601`, `2627`, `547`, `515`, `1205`, `1222`, `3960`, and `-2`.
- Why constraint names are needed in addition to error numbers.
- Why integrity errors and ambiguous timeouts require different handling from transient whole-operation failures.
- How SQL Server command timeout `SqlException.Number == -2` differs from `TimeoutException`.
- Which bad-SQL, invalid-object, permission, constraint, and business-rule classes are non-retriable by default.

## Related knowledge

- `ef-core.execution-strategies-retry-behavior-and-configuration`
- `ef-core.executeintransactionasync-ambiguous-commit-verification`

## Sources

- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr06-concurrency-provider-errors-v002.md`, "Exception layers" and "SQL Server numbers"
- Authoritative processed source: `transcripts/fr04-transactions-retries-rawsql-v002.md`, "Execution strategies and retry boundaries"
- Original SVG: `source/source-complete-v002.svg`, SHA-256 `3f1f8d3f0594043679772ad71c5b40c553fea90716fc781ccf9241542a196efd`
