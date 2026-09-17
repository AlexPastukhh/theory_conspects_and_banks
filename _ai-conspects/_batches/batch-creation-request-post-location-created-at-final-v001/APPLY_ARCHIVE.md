# APPLY ARCHIVE

```powershell
& { Set-Location "C:\Users\alexa\obs"; git checkout ai-processed-conspects-text; $zip = "C:\Users\alexa\Downloads\ai-conspects-creation-request-post-location-created-at-final-v001.zip"; $batch = "_ai-conspects\_batches\batch-creation-request-post-location-created-at-final-v001"; $target = "_ai-conspects\CREATION REQUEST,POST REQUEST,LOCACTION HEADER,CREATED AT"; $OutputEncoding = [System.Text.UTF8Encoding]::new(); [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new(); Expand-Archive -Path $zip -DestinationPath . -Force; git add -A -- $batch $target; git status --short -- $batch $target; git commit -m "Add creation request Location header semantic conspect"; git push origin ai-processed-conspects-text }
```
