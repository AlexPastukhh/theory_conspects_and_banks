# Apply archive: three small conspects 002 closure audit

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-three-small-conspects-002-closure-audit-v001.zip"

$paths = @(
  "_ai-conspects\scopes and idisposable",
  "_ai-conspects\EXCEPTIONHANDLERS",
  "_ai-conspects\httpcontent,custom one, readasstream buffering, compression directly to network",
  "_ai-conspects\_batch-closure-three-small-conspects-002"
)

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short

Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $paths

git status --short -- $paths

git diff --staged -- $paths | Set-Clipboard
```

```powershell
git commit -m "Close three small conspects coverage audits 002"
git push origin ai-processed-conspects-text
```
