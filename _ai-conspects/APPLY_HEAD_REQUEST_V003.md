# Apply archive 1 — HEAD REQUEST corrected v003

Target branch:

```text
ai-processed-conspects-text
```

## Apply

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text
git pull origin ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-head-request-corrected-v003.zip"

Expand-Archive -Path $zip -DestinationPath . -Force

git status --short -- "_ai-conspects/HEAD REQUEST"

git --no-pager diff --stat -- `
  "_ai-conspects/HEAD REQUEST"
```

## Critical review

```powershell
Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/HEAD REQUEST/04-source-preserving-corrected-transcript-v003.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/HEAD REQUEST/05-corrected-aspnet-core-implementation-v003.md"
```

Confirm:

```text
[HttpGet] is not described as an automatic HEAD route.
No code uses item.EstimatedContentLength.
If-None-Match is parsed as entity tags.
Conditional GET is recommended for ordinary revalidation.
```

## Commit

```powershell
git add -- "_ai-conspects/HEAD REQUEST"

git commit -m "Correct HEAD request semantics and ASP.NET Core implementation"

git push origin ai-processed-conspects-text
```
