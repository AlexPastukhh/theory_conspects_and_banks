# Software Engineering Map — Second-Angle Audit (v2 → v3)

Status: supporting audit evidence.

## What was checked this time

Unlike the v1→v2 audit, this pass did not primarily ask "which technical topics are missing?"

It checked the map through additional lenses:

1. **Product quality:** ISO/IEC 25010:2023.
2. **Production reliability:** Google SRE books/workbook.
3. **Secure SDLC:** OWASP SAMM + NIST SSDF.
4. **Platform neutrality:** CS2023 Specialized Platform Development.
5. **Lifecycle coherence:** source → build → release → operate → incident → maintenance.
6. **Canonical ownership:** repeated concepts that naturally occur in several Areas.
7. **Non-web applicability:** worker/batch/CLI/desktop/mobile/platform software.
8. **Repository pressure:** existing .NET/ASP.NET/EF/JS/HTTP units that already cross old topic boundaries.

## Main conclusion

The **15 Area count survives**.

The weaknesses were mostly:
- naming bias;
- duplicated/unclear concept ownership;
- missing quality/reliability/security lifecycle views;
- missing production and release subareas.

## Why no new Area was added

### Quality
Quality properties are requirements and evaluation dimensions that cut through architecture, implementation, testing and operations. ISO/IEC 25010 explicitly defines a product-quality model; turning each property into a physical Area would duplicate the ontology. A generated Quality Attributes view is cleaner.

### Reliability
Google SRE spans monitoring, SLOs, toil, release engineering, incident response, overload and distributed-system design. Those concepts naturally map across A10 and A15 (plus A13), so one new "Reliability" Area would mostly duplicate them.

### Secure SDLC
OWASP SAMM and NIST SSDF show that security spans governance/design/implementation/verification/operations. Security remains A12, while lifecycle integrations link to A14/A15.

### Platform development
CS2023 treats web/mobile/game/industrial as platform-specific development examples. This supports the existing Technology Core / manifestation model rather than adding Web/Mobile top-level Areas.

## Strong corrections

### A01 ↔ A04
v2 let A01 own compiler/interpreter/runtime concepts while A04 already owned runtime/compiler/SDK. v3 makes A01 about language semantics and A04 about execution/toolchain/runtime.

### Time
v2 placed general temporal abstractions in A01. v3 moves clock/timer/timezone foundations to A04 and leaves distributed clocks/order in A10.

### Caching
v2 deliberately left caching unresolved. v3 proposes:
- general cache/derived-state semantics → A09;
- HTTP cache → A06;
- client/server-state cache → A08;
- distributed cache coordination → A10.

### Configuration
v3 distinguishes:
- application configuration consumption → A07;
- source/configuration management → A14;
- operational configuration validation/rollout/rollback → A15.

### Debugging
- controlled/local debugging methodology → A13;
- production incident troubleshooting → A15.

### Quality attributes
Architecture reasons about them, requirements select them, tests verify them, operations measure them. Therefore they are a logical view, not a folder tree.

## Subareas newly emphasized

- SLI/SLO/error budgets
- operational toil/automation
- production readiness
- hermetic/reproducible builds
- artifact identity/promotion
- operational config rollout/rollback
- secure build/development environment
- vulnerability disclosure/response
- software provenance
- chaos/fault-injection testing
- caching/derived state
- data pipelines
- non-web application hosts
- conditional desktop/mobile clients
- protocol version/framing beyond HTTP

## Residual risk

The next likely source of ontology error is no longer "forgotten subject matter."

It is **mapping friction**:
- too many units needing two equally plausible canonical owners;
- Technology Core exception being used too broadly;
- Subareas that are too fine-grained to be useful;
- logical views accidentally becoming duplicate storage.

That can only be tested reliably by mapping a substantial real sample of Knowledge IDs.
