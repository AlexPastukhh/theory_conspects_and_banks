# Generator return and finally cleanup

Knowledge ID: `javascript.generator-finally-cleanup`

Topic: `javascript`

## Core model

Calling `iterator.return(value)` requests abrupt completion at the current suspension point, but applicable `finally` blocks run before completion.

```js
function* source() {
  try {
    yield "work-1";
    yield "work-2";
  } finally {
    console.log("cleanup");
  }
}

const iterator = source();

iterator.next();
iterator.return("END");
```

Normal completion, an injected error, and `return()` all pass through applicable `finally` blocks. This makes `finally` the natural location for releasing resources, closing handles, unsubscribing, logging completion, or propagating termination to an owned iterator.

## Finally can suspend termination

A `finally` block can itself yield:

```js
function* demo() {
  try {
    yield "work";
  } finally {
    yield "cleanup-1";
    yield "cleanup-2";
  }
}
```

After consuming `"work"`:

```js
iterator.return("END");
// { value: "cleanup-1", done: false }

iterator.next();
// { value: "cleanup-2", done: false }

iterator.next();
// { value: "END", done: true }
```

The termination request begins cleanup, but a yielded cleanup value suspends it. The consumer must continue draining the iterator until `finally` finishes and the requested completion value can be returned.

```text
return("END")
  -> termination starts;

finally yields
  -> termination pauses;

consumer continues next()
  -> cleanup values are drained;

finally completes
  -> iterator returns "END" with done: true.
```

Therefore `return(value)` does not guarantee that its immediate result is already `done: true`.

## What should be recallable

- Which completion paths pass through a generator's `finally` blocks?
- Why is `finally` appropriate for producer cleanup?
- What happens when `finally` yields after `iterator.return(value)`?
- Why must a consumer sometimes continue calling `next()` during termination?
- When is the originally requested return value finally observed?

## Related knowledge

- `javascript.generator-control-flow` — `next`, `return`, `throw`, and completion values.
- `javascript.async-generators-and-cancellation` — termination when asynchronous work is pending.

## Sources

- Workspace: `_ai-conspects/js yield, asyncenumerable, finally of generator/`
- Processed source: `01-final-transcript.md`, R03 and generator-cleanup material from R04
- Original SVG: `source/js yield, asyncenumerable, finally of generator.svg`
