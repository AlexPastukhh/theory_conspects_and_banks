# Apply archive

```powershell
& { Set-Location -LiteralPath "C:\Users\alexa\obs"; git checkout ai-processed-conspects-text; git config core.longpaths true; $zip="C:\Users\alexa\Downloads\ai-conspects-next-three-full-svg-repair-final-v002.zip"; tar.exe -xf $zip -C .; $targets=@("_ai-conspects\ef core retry, savepoints","_ai-conspects\linq to sql","_ai-conspects\google recapcha and recapchas","_ai-conspects\_bundles\next-three-full-svg-repair-final-v002"); foreach($target in $targets){ Push-Location -LiteralPath $target; git add -f -A -- .; Pop-Location }; git commit --only -m "Complete next three full SVG repairs" -- "_ai-conspects\ef core retry, savepoints" "_ai-conspects\linq to sql" "_ai-conspects\google recapcha and recapchas" "_ai-conspects\_bundles\next-three-full-svg-repair-final-v002"; git push origin ai-processed-conspects-text }
```
