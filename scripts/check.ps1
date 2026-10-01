$ErrorActionPreference = 'Stop'
$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path

$sourceFiles = @(Get-ChildItem -LiteralPath $projectRoot -Filter '*.lean' -File)
$libraryDir = Join-Path $projectRoot 'MolecularDynamics'
if (Test-Path -LiteralPath $libraryDir) {
    $sourceFiles += @(Get-ChildItem -LiteralPath $libraryDir -Filter '*.lean' -File -Recurse)
}

$forbidden = @($sourceFiles | Select-String -Pattern '\b(sorry|admit|axiom)\b' -CaseSensitive)
if ($forbidden.Count -gt 0) {
    $forbidden | ForEach-Object {
        Write-Host ('{0}:{1}: {2}' -f $_.Path, $_.LineNumber, $_.Line.Trim())
    }
    Write-Error 'Project Lean sources contain a forbidden proof shortcut or axiom.'
    exit 1
}

$lakeCommand = Get-Command lake -ErrorAction SilentlyContinue
if ($lakeCommand) {
    $lakeExe = $lakeCommand.Source
} else {
    $lakeExe = Join-Path $env:USERPROFILE '.elan\bin\lake.exe'
    if (-not (Test-Path -LiteralPath $lakeExe)) {
        Write-Error 'lake was not found. Install elan and the project toolchain first.'
        exit 1
    }
}

Push-Location $projectRoot
try {
    & $lakeExe build
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    & $lakeExe env lean Scratch.lean
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
} finally {
    Pop-Location
}

Write-Host 'Project source scan, lake build, and Scratch.lean check passed.'
