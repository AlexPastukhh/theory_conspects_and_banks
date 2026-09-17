# Apply archive - WebSockets, IMemoryCache, JsonConverter final coverage v001

Target branch: `ai-processed-conspects-text`

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-three-websockets-imemorycache-jsonconverter-stage1-final-coverage-names-fixed-v002.zip"
$targets = @(
  "_ai-conspects\websockets",
  "_ai-conspects\imemorycache",
  "_ai-conspects\jsonconverter",
  "_ai-conspects\_bundles\three-conspects-websockets-imemorycache-jsonconverter-stage1-final-coverage-v001"
)

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $targets

git status --short -- $targets
```

## Commit

```powershell
git commit -m "Complete WebSockets IMemoryCache JsonConverter conspects"
git push origin ai-processed-conspects-text
```

## Rollback staged targets only

```powershell
git restore --staged -- $targets
git restore -- $targets
```
