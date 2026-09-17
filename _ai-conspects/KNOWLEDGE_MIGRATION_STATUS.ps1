param(
    [string]$RepoRoot = (Get-Location).Path,
    [string]$OutputPath = '_ai-conspects/KNOWLEDGE_MIGRATION_STATUS.md'
)

$ErrorActionPreference = 'Stop'

$repo = Resolve-Path -LiteralPath $RepoRoot
$conspectsRoot = Join-Path $repo '_ai-conspects'
if (-not (Test-Path -LiteralPath $conspectsRoot -PathType Container)) {
    throw "_ai-conspects not found under repo root: $repo"
}

function Escape-MarkdownCell([string]$Value) {
    if ($null -eq $Value) { return '' }
    return $Value.Replace('|', '\|')
}

function Split-MarkdownTableRow([string]$Line) {
    $cells = [System.Collections.Generic.List[string]]::new()
    $current = [System.Text.StringBuilder]::new()
    $escaped = $false

    foreach ($ch in $Line.ToCharArray()) {
        if ($escaped) {
            [void]$current.Append($ch)
            $escaped = $false
            continue
        }
        if ($ch -eq '\') {
            [void]$current.Append($ch)
            $escaped = $true
            continue
        }
        if ($ch -eq '|') {
            $cells.Add($current.ToString().Trim())
            [void]$current.Clear()
            continue
        }
        [void]$current.Append($ch)
    }
    $cells.Add($current.ToString().Trim())

    if ($cells.Count -gt 0 -and $cells[0] -eq '') {
        $cells.RemoveAt(0)
    }
    if ($cells.Count -gt 0 -and $cells[$cells.Count - 1] -eq '') {
        $cells.RemoveAt($cells.Count - 1)
    }

    return $cells.ToArray()
}

function Read-RegistryStats([string]$RegistryPath) {
    $lines = Get-Content -LiteralPath $RegistryPath -Encoding UTF8

    $knowledgeIds = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
    $mappingRows = 0
    $unresolvedRows = 0
    $inClaimTable = $false

    foreach ($line in $lines) {
        if ($line -match '^\|\s*Source claim group\s*\|') {
            $inClaimTable = $true
            continue
        }
        if ($inClaimTable -and $line -match '^##\s+') {
            $inClaimTable = $false
        }
        if (-not $inClaimTable) { continue }
        if ($line -match '^\|[-:| ]+\|\s*$') { continue }
        if ($line -notmatch '^\|') { continue }

        $cells = @(Split-MarkdownTableRow $line)
        if ($cells.Count -lt 5) { continue }

        # The four rightmost columns are stable: Knowledge ID, Topic,
        # Destination file, Mapping. Any extra cells to the left belong to
        # Source claim text that contained an unescaped pipe.
        $idCell = $cells[$cells.Count - 4]
        $mapping = $cells[$cells.Count - 1].Trim('`').Trim().ToUpperInvariant()

        if ($mapping -in @('MAPPED', 'MERGED', 'NON_LEARNING', 'UNRESOLVED')) {
            $mappingRows++
        }
        if ($mapping -eq 'UNRESOLVED') {
            $unresolvedRows++
        }

        if ($mapping -in @('MAPPED', 'MERGED')) {
            $matches = [regex]::Matches($idCell, '`([^`]+)`')
            if ($matches.Count -gt 0) {
                foreach ($match in $matches) {
                    $id = $match.Groups[1].Value.Trim()
                    if ($id -and $id -notin @('-', '—', 'N/A')) {
                        [void]$knowledgeIds.Add($id)
                    }
                }
            } else {
                $id = $idCell.Trim('`').Trim()
                if ($id -and $id -notin @('-', '—', 'N/A')) {
                    [void]$knowledgeIds.Add($id)
                }
            }
        }
    }

    $unresolved = $null
    foreach ($line in $lines) {
        if ($line -match '^\|\s*UNRESOLVED\s*\|\s*(\d+)\s*\|') {
            $unresolved = [int]$Matches[1]
        }
    }
    if ($null -eq $unresolved) {
        $unresolved = $unresolvedRows
    }

    [pscustomobject]@{
        Units = $knowledgeIds.Count
        MappingRows = $mappingRows
        Unresolved = $unresolved
    }
}

# Match the established migration scan: top-level directories whose names do
# not start with underscore. Directories such as `_knowledge`, `_batches`, and
# `_bundles` are excluded; ordinary source workspaces such as `-all` remain
# included when they carry their own SOT/registry.
# Also exclude repository/service directories that are not source workspaces.
$excludedWorkspaceNames = @('.git', '.agents', 'tmp_pdf_extract', 'protocol')
$workspaceDirs = Get-ChildItem -LiteralPath $conspectsRoot -Directory |
    Where-Object {
        $_.Name -notlike '_*' -and $_.Name -notin $excludedWorkspaceNames
    }

