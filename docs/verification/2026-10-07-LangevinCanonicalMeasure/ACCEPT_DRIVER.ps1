
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
 '既有最新正式验收基线LangevinGibbsStationaryExpression12：1e90f0088ecb520564646f4079f7aed47fd45ec9，9184jobs/2667公理/267exactinputs，full01全部10checks0/0Leanwarning，输入/rawlog/index/提交后SHA一致。local03全12/private空log0。原classicalforward Gibbsweight0与periodiclift已证；actualprobabilityGibbs不变性仍未证。此前actualC0生成元closed/dense/compactC²真normdomain、domain orbit invariance/commutation/正时间norm导数和C0守恒量常数性已验。'
 '本轮已有Orbit8、C0ConservedObservable5、GibbsStationaryExpression12三批共25public通过正式验收。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalMeasure'
$r=Get-Content -LiteralPath "$base/full-check02/CHECK_REPORT.json" -Raw | ConvertFrom-Json
if($r.machine_check_status -ne 'passed' -or $r.exit_code -ne 0 -or $r.checks.Count -ne 10 -or @($r.checks | Where-Object exit_code -ne 0).Count -ne 0){throw 'Full02 incomplete or failed'}
if($r.inputs.Count -ne 268 -or $r.actual_mathlib_revision -cne '5ed2965256430c3649e86755f9576b54eca72435' -or $r.lean_version -notmatch 'version 4.34.0,'){throw 'Config/count mismatch'}
foreach($i in $r.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Input changed $($i.relative_path)"}}
foreach($c in $r.checks){if((Get-FileHash -LiteralPath "$base/full-check02/$($c.raw_log)").Hash.ToLowerInvariant() -cne $c.raw_log_sha256){throw "Raw changed $($c.raw_log)"}}
$warnings=@()
foreach($n in @('lake_build','scratch','axiom_dependencies')){
 $log=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/full-check02/$n.log"))
 $warnings+=@([regex]::Matches($log,'(?m)^.*warning:.*$') | ForEach-Object {$_.Value})
}
if($warnings.Count -gt 0){throw 'Lean warning found'}
$alog=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/full-check02/axiom_dependencies.log"))
$axiomRecords=[regex]::Matches($alog,"(?s)'([^']+)' depends on axioms:\s*\[([^\]]*)\]|'([^']+)' does not depend on any axioms")
if($axiomRecords.Count -ne 2681){throw "Audit declaration count $($axiomRecords.Count)"}
$all=@($axiomRecords | ForEach-Object {
 $name=if($_.Groups[1].Success){$_.Groups[1].Value}else{$_.Groups[3].Value}
 $axs=@(($_.Groups[2].Value -split ',') | ForEach-Object {$_.Trim()} | Where-Object {$_})
 if(@($axs | Where-Object {$_ -cnotin @('propext','Classical.choice','Quot.sound')}).Count -ne 0){throw "Nonstandard axioms in $name"}
 [ordered]@{name=$name;axioms=$axs}
})
$pub=@(Get-Content -LiteralPath "$base/PUBLIC_DECLARATIONS.json" -Raw | ConvertFrom-Json)
if($pub.Count -ne 14){throw 'Public count'}
$new=@(foreach($name in $pub){
 $found=@($all | Where-Object {$_.name -ceq $name})
 if($found.Count -ne 1){throw "Public audit count $name"}
 $found[0]
})
$btxt=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/full-check02/lake_build.log"))
if($btxt -notmatch 'Build completed successfully \((\d+) jobs\)'){throw 'Missing build jobs'}
$jobs=[int]$Matches[1];if($jobs -ne 9185){throw 'Job count mismatch'}
$flags=@'
{
  "actual_model": "original_unit_mass_6_47_smooth_periodic_potential_positive_beta_Nzero",
  "momentum_measure": "actual_pi_gaussianReal_zero_mean_variance_beta_inverse_probability",
  "gaussian_product_density": "derived_rectangle_uniqueness_real_Fubini_true_gaussianReal_integral_not_assumed",
  "full_phase_measure": "actual_configurational_torus_Gibbs_times_true_momentum_Gaussian_product",
  "full_normalization": "proved_true_probability_and_density_integral_one_no_target_normalization_premise",
  "original_Boltzmann_density": "same_periodic_exp_minus_beta_H_actual_partition_and_Gaussian_normalization_coefficient",
  "position_representative_compatibility": "derived_original_potential_periodicity_not_assumed_representative_continuity",
  "momentum_norm_square_integrable": "derived_actual_Gaussian_vector_L2_and_true_product_marginal_measure_preserving",
  "mass_matrix_scope": "unit_mass_original_Langevin6_47_only_general_mass_6_3_not_claimed",
  "original_PDF239_current_visual": "canonical6_3_partition_factorization_and_smooth_bounded_position_normalization_confirmed",
  "actual_probability_Gibbs_invariance": "not_proved",
  "weak_Gibbs_generator_balance": "not_proved",
  "functional_adjoint_domain_flux_integration_by_parts": "not_proved",
  "actual_joint_positive_time_density_existence": "not_proved",
  "graph_core": "not_proved",
  "weighted_H1_kernel_Proposition6_4": "not_proved",
  "responsible_semantic_review": "pending",
  "whole_theorem6_2": "incomplete",
  "core_scope": "incomplete",
  "internal_local_instance_names": "unique_named_true_instances_root_import_collision_repaired",
  "first_full_check": "failed_root_import_anonymous_internal_name_collision_preserved_raw",
  "final_local_check": "local04_all_14_private_empty_log_zero_warning"
}
'@ | ConvertFrom-Json -AsHashtable
$a=[ordered]@{started_at=$r.started_at;finished_at=$r.finished_at;head_at_check=$r.head;branch=$r.branch;jobs=$jobs;audit_declarations=$axiomRecords.Count;inputs=$r.inputs.Count;new_public_declarations=$pub;new_public_axiom_audit=$new;all_checks_exit_zero=$true;all_inputs_sha256_verified=$true;all_raw_logs_sha256_verified=$true;all_public_axioms_standard=$true;lean_warnings=0}
$a['local_logs']=@('FULL_DRIVER.log','FULL02_DRIVER.log','local01.log','local02.log','local03.log','local04.log') | ForEach-Object {[ordered]@{path=$_;sha256=(Get-FileHash -LiteralPath "$base/$_").Hash.ToLowerInvariant()}}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath "$base/ACCEPTANCE.json" -Encoding utf8
$local=Get-Content -LiteralPath "$base/LOCAL_CHECK.json" -Raw | ConvertFrom-Json -AsHashtable
$local['full_check']='passed_full_check02'
$local | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath "$base/LOCAL_CHECK.json" -Encoding utf8
$repair=Get-Content -LiteralPath "$base/INSTANCE_NAME_REPAIR.json" -Raw | ConvertFrom-Json -AsHashtable
$repair['full_check02']='passed_all_checks_zero_exact_input_hashes_standard_axioms'
$repair | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath "$base/INSTANCE_NAME_REPAIR.json" -Encoding utf8
$utf=[Text.UTF8Encoding]::new($false)

foreach($spec in @(@{path='docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv';id='CH06-DEP-150'},@{path='docs/NOTATION_INVENTORY.csv';id='NOT-CH06-159'})){
 $text=[IO.File]::ReadAllText((Join-Path (Get-Location) $spec.path))
 $pattern='(?m)^'+[regex]::Escape($spec.id)+',[^\r\n]*'
 $records=[regex]::Matches($text,$pattern)
 if($records.Count -ne 1){throw 'Own ledger identity mismatch'}
 $updated=$records[0].Value.Replace('local04_passed_full_check02_pending','actual_canonical_probability_density_moment_passed_full_check02_semantic_pending')
 $text=$text.Replace($records[0].Value,$updated)
 [IO.File]::WriteAllText((Join-Path (Get-Location) $spec.path),$text,$utf)
}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/reviews/2026-10-07-LangevinCanonicalMeasure/REVIEW.zh-CN.md'),[char]10+'full-check02通过：9185jobs/2681标准公理/268exactinputs/all10checks0/0Leanwarning/allinput及全部原rawlog SHA一致，新14public唯一标准axioms。实际Gauss pi momentum真实PDF/L²、qGibbs乘积fullphase真概率、原sameHamiltonian Boltzmann密度严格正可积积分1及真实p²矩。原PDF239/印刷218当前视觉核对6.3及真实partition分离，unitmass6.47模型范围明确，actualGibbsInv/weakbalance/functionaladjoint/graphcore/CORE未完。raw01–04和失败full01保留，不改resource/linter。'+[char]10,$utf)
foreach($path in @('FORMALIZATION_MAP.md','STATUS.md')){
 $text=[IO.File]::ReadAllText((Join-Path (Get-Location) $path))
 if($path -eq 'FORMALIZATION_MAP.md'){$text=$text.Replace('local03零warning exactfull01待验，actualtransitionGibbs不变性未证。','local04零warning及exact full02通过9185/2681/268，actualtransitionGibbs不变性未证。')}
 else{$text=$text.Replace('LangevinCanonicalMeasure14局部通过，唯一full01待验；','LangevinCanonicalMeasure14局部及full01通过9185/2681/268；')}
 [IO.File]::WriteAllText((Join-Path (Get-Location) $path),$text,$utf)
}
$allow=@('MolecularDynamics/Chapter06/LangevinCanonicalMeasure.lean','MolecularDynamicsFormalization.lean','Scratch.lean','scripts/CheckAxioms.lean','FORMALIZATION_MAP.md','ASSUMPTIONS.md','docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv','docs/NOTATION_INVENTORY.csv','docs/reviews/2026-10-07-LangevinCanonicalMeasure/REVIEW.zh-CN.md')
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
git commit -m 'Construct the original normalized canonical phase probability and density'
if($LASTEXITCODE -ne 0){throw 'Commit failed'}
$commit=(git rev-parse HEAD).Trim()
foreach($i in $r.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Postcommit input mismatch $($i.relative_path)"}}
if(@(git diff --name-only -- '*.lean').Count -ne 0){throw 'Tracked Lean diff after accepted commit'}

Save-LocalCheckpoint 'CanonicalMeasure14正式验收提交，继续真实fullpartition及normalized前向表达' "最新$commit；9185jobs/2681标准公理/268exactinputs/all10checks0/0Leanwarning/allrawlog/index/postcommit SHA，local04全14/private空log0。原β^-1 variance真实Gaussian pi probability/PDF/L²、qGibbs product fullphase真概率和wrapper、原Boltzmann密度严格正可积积分1以及真实p²矩已证。PDF239/印刷2186.3及partition分离当前视觉已核。actualGibbsInv/weakbalance/functionaladjoint域/graphcore/positive-time density/weightedH¹核及CORE未完。" '继续原fullpartition真实积分公式、posfinite、同normalized realdensity及physical classicalforward零；不把经典表达当actual概率不变性。'
Write-Output "Accepted $commit; 9185/2681/268 all 10 zero, 0 Lean warnings; exact raw logs preserved."
