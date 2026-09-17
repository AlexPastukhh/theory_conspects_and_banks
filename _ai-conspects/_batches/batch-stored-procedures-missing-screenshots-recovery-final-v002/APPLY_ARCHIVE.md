# APPLY ARCHIVE

```powershell
& { Set-Location "C:\Users\alexa\obs"; git checkout ai-processed-conspects-text; $zip = "C:\Users\alexa\Downloads\ai-conspects-stored-procedures-missing-screenshots-recovery-final-v002.zip"; $batch = "_ai-conspects\_batches\batch-stored-procedures-missing-screenshots-recovery-final-v002"; $target = "_ai-conspects\stored procedures"; $OutputEncoding = [System.Text.UTF8Encoding]::new(); [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new(); git status --short; Expand-Archive -Path $zip -DestinationPath . -Force; git add -A -- $batch $target; git status --short -- $batch $target; git commit -m "Recover missing stored procedures screenshots and transcript"; git push origin ai-processed-conspects-text }
```
