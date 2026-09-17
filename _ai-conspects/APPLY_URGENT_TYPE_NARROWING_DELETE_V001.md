# Apply archive 1 — urgent Type Narrowing and DELETE fixes

Target branch:

```text
ai-processed-conspects-text
```

## Apply

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text
git pull origin ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-urgent-type-narrowing-delete-v001.zip"

Expand-Archive -Path $zip -DestinationPath . -Force

git status --short -- `
  "_ai-conspects/type narrowing" `
  "_ai-conspects/delete"

git --no-pager diff --stat -- `
  "_ai-conspects/type narrowing" `
  "_ai-conspects/delete"
```

## Critical review

Confirm the delete transcript contains:

```sql
WHERE earlier.id < p.id
  AND earlier.email = p.email
```

and does not present this as the source query:

```sql
earlier.id = p.id
```

Review:

```powershell
Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/delete/01-final-transcript.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/type narrowing/01-source-preserving-transcript-v001.md"
```

## Commit

```powershell
git add -- `
  "_ai-conspects/type narrowing" `
  "_ai-conspects/delete"

git commit -m "Fix DELETE transcript and add TypeScript narrowing transcript"

git push origin ai-processed-conspects-text
```
