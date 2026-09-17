# APPLY - next ten small stage0 boundary reviews v001

Target branch: `ai-processed-conspects-text`

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-next-ten-small-stage0-boundary-reviews-v001.zip"

$targets = @(
    "_ai-conspects\cookies auth ON REDIRECT  probmem details returning"
    "_ai-conspects\pointers"
    "_ai-conspects\implicit operators  explicit operators"
    "_ai-conspects\totp, summary,theory"
    "_ai-conspects\ascii"
    "_ai-conspects\principles,practises,patterns"
    "_ai-conspects\ef core retry, savepoints"
    "_ai-conspects\outputcache, response cache comparison"
    "_ai-conspects\editor,display templates"
    "_ai-conspects\AUTH EVENTS"
)

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $targets "_ai-conspects\NEXT_TEN_STAGE0_BATCH_MANIFEST.md" "_ai-conspects\APPLY_NEXT_TEN_STAGE0.md"
git status --short -- $targets "_ai-conspects\NEXT_TEN_STAGE0_BATCH_MANIFEST.md" "_ai-conspects\APPLY_NEXT_TEN_STAGE0.md"
```

Commit after review:

```powershell
git commit -m "Start ten small SVG-named conspect boundary reviews"
git push origin ai-processed-conspects-text
```
