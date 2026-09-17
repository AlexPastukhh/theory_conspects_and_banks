# Apply ApiBehaviorOptions + Account activation correction archive

Target branch:

```text
ai-processed-conspects-text
```

## Apply

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text
git pull origin ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-apibehavior-account-activation-comprehensive-v001.zip"

Expand-Archive -Path $zip -DestinationPath . -Force

git status --short -- `
  "_ai-conspects/apibehavioroptions" `
  "_ai-conspects/Account activation"

git --no-pager diff --stat -- `
  "_ai-conspects/apibehavioroptions" `
  "_ai-conspects/Account activation"
```

## Review critical corrections

```powershell
Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/apibehavioroptions/08-technical-correction-notice-v002.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/Account activation/08-technical-risk-corrections-v002.md"
```

Confirm:

```text
ApiBehaviorOptions: 26 / 26 screenshots indexed
ApiBehaviorOptions: exact option names corrected
Account activation: 16 / 16 screenshots indexed
Account activation: token length mismatch flagged
Account activation: missing return in handler flagged
Account activation: ActivatedAt and GET side-effect boundaries documented
```

## Commit

```powershell
git add -- `
  "_ai-conspects/apibehavioroptions" `
  "_ai-conspects/Account activation"

git commit -m "Expand ApiBehaviorOptions and account activation conspects"

git push origin ai-processed-conspects-text
```
