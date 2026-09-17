# APPLY ARCHIVE

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-websockets-semantic-refresh-final-v003.zip"
$batch = "_ai-conspects\_batches\batch-websockets-semantic-refresh-final-v003"
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
git commit -m "Complete corrected WebSockets semantic transcript"
git push origin ai-processed-conspects-text
```
