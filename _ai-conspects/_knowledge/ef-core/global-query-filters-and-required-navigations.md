# Global query filters and required navigations

Knowledge ID: `ef-core.global-query-filters-and-required-navigations`

Topic: `ef-core`

`HasQueryFilter` automatically narrows an entity for soft deletion, tenancy, or similar policy. A required reference navigation can let EF use an inner join; if the related entity's filter removes that row, the parent disappears too. Querying parents alone and querying with `Include` can therefore return different counts. Collections may instead leave the parent while materializing only children that survive the filter. In general, EF can materialize a root only when the final filtered/joined SQL still contains a row representing that root.

Mitigations include making the relationship optional where that matches the domain, applying compatible filters to both sides, and carefully reviewing `Include` with required relationships and filtered principals. Do not weaken a genuinely required relationship merely to hide a query-model inconsistency; verify generated SQL and row-count tests.

`IgnoreQueryFilters()` bypasses protection for that query and can expose deleted or cross-tenant data. Named filters in supporting EF Core versions allow selective disabling. On older versions, repeated `HasQueryFilter` calls replace the previous filter, so conditions are combined with `&&` and disabled together.

A soft-delete query filter only hides rows; it does not turn `Remove` into an update. A `SaveChanges` override or interceptor must change deleted entries to `Modified` and set the deletion flag. Read filtering and write transformation are separate responsibilities.

For multitenancy, capture the tenant in the context and ensure it is initialized for every request. With `AddDbContextPool`, `OnConfiguring` is not a safe per-request initialization point because the same context instance is checked out repeatedly. Assign and reset tenant state for every checkout/request; stale state can otherwise leak one tenant's rows into another request. The model expression is stable and reads the current context-instance value rather than being rebuilt for each request.

## Sources
- Workspace: `_ai-conspects/query filters ef core/`
- Processed source: `02-stage2-corrected-source-preserving-transcript-v002.md`, complete transcript
