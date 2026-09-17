# APPLY ARCHIVE - batch stage1 final coverage middleware + LINQ + alternate key

Target branch: `ai-processed-conspects-text`

## Apply

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-batch-stage1-final-coverage-middleware-linq-alternatekey-v001.zip"
$targets = @(
  "_ai-conspects\middleware-writeasjson",
  "_ai-conspects\linq-query-syntax",
  "_ai-conspects\alternate-key",
  "_ai-conspects\_batch-stage1-final-coverage-middleware-linq-alternatekey-v001"
)

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $targets

git status --short -- $targets
```

## Commit after review

```powershell
git commit -m "Complete three conspects final coverage"
git push origin ai-processed-conspects-text
```

## Rollback staged targets only

```powershell
git restore --staged -- $targets
git restore -- $targets
```
