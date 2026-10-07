param()
$ErrorActionPreference = 'Stop'
$taskRepo = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..\..'))
$taskSha = [Security.Cryptography.SHA256]::Create()
function Get-TaskByteHash([byte[]]$Bytes) {
    return [Convert]::ToHexString($taskSha.ComputeHash($Bytes)).ToLowerInvariant()
}
function Get-TaskGitBytes([string]$Ref) {
    $taskPsi = [Diagnostics.ProcessStartInfo]::new()
    $taskPsi.FileName = (Get-Command git).Source
    $taskPsi.Arguments = 'cat-file blob ' + $Ref
    $taskPsi.WorkingDirectory = $taskRepo
    $taskPsi.UseShellExecute = $false
    $taskPsi.CreateNoWindow = $true
    $taskPsi.RedirectStandardOutput = $true
    $taskPsi.RedirectStandardError = $true
    $taskProcess = [Diagnostics.Process]::new()
    $taskProcess.StartInfo = $taskPsi
    if (-not $taskProcess.Start()) { throw 'git cat-file did not start' }
    $taskBytes = [IO.MemoryStream]::new()
    $taskProcess.StandardOutput.BaseStream.CopyTo($taskBytes)
    $taskError = $taskProcess.StandardError.ReadToEnd()
    $taskProcess.WaitForExit()
    if ($taskProcess.ExitCode -ne 0) { throw $taskError }
    $taskResult = $taskBytes.ToArray()
    $taskBytes.Dispose()
    $taskProcess.Dispose()
    return ,$taskResult
}
$taskCases = @(
    @{ Batch = 'T2'; Folder = '2026-10-03-T2-first-batch'; Commit = '675fcaedbdef7b6ec57393c1ee99e9ca727da649' },
    @{ Batch = 'T5'; Folder = '2026-10-03-T5-first-batch'; Commit = '9baf87f89d07138a95bfbfe1f37d45dd54946cf7' }
)
$taskEvidence = foreach ($taskCase in $taskCases) {
    $taskEvidenceFolder = Join-Path $taskRepo ('docs\verification\' + $taskCase.Folder)
    $taskReportPath = Join-Path $taskEvidenceFolder 'CHECK_REPORT.json'
    $taskReport = Get-Content -LiteralPath $taskReportPath -Raw | ConvertFrom-Json
    $taskInputChecks = foreach ($taskInput in $taskReport.inputs) {
        $taskCurrentPath = Join-Path $taskRepo $taskInput.relative_path
        $taskGitBytes = Get-TaskGitBytes ($taskCase.Commit + ':' + $taskInput.relative_path)
        $taskGitHash = Get-TaskByteHash $taskGitBytes
        $taskCurrentHash = (Get-FileHash -LiteralPath $taskCurrentPath -Algorithm SHA256).Hash.ToLowerInvariant()
        [ordered]@{
            path = $taskInput.relative_path
            report_sha256 = $taskInput.sha256
            committed_sha256 = $taskGitHash
            committed_bytes_match_report = ($taskGitHash -eq $taskInput.sha256)
            current_sha256 = $taskCurrentHash
            current_bytes_match_report = ($taskCurrentHash -eq $taskInput.sha256)
        }
    }
    $taskLogChecks = foreach ($taskCheck in $taskReport.checks) {
        $taskLogPath = Join-Path $taskEvidenceFolder $taskCheck.raw_log
        $taskLogHash = (Get-FileHash -LiteralPath $taskLogPath -Algorithm SHA256).Hash.ToLowerInvariant()
        [ordered]@{
            check = $taskCheck.name
            recorded_exit_code = $taskCheck.exit_code
            raw_log = $taskCheck.raw_log
            recorded_sha256 = $taskCheck.raw_log_sha256
            actual_sha256 = $taskLogHash
            log_bytes_match_report = ($taskLogHash -eq $taskCheck.raw_log_sha256)
        }
    }
    $taskCiPath = Join-Path $taskEvidenceFolder 'REMOTE_CI_RESULT.json'
    $taskCi = Get-Content -LiteralPath $taskCiPath -Raw | ConvertFrom-Json
    [ordered]@{
        batch = $taskCase.Batch
        frozen_commit = $taskCase.Commit
        check_report_sha256 = (Get-FileHash -LiteralPath $taskReportPath -Algorithm SHA256).Hash.ToLowerInvariant()
        recorded_check_start = $taskReport.started_at
        recorded_check_finish = $taskReport.finished_at
        recorded_machine_status = $taskReport.machine_check_status
        recorded_exit_code = $taskReport.exit_code
        recorded_lean_version = $taskReport.lean_version
        recorded_mathlib_revision = $taskReport.actual_mathlib_revision
        inputs = @($taskInputChecks)
        logs = @($taskLogChecks)
        saved_ci = [ordered]@{
            record_sha256 = (Get-FileHash -LiteralPath $taskCiPath -Algorithm SHA256).Hash.ToLowerInvariant()
            commit = $taskCi.commit
            expected_commit_matches = ($taskCi.commit -eq $taskCase.Commit)
            run_id = $taskCi.run_id
            conclusion = $taskCi.conclusion
            fetched_live_this_review = $false
            original_remote_archive_downloaded_this_review = $false
        }
    }
}
$taskProofChecks = foreach ($taskSource in @('LocalTrajectories.lean', 'PotentialBarriers.lean')) {
    $taskRelativePath = 'MolecularDynamics/Chapter01/' + $taskSource
    $taskSourcePath = Join-Path $taskRepo $taskRelativePath
    $taskProofText = [IO.File]::ReadAllText($taskSourcePath)
    $taskProofBytes = Get-TaskGitBytes ('9baf87f89d07138a95bfbfe1f37d45dd54946cf7:' + $taskRelativePath)
    $taskCurrentProofHash = (Get-FileHash -LiteralPath $taskSourcePath -Algorithm SHA256).Hash.ToLowerInvariant()
    $taskFrozenProofHash = Get-TaskByteHash $taskProofBytes
    $taskNames = @([regex]::Matches($taskProofText, '(?m)^theorem\s+([A-Za-z0-9_.]+)').Groups | Where-Object Name -eq '1' | ForEach-Object Value)
    $taskAudit = [IO.File]::ReadAllText((Join-Path $taskRepo 'docs\verification\2026-10-03-T5-first-batch\axiom_dependencies.log'))
    $taskNamespaceAuditPassed = $taskAudit.Contains('Dependency audit passed for 128 imported project declarations; allowed: [propext, Classical.choice, Quot.sound].')
    $taskAuditRows = foreach ($taskName in $taskNames) {
        $taskDeclaration = 'MolecularDynamics.' + $taskName
        $taskPattern = "'" + [regex]::Escape($taskDeclaration) + "' depends on axioms: \[([^\]]*)\]"
        $taskMatch = [regex]::Match($taskAudit, $taskPattern)
        $taskAllowed = $taskNamespaceAuditPassed
        if ($taskMatch.Success) {
            foreach ($taskAxiom in ($taskMatch.Groups[1].Value -split ',\s*' | Where-Object { $_ })) {
                if ($taskAxiom -notin @('propext', 'Classical.choice', 'Quot.sound')) { $taskAllowed = $false }
            }
        }
        [ordered]@{
            declaration = $taskDeclaration
            individually_printed_in_old_log = $taskMatch.Success
            covered_by_verified_namespace_audit = $taskNamespaceAuditPassed
            only_allowed_axioms = $taskAllowed
            coverage_note = $(if ($taskMatch.Success) { 'Individual axiom print plus namespace-wide audit' } else { 'No individual print; verified namespace-wide audit covers this declaration' })
        }
    }
    [ordered]@{
        path = $taskRelativePath
        current_sha256 = $taskCurrentProofHash
        frozen_sha256 = $taskFrozenProofHash
        current_bytes_match_frozen_commit = ($taskCurrentProofHash -eq $taskFrozenProofHash)
        named_theorem_count = $taskNames.Count
        audit = @($taskAuditRows)
    }
}
$taskOutput = [ordered]@{
    schema_version = '1.0'
    observed_at = [DateTimeOffset]::UtcNow.ToOffset([TimeSpan]::FromHours(8)).ToString('o')
    scope = 'T2/T5 local supplementary evidence review; no rebuild, no website, no remote CI refresh'
    fixed_review_commit = '9baf87f89d07138a95bfbfe1f37d45dd54946cf7'
    textbook_sha256 = (Get-FileHash -LiteralPath (Join-Path $taskRepo '..\Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf') -Algorithm SHA256).Hash.ToLowerInvariant()
    batches = @($taskEvidence)
    reviewed_proofs = @($taskProofChecks)
    responsible_final_semantic_signoff = 'pending'
    mathcopilot_original_review_reports_received = $false
}
$taskOutputPath = Join-Path $PSScriptRoot 'EVIDENCE_CHECK.json'
[IO.File]::WriteAllText($taskOutputPath, ($taskOutput | ConvertTo-Json -Depth 12) + "`n", [Text.UTF8Encoding]::new($false))
[ordered]@{
    local_raw_logs_checked = @($taskEvidence.logs).Count
    local_raw_log_hash_mismatches = @($taskEvidence.logs | Where-Object { -not $_.log_bytes_match_report }).Count
    frozen_inputs_checked = @($taskEvidence.inputs).Count
    frozen_input_hash_mismatches = @($taskEvidence.inputs | Where-Object { -not $_.committed_bytes_match_report }).Count
    proofs = @($taskProofChecks | ForEach-Object { [ordered]@{path=$_.path; named_theorems=$_.named_theorem_count; matches_fixed_commit=$_.current_bytes_match_frozen_commit; audit_mismatches=@($_.audit | Where-Object { -not $_.only_allowed_axioms }).Count} })
    report = $taskOutputPath
} | ConvertTo-Json -Depth 6
