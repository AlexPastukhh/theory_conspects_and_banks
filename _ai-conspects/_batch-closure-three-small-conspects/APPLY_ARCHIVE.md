# Apply archive: three small conspects closure audit

Archive type: closure audit batch.

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
C:\Users\alexa\Downloads\ai-conspects-three-small-conspects-closure-audit-v001.zip
```

## Apply + copy staged diff to clipboard

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-three-small-conspects-closure-audit-v001.zip"

$paths = @(
  "_ai-conspects\rawconnections,dbconnection,sqlconnection,commands",
  "_ai-conspects\Lazy",
  "_ai-conspects\creating base32 secret",
  "_ai-conspects\_batch-closure-three-small-conspects"
)

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short

Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $paths

git status --short -- $paths

git diff --staged -- $paths | Set-Clipboard
```

## Commit commands

```powershell
git commit -m "Close three small conspects coverage audits"
git push origin ai-processed-conspects-text
```

## Rollback before commit

```powershell
git restore --staged -- "_ai-conspects\rawconnections,dbconnection,sqlconnection,commands" "_ai-conspects\Lazy" "_ai-conspects\creating base32 secret" "_ai-conspects\_batch-closure-three-small-conspects"
git restore -- "_ai-conspects\rawconnections,dbconnection,sqlconnection,commands" "_ai-conspects\Lazy" "_ai-conspects\creating base32 secret" "_ai-conspects\_batch-closure-three-small-conspects"
git clean -fd -- "_ai-conspects\rawconnections,dbconnection,sqlconnection,commands" "_ai-conspects\Lazy" "_ai-conspects\creating base32 secret" "_ai-conspects\_batch-closure-three-small-conspects"
```

## Notes

This archive does not add new transcript. It closes all three small conspects by source coverage after Stage1.
