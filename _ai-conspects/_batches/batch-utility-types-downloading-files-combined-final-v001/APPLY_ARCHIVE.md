# APPLY ARCHIVE

```powershell
& { Set-Location "C:\Users\alexa\obs"; git checkout ai-processed-conspects-text; $zip = "C:\Users\alexa\Downloads\ai-conspects-utility-types-downloading-files-combined-final-v001.zip"; $batch = "_ai-conspects\_batches\batch-utility-types-downloading-files-combined-final-v001"; $target1 = "_ai-conspects\utility types"; $target2 = "_ai-conspects\donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable"; $OutputEncoding = [System.Text.UTF8Encoding]::new(); [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new(); Expand-Archive -Path $zip -DestinationPath . -Force; git add -A -- $batch $target1 $target2; git status --short -- $batch $target1 $target2; git commit -m "Add utility types and file download semantic conspects"; git push origin ai-processed-conspects-text }
```
