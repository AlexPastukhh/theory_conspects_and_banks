# Apply archive: three small conspects 002 Stage0 boundary review

Archive type: boundary review batch.

Target branch:

```text
ai-processed-conspects-text
```

## Apply + copy staged diff to clipboard

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-three-small-conspects-002-stage0-boundary-review-v001.zip"

$paths = @(
  "_ai-conspects\scopes and idisposable",
  "_ai-conspects\EXCEPTIONHANDLERS",
  "_ai-conspects\httpcontent,custom one, readasstream buffering, compression directly to network",
  "_ai-conspects\_batch-stage0-three-small-conspects-002"
)

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short

Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $paths

git status --short -- $paths

git diff --staged -- $paths | Set-Clipboard
```

## Commit commands

```powershell
git commit -m "Add three small conspects Stage0 boundary reviews 002"
git push origin ai-processed-conspects-text
```
