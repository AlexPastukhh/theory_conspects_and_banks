# Diagnosing Vitest React environment errors

Knowledge ID: `testing.vitest-react-environment-errors`

Topic: `testing`

React Testing Library needs `jsdom`; the root-discovered Vitest config must set it (or use the per-file annotation). Shared matchers belong in setup files:

```ts
export default defineConfig({
  plugins: [react()],
  test: {
    environment: "jsdom",
    globals: true,
    setupFiles: ["./src/setupTests.ts"],
  },
});
```

Render every required provider and create a fresh React Query client per test to prevent cache leakage:

```tsx
const queryClient = new QueryClient({
  defaultOptions: { queries: { retry: false } },
});

render(
  <QueryClientProvider client={queryClient}>
    <RouterProvider router={router} />
  </QueryClientProvider>
);
```

SVG imports must match the build contract: configure SVGR for components or render URL imports through `<img>`. A URL string used as a JSX tag causes a DOM error. Data-router tests should use an explicit boundary so default boundary UI does not hide failures:

```tsx
const router = createMemoryRouter([{
  path: "/register",
  element: <Register />,
  errorElement: <RouteError />,
}]);
```

Diagnose: first application stack frame → jsdom → providers → asset plugins → route boundary → cache/mock isolation.

## What should be recallable

- Explain the core model of **Diagnosing Vitest React environment errors** without opening the Unit.
- Reconstruct this Unit-grounded rule: React Testing Library needs `jsdom`; the root-discovered Vitest config must set it (or use the per-file annotation).
- Reconstruct this Unit-grounded rule: SVG imports must match the build contract: configure SVGR for components or render URL imports through `<img>`.
- Reconstruct this Unit-grounded rule: Diagnose: first application stack frame → jsdom → providers → asset plugins → route boundary → cache/mock isolation.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources
- Workspace: `_ai-conspects/vitest test errors/`
- Processed source: `01-final-transcript.md`, complete transcript
