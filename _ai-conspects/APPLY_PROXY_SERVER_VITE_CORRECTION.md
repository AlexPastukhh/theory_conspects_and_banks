# Apply archive — proxy/server/Vite source-preserving correction v003

Target branch:

```text
ai-processed-conspects-text
```

## Apply

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text
git pull origin ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-proxy-server-vite-corrected-v003.zip"

Expand-Archive -Path $zip -DestinationPath . -Force

git status --short -- "_ai-conspects/proxy, server, vite dev server proxy"

git --no-pager diff --stat -- "_ai-conspects/proxy, server, vite dev server proxy"

git --no-pager diff -- `
  "_ai-conspects/proxy, server, vite dev server proxy/CURRENT_SOURCE_OF_TRUTH.md"
```

## Review

```powershell
Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/proxy, server, vite dev server proxy/03-source-preserving-transcript-v003.md"

Get-Content -Raw -Encoding UTF8 `
  "_ai-conspects/proxy, server, vite dev server proxy/04-repetition-guide-v003.md"
```

## Commit

```powershell
git add -- "_ai-conspects/proxy, server, vite dev server proxy"

git commit -m "Add source-preserving proxy and Vite transcript"

git push origin ai-processed-conspects-text
```

## Scope

The archive updates only `_ai-conspects/proxy, server, vite dev server proxy/`.

It preserves the v002 regional summary and adds the missing screenshot-level transcript and repetition layer.
