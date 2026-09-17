# File System Access save, streaming, and writer lifecycle

Knowledge ID: `javascript.file-system-access-save-and-streaming`

Topic: `javascript`

The File System Access API lets a supported browser ask the user for an exact save target and write through a `FileSystemWritableFileStream`.

## Select a target

```ts
const handle = await window.showSaveFilePicker({
  suggestedName: "report.csv",
  startIn: "downloads",
  id: "exports",
  types: [
    {
      description: "CSV files",
      accept: { "text/csv": [".csv"] },
    },
  ],
  excludeAcceptAllOption: false,
});
```

- `suggestedName` supplies the initial filename.
- `startIn` supplies a preferred starting directory or handle.
- `id` separates remembered picker locations by purpose.
- `types` describes offered MIME/extension choices.
- `excludeAcceptAllOption` controls the generic All Files choice.

The browser may remember different locations for different picker IDs.

## Write and commit

```ts
const writable = await handle.createWritable();
await writable.write(data);
await writable.close();
```

Writing uses a temporary backing file; `close()` commits the save to the selected file.

When fetch exposes a streaming body, it can be piped directly to the writable instead of first building one giant Blob:

```ts
const response = await fetch("/api/files/report");

if (!response.body) {
  throw new Error("Streaming body unavailable");
}

const handle = await window.showSaveFilePicker({
  suggestedName: "report.pdf",
});

const writable = await handle.createWritable();
await response.body.pipeTo(writable);
```

## Preserve and edit existing data

Without `keepExistingData`, the temporary writable starts empty. With it, the temporary file begins as a copy of the selected file, which permits seeking and editing a portion:

```ts
const writable = await handle.createWritable({
  keepExistingData: true,
});

await writable.seek(6);
await writable.write("CHANGED");
await writable.close();
```

`FileSystemWritableFileStream` also supports file-oriented positioning and truncation operations before final `close()`, so a sink can do more than append or replace one whole value.

## Writer concurrency modes

An exclusive writer prevents a second writer from opening the same file concurrently:

```ts
await handle.createWritable({ mode: "exclusive" });
```

Siloed writers can use separate temporary backing files; the last valid writer to close may determine final contents according to browser/API behavior:

```ts
await handle.createWritable({ mode: "siloed" });
```

Prefer one active writer for one logical save unless concurrent editing is deliberately designed.

## Capability and fallback boundary

The API is not universal. It normally requires a secure context, user activation, a supporting browser, and permission for the selected file. Keep a Blob-plus-anchor fallback for unsupported environments.

## Related knowledge

- `javascript.browser-download-navigation-and-blob-urls`

## What should be recallable

- What does each save-picker option control?
- At what point is a temporary write committed?
- How can a response body be written without first materializing one giant Blob?
- What changes when `keepExistingData` is true?
- How do exclusive and siloed writer modes differ?
- Which browser/security prerequisites require a fallback?

## Sources

- Workspace: `_ai-conspects/donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable/`
- Authoritative processed source: `regions/R01R02R03R04R05-semantic-transcript-final-v001.md`, R04 and the File System Access decision/checklist claims
- Original SVG: `source/donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable.svg`

- Workspace: `_ai-conspects/pipethrough,transformstream,pipeto,writablestream, readablestream/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R06 file-writing claims
- Original SVG: `source/pipethrough,transformstream,pipeto,writablestream, readablestream.svg`
