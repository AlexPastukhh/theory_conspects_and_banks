# Change Log — v11

Relative to v10, this release is a consistency-cleanup release rather than a new architecture.

1. Removed the global `Daily work selection order` from Repetition Scheduling Policy.
   Repetition now owns only review/repetition scheduling; it does not rank itself against Capture/Triage or Expansion.

2. Updated `UC-KNOWLEDGE-EXPAND-BY-ANALOGY`.
   The Use Case keeps comparison/transfer learning, but fixed pairwise relation enums are no longer required.
   Comparison may be written in free-form durable comparison Knowledge Units.

3. Updated `UC-KNOWLEDGE-PLAN-EXPANSION`.
   It now explicitly owns optional temporal/order placement into Expansion Plan after semantic placement, scope and priority are established.

4. Normalized local Question Inbox placement to `Area / nested Area / Concept`.

5. Clarified Key Question identity.
   Simple defining Key Questions may live locally without a stable independent Question ID.
   Independent identity is required when the Question needs planning, lifecycle/history, references, priority or resolution tracking.

6. Rewrote the end-to-end simulation to exercise:
   - local Question Inbox/placement;
   - Key vs Open Expansion Questions;
   - Coverage & Expansion;
   - Expansion Plan;
   - comparison-unit ownership;
   - ACTIVE/STABLE transition;
   - Repetition;
   - MEMORY_GAP vs KNOWLEDGE_BASE_GAP;
   - absence of a global daily scheduler.

7. No new core view, entity, relation graph, or retention class was introduced.
