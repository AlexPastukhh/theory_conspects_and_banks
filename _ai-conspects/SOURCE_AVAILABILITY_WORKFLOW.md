# Source Availability Workflow

Generated: 2026-06-01 17:00:51 UTC

## Why this note exists

The project has two related but separate concerns:

```text
1. Raw source availability
2. Processed AI-readable text output
```

Raw source availability is not a one-time finished state. New Excalidraw bundles may be added over time.

Therefore, future AI chats should not assume that all conspects already have complete bundles, and should not ask for screenshots one-by-one before checking the raw source branch.

---

## Raw source branch

The raw/source branch is:

```text
ai-processing-excalidraw-conspects
```

This branch may contain:

```text
Canvases/.../*.svg
_ai-test-bundles-server/<bundle-name>/
```

A bundle may contain:

```text
ai-prompt.md
full.svg
image-index.csv
image-index.md
images/*.png
note.md
text-elements-raw.txt
```

Not every conspect is guaranteed to have a full bundle yet.

---

## Processed text branch

The processed text work is being prepared for:

```text
ai-processed-conspects-text
```

Processed files should live under:

```text
_ai-conspects/
```

For example:

```text
_ai-conspects/react-query-rquery/
```

---

## Important workflow rule

Before starting a new conspect or a new region transcript, check whether raw source is already available.

Do not assume screenshots must be re-uploaded manually.

First check:

```text
1. Does the raw source branch contain the original SVG?
2. Does `_ai-test-bundles-server/` contain a bundle for this conspect?
3. Does the bundle have `full.svg`?
4. Does the bundle have `image-index.csv`?
5. Does the bundle have `images/*.png`?
6. Does the bundle have `text-elements-raw.txt`?
```

If a full bundle exists, use it as the source of truth for screenshot/image transcription.

If only the `.svg` exists, mark the conspect as:

```text
source-svg-available / bundle-not-yet-available
```

If neither exists, then ask the user for the missing source.

---

## Incremental bundle rule

Bundles are expected to be added incrementally.

A future chat should treat this as normal:

```text
some conspects have full bundles
some conspects only have SVG
some conspects are not exported yet
more bundles may appear later
```

This is not an error.

Do not create a big audit archive every time new bundles are added unless the user explicitly asks for an inventory.

Instead, keep workflow notes clear and check source availability at the start of each processing step.

---

## Processing decision table

| Source state | Meaning | Next action |
|---|---|---|
| `full bundle exists` | Best case | Use bundle for map/index/transcript |
| `SVG exists, no bundle` | Partial source | Use SVG for layout; request/export bundle only when images are needed |
| `processed files exist, raw bundle missing` | Processed branch may be ahead of raw inventory | Do not invent raw evidence; mark source limitation |
| `no SVG, no bundle` | Source unavailable | Ask user for source/export |
| `new bundles added later` | Normal incremental workflow | Process next target from available bundles |

---

## Do not do this

Do not create one user-facing archive just to say:

```text
bundle X exists
bundle Y exists
bundle Z does not exist yet
```

unless the user asks for an explicit source inventory.

Do not start a region transcript from guessed screenshots if a bundle may already exist on the raw source branch.

Do not request screenshots manually until the raw source branch has been checked.

---

## Recommended local source check

From repo root:

```powershell
cd C:\Users\alexa\obs
git checkout ai-processing-excalidraw-conspects

Get-ChildItem "_ai-test-bundles-server" -Directory -ErrorAction SilentlyContinue | ForEach-Object {
  $bundle = $_.FullName
  [PSCustomObject]@{
    Bundle = $_.Name
    FullSvg = Test-Path (Join-Path $bundle "full.svg")
    ImageIndexCsv = Test-Path (Join-Path $bundle "image-index.csv")
    ImageIndexMd = Test-Path (Join-Path $bundle "image-index.md")
    Images = @(Get-ChildItem (Join-Path $bundle "images") -File -ErrorAction SilentlyContinue).Count
    AiPrompt = Test-Path (Join-Path $bundle "ai-prompt.md")
    Note = Test-Path (Join-Path $bundle "note.md")
    TextElementsRaw = Test-Path (Join-Path $bundle "text-elements-raw.txt")
  }
} | Format-Table -AutoSize
```

For a specific conspect name:

```powershell
Get-ChildItem "_ai-test-bundles-server" -Directory -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -like "*react*query*" -or $_.Name -like "*rquery*" } |
  Select-Object FullName
```

---

## Current React Query note

For the React Query conspect:

```text
Canvases/new theory/fw_React/Sheet/react query,rquery.svg
```

was observed on the raw source branch.

A full `_ai-test-bundles-server/...react query.../` bundle was not confirmed through GitHub connector lookup yet.

Before continuing R07 or any next React Query region, check the raw branch locally for the exact bundle path. If it exists, use its `image-index.csv` and `images/*.png` instead of treating screenshots as unavailable.
