# EF Core query shape, diagnostics, and batching

Knowledge ID: `ef-core.query-performance-shape-diagnostics-and-batching`

Topic: `ef-core`

## Stable shapes and compiled queries

EF Core caches and compiles query expression shapes. If application code builds a materially different expression tree for each parameter combination, reuse falls. On a hot path, express optional conditions as parameters inside a stable shape when that preserves the intended query:

```text
stable expression shape + changing parameter values
  -> reusable compilation/cache entry

different expression tree per call
  -> less cache reuse
```

This is not a rule to never branch. It is a reason to avoid needless shape variation in frequently executed queries.

Explicit compiled queries are a targeted optimization. Good candidates are stable, frequently executed queries where EF compilation overhead is material. Cold queries, heavily dynamic filters, or ordinary application code where maintainability dominates are poor candidates. Infrastructure/library hot paths are a more natural home.

Compilation optimization does not remove database I/O. Async execution still hits the database, and compiled queries do not repair slow SQL, bad indexes, chatty access, or unnecessary round trips.

## Observe the actual bottleneck

Start with generated SQL, timings, and database-call counts. The classic N+1 pattern occurs when iteration or lazy-loaded navigation access causes a database call per item. Batching applies the opposite pressure: reduce round trips and tune provider/framework batch size, including `MaxBatchSize`, only where measurement supports it.

Compiled-query overhead, N+1 access, and batching are separate problems. Select the remedy that matches observed cost.

## Runtime counters

`dotnet-counters` installs and runs as a .NET diagnostic tool, then attaches to a running process by PID. Select the actual application process, not an IDE helper or unrelated runtime, and monitor the `Microsoft.EntityFrameworkCore` counters.

Useful signals include active `DbContext` instances, query count, query-cache hit rate, `SaveChanges` calls, execution-strategy failures, and optimistic-concurrency failures:

```text
high query count                -> possible N+1 or chatty access
low query-cache hit rate        -> constantly changing query shapes
many SaveChanges calls          -> possible missed batching
strategy/concurrency failures   -> investigate their specific failure path
```

Counters indicate where to investigate; generated SQL and timings establish what the application is actually doing.

## What should be recallable

- How do parameter changes differ from expression-shape changes?
- When is an explicit compiled query a reasonable optimization?
- Which costs remain after query compilation overhead is reduced?
- How do N+1 behavior and batching affect round trips?
- Which EF Core counters can reveal shape churn, chatty access, or missed batching?

## Sources

- Workspace: `_ai-conspects/ef-core-performance-diagnostics-compiled-linq-batching-n-1/`
- Authoritative processed source: `regions/R01R02R03R04-efcore-performance-final-coverage.md`, R01–R04
- Original SVG: `source/ef-core-performance-diagnostics-compiled-linq-batching-n-1.svg`
- Workspace: `_ai-conspects/ef migrations, dotnet-counters/`
- Authoritative processed source: `regions/full-svg-reconciliation-v002.md`, R05–R06
- Original SVG: `source/source-complete-v002.svg`
