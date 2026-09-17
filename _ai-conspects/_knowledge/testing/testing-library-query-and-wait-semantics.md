# Testing Library query and wait semantics

Knowledge ID: `testing.testing-library-query-and-wait-semantics`

Topic: `testing`

`getByRole` is synchronous and throws for zero/multiple matches; use it for present UI. `queryByRole` returns null for absence but still throws for multiples. `findByRole` returns a retrying Promise and suits asynchronously appearing UI. Prefer role/name and plural variants when multiples are expected.

`waitFor` retries while its callback throws—returning false does not retry. Use `findBy` for one element and `waitFor` for mock calls, attributes, or related assertions. Trigger/await `userEvent` before waiting; never repeat side effects inside `waitFor`. Async callbacks alter retry timing and long timeouts can hide broken setup.

```ts
await waitFor(() => {
  expect(api.save).toHaveBeenCalledTimes(1);
  expect(screen.getByRole("status")).toHaveTextContent("Saved");
});
```

Helpers should accept semantic role/name options, use `findByRole`, return the element, preserve useful errors, and exist only for repeated domain-level assertions.

## Sources
- Workspace: `_ai-conspects/viTst existance assert test/`
- Processed source: `04-full-combined-final-transcript.md`, complete transcript
