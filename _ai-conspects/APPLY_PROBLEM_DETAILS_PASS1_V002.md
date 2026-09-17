# Apply archive — Problem Details source-preserving pass 1 v002

Target branch:

```text
ai-processed-conspects-text
```

## Apply

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text
git pull origin ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-problem-details-source-preserving-pass1-v002.zip"

Expand-Archive -Path $zip -DestinationPath . -Force

git status --short -- "_ai-conspects/problem details"

git --no-pager diff --stat -- "_ai-conspects/problem details"
```

## Review

```powershell
Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/problem details/05-stage5-actual-transcript-quality-audit-v002.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/problem details/06-stage6-source-preserving-transcript-pass1-v002.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/problem details/CANONICAL_FULL_SOURCE_REQUIRED.md"
```

## Commit

```powershell
git add -- "_ai-conspects/problem details"

git commit -m "Add ProblemDetails source-preserving transcript pass 1"

git push origin ai-processed-conspects-text
```
