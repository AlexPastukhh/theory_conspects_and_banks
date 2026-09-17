# React Router redirect tests

Knowledge ID: `testing.react-router-redirect-tests`

Topic: `testing`

Match the production router. For data routers, define minimal start/destination routes, use `createMemoryRouter(..., {initialEntries})`, render `RouterProvider`, perform realistic user input, and assert destination UI plus exact `router.state.location.pathname` when path/query/params are contractual. Mock external I/O, not routing.

For declarative `<Routes>`, use `MemoryRouter` and a tiny `useLocation` display only when exact path must be observable. Destination content is usually the most user-centered assertion; add path assertions only when needed. `initialEntries` configures history—it is not an assertion.

Use `findBy...` for async navigation. Data-router style supports loaders/actions/redirects/error elements; component-router style is lighter for context-only tests. Keep successful redirect, validation failure, and server failure in separate tests; avoid asserting a navigation mock when real routing can be exercised.

## Sources
- Workspace: `_ai-conspects/router and redirect tests/`
- Processed source: `04-full-combined-final-transcript.md`, complete transcript
