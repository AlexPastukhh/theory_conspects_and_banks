# Browser download navigation and Blob URL lifecycle

Knowledge ID: `javascript.browser-download-navigation-and-blob-urls`

Topic: `javascript`

Browser downloads have two different ownership models:

```text
native navigation
    browser requests the endpoint and manages display, streaming, and download UI

fetch/Axios + Blob
    application requests and buffers the bytes, then chooses how a Blob URL is used
```

## Native navigation

A link is the clearest simple-GET flow:

```html
<a href="/reports/42">Download report</a>
```

`window.location.href = "/reports/42"` navigates the current tab. To request another browsing context, use `window.open` or an anchor target:

```ts
window.open("/reports/42", "_blank", "noopener");
```

```html
<a href="/reports/42" target="_blank" rel="noopener">
  Open report
</a>
```

The server response and browser policy decide whether a supported representation is displayed inline or downloaded. An anchor's `download="report.pdf"` can suggest saving and a filename, but it is a browser hint rather than a guarantee; cross-origin URLs may not honor it, while `blob:` and `data:` URLs commonly do.

Link and `window.location` navigation fit a simple GET, cookie/session authentication, large files, and cases where the browser should stream and manage the transfer. Those simple mechanisms cannot attach an arbitrary application `Authorization` header or POST body.

## Fetching and using a Blob

Use fetch/Axios when the request needs a bearer header, POST body, custom error/progress handling, or client-side filename/content transformation:

```ts
const response = await fetch("/api/report");
const blob = await response.blob();
const url = URL.createObjectURL(blob);
```

Axios uses `responseType: "blob"`. In both flows, the browser normally materializes the response as a Blob before application code acts on it. For a very large file, native navigation or direct disk streaming can avoid this full Blob stage.

An object URL names browser-managed bytes. Release it after the browser has begun using it; revoking before the click or navigation is processed can break the action.

## Display versus forced download

To display a Blob in another context:

```ts
const url = URL.createObjectURL(blob);
window.open(url, "_blank", "noopener");
```

Inline behavior depends largely on `blob.type` and browser capabilities. PDFs, images, and text commonly have viewers; unknown binary types may download or show a save dialog.

To request a download and filename:

```ts
const link = document.createElement("a");
link.href = url;
link.download = "report.pdf";
document.body.appendChild(link);
link.click();
link.remove();

setTimeout(() => URL.revokeObjectURL(url), 0);
```

Once the application has fetched bytes and created a new Blob URL, the browser is no longer navigating to the original HTTP response. The original `Content-Disposition` no longer directly controls the Blob URL. Application code controls the Blob MIME type, open-versus-download choice, `download` filename, and object-URL lifetime.

## Production filename flow

`Content-Disposition` remains useful response metadata. A production flow can read it, parse `filename`, quoted `filename`, or RFC-style `filename*`, fall back safely, and assign the result to `link.download`:

```ts
const response = await api.get("/report", {
  responseType: "blob",
});

const blob = response.data as Blob;
const disposition = response.headers["content-disposition"] as
  | string
  | undefined;
const fileName = getFileName(disposition) ?? "report.pdf";

const url = URL.createObjectURL(blob);
const link = document.createElement("a");
link.href = url;
link.download = fileName;
document.body.appendChild(link);
link.click();
link.remove();
setTimeout(() => URL.revokeObjectURL(url), 0);
```

For a cross-origin response, the server must expose `Content-Disposition` through CORS before browser JavaScript can read it. A fragile one-line filename regex is not a robust parser when production correctness matters.

For a bearer-protected very large file, a protected prepare call can return a short-lived signed URL and hand the actual transfer back to native navigation. That security handoff is covered separately.

## Related knowledge

- `http.content-disposition-filenames`
- `security.signed-download-url-handoff`
- `javascript.file-system-access-save-and-streaming`
- `javascript.browsing-contexts-popups-and-targets`

## What should be recallable

- Which responsibilities differ between native navigation and a Blob flow?
- Why can native navigation handle large cookie-authenticated GETs well?
- Why can a link or `window.location` not attach an arbitrary bearer header or POST body?
- When is a response fully materialized as a Blob?
- Why must object URLs be revoked only after use has started?
- What controls inline display of a Blob URL?
- Why does the original `Content-Disposition` stop directly controlling a new Blob URL?
- What CORS policy is needed before JavaScript can read the suggested filename?

## Sources

- Workspace: `_ai-conspects/donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable/`
- Authoritative processed source: `regions/R01R02R03R04R05-semantic-transcript-final-v001.md`, R01-R03 excluding the focused signed-URL security details
- Original SVG: `source/donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable.svg`
- Workspace: `_ai-conspects/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison/`
- Authoritative processed source: `01-final-transcript.md`, R01 Blob download boundary
- Original SVG: `source/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison.svg`
