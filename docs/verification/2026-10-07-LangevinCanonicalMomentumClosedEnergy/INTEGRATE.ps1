
function Save-LocalCheckpoint([string]$Title,[string]$Details,[string]$Next) {
 $stamp=[DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('yyyy-MM-dd HH:mm:ss zzz')
 $head=(git rev-parse HEAD).Trim()
 $branch=(git branch --show-current).Trim()
 $latest=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalCoordinateClosed/ACCEPTANCE.json' -Raw | ConvertFrom-Json
 $lines=@(
 '# 当前可操作状态'
 "最后更新时间（Asia/Shanghai）：$stamp"
 '当前聊天01a10bc0-bc8d-7043-8df9-21a6b0bde09a；handoff ready/new_thread_id正确。'
 "工程C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization；branch $branch；HEAD $head。"
 '固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435，只本地。'
 "既有最新正式验收基线LangevinCanonicalCoordinateClosed十一声明：$head，$($latest.jobs)jobs/2825公理/283exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local01十一声明空log0。samecanonical实际coordinate graphclosure闭算子graph/isClosed/dense/smoothgraph、actualsmoothadjoint域/literal值及weakH1在实际minimaldomain交集上的导数一致已证；minimal/fullweak域等同、H1范数密度、closedL全动量能量及kernel、actualgenerator身份/core/κInv/Poisson未证。"
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7、CanonicalHilbertGraph10、CanonicalHilbertClosed10、CanonicalHilbertDissipativity5、CanonicalCoordinateWeakDerivative11、CanonicalWeakH1十五声明、CanonicalH1MeanZero十六声明、CanonicalCoordinateClosed十一声明十九批共183public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalMomentumClosedEnergy'
$source='MolecularDynamics/Chapter06/LangevinCanonicalMomentumClosedEnergy.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local02.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local02.log")).Trim().Length -ne 0){throw 'Local01 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
$prior=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalCoordinateClosed/full-check01/CHECK_REPORT.json' -Raw | ConvertFrom-Json
if($prior.machine_check_status -ne 'passed' -or $prior.inputs.Count -ne 283){throw 'Previous baseline not accepted'}
foreach($i in $prior.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Prior exact input changed $($i.relative_path)"}}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:abbrev|def|theorem|instance) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 13){throw 'Expected 13 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalMomentumClosedEnergy'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_gamma_strictly_positive_FD_same_canonical_measure_Nzero",
  "actual_momentum_jet": "true_PiLp2_vector_of_same_original_canonical_L2_classes",
  "actual_test_graph_momentum_domain_membership": "proved_from_true_F_and_DpF_AE_classes_and_coordinate_graph_closure",
  "actual_test_momentum_derivative_linearity": "proved_from_true_minimal_closed_coordinate_linear_operators",
  "actual_test_momentum_energy": "proved_exact_original_energy_equals_minus_gamma_over_beta_times_true_gradient_norm_squared",
  "actual_test_momentum_graph_norm_bound": "proved_sqrt_beta_over_gamma_bound_from_true_energy_and_Cauchy_Schwarz",
  "actual_test_to_closed_graph_embedding": "proved_dense_and_uniform_inducing_in_actual_graph_topological_closure",
  "actual_closed_graph_momentum_derivative": "true_continuous_linear_extension_from_actual_test_graph_with_proved_embedding_and_bound",
  "actual_closed_graph_momentum_coordinate_graph_membership": "proved_by_dense_induction_and_actual_closed_coordinate_graph",
  "actual_closed_graph_momentum_energy": "proved_on_entire_actual_graph_closure_by_continuity_and_true_test_energy",
  "actual_closed_L_domain_minimal_p_derivative_inclusion": "proved_for_every_actual_closed_operator_domain_element_and_every_momentum_coordinate",
  "actual_closed_L_momentum_derivative_vector": "constructed_from_genuine_continuous_closed_graph_momentum_extension",
  "actual_closed_L_full_domain_momentum_energy": "proved_exact_original_minus_gamma_over_beta_identity",
  "actual_closed_L_weakH1_momentum_compatibility": "proved_for_actual_weakH1_functions_in_actual_closed_L_domain",
  "actual_closed_L_kernel_momentum_derivative_zero": "proved_from_actual_full_domain_energy_with_gamma_strictly_positive",
  "actual_closed_L_domain_full_q_and_p_H1_inclusion": "not_proved_or_assumed",
  "minimal_coordinate_domain_equals_full_weak_derivative_domain": "not_proved",
  "weighted_H1_norm_smooth_density": "not_proved",
  "full_closed_L_kernel_constancy": "not_proved",
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_entire_actual_closed_L_momentum_energy_and_kernel_derivative_necessary_dependency';actual_closed_L_momentum_derivative_domain_distinct_from_full_q_p_H1_regular_or_generator_identity=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8








$claim='CH06-DEP-166,Proposition6.4_dependency,6.4.4,256-257,277-278,analytic_dependency,实际closedL全域动量能量与kernel动量导数0,local02_passed_full_check01_pending,responsible_pending,unitmass_U_Cinfty_unitperiodic_beta_positive_gamma_positive_FD_Nzero_same_actual_mu,full_qH1_regular_H1_smooth_density_full_kernel_constancy_ActualInv_Prop6.4_CORE_pending,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_energy,module=MolecularDynamics/Chapter06/LangevinCanonicalMomentumClosedEnergy.lean;13public;实际graphnormbound导momentumCLM真closure延伸;完整域能量实证'
$notation='NOT-CH06-175,Langevin_canonical_closed_domain_momentum_energy,原canonical闭L全域动量能量与kernel动量导数0,256-257,277-278,Proposition6.4_full_closed_L_momentum_energy_necessary_dependency,currentread277278_exactpriorraw_priorvisual278_hash,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_energy,MolecularDynamics/Chapter06/LangevinCanonicalMomentumClosedEnergy.lean,responsible_pending,local02_passed_full_check01_pending,full-check01-LangevinCanonicalMomentumClosedEnergy,13public;γ>0真实graphnorm估计及momentumCLM延伸;actualclosedL全域动量导数及energy;全kernel常数性未证'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-166') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-175')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalMomentumClosedEnergy / CH06-DEP-166 / NOT-CH06-175：13public。真实testgraph中F和所有DpF同µL2类属于actualminimalcoordinate闭域，线性构成PiLp2动量向量。原真实energy逐坐标L2平方积分给testgradient norm²，γ>0时真实Cauchy–Schwarz/productnorm导‖gradp‖≤sqrt(β/γ)‖(f,Lf)‖。实际testgraph至其真closure的embedding被证dense/uniformInducing，该真bound构造CLM并连续延伸到整个actualclosure；denseinduction证明各momentumcoordinate闭graphmembership和原energy。故实际closedL完整域包含每个p的minimalclosed导数域，并有实际momentumgradient和完整域energy；trueweakH1在实际L域时gradient与weakderivatives相容；actualkernel momentumvector=0。local02 clean；exactfull01待验。未声称closedLdomain⊂fullq/pH1；minimal/fullweak域等同、H1范数密度、全kernel常数性、actualgeneratorcore/κInv/Prop6.4未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalMomentumClosedEnergy：同一原canonicalµ，N允许0、unitmass、U∞且unitperiodic、β>0，并明确γ>0、真实FD σ²=2γ/β；新γ>0用于graphnormgradient控制和kernelmomentum0，没有隐入早前γ=0结论。真实testgraph及actualcoordinate闭图提供各p导数，原energy/Cauchy–Schwarz实证graphbound，denseUniformEmbedding实证CLM.extend有效，非零junk分支已排除。actualclosedL完整域p正则和能量实证，不假设全q/pH1域包含、fullweak=minimal域、H1范数密度、generator身份/core或InvLaw。完整核常数性及Poisson未完。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalMomentumClosedEnergy13 local02通过，唯一full01待验；γ>0实际closedL全域momentum导数与原energy、kernelmomentum0；全qH1域包含/H1密度/全kernel常数性/Prop6.4/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalMomentumClosedEnergy'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='十三声明服务原PDF277/printed256 H1及278/printed257 Proposition6.4的完整closedL能量与kernel必要证明步骤。原actualtestgraph的F和DpF两同µAE类给actualminimalclosedmomentum域；已证coordinateLinearPMap线性构造真正PiLp2向量。原energy和真实L2内积/可积平方finiteSum给⟪f,Lf⟫=−γ/β‖gradp‖²；明确γ>0时实证‖gradp‖≤sqrt(β/γ)‖(f,Lf)‖，因此是actualgraphnormCLM。'
$reviewText+=[char]10+[char]10+'actualtestgraphSubmodule至其真正topologicalClosure的inclusion被分别证明denseRange及IsUniformInducing；沿此embedding调用真正CLM.extend且证明与test值一致，非有效分支的零junk被实际证明排除。每个坐标闭graph是closed，denseinduction给真closure所有pair的pclosedgraphmembership；原inner与extensionnorm²连续，denseinduction给完整closureenergy。于是每个actualclosedLdomain函数确在所有p的minimalclosed导数域，实际gradient向量及完整域energy均已证；已有trueweakH1函数若确在L域，则实际momentumvector与其弱导数一致；真实kernel元素由γ>0能量强迫momentumvector0。'
$reviewText+=[char]10+[char]10+'这里未声称closedLdomain包含fullq/pH1，完整qregularity另待证明。仍未证H1范数smoothdensity/minimal与fullweak域相同、全kernel常数性、actualsemigroupgenerator身份/core、κGibbsInv、compactresolvent/Fredholm/完整Poisson/Prop6.4/CORE；负责人语义签核pending。local01真实PiLp pointwise操作未展开、Integral Pi乘法/lambda形状、弃用integral_finset_sum、denseinduction类型未显式、closedenergy graphpair推断、kernelenergy三次nlinarith错误。分别显式PiLp运算和actualdomain元素、typed hm、新integral_finsetSum、显式命题函数与actualpair，提取mul_eq_zero非零系数后证norm0。local02十三声明全emptylog0，未改statement/模型假设/资源选项，raw01–02保留。原277278当前复读，复用同SHA raw及既有visual278，无新render。唯一full01。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalMomentumClosedEnergy13 local02 clean，唯一full01中' '实际testmomentumPiLp向量线性/energy/graphnormbound，真实denseuniformembedding导CLM.extend在真closure上的coordinate闭graph与完整energy；actualclosedL全域p闭导数域包含/actualgradient/energy/weakH1相容及kernelmomentum0，共13public。local02空log0，DEP166/NOT175/284formalinputs冻结。γ>0范围显式。全q/pH1域包含、H1密度、全kernel常数性、actualgeneratorcore/κInv/Prop6.4未证。' '等唯一full01实际jobs/2838standardaxioms/284inputs/all10zero/0Leanwarning/allSHA后allowlist验收；继续actualkernel常数性所需weak动量导数0至p独立桥，不假设fullH1core。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
