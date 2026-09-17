# Apply archive 3 — Exhaustiveness source-preserving correction

Target branch:

```text
ai-processed-conspects-text
```

## Apply

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text
git pull origin ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-exhaustiveness-source-preserving-v002.zip"

Expand-Archive -Path $zip -DestinationPath . -Force

git status --short -- `
  "_ai-conspects/exaustiveness check with sicr union for enums,classes with inher"

git --no-pager diff --stat -- `
  "_ai-conspects/exaustiveness check with sicr union for enums,classes with inher"
```

## Review

```powershell
Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/exaustiveness check with sicr union for enums,classes with inher/05-source-preserving-transcript-v002.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/exaustiveness check with sicr union for enums,classes with inher/08-transcript-quality-correction-audit-v002.md"
```

## Commit

```powershell
git add -- `
  "_ai-conspects/exaustiveness check with sicr union for enums,classes with inher"

git commit -m "Expand C# exhaustiveness conspect with source-preserving code"

git push origin ai-processed-conspects-text
```
