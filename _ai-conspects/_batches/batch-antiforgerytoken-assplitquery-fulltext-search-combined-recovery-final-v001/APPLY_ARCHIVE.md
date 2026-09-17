# APPLY ARCHIVE

```powershell
& { Set-Location "C:\Users\alexa\obs"; git checkout ai-processed-conspects-text; $zip = "C:\Users\alexa\Downloads\ai-conspects-antiforgerytoken-assplitquery-fulltext-search-combined-recovery-final-v001.zip"; $batch = "_ai-conspects\_batches\batch-antiforgerytoken-assplitquery-fulltext-search-combined-recovery-final-v001"; $target1 = "_ai-conspects\antiforgerytoken"; $target2 = "_ai-conspects\assplitquery"; $target3 = "_ai-conspects\searching impl, ef core, full text search,sql server"; $OutputEncoding = [System.Text.UTF8Encoding]::new(); [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new(); git status --short; Expand-Archive -Path $zip -DestinationPath . -Force; git add -A -- $batch $target1 $target2 $target3; git status --short -- $batch $target1 $target2 $target3; git commit -m "Recover antiforgery split query and search screenshots"; git push origin ai-processed-conspects-text }
```
