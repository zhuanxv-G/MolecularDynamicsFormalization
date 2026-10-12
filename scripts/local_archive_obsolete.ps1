param([Parameter(Mandatory=$true)][ValidateRange(3,6)][int]$Chapter)
$ErrorActionPreference = 'Stop'
$projectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$chapterTag = '{0:d2}' -f $Chapter
$chapterRoot = Join-Path $projectRoot "blueprint/ch$chapterTag"
$compactRoot = [IO.Path]::GetFullPath((Join-Path $chapterRoot 'mathcopilot_tasks/compact'))
$archiveRoot = [IO.Path]::GetFullPath((Join-Path $chapterRoot 'validation/obsolete_compact'))
$manifest = Get-Content -LiteralPath (Join-Path $chapterRoot 'mathcopilot_tasks/MANIFEST.json') -Raw | ConvertFrom-Json
$expected = @($manifest | ForEach-Object { $_.subtasks | ForEach-Object { [IO.Path]::GetFullPath((Join-Path $projectRoot $_.path)) } })
$obsolete = @(Get-ChildItem -LiteralPath $compactRoot -Filter PASTE.txt -Recurse -File | ForEach-Object { $_.Directory.FullName } | Where-Object { $_ -notin $expected })
if ($obsolete.Count -eq 0) { Write-Host 'No obsolete active compact packages.'; exit 0 }
$planned = @()
foreach ($source in $obsolete) {
    $resolvedSource = [IO.Path]::GetFullPath($source)
    if (-not $resolvedSource.StartsWith($compactRoot.TrimEnd('\')+'\',[StringComparison]::OrdinalIgnoreCase)) { throw 'Archive source escaped the chapter compact root.' }
    $relative = [IO.Path]::GetRelativePath($compactRoot,$resolvedSource)
    $target = [IO.Path]::GetFullPath((Join-Path $archiveRoot $relative))
    if (-not $target.StartsWith($archiveRoot.TrimEnd('\')+'\',[StringComparison]::OrdinalIgnoreCase)) { throw 'Archive target escaped the chapter archive root.' }
    if (Test-Path -LiteralPath $target) { throw "Existing archive target: $target" }
    $files = @(Get-ChildItem -LiteralPath $resolvedSource -Recurse -File | ForEach-Object {
        [ordered]@{name=[IO.Path]::GetRelativePath($resolvedSource,$_.FullName);sha256=(Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash.ToLowerInvariant()}
    })
    $planned += [ordered]@{source=$resolvedSource;target=$target;files=$files}
}
$null = New-Item -ItemType Directory -Path $archiveRoot -Force
$receipt = Join-Path $archiveRoot ('MOVE-'+(Get-Date -Format 'yyyyMMdd-HHmmss')+'.json')
$planned | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $receipt -Encoding utf8
foreach ($item in $planned) {
    $null = New-Item -ItemType Directory -Path ([IO.Path]::GetDirectoryName($item.target)) -Force
    Move-Item -LiteralPath $item.source -Destination $item.target
    foreach ($file in $item.files) {
        $after = (Get-FileHash -LiteralPath (Join-Path $item.target $file.name) -Algorithm SHA256).Hash.ToLowerInvariant()
        if ($after -cne $file.sha256) { throw 'Archived file hash changed.' }
    }
}
Write-Host "Archived $($obsolete.Count) obsolete compact packages with identical hashes."
