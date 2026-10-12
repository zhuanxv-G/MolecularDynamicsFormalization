#Requires -Version 7.0
param([Parameter(Mandatory)][ValidateRange(3,6)][int]$Chapter,
      [Parameter(Mandatory)][string]$ReportDirectory)
$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$chapterTag = '{0:d2}' -f $Chapter
$reportRoot = [IO.Path]::GetFullPath($ReportDirectory)
Push-Location $projectRoot
try {
    function Test-RecordedCheck([string]$path) {
        if (-not (Test-Path -LiteralPath $path)) { return $false }
        $saved = Get-Content -LiteralPath $path -Raw | ConvertFrom-Json
        if ($saved.machine_check_status -ne 'passed') { return $false }
        foreach ($inputFile in $saved.inputs) {
            if (-not (Test-Path -LiteralPath $inputFile.relative_path)) { return $false }
            if ((Get-FileHash -LiteralPath $inputFile.relative_path -Algorithm SHA256).Hash.ToLowerInvariant() -cne $inputFile.sha256) { return $false }
        }
        foreach ($check in $saved.checks) {
            $log = Join-Path $reportRoot $check.raw_log
            if ($check.exit_code -ne 0 -or -not (Test-Path -LiteralPath $log)) { return $false }
            if ((Get-FileHash -LiteralPath $log -Algorithm SHA256).Hash.ToLowerInvariant() -cne $check.raw_log_sha256) { return $false }
        }
        return $true
    }
    # The shared checker owns creation of a new report directory.
    $runningPath = $reportRoot + '-RUNNING.json'
    if (Test-Path -LiteralPath $runningPath) {
        $prior = Get-Content -LiteralPath $runningPath -Raw | ConvertFrom-Json
        if ($prior.status -eq 'running' -and $prior.process_pid -ne $PID) {
            $taskProcess = Get-Process -Id $prior.process_pid -ErrorAction SilentlyContinue
            while ($taskProcess -and $taskProcess.StartTime.ToUniversalTime().ToString('o') -eq $prior.process_started_at) {
                Start-Sleep -Seconds 5
                $taskProcess = Get-Process -Id $prior.process_pid -ErrorAction SilentlyContinue
            }
        }
    }
    $sharedPath = Join-Path $reportRoot 'CHECK_REPORT.json'
    $localPath = Join-Path $reportRoot 'LOCAL_CHECK_REPORT.json'
    if ((Test-RecordedCheck $sharedPath) -and (Test-RecordedCheck $localPath)) {
        $savedLocal = Get-Content -LiteralPath $localPath -Raw | ConvertFrom-Json
        if ((Get-FileHash -LiteralPath $sharedPath -Algorithm SHA256).Hash.ToLowerInvariant() -ceq $savedLocal.shared_check_sha256) {
            Write-Host 'Reused completed full and chapter checks with unchanged inputs and log hashes.'
            exit 0
        }
    }
    [ordered]@{status='running';chapter=$Chapter;process_pid=$PID;process_started_at=(Get-Process -Id $PID).StartTime.ToUniversalTime().ToString('o')} |
        ConvertTo-Json | Set-Content -LiteralPath $runningPath -Encoding utf8
    # Preserve the accepted shared check unchanged; add fresh chapter evidence.
    if (Test-RecordedCheck $sharedPath) {
        Write-Host 'Reused passed shared check with unchanged inputs and log hashes.'
    } else {
        & (Join-Path $PSScriptRoot 'check.ps1') -ReportDirectory $reportRoot
        if ($LASTEXITCODE -ne 0) { throw 'Shared full check failed.' }
    }
    $paths = @("Blueprint/Ch$chapterTag.lean", "blueprint/ch$chapterTag/CheckAxioms.lean", 'lakefile.toml', 'lean-toolchain', 'lake-manifest.json', 'scripts/local_chapter_check.ps1')
    $inputs = @($paths | ForEach-Object { [ordered]@{relative_path=$_;sha256=(Get-FileHash -LiteralPath $_ -Algorithm SHA256).Hash.ToLowerInvariant()} })
    $blueprintText = Get-Content -LiteralPath "Blueprint/Ch$chapterTag.lean" -Raw
    $codeOnly = [regex]::Replace($blueprintText,'(?s)/-.*?-/','')
    if ($codeOnly -match '\b(admit|axiom|unsafe|True)\b') { throw 'Prohibited Blueprint shortcut.' }
    $checks = @()
    foreach ($check in @(@{name='chapter_fresh';path="Blueprint/Ch$chapterTag.lean"},@{name='chapter_axioms';path="blueprint/ch$chapterTag/CheckAxioms.lean"})) {
        $output = @(& lake env lean $check.path 2>&1 | ForEach-Object { "$_" })
        $code = $LASTEXITCODE
        $logPath = Join-Path $reportRoot ($check.name+'.log')
        [IO.File]::WriteAllText($logPath,($output -join [Environment]::NewLine),[Text.UTF8Encoding]::new($false))
        $checks += [ordered]@{name=$check.name;exit_code=$code;raw_log=$check.name+'.log';raw_log_sha256=(Get-FileHash -LiteralPath $logPath -Algorithm SHA256).Hash.ToLowerInvariant()}
        if ($code -ne 0) { $output | ForEach-Object { Write-Host $_ }; throw "Supplementary $($check.name) failed." }
    }
    foreach ($inputFile in $inputs) {
        if ((Get-FileHash -LiteralPath $inputFile.relative_path -Algorithm SHA256).Hash.ToLowerInvariant() -cne $inputFile.sha256) { throw 'Supplementary input drift.' }
    }
    [ordered]@{chapter=$Chapter;machine_check_status='passed';shared_check_sha256=(Get-FileHash -LiteralPath (Join-Path $reportRoot 'CHECK_REPORT.json') -Algorithm SHA256).Hash.ToLowerInvariant();inputs=$inputs;checks=$checks} | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath (Join-Path $reportRoot 'LOCAL_CHECK_REPORT.json') -Encoding utf8
    [ordered]@{status='completed';chapter=$Chapter;process_pid=$PID;machine_check_status='passed'} | ConvertTo-Json | Set-Content -LiteralPath $runningPath -Encoding utf8
    Write-Host "Full check and supplementary Chapter $Chapter fresh check/axioms passed."
} finally { Pop-Location }
