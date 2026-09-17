# Apply archive 2 — HashCode source-preserving correction

Target branch:

```text
ai-processed-conspects-text
```

## Apply

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text
git pull origin ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-hashcode-source-preserving-v002.zip"

Expand-Archive -Path $zip -DestinationPath . -Force

git status --short -- "_ai-conspects/hashcode"

git --no-pager diff --stat -- "_ai-conspects/hashcode"
```

## Review

```powershell
Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/hashcode/02-source-preserving-transcript-v002.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/hashcode/03-repetition-guide-v002.md"
```

## Commit

```powershell
git add -- "_ai-conspects/hashcode"

git commit -m "Expand HashCode conspect with source-preserving transcript"

git push origin ai-processed-conspects-text
```
