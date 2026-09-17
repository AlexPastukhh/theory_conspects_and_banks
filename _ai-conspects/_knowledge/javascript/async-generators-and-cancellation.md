# Async generators and responsive cancellation

Knowledge ID: `javascript.async-generators-and-cancellation`

Topic: `javascript`

## Core model

An async generator can await asynchronous work between yielded values:

```js
async function* numbersAsync() {
  yield 1;

  await new Promise(
    resolve => setTimeout(resolve, 500),
  );

  yield 2;
}
```

Consume it with asynchronous iteration:

```js
for await (const value of numbersAsync()) {
  console.log(value);
}
```

`function*` is broadly analogous to `.NET IEnumerable<T>`, while `async function*` is broadly analogous to `.NET IAsyncEnumerable<T>`. The analogy does not make their cancellation, disposal, or final-value APIs identical.

## Propagating early termination

A wrapper that owns an iterator should give the underlying producer a chance to clean up:

```js
async function cancel(reason) {
  console.log("Cancelled:", reason);

  if (typeof iterator.return === "function") {
    await iterator.return();
  }
}
```

```text
consumer cancellation
  -> wrapper cancellation hook
  -> underlying iterator.return()
  -> producer finally block.
```

## Return request versus I/O cancellation

`iterator.return()` requests iterator completion and cleanup. It does not automatically interrupt arbitrary awaited work.

Async-generator control requests are processed in sequence. If the generator is blocked in an await that never settles, a later `return()` cannot reach `finally` until control leaves that await.

An `AbortSignal` and `return()` solve related but different problems:

- a cooperative signal can interrupt the awaited operation;
- `return()` requests iterator termination and cleanup.

Responsive shutdown may require both mechanisms.

## What should be recallable

- How is an async generator declared and consumed?
- What is useful—and limited—about the `IAsyncEnumerable<T>` analogy?
- Why should an owning wrapper propagate cancellation through `iterator.return()`?
- Why can `return()` fail to interrupt a currently blocked await promptly?
- How do an `AbortSignal` and `iterator.return()` complement each other?

## Related knowledge

- `javascript.generator-control-flow` — the synchronous iterator state model.
- `javascript.generator-finally-cleanup` — cleanup initiated by iterator termination.

## Sources

- Workspace: `_ai-conspects/js yield, asyncenumerable, finally of generator/`
- Processed source: `01-final-transcript.md`, cancellation material from R01, async-generator material from R02, and async caveat from R04
- Original SVG: `source/js yield, asyncenumerable, finally of generator.svg`
