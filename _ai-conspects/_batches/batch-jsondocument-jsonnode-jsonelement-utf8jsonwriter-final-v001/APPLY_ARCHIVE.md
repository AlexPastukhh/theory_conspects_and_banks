# APPLY ARCHIVE

```powershell
& { Set-Location "C:\Users\alexa\obs"; git checkout ai-processed-conspects-text; $zip = "C:\Users\alexa\Downloads\ai-conspects-jsondocument-jsonnode-jsonelement-utf8jsonwriter-final-v001.zip"; $batch = "_ai-conspects\_batches\batch-jsondocument-jsonnode-jsonelement-utf8jsonwriter-final-v001"; $target = "_ai-conspects\jsondocument, jsonnode, jsonelement, utf8jsonwriter"; $OutputEncoding = [System.Text.UTF8Encoding]::new(); [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new(); Expand-Archive -Path $zip -DestinationPath . -Force; git add -A -- $batch $target; git status --short -- $batch $target; git commit -m "Add JSON DOM and Utf8JsonWriter semantic conspect"; git push origin ai-processed-conspects-text }
```
