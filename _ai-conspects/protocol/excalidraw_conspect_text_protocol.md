# Protocol: Converting Obsidian Excalidraw Conspects into AI-Readable Text

Version: 0.4  
Purpose: preserve a visual Obsidian Excalidraw conspect as a text source that another AI chat can reliably use for summaries, repetition questions, spaced recall, and navigation.

This protocol is written for a fresh chat that has no prior context.

---

## 0. Core goal

The goal is **not** to rewrite the conspect as a new textbook.

The goal is to convert a visual Excalidraw conspect into a text format that preserves:

1. the original source content;
2. the visual/spatial structure;
3. the screenshots and their local meaning;
4. the original labels/captions;
5. uncertainty and unreadable fragments;
6. enough normalized structure for AI processing and question generation.

The output should be an **AI-readable textual mirror** of the visual conspect.

---

## 1. What this task is

This task is a source-preserving transcription + structured extraction task.

The input is usually:

- `full.svg` — visual map of the whole Excalidraw canvas;
- `note.md` — original Obsidian Excalidraw note;
- `text-elements-raw.txt` — raw Excalidraw text labels;
- `image-index.md` / `image-index.csv` — mapping of embedded screenshots to files;
- `images/` — copied screenshot files from the Excalidraw note.

The output is usually Markdown.

The output should support future tasks such as:

- generating repetition questions;
- finding where a concept is located visually;
- distinguishing source text from AI interpretation;
- tracing any claim back to screenshot / label / location;
- preserving the user's visual memory of the canvas.

---

## 2. What this task is not

Do **not** treat the task as:

- writing a polished article;
- creating a new study guide from general knowledge;
- summarizing the whole topic from memory;
- silently fixing or expanding the author's notes;
- replacing the original visual logic with your own logical order;
- generating questions before the source transcription is complete;
- using Excalidraw labels alone as the full knowledge source.

A visual Excalidraw conspect can contain short labels, but the real knowledge may be inside embedded screenshots.

---

## 3. Golden rule: separate layers

Always separate these layers:

```text
Layer 1 — Source metadata
Layer 2 — Canvas-wide spatial map
Layer 3 — Region/block index
Layer 4 — Original Excalidraw labels
Layer 5 — Screenshot transcript
Layer 6 — Cleaned source note
Layer 7 — Minimal interpretation
Layer 8 — Question hooks / future repetition prompts
```

Never mix raw source transcription with AI interpretation.

---

## 4. Source categories

Every piece of content should be marked as one of these source categories.

### 4.1 `source:screenshot`

Text/code/UI content directly visible inside a screenshot.

Example:

```md
Source: screenshot
Image: `images/155__db2d4aae55__Pasted Image ...png`
Visible text:
> Returning a Promise on onSettled makes the mutation stay pending...
```

### 4.2 `source:label`

Text directly from Excalidraw labels/captions.

Example:

```md
Source: label
Original:
```text
KEEPING MUTATION IN 
PENDING STATE UNTIL REVALIDATION + REFETCH
```
```

### 4.3 `source:layout`

Information inferred from visual position, grouping, arrows, proximity, or region.

Example:

```md
Source: layout
This block is in the lower-right part of the mutation region.
Confidence: medium
```

### 4.4 `source:normalized`

A cleaned version of source text, preserving the same meaning but improving readability.

Example:

```md
Original label:
```text
INVALIDATION ONSETTLED
```

Normalized:
`invalidation in onSettled`
```

### 4.5 `source:interpretation`

A minimal explanation of what a block means, based only on the source material.

Example:

```md
Interpretation:
This block appears to explain why returning the `invalidateQueries` Promise keeps the mutation pending until refetch finishes.
```

### 4.6 `source:general-knowledge`

General domain knowledge not visibly present in the conspect.

Avoid this layer in the main transcription. If used, mark it explicitly.

Example:

```md
General React Query note:
Mutations are usually used for server writes such as create/update/delete operations.
```

Use this only in an optional appendix, not in source transcript.

---

## 5. Original text vs normalized text

### 5.1 Preserve original wording

Keep the original language, capitalization, abbreviations, and errors in an `Original` field.

Example:

```md
Original label:
```text
MUTATE VS MUTATEASYNC
```
```

Do not silently rewrite it as:

```text
mutate vs mutateAsync
```

unless it is in a separate normalized field.

### 5.2 Allow normalized version, but separate it

