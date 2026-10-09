#Requires -Version 7.0
param([string]$ReportDirectory)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$expectedToolchain = 'leanprover/lean4:v4.34.0'
$expectedLeanVersion = '4.34.0'
$expectedMathlibRevision = '5ed2965256430c3649e86755f9576b54eca72435'
$reportRoot = $null

# Refuse to overwrite evidence from an earlier run.
if ($ReportDirectory) {
    $reportRoot = [IO.Path]::GetFullPath($ReportDirectory)
    if (Test-Path -LiteralPath $reportRoot) {
        throw "Report directory already exists; choose a new run directory: $reportRoot"
    }
    $null = New-Item -ItemType Directory -Path $reportRoot
}

$report = [ordered]@{
    schema_version = '1.0'
    started_at = [DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('o')
    finished_at = $null
    project_root = $projectRoot
    branch = $null
    head = $null
    git_status = $null
    expected_toolchain = $expectedToolchain
    expected_mathlib_revision = $expectedMathlibRevision
    lean_version = $null
    lake_version = $null
    actual_mathlib_revision = $null
    source_scan = 'not_run'
    blueprint_scan = 'not_run'
    blueprint_placeholders = @()
    inputs = @()
    checks = [Collections.Generic.List[object]]::new()
    machine_check_status = 'running'
    exit_code = $null
    responsible_semantic_review = 'pending'
    failed_phase = $null
    error = $null
}

function Save-Report {
    if ($reportRoot) {
        $report | ConvertTo-Json -Depth 10 |
            Set-Content -LiteralPath (Join-Path $reportRoot 'CHECK_REPORT.json') -Encoding utf8
    }
}

function Invoke-CheckedCommand {
    param([string]$Name, [string]$Executable, [string[]]$Arguments)
    Write-Host "Checking $Name..."
    $output = @(& $Executable @Arguments 2>&1 | ForEach-Object { "$_" })
    $code = $LASTEXITCODE
    $output | ForEach-Object { Write-Host $_ }
    $logName = "$Name.log"
    $logHash = $null
    if ($reportRoot) {
        $logPath = Join-Path $reportRoot $logName
        [IO.File]::WriteAllText($logPath, ($output -join [Environment]::NewLine), [Text.UTF8Encoding]::new($false))
        $logHash = (Get-FileHash -LiteralPath $logPath -Algorithm SHA256).Hash.ToLowerInvariant()
    }
    $report.checks.Add([ordered]@{
        name = $Name
        executable = $Executable
        arguments = $Arguments
        cwd = $projectRoot
        exit_code = $code
        raw_log = $(if ($reportRoot) { $logName } else { $null })
        raw_log_sha256 = $logHash
    })
    Save-Report
    if ($code -ne 0) { throw "$Name failed with exit code $code." }
    return ($output -join "`n")
}

$phase = 'input_inventory'
Push-Location $projectRoot
try {
    $auditPath = Join-Path $PSScriptRoot 'CheckAxioms.lean'
    if (-not (Test-Path -LiteralPath $auditPath)) {
        throw 'scripts/CheckAxioms.lean is required for the formal check.'
    }
    $sourceFiles = @(Get-ChildItem -LiteralPath $projectRoot -Filter '*.lean' -File)
    $sourceFiles += @(Get-ChildItem -LiteralPath (Join-Path $projectRoot 'MolecularDynamics') -Filter '*.lean' -File -Recurse)
    $sourceFiles += Get-Item -LiteralPath $auditPath
    $blueprintFiles = @()
    if (Test-Path -LiteralPath (Join-Path $projectRoot 'Blueprint')) {
        # On Windows Blueprint/ and blueprint/ share a physical directory.
        # The pilot target is explicit; metadata-side audit files are checked below.
        $blueprintFiles = @(Get-Item -LiteralPath (Join-Path $projectRoot 'Blueprint/Ch01.lean'))
    }
    $blueprintAudit = Join-Path $projectRoot 'blueprint/ch01/CheckAxioms.lean'
    $inputPaths = @($sourceFiles.FullName) + @($blueprintFiles.FullName) + @(
        (Join-Path $projectRoot 'lean-toolchain'),
        (Join-Path $projectRoot 'lakefile.toml'),
        (Join-Path $projectRoot 'lake-manifest.json'),
        $PSCommandPath,
        (Join-Path $projectRoot '.github/workflows/lean_action_ci.yml')
    )
    if (Test-Path -LiteralPath $blueprintAudit) { $inputPaths += $blueprintAudit }
    $report.inputs = @($inputPaths | Sort-Object -Unique | ForEach-Object {
        [ordered]@{
            relative_path = [IO.Path]::GetRelativePath($projectRoot, $_).Replace('\', '/')
            sha256 = (Get-FileHash -LiteralPath $_ -Algorithm SHA256).Hash.ToLowerInvariant()
        }
    })
    Save-Report

    $phase = 'fixed_configuration'
    $toolchain = (Get-Content -LiteralPath 'lean-toolchain' -Raw).Trim()
    if ($toolchain -cne $expectedToolchain) { throw "Unexpected lean-toolchain: $toolchain" }
    $manifest = Get-Content -LiteralPath 'lake-manifest.json' -Raw | ConvertFrom-Json
    $mathlib = @($manifest.packages | Where-Object { $_.name -ceq 'mathlib' })
    if ($mathlib.Count -ne 1 -or $mathlib[0].rev -cne $expectedMathlibRevision -or
        $mathlib[0].inputRev -cne 'v4.34.0') {
        throw 'lake-manifest.json does not lock the reviewed mathlib v4.34.0 revision.'
    }
    $requirements = (Get-Content -LiteralPath 'lakefile.toml' -Raw) -split '(?m)^\[\[require\]\]\s*$'
    $mathlibRequirements = @($requirements | Where-Object {
        $_ -cmatch '(?m)^name\s*=\s*"mathlib"\s*$'
    })
    if ($mathlibRequirements.Count -ne 1 -or
        $mathlibRequirements[0] -cnotmatch '(?m)^rev\s*=\s*"v4\.34\.0"\s*$') {
        throw 'lakefile.toml must require mathlib v4.34.0.'
    }

    $phase = 'source_scan'
    # This textual gate is conservative; dependency inspection follows.
    $forbidden = @($sourceFiles | Select-String -Pattern '\b(sorry|admit|axiom|unsafe)\b' -CaseSensitive)
    if ($forbidden.Count -gt 0) {
        $report.source_scan = 'failed'
        $forbidden | ForEach-Object {
            Write-Host ('{0}:{1}: {2}' -f $_.Path, $_.LineNumber, $_.Line.Trim())
        }
        throw 'Project Lean sources contain a forbidden proof shortcut, new axiom, or unsafe declaration.'
    }
    $report.source_scan = 'passed'

    # Draft statements live in a separate library; only sorry is permitted there.
    # A successful draft build must never be reported as a completed proof.
    $blueprintForbidden = @($blueprintFiles | Select-String -Pattern '\b(admit|axiom|unsafe|True)\b' -CaseSensitive)
    if ($blueprintForbidden.Count -gt 0) {
        $report.blueprint_scan = 'failed'
        $blueprintForbidden | ForEach-Object { Write-Host "$($_.Path):$($_.LineNumber): $($_.Line)" }
        throw 'Blueprint contains a prohibited shortcut or trivialized statement.'
    }
    $report.blueprint_placeholders = @($blueprintFiles | Select-String -Pattern '\bsorry\b' -CaseSensitive | ForEach-Object {
        [ordered]@{ file = [IO.Path]::GetRelativePath($projectRoot, $_.Path); line = $_.LineNumber }
    })
    $report.blueprint_scan = $(if ($report.blueprint_placeholders.Count) { 'draft_with_placeholders' } else { 'passed' })

    $phase = 'runtime_versions'
    $lakeExe = (Get-Command lake -ErrorAction Stop).Source
    $report.branch = Invoke-CheckedCommand 'git_branch' 'git' @('-c', "safe.directory=$projectRoot", 'branch', '--show-current')
    $report.head = Invoke-CheckedCommand 'git_head' 'git' @('-c', "safe.directory=$projectRoot", 'rev-parse', 'HEAD')
    $report.git_status = Invoke-CheckedCommand 'git_status' 'git' @('-c', "safe.directory=$projectRoot", 'status', '--short')
    $report.lake_version = Invoke-CheckedCommand 'lake_version' $lakeExe @('--version')
    $report.lean_version = Invoke-CheckedCommand 'lean_version' $lakeExe @('env', 'lean', '--version')
    if ($report.lean_version -cnotmatch ('^Lean \(version ' + [regex]::Escape($expectedLeanVersion) + ',')) {
        throw "Actual Lean runtime is not $expectedLeanVersion."
    }
    if ($report.lake_version -cnotmatch ('\(Lean version ' + [regex]::Escape($expectedLeanVersion) + '\)')) {
        throw "Lake runtime does not report Lean $expectedLeanVersion."
    }
    $mathlibDirectory = Join-Path $projectRoot '.lake/packages/mathlib'
    $report.actual_mathlib_revision = Invoke-CheckedCommand 'mathlib_revision' 'git' @(
        '-c', "safe.directory=$mathlibDirectory", '-C', $mathlibDirectory, 'rev-parse', 'HEAD'
    )
    if ($report.actual_mathlib_revision -cne $expectedMathlibRevision) {
        throw 'Actual mathlib checkout differs from the locked revision.'
    }
    $mathlibChanges = Invoke-CheckedCommand 'mathlib_status' 'git' @(
        '-c', "safe.directory=$mathlibDirectory", '-C', $mathlibDirectory,
        'status', '--porcelain', '--untracked-files=no'
    )
    if ($mathlibChanges) { throw 'Actual mathlib checkout has tracked local modifications.' }

    $phase = 'lake_build'
    $null = Invoke-CheckedCommand 'lake_build' $lakeExe @('build')
    $phase = 'scratch'
    $null = Invoke-CheckedCommand 'scratch' $lakeExe @('env', 'lean', 'Scratch.lean')
    $phase = 'axiom_dependencies'
    $null = Invoke-CheckedCommand 'axiom_dependencies' $lakeExe @('env', 'lean', 'scripts/CheckAxioms.lean')
    if ($blueprintFiles.Count) {
        $phase = 'blueprint_fresh_check'
        foreach ($blueprintFile in $blueprintFiles) {
            $relative = [IO.Path]::GetRelativePath($projectRoot, $blueprintFile.FullName)
            $name = 'blueprint_fresh_' + [IO.Path]::GetFileNameWithoutExtension($relative)
            $null = Invoke-CheckedCommand $name $lakeExe @('env', 'lean', $relative)
        }
        if (-not (Test-Path -LiteralPath $blueprintAudit)) { throw 'Blueprint axiom audit file is required.' }
        $phase = 'blueprint_axiom_dependencies'
        $null = Invoke-CheckedCommand 'blueprint_axiom_dependencies' $lakeExe @('env', 'lean', $blueprintAudit)
    }

    $phase = 'input_stability'
    foreach ($inputFile in $report.inputs) {
        $actualHash = (Get-FileHash -LiteralPath (Join-Path $projectRoot $inputFile.relative_path) -Algorithm SHA256).Hash.ToLowerInvariant()
        if ($actualHash -cne $inputFile.sha256) {
            throw "Input changed while the check ran: $($inputFile.relative_path)"
        }
    }
    $report.machine_check_status = 'passed'
    Write-Host 'Fixed versions, project source scan, lake build, Scratch.lean, and axiom dependency checks passed.'
    if ($report.blueprint_placeholders.Count) { Write-Host 'Blueprint draft compiled with recorded placeholders; these entries remain incomplete.' }
} catch {
    $report.machine_check_status = 'failed'
    $report.failed_phase = $phase
    $report.error = $_.Exception.Message
    Write-Host "Formal project check failed in ${phase}: $($report.error)"
} finally {
    $report.exit_code = $(if ($report.machine_check_status -eq 'passed') { 0 } else { 1 })
    $report.finished_at = [DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('o')
    Save-Report
    Pop-Location
}

if ($report.machine_check_status -ne 'passed') { exit 1 }
