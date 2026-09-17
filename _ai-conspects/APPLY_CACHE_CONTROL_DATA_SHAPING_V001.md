# Apply comprehensive Cache-Control + Data Shaping correction

Target branch:

```text
ai-processed-conspects-text
```

## Apply

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text
git pull origin ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-cache-control-data-shaping-comprehensive-v001.zip"

Expand-Archive -Path $zip -DestinationPath . -Force

git status --short -- `
  "_ai-conspects/cache control headers and response caching" `
  "_ai-conspects/data shaping,expando"

git --no-pager diff --stat -- `
  "_ai-conspects/cache control headers and response caching" `
  "_ai-conspects/data shaping,expando"
```

## Review critical corrections

```powershell
Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/cache control headers and response caching/15-technical-correction-notice-v002.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/data shaping,expando/02-code-preserving-integrated-transcript-v002.md"
```

Confirm:

```text
one ResponseCacheAttribute per action
Location=None described as no-cache, not no-store
NoStore=true used for storage prohibition
all 91 cache placements indexed
all 72 data-shaping placements indexed
five data-shaping duplicates explicitly linked
```

## Commit

```powershell
git add -- `
  "_ai-conspects/cache control headers and response caching" `
  "_ai-conspects/data shaping,expando"

git commit -m "Correct cache semantics and expand data-shaping study transcripts"

git push origin ai-processed-conspects-text
```
