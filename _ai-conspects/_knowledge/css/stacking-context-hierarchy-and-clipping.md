# CSS stacking-context hierarchy and clipping

Knowledge ID: `css.stacking-context-hierarchy-and-clipping`

Topic: `css`

`z-index` is local to the relevant stacking context, not a global layer. Static elements generally do not use integer z-index as positioned stacking control, though flex/grid items have special behavior. `position:relative` with `z-index:auto` does not itself isolate; positioned non-auto z-index does. A child at 1000 inside parent layer 1 remains behind a sibling parent at layer 2 because nested contexts paint atomically.

Common context triggers include the root, positioned non-auto z-index, fixed/sticky positioning, opacity below 1, transforms, filters, perspective, isolation, compositing/masking/clipping/containment rules, and flex/grid items with non-auto z-index. A visual/animation property can unexpectedly change hierarchy. Contexts and containing blocks are distinct even when one property creates both.

Debug from the element toward the root, record every context, find the first diverging sibling contexts, and compare those parents before descendant z-index. DOM order still matters among elements in the same painting category. The complete trigger list evolves with CSS features, so inspect computed styles rather than relying only on a memorized list. Remove transform/opacity/isolation temporarily to test hierarchy. Use a documented small layer scale or shared portal/overlay root rather than escalating numbers.

Pseudo-elements belong to their originating element's context and can extend outside its border box, but `overflow:hidden`, clips, masks, or containment can cut them off. Negative layers may fall behind the parent's background. Test clipping separately by removing overflow, and restructure wrappers or move global overlays when a child should not be constrained. Preserve focus order, pointer behavior, and accessibility in visual fixes.

## Sources
- Workspace: `_ai-conspects/stacking contexts, zindex/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
