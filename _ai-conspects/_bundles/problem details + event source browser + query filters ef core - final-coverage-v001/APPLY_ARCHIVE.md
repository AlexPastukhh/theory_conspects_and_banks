# APPLY ARCHIVE - three conspects final coverage v001

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-three-problem-details-event-source-browser-query-filters-ef-core-stage1-final-coverage-v001.zip"

$targets = @(
  "_ai-conspects\problem details",
  "_ai-conspects\event source browser",
  "_ai-conspects\query filters ef core",
  "_ai-conspects\_bundles\problem details + event source browser + query filters ef core - final-coverage-v001"
)

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $targets

git status --short -- $targets
```

```powershell
git commit -m "Complete Problem Details EventSource Query Filters conspects"
git push origin ai-processed-conspects-text
```
