# Apply Problem Details study/source-export v003

Target branch:

```text
ai-processed-conspects-text
```

## Apply

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text
git pull origin ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-problem-details-study-and-source-export-v003.zip"

Expand-Archive -Path $zip -DestinationPath . -Force

git status --short -- "_ai-conspects/problem details"

git --no-pager diff --stat -- `
  "_ai-conspects/problem details"
```

## Review

```powershell
Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/problem details/09-stage9-integrated-study-transcript-v003.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/problem details/10-question-bank-v003.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/problem details/11-remaining-literal-source-gap-v003.md"
```

## Commit

```powershell
git add -- "_ai-conspects/problem details"

git commit -m "Add ProblemDetails integrated study transcript and source exporter"

git push origin ai-processed-conspects-text
```

## Export canonical PNGs for final literal pass

```powershell
powershell -ExecutionPolicy Bypass -File `
  "_ai-conspects/problem details/EXPORT_CANONICAL_PROBLEM_DETAILS_SOURCE.ps1"
```
