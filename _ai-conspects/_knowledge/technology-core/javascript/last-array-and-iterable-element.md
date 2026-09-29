# Reading the last array or iterable element

Knowledge ID: `javascript.last-array-and-iterable-element`

Topic: `javascript`

## Core model

For an array, `.at(-1)` clearly expresses access from the end and returns `undefined` when the array is empty:

```js
const last = values.at(-1);
```

The older indexed form is also O(1):

```js
const last = values[values.length - 1];
```

`pop()` returns the last element in O(1) time but mutates the source. `slice(-1)[0]` avoids mutation but copies and therefore does O(n) copying work; it is unnecessary for simple access.

## Generic iterables

A generic iterable has no universal direct last-element operation. Read it in one pass:

```ts
let last: T | undefined;

for (const item of iterable) {
  last = item;
}
```

Spreading a `Set` or another iterable is convenient but allocates:

```js
const last = [...set].at(-1);
```

That spread traverses the iterable and creates an intermediate array, so it costs O(n) time and memory. Prefer the one-pass loop when copying only to read the last value is undesirable.

## What should be recallable

- What does `.at(-1)` return for a non-empty and an empty array?
- What older indexed syntax provides the same O(1) access?
- Which alternative mutates the array, and which copies?
- Why must a generic iterable normally be traversed?
- What allocation does spreading a `Set` introduce?

## Sources

- Workspace: `_ai-conspects/last element/`
- Processed source: `01-final-transcript.md`, complete semantic region
- Original SVG: `source/last element.svg`
- Additional workspace: `_ai-conspects/last element sharp/`
- Additional processed source: `regions/R01-semantic-transcript-final-v001.md`, complete transcript
- Additional original SVG: `source/last element sharp.svg` (content is byte-identical to the original `last element` source)
