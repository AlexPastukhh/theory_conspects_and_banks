# APPLY ARCHIVE - three conspects stage0 v001

## PowerShell

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-three-computed-columns-razor-partial-updates-statuscodepages-stage0-v001.zip"

$targets = @(
  "_ai-conspects\computed columns",
  "_ai-conspects\RAZOR PARTIAL UPDATES FOR VIEWCOMPONENT HTMX,AJAX",
  "_ai-conspects\statuscodepages",
  "_ai-conspects\_bundles\three-conspects-computed-columns-razor-statuscodepages-stage0-v001"
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
git commit -m "Start computed columns Razor partial updates statuscodepages conspects"
git push origin ai-processed-conspects-text
```