Normalized text is allowed because it helps search, AI parsing, and question generation.

Example:

```md
Original:
```text
SETQUERYDATA RETURN FULL OBJECT LIKE PUT
```

Normalized:
`setQueryData should return a full new object / array`

Notes:
- Original wording is preserved.
- Normalized wording is only for readability/search.
```

### 5.3 What normalization means

Normalization may include:

- fixing obvious casing;
- expanding abbreviations;
- adding backticks around code terms;
- formatting code blocks;
- correcting obvious typos if the correction is clearly intended;
- splitting long text into bullets.

### 5.4 What normalization does not mean

Normalization must not:

- add new concepts not present in the source;
- replace the author's mental model with a generic textbook model;
- invent missing text from a cut-off screenshot;
- change the meaning;
- silently remove uncertainty.

---

## 6. Handling typos and broken English

The user's Excalidraw notes may contain broken English, abbreviations, personal shorthand, and typos. Preserve them in `Original`.

Then optionally provide a normalized version.

Example:

```md
Original:
```text
AND NEED TO REMEMBER THAT YOU ARE MANUALLY SETTING CACHE IN BOTH SUCCESS 
AND ERROR OUTCOMES SO ITS LOGICALLY CORRECT TO GET THE FINAL STATE FROM THE SERVER
```

Normalized:
When cache is manually changed in both success and error paths, it is logically safer to refetch the final state from the server.

Correction notes:
- `ITS` normalized to `it's`.
- Meaning preserved.
- No external concept added.
```

If unsure about a typo, do not correct it silently.

Use:

```text
[unclear: maybe "..."]
```

or:

```text
[as written]
```

---

## 7. Handling screenshots

### 7.1 Screenshots are primary content

If the conspect is mostly screenshots plus short labels, treat screenshots as the primary source of knowledge.

Labels are navigation and structure, not full content.

### 7.2 Per-screenshot record

For every relevant screenshot, create a record:

```md
## Screenshot S-155

Metadata:
- image index: 155
- filename: `images/155__db2d4aae55__Pasted Image ...png`
- fileId: `db2d4aae...`
- nearby label: `KEEPING MUTATION IN PENDING STATE UNTIL REVALIDATION + REFETCH`
- visual region: `MUTATIONS / lower-right`
- opened/read: yes
- readability: high / medium / low
- cut off: yes / no
- confidence: high / medium / low

### Exact visible text

[transcribe visible text]

### Exact visible code

```ts
[transcribe visible code]
```

### Unclear / cut-off fragments

- `[cut off below]`
- `[unclear: ...]`

### Cleaned source note

[cleaned version of only the visible source content]

### Minimal interpretation

[optional, explicitly marked]
```

### 7.3 Do not describe screenshot content unless opened/read

If a screenshot was identified by layout but not inspected, say:

```md
Opened/read: no
Content description: not provided
Reason included: nearby mutation label and spatial grouping
Confidence: low/medium
```

### 7.4 Mark cut-off content

If the screenshot is cropped or incomplete:

```md
Cut off: yes
Visible ending:
```text
is true
```

Missing:
- content below the visible crop
```

Never fill missing parts from memory.

---

## 8. Handling code

Code from screenshots is high-risk for exact transcription.

### 8.1 Keep exact and cleaned separately

```md
### Exact visible code

```ts
context.client.setQueryData(['todos'], (old) => [
  ...old,
  newTodo,
])
```

### Cleaned code

```ts
context.client.setQueryData(['todos'], (old) => [
  ...old,
  newTodo,
])
```

### Notes

- Exact and cleaned versions are identical.
- Confidence: high
```

If exact text is uncertain:

```md
### Exact visible code

```ts
context.client.setQueryData([unclear], (old) => [
  ...old,
  newTodo,
])
```

### Cleaned probable code

```ts
context.client.setQueryData(['todos'], (old) => [
  ...old,
  newTodo,
])
```

Confidence: medium
Reason: query key text is small.
```

### 8.2 Never silently fix code

If you correct code formatting, label it as cleaned.

### 8.3 Do not use cleaned code as source evidence

Evidence should refer to exact visible code, not only cleaned code.

---

## 9. Handling layout and visual memory

The text version must preserve where information lives on the visual canvas.

### 9.1 Canvas-wide map

Every full conspect transcription should start with a `Canvas-wide map`.

Example:

```md
# Canvas-wide map

Conspect: React Query / rquery
Orientation: very tall vertical sheet

