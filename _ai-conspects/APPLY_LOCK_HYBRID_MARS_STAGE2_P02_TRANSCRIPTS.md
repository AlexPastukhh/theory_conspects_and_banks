# Apply archive: lock-monitor + hybrydcache + sql-server-mars P02 transcripts v001

Generated: 2026-06-21 14:45:12 UTC

Archive type: **combined stage-2 P02 transcripts for 3 conspects**  
Target branch: `ai-processed-conspects-text`

## Included conspects

```text
lock-monitor
hybrydcache
sql-server-mars
```

## Expected download path

```powershell
C:\Users\alexa\Downloads\ai-conspects-lock-monitor-hybrydcache-sql-server-mars-stage2-p02-transcripts-v001.zip
```

## Apply + copy combined diff to clipboard

```powershell
cd C:\Users\alexa\obs-ai-conspects
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-lock-monitor-hybrydcache-sql-server-mars-stage2-p02-transcripts-v001.zip"
$diffPath = "C:\Users\alexa\Downloads\ai-conspects-lock-monitor-hybrydcache-sql-server-mars-stage2-p02-transcripts-v001.diff"

$paths = @(
  "_ai-conspects/lock-monitor",
  "_ai-conspects/hybrydcache",
  "_ai-conspects/sql-server-mars"
)

$bundleFiles = @(
  "_ai-conspects/APPLY_LOCK_HYBRID_MARS_STAGE2_P02_TRANSCRIPTS.md",
  "_ai-conspects/MANIFEST_LOCK_HYBRID_MARS_STAGE2_P02_TRANSCRIPTS.md"
)

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git status --short
git diff --stat -- $paths $bundleFiles

git add -N -- $paths $bundleFiles

git --no-pager diff -- $paths $bundleFiles > $diffPath
$text = Get-Content $diffPath -Raw
if ([string]::IsNullOrWhiteSpace($text)) {
  Write-Host "Diff is empty. Check whether files are already committed or the wrong worktree is open."
} else {
  Set-Clipboard -Value $text
  Write-Host "Full combined diff saved and copied: $diffPath"
}
```

## Commit after review

```powershell
git add -- $paths $bundleFiles
git commit -m "Add P02 transcripts for lock monitor hybrydcache and sql mars"
git push origin HEAD:ai-processed-conspects-text
```
