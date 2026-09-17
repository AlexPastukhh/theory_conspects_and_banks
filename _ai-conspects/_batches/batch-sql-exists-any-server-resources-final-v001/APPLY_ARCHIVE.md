# APPLY ARCHIVE

```powershell
& { Set-Location "C:\Users\alexa\obs"; git checkout ai-processed-conspects-text; $zip = "C:\Users\alexa\Downloads\ai-conspects-sql-exists-any-server-resources-final-v001.zip"; $batch = "_ai-conspects\_batches\batch-sql-exists-any-server-resources-final-v001"; $target1 = "_ai-conspects\in any exist, some"; $target2 = "_ai-conspects\server resources,multipleinstances,microservices"; $OutputEncoding = [System.Text.UTF8Encoding]::new(); [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new(); Remove-Item -Recurse -Force $target1 -ErrorAction SilentlyContinue; Remove-Item -Recurse -Force $target2 -ErrorAction SilentlyContinue; Expand-Archive -Path $zip -DestinationPath . -Force; git add -A -- $batch $target1 $target2; git status --short -- $batch $target1 $target2; git commit -m "Complete SQL existence and server resources conspects"; git push origin ai-processed-conspects-text }
```
