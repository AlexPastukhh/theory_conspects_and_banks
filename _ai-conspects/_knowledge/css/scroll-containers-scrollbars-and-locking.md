# Scroll containers, scrollbar visibility, and scroll locking

Knowledge ID: `css.scroll-containers-scrollbars-and-locking`

Topic: `css`

An internal scroll area needs overflowing content, a constrained axis, and an overflow policy. `overflow: auto` shows scrolling only on overflow; `overflow-x: auto`/`overflow-y: auto` limit it to one axis; `overflow: scroll` reserves a scrolling mechanism even while content fits. Flex/grid children often require `min-height: 0` or `min-width: 0`; an unconstrained parent height cannot create an internal vertical scrollbar. Overflow clipping and scrollability are different concerns. Keep keyboard/touch access and visible affordances; nested scrolling needs deliberate interaction design.

Hide only scrollbar chrome while retaining overflow: Firefox uses `scrollbar-width: none`, legacy Microsoft used `-ms-overflow-style`, and WebKit/Blink expose `::-webkit-scrollbar`. Styling or a narrow visible bar often preserves discoverability; WebKit pseudo-elements are progressive enhancement. Hidden bars can suit carousels, draggable chips, or overlays with another strong affordance, while long document content should normally retain a visible scrollbar. Hidden chrome can make content appear truncated, and OS overlay-scrollbar settings change the observed result.

Modal body locking must restore the previous inline overflow, centralize/reference-count overlapping locks, compensate scrollbar gap or use `scrollbar-gutter: stable`, and handle mobile position preservation. Keep the overlay scrollable, clean up on unmount/navigation, trap focus, and mark background inert. Scroll lock alone is not modal accessibility; blanket wheel/touch prevention can block overlay scrolling.

## Sources
- Workspace: `_ai-conspects/scroll block/`; processed source: `04-full-combined-final-transcript.md`
- Duplicate workspace: `_ai-conspects/scroll block css/`; same complete semantic transcript
