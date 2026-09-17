[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$repetitionRoot = $PSScriptRoot
$conspectsRoot = Split-Path -Parent $repetitionRoot
$knowledgeRoot = Join-Path $conspectsRoot '_knowledge'
$repositoryRoot = Split-Path -Parent $conspectsRoot
$statePath = Join-Path $repetitionRoot 'REPETITION_STATE.csv'
$queuePath = Join-Path $repetitionRoot 'INITIAL_WAVE_QUEUE.csv'

if ((Test-Path -LiteralPath $statePath) -or (Test-Path -LiteralPath $queuePath)) {
    throw 'Bootstrap outputs already exist. Refusing to overwrite learning state or the active initial-wave queue.'
}

$areaByTopic = @{
    'architecture'    = 'backend'
    'aspnet-core'     = 'backend'
    'http'            = 'backend'
    'axios'           = 'frontend'
    'css'             = 'frontend'
    'javascript'      = 'frontend'
    'react'           = 'frontend'
    'react-hook-form' = 'frontend'
    'react-query'     = 'frontend'
    'redux'           = 'frontend'
    'typescript'      = 'frontend'
    'ef-core'         = 'data'
    'redis'           = 'data'
    'sql'             = 'data'
    'sql-server'      = 'data'
    'security'        = 'security'
    'algorithms'      = 'cross-cutting'
    'dotnet'          = 'cross-cutting'
    'testing'         = 'cross-cutting'
}

# Three six-unit prerequisite/context slots. This is an ordering decision,
# not a claim about the learner's memory or the unit's audited depth.
$immediateIds = @(
    'javascript.timers-tasks-microtasks-and-abortable-delay',
    'aspnet-core.middleware-ordering-short-circuit-and-json',
    'sql-server.logical-query-processing-order',
    'react.render-snapshots-batching-and-memoization',
    'dotnet.async-concurrency-and-task-start',
    'ef-core.tracking-queries-identity-resolution-and-projections',

    'http.rest-constraints-resource-and-method-semantics',
    'aspnet-core.endpoint-matching-phases-and-route-precedence',
    'dotnet.disposable-ownership-and-deterministic-cleanup',
    'javascript.fetch-response-contract-and-wrapper-policy',
    'sql-server.transactions-trancount-and-boundaries',
    'security.cors-and-antiforgery-boundaries',

    'aspnet-core.di-scope-lifetime-and-disposal',
    'ef-core.linq-relational-translation-shapes',
    'react.strict-mode-effect-cleanup',
    'dotnet.deferred-enumeration-replay-and-materialization',
    'typescript.control-flow-type-narrowing',
    'sql-server.index-design-and-query-cost'
)

$units = [System.Collections.Generic.List[object]]::new()

Get-ChildItem -LiteralPath $knowledgeRoot -Directory |
    Sort-Object Name |
    ForEach-Object {
        $topic = $_.Name
        $indexPath = Join-Path $_.FullName 'INDEX.md'
        if (-not (Test-Path -LiteralPath $indexPath)) { return }
        if (-not $areaByTopic.ContainsKey($topic)) {
            throw "No macro-area mapping for topic '$topic'."
        }

        $topicOrdinal = 0
        foreach ($line in Get-Content -LiteralPath $indexPath -Encoding utf8) {
            if ($line -notmatch '^\| `(?<id>[^`]+)` \| (?<title>.*?) \| \[\[(?<link>[^\]]+)\]\] \|$') {
                continue
            }

            $topicOrdinal++
            $filePath = Join-Path $_.FullName ($Matches.link + '.md')
            if (-not (Test-Path -LiteralPath $filePath)) {
                throw "Index link does not resolve: $($Matches.id) -> $filePath"
            }

            $units.Add([pscustomobject]@{
                KnowledgeId  = $Matches.id
                Topic        = $topic
                Area         = $areaByTopic[$topic]
                Unit         = $Matches.title
                File         = $filePath.Substring($repositoryRoot.Length + 1).Replace('\', '/')
                TopicOrdinal = $topicOrdinal
            })
        }
    }

$duplicates = $units | Group-Object KnowledgeId | Where-Object Count -gt 1
if ($duplicates) {
    throw "Duplicate Knowledge IDs: $($duplicates.Name -join ', ')"
}

if ($units.Count -eq 0) {
    throw 'No knowledge units were discovered.'
}

$missingImmediate = $immediateIds | Where-Object { $_ -notin $units.KnowledgeId }
if ($missingImmediate) {
    throw "Immediate-review IDs do not resolve: $($missingImmediate -join ', ')"
}

$state = foreach ($unit in ($units | Sort-Object Topic, TopicOrdinal)) {
    [pscustomobject]@{
        KnowledgeId         = $unit.KnowledgeId
        Topic               = $unit.Topic
        Area                = $unit.Area
        Unit                 = $unit.Unit
        File                 = $unit.File
        SourceStatus         = 'UNKNOWN'
        ReviewPriority       = if ($unit.KnowledgeId -in $immediateIds) { 'HIGH' } else { 'UNASSESSED' }
        LearningState        = 'NOT_REVIEWED'
        LastReview           = ''
        ProvisionalRecall    = ''
        FinalRecall          = ''
        CompletedGapDays     = ''
        IntervalStage        = ''
        NextReview           = ''
        NextType             = 'CALIBRATION'
        NextScope            = 'whole unit'
        ConsecutiveFours     = 0
        OpenQuestionCount    = 0
        HistoryPath          = ''
        OverrideReason       = ''
    }
}

$seed = foreach ($id in $immediateIds) {
    $units | Where-Object KnowledgeId -eq $id
}

$remaining = @($units | Where-Object KnowledgeId -notin $immediateIds)
$distributed = [System.Collections.Generic.List[object]]::new()

foreach ($areaGroup in ($remaining | Group-Object Area)) {
    $areaItems = [System.Collections.Generic.List[object]]::new()
    foreach ($topicGroup in ($areaGroup.Group | Group-Object Topic)) {
        $orderedTopic = @($topicGroup.Group | Sort-Object TopicOrdinal)
        for ($i = 0; $i -lt $orderedTopic.Count; $i++) {
            $unit = $orderedTopic[$i]
            $areaItems.Add([pscustomobject]@{
                UnitObject    = $unit
                TopicFraction = ($i + 0.5) / $orderedTopic.Count
            })
        }
    }

    $orderedArea = @($areaItems | Sort-Object TopicFraction, @{ Expression = { $_.UnitObject.Topic } })
    for ($i = 0; $i -lt $orderedArea.Count; $i++) {
        $distributed.Add([pscustomobject]@{
            UnitObject   = $orderedArea[$i].UnitObject
            AreaFraction = ($i + 0.5) / $orderedArea.Count
        })
    }
}

$orderedRemaining = $distributed |
    Sort-Object AreaFraction, @{ Expression = { $_.UnitObject.Area } } |
    ForEach-Object UnitObject

$waveUnits = @($seed) + @($orderedRemaining)
$queue = for ($i = 0; $i -lt $waveUnits.Count; $i++) {
    $unit = $waveUnits[$i]
    [pscustomobject]@{
        WaveOrder       = $i + 1
        WaveSlot        = [math]::Floor($i / 6) + 1
        SlotPosition    = ($i % 6) + 1
        Area            = $unit.Area
        Topic           = $unit.Topic
        KnowledgeId     = $unit.KnowledgeId
        Unit            = $unit.Unit
        File            = $unit.File
        InitialPriority = if ($unit.KnowledgeId -in $immediateIds) { 'HIGH' } else { 'UNASSESSED' }
        Status          = 'NOT_REVIEWED'
        CompletedOn     = ''
    }
}

$state | Export-Csv -LiteralPath $statePath -NoTypeInformation -Encoding utf8
$queue | Export-Csv -LiteralPath $queuePath -NoTypeInformation -Encoding utf8

Write-Host "Created $($state.Count) state rows at $statePath"
Write-Host "Created $($queue.Count) queue rows across $((($queue | Measure-Object WaveSlot -Maximum).Maximum)) wave slots at $queuePath"
