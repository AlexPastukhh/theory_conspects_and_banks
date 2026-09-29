# Typed Axios clients and runtime boundaries

Knowledge ID: `axios.typed-client-boundaries`

Topic: `axios`

## Centralize transport policy behind a typed client

A dedicated Axios client centralizes the base URL and transport policy while TypeScript generics describe the expected compile-time data shape.

After installing Axios, import `AxiosInstance`, `AxiosRequestConfig`, `AxiosResponse`, and `AxiosError` as needed by the client boundary.

Use `axios.create` to build an `AxiosInstance` rather than sharing mutable global defaults. An API module can wrap the instance with methods such as `getUsers(params)` or `createUser(input)` so components do not construct transport configuration directly.


Domain-specific error conversion belongs at the wrapper boundary rather than leaking every transport detail into application components.

## Generics describe expectations; they do not validate JSON

A call such as:

```ts
api.get<User[]>("/users")
```

types `response.data` as `User[]` at compile time. Request-body and response-body types should be distinct when the server contracts differ.

The generic does not validate runtime JSON. TypeScript types disappear at runtime, so an untrusted response still needs runtime schema validation when that boundary matters.

## Response and error boundaries

An `AxiosResponse` exposes fields such as `status`, `statusText`, `headers`, `data`, and `config`.

Use `axios.isAxiosError` to narrow an unknown error before relying on Axios-specific fields. Error handling should distinguish:

- a server response represented on the Axios error;
- network or browser CORS failures where no ordinary server response is available;
- request/setup failures.

The wrapper can then convert those transport outcomes into the application's domain-specific error model.

## Cancellation, timeout, and retries

Pass `AbortSignal` through wrapper methods when callers need cancellation.

Axios timeout and AbortSignal solve related but distinct cancellation needs. Axios does not retry requests by default. Retry logic should be limited to safe/idempotent operations or to request semantics that were explicitly designed to tolerate retries.

## Representative wrapper

```ts
type ApiError = { message: string; code: string };

export const api: AxiosInstance = axios.create({
  baseURL: "https://api.example.com",
  timeout: 10_000,
  headers: { "Content-Type": "application/json" }
});

export async function getUsers(params: UsersQuery, signal?: AbortSignal) {
  const response = await api.get<User[]>("/users", { params, signal });
  return response.data;
}
```

## What should be recallable

- Why put Axios behind a dedicated instance and API wrapper?
- What do Axios TypeScript generics guarantee, and what do they not guarantee?
- Why might request and response types differ?
- Which response fields are available when a wrapper needs transport metadata?
- How does `axios.isAxiosError` help with unknown errors?
- Which error categories should a client distinguish?
- How do AbortSignal and Axios timeout differ in responsibility?
- Does Axios retry by default?
- What constraint should govern retrying operations?

## Related knowledge

- `axios.request-configuration-and-instance-defaults`
- `axios.files-and-query-serialization`
- `axios.interceptor-lifecycle-status-and-token-refresh`
- `typescript.any-vs-unknown-external-data`

## Sources

- Workspace: `_ai-conspects/axios/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R04 excluding file/binary and query-serialization claims routed to `axios.files-and-query-serialization`
- Original SVG identity recorded by Stage0: `source/axios.svg` (not physically present under the workspace `source/` directory on the current branch)