$rows = foreach ($dir in $workspaceDirs) {
    $sotPath = Join-Path $dir.FullName 'CURRENT_SOURCE_OF_TRUTH.md'
    $registryPath = Join-Path $dir.FullName 'KNOWLEDGE_REGISTRY.md'
    $hasSot = Test-Path -LiteralPath $sotPath -PathType Leaf
    $hasRegistry = Test-Path -LiteralPath $registryPath -PathType Leaf

    $status = if ($hasRegistry -and $hasSot) {
        'MIGRATED'
    } elseif ($hasRegistry) {
        'MIGRATED_NO_SOT'
    } elseif ($hasSot) {
        'PENDING'
    } else {
        'NO_SOT'
    }

    $stats = if ($hasRegistry) { Read-RegistryStats $registryPath } else { $null }

    [pscustomobject]@{
        Workspace = $dir.Name
        SOT = if ($hasSot) { 'yes' } else { 'no' }
        Registry = if ($hasRegistry) { 'yes' } else { 'no' }
        Status = $status
        Units = if ($stats) { $stats.Units } else { $null }
        MappingRows = if ($stats) { $stats.MappingRows } else { $null }
        Unresolved = if ($stats) { $stats.Unresolved } else { $null }
    }
}

$rows = @($rows | Sort-Object @{ Expression = {
    switch ($_.Status) {
        'PENDING' { 0 }
        'MIGRATED_NO_SOT' { 1 }
        'NO_SOT' { 2 }
        default { 3 }
    }
}}, Workspace)

$total = $rows.Count
$migrated = @($rows | Where-Object { $_.Registry -eq 'yes' }).Count
$pending = @($rows | Where-Object { $_.Status -eq 'PENDING' }).Count
$noSot = @($rows | Where-Object { $_.Status -eq 'NO_SOT' }).Count
$registryNoSot = @($rows | Where-Object { $_.Status -eq 'MIGRATED_NO_SOT' }).Count
$withUnresolved = @($rows | Where-Object { $null -ne $_.Unresolved -and $_.Unresolved -gt 0 }).Count

$branch = 'unknown'
$head = 'unknown'
try { $branch = (& git -C $repo rev-parse --abbrev-ref HEAD 2>$null).Trim() } catch {}
try { $head = (& git -C $repo rev-parse HEAD 2>$null).Trim() } catch {}
$generatedAt = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss zzz')

$out = [System.Collections.Generic.List[string]]::new()
$out.Add('# Knowledge Migration Status')
$out.Add('')
$out.Add('Generated inventory. Do not edit workspace rows by hand; regenerate them with `KNOWLEDGE_MIGRATION_STATUS.ps1`.')
$out.Add('')
$out.Add("- Branch: ``$branch``")
$out.Add("- HEAD: ``$head``")
$out.Add("- Generated: $generatedAt")
$out.Add('')
$out.Add('## Summary')
$out.Add('')
$out.Add('| Metric | Count |')
$out.Add('|---|---:|')
$out.Add("| Top-level directories included by the scan (name not starting with _) | $total |")
$out.Add("| Migrated (KNOWLEDGE_REGISTRY.md present) | $migrated |")
$out.Add("| Pending (CURRENT_SOURCE_OF_TRUTH.md present, registry absent) | $pending |")
$out.Add("| No SOT and no registry | $noSot |")
$out.Add("| Registry present but SOT absent | $registryNoSot |")
$out.Add("| Migrated workspaces with UNRESOLVED > 0 | $withUnresolved |")
$out.Add('')
$out.Add('Status meaning: MIGRATED = already partitioned/mapped into knowledge units; PENDING = ready candidate by the normal migration heuristic; NO_SOT = not ready by that heuristic; MIGRATED_NO_SOT = provenance anomaly worth checking.')
$out.Add('For rows without a registry, Units, Mapping rows, and Unresolved are unknown because those values have not been established yet.')
$out.Add('Excluded service/non-workspace directories: `protocol` (processing protocol documentation, not source learning material).')
$out.Add('')
$out.Add('## Workspaces')
$out.Add('')
$out.Add('| Workspace | SOT | Registry | Status | Units | Mapping rows | Unresolved |')
$out.Add('|---|:---:|:---:|---|---:|---:|---:|')
foreach ($row in $rows) {
    $name = Escape-MarkdownCell $row.Workspace
    $units = if ($null -ne $row.Units) { [string]$row.Units } else { 'unknown' }
    $mappingRows = if ($null -ne $row.MappingRows) { [string]$row.MappingRows } else { 'unknown' }
    $unresolved = if ($null -ne $row.Unresolved) { [string]$row.Unresolved } else { 'unknown' }
    $out.Add("| $name | $($row.SOT) | $($row.Registry) | $($row.Status) | $units | $mappingRows | $unresolved |")
}
$out.Add('')
$out.Add('## Regenerate')
$out.Add('')
$out.Add('From the repository root:')
$out.Add('')
$out.Add('```powershell')
$out.Add('powershell -ExecutionPolicy Bypass -File .\_ai-conspects\KNOWLEDGE_MIGRATION_STATUS.ps1')
$out.Add('```')
$out.Add('')
$out.Add('The registry is the migration marker. The status file is only a generated view; current workspace files remain the authority.')

$resolvedOutput = Join-Path $repo $OutputPath
$parent = Split-Path -Parent $resolvedOutput
if (-not (Test-Path -LiteralPath $parent)) {
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
}
[System.IO.File]::WriteAllLines($resolvedOutput, $out, [System.Text.UTF8Encoding]::new($false))
Write-Host "Wrote $resolvedOutput"
Write-Host "Migrated: $migrated | Pending: $pending | Total dirs: $total"
