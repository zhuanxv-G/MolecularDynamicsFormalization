
function Save-LocalCheckpoint([string]$Title,[string]$Details,[string]$Next) {
 $stamp=[DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('yyyy-MM-dd HH:mm:ss zzz')
 $head=(git rev-parse HEAD).Trim()
 $branch=(git branch --show-current).Trim()
 $latest=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalKernelShift/ACCEPTANCE.json' -Raw | ConvertFrom-Json
 $lines=@(
 '# 当前可操作状态'
 "最后更新时间（Asia/Shanghai）：$stamp"
 '当前聊天01a10bc0-bc8d-7043-8df9-21a6b0bde09a；handoff ready/new_thread_id正确。'
 "工程C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization；branch $branch；HEAD $head。"
 '固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435，只本地。'
 "既有最新正式验收基线LangevinCanonicalKernelShift七声明：$head，$($latest.jobs)jobs/2866公理/288exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local03七声明空log0。真实phaseProjection add/shift∞compact/Dshift/alltime HasDeriv/reference shift measurePreserving/actualkernel任意real方向shiftedtest弱配对0已证；真实积分微分与配对平移不变/全kernel常数性/H1密度/actualgeneratorcore/κInv/Poisson未证。"
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7、CanonicalHilbertGraph10、CanonicalHilbertClosed10、CanonicalHilbertDissipativity5、CanonicalCoordinateWeakDerivative11、CanonicalWeakH1十五声明、CanonicalH1MeanZero十六声明、CanonicalCoordinateClosed十一声明、CanonicalMomentumClosedEnergy十三声明、CanonicalKernelTransport五声明、CanonicalKernelWeakH1八声明、CanonicalKernelUnweighted八声明、CanonicalKernelShift七声明二十四批共224public已正式验收；不代表整本教材完成。'
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
$source='MolecularDynamics/Chapter06/LangevinCanonicalKernelPairingShift.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local02.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local02.log")).Trim().Length -ne 0){throw 'Local02 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
$prior=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalKernelShift/full-check01/CHECK_REPORT.json' -Raw | ConvertFrom-Json
if($prior.machine_check_status -ne 'passed' -or $prior.inputs.Count -ne 288){throw 'Previous baseline not accepted'}
foreach($i in $prior.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Prior exact input changed $($i.relative_path)"}}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:abbrev|def|theorem|instance) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 6){throw 'Expected 6 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalKernelPairingShift'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
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
$local=[ordered]@{draft_path="$base/Draft.lean";source_path=$source;draft_sha256=$hash;source_sha256=$hash;local_check_log='local02.log';local_check_log_sha256=(Get-FileHash "$base/local02.log").Hash.ToLowerInvariant();local_exit_code=0;local_lean_warnings=0;local_log_empty=$true;exact_source_copy_verified=$true;public_declarations=$pub;integrated=$true;full_check='pending_full_check01'}
foreach($k in $flags.Keys){$local[$k]=$flags[$k]}
$local | ConvertTo-Json -Depth 10 | Set-Content "$base/LOCAL_CHECK.json" -Encoding utf8
$pdf='C:/Users/ustc/Desktop/formal math/Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf'
$pdfHash=(Get-FileHash $pdf).Hash.ToLowerInvariant()
if($pdfHash -cne '1939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036'){throw 'PDF changed'}
$ref='docs/verification/2026-10-07-LangevinCanonicalEnergy/ORIGINAL_PDF277_278.log'
$refHash=(Get-FileHash $ref).Hash.ToLowerInvariant()
if($refHash -cne '2e61d88b5f401a122ef2fce7f30e76cadfd7f4c0bda798eec882e0e3229dacac'){throw 'Original text changed'}
$png='docs/verification/2026-10-07-LangevinC0ConservedObservable/original-PDF278.png'
$pngHash=(Get-FileHash $png).Hash.ToLowerInvariant()
if($pngHash -cne 'c7c839b7ec2b02c7b52288a986d4bfa3bffa992bd0239ea07878b59e5d6d863c'){throw 'Prior visual changed'}
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_actual_dominated_pairing_curve_derivative_and_test_functional_shift_invariance';actual_kernel_pairing_shift_invariance_distinct_from_rough_kernel_AE_constancy_and_Poisson=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8










$claim='CH06-DEP-171,Proposition6.4_dependency,6.4.4,256-257,277-278,analytic_dependency,实际紧支撑支配积分微分及kernel测试配对平移不变,local02_passed_full_check01_pending,responsible_pending,unitmass_U_Cinfty_unitperiodic_beta_positive_gamma_positive_FD_Nzero_same_actual_mu,rough_kernel_AE_constancy_ActualInv_Prop6.4_CORE_pending,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_kernel_pairing_shift_invariant,module=MolecularDynamics/Chapter06/LangevinCanonicalKernelPairingShift.lean;6public;真实uniformcompactdominator和dominated积分微分导测试配对shiftinvariance'
$notation='NOT-CH06-180,Langevin_canonical_kernel_test_pairing_phase_shift,真实shift配对积分的支配微分和平移不变,256-257,277-278,Proposition6.4_kernel_constancy_pairing_shift_necessary_dependency,currentread277278_exactpriorraw_priorvisual278_hash,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_kernel_pairing_shift_invariant,MolecularDynamics/Chapter06/LangevinCanonicalKernelPairingShift.lean,responsible_pending,local02_passed_full_check01_pending,full-check01-LangevinCanonicalKernelPairingShift,6public;actualcompactregion;outside;actualdominator;truepairingHasDeriv0;testfunctionalshiftinvariance'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-171') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-180')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalKernelPairingShift / CH06-DEP-171 / NOT-CH06-180：6public。actual tsupport G和DG的union与实际timeinterval紧积，经真实phase shift连续image产生共同compact K；x不在K则所有intervaltimes shiftedG/DG=0。真实D∞compact给ofCompactSupport uniformnorm C，原canonical L2 f的reference LocallyIntegrable使indicator K乘normf乘C真正可积并pointwise支配所有shifted导数产品。真实F(t0)产品可积及F/Fderivative AEmeas、逐点curve HasDeriv与实际dominated integral theorem，结合原kernel每shifted全方向weak0，证明实际配对曲线所有time HasDerivAt0。任意phase a选真实real代表后沿line应用deriv0常数定理，得到所有smoothcompact G的测试泛函平移不变。local02 clean；exactfull01待验。roughkernel AE常数性、fullkernelidentity、H1normdensity、actualgeneratorcore/κInv/完整Prop6.4仍未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalKernelPairingShift：N0有效，原unit torus×real momentum及reference Haar×Leb；G lift∞和真实compact，v原realphase和t0任意real，β>0与U∞unitperiodic给原canonicalL2 f实际reference局部L1，不要求rhoinv全局有界。最终pairing原γ>0/FD及actualclosedLdomain/Af0。dominator真实constructedindicatorcompact×normf×Duniformnorm，实际F/Fderivative可测和F可积与pointwiseHasDeriv均已证明后应用积分微分。未假设配对平移不变或roughkernel常数性、H1core或actualInvLaw。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalKernelPairingShift 6public local02通过，唯一full01待验；真实compactdominator/dominated pairing HasDeriv0/testfunctional phase shiftinvariance；roughkernel AE常数性/Prop6.4/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalKernelPairingShift'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='六声明落实PDF278/printed257原核常数性证明的测试配对平移步骤，未直接宣称roughkernel AE常数。K是actual tsupport G及DG并集与真实t0±1紧时间区间的紧积，经(y-tshift)真实连续image所得，不是输入K或支配条件。x不在K且t在区间时，若shiftedG/DG非零即产生K真实image witness而矛盾。'
$reviewText+=[char]10+[char]10+'C由真正continuouscompact DG的ofCompactSupport uniformnorm产生，原canonicalL2 f已证reference Haar×Leb局部L1在真实compact K可积，因此bound=K.indicator(norm f * C)真正integrable而支配所有shifted导数产品。真实Gshiftcompact给F(t0)integrable；LocallyIntegrable AEmeas和真正continuousshift使F/Fderivative AEmeas；原realcurve真HasDeriv给逐点Fderivative，fixedmathlib dominated derivative theorem得到实际积分微分。原kernel allshifted全方向weak0使其真实积分导数0。任意a选原Π的realphase代表v，I(t)原积分曲线所有time HasDerivAt0，再真实deriv0const定理I1=I0得全phase测试泛函平移不变。未将微分换积分/不变性/常数性藏入假设，也未假设canonicalprobability平移保持。'
$reviewText+=[char]10+[char]10+'local01共同compact/outside及微分框架编译，但BoundedContinuousFunction.ofCompactSupport实际是全局ofCompactSupport且scopednotation未开、F需要显式展开以化简mulcomm、Π0需要真逐坐标证明。local02真实constructor与显式类型/F/Π0修复后六public/private clean emptylog0，raw01–02完整保留。无资源/透明性/linter选项。roughkernel AE常数与完整核identity、H1normdensity、actualgeneratorcore/κInv、Poisson/Prop6.4/CORE仍未证，负责人semantic pending。原277278核对复用exacttext/priorvisual278，无newrender。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalKernelPairingShift六声明local02 clean，唯一full01中' 'actualuniformcompact K和outside、constructed genuineintegrable dominator、原pairing曲线dominated HasDerivAt0和测试泛函phase平移不变local02全部空log0。DEP171/NOT180/289formalinputs冻结；roughkernel AE常数性未证，raw01–02保留。' '等唯一full01 9206jobs/2872standardaxioms/289inputs/all10zero/0warning/allSHA，自身allowlist验收；下一真正testfunctional不变⇒roughkernel AE常数性或推进独立正文目标。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
