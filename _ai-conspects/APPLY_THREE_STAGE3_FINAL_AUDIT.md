# Apply archive: three final coverage audits v001

Generated: 2026-06-13 10:53:40 UTC

Archive type: **combined stage-3 final coverage audit for 3 conspects**  
Target branch: `ai-processed-conspects-text`

## Included conspects

```text
qs-preference-with-multiple-accept-header-values-helper
redis-multiplexer-redis-lock
automatic-problem-details-from-modelstate-apicontroller-filter-invalidmodelstateresponsefactory
```

## Expected download path

```powershell
C:\Users\alexa\Downloads\ai-conspects-three-conspects-stage3-final-coverage-audit-v001.zip
```

## Apply + copy combined diff to clipboard

Run from repository root:

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-three-conspects-stage3-final-coverage-audit-v001.zip"
$diffPath = "C:\Users\alexa\Downloads\ai-conspects-three-conspects-stage3-final-coverage-audit-v001.diff"

$paths = @(
  "_ai-conspects/qs-preference-with-multiple-accept-header-values-helper",
  "_ai-conspects/redis-multiplexer-redis-lock",
  "_ai-conspects/automatic-problem-details-from-modelstate-apicontroller-filter-invalidmodelstateresponsefactory"
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

Recommended as one combined commit:

```powershell
git add -- $paths
git commit -m "Finalize coverage audits for accept helper redis lock and problem details"
git push origin ai-processed-conspects-text
```
