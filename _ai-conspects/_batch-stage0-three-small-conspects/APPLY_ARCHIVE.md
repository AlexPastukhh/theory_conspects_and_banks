# Apply archive: three small conspects Stage0 boundary review

Archive type: boundary review batch.

Target branch:

```text
ai-processed-conspects-text
```

Apply from repository root:

```powershell
PS C:\Users\alexa\obs>
```

## Expected download path

```powershell
C:\Users\alexa\Downloads\ai-conspects-three-small-conspects-stage0-boundary-review-v001.zip
```

## Apply commands

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-three-small-conspects-stage0-boundary-review-v001.zip"

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short

Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- "_ai-conspects\rawconnections,dbconnection,sqlconnection,commands" "_ai-conspects\Lazy" "_ai-conspects\creating base32 secret" "_ai-conspects\_batch-stage0-three-small-conspects"

git status --short -- "_ai-conspects\rawconnections,dbconnection,sqlconnection,commands" "_ai-conspects\Lazy" "_ai-conspects\creating base32 secret" "_ai-conspects\_batch-stage0-three-small-conspects"
```

## Commit commands

```powershell
git commit -m "Add three small conspects Stage0 boundary reviews"
git push origin ai-processed-conspects-text
```

## Rollback before commit

```powershell
git restore --staged -- "_ai-conspects\rawconnections,dbconnection,sqlconnection,commands" "_ai-conspects\Lazy" "_ai-conspects\creating base32 secret" "_ai-conspects\_batch-stage0-three-small-conspects"
git restore -- "_ai-conspects\rawconnections,dbconnection,sqlconnection,commands" "_ai-conspects\Lazy" "_ai-conspects\creating base32 secret" "_ai-conspects\_batch-stage0-three-small-conspects"
git clean -fd -- "_ai-conspects\rawconnections,dbconnection,sqlconnection,commands" "_ai-conspects\Lazy" "_ai-conspects\creating base32 secret" "_ai-conspects\_batch-stage0-three-small-conspects"
```

## Notes

This archive is boundary review only. It does not add transcript and does not mark sources as processed.
