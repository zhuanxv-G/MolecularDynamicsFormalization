
function Save-LocalCheckpoint([string]$Title,[string]$Details,[string]$Next) {
 $stamp=[DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('yyyy-MM-dd HH:mm:ss zzz')
 $head=(git rev-parse HEAD).Trim()
 $branch=(git branch --show-current).Trim()
 $latest=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalCoordinateWeakDerivative/ACCEPTANCE.json' -Raw | ConvertFrom-Json
 $lines=@(
 '# 当前可操作状态'
 "最后更新时间（Asia/Shanghai）：$stamp"
 '当前聊天01a10bc0-bc8d-7043-8df9-21a6b0bde09a；handoff ready/new_thread_id正确。'
 "工程C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization；branch $branch；HEAD $head。"
 '固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435，只本地。'
 "既有最新正式验收基线LangevinCanonicalCoordinateWeakDerivative11：$head，$($latest.jobs)jobs/2783公理/280exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local01十一声明首次空log0。sameactualcanonical q/p联合IBP、实际weighted transpose、同µL2像、actualcoordinateGraph domainDense及真实closurepairing导zerovertical可闭性；完整H1空间/范数密度/semigroupgenerator身份/core/κInv未证。"
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7、CanonicalHilbertGraph10、CanonicalHilbertClosed10、CanonicalHilbertDissipativity5、CanonicalCoordinateWeakDerivative11十六批共141public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalWeakH1'
$source='MolecularDynamics/Chapter06/LangevinCanonicalWeakH1.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local02.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local02.log")).Trim().Length -ne 0){throw 'Local02 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:abbrev|def|theorem|instance) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 15){throw 'Expected 10 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalWeakH1'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_same_canonical_measure_Nzero_coordinate_weak_derivatives",
  "actual_H1_jet": "finite_PiLp_two_of_original_function_and_all_true_q_p_coordinate_L2_classes",
  "actual_weighted_H1_definition": "all_same_measure_coordinate_weak_test_equations_for_actual_original_IBP_transpose",
  "actual_weak_H1_graph_linear": "proved_actual_submodule_by_true_pairing_linearity",
  "actual_weak_H1_graph_closed": "proved_intersection_of_continuous_actual_test_pairing_equalities",
  "actual_weak_derivative_uniqueness": "proved_zero_value_implies_zero_jet_using_actual_L2_dense_smooth_tests",
  "actual_weak_H1_complete_Hilbert_space": "constructed_as_true_closed_submodule_of_finite_real_Hilbert_L2_product",
  "actual_function_projection": "continuous_linear_and_injective_by_proved_weak_derivative_uniqueness",
  "actual_coordinate_derivative_maps": "continuous_linear_maps_into_same_original_canonical_L2",
  "actual_H1_norm_square": "proved_exact_function_plus_q_gradient_plus_p_gradient_L2_square_sum",
  "actual_compact_smooth_H1_membership": "proved_from_actual_same_measure_coordinate_IBP_graph_pairings",
  "actual_smooth_H1_function_and_derivative_representatives": "proved_original_F_and_true_DjF_AE_classes",
  "actual_smooth_H1_norm_square_integrals": "proved_original_integral_F_squared_plus_all_q_and_p_derivative_squared_integrals",
  "no_extra_H1_closedness_completeness_or_smooth_membership_hypotheses": true,
  "H1_characterization_against_other_implementations": "not_proved",
  "weighted_H1_norm_smooth_density": "not_proved",
  "full_closed_Hilbert_operator_H1_energy_or_kernel_characterization": "not_proved",
  "full_closed_Hilbert_adjoint_domain_characterization": "not_proved",
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_original_weighted_H1_actual_weak_space_complete_Hilbert_exact_norm_and_true_smooth_membership_necessary_definition';actual_weighted_H1_construction_distinct_from_H1_smooth_norm_density_or_Poisson_solvability=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8







$claim='CH06-DEP-163,Proposition6.4_dependency,6.4.4,256-257,277-278,definition_dependency,按真实canonical坐标弱测试定义的完整Hilbert H1空间及确切原范数,local02_passed_full_check01_pending,responsible_pending,unitmass_U_Cinfty_unitperiodic_beta_positive_Nzero_same_actual_mu,H1_norm_density_operator_H1_energy_kernel_SemigroupGeneratorIdentity_GraphCore_ActualInv_Prop6.4_CORE_pending,MolecularDynamics.textbookLangevinCanonicalWeakH1SmoothTest_norm_sq,module=MolecularDynamics/Chapter06/LangevinCanonicalWeakH1.lean;15声明含2abbrev与CompleteSpace instance;闭图导数唯一和真实smooth membership已证'
$notation='NOT-CH06-172,Langevin_canonical_weighted_H1,原canonical加权H1函数与q和p弱梯度平方和Hilbert范数,256-257,277-278,Proposition6.4_original_H1_necessary_definition,currentread277278_exactpriorraw_priorvisual278_hash,MolecularDynamics.textbookLangevinCanonicalWeakH1SmoothTest_norm_sq,MolecularDynamics/Chapter06/LangevinCanonicalWeakH1.lean,responsible_pending,local02_passed_full_check01_pending,full-check01-LangevinCanonicalWeakH1,15声明;实际IBP弱测试闭图;H1范数光滑密度和Poisson尚未证'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-163') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-172')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalWeakH1 / CH06-DEP-163 / NOT-CH06-172：15声明（2abbrev、CompleteSpace instance及定义/定理）。同原canonical µ的函数与全部q/p坐标导数类置于finite PiLp2，按每个原compact∞test的真实IBP转置配对定义weakH1Graph Submodule；配对连续性证明图closed，同µactual smooth L2密度导zeroValue=zeroJet/弱导数唯一。闭Hilbert乘积图构成CompleteSpace，函数及各坐标导数是实际CLM，函数投影injective。norm²严格等于原函数/q梯度/p梯度L2平方和；actualcompact∞F的H1 membership从已证真实coordinate pairing导出，并证明原F与DjF AE类和原积分norm。local02 clean；exactfull01待验。H1范数光滑密度、其他H1实现等价、closedL H1能量/完整kernel/core/GibbsInv/Prop6.4未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalWeakH1：同一原canonical µ，N允许0，unitmass、U∞且unitperiodic、β>0，不需γ/σ/FD。H1定义用实际函数L2类与坐标弱导数L2类满足原canonical IBP的所有真实compact∞测试配对；配对是弱导数的定义，不是Poisson/closedL/core结论。weak图closed、导数唯一、CompleteSpace、函数投影injective和原平方和范数均从实际连续测试与L2密度证明，没有假设这些性质；compact∞F真实属于此空间由已证IBP推出，不把membership藏为假设。与其他Sobolev实现的等价、H1范数下smooth密度及closedL H1能量/kernel/Poisson未完。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalWeakH1十五声明 local02通过，唯一full01待验；实际weak H1闭Hilbert空间、唯一导数与原平方和范数及真实compact∞测试membership，H1范数密度/closedL H1核/Prop6.4/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalWeakH1'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='十五公开声明（含两个类型abbrev与命名CompleteSpace instance）落实原PDF277/printed256、278/printed257 H1必要定义。Jet在同原canonical L2的finite PiLp2中以none记录函数类、some(q/p)记录坐标导数类，避免使用sup范数代替教材的平方和范数。actual weakH1Graph要求每个真实compact∞测试满足已证原weighted坐标IBP的转置配对；这是弱坐标导数定义，不是把目标closedL/Poisson性质写入假设。'
$reviewText+=[char]10+[char]10+'配对真实线性给Submodule，连续实际L2配对的任意交证明图closed。同µactualsmoothcompact L2密度说明函数类为0时全部导数类为0，弱导数真正唯一；闭有限Hilbert乘积图由此构成complete Hilbert H1空间，函数与每坐标导数为实际CLM，函数投影injective。PiLp2 norm²分解Option/Sum两个有限指标严格给原函数/q梯度/p梯度三项L2平方和。实际compact∞F的测试jet用真实F与DjF同µtoLp类构造，membership由上一批actualcoordinategraph配对导出，没有假设H1 membership；函数值、导数AE及原∫F²和各∫DjF²的norm公式已证。'
$reviewText+=[char]10+[char]10+'没有证明H1范数下smooth密度，未与其他Sobolev实现作域等价；未把minimal smooth graph closure偷换为整个weak域。closedL全部H1能量、核/全adjoint域、actualsemigroupgenerator身份/core、κGibbsInv、完整Poisson/Fredholm/Prop6.4/CORE仍未证，负责人语义签核pending。local01闭性/唯一性/CompleteSpace/CLM/范数已处理，但smooth membership内F连续性_未能推断，改显式已证weakH1_F_continuous；弃用Set.setOf_forall改固定Set.ofPred_forall。local02全部十五/public与private空log0，无资源/透明性/linter选项或数学假设变动。raw01–02按字节保留。原277278已读，复用同SHA原文本与既有visual278，无新render。冻结正式源码后唯一full01。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalWeakH1十五声明 local02 clean，唯一full01中' '实际canonical weak坐标测试Jet/真Submodule、closed图、actualL2density导弱导数唯一/函数投影injective、truecompleteHilbert H1与原函数/q/p平方和norm，真实compact∞test membership/F和DjF AE及原积分norm十五声明。local02空log0，DEP163/NOT172/281formalinputs冻结。H1范数光滑密度、closedL H1能量/完整kernel、actualsemigroupgeneratorcore/κInv/Prop6.4未证。' '等唯一full01实际jobs/2798standardaxioms/281inputs/all10zero/0Leanwarning/allSHA后allowlist验收；接续原H1常数与canonical mean-zero条件的真实实现。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
