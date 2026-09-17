# APPLY ARCHIVE — auth/security triple final coverage v002 (exact SVG names)

This archive supersedes the previous stage0/final archives and uses conspect-folder names that exactly match the source SVG base names.

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-auth-security-triple-final-coverage-exact-names-v002.zip"
$batch0 = "_ai-conspects\_batches\batch-auth-cors-antiforgery-basic-auth-account-activation-stage0-v001"
$batch1 = "_ai-conspects\_batches\batch-auth-cors-antiforgery-basic-auth-account-activation-final-v001"

$target1 = "_ai-conspects\cors vs anti forgery"
$target2 = "_ai-conspects\basic auth"
$target3 = "_ai-conspects\account activation"

$old1 = "_ai-conspects\aspnetcore-cors-vs-antiforgery-simple-requests-preflight-credentials"
$old2 = "_ai-conspects\aspnetcore-basic-authentication-custom-handler-httpclient-curl"
$old3 = "_ai-conspects\aspnetcore-account-activation-email-confirmation-dataprotection-identity"

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short

if (Test-Path $old1) { Remove-Item -Recurse -Force $old1 }
if (Test-Path $old2) { Remove-Item -Recurse -Force $old2 }
if (Test-Path $old3) { Remove-Item -Recurse -Force $old3 }

Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $batch0 $batch1 $old1 $old2 $old3 $target1 $target2 $target3

git status --short -- $batch0 $batch1 $old1 $old2 $old3 $target1 $target2 $target3
```

## Commit after review

```powershell
git commit -m "Complete cors vs anti forgery, basic auth, and account activation conspects"
git push origin ai-processed-conspects-text
```
