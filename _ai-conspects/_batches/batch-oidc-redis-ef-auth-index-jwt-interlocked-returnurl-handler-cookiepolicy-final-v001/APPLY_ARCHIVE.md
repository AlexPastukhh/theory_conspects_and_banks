# APPLY ARCHIVE — 10 conspects final coverage v001

Target branch: `ai-processed-conspects-text`

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-oidc-redis-ef-auth-index-jwt-interlocked-returnurl-handler-cookiepolicy-final-v001.zip"
$batch = "_ai-conspects\_batches\batch-oidc-redis-ef-auth-index-jwt-interlocked-returnurl-handler-cookiepolicy-final-v001"
$target1 = "_ai-conspects\OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties"
$target2 = "_ai-conspects\redis, idatabase,iserver"
$target3 = "_ai-conspects\onmodelcreating"
$target4 = "_ai-conspects\cookie auth, antiforgery"
$target5 = "_ai-conspects\indexes, onmodel indexes"
$target6 = "_ai-conspects\jwt auth"
$target7 = "_ai-conspects\interlocked,interlocked.read"
$target8 = "_ai-conspects\return url implementation razor"
$target9 = "_ai-conspects\primary httphandler optoins, socket"
$target10 = "_ai-conspects\usecookiepolicy"

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $batch $target1 $target2 $target3 $target4 $target5 $target6 $target7 $target8 $target9 $target10

git status --short -- $batch $target1 $target2 $target3 $target4 $target5 $target6 $target7 $target8 $target9 $target10
```

## Commit

```powershell
git commit -m "Complete OIDC Redis EF auth indexes JWT interlocked return URL handler and cookie policy conspects"
git push origin ai-processed-conspects-text
```
