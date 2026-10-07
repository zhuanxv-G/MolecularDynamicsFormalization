
function Save-LocalCheckpoint([string]$Title,[string]$Details,[string]$Next) {
 $stamp=[DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('yyyy-MM-dd HH:mm:ss zzz')
 $head=(git rev-parse HEAD).Trim()
 $branch=(git branch --show-current).Trim()
 $latest=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalWeakH1/ACCEPTANCE.json' -Raw | ConvertFrom-Json
 $lines=@(
 '# 当前可操作状态'
 "最后更新时间（Asia/Shanghai）：$stamp"
 '当前聊天01a10bc0-bc8d-7043-8df9-21a6b0bde09a；handoff ready/new_thread_id正确。'
 "工程C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization；branch $branch；HEAD $head。"
 '固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435，只本地。'
 "既有最新正式验收基线LangevinCanonicalWeakH1十五声明：$head，$($latest.jobs)jobs/2798公理/281exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local02十五声明空log0。sameactualcanonical weak坐标测试closedSubmodule/weak导数唯一，真实completeHilbert H1及函数/导数CLM、函数投影injective、原q/p梯度平方和norm和compact∞真实membership/积分norm已证；H1范数密度/closedL H1能量及全kernel/semigroupgenerator身份/core/κInv未证。"
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7、CanonicalHilbertGraph10、CanonicalHilbertClosed10、CanonicalHilbertDissipativity5、CanonicalCoordinateWeakDerivative11、CanonicalWeakH1十五声明十七批共156public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalH1MeanZero'
$source='MolecularDynamics/Chapter06/LangevinCanonicalH1MeanZero.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local02.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local02.log")).Trim().Length -ne 0){throw 'Local02 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:abbrev|def|theorem|instance) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 16){throw 'Expected 10 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalH1MeanZero'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_same_normalized_canonical_measure_Nzero_actual_weak_H1",
  "actual_constant_H1_membership": "constructed_true_constant_jet_by_actual_coordinate_transpose_test_integral_zero_from_IBP",
  "actual_constant_function_representative": "proved_literal_constant_AE_in_original_canonical_L2",
  "actual_constant_coordinate_derivatives": "proved_all_true_q_p_weak_derivatives_zero",
  "actual_constant_H1_norm": "proved_absolute_value_using_actual_canonical_probability_and_original_H1_norm",
  "actual_H1_function_integrability": "proved_L2_to_L1_under_same_actual_finite_canonical_probability",
  "actual_canonical_mean": "true_continuous_linear_functional_proved_equal_original_canonical_integral",
  "actual_mean_constant_and_bound": "proved_mean_of_constant_c_is_c_and_absolute_mean_le_original_H1_norm",
  "actual_mean_zero_condition": "true_mean_kernel_proved_exact_Proposition6_4_integral_g_d_mu_beta_zero",
  "actual_mean_zero_H1_subspace": "proved_closed_and_complete_in_true_original_weak_H1",
  "actual_canonical_centering": "continuous_linear_actual_f_minus_mean_f_times_true_constant_one",
  "actual_centering_mean_zero_and_fixes": "proved_centered_function_has_true_integral_zero_and_centering_fixes_every_mean_zero_function",
  "no_extra_constant_H1_membership_mean_closedness_or_Poisson_hypotheses": true,
  "full_closed_operator_kernel_equals_constants": "not_proved",
  "weighted_H1_norm_smooth_density": "not_proved",
  "H1_characterization_against_other_implementations": "not_proved",
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_original_zero_canonical_integral_condition_actual_H1_constants_mean_and_closed_mean_zero_subspace_necessary_definition';actual_mean_zero_condition_distinct_from_full_closed_operator_kernel_or_Poisson_solvability=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8








$claim='CH06-DEP-164,Proposition6.4_dependency,6.4.4,256-257,277-278,definition_dependency,原canonical H1常数均值和真实积分为零的闭完备子空间,local02_passed_full_check01_pending,responsible_pending,unitmass_U_Cinfty_unitperiodic_beta_positive_Nzero_same_actual_mu_weak_H1,FullClosedKernel_H1_norm_density_operator_energy_SemigroupGeneratorIdentity_GraphCore_ActualInv_Prop6.4_CORE_pending,MolecularDynamics.textbookLangevinCanonicalWeakH1MeanZero_mem_iff,module=MolecularDynamics/Chapter06/LangevinCanonicalH1MeanZero.lean;16声明;真实IBP导constant member和原mean condition;没有Fredholm可解性结论'
$notation='NOT-CH06-173,Langevin_canonical_H1_mean_zero,原H1函数canonical均值与积分为零闭子空间,256-257,277-278,Proposition6.4_original_zero_mean_condition_necessary_definition,currentread277278_exactpriorraw_priorvisual278_hash,MolecularDynamics.textbookLangevinCanonicalWeakH1MeanZero_mem_iff,MolecularDynamics/Chapter06/LangevinCanonicalH1MeanZero.lean,responsible_pending,local02_passed_full_check01_pending,full-check01-LangevinCanonicalH1MeanZero,16声明;actualcanonical H1 constants and integral mean;闭完备mean-zero及真实centering;Poisson未证'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-164') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-173')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalH1MeanZero / CH06-DEP-164 / NOT-CH06-173：16声明。原同canonical H1常数的membership从真实compact test坐标IBP导∫adjointTest=0构造，不假设常数属于某closedL域；value是真constant AE、所有坐标weak导数0，actualprobability及原H1norm导‖constant c‖=|c|。每真实H1value可积，innerSL与实际constant1给mean CLM，并证明等于原∫g dµβ、mean(c)=c、|mean g|≤‖g‖H1。true mean kernel给原积分0条件的closed complete H1子空间；真实continuous centering减去mean•1，总入mean-zero且固定原mean-zero函数。local02 clean；exactfull01待验。closedL全kernel=constants、H1范数密度/能量/semigroupgeneratorcore/GibbsInv/Poisson未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalH1MeanZero：同一原canonical normalized概率、N允许0、unitmass、U∞unitperiodic、β>0；使用上一批真实weakH1定义，不需γ/σ/FD。actualconstantH1由真实coordinate IBP紧支测试构造，非C0函数/closedL核假设。均值的Bochner积分身份另证明actual H1value属于L1，避免以不可积积分总化代替原mean。norm constant和mean bound使用已证canonicalµ概率总质量1，mean-zero是这个真实CLM核；closed/complete和centering从实际构造导出。未假设closedL核全常数、Fredholm可解性、H1范数密度/core/InvLaw。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalH1MeanZero十六声明 local02通过，唯一full01待验；实际H1常数/可积/积分mean及真实mean-zero closedCompleteSpace/centering，closedL全kernel/H1范数密度/Poisson/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalH1MeanZero'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='十六声明服务原PDF277/printed256 H1及278/printed257 Proposition6.4 ∫g dµβ=0的原条件。由真实coordinate IBP ∫DG=∫sG，实际可积性给literaladjointTest的积分0，所以值为原constant L2类、全部derivative为0的jet真正满足weakH1测试等式；没有假设constantH1 membership或closedL kernel。value AE=c、所有q/p弱导数0、canonicalµ真实probability与原square-sum norm给‖constant c‖H1=|c|。'
$reviewText+=[char]10+[char]10+'每actualH1函数值是同µL2，实际有限probability下mono exponent导L1可积。原constant1与value的actualHilbert pairing构造mean continuouslinearfunctional，真实AE1和L2.inner_def导它正好等于原canonical integral。mean(c)=c，Cauchy–Schwarz/真实constant1 norm及PiLp函数projectionbound导|mean f|≤‖f‖H1。这个真实CLM核是closed complete H1子空间，其membership严格等价原∫g dµβ=0。真实centering f−mean f•1为CLM，均值0且固定原mean-zero函数。'
$reviewText+=[char]10+[char]10+'未证明closedL或其完整adjoint的全kernel=constants，未证明H1范数光滑密度或closedL H1全能量；实际semigroupgenerator身份/core、κGibbsInv、完整Fredholm/Poisson/compactresolvent/Prop6.4/CORE未证，负责人语义签核pending。local01 integral_add的Pi.neg与lambda写法重写不匹配，Lp.memLp误作Subtype字段，norm_inner_le_norm缺𝕜=ℝ；分别显式hDN、Lp.memLp/q=2、实数scalar修复。local02全16/public/private空log0，无资源/透明性/linter选项或statement弱化。raw01–02按字节保留。原277278已读，复用同SHA原文本与既有visual278，无新render。冻结正式源码后唯一full01。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalH1MeanZero十六声明 local02 clean，唯一full01中' '实际canonical H1常数由IBP构造、constantAE/坐标weak导数0/norm|c|、actualH1value可积、mean CLM=原canonical integral/meanconstant/normbound1、true原mean-zero closedCompleteSpace和实际centering十六声明。local02空log0，DEP164/NOT173/282formalinputs冻结。closedL全kernel=constants、H1范数密度/全部域能量、actualsemigroupgeneratorcore/κInv/Prop6.4未证。' '等唯一full01实际jobs/2814standardaxioms/282inputs/all10zero/0Leanwarning/allSHA后allowlist验收；接续实际坐标闭导数算子及closedL动量能量延伸所需桥。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
