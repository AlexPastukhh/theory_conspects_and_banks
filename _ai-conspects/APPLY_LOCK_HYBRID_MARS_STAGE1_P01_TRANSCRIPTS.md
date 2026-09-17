# Apply archive: lock-monitor + hybrydcache + sql-server-mars P01 transcripts v001

Generated: 2026-06-20 08:05:01 UTC

Archive type: **combined stage-1 P01 transcripts for 3 conspects**  
Target branch: `ai-processed-conspects-text`

## Expected download path

```powershell
C:\Users\alexa\Downloads\ai-conspects-lock-monitor-hybrydcache-sql-server-mars-stage1-p01-transcripts-v001.zip
```

## Apply + copy combined diff to clipboard

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-lock-monitor-hybrydcache-sql-server-mars-stage1-p01-transcripts-v001.zip"
$diffPath = "C:\Users\alexa\Downloads\ai-conspects-lock-monitor-hybrydcache-sql-server-mars-stage1-p01-transcripts-v001.diff"

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
git commit -m "Add P01 transcripts for lock monitor hybrydcache and sql mars"
git push origin ai-processed-conspects-text
```
