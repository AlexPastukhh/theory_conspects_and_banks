# Apply Lazy correction and previous raw-SVG hotfix

Target branch:

```text
ai-processed-conspects-text
```

## Extract

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text
git pull origin ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-lazy-corrected-v002.zip"

Expand-Archive -Path $zip -DestinationPath . -Force
```

## Force-add the raw SVG files

The repository currently ignores untracked SVG files, so ordinary `git add` is insufficient:

```powershell
git add -f -- `
  "_ai-conspects/Lazy/source/Lazy.svg" `
  "_ai-conspects/SYSTEM.TEXT.JSON SER SER/source/SYSTEM.TEXT.JSON SER SER.svg" `
  "_ai-conspects/computed columns/source/computed columns.svg"
```

## Add the remaining Lazy correction

```powershell
git add -A -- "_ai-conspects/Lazy"
```

## Review exactly what is staged

```powershell
git diff --cached --name-status

git diff --cached --stat
```

The staged paths should be limited to:

```text
_ai-conspects/Lazy/
_ai-conspects/SYSTEM.TEXT.JSON SER SER/source/SYSTEM.TEXT.JSON SER SER.svg
_ai-conspects/computed columns/source/computed columns.svg
```

## Commit and push

```powershell
git commit -m "Correct Lazy transcript and restore missing raw SVG sources"

git push origin ai-processed-conspects-text
```

## Verify

```powershell
git status --short -- `
  "_ai-conspects/Lazy" `
  "_ai-conspects/SYSTEM.TEXT.JSON SER SER/source" `
  "_ai-conspects/computed columns/source"
```

Do not use `git add .` because the working tree contains unrelated changes.
