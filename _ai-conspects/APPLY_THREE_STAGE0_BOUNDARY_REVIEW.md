# Apply archive: three Stage0 boundary reviews v001

Generated: 2026-06-13 11:04:52 UTC

Archive type: **combined stage-0 boundary review for 3 conspects**  
Target branch: `ai-processed-conspects-text`

## Included conspects

```text
lock-monitor
hybrydcache
sql-server-mars
```

## Expected download path

```powershell
C:\Users\alexa\Downloads\ai-conspects-three-conspects-stage0-boundary-review-v001.zip
```

## Apply + copy combined diff to clipboard

Run from repository root:

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-three-conspects-stage0-boundary-review-v001.zip"
$diffPath = "C:\Users\alexa\Downloads\ai-conspects-three-conspects-stage0-boundary-review-v001.diff"

$paths = @(
  "_ai-conspects/lock-monitor",
  "_ai-conspects/hybrydcache",
  "_ai-conspects/sql-server-mars"
)

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git status --short
git diff --stat -- $paths

git add -N -- $paths

git --no-pager diff -- $paths > $diffPath
$text = Get-Content $diffPath -Raw
if ([string]::IsNullOrWhiteSpace($text)) {
  Write-Host "Diff is empty. Check whether files are already committed."
} else {
  Set-Clipboard -Value $text
  Write-Host "Full combined diff saved and copied: $diffPath"
}
```

## Commit after review

```powershell
git add -- $paths
git commit -m "Start lock monitor hybrydcache and sql mars boundary reviews"
git push origin ai-processed-conspects-text
```
