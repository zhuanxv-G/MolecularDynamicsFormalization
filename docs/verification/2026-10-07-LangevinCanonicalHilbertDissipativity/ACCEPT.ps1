
function Save-LocalCheckpoint([string]$Title,[string]$Details,[string]$Next) {
 $stamp=[DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('yyyy-MM-dd HH:mm:ss zzz')
 $head=(git rev-parse HEAD).Trim()
 $branch=(git branch --show-current).Trim()
 $latest=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalHilbertDissipativity/ACCEPTANCE.json' -Raw | ConvertFrom-Json
 $lines=@(
 '# 当前可操作状态'
 "最后更新时间（Asia/Shanghai）：$stamp"
 '当前聊天01a10bc0-bc8d-7043-8df9-21a6b0bde09a；handoff ready/new_thread_id正确。'
 "工程C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization；branch $branch；HEAD $head。"
 '固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435，只本地。'
 "既有最新正式验收基线LangevinCanonicalHilbertDissipativity5：$head，$($latest.jobs)jobs/2772公理/279exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local03五声明空log0。sameactualcanonical 测试图/真实closure/closedoperator全域耗散；r>0真实移位范数下界及域单射已证；完整H1能量恒等式/移位满射/预解式/semigroupgenerator身份/core/κInv未证。"
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7、CanonicalHilbertGraph10、CanonicalHilbertClosed10、CanonicalHilbertDissipativity5十五批共130public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalHilbertDissipativity'
$r=Get-Content -LiteralPath "$base/full-check01/CHECK_REPORT.json" -Raw | ConvertFrom-Json
if($r.machine_check_status -ne 'passed' -or $r.exit_code -ne 0 -or $r.checks.Count -ne 10 -or @($r.checks | Where-Object exit_code -ne 0).Count -ne 0){throw 'Full01 incomplete or failed'}
if($r.inputs.Count -ne 279 -or $r.actual_mathlib_revision -cne '5ed2965256430c3649e86755f9576b54eca72435' -or $r.lean_version -notmatch 'version 4.34.0,'){throw 'Config/count mismatch'}
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
if($axiomRecords.Count -ne 2772){throw "Audit declaration count $($axiomRecords.Count)"}
$all=@($axiomRecords | ForEach-Object {
 $name=if($_.Groups[1].Success){$_.Groups[1].Value}else{$_.Groups[3].Value}
 $axs=@(($_.Groups[2].Value -split ',') | ForEach-Object {$_.Trim()} | Where-Object {$_})
 if(@($axs | Where-Object {$_ -cnotin @('propext','Classical.choice','Quot.sound')}).Count -ne 0){throw "Nonstandard axioms in $name"}
 [ordered]@{name=$name;axioms=$axs}
})
$pub=@(Get-Content -LiteralPath "$base/PUBLIC_DECLARATIONS.json" -Raw | ConvertFrom-Json)
if($pub.Count -ne 5){throw 'Public count'}
$new=@(foreach($name in $pub){
 $found=@($all | Where-Object {$_.name -ceq $name})
 if($found.Count -ne 1){throw "Public audit count $name"}
 $found[0]
})
$btxt=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/full-check01/lake_build.log"))
if($btxt -notmatch 'Build completed successfully \((\d+) jobs\)'){throw 'Missing build jobs'}
$jobs=[int]$Matches[1];if($jobs -lt 9196){throw 'Job count mismatch'}
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_same_canonical_measure_Nzero_true_sigma_squared_FD",
  "actual_test_graph_energy_nonpositive": "proved_from_original_canonical_energy_and_true_AE_L2_classes",
  "actual_graph_closure_pairing_nonpositive": "proved_by_continuity_on_true_smooth_test_graph_closure",
  "actual_closed_operator_dissipativity": "proved_on_every_element_of_true_closed_operator_domain",
  "positive_shift_norm_bound": "proved_norm_f_le_norm_r_f_minus_g_div_r_for_r_positive_on_true_graph_closure",
  "actual_closed_operator_positive_shift_injective": "proved_on_actual_domain_by_true_graph_difference_and_norm_bound",
  "gamma_beta_inverse_nonnegative": "derived_from_actual_sigma_squared_fluctuation_dissipation_identity",
  "no_extra_operator_domain_core_InvLaw_or_dissipativity_hypotheses": true,
  "full_graph_domain_energy_identity_or_weighted_H1_estimate": "not_proved",
  "positive_shift_surjectivity_or_resolvent_existence": "not_proved",
  "full_closed_Hilbert_adjoint_domain_characterization": "not_proved",
  "actual_L2_semigroup_generator_identification": "not_proved",
  "weighted_H1_derivative_closure": "not_proved",
  "actual_semigroup_generator_graph_core": "not_proved",
  "actual_probability_Gibbs_invariance": "not_proved",
  "forward_Poisson_compact_resolvent_Fredholm_Proposition6_4": "not_proved",
  "responsible_semantic_review": "pending",
  "whole_theorem6_2": "incomplete",
  "core_scope": "incomplete"
}' | ConvertFrom-Json -AsHashtable
$a=[ordered]@{started_at=$r.started_at;finished_at=$r.finished_at;head_at_check=$r.head;branch=$r.branch;jobs=$jobs;audit_declarations=$axiomRecords.Count;inputs=$r.inputs.Count;new_public_declarations=$pub;new_public_axiom_audit=$new;all_checks_exit_zero=$true;all_inputs_sha256_verified=$true;all_raw_logs_sha256_verified=$true;all_public_axioms_standard=$true;lean_warnings=0}
$a['local_logs']=@('FULL_DRIVER.log','local01.log','local02.log','local03.log') | ForEach-Object {[ordered]@{path=$_;sha256=(Get-FileHash -LiteralPath "$base/$_").Hash.ToLowerInvariant()}}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath "$base/ACCEPTANCE.json" -Encoding utf8
$local=Get-Content -LiteralPath "$base/LOCAL_CHECK.json" -Raw | ConvertFrom-Json -AsHashtable
$local['full_check']='passed_full_check01'
$local | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath "$base/LOCAL_CHECK.json" -Encoding utf8
$utf=[Text.UTF8Encoding]::new($false)



foreach($spec in @(@{path='docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv';id='CH06-DEP-161'},@{path='docs/NOTATION_INVENTORY.csv';id='NOT-CH06-170'})){
 $text=[IO.File]::ReadAllText((Join-Path (Get-Location) $spec.path))
 $records=[regex]::Matches($text,'(?m)^'+[regex]::Escape($spec.id)+',[^\r\n]*')
 if($records.Count -ne 1){throw 'Own ledger identity mismatch'}
 $newRow=$records[0].Value.Replace('local03_passed_full_check01_pending','true_canonical_Hilbert_dissipativity_and_positive_shift_injectivity_passed_full_check01_semantic_pending')
 $text=$text.Replace($records[0].Value,$newRow)
 [IO.File]::WriteAllText((Join-Path (Get-Location) $spec.path),$text,$utf)
}




[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/reviews/2026-10-07-LangevinCanonicalHilbertDissipativity/REVIEW.zh-CN.md'),[char]10+"full01通过：$jobs jobs/2772standardaxioms/279exactinputs/all10checks0/0Leanwarnings/allinput/rawSHA，新5public唯一标准公理。实际测试图、闭包及闭算子全域耗散，正移位范数下界和真实域单射已证。raw01–03按字节保留。完整H1能量恒等式、移位满射/预解式、actualL2semigroupgenerator身份/core/κInv/Prop6.4/CORE未证。"+[char]10,$utf)
foreach($path in @('FORMALIZATION_MAP.md','STATUS.md')){
 $text=[IO.File]::ReadAllText((Join-Path (Get-Location) $path))
 if($path -eq 'FORMALIZATION_MAP.md'){$text=$text.Replace('local03 clean；exactfull01待验。完整H1', "local03 clean及exactfull01通过$jobs/2772/279。完整H1")}
 else{$text=$text.Replace('LangevinCanonicalHilbertDissipativity5 local03通过，唯一full01待验；',"LangevinCanonicalHilbertDissipativity5 local03及唯一full01通过$jobs/2772/279；")}
 [IO.File]::WriteAllText((Join-Path (Get-Location) $path),$text,$utf)
}
$allow=@('MolecularDynamics/Chapter06/LangevinCanonicalHilbertDissipativity.lean','MolecularDynamicsFormalization.lean','Scratch.lean','scripts/CheckAxioms.lean','FORMALIZATION_MAP.md','ASSUMPTIONS.md','docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv','docs/NOTATION_INVENTORY.csv','docs/reviews/2026-10-07-LangevinCanonicalHilbertDissipativity/REVIEW.zh-CN.md')
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
git commit -m 'Prove canonical closed Hilbert dissipativity and positive shift injectivity'
if($LASTEXITCODE -ne 0){throw 'Commit failed'}
$commit=(git rev-parse HEAD).Trim()
foreach($i in $r.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Postcommit input mismatch $($i.relative_path)"}}
if(@(git diff --name-only -- '*.lean').Count -ne 0){throw 'Tracked Lean diff after accepted commit'}





Save-LocalCheckpoint 'CanonicalHilbertDissipativity5正式验收提交' "最新$commit；$jobs jobs/2772standardaxioms/279exactinputs/all10checks0/0Leanwarning/allinput/raw/index/postcommit SHA，local03五声明空log0。实际canonical能量导测试图非正，内积连续性扩到真实图closure及实际closedoperator全域耗散；Hilbert Cauchy–Schwarz导r>0真实移位范数下界，实际图差导正移位单射。未假设γ或耗散性，符号来自原FD。完整H1能量恒等式、移位满射/预解式、actualL2semigroupgenerator身份/core/κInv/Prop6.4/CORE未证。" '下一实际fullcanonical q坐标无p权IBP、坐标测试弱导数/其真实Hilbert图闭包；不假设H1闭域或完整Poisson。'
Write-Output "Accepted $commit; $jobs/2772/279 all 10 zero, 0 Lean warnings; raw logs exact."
