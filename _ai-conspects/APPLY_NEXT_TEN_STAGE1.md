# Apply next ten small conspects — stage1 final coverage v001

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-next-ten-small-stage1-final-coverage-v001.zip"

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
    "_ai-conspects\NEXT_TEN_STAGE1_FINAL_COVERAGE.md"
    "_ai-conspects\APPLY_NEXT_TEN_STAGE1.md"
)

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $targets
git status --short -- $targets

# Commit after review:
# git commit -m "Complete ten small SVG-named conspects"
# git push origin ai-processed-conspects-text
```
