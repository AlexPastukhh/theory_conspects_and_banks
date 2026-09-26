# Priority Model — Real Corpus Validation v1

Status: supporting validation evidence for the current Priority Model; **does not modify the methodology** and is not a semantic owner.

Note: this v1 evidence predates the current adjacent-boundary-band convention and therefore contains historical `MIXED` cells. Current methodology does **not** use `MIXED` as a Retention Class; those cases are normalized in the current full-corpus classification to explicit adjacent bands such as `CORE ↔ WORKING` or `WORKING ↔ RECOGNITION`.

## Test context

The ratings assume the current intended engineering direction:

- broad software-engineering understanding;
- strong existing .NET anchor;
- expansion into Node/Python/frontend/data;
- AI is available for mechanical lookup;
- the owner should retain mental models, failure modes, boundaries, and verification ability more strongly than API trivia.

Scale:
- `H` = HIGH
- `M` = MEDIUM
- `L` = LOW

Dimensions:
- **Leverage** — cross-concept / transfer value.
- **Consequence** — cost of misunderstanding/misapplication.
- **Usefulness** — likelihood of use in the current planning horizon.
- **Recoverability** — ease and reliability of external recovery **and verification**.

`Depth` and `Retention` are derived judgments, not a fixed formula.

## Matrix

| Knowledge ID | Lvg | Cons | Use | Recov | Depth | Retention | Observation |
|---|---:|---:|---:|---:|---|---|---|

| `dotnet.string-trimming-boundaries` | L | L | M | H | LOW | MAP_ONLY | Useful for map/comparison; exact API is trivial to recover. |
| `dotnet.array-removal-and-copying` | L | L | L | H | LOW | MAP_ONLY | Mostly mechanical collection/API detail; retain only the fixed-size-array model. |
| `typescript.keyof-property-extraction` | M | L | M | H | MEDIUM | RECOGNITION | Useful TS pattern, but syntax is cheap to reconstruct from docs/AI/compiler. |
| `javascript.set-basics` | M | L | M | H | LOW/MEDIUM | RECOGNITION | Existence/identity semantics worth recognizing; method names are lookup detail. |
| `css.flex-centering-axes-and-defaults` | M | L | M | H | MEDIUM | RECOGNITION | Axis/min-size mental model matters; exact defaults/property syntax are recoverable. |
| `typescript.any-vs-unknown-external-data` | H | H | H | H | HIGH | CORE | High recoverability does not cancel high leverage/consequence; core boundary model. |
| `typescript.never-and-discriminated-union-exhaustiveness` | M | M | M | H | MEDIUM | WORKING | Transferable type-safety model; details/compiler idioms are recoverable. |
| `javascript.timers-tasks-microtasks-and-abortable-delay` | H | M | H | M | HIGH | CORE | Foundational event-loop model with broad Node/browser transfer. |
| `javascript.fetch-response-contract-and-wrapper-policy` | H | M | H | H | HIGH | WORKING | Core HTTP-client boundary; exact wrapper/API syntax is highly recoverable. |
| `dotnet.async-concurrency-and-task-start` | H | H | H | M | HIGH | CORE | Foundational concurrency model; mistakes cause performance/load/logic failures. |
| `dotnet.stream-partial-reads-and-bounded-loops` | H | H | M | M | HIGH | WORKING | High consequence systems invariant, but lower daily usefulness for general app work. |
| `sql.subquery-membership-and-existence` | H | M | H | M | HIGH | WORKING | Reusable SQL semantics; NOT IN/NULL trap has real correctness cost. |
| `http.rest-constraints-resource-and-method-semantics` | H | H | H | M | HIGH | MIXED | Unit is too broad: method/resource semantics CORE/WORKING; Richardson levels RECOGNITION. |
| `ef-core.tracking-queries-identity-resolution-and-projections` | M | M | H | M | MEDIUM/HIGH | WORKING | Frequent EF decision model; framework-specific but meaningful for correctness/performance. |
| `ef-core.query-shape-cartesian-expansion` | M | M | M | M | MEDIUM | WORKING | Important when shaping ORM queries; recoverability needs SQL/plan reasoning. |
| `ef-core.optimistic-concurrency-resolution-and-savepoints` | H | H | H | M | HIGH | CORE | High decision/failure impact; model transfers beyond EF. |
| `security.xss-sources-sinks-and-attack-flows` | H | H | H | M | HIGH | CORE | Security invariant and diagnostic model; not safe to outsource to lookup alone. |
| `security.jwt-signing-keys-kid-and-jwks-rotation` | H | H | M | M | HIGH | WORKING | High consequence but somewhat specialized; should be deeply understood when used. |
| `security.refresh-token-family-rotation-and-reuse-detection` | H | H | M | M | HIGH | WORKING | Security-critical lifecycle; lower broad usefulness than XSS/auth fundamentals. |
| `redis.cache-stampede-and-token-owned-locks` | H | H | M | M | HIGH | WORKING | Failure-model knowledge matters; specialized enough not to require universal CORE. |
| `react.render-snapshots-batching-and-memoization` | H | M | H | M | HIGH | MIXED | Render/state snapshot is CORE-ish; memoization/external-store details may be WORKING. |
| `react.strict-mode-effect-cleanup` | H | M | H | M | HIGH | WORKING | Transferable lifecycle/cleanup model; exact React phase detail can be lighter. |

