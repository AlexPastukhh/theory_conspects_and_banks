# Apply archive: source availability workflow note v001

Archive type: workflow note update.

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
C:\Users\alexa\Downloads\ai-conspects-source-availability-workflow-v001.zip
```

## Apply commands

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-source-availability-workflow-v001.zip"

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
git commit -m "Document source availability workflow"
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

This archive only documents workflow.

It does not claim that every bundle exists. It records that bundles are added incrementally and should be checked on `ai-processing-excalidraw-conspects` before requesting screenshots manually.
