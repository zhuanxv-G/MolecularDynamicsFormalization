
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
 '既有最新正式验收基线LangevinCanonicalPositionIBP3：132964f2c40f5200fe559af9ad966c1b116e46c3，9188jobs/2703公理/271exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local03全3/private空log0。真实周期位置Gibbs分部积分已证，fullphase弱平衡/actualGibbsInv未证。'
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3七批共61public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalWeakBalance'
$source='MolecularDynamics/Chapter06/LangevinCanonicalWeakBalance.lean'
$localCode=(Get-Content -LiteralPath "$base/local07.exit" -Raw).Trim()
$localLog=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local07.log"))
if($localCode -ne '0' -or $localLog.Trim().Length -ne 0){throw 'Local not passed clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
if(@(Get-CimInstance Win32_Process | Where-Object {$_.Name -in @('lean.exe','lake.exe')}).Count -gt 0){throw 'Active Lean'}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:def|theorem) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 13){throw 'Expected 13 public declarations'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash -LiteralPath "$base/Draft.lean" -Algorithm SHA256).Hash.ToLowerInvariant()){throw 'Exact copy mismatch'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalWeakBalance'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content -LiteralPath "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags=@'
{
  "actual_model": "original_unit_mass_smooth_unit_periodic_potential_actual_full_torus_Gibbs_times_true_Gaussian_probability_beta_positive_Nzero",
  "actual_phase_tests": "all_genuinely_compact_actual_phase_tests_with_Cinfty_real_lift_no_separability_assumption",
  "true_directional_descent": "proved_all_real_representatives_true_periodicity_no_continuous_representative_assumption",
  "true_joint_integrability_and_Fubini": "proved_all_terms_from_actual_continuity_support_compactness_and_actual_probability",
  "whole_Langevin_phase_weak_balance": "proved_actual_canonical_expectation_original_LF_zero_with_sigma_squared_2gamma_over_beta",
  "physical_noise_weak_balance": "proved_true_sqrt_coefficient_positive_gamma_beta",
  "actual_C0_generator_weak_balance": "proved_same_closed_actual_generator_on_genuine_compact_smooth_tests_in_proved_domain",
  "no_target_IBP_balance_InvLaw_or_integrability_hypotheses": "proved_all_needed_measures_derivatives_support_integrability_and_cancellations",
  "actual_probability_Gibbs_invariance": "not_proved_requires_semigroup_core_or_stationary_law_argument",
  "functional_adjoint_domain": "not_proved",
  "graph_core": "not_proved",
  "actual_joint_positive_time_density_existence": "not_proved",
  "weighted_H1_kernel_Proposition6_4": "not_proved",
  "responsible_semantic_review": "pending",
  "whole_theorem6_2": "incomplete",
  "core_scope": "incomplete"
}
'@ | ConvertFrom-Json -AsHashtable
$local=[ordered]@{draft_path="$base/Draft.lean";source_path=$source;draft_sha256=$hash;source_sha256=$hash;local_check_log='local07.log';local_check_log_sha256=(Get-FileHash -LiteralPath "$base/local07.log").Hash.ToLowerInvariant();local_exit_code=0;local_lean_warnings=0;local_log_empty=$true;exact_source_copy_verified=$true;public_declarations=$pub}
foreach($k in $flags.Keys){$local[$k]=$flags[$k]}
$local['integrated']=$true;$local['full_check']='pending_full_check01'
$local | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath "$base/LOCAL_CHECK.json" -Encoding utf8


$pdf='C:/Users/ustc/Desktop/formal math/Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf'
$pdfHash=(Get-FileHash -LiteralPath $pdf).Hash.ToLowerInvariant()
if($pdfHash -cne '1939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036'){throw 'PDF changed'}
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(218,247,250,251,252,253,254);pdf_pages=@(239,268,271,272,273,274,275);visual_checked_prior_exact_unchanged_pages=@(239,268,273);original_text_prior_rechecked_exact_unchanged_pages=@(239,268,271,272,273,274,275);visual_checked_current_pages=@();original_pdf_hash_reverified_current=$true;reference='original_Canonical6_3_Langevin6_47_Ldagger6_23_and_Theorem6_2_fullphase_canonical_stationary_weak_dependency';prior_render_path='docs/verification/2026-10-07-LangevinCanonicalMeasure/original-PDF239.png';prior_render_sha256=(Get-FileHash -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalMeasure/original-PDF239.png').Hash.ToLowerInvariant()}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8
$claim='CH06-DEP-154,Original full canonical Langevin weak balance on compact smooth phase tests,6.1.3;6.2;6.4.4,218;247;251-254,239;268;272-275,necessary_proof_dependency,true_directional_descent_compact_support_actual_joint_qp_IBP_Fubini_OU_cancellation_original_L_split_full_canonical_weak_zero_actual_closedC0_generator_domain_action,docs/reviews/2026-10-07-LangevinCanonicalWeakBalance/REVIEW.zh-CN.md;docs/verification/2026-10-07-LangevinCanonicalWeakBalance/full-check01/CHECK_REPORT.json,local07_passed_full_check01_pending,original_unit_mass_U_Cinfty_unitperiodic_beta_positive_truecanonical_phase_F_Cinfty_lift_compact_Nzero_sigma2_2gamma_overbeta_no_IBP_balance_InvLaw_integrability_premise,13public_actualjoint_fullphase_weakbalance_C0_domain_generator_expectation_zero_transitionInv_not_proved,MolecularDynamics/Chapter06/LangevinCanonicalWeakBalance.lean,ActualGibbsInvariance/FunctionalAdjointDomain/GraphCore/Density/WeightedH1Kernel/CorePending'
$notation='NOT-CH06-163,Langevin_actual_full_canonical_weak_balance,原真实canonical概率全phase弱平衡,218;247;251-254,239;268;272-275,Canonical6.3_Theorem6.2_stationary_law_dependency,prior_exact_original_text_visual239268273,textbookLangevinCanonicalMeasure_weak_balance,MolecularDynamics/Chapter06/LangevinCanonicalWeakBalance.lean,responsible_pending,local07_passed_full_check01_pending,full-check01-LangevinCanonicalWeakBalance,13public allsmoothcompact actualjoint qforce OU cancellation trueintegrability C0actualgenerator action weakzero actualInv未证'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-154') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-163')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalWeakBalance / CH06-DEP-154 / NOT-CH06-163：13public trueconstant方向导数allrepresentatives下降、smooth/continuous/tsupport/compact；actualfullcanonical probability所有jointterms真可积与Fubini给任意compact smooth phaseF的qforce相消+OU弱零；原L truefirstsecondderivative精确split导∫LFµ=0及physicalsqrt。连接same actualclosedC0 generator已证domain action的expectation0。U∞periodic β正 F真实compact且lift∞ N0 σ²=2γ/β；无IBP/weakbalance/InvLaw/integrability前提。local07零warning exactfull01待验；actualGibbsInv/functionaladjoint域/graphcore/weightedH1未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalWeakBalance：原unitmass实际torusGibbs×真实Gaussian相空间概率，U∞unitperiodic β正 N0 F实际compact smoothlift；true方向导数下降continuity/supportcompact、两真slice chain derivative/compact支持、所有actualjointterms从连续compact+真prob推导可积，Fubini和已证trueµq/µp IBP给full Hamiltonianforce cancellation及OU弱零。literal原L表达式精确split导actual∫LFµ0，σ²FD仅物理系数；sqrt由βγ正导。actualclosedC0 generator corollary使用原已证domain/action而无targetbalance或InvLaw或jointintegrability假设。仅∞compact测试，未声称所有C²/H1/closed generator domain弱平衡、actualκGibbsInv或Hilbertadjoint/core，CORE未完。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalWeakBalance13局部通过，唯一full01待验；真实全phase compact smooth canonical弱平衡及actualC0domain测试生成元期望0，actualInv/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalWeakBalance'
$null=New-Item -ItemType Directory -Path $review
$t=@'
# 原canonical完整相空间真实弱平衡

13公开声明：实际constant方向导数由真正整数周期性在所有代表元一致，open quotient给实际连续，真fderiv support给实际tsupport包含并保持compact；smoothlift得derivative smoothlift。所有真phasecompact测试F（lift∞，无需separable），slice链式导数、momentum slice支持由实际tsupport image compact导出，不把uniformsupport或bound藏入假设。

对同actualµq×真实Gaussian µp的各项从continuous和实际compact支持、实际probability推导jointintegrable，trueFubini结合已验真实position/momentum IBP，两个Hamiltonianforce项的积分同β∫pDiU F从而相消；真实OU µp弱零经过全部joint可积及Fubini到same fullphase概率。原literal directionalfirstsecond L表达式通过真正Fréchet finitebasis及Hessian/secondpartial识别得到split，因此真正∫LF dcanonical=0，physicalsqrt系数亦真实。最后使用same original actualclosedC0 generator已证compactC²domain/action给同∞compact测试期望0，不把classic differential表达式冒充actualgenerator。

scope原unitmass6.47、U∞unitperiodic β正、N0，F实际compact且real lift∞；未推广所有C²、H1、wholeclosed generator domain。没有IBP/weakbalance/InvLaw或任何jointintegrability假设。actualκGibbsInv还需core或stationarylaw证明；functionaladjoint域、graphcore、真实jointdensity、weightedH1 Prop6.4、整Theorem6.2/CORE及负责人签核未完。PDF239/268/271–275文字与239/268/273视觉复用同original hash此前核对，当前PDF hash再次验证，未新render。

local01两slice HasFDerivAt comp/λeta；02只pairinteger动量+0；03periodiclet未展开、finitepairbasis投影sum、constdiff参数、partialderivative阶数推断、integral_sub函数Piη。改typed真实chain derivative、explicit Prod.fst_sum/snd_sum、explicit ContDiff∞fderiv和真lambda integrable；04/05仅C0corollary缺NNReal scope导致ℝ≥0误解析成LE Type及isDefEq timeout，开启对应notation scope；06多开ENNReal导致未双向标注的∞歧义，去除无用ENNReal scope并将order显式标注ℕ∞ω后07全13/private空log0。未增加资源/transparency/linter options。raw01–07保留。首次fullcandidate写入command因Windows长度206没执行后分段写入全部候选，保留真实检查点，不计失败源码通过。

'@
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$t.TrimEnd()+[char]10,$utf)
Save-LocalCheckpoint 'CanonicalWeakBalance13 local07空log零warning，唯一full01中' 'actualcanonical全phase compact smooth F truejoint IBP/Fubini Hamiltonianforce+OU cancellation、original Lsplit及真期望0/physicalsqrt、same actualclosedC0 generator已证domain期望0共13public局部通过。exactsource/root/DEP154 NOT163/272inputs冻结，raw01–07留；actualκGibbsInv/core/functionaladjoint/H1未证。' '等待唯一full01 all10zero/2716standardaxioms/272inputs/allSHA然后allowlist验收提交，继续canonical必要adjoint/energy/core依赖。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
