# CSS selector exclusion with `:not()`

Knowledge ID: `css.not-selector-exclusion`

Topic: `css`

The `:not()` pseudo-class matches an element only when the selector inside `:not(...)` does not match it:

```css
element:not(selector) {
}
```

The argument is not limited to a class; it can be another selector form. A common use is excluding one class from a base selection:

```css
button:not(.primary) {
  opacity: 0.6;
}
```

This selects buttons without `.primary`. The base selector can itself be a class:

```css
.card:not(.active) {
  opacity: 0.6;
}
```

This matches elements that have `.card` but do not have `.active`.

```css
.base:not(.excluded) {
  /* .base elements for which .excluded is absent */
}
```

## What should be recallable

- What condition `:not(selector)` adds to the base selector.
- How to select a class or element while excluding another class.
- That the argument can be a selector, not only a class name.

## Sources

- Workspace: `_ai-conspects/not/`
- Authoritative reconstructed source: `regions/R01R02-css-not-final-transcript-v001.md`, complete transcript
- Original SVG: `source/not.svg`
