
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
$base='docs/verification/2026-10-07-LangevinCanonicalCoordinateWeakDerivative'
$source='MolecularDynamics/Chapter06/LangevinCanonicalCoordinateWeakDerivative.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local01.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local01.log")).Trim().Length -ne 0){throw 'Local01 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:def|theorem) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 11){throw 'Expected 10 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalCoordinateWeakDerivative'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_same_canonical_measure_Nzero_coordinates_independent_of_gamma_sigma",
  "actual_coordinate_directions": "original_q_and_p_coordinate_directions_on_true_periodic_real_lift",
  "actual_coordinate_log_weight_slopes": "beta_Dq_U_and_beta_p_for_same_original_canonical_weight",
  "actual_full_phase_unweighted_position_IBP": "proved_by_true_configurational_Gibbs_slices_and_joint_Fubini_without_p_division",
  "actual_q_p_coordinate_IBP": "proved_by_original_q_and_Gaussian_p_joint_IBP",
  "actual_coordinate_weighted_transpose_pairing": "proved_by_true_product_derivative_and_actual_joint_IBP",
  "actual_coordinate_transpose_test_L2": "proved_continuous_compact_expression_in_same_canonical_Hilbert_space",
  "actual_coordinate_test_graph": "defined_using_true_F_DjF_AE_representatives_on_same_canonical_mu",
  "actual_coordinate_test_domain_dense": "proved_using_true_same_measure_smooth_compact_L2_density",
  "actual_coordinate_graph_closure_pairing": "proved_by_continuity_of_true_Hilbert_pairings",
  "actual_coordinate_graph_zero_vertical": "proved_by_actual_dense_smooth_tests",
  "actual_coordinate_derivative_closability": "proved_on_genuine_original_test_graph_not_assumed_as_Sobolev_domain",
  "no_extra_derivative_domain_core_InvLaw_or_closability_hypotheses": true,
  "full_weighted_H1_space_or_domain_characterization": "not_constructed_or_proved",
  "weighted_H1_norm_smooth_density": "not_proved",
  "full_closed_Hilbert_adjoint_domain_characterization": "not_proved",
  "actual_L2_semigroup_generator_identification": "not_proved",
  "actual_semigroup_generator_graph_core": "not_proved",
  "actual_probability_Gibbs_invariance": "not_proved",
  "forward_Poisson_compact_resolvent_Fredholm_Proposition6_4": "not_proved",
  "responsible_semantic_review": "pending",
  "whole_theorem6_2": "incomplete",
  "core_scope": "incomplete"
}' | ConvertFrom-Json -AsHashtable
$local=[ordered]@{draft_path="$base/Draft.lean";source_path=$source;draft_sha256=$hash;source_sha256=$hash;local_check_log='local01.log';local_check_log_sha256=(Get-FileHash "$base/local01.log").Hash.ToLowerInvariant();local_exit_code=0;local_lean_warnings=0;local_log_empty=$true;exact_source_copy_verified=$true;public_declarations=$pub;integrated=$true;full_check='pending_full_check01'}
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_original_weighted_H1_true_coordinate_weak_derivative_testing_and_closability_necessary_dependency';actual_coordinate_closability_distinct_from_complete_H1_space_or_norm_density=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8






