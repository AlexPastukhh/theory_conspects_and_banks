# Expansion Map

Status: **current operational owner** for explicitly planned knowledge expansion.

Current planned expansion items: **2**.

Coverage gaps and open Questions remain candidate inputs unless explicitly selected. The two current items below were selected from an ordinary learning need and the cross-runtime manifestation gaps; they do not schedule every visible gap.

## Boundary

Candidate sources are separate from the plan:

- `RESPONSIBILITY_COVERAGE.csv` — generic semantic gaps/evidence state;
- `MANIFESTATION_COVERAGE.csv` — selected cross-runtime manifestation gaps;
- `QUESTIONS.csv` — independently tracked open Questions;
- `COVERAGE_AND_EXPANSION.md` — human-readable coverage summary.

A gap or Question becomes planned expansion work **only when it is explicitly added below**. Priority fields in candidate sources do not by themselves schedule work.

Repetition is independent and lives in `../_repetition/REPETITION_MAP.csv`.

## Planned

### Go foundations and engineering manifestations

Source: ordinary need + `MANIFESTATION_COVERAGE.csv`
Target: selected Go manifestations across the existing Software Engineering responsibility map, beginning with programming model, concurrency, and runtime/resource foundations
Why now: add a native compiled, garbage-collected ecosystem with goroutines/channels and a deliberately different concurrency/runtime model from the existing .NET / JavaScript / Python baseline
Intended result: durable Go defining-model Units plus Area-owned manifestations/comparisons where the broader engineering Concept remains canonical
Notes: learn by engineering responsibility rather than exhaustive syntax curriculum; materialize only after real learning/triage

### Rust foundations and engineering manifestations

Source: ordinary need + `MANIFESTATION_COVERAGE.csv`
Target: selected Rust manifestations across the existing Software Engineering responsibility map, beginning with programming model, concurrency, and runtime/resource foundations
Why now: add ownership/borrowing, RAII, compile-time resource/concurrency safety, and async/runtime tradeoffs that are not represented by the current ecosystems
Intended result: durable Rust defining-model Units plus Area-owned manifestations/comparisons where the broader engineering Concept remains canonical
Notes: learn by engineering responsibility rather than exhaustive syntax curriculum; materialize only after real learning/triage

## Adding work

Use a lightweight Markdown entry. Do not create a heavy workflow schema merely to plan one learning direction.

```markdown
### <short title>

Source: <Question ID / responsibility ID / manifestation / ordinary need>
Target: <Area / nested Area / Concept / bounded topic>
Why now: <context>
Intended result: <new Unit / update / comparison / investigation / other>
Order/date: <optional>
Notes: <optional>
```

Ordering/date is optional. Removing or reordering an item does not move canonical knowledge and does not change coverage semantics.

## Physical-layout boundary

Physical reorganization of existing Knowledge Unit files does not populate this map. Repository representation work is not knowledge expansion.
