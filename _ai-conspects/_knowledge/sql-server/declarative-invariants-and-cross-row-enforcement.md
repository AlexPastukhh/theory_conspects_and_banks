# Declarative invariants and cross-row enforcement

Knowledge ID: `sql-server.declarative-invariants-and-cross-row-enforcement`

Topic: `sql-server`

Place an invariant in the strongest database mechanism that directly expresses it. Primary keys, unique indexes or constraints, foreign keys, `NOT NULL`, and `CHECK` constraints are preferred to procedural logic. An application pre-check can improve the user experience but cannot close the race with another writer; the database remains the final guard.

A `CHECK` predicate applies to the row being inserted or updated. It fits ranges, date ordering, allowed status sets, and correlated fields such as "first and last name are both present or both absent." It cannot directly enforce a cross-row rule such as "no active bookings overlap." Explicit names make later provider-error mapping stable.

## Serializable and range invariants

Serializable isolation can protect a set/range invariant only when every competing transaction expresses the same invariant through compatible database reads and writes. In the booking example, each transaction first queries the predicate "no active booking overlaps this interval" and then inserts. When SQL Server can protect that predicate range, Serializable prevents the unsafe phantom: a competing transaction must wait or fail instead of both checks succeeding and both overlapping rows committing.

Serializable does not preserve the invariant if another writer bypasses the predicate-reading protocol. Prefer a declarative constraint or atomic database operation when it can express the rule; use Serializable for the range/absence case only with a shared invariant-enforcing access pattern.

SQL Server triggers are statement-level and must process every row in `inserted` and `deleted`; during an update, those tables contain the new and old row versions respectively. A set-based overlap trigger compares all changed rows with existing active bookings and throws a stable error on overlap. Because a trigger runs after the statement passes ordinary constraints, it is a last line of defense for rules that simpler declarative mechanisms cannot express.

A stored procedure can also own a complex write boundary and `THROW` a stable custom number. Custom errors can likewise originate from a batch, trigger, or SQL `TRY/CATCH`; functions are not the normal place for side-effecting error logic.

## What should be recallable

- The database-defense hierarchy and why an application pre-check cannot replace it.
- Which row-local rules fit `CHECK`, and why cross-row overlap does not.
- The multi-row meanings of trigger `inserted` and `deleted`, including update old/new versions.
- Why a trigger is a last-line mechanism and must be set-based.
- Where stable custom SQL errors can be raised.

## Sources

- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr05-invariants-constraints-triggers-v002.md`, "Defense hierarchy", "Stored procedures, batches, and custom errors", and "Triggers"
- Authoritative processed source: `transcripts/fr05-invariants-constraints-triggers-v002.md`, Serializable/range-invariant uses `NU-054`-`NU-058`
- Original SVG: `source/source-complete-v002.svg`, SHA-256 `3f1f8d3f0594043679772ad71c5b40c553fea90716fc781ccf9241542a196efd`
