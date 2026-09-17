# APPLY ARCHIVE

```powershell
& { Set-Location "C:\Users\alexa\obs"; git checkout ai-processed-conspects-text; $zip = "C:\Users\alexa\Downloads\ai-conspects-primary-httphandler-options-socket-missing-screenshots-recovery-final-v002.zip"; $batch = "_ai-conspects\_batches\batch-primary-httphandler-options-socket-missing-screenshots-recovery-final-v002"; $target = "_ai-conspects\primary httphandler optoins, socket"; $OutputEncoding = [System.Text.UTF8Encoding]::new(); [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new(); git status --short; Expand-Archive -Path $zip -DestinationPath . -Force; git add -A -- $batch $target; git status --short -- $batch $target; git commit -m "Recover missing primary handler screenshots and transcript"; git push origin ai-processed-conspects-text }
```
