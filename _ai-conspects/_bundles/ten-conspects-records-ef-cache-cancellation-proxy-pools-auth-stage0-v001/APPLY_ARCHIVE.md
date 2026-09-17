# APPLY ARCHIVE - ten conspects stage0 v001

```powershell
cd C:\Users\alexa\obs
git checkout ai-processed-conspects-text

$zip = "C:\Users\alexa\Downloads\ai-conspects-ten-records-ef-cache-cancellation-proxy-pools-auth-stage0-v001.zip"

$targets = @(
  "_ai-conspects\records",
  "_ai-conspects\dbcontext interseptors savechanges , dbcommand",
  "_ai-conspects\dbset fromsql fromsqlraw fromsqlinterpolated and LINQ executeupdateasync and executedelete async,database.executesql executeraw,fromsqlquery",
  "_ai-conspects\idistributedcache",
  "_ai-conspects\ef migrations, dotnet-counters",
  "_ai-conspects\dbcontextpool, queryfilter",
  "_ai-conspects\cancellation,async",
  "_ai-conspects\proxy, server, vite dev server proxy",
  "_ai-conspects\objectpool,arraypool,memorypool",
  "_ai-conspects\authenticaiton ticket, properties, context.User (claimsprincipal)",
  "_ai-conspects\_bundles\ten-conspects-records-ef-cache-cancellation-proxy-pools-auth-stage0-v001"
)

$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

git status --short
Expand-Archive -Path $zip -DestinationPath . -Force

git add -A -- $targets

git status --short -- $targets
```

## Commit

```powershell
git commit -m "Start ten records EF cache cancellation proxy pools auth conspects"
git push origin ai-processed-conspects-text
```
