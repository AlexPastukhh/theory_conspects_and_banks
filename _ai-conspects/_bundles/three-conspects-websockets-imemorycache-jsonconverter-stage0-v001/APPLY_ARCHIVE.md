# APPLY ARCHIVE - three conspects stage0 naming correction v002

Target branch: `ai-processed-conspects-text`

This correction renames the three already committed stage0 folders to match the exact SVG filenames.

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-three-websockets-imemorycache-jsonconverter-stage0-naming-correction-v002.zip"

$oldTargets = @(
  "_ai-conspects\aspnetcore-websockets-client-browser-auth-subprotocols",
  "_ai-conspects\aspnetcore-imemorycache-expiration-invalidation-stampede",
  "_ai-conspects\dotnet-systemtextjson-jsonconverter-optional-activator"
)

$newTargets = @(
  "_ai-conspects\websockets",
  "_ai-conspects\imemorycache",
  "_ai-conspects\jsonconverter"
)

$bundleTarget = "_ai-conspects\_bundles\three-conspects-websockets-imemorycache-jsonconverter-stage0-v001"

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short

git mv "_ai-conspects\aspnetcore-websockets-client-browser-auth-subprotocols" "_ai-conspects\websockets"
git mv "_ai-conspects\aspnetcore-imemorycache-expiration-invalidation-stampede" "_ai-conspects\imemorycache"
git mv "_ai-conspects\dotnet-systemtextjson-jsonconverter-optional-activator" "_ai-conspects\jsonconverter"

Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $oldTargets $newTargets $bundleTarget

git status --short -- $oldTargets $newTargets $bundleTarget
```

## Commit after review

```powershell
git commit -m "Rename conspects to match SVG filenames"
git push origin ai-processed-conspects-text
```

## Correct resulting paths

```text
_ai-conspects/websockets
_ai-conspects/imemorycache
_ai-conspects/jsonconverter
```
