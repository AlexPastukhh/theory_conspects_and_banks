# Apply archive — two corrected conspects

Target repository:

```text
AlexPastukhh/obs
```

Target branch:

```text
ai-processed-conspects-text
```

## Apply from PowerShell

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text
git pull origin ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-find-index-and-server-resources-corrected-v001.zip"

Expand-Archive -Path $zip -DestinationPath . -Force

git status --short -- `
  "_ai-conspects/find index array string" `
  "_ai-conspects/server resources,multipleinstances,microservices"

git --no-pager diff --stat -- `
  "_ai-conspects/find index array string" `
  "_ai-conspects/server resources,multipleinstances,microservices"
```

## Review

```powershell
Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/find index array string/01-source-preserving-transcript-v001.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/server resources,multipleinstances,microservices/02-source-preserving-transcript-v002.md"
```

## Commit

```powershell
git add -- `
  "_ai-conspects/find index array string" `
  "_ai-conspects/server resources,multipleinstances,microservices"

git commit -m "Add source-preserving transcripts for index lookup and server scaling"

git push origin ai-processed-conspects-text
```

## Scope

- The find-index conspect receives its first complete transcript.
- The server-resources conspect keeps its existing `01-final-transcript.md` summary.
- The archive restores the missing server raw SVG at the path already declared by repo.
- No unrelated notes or workspace files are modified.
