# APPLY ARCHIVE — three conspects final coverage v001

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-partial-init-binary-primitives-decoding-final-v001.zip"
$batch = "_ai-conspects\_batches\batch-partial-init-binary-primitives-decoding-final-v001"
$target1 = "_ai-conspects\partially initialized antipattern and possible partial inits inside repositories"
$target2 = "_ai-conspects\binary primitives"
$target3 = "_ai-conspects\decoding, bytes memory, start of x byte character"

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $batch $target1 $target2 $target3

git status --short -- $batch $target1 $target2 $target3
```

## Commit

```powershell
git commit -m "Complete partial initialization, binary primitives, and UTF-8 decoding conspects"
git push origin ai-processed-conspects-text
```
