# APPLY ARCHIVE

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-jwt-auth-missing-screenshots-recovery-final-v002.zip"
$batch = "_ai-conspects\_batches\batch-jwt-auth-missing-screenshots-recovery-final-v002"
$target = "_ai-conspects\jwt auth"

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $batch $target

git status --short -- $batch $target
```

Commit:

```powershell
git commit -m "Recover missing JWT auth screenshots and transcript"
git push origin ai-processed-conspects-text
```
