# Apply archive: lock-monitor + hybrydcache + sql-server-mars final coverage audit v001

Generated: 2026-06-21 14:48:11 UTC

Archive type: **combined stage-3 final coverage audit for 3 conspects**  
Target branch: `ai-processed-conspects-text`

## Expected download path

```powershell
C:\Users\alexa\Downloads\ai-conspects-lock-monitor-hybrydcache-sql-server-mars-stage3-final-coverage-audit-v001.zip
```

## Apply + copy combined diff to clipboard

```powershell
cd C:\Users\alexa\obs-ai-conspects
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-lock-monitor-hybrydcache-sql-server-mars-stage3-final-coverage-audit-v001.zip"
$diffPath = "C:\Users\alexa\Downloads\ai-conspects-lock-monitor-hybrydcache-sql-server-mars-stage3-final-coverage-audit-v001.diff"

$paths = @(
  "_ai-conspects/lock-monitor",
  "_ai-conspects/hybrydcache",
  "_ai-conspects/sql-server-mars"
)

$bundleFiles = @(
  "_ai-conspects/APPLY_LOCK_HYBRID_MARS_STAGE3_FINAL_COVERAGE_AUDIT.md",
  "_ai-conspects/MANIFEST_LOCK_HYBRID_MARS_STAGE3_FINAL_COVERAGE_AUDIT.md",
  "_ai-conspects/FINAL_COVERAGE_SUMMARY_LOCK_HYBRID_MARS.md"
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
git commit -m "Complete coverage audits for lock monitor hybrydcache and sql mars"
git push origin HEAD:ai-processed-conspects-text
```
