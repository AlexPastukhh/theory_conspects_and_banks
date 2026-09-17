# Apply archive

```powershell
& { Set-Location -LiteralPath "C:\Users\alexa\obs"; git checkout ai-processed-conspects-text; git config core.longpaths true; $zip="C:\Users\alexa\Downloads\ai-conspects-put-patch-new-conspect-final-v001.zip"; tar.exe -xf $zip -C .; $target="_ai-conspects\PUT,PATCH"; $bundle="_ai-conspects\_bundles\put-patch-new-conspect-final-v001"; Push-Location -LiteralPath $target; git add -f -A -- .; Pop-Location; Push-Location -LiteralPath $bundle; git add -f -A -- .; Pop-Location; git commit --only -m "Add complete PUT PATCH semantic conspect" -- "$target" "$bundle"; git push origin ai-processed-conspects-text }
```
