# Apply Route Params + Route Nesting correction archive

Target branch:

```text
ai-processed-conspects-text
```

## Apply

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text
git pull origin ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-route-params-route-nesting-comprehensive-v001.zip"

Expand-Archive -Path $zip -DestinationPath . -Force

git status --short -- `
  "_ai-conspects/ROUTE PARAMS,QUERY STRING BASICS" `
  "_ai-conspects/ROUTE NESTING"

git --no-pager diff --stat -- `
  "_ai-conspects/ROUTE PARAMS,QUERY STRING BASICS" `
  "_ai-conspects/ROUTE NESTING"
```

## Review

```powershell
Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/ROUTE PARAMS,QUERY STRING BASICS/08-technical-correction-notice-v002.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/ROUTE NESTING/04-source-preserving-transcript-v002.md"
```

Confirm:

```text
8 / 8 route-params screenshots indexed
7 / 7 route-params labels preserved
11 / 11 route-nesting screenshots indexed
CSV route segment described as one value
IEnumerable<Guid> not claimed to auto-split from CSV
route-list REST wording treated as advice, not prohibition
parent membership enforced in code/query
canonical URI and 404/403 policy documented
```

## Commit

```powershell
git add -- `
  "_ai-conspects/ROUTE PARAMS,QUERY STRING BASICS" `
  "_ai-conspects/ROUTE NESTING"

git commit -m "Expand route binding and nesting conspects with source-preserving code"

git push origin ai-processed-conspects-text
```
