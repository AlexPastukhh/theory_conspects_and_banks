# APPLY ARCHIVE

```powershell
& { Set-Location "C:\Users\alexa\obs"; git checkout ai-processed-conspects-text; $zip = "C:\Users\alexa\Downloads\ai-conspects-zod-zustand-combined-final-v001.zip"; $batch = "_ai-conspects\_batches\batch-zod-zustand-combined-final-v001"; $target1 = "_ai-conspects\zod"; $target2 = "_ai-conspects\zustand"; $OutputEncoding = [System.Text.UTF8Encoding]::new(); [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new(); Expand-Archive -Path $zip -DestinationPath . -Force; git add -A -- $batch $target1 $target2; git status --short -- $batch $target1 $target2; git commit -m "Add Zod and Zustand semantic conspects"; git push origin ai-processed-conspects-text }
```
