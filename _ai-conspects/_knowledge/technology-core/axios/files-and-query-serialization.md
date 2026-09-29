# Axios files, binary responses, and query serialization

Knowledge ID: `axios.files-and-query-serialization`

Topic: `axios`

## File uploads use the platform's multipart encoding

Upload browser files with `FormData`. Let the browser generate the multipart boundary.

Do not manually set a multipart boundary unless the application is constructing the entire encoded body itself.

## File downloads choose a response representation

For browser downloads, use:

```ts
responseType: "blob"
```

when application code needs a Blob. A browser download flow can create an object URL for that Blob and revoke the URL after use.

Use `arraybuffer` when the caller needs raw binary manipulation rather than a Blob-oriented browser flow.

These choices are response-representation concerns; they are separate from the server-side meaning of the file.

## Query serialization must match the backend

Axios serializes a plain `params` object into the query string. `params` is not the request body.

Arrays may need different wire formats depending on the backend, including:

- repeated keys;
- bracketed keys;
- comma-separated values;
- indexed values.

Nested-object conventions also vary across server frameworks.

Configure `paramsSerializer`, including with a serializer such as `qs`, when the backend expects a particular format instead of Axios' default representation.

## What should be recallable

- Why should browser file uploads use `FormData` without manually inventing the multipart boundary?
- When is `responseType: "blob"` the useful browser response representation?
- What lifecycle obligation comes with an object URL created for a downloaded Blob?
- When is `arraybuffer` a better response representation?
- Why is `params` distinct from the request body?
- Which array query-string shapes may a backend expect?
- Why can nested query objects require an explicit `paramsSerializer`?

## Related knowledge

- `axios.request-configuration-and-instance-defaults`
- `axios.typed-client-boundaries`
- `javascript.browser-download-navigation-and-blob-urls`
- `javascript.binary-storage-arraybuffer-typedarrays-and-blob`

## Sources

- Workspace: `_ai-conspects/axios/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, query/body configuration in R01 and file/binary/query-serialization material in R04
- Original SVG identity recorded by Stage0: `source/axios.svg` (not physically present under the workspace `source/` directory on the current branch)
- Workspace: `_ai-conspects/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison/`
- Authoritative processed source: `01-final-transcript.md`, R01 query-shape and Blob-response comparison
- Original SVG: `source/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison.svg`
