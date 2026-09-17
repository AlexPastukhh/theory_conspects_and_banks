# APPLY ARCHIVE

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-websockets-missing-screenshots-recovery-v002.zip"
$batch = "_ai-conspects\_batches\batch-websockets-missing-screenshots-recovery-v002"
$target = "_ai-conspects\websockets"

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $batch $target

git status --short -- $batch $target
```

Commit:

```powershell
git commit -m "Recover missing WebSockets screenshots"
git push origin ai-processed-conspects-text
```