R01 — Query basics / statuses / keys
R02 — Staleness / refetch / cache lifetime
R03 — QueryClient / prefetch / filters
R04 — Offline / network mode
R05 — Mutations
R06 — Persistence / hydration
R07 — Suspense / transitions
R08 — Error handling / cancellation
R09 — Testing / config
R10 — Performance / select
```

### 9.2 Current-location block

When extracting a region, include a `You are here` block.

Example:

```md
## You are here

Conspect: `react query,rquery`
Current region: `R05 — MUTATIONS`
Canvas position: middle-lower part of the sheet

Previous nearby regions:
- QueryClient methods
- query filters
- cancel options
- getQueryCache / getMutationCache

Next nearby regions:
- Retry
- Pagination / Infinite Query
- Offline / persistence
```

### 9.3 Spatial language

Use spatial descriptions, but mark them as layout inference.

Good:

```md
Layout inference:
The `mutate vs mutateAsync` screenshots appear in the right side of the mutation region.
Confidence: high
```

Bad:

```md
The author intended mutateAsync to be less important because it is on the right.
```

Do not infer importance from position unless source supports it.

---

## 10. Handling region/block structure

A region is a large visual topic area. A block is a sub-area inside a region.

Example:

```md
# Region R05 — MUTATIONS

Visual position:
- middle-lower part of the full sheet
- after QueryClient/cache-method area
- before Retry/Pagination area

Blocks:
- R05-A — cancelQueries in optimistic updates
- R05-B — structure / callbacks
- R05-C — callback arguments
- R05-D — invalidation onSettled
- R05-E — setQueryData caveats
- R05-F — mutate vs mutateAsync
- R05-G — keeping mutation pending until refetch
```

Block names may be normalized for readability, but original labels must be preserved inside each block.

---

## 11. Citation / evidence system

The output should support traceability.

Use a local citation system if formal citations are unavailable.

### 11.1 Recommended source IDs

Assign IDs:

```text
L-001 = Excalidraw label
S-003 = Screenshot image 003
R-05 = Region
B-05A = Block
```

Example:

```md
Claim:
`onError` is used for rollback.

Evidence:
- S-135, visible code uses `onMutateResult.previousTodos`.
- B-05C, callback args block.
Confidence: high.
```

### 11.2 Evidence table

Each region should end with:

```md
## Evidence table

| Claim | Evidence | Source type | Confidence |
|---|---|---|---|
| `cancelQueries` protects optimistic cache from stale refetch | S-003, S-004 | screenshot | high |
| `onError` uses rollback data from `onMutate` | S-135, S-145 | screenshot | high |
| `mutateAsync` returns Promise | S-151, S-154 | screenshot | high |
```

### 11.3 What counts as evidence

Strong evidence:

- exact visible screenshot text;
- exact visible screenshot code;
- explicit Excalidraw label;
- clearly visible arrow/grouping.

Weak evidence:

- proximity without arrow;
- inferred reading order;
- general React Query knowledge;
- cleaned notes without source transcript.

---

## 12. Confidence levels

Use explicit confidence labels.

### High

Use when:

- text is readable;
- screenshot is not cut off;
- layout grouping is clear;
- multiple sources support the same claim.

### Medium

Use when:

- screenshot is partially cut off;
- code is small but mostly readable;
- relation is likely but not explicitly arrowed;
- wording is visible but one fragment is uncertain.

### Low

Use when:

- screenshot was not opened;
- text is blurry;
- relation is inferred only from proximity;
- important part is missing.

Example:

```md
Confidence: medium
Reason: screenshot is cut off below the line `mutation.isPending`.
```

---

## 13. Output structure for full conspect transcription

Recommended Markdown structure:

```md
# [Conspect title] — Source-Preserving Text Version

## 0. Source files

- full.svg
- note.md
- text-elements-raw.txt
- image-index.csv
- images/

## 1. Canvas-wide map

[global spatial map]

## 2. Region index

| Region ID | Normalized name | Original labels | Approx location | Status |
|---|---|---|---|---|

## 3. Region R01 — ...

### 3.1 You are here
### 3.2 Original labels
### 3.3 Screenshot inventory
### 3.4 Screenshot transcripts
### 3.5 Cleaned source notes
### 3.6 Minimal interpretation
### 3.7 Evidence table
### 3.8 Question hooks

## 4. Region R02 — ...

...

## Appendix A — Unreadable / missing / ambiguous items

