# Apply stage0 bundle - Windows path-safe v002

This revision stores every uploaded SVG copy as `source/source.svg` instead of repeating the very long original filename inside the conspect folder. The original SVG filename remains recorded in manifests and source summaries.

Use `tar.exe` for extraction instead of `Expand-Archive`.

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-ten-records-ef-cache-cancellation-proxy-pools-auth-stage0-v002-windows-path-fix.zip"

# Remove any partially extracted target folders first.
# Use -LiteralPath because names contain commas, spaces and parentheses.

# Extract with Windows bsdtar to avoid Microsoft.PowerShell.Archive path handling issues.
tar.exe -xf $zip -C .
```
