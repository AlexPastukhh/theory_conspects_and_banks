# Vitest module mocking

Knowledge ID: `testing.vitest-module-mocking`

Topic: `testing`

`vi.mock` is hoisted before tested imports and its resolved path must match production. Put shared handles in `vi.hoisted`; partial mocks can retain actual exports:

```ts
const mocks = vi.hoisted(() => ({ navigate: vi.fn() }));
vi.mock("react-router-dom", async () => ({
  ...(await vi.importActual("react-router-dom")),
  useNavigate: () => mocks.navigate,
}));
```

Do not create a new mock per hook call. `mockClear` clears calls, `mockReset` also clears implementation/results, and `mockRestore` restores spies/restorable mocks. Reset owned handles between tests; use `vi.mocked` or explicit types instead of `any`. Recreate module state only with careful reset and re-import ordering.

## What should be recallable

- Explain the core model of **Vitest module mocking** without opening the Unit.
- Reconstruct this Unit-grounded rule: `vi.mock` is hoisted before tested imports and its resolved path must match production.
- Reconstruct this Unit-grounded rule: Do not create a new mock per hook call.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources
- Workspace: `_ai-conspects/vitest mocking/`
- Processed source: `01-final-transcript.md`, complete transcript