## Appendix B — Normalization glossary

## Appendix C — Future questions index
```

---

## 14. Output structure for one region

```md
# Region R05 — MUTATIONS

## You are here

...

## Original labels

```text
MUTATIONS
CANCELQUERIES IN OPTIMISTIC UPDATES PATTERN
...
```

## Visual structure

- block R05-A: ...
- block R05-B: ...

## Screenshot inventory

| Source ID | Image | Nearby label | Opened | Readability | Confidence |
|---|---|---|---|---|---|

## Source transcript

### S-003 — filename

#### Exact visible text
...

#### Exact visible code
...

#### Cut off / unclear
...

## Cleaned source notes

Only cleaned version of source content. No general knowledge.

## Minimal interpretation

Clearly marked as interpretation.

## Evidence table

...

## Question hooks

Draft hooks only, not full questions unless requested.
```

---

## 15. Question hooks vs generated questions

Do not generate full study questions during source transcription unless the user asks.

Instead, add `Question hooks`.

Example:

```md
Question hooks:
- Why cancel queries before optimistic update?
- What data should `onMutate` return for rollback?
- What happens if `invalidateQueries` is not returned from `onSettled`?
```

Later, a separate pass can convert hooks into:

- active recall questions;
- cloze cards;
- spaced repetition prompts;
- exam-style questions;
- visual-location questions.

---

## 16. Visual-location questions

For users with strong visual memory, questions should preserve spatial context.

Example:

```md
Question:
In the middle-lower `MUTATIONS` region, right-side block `MUTATE VS MUTATEASYNC`, what is the key difference between `mutate` and `mutateAsync`?

Source:
- Region: R05
- Block: R05-F
- Screenshots: S-149–S-154
```

This helps the user recall the visual layout, not just the abstract concept.

---

## 17. Processing order

Use this order:

1. Read/inspect `full.svg` as visual canvas.
2. Extract canvas dimensions and visible text labels.
3. Build canvas-wide map.
4. Identify major regions.
5. Build region index.
6. For one region at a time:
   - locate screenshots in the region;
   - map screenshots to `image-index.csv`;
   - open/read screenshots;
   - transcribe exact visible text/code;
   - mark uncertainty;
   - create cleaned source note;
   - create minimal interpretation;
   - create evidence table;
   - create question hooks.
7. Repeat for next region.
8. Final pass:
   - unify terminology;
   - check citations;
   - list ambiguous/missing items;
   - prepare final AI-readable Markdown.

---

## 18. Do / don't examples

### Good

```md
Original label:
```text
MUTATE VS MUTATEASYNC
```

Normalized label:
`mutate vs mutateAsync`

Source screenshots:
- S-149
- S-150
- S-151
- S-154

Cleaned source note:
`mutate` is callback-style and returns void. `mutateAsync` returns a Promise and can be awaited.

Evidence:
- S-150: visible text says `mutate` returns void.
- S-151: visible text says `mutateAsync` returns Promise.

Confidence: high
```

### Bad

```md
React Query mutations are the best way to manage server-side effects in modern React applications...
```

Why bad:
- sounds like general tutorial;
- may not be present in the source;
- not traceable to screenshot/label.

---

## 19. Required behavior for a fresh AI chat

A fresh chat should follow these rules:

1. First check which files are available.
2. Do not claim to visually inspect `full.svg` unless actually rendered/opened.
3. If `full.svg` cannot be visually inspected, ask for crop or uploaded image.
4. Treat screenshots as primary knowledge when the user says the conspect is screenshot-heavy.
5. Do not summarize the whole conspect before building the map.
6. Do not generate study questions before transcription/evidence pass.
7. Preserve original labels and language.
8. Mark all uncertainty.
9. Separate source transcript from cleaned notes and interpretation.
10. Keep region and spatial context because visual memory matters.

---

## 20. Final principle

The final text should let a future AI answer:

```text
What exactly was visible in the original conspect?
Where was it located?
Which screenshot or label supports this?
What is cleaned vs original?
What is interpreted vs directly visible?
What can be used to generate repetition questions?
```

If the output cannot answer these questions, it is not source-preserving enough.

---

## 21. Delivery workflow: archive-based PUT updates

All generated outputs for this project must normally be delivered as a ZIP archive.

The assistant must **not** write directly to GitHub unless the user explicitly asks for that in a later message. The normal workflow is:

```text
assistant generates ZIP archive
user downloads ZIP to Downloads
user unpacks ZIP in repository root
files are replaced/added by repo-relative paths
user reviews diff
user commits on the correct branch
```

This is a PUT-style workflow: files included in the archive are intended to become the new complete version at their target paths.

---

### 21.1 Target repository, branch, and local paths

The user works from the repository root:

```powershell
PS C:\Users\alexa\obs>
```

Default target branch for this project:

```text
ai-processed-conspects-text
```

Downloaded files from ChatGPT normally land in:

```powershell
C:\Users\alexa\Downloads\
```

Known current standalone protocol download path:

```powershell
C:\Users\alexa\Downloads\excalidraw_conspect_text_protocol_v003.md
```

Important:

```text
Files in Downloads are not the repository result.
They are inputs/artifacts that must be applied into the repo root.
```

The repo copy of the protocol should live at:

```text
_ai-conspects/protocol/excalidraw_conspect_text_protocol.md
```

---

### 21.2 Before applying any archive

From repo root:

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text
git status --short
```

