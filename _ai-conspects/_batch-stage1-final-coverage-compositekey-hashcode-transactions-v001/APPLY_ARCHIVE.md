# Apply archive - batch stage1 final coverage

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-batch-stage1-final-coverage-compositekey-hashcode-transactions-v001.zip"
$targets = @(
  "_ai-conspects\composite-key",
  "_ai-conspects\hashcode",
  "_ai-conspects\transaction-isolation",
  "_ai-conspects\_batch-stage1-final-coverage-compositekey-hashcode-transactions-v001"
)

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $targets

git status --short -- $targets
git diff --cached -- $targets | Set-Clipboard
```

Commit after review:

```powershell
git commit -m "Complete composite key hashcode transactions final coverage"
git push origin ai-processed-conspects-text
```
