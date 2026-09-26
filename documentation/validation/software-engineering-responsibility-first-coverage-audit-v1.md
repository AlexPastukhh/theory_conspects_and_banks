# Responsibility-First Coverage Audit v1

Status: current validation evidence for the pre-CS5 responsibility/manifestation coverage pass.

## Result

- generic responsibilities assessed: **183**;
- `PARTIAL`: **101**;
- `MISSING`: **82**;
- `COVERED`: **0** (intentionally not asserted by this pass);
- cross-runtime baseline responsibilities: **30**;
- ecosystems checked: `.NET`, JavaScript language, Browser, Node.js, Python, plus generic responsibility state.

## What changed conceptually

Earlier coverage primarily asked whether current corpus Units occupied an Area/nested Area. This pass instead starts from durable engineering responsibilities seeded by Map v3 and the accepted methodology, then asks whether current durable knowledge supports each responsibility.

This exposes gaps that corpus-shaped taxonomy alone cannot reveal. It also supports reverse/symmetric discovery: a responsibility identified while thinking about Python or Node must be checked for .NET as well, rather than treating the current .NET-heavy corpus as the definition of completeness.

## Ontology consequences

Two hierarchy corrections are justified by the responsibility audit:

1. `A03` needs an explicit broad nested Area **Threads, Processes & Parallelism** even though current generic coverage is weak. Threads/processes/workers are a durable concurrency responsibility and should not disappear into async task scheduling.
2. `A08` broad node **Accessibility & Interaction** is widened to **Markup, Accessibility & Interaction** so semantic HTML/forms/accessibility responsibilities have a durable home independent of React/CSS implementations.

The responsibility list itself is **not** promoted to nested Areas one-for-one. Most items remain Concepts/coverage responsibilities under the existing hierarchy.

## Repetition gate

This pass does not touch repetition state. It improves expansion/coverage semantics only. CS5 repetition cutover remains technically possible after this pass, but expansion priorities should now use responsibility/manifestation gaps rather than empty-folder counts alone.
