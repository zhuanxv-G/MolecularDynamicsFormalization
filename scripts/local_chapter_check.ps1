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
    # Preserve the accepted shared check unchanged; add fresh chapter evidence.
    & (Join-Path $PSScriptRoot 'check.ps1') -ReportDirectory $reportRoot
    if ($LASTEXITCODE -ne 0) { throw 'Shared full check failed.' }
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
    Write-Host "Full check and supplementary Chapter $Chapter fresh check/axioms passed."
} finally { Pop-Location }
