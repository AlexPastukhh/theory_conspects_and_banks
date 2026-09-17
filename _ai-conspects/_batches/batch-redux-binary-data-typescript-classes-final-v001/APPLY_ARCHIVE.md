# APPLY ARCHIVE

```powershell
& { Set-Location "C:\Users\alexa\obs"; git checkout ai-processed-conspects-text; $zip = "C:\Users\alexa\Downloads\ai-conspects-redux-binary-data-typescript-classes-final-v001.zip"; $batch = "_ai-conspects\_batches\batch-redux-binary-data-typescript-classes-final-v001"; $target1 = "_ai-conspects\redux rtk"; $target2 = "_ai-conspects\uintarray,blob, arraybuffer,dataview,endianness"; $target3 = "_ai-conspects\typescript ctor shortcut, inheritance, statics, getters,setters, prop! - definite assertion"; $OutputEncoding = [System.Text.UTF8Encoding]::new(); [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new(); Expand-Archive -Path $zip -DestinationPath . -Force; git add -A -- $batch $target1 $target2 $target3; git status --short -- $batch $target1 $target2 $target3; git commit -m "Add Redux binary data and TypeScript class semantic conspects"; git push origin ai-processed-conspects-text }
```
