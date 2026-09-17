# Apply archive — DbContext / SaveChanges / DbCommand interceptor corrected transcript

Target branch:

```text
ai-processed-conspects-text
```

## Apply from PowerShell

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-dbcontext-interceptors-corrected-transcript-v003.zip"

Expand-Archive -Path $zip -DestinationPath . -Force

git status --short -- "_ai-conspects/dbcontext interseptors savechanges , dbcommand"

git --no-pager diff --stat -- "_ai-conspects/dbcontext interseptors savechanges , dbcommand"

git --no-pager diff -- `
  "_ai-conspects/dbcontext interseptors savechanges , dbcommand/CURRENT_SOURCE_OF_TRUTH.md"
```

## Read the active transcript

```powershell
Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/dbcontext interseptors savechanges , dbcommand/06-stage6-corrected-source-preserving-transcript-v003.md"
```

## Commit

```powershell
git add -- "_ai-conspects/dbcontext interseptors savechanges , dbcommand"

git commit -m "Add source-preserving DbContext interceptor transcript"

git push origin ai-processed-conspects-text
```

## Scope

The archive updates only `_ai-conspects/dbcontext interseptors savechanges , dbcommand/`. It preserves the earlier v002 reconciliation as history and makes v003 authoritative.
