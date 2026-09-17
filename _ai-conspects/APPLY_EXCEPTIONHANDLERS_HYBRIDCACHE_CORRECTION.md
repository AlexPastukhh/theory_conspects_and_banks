# Apply archive — corrected EXCEPTIONHANDLERS and hybrydcache transcripts

Target repository:

```text
AlexPastukhh/obs
```

Target branch:

```text
ai-processed-conspects-text
```

## Apply

Run from PowerShell:

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-exceptionhandlers-hybrydcache-corrected-transcripts-v001.zip"

Expand-Archive -Path $zip -DestinationPath . -Force

git status --short -- `
  "_ai-conspects/EXCEPTIONHANDLERS" `
  "_ai-conspects/hybrydcache"

git --no-pager diff --stat -- `
  "_ai-conspects/EXCEPTIONHANDLERS" `
  "_ai-conspects/hybrydcache"

git --no-pager diff -- `
  "_ai-conspects/EXCEPTIONHANDLERS/CURRENT_SOURCE_OF_TRUTH.md" `
  "_ai-conspects/hybrydcache/CURRENT_SOURCE_OF_TRUTH.md"
```

## Recommended content review

```powershell
Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/EXCEPTIONHANDLERS/04-stage4-corrected-source-preserving-transcript.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/hybrydcache/04-stage4-corrected-source-preserving-transcript.md"
```

## Commit

```powershell
git add -- `
  "_ai-conspects/EXCEPTIONHANDLERS" `
  "_ai-conspects/hybrydcache"

git commit -m "Correct ExceptionHandlers and HybridCache source-preserving transcripts"

git push origin ai-processed-conspects-text
```

## Scope

This archive overwrites the active region files and the source-of-truth files for the two conspects. It does not modify Obsidian workspace files or unrelated notes.
