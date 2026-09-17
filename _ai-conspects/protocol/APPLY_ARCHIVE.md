# Apply archive: AI conspects protocol update v003

Archive type: protocol-only PUT update.

Target branch:

```text
ai-processed-conspects-text
```

Apply from repository root:

```powershell
PS C:\Users\alexa\obs>
```

## Files included

- `_ai-conspects/protocol/excalidraw_conspect_text_protocol.md`
- `_ai-conspects/protocol/APPLY_ARCHIVE.md`

## Expected download paths

ZIP archive:

```powershell
C:\Users\alexa\Downloads\ai-conspects-protocol-update-v003.zip
```

Standalone protocol file, if downloaded separately:

```powershell
C:\Users\alexa\Downloads\excalidraw_conspect_text_protocol_v003.md
```

## Apply ZIP archive

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-protocol-update-v003.zip"

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git status --short
git diff --stat
git diff -- _ai-conspects/protocol
```

## Alternative: apply standalone Markdown file

Use this only if you downloaded the `.md` file directly instead of the ZIP.

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

## Commit commands

```powershell
git add _ai-conspects/protocol
git commit -m "Update AI conspect transcription protocol"
```

## Push command

```powershell
git push origin ai-processed-conspects-text
```

## Rollback before commit

```powershell
git restore -- _ai-conspects/protocol
```

## Notes

This archive only adds/replaces files under:

```text
_ai-conspects/protocol/
```

It does not delete files.
