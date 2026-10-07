
function Save-LocalCheckpoint([string]$Title,[string]$Details,[string]$Next) {
 $stamp=[DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('yyyy-MM-dd HH:mm:ss zzz')
 $head=(git rev-parse HEAD).Trim()
 $branch=(git branch --show-current).Trim()
 $latest=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalKernelPairingShift/ACCEPTANCE.json' -Raw | ConvertFrom-Json
 $lines=@(
 '# 当前可操作状态'
 "最后更新时间（Asia/Shanghai）：$stamp"
 '当前聊天01a10bc0-bc8d-7043-8df9-21a6b0bde09a；handoff ready/new_thread_id正确。'
 "工程C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization；branch $branch；HEAD $head。"
 '固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435，只本地。'
 "既有最新正式验收基线LangevinCanonicalKernelPairingShift六声明：$head，$($latest.jobs)jobs/2872公理/289exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local02六声明空log0。真实共同compact支撑、constructed integrabledominator、原pairing曲线dominated HasDerivAt0及所有smoothcompact测试泛函phase shiftinvariance已证；roughkernel AE常数/完整kernelidentity/H1密度/actualgeneratorcore/κInv/Poisson未证。"
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7、CanonicalHilbertGraph10、CanonicalHilbertClosed10、CanonicalHilbertDissipativity5、CanonicalCoordinateWeakDerivative11、CanonicalWeakH1十五声明、CanonicalH1MeanZero十六声明、CanonicalCoordinateClosed十一声明、CanonicalMomentumClosedEnergy十三声明、CanonicalKernelTransport五声明、CanonicalKernelWeakH1八声明、CanonicalKernelUnweighted八声明、CanonicalKernelShift七声明、CanonicalKernelPairingShift六声明二十五批共230public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalKernelPairingShift'
$r=Get-Content -LiteralPath "$base/full-check01/CHECK_REPORT.json" -Raw | ConvertFrom-Json
if($r.machine_check_status -ne 'passed' -or $r.exit_code -ne 0 -or $r.checks.Count -ne 10 -or @($r.checks | Where-Object exit_code -ne 0).Count -ne 0){throw 'Full01 incomplete or failed'}
if($r.inputs.Count -ne 289 -or $r.actual_mathlib_revision -cne '5ed2965256430c3649e86755f9576b54eca72435' -or $r.lean_version -notmatch 'version 4.34.0,'){throw 'Config/count mismatch'}
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
if($axiomRecords.Count -ne 2872){throw "Audit declaration count $($axiomRecords.Count)"}
$all=@($axiomRecords | ForEach-Object {
 $name=if($_.Groups[1].Success){$_.Groups[1].Value}else{$_.Groups[3].Value}
 $axs=@(($_.Groups[2].Value -split ',') | ForEach-Object {$_.Trim()} | Where-Object {$_})
 if(@($axs | Where-Object {$_ -cnotin @('propext','Classical.choice','Quot.sound')}).Count -ne 0){throw "Nonstandard axioms in $name"}
 [ordered]@{name=$name;axioms=$axs}
})
$pub=@(Get-Content -LiteralPath "$base/PUBLIC_DECLARATIONS.json" -Raw | ConvertFrom-Json)
if($pub.Count -ne 6){throw 'Public count'}
$new=@(foreach($name in $pub){
 $found=@($all | Where-Object {$_.name -ceq $name})
 if($found.Count -ne 1){throw "Public audit count $name"}
 $found[0]
})
$btxt=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/full-check01/lake_build.log"))
if($btxt -notmatch 'Build completed successfully \((\d+) jobs\)'){throw 'Missing build jobs'}
$jobs=[int]$Matches[1];if($jobs -lt 9206){throw 'Job count mismatch'}
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_gamma_strictly_positive_FD_same_canonical_measure_Nzero",
  "actual_uniform_shift_test_and_directional_support_region": "proved_true_compact_image_of_original_support_union_times_real_interval",
  "actual_reference_L2_test_shift_derivative_dominator": "proved_actual_f_locally_L1_indicator_compact_times_true_test_uniform_norm",
  "actual_pairing_curve_hasDerivAt_zero": "proved_genuine_dominated_integral_derivative_from_actual_all_direction_weak_testing",
  "actual_kernel_smooth_compact_test_functional_phase_shift_invariance": "proved_actual_zero_derivatives_of_pairing_curves_all_real_times",
  "no_assumed_pairing_shift_invariance_integral_differentiability_kernel_constancy_or_invLaw": true,
  "weak_zero_gradient_implies_actual_canonical_constant": "not_proved",
  "full_closed_L_kernel_constancy": "not_proved",
  "weighted_H1_norm_smooth_density": "not_proved",
  "actual_L2_semigroup_generator_identification": "not_proved",
  "actual_semigroup_generator_graph_core": "not_proved",
  "actual_probability_Gibbs_invariance": "not_proved",
  "forward_Poisson_compact_resolvent_Fredholm_Proposition6_4": "not_proved",
  "responsible_semantic_review": "pending",
  "whole_theorem6_2": "incomplete",
  "core_scope": "incomplete"
}' | ConvertFrom-Json -AsHashtable
$a=[ordered]@{started_at=$r.started_at;finished_at=$r.finished_at;head_at_check=$r.head;branch=$r.branch;jobs=$jobs;audit_declarations=$axiomRecords.Count;inputs=$r.inputs.Count;new_public_declarations=$pub;new_public_axiom_audit=$new;all_checks_exit_zero=$true;all_inputs_sha256_verified=$true;all_raw_logs_sha256_verified=$true;all_public_axioms_standard=$true;lean_warnings=0}
$a['local_logs']=@('FULL_DRIVER.log','local01.log','local02.log') | ForEach-Object {[ordered]@{path=$_;sha256=(Get-FileHash -LiteralPath "$base/$_").Hash.ToLowerInvariant()}}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath "$base/ACCEPTANCE.json" -Encoding utf8
$local=Get-Content -LiteralPath "$base/LOCAL_CHECK.json" -Raw | ConvertFrom-Json -AsHashtable
$local['full_check']='passed_full_check01'
$local | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath "$base/LOCAL_CHECK.json" -Encoding utf8
$utf=[Text.UTF8Encoding]::new($false)



foreach($spec in @(@{path='docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv';id='CH06-DEP-171'},@{path='docs/NOTATION_INVENTORY.csv';id='NOT-CH06-180'})){
 $text=[IO.File]::ReadAllText((Join-Path (Get-Location) $spec.path))
 $records=[regex]::Matches($text,'(?m)^'+[regex]::Escape($spec.id)+',[^\r\n]*')
 if($records.Count -ne 1){throw 'Own ledger identity mismatch'}
 $newRow=$records[0].Value.Replace('local02_passed_full_check01_pending','true_canonical_actual_kernel_pairing_dominated_derivative_and_test_shift_invariance_passed_full_check01_semantic_pending')
 $text=$text.Replace($records[0].Value,$newRow)
 [IO.File]::WriteAllText((Join-Path (Get-Location) $spec.path),$text,$utf)
}









[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/reviews/2026-10-07-LangevinCanonicalKernelPairingShift/REVIEW.zh-CN.md'),[char]10+"full01通过：$jobs jobs/2872standardaxioms/289exactinputs/all10checks0/0Leanwarnings/allinput/rawSHA，新6public唯一标准公理。actualuniformcompact K/outside与constructed integrabledominator、原pairing积分曲线dominated HasDerivAt0和所有smoothcompact测试泛函phase shiftinvariance已证。raw01–02保留；roughkernel AE常数/fullkernelidentity/H1normdensity/actualgeneratorcore/κInv/Poisson/完整Prop6.4/CORE未证。"+[char]10,$utf)
foreach($path in @('FORMALIZATION_MAP.md','STATUS.md')){
 $text=[IO.File]::ReadAllText((Join-Path (Get-Location) $path))
 if($path -eq 'FORMALIZATION_MAP.md'){$text=$text.Replace('local02 clean；exactfull01待验。roughkernel AE常数性', "local02 clean及exactfull01通过$jobs/2872/289。roughkernel AE常数性")}
 else{$text=$text.Replace('LangevinCanonicalKernelPairingShift 6public local02通过，唯一full01待验；',"LangevinCanonicalKernelPairingShift 6public local02及唯一full01通过$jobs/2872/289；")}
 [IO.File]::WriteAllText((Join-Path (Get-Location) $path),$text,$utf)
}
$allow=@('MolecularDynamics/Chapter06/LangevinCanonicalKernelPairingShift.lean','MolecularDynamicsFormalization.lean','Scratch.lean','scripts/CheckAxioms.lean','FORMALIZATION_MAP.md','ASSUMPTIONS.md','docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv','docs/NOTATION_INVENTORY.csv','docs/reviews/2026-10-07-LangevinCanonicalKernelPairingShift/REVIEW.zh-CN.md')
$evidence=@(Get-ChildItem -LiteralPath $base -File -Recurse | Where-Object {$_.Extension -in @('.json','.log','.png','.ps1')} | ForEach-Object {[IO.Path]::GetRelativePath((Get-Location).Path,$_.FullName).Replace('\','/')})
$allow+= $evidence
$staged=@(git diff --cached --name-only)
if($LASTEXITCODE -ne 0 -or @($staged | Where-Object {$_ -notin $allow}).Count -ne 0){throw 'Staged changes outside own batch; do not mix'}
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
git commit -m 'Derive genuine dominated kernel pairing derivative and phase shift invariance'
if($LASTEXITCODE -ne 0){throw 'Commit failed'}
$commit=(git rev-parse HEAD).Trim()
foreach($i in $r.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Postcommit input mismatch $($i.relative_path)"}}
if(@(git diff --name-only -- '*.lean').Count -ne 0){throw 'Tracked Lean diff after accepted commit'}







Save-LocalCheckpoint 'CanonicalKernelPairingShift六声明正式验收提交' "最新$commit；$jobs jobs/2872standardaxioms/289exactinputs/all10checks0/0Leanwarning/allinput/raw/index/postcommit SHA，local02六声明空log0。原tsupport union/timecompact连续image为真K，actualreference LocallyIntegrable f和trueDuniformnorm构造integrabledominator，实际F/Fderivative AEmeas和F可积/逐点HasDeriv后dominated积分HasDerivAt0；每smoothcompact测试配对真phase shiftinvariance已证。roughkernel AE常数/完整kernelidentity/H1density/actualgeneratorcore/κInv/Prop6.4/CORE仍未证。" '下一实际smoothapprox统一compact支撑和reference integral连续极限，extend测试泛函到continuouscompact，再导真实roughkernel AE平移及常数性；独立正文任务可继续。'
Write-Output "Accepted $commit; $jobs/2872/289 all 10 zero, 0 Lean warnings; raw logs exact."
