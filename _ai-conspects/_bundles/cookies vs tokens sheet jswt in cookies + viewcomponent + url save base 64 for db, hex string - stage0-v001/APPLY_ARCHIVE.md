# APPLY ARCHIVE - three conspects stage0 v001

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-three-cookies-vs-tokens-viewcomponent-url-save-base64-stage0-v001.zip"

$targets = @(
  "_ai-conspects\cookies vs tokens sheet jswt in cookies",
  "_ai-conspects\viewcomponent",
  "_ai-conspects\url save base 64 for db, hex string",
  "_ai-conspects\_bundles\cookies vs tokens sheet jswt in cookies + viewcomponent + url save base 64 for db, hex string - stage0-v001"
)

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $targets

git status --short -- $targets
```

## Commit after review

```powershell
git commit -m "Start cookies tokens viewcomponent base64 conspects"
git push origin ai-processed-conspects-text
```
