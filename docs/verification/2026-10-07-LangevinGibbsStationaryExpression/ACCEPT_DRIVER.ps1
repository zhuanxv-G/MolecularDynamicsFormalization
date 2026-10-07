
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
 '既有最新正式验收基线LangevinGeneratorOrbit8：5d76f09713fd30ceb2a3c0a86c66e32daeeacc3a，9182jobs/2650公理/265exactinputs，full01全部10checks0/0Leanwarning，输入/rawlog/index/提交后SHA一致。local01全8/private空log0。原actualdomain保持/交换与正时间范数导数已证；上一8ca8f74 compactC²真实normdomain/image已证。'
 '前两批b6315a9 strongC0五项和e35ea64 actualclosed/densegenerator十项已验，共23public。'
 "当前：$Title"
 $Details
 "恢复第一动作：$Next"
 '未完：graphcore、实际正时间jointdensity存在、densityPDE/Gibbs身份、Harris非条件完整结论、一般Theorem6.2、负责人教材语义签核及CORE_SCOPE整体。实际compactC²范数生成元域已证，不再记为未完。literal时间零density反证与印刷Hl Laplacian因子修正待负责人记录保留。'
 '用户历史dirty AGENTS/FORMALIZATION_PLAN/STATUS/roadmap/handoff/tasks及旧候选均保留；仅自身批次allowlist阶段提交；候选不计正式成果。'
 '长期Goal工具只读status paused，用户继续/heartbeat已授权本地推进，工具不能resume；未创建或改变Goal、聊天、工作树、automation。'
 '此前完成8ca8f74提交后的检查点写入因自动权限审查无法完成（额度耗尽）未执行；本次只读确认ordinaryUsageAllowed=true后复核既有264输入及rawlog，补写实际状态，未重复Lean。'
 )
 [IO.File]::WriteAllText((Join-Path (Get-Location) 'docs/handoff/CURRENT_STATE.zh-CN.md'),($lines -join [char]10)+[char]10,[Text.UTF8Encoding]::new($false))
 $entry=([char]10+[char]10+"## $stamp $Title"+[char]10+$Details+[char]10+"下一：$Next"+[char]10)
 [IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/handoff/WORK_LOG.zh-CN.md'),$entry,[Text.UTF8Encoding]::new($false))
}

