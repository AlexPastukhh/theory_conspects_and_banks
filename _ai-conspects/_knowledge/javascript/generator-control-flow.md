# Generator execution, yield, and completion

Knowledge ID: `javascript.generator-control-flow`

Topic: `javascript`

## Core model

Calling a generator function returns an iterator immediately. The function body begins only when the consumer requests a value.

```js
function* numbers() {
  yield 1;
  yield 2;
  return 3;
}

const iterator = numbers();

iterator.next();
// { value: 1, done: false }
```

`yield` produces an intermediate value, suspends execution, and preserves the continuation. A later `next()` resumes from that suspension point. `return` completes the iterator.

```text
next()
  -> resume until the next yield or completion;

return(value)
  -> request early completion;

throw(error)
  -> inject an error at the suspended point.
```

## Yielded and returned values

```js
function* demo() {
  yield 10;
  yield 20;
  return 30;
}
```

Manual iteration can observe:

```text
{ value: 10, done: false }
{ value: 20, done: false }
{ value: 30, done: true }
```

A normal `for...of` consumes yielded items but ignores the final `done: true` value.

## Consumption boundary

The consumer controls when execution advances:

```js
for (const value of numbers()) {
  console.log(value);
}
```

This pull boundary is central to generator behavior: the producer runs only as the consumer asks for items or termination.

## What should be recallable

- When does a generator body begin executing?
- What state does `yield` preserve?
- How do `next`, `return`, and `throw` affect a suspended generator?
- How does a returned final value differ from a yielded value?
- Why does `for...of` not expose the final `done: true` value?

## Related knowledge

- `javascript.async-generators-and-cancellation` — asynchronous production and cancellation.
- `javascript.generator-finally-cleanup` — termination through cleanup blocks.

## Sources

- Workspace: `_ai-conspects/js yield, asyncenumerable, finally of generator/`
- Processed source: `01-final-transcript.md`, generator boundary material from R01 and synchronous generator material from R02
- Original SVG: `source/js yield, asyncenumerable, finally of generator.svg`
