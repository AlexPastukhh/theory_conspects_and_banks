# APPLY ARCHIVE

```powershell
& { Set-Location "C:\Users\alexa\obs"; git checkout ai-processed-conspects-text; $zip = "C:\Users\alexa\Downloads\ai-conspects-content-negotiation-formatters-xml-json-final-v001.zip"; $batch = "_ai-conspects\_batches\batch-content-negotiation-formatters-xml-json-final-v001"; $target = "_ai-conspects\CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON"; $OutputEncoding = [System.Text.UTF8Encoding]::new(); [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new(); git status --short; Expand-Archive -Path $zip -DestinationPath . -Force; git add -A -- $batch $target; git status --short -- $batch $target; git commit -m "Add content negotiation formatters semantic conspect"; git push origin ai-processed-conspects-text }
```
