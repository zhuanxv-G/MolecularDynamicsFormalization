
function Save-LocalCheckpoint([string]$Title,[string]$Details,[string]$Next) {
 $stamp=[DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('yyyy-MM-dd HH:mm:ss zzz')
 $head=(git rev-parse HEAD).Trim()
 $branch=(git branch --show-current).Trim()
 $latest=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalKernelUnweighted/ACCEPTANCE.json' -Raw | ConvertFrom-Json
 $lines=@(
 '# 当前可操作状态'
 "最后更新时间（Asia/Shanghai）：$stamp"
 '当前聊天01a10bc0-bc8d-7043-8df9-21a6b0bde09a；handoff ready/new_thread_id正确。'
 "工程C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization；branch $branch；HEAD $head。"
 '固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435，只本地。'
 "既有最新正式验收基线LangevinCanonicalKernelUnweighted八声明：$head，$($latest.jobs)jobs/2859公理/287exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local05八声明空log0。真实density/reciprocal∞和coordinate求导、literal去权重transpose、原canonicalL2 reference局部可积/fDG可积及actualkernel Haar×Leb ordinaryweak测试0已证；ordinaryweak0至constants/全kernel常数性/H1密度/actualgeneratorcore/κInv/Poisson未证。"
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7、CanonicalHilbertGraph10、CanonicalHilbertClosed10、CanonicalHilbertDissipativity5、CanonicalCoordinateWeakDerivative11、CanonicalWeakH1十五声明、CanonicalH1MeanZero十六声明、CanonicalCoordinateClosed十一声明、CanonicalMomentumClosedEnergy十三声明、CanonicalKernelTransport五声明、CanonicalKernelWeakH1八声明、CanonicalKernelUnweighted八声明二十三批共217public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalKernelShift'
$source='MolecularDynamics/Chapter06/LangevinCanonicalKernelShift.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local03.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local03.log")).Trim().Length -ne 0){throw 'Local03 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
$prior=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalKernelUnweighted/full-check01/CHECK_REPORT.json' -Raw | ConvertFrom-Json
if($prior.machine_check_status -ne 'passed' -or $prior.inputs.Count -ne 287){throw 'Previous baseline not accepted'}
foreach($i in $prior.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Prior exact input changed $($i.relative_path)"}}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:abbrev|def|theorem|instance) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 7){throw 'Expected 7 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalKernelShift'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_gamma_strictly_positive_FD_same_canonical_measure_Nzero",
  "actual_periodic_projection_add": "proved_literal_real_to_unit_torus_phase_projection",
  "actual_shifted_smooth_test_lift": "proved_actual_real_translation_and_smooth_composition",
  "actual_shifted_test_compact_support": "proved_actual_phase_translation_homeomorphism",
  "actual_directional_derivative_shift": "proved_fixed_fderiv_comp_add_right_of_true_real_lifts",
  "actual_phase_shift_curve_hasDerivAt": "proved_all_real_times_and_real_phase_directions",
  "actual_reference_Haar_times_Lebesgue_shift_measurePreserving": "proved_actual_product_translation_preservation",
  "actual_closed_L_kernel_shifted_test_all_direction_testing": "proved_true_finite_coordinate_basis_actual_integrable_products_and_original_kernel_weak_testing",
  "actual_pairing_curve_integral_differentiability_and_shift_invariance": "not_proved",
  "no_kernel_pairing_shift_invariance_constancy_or_canonical_probability_shift_hypotheses": true,
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
$local=[ordered]@{draft_path="$base/Draft.lean";source_path=$source;draft_sha256=$hash;source_sha256=$hash;local_check_log='local03.log';local_check_log_sha256=(Get-FileHash "$base/local03.log").Hash.ToLowerInvariant();local_exit_code=0;local_lean_warnings=0;local_log_empty=$true;exact_source_copy_verified=$true;public_declarations=$pub;integrated=$true;full_check='pending_full_check01'}
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_actual_phase_shifted_test_calculus_reference_preservation_kernel_direction_testing';actual_kernel_true_shifted_tests_distinct_from_integral_differentiability_pairing_invariance_full_constancy_or_Poisson=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8









$claim='CH06-DEP-170,Proposition6.4_dependency,6.4.4,256-257,277-278,analytic_dependency,真实phase平移测试微分reference保持及kernel任意方向弱测试,local03_passed_full_check01_pending,responsible_pending,unitmass_U_Cinfty_unitperiodic_beta_positive_gamma_positive_FD_Nzero_same_actual_mu,pairing_dominated_integral_derivative_shift_invariance_full_kernel_constancy_ActualInv_Prop6.4_CORE_pending,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_kernel_unweighted_shift_direction_testing,module=MolecularDynamics/Chapter06/LangevinCanonicalKernelShift.lean;7public;真实phasequotient加法与shift微分及kernel移位测试全方向0'
$notation='NOT-CH06-179,Langevin_canonical_kernel_phase_shift_testing,原phase平移的真实微分和reference测度保持,256-257,277-278,Proposition6.4_kernel_constancy_shift_testing_necessary_dependency,currentread277278_exactpriorraw_priorvisual278_hash,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_kernel_unweighted_shift_direction_testing,MolecularDynamics/Chapter06/LangevinCanonicalKernelShift.lean,responsible_pending,local03_passed_full_check01_pending,full-check01-LangevinCanonicalKernelShift,7public;Projection_add;shift∞compact;Dshift;truecurveHasDeriv;referencepreserving;actualkernelshifted任意real方向弱配对0'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-170') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-179')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalKernelShift / CH06-DEP-170 / NOT-CH06-179：7public。真实Π保add，把phase shift test的real lift转为真实realtranslation，故∞与compact支撑分别从smooth composition/homeomorphism导出；fixedfderiv_comp_add_right给Dshift，真实liftFrechet与原timecurvechainrule给所有real time HasDerivAt。真正referenceHaar×Leb以两个实际coordinate measurePreserving的product证明phase平移保持。实际fderivCLM的完整q/p有限basis分解、逐项真正reference产品integrable与已证actualkernel weakcoord测试0，导每真实phase shifted test在每real phase direction弱配对0。local03 clean；exactfull01待验。尚未证明积分换微分/domination或实际pairing shift invariance；roughkernel常数性/H1normdensity/actualgeneratorcore/κInv/完整Prop6.4仍未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalKernelShift：N0有效、真实phase=unit torus×real momentum，前六纯test/reference公式不要求canonicalprobability保持平移；smooth/curve有原G lift∞，compact有真实HasCompactSupport，reference是实际Haar×Leb。末kernel测试原samecanonicalµ、U∞unitperiodic、β>0、γ>0/FD、actualclosedLdomain/Af=0；真实q/p积分产品可积和有限方向basis保证积分有限和合法。没有假设integralcurve differentiability、pairing平移不变、roughkernel常数性、H1core、actualsemigroupgenerator或InvLaw。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalKernelShift 7public local03通过，唯一full01待验；真实shift test∞compact/Dshift/curve/referencepreserving及kernel任意方向shifted弱配对0，积分微分及配对平移不变/常数性/Prop6.4/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalKernelShift'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='七声明是PDF278/printed257原核常数性测试平移步骤。真实Π从realphase至unit-torusphase保add；选真实phase代表只用于证明shift realLift等于realtranslate，不对代表函数求微分。shift∞从true smoothrealLift composition，compact从actual Homeomorph.addRight。fixedfderiv_comp_add_right无前提光滑即可真Dshift。任意time曲线G(x+Π(tv))的真HasDeriv从原lift Frechet与realstraightlinechainrule得到。referenceHaar×Leb真正coordinate平移preserving的product给phase平移preserving，并非canonical概率平移保持。'
$reviewText+=[char]10+[char]10+'actualkernel对shiftedcompact∞G在任意real v的普通weak配对0，由真正CLM全部q/pbasis有限分解，既有原canonicalL2 f与每reference DG产品真正可积及coordinate弱测试0，允许原积分合法拆有限和。使用之前实际q/pweak已证结果，没有要求fullH1core或roughkernel常数。积分曲线换微分需要uniformcompact支撑的integrable dominator，本批未假设或证明它，测试配对平移不变及常数性仍独立未证。'
$reviewText+=[char]10+[char]10+'local01仅Projection_add AddCircle类型参数两个_未推断；其余六public与private证明编译。local02显式real坐标后发现period首参数仍需给1；local03补实际period1后7public/private clean emptylog0，raw01–03保留，无资源/透明性/linter选项。pairing dominated integralderivative/shiftinvariance、fullkernelconstancy、H1normdensity、actualgeneratorcore/κInv、Poisson/Prop6.4/CORE未证，负责人semantic pending。原277278复读复用exactraw/priorvisual278，无newrender。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalKernelShift 7public local03 clean，唯一full01中' 'actualProjection add、shift∞compact/真实Dshift/alltimecurve HasDeriv、referenceHaar×Leb平移preserving及actualkernel任意real方向shiftedtest弱配对0。真实有限basis和reference积分产品integrable；未假设实际配对平移不变或常数性。local03空log0，DEP170/NOT179/288formalinputs冻结，raw01–03保留。' '等唯一full01 actualjobs/2866standardaxioms/288inputs/all10zero/0Leanwarning/allSHA后自身allowlist验收；下一实际uniformcompacttest支撑/导数界与reference局部L1产生dominator，真正积分微分后测试配对平移不变。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
