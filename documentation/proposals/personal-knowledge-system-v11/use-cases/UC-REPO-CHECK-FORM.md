# UC-REPO-CHECK-FORM — Check Knowledge-System Form

## Situation
The structural correctness and invariants of the knowledge system should be checked.

## Result
A read-only report describing:
- which invariants were checked;
- which passed;
- which defects were found;
- which boundaries remain unverified;
- which owner/process should repair each defect.

The Use Case does not repair the system itself.

## Process
1. Define check scope.
2. Check relevant structural invariants.
3. Check IDs, links, indexes, states, and registries when in scope.
4. Check consistency between relevant layers.
5. Separate `VERIFIED`, `DEFECT`, and `UNVERIFIED`.
6. Record findings.
7. Route defects to the semantic owner responsible for the affected structure.
8. Re-run after external repair when needed.

## Boundary
`Check` and `Repair` produce different Results. Repair belongs to the affected semantic owner.
