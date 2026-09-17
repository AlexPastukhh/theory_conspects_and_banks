# XMLHttpRequest lifecycle, progress, and streaming limits

Knowledge ID: `javascript.xhr-lifecycle-progress-and-streaming`

Topic: `javascript`

`open()` configures an XHR and `send()` starts it. The third `open` argument controls async behavior; wrapping a synchronous XHR in a Promise does not make it asynchronous. Response types include text, JSON parsed after completion, `ArrayBuffer`, `Blob`, and supported `Document`; raw bytes require an `ArrayBuffer` plus `Uint8Array`, not a universal `bytes` property.

```js
const xhr = new XMLHttpRequest();
xhr.open("GET", url, true);
xhr.responseType = "json";
xhr.onload = () => {
  if (xhr.status >= 200 && xhr.status < 300) onData(xhr.response);
};
xhr.onerror = () => onNetworkError();
xhr.send();
```

`progress` exposes `loaded`, `total`, and `lengthComputable`, but does not provide the newly arrived byte chunk. Incremental textual parsing must retain state across progress events:

```js
let lastIndex = 0;
let buffer = "";

xhr.onprogress = () => {
  buffer += xhr.responseText.slice(lastIndex);
  lastIndex = xhr.responseText.length;

  let newline;
  while ((newline = buffer.indexOf("\n")) >= 0) {
    const line = buffer.slice(0, newline).trim();
    buffer = buffer.slice(newline + 1);
    if (line) onItem(JSON.parse(line));
  }
};

xhr.onload = () => {
  const finalLine = buffer.trim();
  if (finalLine) onItem(JSON.parse(finalLine));
};
```

`lastIndex` prevents reprocessing old text, complete lines are emitted repeatedly, and the incomplete tail remains buffered until more text arrives. The `load` handler flushes a final record without a newline. `trim()` also removes meaningful surrounding whitespace; remove only trailing `\r` when the format requires preservation.

XHR ready states are `0 UNSENT`, `1 OPENED`, `2 HEADERS_RECEIVED`, `3 LOADING`, and `4 DONE`; lifecycle events include `readystatechange`, `loadstart`, `progress`, `load`, `loadend`, `error`, `abort`, and `timeout`. Set `xhr.timeout`, handle `ontimeout`, and cancel with `abort()`. A Promise wrapper must expose cancellation separately because a Promise itself has no abort method.

```js
return { promise, abort: () => xhr.abort() };
```

Incremental `responseText` is browser-decoded text, not original byte chunks. `ArrayBuffer`/`Blob` are generally useful as final values. Prefer Fetch `ReadableStream` for true progressive response-byte consumption; XHR remains useful for its mature event surface and upload progress.

XHR can also remain appropriate for legacy-browser support, existing code, precise upload/download progress, and its explicit abort/event controls. Prefer Fetch for modern Promise/`async` code and Service Worker integration. In either API, CORS governs whether cross-origin JavaScript may access a response; it is not a universal prohibition on sending cross-origin requests.

## Sources
- Workspace: `_ai-conspects/xhr/`
- Processed source: `01-final-transcript.md`, complete transcript
- Workspace: `_ai-conspects/cors vs anti forgery/`
- Authoritative processed source: `FINAL_TRANSCRIPT.md`, S-005 through S-007
- Original SVG: `source/cors vs anti forgery.svg`
