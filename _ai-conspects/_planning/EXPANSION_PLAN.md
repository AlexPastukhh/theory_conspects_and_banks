# Expansion Plan — Software Engineering

Status: current lightweight action projection over tracked Open Expansion Questions after responsibility-first coverage audit. No calendar day is invented.

Canonical semantic location remains in the Area/Concept/Question map; this file only adds action ordering. Responsibility gaps without independent planning lifecycle remain in `RESPONSIBILITY_COVERAGE.csv` and do not need Question IDs.

## Ready — `PURSUE_NOW`

- `Q-SE-001` — **A14 / Software lifecycle baseline** — What minimum lifecycle/practice model should this knowledge base establish for requirements, source/configuration management, build/change flow, maintenance, compatibility, and technical debt?
- `Q-SE-002` — **A15 / Operations baseline** — What baseline model should connect observability signals, SLI/SLO/error budgets, production readiness, release/rollback, incident response, and capacity?
- `Q-SE-003` — **A13 / Testing/debugging foundations** — What general testing and debugging model should precede framework-specific test mechanics and production-specific diagnosis?
- `Q-SE-004` — **A04 / OS/runtime foundations and symmetric manifestations** — Which process, OS, filesystem, memory, clock, and resource-lifecycle foundations are missing generically and across .NET, Node.js, and Python?
- `Q-SE-005` — **A12 / Threat modeling and secure lifecycle** — What threat-modeling and secure-development baseline is missing despite strong authentication/authorization and browser-security knowledge?
- `Q-SE-011` — **A01 / Cross-language semantic foundations** — What transferable baseline for scope/binding, modules/name resolution, and error/failure semantics should exist across C#/.NET, JavaScript/Node.js, and Python before technology-specific details?

## Later — `DEFER`

- `Q-SE-006` — **A02 / Algorithms/data structures foundations** — Which algorithms and data-structure foundations are required to turn the current two rolling-window examples into a coherent transferable Area?
- `Q-SE-007` — **A03 / Node concurrency manifestation** — How do Node event-loop/libuv scheduling, async I/O ownership, cancellation, and failure propagation map to the general concurrency model?
- `Q-SE-008` — **A03 / Python concurrency manifestation** — How do Python asyncio tasks, cancellation, structured concurrency, threads, and processes map to the general concurrency model?
- `Q-SE-009` — **A10 / Distributed systems foundations** — What consistency, replication, time/order, delivery-semantics, and coordination model should exist before technology-specific resilience mechanisms?
- `Q-SE-010` — **A11 / Requirements / quality-attribute reasoning** — How should requirements and quality attributes drive architecture decisions without becoming duplicate storage or separately maintained views?
- `Q-SE-012` — **A07 / Backend host lifecycle manifestations** — How do .NET, Node.js, and Python application hosts implement startup, shutdown, process-signal handling, background work, and graceful termination relative to the generic host lifecycle?

## Not part of this plan

- untracked responsibility gaps — remain structural coverage state until selected for independent planning;
- repetition/calibration work — owned by Repetition;
- capture/triage work — separate workflow;
- physical Knowledge Unit moves — deferred representation decision.

## Plan semantics

`READY` / `LATER` is lightweight ordering only. Reordering this plan must not move Knowledge Units or change semantic ownership.
