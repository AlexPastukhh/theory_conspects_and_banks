# Axios payload transforms and interceptor boundaries

Knowledge ID: `axios.payload-transforms-and-interceptor-boundaries`

Topic: `axios`

## Transforms are payload hooks

`transformRequest` and `transformResponse` change payload data at fixed points inside one request. They are different from interceptors, which operate on the broader request/response pipeline.

`transformRequest` runs before the body is sent. It receives outgoing data and headers and can return serialized data. It is primarily relevant to body-bearing methods such as PUT, POST, PATCH, and DELETE. Typical uses include body serialization, body normalization, and body-related Content-Type selection.

`transformResponse` runs after response bytes have been received but before the caller's `then` or `await` receives `response.data`. It can parse or normalize the body and can be chained with Axios defaults.

Runtime schema validation can be applied at this stage, but transport parsing and domain validation are often kept as separate boundaries. A transform should not be used as a substitute for a global error policy.

## Interceptors are pipeline hooks

Request interceptors see the full request config and apply even to requests such as GET that may have no body transform. They fit cross-cutting work such as bearer tokens, correlation IDs, locale headers, logging, retries, and request-wide policy.

Response interceptors see the full response or an `AxiosError`. They can centralize response mapping, error mapping, and refresh-token flows.

The distinction is:

```text
transformRequest / transformResponse
    -> payload hooks at fixed request stages

request / response interceptors
    -> hooks around the full request/response pipeline
```

This is why Authorization policy should not live only in `transformRequest`: GET requests can bypass the intended body-transform path.

## Preserve default transforms when extending them

A source pattern extends Axios defaults instead of accidentally replacing them:

```ts
const api = axios.create({
  transformRequest: [
    ...axios.defaults.transformRequest as AxiosRequestTransformer[],
    (data, headers) => {
      headers.set("Content-Type", "application/json");
      return data;
    }
  ],
  transformResponse: [
    ...axios.defaults.transformResponse as AxiosResponseTransformer[],
    data => data
  ]
});
```

## What should be recallable

- When does `transformRequest` run, what does it receive, and what can it return?
- When does `transformResponse` run relative to `response.data` reaching the caller?
- What work belongs naturally in transforms?
- Why are interceptors broader than transforms?
- Why can putting Authorization policy only in `transformRequest` miss intended requests?
- Why can runtime schema validation be placed near response transformation without making TypeScript types runtime validation?
- Why does extending the transform arrays preserve Axios' existing transformation behavior?

## Related knowledge

- `axios.request-configuration-and-instance-defaults`
- `axios.interceptor-lifecycle-status-and-token-refresh`
- `axios.typed-client-boundaries`

## Sources

- Workspace: `_ai-conspects/axios/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R02 excluding the cancellation/progress details routed to `axios.adapters-progress-and-streaming` and status-policy details routed to `axios.interceptor-lifecycle-status-and-token-refresh`
- Original SVG identity recorded by Stage0: `source/axios.svg` (not physically present under the workspace `source/` directory on the current branch)
