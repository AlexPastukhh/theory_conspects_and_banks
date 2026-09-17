# ASP.NET Core nested resource route design

Knowledge ID: `aspnet-core.nested-resource-route-design`

Topic: `aspnet-core`

A parent key is required for identity when the child ID is only locally unique, for example `/authors/{authorId}/courses/{courseId}`. Globally unique child IDs remove that addressing requirement but do not decide ownership, authorization scope, lifecycle, or canonical URI.

Nesting fits a parent aggregate when children cannot be created independently, parent invariants govern commands, deletion/lifecycle is parent-owned, or tenancy policies are keyed by the parent. The URL only communicates scope; enforce it with a parent-scoped lookup or `course.AuthorId == authorId`. A mismatch commonly returns 404 to avoid cross-scope existence leakage, while 403 is valid only under a deliberate policy.

For an independent child aggregate, make `/courses/{courseId}` canonical for single-resource operations and keep `/authors/{authorId}/courses` for scoped listing/creation. If creation is also independent of parent context, expose `POST /courses` alongside the nested collection routes. Reparenting or multiple parents makes nested identity unstable and can create several URLs for one resource. Query filtering (`/courses?authorId=123`) narrows a canonical collection; a nested path foregrounds the relationship.

If both route families exist, choose one canonical form for links, `Location`, `CreatedAtAction`, and documentation. A nested single-resource route can remain a scoped view/check or alias, but must verify membership. A convenience top-level lookup does not necessarily change aggregate ownership: commands may remain nested while globally indexed reads are top-level.

## Sources
- Workspace: `_ai-conspects/ROUTE NESTING/`
- Processed source: `04-source-preserving-transcript-v002.md`, complete transcript
- Workspace: `_ai-conspects/ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED/`
- Authoritative processed source: `01-final-transcript.md`, R01-R03 (enforced parent scope, global versus parent-scoped child identity)
- Original SVG: `source/ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED.svg`
