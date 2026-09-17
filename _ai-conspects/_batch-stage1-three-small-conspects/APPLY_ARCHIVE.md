# Apply archive: three small conspects Stage1 transcript

Archive type: source-level semantic transcript batch.

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
C:\Users\alexa\Downloads\ai-conspects-three-small-conspects-stage1-transcript-v001.zip
```

## Apply + copy staged diff to clipboard

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-three-small-conspects-stage1-transcript-v001.zip"

$paths = @(
  "_ai-conspects\rawconnections,dbconnection,sqlconnection,commands",
  "_ai-conspects\Lazy",
  "_ai-conspects\creating base32 secret",
  "_ai-conspects\_batch-stage1-three-small-conspects"
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
git commit -m "Add three small conspects Stage1 transcripts"
git push origin ai-processed-conspects-text
```

## Rollback before commit

```powershell
git restore --staged -- "_ai-conspects\rawconnections,dbconnection,sqlconnection,commands" "_ai-conspects\Lazy" "_ai-conspects\creating base32 secret" "_ai-conspects\_batch-stage1-three-small-conspects"
git restore -- "_ai-conspects\rawconnections,dbconnection,sqlconnection,commands" "_ai-conspects\Lazy" "_ai-conspects\creating base32 secret" "_ai-conspects\_batch-stage1-three-small-conspects"
git clean -fd -- "_ai-conspects\rawconnections,dbconnection,sqlconnection,commands" "_ai-conspects\Lazy" "_ai-conspects\creating base32 secret" "_ai-conspects\_batch-stage1-three-small-conspects"
```

## Notes

This archive adds Stage1 source-level semantic transcripts for all three small conspects. Next archive should be closure audit batch.
