# APPLY ARCHIVE - problem details + event source browser + query filters ef core stage0 v001

## PowerShell

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-three-problem-details-event-source-browser-query-filters-ef-core-stage0-v001.zip"

$targets = @(
  "_ai-conspects\problem details",
  "_ai-conspects\event source browser",
  "_ai-conspects\query filters ef core",
  "_ai-conspects\_bundles\problem details + event source browser + query filters ef core - stage0-v001"
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
git commit -m "Start Problem Details EventSource Query Filters conspects"
git push origin ai-processed-conspects-text
```

## Rollback staged targets only

```powershell
git restore --staged -- $targets
git restore -- $targets
```
