# CSS positioning constraint equations

Knowledge ID: `css.positioning-constraint-equations`

Topic: `css`

Positioned values resolve against a containing block, not always the DOM parent. Absolute uses a qualifying ancestor; fixed usually uses viewport but transforms can establish another block. Relative positioning preserves the original flow slot and visually shifts the painted box.

Absolute horizontal layout solves one equation containing left/right, margins, borders, padding, and width; vertical layout is analogous. `auto` lets the browser solve a value. With left+width+right specified, one side becomes derived—commonly right in LTR and left in RTL. Both insets with auto width fill remaining space. When both insets and width are all `auto`, static-position and shrink-to-fit rules can participate.

Padding remains internal but contributes to the sizing equation according to the selected `box-sizing` model. Absolute margins participate but do not push siblings. `width:100%` plus 20px margins can yield `0 + 20 + W + 20 + right = W`, so `right = -40px`. Prefer both insets with auto width or deliberate box sizing for fill-available-space.

## Sources
- Workspace: `_ai-conspects/inset vs size,margins,formula/`
- Processed source: `regions/final-transcript.md`, complete transcript
