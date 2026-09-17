# Apply corrective final archive

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-headers-identity-search-compression-hashing-correction-final-v002.zip"
$batch = "_ai-conspects\_batches\batch-headers-identity-search-compression-hashing-correction-final-v002"
$target1 = "_ai-conspects\headers"
$target2 = "_ai-conspects\identity"
$target3 = "_ai-conspects\searching impl, ef core, full text search,sql server"
$target4 = "_ai-conspects\compression,decompression,request,response"
$target5 = "_ai-conspects\hashing"

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $batch $target1 $target2 $target3 $target4 $target5

git status --short -- $batch $target1 $target2 $target3 $target4 $target5

git commit -m "Complete headers identity search compression and hashing conspects"
git push origin ai-processed-conspects-text
```