$ErrorActionPreference='Stop'
$base='docs/verification/2026-10-07-LangevinGibbsStationaryExpression'
$r=Get-Content -LiteralPath "$base/full-check01/CHECK_REPORT.json" -Raw | ConvertFrom-Json
if($r.machine_check_status -ne 'passed' -or $r.exit_code -ne 0 -or $r.checks.Count -ne 10 -or @($r.checks | Where-Object exit_code -ne 0).Count -ne 0){throw 'Full01 incomplete or failed'}
if($r.inputs.Count -ne 267 -or $r.actual_mathlib_revision -cne '5ed2965256430c3649e86755f9576b54eca72435' -or $r.lean_version -notmatch 'version 4.34.0,'){throw 'Config/count mismatch'}
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
if($axiomRecords.Count -ne 2667){throw "Audit declaration count $($axiomRecords.Count)"}
$all=@($axiomRecords | ForEach-Object {
 $name=if($_.Groups[1].Success){$_.Groups[1].Value}else{$_.Groups[3].Value}
 $axs=@(($_.Groups[2].Value -split ',') | ForEach-Object {$_.Trim()} | Where-Object {$_})
 if(@($axs | Where-Object {$_ -cnotin @('propext','Classical.choice','Quot.sound')}).Count -ne 0){throw "Nonstandard axioms in $name"}
 [ordered]@{name=$name;axioms=$axs}
})
$pub=@(Get-Content -LiteralPath "$base/PUBLIC_DECLARATIONS.json" -Raw | ConvertFrom-Json)
if($pub.Count -ne 12){throw 'Public count'}
$new=@(foreach($name in $pub){
 $found=@($all | Where-Object {$_.name -ceq $name})
 if($found.Count -ne 1){throw "Public audit count $name"}
 $found[0]
})
$btxt=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/full-check01/lake_build.log"))
if($btxt -notmatch 'Build completed successfully \((\d+) jobs\)'){throw 'Missing build jobs'}
$jobs=[int]$Matches[1];if($jobs -ne 9184){throw 'Job count mismatch'}
$flags=@'
{
  "actual_model": "original_unitmass6_47_H_kinetic_half_square_plus_U_actual_drift_original_sigma_p_noise_Nzero",
  "true_phase_divergence": "proved_from_actual_q_p_coordinate_derivatives_minus_gamma_N_no_divergence_premise",
  "classical_forward_expression": "defined_true_minus_b_directional_derivative_minus_computed_divb_times_f_plus_original_sigma_squared_half_momentum_second_derivatives",
  "original_Gibbs_weight": "literal_exp_minus_beta_same_actual_mechanical_H_no_target_stationarity_premise",
  "momentum_first_second": "derived_same_true_H_momentum_shift_quadratic_and_real_exp_chain_all_real_shifts",
  "drift_Gibbs_derivative": "derived_previously_proved_actual_H_friction_dissipation_and_true_exp_chain",
  "classical_stationary_identity": "proved_fluctuation_dissipation_sigma_squared_2gamma_over_beta_beta_positive",
  "physical_noise_stationarity": "proved_sigma_actual_sqrt_2gamma_beta_inverse_using_true_real_sq_sqrt_gamma_positive",
  "periodic_Gibbs_weight": "defined_same_original_periodic_H1_exp_and_proved_all_real_representatives_lift",
  "printed_forward_phi_second_vs_density_rho_second": "PDF268_visual_confirms_printed_phi_second_in_Ldagger_rho_formula_correct_density_derivatives_explicitly_used_owner_signoff_pending",
  "actual_probability_Gibbs_invariance": "not_proved",
  "Gibbs_probability_normalization_in_this_batch": "not_proved_unnormalized_weight",
  "functional_adjoint_domain_flux_integration_by_parts": "not_proved_classical_expanded_expression_only",
  "weak_Gibbs_generator_balance": "not_proved",
  "actual_joint_positive_time_density_existence": "not_proved",
  "graph_core": "not_proved",
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
foreach($path in @('docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv','docs/NOTATION_INVENTORY.csv')){
 $text=[IO.File]::ReadAllText((Join-Path (Get-Location) $path))
 $text=$text.Replace('local03_passed_full_check01_pending','actual_Gibbs_classical_forward_expression_passed_full_check01_semantic_pending')
 [IO.File]::WriteAllText((Join-Path (Get-Location) $path),$text,$utf)
}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/reviews/2026-10-07-LangevinGibbsStationaryExpression/REVIEW.zh-CN.md'),[char]10+'full-check01通过：9184jobs/2667标准公理/267exactinputs/all10checks0/0Leanwarning/allinput及全部原rawlog SHA一致，新12public唯一标准axioms。truephase divergence/actualdrift div=-γN，mechanicalexp-H真实p一二阶/drift导数和真实physicalFD取消得到classicalforward0，原periodicweight allrepresentative lift。原PDF268 forward diffusion印φ二阶vs densityρ不一致明确记录owner修订pending。未证明actualGibbs概率不变性、normalization/weakbalance/functionaladjointdomain/graphcore/CORE。raw01-03保留，不改resource/linter。'+[char]10,$utf)
$allow=@('MolecularDynamics/Chapter06/LangevinGibbsStationaryExpression.lean','MolecularDynamicsFormalization.lean','Scratch.lean','scripts/CheckAxioms.lean','FORMALIZATION_MAP.md','ASSUMPTIONS.md','docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv','docs/NOTATION_INVENTORY.csv','docs/reviews/2026-10-07-LangevinGibbsStationaryExpression/REVIEW.zh-CN.md')
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
git commit -m 'Prove the original Gibbs stationary forward differential expression'
if($LASTEXITCODE -ne 0){throw 'Commit failed'}
$commit=(git rev-parse HEAD).Trim()
foreach($i in $r.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Postcommit input mismatch $($i.relative_path)"}}
if(@(git diff --name-only -- '*.lean').Count -ne 0){throw 'Tracked Lean diff after accepted commit'}
Save-LocalCheckpoint '原Gibbs经典forward12正式验收提交，下一canonical真概率及density' "最新$commit；9184jobs/2667标准公理/267exactinputs/all10checks0/0Leanwarning/all rawlog/index/postcommit SHA，local03全12/private空log0。真phase div及原drift div=-γN，同mechanicalH expGibbs真实p一二阶/drift导数，actualFD或physicalsqrt系数导classicalforward表达0；periodicweight全realrepresentative lift，N0 βγ正无目标PDE/GibbsInv假设。原PDF268 printedφ二阶vsρ明确记录owner pending。实际probabilityGibbs、normalization/weakbalance/functionaladjoint域、graphcore、density、加权H¹核/Prop6.4及CORE未完。下一复用actualtorus Gibbs probability与β^-1 covariance原Gaussian product给真实normalized canonicalphase measure及Boltzmann density，矩与weakbalance逐步导出。" '写LangevinCanonicalMeasure：原q torus Gibbs measure × p actualGaussian pi measure，先真概率/物理beta正variance与Gaussian product density，再同periodicexp-H factor/normalization；未假设目标InvLaw。'

Write-Output "Accepted $commit; 9184/2667/267 all 10 zero, 0 Lean warnings; exact raw logs preserved."