If the branch exists on remote but not locally:

```powershell
git fetch origin
git checkout -b ai-processed-conspects-text origin/ai-processed-conspects-text
```

If the branch is intentionally local-only:

```powershell
git checkout -b ai-processed-conspects-text
```

---

### 21.3 Archive structure

The archive must contain paths relative to the repository root.

Good archive paths:

```text
_ai-conspects/protocol/excalidraw_conspect_text_protocol.md
_ai-conspects/protocol/APPLY_ARCHIVE.md
_ai-conspects/react query,rquery/source-map.md
_ai-conspects/react query,rquery/regions/R05-mutations.md
```

Bad archive paths:

```text
C:\Users\alexa\obs\_ai-conspects\...
C:\Users\alexa\Downloads\...
/mnt/data/...
Desktop/generated/...
```

Do not include machine-specific absolute paths inside the ZIP.

Downloads paths should appear only in instructions, not as archive paths.

---

### 21.4 Required files in every archive

Every archive should include at least:

```text
_ai-conspects/protocol/APPLY_ARCHIVE.md
```

For protocol updates, include:

```text
_ai-conspects/protocol/excalidraw_conspect_text_protocol.md
```

For conspect transcription outputs, include a manifest such as:

```text
_ai-conspects/<conspect-id>/MANIFEST.md
```

The manifest should list:

- generated files;
- source files used;
- whether screenshots were read;
- whether the output is source transcript, cleaned note, interpretation, or question hooks;
- known limitations;
- whether the archive is full PUT for that subdirectory or partial update.

---

### 21.5 PUT-style rule

PUT-style means:

```text
If a file is included in the archive, unpacking the archive should replace that file with the new intended complete version.
```

It does **not** mean deleting every other file in the repository.

It also does **not** mean the assistant may remove user files unless the archive explicitly contains a deletion plan and the user approves it.

Default behavior:

```text
archive adds/replaces included files only
archive does not delete files
```

If deletion is needed, the assistant must not rely on ZIP extraction. Instead it must provide explicit deletion commands in `APPLY_ARCHIVE.md`, clearly separated under a heading:

```md
## Optional deletion commands
```

---

### 21.6 Apply a ZIP archive from Downloads

Assume the archive is downloaded to Downloads:

```powershell
$zip = "C:\Users\alexa\Downloads\ai-conspects-protocol-update-v003.zip"
```

From repo root:

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git status --short
git diff --stat
git diff -- _ai-conspects
```

Stage and commit:

```powershell
git add _ai-conspects
git commit -m "Add AI conspect transcription protocol"
```

Push if needed:

```powershell
git push origin ai-processed-conspects-text
```

---

### 21.7 Apply a standalone Markdown artifact from Downloads

Sometimes the assistant may also provide a standalone `.md` file for inspection.

Known current standalone protocol path:

```powershell
$protocolDownload = "C:\Users\alexa\Downloads\excalidraw_conspect_text_protocol_v003.md"
```

To apply it to the repository protocol path:

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

New-Item -ItemType Directory -Force -Path "_ai-conspects\protocol" | Out-Null

Copy-Item `
  -Path "C:\Users\alexa\Downloads\excalidraw_conspect_text_protocol_v003.md" `
  -Destination "_ai-conspects\protocol\excalidraw_conspect_text_protocol.md" `
  -Force