$claim='CH06-DEP-162,Proposition6.4_dependency,6.4.4,256-257,277-278,analytic_dependency,实际canonical位置动量坐标弱导数配对及图可闭性,local01_passed_full_check01_pending,responsible_pending,unitmass_U_Cinfty_unitperiodic_beta_positive_Nzero_same_actual_mu,H1_space_norm_density_SemigroupGeneratorIdentity_GraphCore_ActualInv_Prop6.4_CORE_pending,MolecularDynamics.textbookLangevinCanonicalCoordinateHilbertTestGraph_closure_zero_vertical,module=MolecularDynamics/Chapter06/LangevinCanonicalCoordinateWeakDerivative.lean;11public;真实q与p联合IBP和稠密测试导zerovertical'
$notation='NOT-CH06-171,Langevin_canonical_coordinate_weak_derivative,原canonical位置动量坐标弱导数转置测试与图可闭性,256-257,277-278,Proposition6.4_weighted_H1_derivative_necessary_dependency,currentread277278_exactpriorraw_priorvisual278_hash,MolecularDynamics.textbookLangevinCanonicalCoordinateHilbertTestGraph_closure_zero_vertical,MolecularDynamics/Chapter06/LangevinCanonicalCoordinateWeakDerivative.lean,responsible_pending,local01_passed_full_check01_pending,full-check01-LangevinCanonicalCoordinateWeakDerivative,11public;实际坐标方向及logSlope;同µAE导数图;完整H1空间与范数密度仍未证'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-162') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-171')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalCoordinateWeakDerivative / CH06-DEP-162 / NOT-CH06-171：11public。位置无p权IBP从实际configurational Gibbs切片和全phase Fubini导出，没有除以p坐标；原q/p方向和βDU/βp权斜率统一联合IBP。真实product导数给坐标weighted transpose配对，−DjG+logSlope_j G是真同µL2测试像。实际F/DjF两AE类定义coordinateTestGraph，其域由同µ真实smoothcompact L2密度得dense；真实Hilbert配对的闭性扩到图closure，密度导zerovertical从而坐标导数可闭。local01 clean；exactfull01待验。完整H1空间/范数密度/semigroupgeneratorcore/κInv/Prop6.4未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalCoordinateWeakDerivative：同一原canonical µ，N允许0，unitmass、U∞且unitperiodic、β>0；所有测试函数真实phase compact及real lift∞。坐标IBP、weighted配对及其图可闭性不需要γ/σ或FD，因为它们是同测度坐标导数的事实。actualq无p权IBP直接由原Gibbs切片/Fubini，未用p除法。actualcoordinate graph由F/DjF两同µAE类构成，测试density和Hilbert连续性导zerovertical，不假设weak域/可闭性/core/InvLaw。完整H1空间构造、H1范数密度及一般Poisson仍未完。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalCoordinateWeakDerivative11 local01通过，唯一full01待验；真实q/p坐标联合IBP、加权转置测试及导数图可闭性，完整H1空间/范数密度/Prop6.4/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalCoordinateWeakDerivative'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='十一公开声明是原PDF277/printed256 weightedH1及278/printed257 Proposition6.4所需坐标导数依赖。q坐标无p权联合IBP直接使用真实configuration Gibbs切片分部积分和joint Fubini，所有可积性来自同µ概率与原连续compact测试；没有从p加权等式除以p或假设separable测试。真实q/p坐标方向和负log权斜率βDU_i/βp_i把此结果与已证Gaussian momentum联合IBP统一。'
$reviewText+=[char]10+[char]10+'实际F/G product Frechet导数及原联合IBP给∫DjF·G=∫F·(−DjG+logSlope_j G)。这个literal转置测试像连续且compact，真正属于同canonical L2。actualcoordinateTestGraph由真实F及DjF的两个同µAE类组成，原smoothcompact L2密度给actualdomainDense。Hilbert配对连续、等值集合closed，真实配对扩到actualgraphclosure；若(0,g)属于它，g与每个真实dense smooth test配对为0，因此g=0。这是实际坐标导数的zerovertical可闭性证明，未把可闭性或weak Sobolev域藏入假设。'
$reviewText+=[char]10+[char]10+'γ/σ/FD不参与这些同µ坐标导数事实。尚未构造完整weightedH1空间、证明H1范数下smooth density、刻画所有weak导数域或closedL的完整H1能量；actualsemigroupgenerator身份/core、κGibbsInv、完整Poisson/Fredholm/Prop6.4/CORE未证，负责人语义签核pending。local01全部11/public及private首次空log0，未改变资源/透明性/linter选项。原277278已读，复用同SHA原文本与既有visual278，无新render。冻结正式源码后唯一full01。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalCoordinateWeakDerivative11 local01 clean，唯一full01中' '实际q/p方向/logSlope、fullcanonical q无p权IBP与统一坐标IBP、真实product加权transpose及同µL2测试像、actualcoordinate graph domainDense/closurepairing/zerovertical11public。local01空log0，DEP162/NOT171/280formalinputs冻结。完整H1空间及范数密度、actualsemigroupgenerator身份/core/κInv/Prop6.4未证。' '等唯一full01实际jobs/2783standardaxioms/280inputs/all10zero/0Leanwarning/allSHA后allowlist验收；接续原加权H1弱导数域及确切范数的闭Hilbert空间构造。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
