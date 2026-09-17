# Apply archive — three conspect corrections v001

Target branch:

```text
ai-processed-conspects-text
```

## Result

```text
query filters ef core:
  complete source-preserving correction

scopes and idisposable:
  complete source-preserving correction

problem details:
  first quality-gate correction
  source coverage remains accepted
  fidelity/repetition certification becomes explicitly pending
```

## Apply

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text
git pull origin ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-queryfilters-problemdetails-scopes-correction-v001.zip"

Expand-Archive -Path $zip -DestinationPath . -Force

git status --short -- `
  "_ai-conspects/query filters ef core" `
  "_ai-conspects/problem details" `
  "_ai-conspects/scopes and idisposable"

git --no-pager diff --stat -- `
  "_ai-conspects/query filters ef core" `
  "_ai-conspects/problem details" `
  "_ai-conspects/scopes and idisposable"
```

## Review

```powershell
Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/query filters ef core/02-stage2-corrected-source-preserving-transcript-v002.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/scopes and idisposable/05-stage5-corrected-source-preserving-transcript-v002.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/problem details/05-stage5-transcript-quality-gate-v001.md"
```

## Commit

```powershell
git add -- `
  "_ai-conspects/query filters ef core" `
  "_ai-conspects/problem details" `
  "_ai-conspects/scopes and idisposable"

git commit -m "Correct query-filter and disposal transcripts and gate ProblemDetails quality"

git push origin ai-processed-conspects-text
```