## What the test validates

### 1. The four dimensions are enough for the sampled decisions

No repeated case required a stable fifth priority dimension.

Previously proposed factors map acceptably:
- foundationality / transferability / connection value → **Leverage**;
- failure cost / decision impact / blast radius → **Consequence**;
- frequency / current goals / personal relevance → **Usefulness**;
- AI/docs availability + verification cost → **External Recoverability**.

### 2. External Recoverability must not dominate

`typescript.any-vs-unknown-external-data` is highly recoverable from docs/AI/compiler, but still deserves CORE-like retention because Leverage, Consequence, and Usefulness are all high.

This is an important success case: the model does not reduce "AI can answer it" to "I should not know it."

### 3. Depth and retention must remain separate outputs

Examples:
- Refresh-token rotation: **HIGH depth**, but likely **WORKING**, because it is security-critical yet less universally used.
- Stream partial reads: **HIGH depth**, but likely **WORKING** for general application work.
- String trimming: low depth and MAP_ONLY despite legitimate semantic coverage value.

### 4. Usefulness requires an explicit planning context

Usefulness is not intrinsic to a Knowledge Unit.

For example:
- EF Core tracking may be HIGH usefulness in a .NET-heavy period;
- it may fall to MEDIUM/LOW after moving to another stack.

Therefore every priority assessment should be interpreted relative to a declared/current planning context or horizon.

The methodology does not need a new dimension for this; it needs a clear context rule.

### 5. Some current Knowledge Units are too broad for one retention class

Two clear examples:

`http.rest-constraints-resource-and-method-semantics`
- HTTP method safety/idempotency and resource contracts: CORE/WORKING candidates;
- Richardson maturity levels: closer to RECOGNITION.

`react.render-snapshots-batching-and-memoization`
- render/state-snapshot model: CORE-ish;
- memoization and external-store detail: WORKING/RECOGNITION depending on current work.

This is primarily a **Knowledge Structure / Review Scope** issue, not a Priority Model failure.

Possible remedies:
1. split the Knowledge Unit;
2. keep one unit but define multiple explicit review scopes;
3. keep low-retention detail in the unit while only scheduling the higher-value scope.

Do not add priority dimensions to compensate for poor unit boundaries.

## Proposed corrections to the methodology

### A. Make planning context explicit for Usefulness

Add a rule:

> Priority assessment is relative to a current planning context/horizon.  
> Usefulness must not be treated as a timeless property of knowledge.

The context may include:
- active domains/stacks;
- current learning goals;
- expected work horizon.

It does not need to be duplicated on every unit if there is one current global/domain context.

### B. Do not force one Retention Class over heterogeneous scope

Add a rule:

> If one Knowledge Unit contains materially different retention needs, first review the unit/review-scope boundary. Do not average unrelated subtopics into one retention class.

This already aligns with the current `Retention & Repetition` principle: split/restructure heterogeneous scope before introducing per-claim scheduling.

### C. Keep the four dimensions

Do **not** add a fifth core dimension based on this sample.

The main remaining uncertainty is not dimension coverage; it is the mapping from dimension patterns to retention classes and exact repetition policy.

## Current conclusion

The Priority Model passes this first corpus test.

The strongest findings are:

1. **four dimensions appear sufficient** for representative current units;
2. **Usefulness needs explicit context/horizon**;
3. **Recoverability must include verification cost** (already corrected in v6);
4. **unit/review-scope granularity is now the bigger design risk than priority scoring**;
5. Retention should remain judgment-based until more corpus and actual repetition behavior are observed.

Next useful validation:
- run the same model over a larger random/stratified sample (e.g. 60–100 units);
- compare proposed retention against actual recall difficulty during calibration;
- test whether `CORE / WORKING / RECOGNITION / MAP_ONLY` remains sufficient.
