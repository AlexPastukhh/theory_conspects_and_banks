# APPLY ARCHIVE — 7 conspects final coverage v001

Target branch: `ai-processed-conspects-text`

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-headers-identity-search-compression-hashing-antiforgery-dataprotection-final-v001.zip"
$batch = "_ai-conspects\_batches\batch-headers-identity-search-compression-hashing-antiforgery-dataprotection-final-v001"
$target1 = "_ai-conspects\headers"
$target2 = "_ai-conspects\identity"
$target3 = "_ai-conspects\searching impl, ef core, full text search,sql server"
$target4 = "_ai-conspects\compression,decompression,request,response"
$target5 = "_ai-conspects\hashing"
$target6 = "_ai-conspects\antiforgerytoken"
$target7 = "_ai-conspects\adddataprotection, encryption, password recovery"

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $batch $target1 $target2 $target3 $target4 $target5 $target6 $target7

git status --short -- $batch $target1 $target2 $target3 $target4 $target5 $target6 $target7
```

## Commit

```powershell
git commit -m "Complete headers identity search compression hashing antiforgery and data protection conspects"
git push origin ai-processed-conspects-text
```