git status --short
git diff -- _ai-conspects/protocol/excalidraw_conspect_text_protocol.md
```

Commit:

```powershell
git add _ai-conspects/protocol/excalidraw_conspect_text_protocol.md
git commit -m "Update AI conspect transcription protocol"
```

Important:

```text
The standalone Downloads file is not committed directly from Downloads.
It must be copied into the repo-relative target path first.
```

---

### 21.8 Optional safety backup before overwrite

From repo root:

```powershell
$backup = "C:\Users\alexa\Downloads\obs-backup-before-ai-conspects-" + (Get-Date -Format "yyyyMMdd-HHmmss") + ".zip"
git ls-files | Compress-Archive -DestinationPath $backup -Force
```

This backup is optional. It archives tracked files only.

---

### 21.9 If PowerShell blocks overwrite or path names

Use .NET extraction as fallback:

```powershell
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($zip, (Get-Location).Path, $true)
```

Then review:

```powershell
git status --short
git diff --stat
```

---

### 21.10 Required assistant response with every archive

When providing an archive, the assistant must include:

1. download link to the ZIP;
2. list of files inside the ZIP;
3. exact PowerShell commands to apply it from `PS C:\Users\alexa\obs>`;
4. exact commit command;
5. expected Downloads path for the ZIP;
6. if a standalone Markdown file is also provided, exact `Copy-Item` command from Downloads into the repo;
7. note whether the archive is:
   - protocol-only;
   - one-region update;
   - whole-conspect update;
   - partial update;
   - full PUT for a subdirectory;
8. warning if the archive overwrites existing files.

Example response:

```md
Archive type: protocol-only PUT update

Expected download path:
`C:\Users\alexa\Downloads\ai-conspects-protocol-update-v003.zip`

Files included:
- `_ai-conspects/protocol/excalidraw_conspect_text_protocol.md`
- `_ai-conspects/protocol/APPLY_ARCHIVE.md`

Apply from:

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text
$zip = "C:\Users\alexa\Downloads\ai-conspects-protocol-update-v003.zip"
Expand-Archive -Path $zip -DestinationPath . -Force
git status --short
git diff -- _ai-conspects/protocol
git add _ai-conspects/protocol
git commit -m "Update AI conspect transcription protocol"
```
```

---

### 21.11 Review-before-commit rule

The user should always review before commit:

```powershell
git status --short
git diff --stat
git diff -- _ai-conspects
```

If the diff is too large:

```powershell
git diff --name-only
```

If the archive was applied accidentally on the wrong branch:

```powershell
git status --short
git switch ai-processed-conspects-text
```

If files were overwritten and should be reverted before commit:

```powershell
git restore -- _ai-conspects
```

If only one file should be reverted:

```powershell
git restore -- _ai-conspects/protocol/excalidraw_conspect_text_protocol.md
```

---

### 21.12 Naming archives and standalone files

Use descriptive archive names:

```text
ai-conspects-protocol-update-v003.zip
ai-conspects-react-query-map-v001.zip
ai-conspects-react-query-R05-mutations-v001.zip
ai-conspects-react-query-full-v001.zip
```

Standalone protocol files may be named:

```text
excalidraw_conspect_text_protocol_v003.md
excalidraw_conspect_text_protocol_v003.md
```

But the repo target path should remain stable:

```text
_ai-conspects/protocol/excalidraw_conspect_text_protocol.md
```

---

### 21.13 Recommended repository layout

Recommended generated-file layout:

```text
_ai-conspects/
  protocol/
    excalidraw_conspect_text_protocol.md
    APPLY_ARCHIVE.md

  react-query-rquery/
    MANIFEST.md
    00-canvas-wide-map.md
    01-region-index.md
    regions/
      R01-query-basics.md
      R02-staleness-refetch.md
      R03-queryclient-prefetch.md
      R04-offline-network.md
      R05-mutations.md
      ...
    screenshots/
      inventory.md
    questions/
      hooks.md
```

This keeps generated AI-readable text separate from the original Obsidian notes and attachments.

---

### 21.14 Important safety rule

The assistant must not generate commands that delete, move, or overwrite broad repository areas unless explicitly requested.

Safe default:

```powershell
Expand-Archive -Path $zip -DestinationPath . -Force
git diff -- _ai-conspects
```

Unsafe unless explicitly requested:

```powershell
Remove-Item -Recurse -Force .
git clean -fdx
git reset --hard
```

Do not suggest unsafe commands as part of normal archive application.

