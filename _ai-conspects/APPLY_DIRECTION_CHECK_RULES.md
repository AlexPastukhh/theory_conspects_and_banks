# Apply archive: direction check rules v001

Archive type: workflow/protocol update.

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
C:\Users\alexa\Downloads\ai-conspects-direction-check-rules-v001.zip
```

## Apply commands

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-direction-check-rules-v001.zip"

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git status --short
git diff --stat -- _ai-conspects

# Copy full diff to clipboard. Do not print it and do not open a pager.
git --no-pager diff -- _ai-conspects | Set-Clipboard
```

## Optional: save full diff to file

```powershell
git --no-pager diff -- _ai-conspects > C:\Users\alexa\Downloads\ai-conspects-last-diff.patch
```

## Commit commands

```powershell
git add _ai-conspects
git commit -m "Add conspect processing direction check rules"
```

## Push command

```powershell
git push origin ai-processed-conspects-text
```

## Rollback before commit

```powershell
git restore -- _ai-conspects
```

## Notes

This archive is a shared workflow/protocol update.

It does not modify any specific conspect folder.
