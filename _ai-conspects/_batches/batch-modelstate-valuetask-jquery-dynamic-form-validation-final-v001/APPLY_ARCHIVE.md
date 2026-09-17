# APPLY_ARCHIVE — combined final coverage

## PowerShell

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-modelstate-valuetask-jquery-dynamic-form-validation-final-v001.zip"
$batch = "_ai-conspects\_batches\batch-modelstate-valuetask-jquery-dynamic-form-validation-final-v001"
$target1 = "_ai-conspects\modelstate"
$target2 = "_ai-conspects\valuetask"
$target3 = "_ai-conspects\jquery dynamic form validation"

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $batch $target1 $target2 $target3

git status --short -- $batch $target1 $target2 $target3
```

## Commit

```powershell
git commit -m "Complete modelstate, valuetask, and jquery dynamic form validation conspects"
git push origin ai-processed-conspects-text
```

## Rollback this batch only

```powershell
git restore --staged -- $batch $target1 $target2 $target3
git restore -- $batch $target1 $target2 $target3
```
