
function Save-LocalCheckpoint([string]$Title,[string]$Details,[string]$Next) {
 $stamp=[DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('yyyy-MM-dd HH:mm:ss zzz')
 $head=(git rev-parse HEAD).Trim()
 $branch=(git branch --show-current).Trim()
 $latest=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCompactC2Domain/ACCEPTANCE.json' -Raw | ConvertFrom-Json
 $lines=@(
 '# 当前可操作状态'
 "最后更新时间（Asia/Shanghai）：$stamp"
 '当前聊天01a10bc0-bc8d-7043-8df9-21a6b0bde09a；handoff ready/new_thread_id正确。'
 "工程C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization；branch $branch；HEAD $head。"
 '固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435，只本地。'
 '既有最新正式验收基线LangevinCanonicalPartition11：61cf59abd16d1cc275be5067a328cccbe70b47e0，9186jobs/2692公理/269exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local02全11/private空log0。actualfullweight可积/partition真实积分公式及正性/actualdensity真实积分倒数/smooth reallift/allrepresentatives/actualnormalized torusdensity physicalclassicforward零已证。canonical实际概率与p²矩已验；actualGibbsInv和weakbalance仍未证。'
 '本轮已有Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14加CanonicalPartition11五批共50public通过正式验收。'
 "当前：$Title"
 $Details
 "恢复第一动作：$Next"
 '未完：graphcore、实际正时间jointdensity存在、densityPDE/Gibbs身份、Harris非条件完整结论、一般Theorem6.2、负责人教材语义签核及CORE_SCOPE整体。实际compactC²范数生成元域已证，不再记为未完。literal时间零density反证与印刷Hl Laplacian因子修正待负责人记录保留。'
 '用户历史dirty AGENTS/FORMALIZATION_PLAN/STATUS/roadmap/handoff/tasks及旧候选均保留；仅自身批次allowlist阶段提交；候选不计正式成果。'
 '长期Goal工具只读status paused，用户继续/heartbeat已授权本地推进，工具不能resume；未创建或改变Goal、聊天、工作树、automation。'
 '历史8ca8f74缺失检查点已补；CanonicalMeasure14 local04后full02启动前因额度使自动权限审查失败，整条命令未执行。2026-10-07只读额度ordinaryUsageAllowed=true、无active Lean、local04空log0和exact源码重新核对后恢复，未重复局部证明。'
 )
 [IO.File]::WriteAllText((Join-Path (Get-Location) 'docs/handoff/CURRENT_STATE.zh-CN.md'),($lines -join [char]10)+[char]10,[Text.UTF8Encoding]::new($false))
 $entry=([char]10+[char]10+"## $stamp $Title"+[char]10+$Details+[char]10+"下一：$Next"+[char]10)
 [IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/handoff/WORK_LOG.zh-CN.md'),$entry,[Text.UTF8Encoding]::new($false))
}

$ErrorActionPreference='Stop'
$base='docs/verification/2026-10-07-LangevinCanonicalMomentumIBP'
$r=Get-Content -LiteralPath "$base/full-check01/CHECK_REPORT.json" -Raw | ConvertFrom-Json
if($r.machine_check_status -ne 'passed' -or $r.exit_code -ne 0 -or $r.checks.Count -ne 10 -or @($r.checks | Where-Object exit_code -ne 0).Count -ne 0){throw 'Full01 incomplete or failed'}
if($r.inputs.Count -ne 270 -or $r.actual_mathlib_revision -cne '5ed2965256430c3649e86755f9576b54eca72435' -or $r.lean_version -notmatch 'version 4.34.0,'){throw 'Config/count mismatch'}
foreach($i in $r.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Input changed $($i.relative_path)"}}
foreach($c in $r.checks){if((Get-FileHash -LiteralPath "$base/full-check01/$($c.raw_log)").Hash.ToLowerInvariant() -cne $c.raw_log_sha256){throw "Raw changed $($c.raw_log)"}}
$warnings=@()
foreach($n in @('lake_build','scratch','axiom_dependencies')){
 $log=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/full-check01/$n.log"))
 $warnings+=@([regex]::Matches($log,'(?m)^.*warning:.*$') | ForEach-Object {$_.Value})
}
if($warnings.Count -gt 0){throw 'Lean warning found'}
$alog=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/full-check01/axiom_dependencies.log"))
$axiomRecords=[regex]::Matches($alog,"(?s)'([^']+)' depends on axioms:\s*\[([^\]]*)\]|'([^']+)' does not depend on any axioms")
if($axiomRecords.Count -ne 2700){throw "Audit declaration count $($axiomRecords.Count)"}
$all=@($axiomRecords | ForEach-Object {
 $name=if($_.Groups[1].Success){$_.Groups[1].Value}else{$_.Groups[3].Value}
 $axs=@(($_.Groups[2].Value -split ',') | ForEach-Object {$_.Trim()} | Where-Object {$_})
 if(@($axs | Where-Object {$_ -cnotin @('propext','Classical.choice','Quot.sound')}).Count -ne 0){throw "Nonstandard axioms in $name"}
 [ordered]@{name=$name;axioms=$axs}
})
$pub=@(Get-Content -LiteralPath "$base/PUBLIC_DECLARATIONS.json" -Raw | ConvertFrom-Json)
if($pub.Count -ne 8){throw 'Public count'}
$new=@(foreach($name in $pub){
 $found=@($all | Where-Object {$_.name -ceq $name})
 if($found.Count -ne 1){throw "Public audit count $name"}
 $found[0]
})
$btxt=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/full-check01/lake_build.log"))
if($btxt -notmatch 'Build completed successfully \((\d+) jobs\)'){throw 'Missing build jobs'}
$jobs=[int]$Matches[1];if($jobs -ne 9187){throw 'Job count mismatch'}
$flags=@'
{
  "actual_model": "original_unit_mass_canonical_momentum_variance_beta_inverse_positive_beta_Nzero",
  "actual_momentum_density": "same_literal_Gaussian_Boltzmann_coefficient_and_kinetic_weight",
  "density_law_identity": "proved_true_original_gaussian_pi_measure_with_same_density_and_real_expectation",
  "density_smooth_partial": "derived_true_mechanical_Gibbs_curve_and_real_Frechet_coordinate_derivative_minus_beta_p_density",
  "gaussian_integration_by_parts": "proved_actual_measure_C1_compact_momentum_tests_true_fullspace_Haar_IBP_all_integrability_derived",
  "physical_momentum_operator": "literal_gamma_sum_beta_inverse_second_partial_minus_p_first_partial_original_friction_diffusion_component",
  "C2_compact_momentum_weak_balance": "proved_true_first_derivative_compact_support_C1_and_real_integrability_then_actual_IBP_cancellation",
  "project_source_placeholders": "none_early_parse_errors_compiler_recovery_warning_preserved_only_failed_raw_not_accepted_source",
  "whole_Langevin_phase_weak_balance": "not_proved_Hamiltonian_position_force_terms_pending",
  "actual_probability_Gibbs_invariance": "not_proved",
  "functional_adjoint_domain_flux_integration_by_parts": "not_proved_complete_phase",
  "graph_core": "not_proved",
  "actual_joint_positive_time_density_existence": "not_proved",
  "weighted_H1_kernel_Proposition6_4": "not_proved",
  "responsible_semantic_review": "pending",
  "whole_theorem6_2": "incomplete",
  "core_scope": "incomplete"
}
'@ | ConvertFrom-Json -AsHashtable
$a=[ordered]@{started_at=$r.started_at;finished_at=$r.finished_at;head_at_check=$r.head;branch=$r.branch;jobs=$jobs;audit_declarations=$axiomRecords.Count;inputs=$r.inputs.Count;new_public_declarations=$pub;new_public_axiom_audit=$new;all_checks_exit_zero=$true;all_inputs_sha256_verified=$true;all_raw_logs_sha256_verified=$true;all_public_axioms_standard=$true;lean_warnings=0}
$a['local_logs']=@('FULL_DRIVER.log','local01.log','local02.log','local03.log') | ForEach-Object {[ordered]@{path=$_;sha256=(Get-FileHash -LiteralPath "$base/$_").Hash.ToLowerInvariant()}}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath "$base/ACCEPTANCE.json" -Encoding utf8
$local=Get-Content -LiteralPath "$base/LOCAL_CHECK.json" -Raw | ConvertFrom-Json -AsHashtable
$local['full_check']='passed_full_check01'
$local | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath "$base/LOCAL_CHECK.json" -Encoding utf8
$utf=[Text.UTF8Encoding]::new($false)

foreach($spec in @(@{path='docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv';id='CH06-DEP-152'},@{path='docs/NOTATION_INVENTORY.csv';id='NOT-CH06-161'})){
 $text=[IO.File]::ReadAllText((Join-Path (Get-Location) $spec.path))
 $records=[regex]::Matches($text,'(?m)^'+[regex]::Escape($spec.id)+',[^\r\n]*')
 if($records.Count -ne 1){throw 'Own ledger identity mismatch'}
 $newRow=$records[0].Value.Replace('local03_passed_full_check01_pending','actual_canonical_momentum_IBP_weakOU_passed_full_check01_semantic_pending')
 $text=$text.Replace($records[0].Value,$newRow)
 [IO.File]::WriteAllText((Join-Path (Get-Location) $spec.path),$text,$utf)
}

[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/reviews/2026-10-07-LangevinCanonicalMomentumIBP/REVIEW.zh-CN.md'),[char]10+'full-check01通过：9187jobs/2700标准公理/270exactinputs/all10checks0/0Leanwarning/allinput及全部原rawlog SHA一致，新8public唯一标准axioms。actualGauss pi law literalPDF/expectation/C∞partial、C1compact真实Haar IBP及C2compactmomentum OU弱零已证，各实际导数支持与integrability推导；完整phase Hamiltonian qforce balance/actualGibbsInv未证。raw01–03保留，无option变化，earlyparse compilerrecovery只失败raw。'+[char]10,$utf)
foreach($path in @('FORMALIZATION_MAP.md','STATUS.md')){
 $text=[IO.File]::ReadAllText((Join-Path (Get-Location) $path))
 if($path -eq 'FORMALIZATION_MAP.md'){$text=$text.Replace('local03零warning exactfull01待验；完整phase q-Hamiltonian与force项/actualGibbsInv尚未证。','local03零warning及exactfull01通过9187/2700/270；完整phase q-Hamiltonian与force项/actualGibbsInv未证。')}
 else{$text=$text.Replace('LangevinCanonicalMomentumIBP8局部通过，唯一full01待验；','LangevinCanonicalMomentumIBP8局部及唯一full01通过9187/2700/270；')}
 [IO.File]::WriteAllText((Join-Path (Get-Location) $path),$text,$utf)
}
$allow=@('MolecularDynamics/Chapter06/LangevinCanonicalMomentumIBP.lean','MolecularDynamicsFormalization.lean','Scratch.lean','scripts/CheckAxioms.lean','FORMALIZATION_MAP.md','ASSUMPTIONS.md','docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv','docs/NOTATION_INVENTORY.csv','docs/reviews/2026-10-07-LangevinCanonicalMomentumIBP/REVIEW.zh-CN.md')
$evidence=@(Get-ChildItem -LiteralPath $base -File -Recurse | Where-Object {$_.Extension -in @('.json','.log','.png','.ps1')} | ForEach-Object {[IO.Path]::GetRelativePath((Get-Location).Path,$_.FullName).Replace('\','/')})
$allow+= $evidence
$staged=@(git diff --cached --name-only)
if($LASTEXITCODE -ne 0 -or $staged.Count -ne 0){throw 'Existing staged changes; do not mix'}
foreach($path in $allow){
 if(($path.EndsWith('.log') -or $path.EndsWith('.png'))){
  $oid=(git hash-object -w --no-filters -- $path).Trim()
  if($LASTEXITCODE -ne 0){throw "Hash log $path"}
  git update-index --add --cacheinfo "100644,$oid,$path"
 }else{git add -- $path}
 if($LASTEXITCODE -ne 0){throw "Stage failed $path"}
}
function Read-GitBlobBytes([string]$Spec) {
 $pi=[Diagnostics.ProcessStartInfo]::new('git')
 $pi.UseShellExecute=$false;$pi.RedirectStandardOutput=$true;$pi.RedirectStandardError=$true
 $pi.ArgumentList.Add('cat-file');$pi.ArgumentList.Add('blob');$pi.ArgumentList.Add($Spec)
 $p=[Diagnostics.Process]::Start($pi)
 $ms=[IO.MemoryStream]::new();$p.StandardOutput.BaseStream.CopyTo($ms)
 $err=$p.StandardError.ReadToEnd();$p.WaitForExit()
 if($p.ExitCode -ne 0){throw "Read blob $Spec : $err"}
 return ,$ms.ToArray()
}
$index=@(foreach($path in $allow){
 $wb=[IO.File]::ReadAllBytes((Join-Path (Get-Location) $path))
 $ib=Read-GitBlobBytes ":$path"
 $wh=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($wb)).ToLowerInvariant()
 $ih=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($ib)).ToLowerInvariant()
 $norm=([Text.Encoding]::UTF8.GetString($wb).Replace([string]([char]13)+[char]10,[string][char]10) -ceq [Text.Encoding]::UTF8.GetString($ib).Replace([string]([char]13)+[char]10,[string][char]10))
 if(-not $norm -or (($path.EndsWith('.log') -or $path.EndsWith('.png')) -and $wh -cne $ih)){throw "Index bytes mismatch $path"}
 [ordered]@{path=$path;raw_work_sha256=$wh;staged_sha256=$ih;only_crlf_normalization=$norm;raw_log_exact=(($path.EndsWith('.log') -or $path.EndsWith('.png')) -and $wh -ceq $ih)}
})
$index | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath "$base/STAGED_INPUTS.json" -Encoding utf8
git add -- "$base/STAGED_INPUTS.json"
if($LASTEXITCODE -ne 0){throw 'Stage audit'}
$allow+= "$base/STAGED_INPUTS.json"
$allStaged=@(git diff --cached --name-only)
if(@($allStaged | Where-Object {$_ -notin $allow}).Count -gt 0 -or @($allow | Where-Object {$_ -notin $allStaged}).Count -gt 0){throw 'Staged allowlist mismatch'}
$nonLog=@(git diff --cached --check -- . ':(glob,exclude)**/*.log' 2>&1 | ForEach-Object {"$_"})
if($LASTEXITCODE -ne 0){throw "Non-log whitespace $($nonLog -join [char]10)"}
$ws=@(git diff --cached --check 2>&1 | ForEach-Object {"$_"})
[ordered]@{raw_logs_and_original_PDF_render_preserved_byte_exact=$true;raw_log_whitespace_only=$ws;non_log_whitespace_errors=0;non_log_check_command='git diff --cached --check -- . :(glob,exclude)**/*.log'} | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath "$base/STAGED_LOG_WHITESPACE.json" -Encoding utf8
git add -- "$base/STAGED_LOG_WHITESPACE.json"
if($LASTEXITCODE -ne 0){throw 'Stage raw whitespace audit'}
git commit -m 'Prove actual canonical Gaussian momentum integration by parts'
if($LASTEXITCODE -ne 0){throw 'Commit failed'}
$commit=(git rev-parse HEAD).Trim()
foreach($i in $r.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Postcommit input mismatch $($i.relative_path)"}}
if(@(git diff --name-only -- '*.lean').Count -ne 0){throw 'Tracked Lean diff after accepted commit'}


Save-LocalCheckpoint 'CanonicalMomentumIBP8正式验收提交，继续periodic位置分部积分' "最新$commit；9187jobs/2700标准公理/270exactinputs/all10checks0/0Leanwarning/allrawlog/index/postcommit SHA，local03全8/private空log0。actualGaussian pi law同literalnormalizedPDF与expectation，真实smoothpartial=-βpρ，C1compact Haar IBP导actualGaussian ∫Di f=β∫p_if，C2compact真partial支持/可积给physicalmomentum OU weakzero，N0 β正。无targetIBP/weakbalance/InvLaw前提，完整phase q Hamiltonianforce弱平衡与actualGibbsInv/functionaladjoint/graphcore/density/weightedH1/CORE未完。" '继续原periodic configuration Gibbs位置分部积分：复用真正cube divergence oppositeface cancellation，导actualtorus Gibbs ∫Di f=β∫DiU f，随后接same phase qforce+momentum balance。'
Write-Output "Accepted $commit; 9187/2700/270 all 10 zero, 0 Lean warnings; exact raw logs preserved."
