# Subarea Completeness Audit — v1 → v2

## Overall result

The 14-Area v1 map was technically useful but **biased toward the subjects already present in the repository**. That made several existing Areas rich while underrepresenting software-engineering lifecycle and systems foundations.

The audit found:

- **1 genuinely missing Area**: Software Lifecycle & Engineering Practice.
- **2 Areas needing scope/name expansion**: Runtime → include OS; Testing → include Debugging/Quality.
- Many missing Subareas within otherwise sound Areas.
- No evidence yet that the map needs to split into 20+ top-level Areas.

## External-reference check

SWEBOK v4.0a explicitly treats Requirements, Architecture, Design, Construction, Testing, Operations, Maintenance, Configuration Management, Process, Quality and Security as distinct professional software-engineering knowledge areas.

CS2023 separately emphasizes:
- Algorithmic Foundations
- Data Management
- Foundations of Programming Languages
- Networking
- Operating Systems
- Parallel/Distributed Computing
- Security
- Software Development Fundamentals
- Software Engineering
- Systems Fundamentals

Our map should not copy either taxonomy, but v1's omissions around Requirements/Maintenance/SCM and OS/System fundamentals were real.

## Areas that were already structurally strong

- Concurrency & Asynchrony
- Data Representation / I/O
- Networking / HTTP
- Frontend / Browser
- Data / Persistence
- Distributed Systems / Resilience
- Security

They mainly needed missing Subareas, not new top-level splits.

## Areas most changed

### A04 Runtime
v1 was too language-runtime-centric.
v2 adds process/thread/filesystem/system-call/virtual-memory/IPC fundamentals.

### A10 Distributed Systems
v1 covered resilience better than distributed-systems theory.
v2 adds time/order, consistency, replication, quorum, leader election, consensus, sharding, service discovery and delivery semantics.

### A13 Testing
v1 was too framework-test-centric.
v2 adds test-design methods, coverage, debugging, reviews, static quality and root-cause analysis.

### New A14 Lifecycle & Practice
Needed to own requirements, source/configuration management, maintenance, compatibility, refactoring, technical debt and development process.

### A15 Operations
v1 had logging/tracing/deployment gaps but omitted SLI/SLO, backup/restore/DR, incident response, IaC and release strategies.

## Most likely next controversy

The map is now broad enough that the main design issue is no longer missing Subareas; it is **boundary discipline**:
- A04 systems/runtime vs A03 concurrency
- A06 network/API vs A07 backend
- A09 persistence vs A10 distributed data
- A11 architecture vs A14 lifecycle
- A13 debugging vs A15 production diagnosis

These should be handled using canonical semantic ownership + secondary links, not by duplicating knowledge.
