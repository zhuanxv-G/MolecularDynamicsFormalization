
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
 '既有最新正式验收基线LangevinCanonicalWeakBalance13：0fb6e42c0b1988366572718c6e4e101f1fa74e7e，9189jobs/2716公理/272exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local07全13/private空log0。same actual canonical probability完整phase smoothcompact弱平衡及actualclosedC0 generator已证domain测试期望0已证；actualκGibbsInv未证。'
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13八批共74public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalEnergy'
$source='MolecularDynamics/Chapter06/LangevinCanonicalEnergy.lean'
$localCode=(Get-Content -LiteralPath "$base/local05.exit" -Raw).Trim()
$localLog=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local05.log"))
if($localCode -ne '0' -or $localLog.Trim().Length -ne 0){throw 'Local not passed clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
if(@(Get-CimInstance Win32_Process | Where-Object {$_.Name -in @('lean.exe','lake.exe')}).Count -gt 0){throw 'Active Lean'}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:def|theorem) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 12){throw 'Expected 12 public declarations'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash -LiteralPath "$base/Draft.lean" -Algorithm SHA256).Hash.ToLowerInvariant()){throw 'Exact copy mismatch'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalEnergy'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content -LiteralPath "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags=@'
{
  "actual_model": "original_unit_mass_smooth_unit_periodic_potential_actual_full_canonical_probability_beta_positive_Nzero",
  "energy_tests": "genuinely_compact_actual_phase_F_G_with_Cinfty_real_lifts",
  "actual_directional_and_operator_product_rule": "proved_true_first_and_second_derivative_product_calculus_same_L_with_physical_coefficient",
  "actual_canonical_bilinear_and_energy": "proved_from_actual_full_phase_weak_balance_true_all_product_integrability",
  "actual_closed_C0_generator_energy": "proved_same_actual_generator_on_genuine_compact_smooth_tests_in_proved_domain",
  "actual_canonical_density_continuous_full_support": "proved_from_true_smooth_real_density_lift_actual_strict_positive_density_true_Haar_times_Lebesgue_and_reverse_absolute_continuity",
  "compact_smooth_zero_mode_momentum_gradient": "proved_mu_almost_everywhere_zero_from_true_nonnegative_energy_integral_and_positive_gamma",
  "smooth_gradient_AE_to_pointwise_and_momentum_independent": "proved_true_full_support_continuity_actual_Frechet_slice_coordinate_basis_and_mean_value",
  "noncompact_smooth_gradient_implication_premise": "actual_momentum_gradient_zero_mu_AE_genuine_intermediate_not_assumed_kernel_or_invariance_conclusion",
  "no_target_IBP_balance_InvLaw_integrability_hypotheses": "proved_all_analytic_integrability_and_weak_balance_dependencies",
  "weighted_H1_extension": "not_proved_only_smooth_test_stage",
  "weighted_H1_kernel_Proposition6_4": "not_proved_complete",
  "functional_adjoint_domain": "not_proved",
  "actual_probability_Gibbs_invariance": "not_proved",
  "graph_core": "not_proved",
  "actual_joint_positive_time_density_existence": "not_proved",
  "forward_Poisson_compact_resolvent_Fredholm_Proposition6_4": "not_proved",
  "responsible_semantic_review": "pending",
  "whole_theorem6_2": "incomplete",
  "core_scope": "incomplete"
}
'@ | ConvertFrom-Json -AsHashtable
$local=[ordered]@{draft_path="$base/Draft.lean";source_path=$source;draft_sha256=$hash;source_sha256=$hash;local_check_log='local05.log';local_check_log_sha256=(Get-FileHash -LiteralPath "$base/local05.log").Hash.ToLowerInvariant();local_exit_code=0;local_lean_warnings=0;local_log_empty=$true;exact_source_copy_verified=$true;public_declarations=$pub}
foreach($k in $flags.Keys){$local[$k]=$flags[$k]}
$local['integrated']=$true;$local['full_check']='pending_full_check01'
$local | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath "$base/LOCAL_CHECK.json" -Encoding utf8


$pdf='C:/Users/ustc/Desktop/formal math/Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf'
$pdfHash=(Get-FileHash -LiteralPath $pdf).Hash.ToLowerInvariant()
if($pdfHash -cne '1939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036'){throw 'PDF changed'}
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(218,247,251,252,253,254,256,257);pdf_pages=@(239,268,272,273,274,275,277,278);visual_checked_prior_exact_unchanged_pages=@(239,268,273,278);original_text_prior_rechecked_exact_unchanged_pages=@(239,268,271,272,273,274,275);visual_checked_current_pages=@();original_pdf_hash_reverified_current=$true;reference='original_weighted_H1_notation_PDF277_278_Proposition6_4_smooth_energy_null_gradient_dependency';prior_render_path='docs/verification/2026-10-07-LangevinCanonicalMeasure/original-PDF239.png';prior_render_sha256=(Get-FileHash -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalMeasure/original-PDF239.png').Hash.ToLowerInvariant()}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a['original_text_rechecked_current_pages']=@(277,278)
$a['current_text_path']="$base/ORIGINAL_PDF277_278.log"
$a['current_text_sha256']=(Get-FileHash -LiteralPath "$base/ORIGINAL_PDF277_278.log").Hash.ToLowerInvariant()
$a['prior_PDF278_render_path']='docs/verification/2026-10-07-LangevinC0ConservedObservable/original-PDF278.png'
$a['prior_PDF278_render_sha256']=(Get-FileHash -LiteralPath $a.prior_PDF278_render_path).Hash.ToLowerInvariant()
if($a.prior_PDF278_render_sha256 -cne 'c7c839b7ec2b02c7b52288a986d4bfa3bffa992bd0239ea07878b59e5d6d863c'){throw 'Prior PDF278 render changed'}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8
$claim='CH06-DEP-155,Original canonical energy identity and smooth momentum null-gradient stage for weighted H1,6.1.3;6.4.4;Proposition6.4,218;251-254;256-257,239;272-275;277-278,necessary_proof_dependency,true_D_and_L_product_rule_actual_fullcanonical_bilinear_energy_true_gradient_sq_nonnegative_integrability_compact_zero_mode_AE_grad0_actual_fullsupport_continuity_meanvalue_momentumindependence_C0_generator_energy,docs/reviews/2026-10-07-LangevinCanonicalEnergy/REVIEW.zh-CN.md;docs/verification/2026-10-07-LangevinCanonicalEnergy/full-check01/CHECK_REPORT.json,local05_passed_full_check01_pending,original_unit_mass_U_Cinfty_unitperiodic_beta_positive_energy_FG_actualcompact_Cinfty_lifts_Nzero_sigma2FD_smooth_AEgrad_condition_for_pointwise_independence_not_H1_extension,12public_actualenergy_and_canonical_fullsupport_smooth_grad0_momentumindependent_actualclosedC0domain_energy_H1_and_Inv_not_proved,MolecularDynamics/Chapter06/LangevinCanonicalEnergy.lean,WeightedH1Extension/ActualGibbsInvariance/FunctionalAdjointDomain/GraphCore/Density/PoissonFredholm/CorePending'
$notation='NOT-CH06-164,Langevin_canonical_energy_smooth_momentum_gradient_square,原canonical能量与真实动量梯度平方smooth阶段,218;256-257,239;277-278,weightedH1_Proposition6.4_necessary_smooth_proof_stage,currenttext277278_priorvisual278_exacthash,textbookLangevinPeriodicMomentumGradientSquare,MolecularDynamics/Chapter06/LangevinCanonicalEnergy.lean,responsible_pending,local05_passed_full_check01_pending,full-check01-LangevinCanonicalEnergy,12public actualcanonicalenergy fullsupport smoothAEgradzero pointwise momentumindependence notfullH1 Inv orPoisson'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-155') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-164')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalEnergy / CH06-DEP-155 / NOT-CH06-164：12public 原actualD/L真product calculus、fullcanonical weakbalance product+所有真实可积得symmetric bilinear与∫F LF=−γβinv∫ΣDpF²、physicalnoise、actualclosedC0 domain energy。compact smooth LF0由真nonnegativeintegral给DpFµae0；实际ρcontinuity/strictpos withDensity reverseAC给actualcanonical fullsupport；smooth gradµae0经continuity得pointwise并trueFrechet slice+finitebasis meanvalue得momentumindep。energy及zeromode仅∞compact，AE→pointwise/indep为∞observable给定真AEgradient条件，未冒称H1延拓。local05零warning exactfull01待验；H1kernel/Poisson/actualκGibbsInv/functionaladjoint/core未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalEnergy：same原unitmass U∞unitperiodic actualfullcanonical β正 N0；energy/bilinear F/G实际compact且real lift∞，原σ²=2γ/β物理系数，zero_mode导gradientAE0需γ正且LF0正当kernel条件。全部∫项从continuity/compact与实际probability证明可积；真实Dproduct/Lproduct与fullweakproduct导energy，无targetenergy或adjoint或IBP/InvLaw假设。实际canonical满支集由真ρstrictpos+continuous+真实withDensity reverseAC，任意smoothF给定真实µa.e.∇pF0则pointwise再meanvalue得momentumindep；该AEgradient是原nullspace论证合法中间条件，无L2/H1完整extension或kernelconstancy重证明主张。actualclosedC0只用既有真实domain/action。H1弱导数闭包/adjoint域/κInv/compactresolvent/Fredholm/CORE未完。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalEnergy12局部通过，唯一full01待验；actualcanonical energy/fullsupport与smooth梯度零的动量独立stage，H1/actualInv/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalEnergy'
$null=New-Item -ItemType Directory -Path $review
$t=@'
# 原canonical能量恒等式与加权H1零梯度证明的smooth阶段

12公开声明围绕原Proposition6.4必要零模分析及原加权H1 notation。真实actualD product和second product推导同原L actualproduct rule，fullcanonical弱平衡应用真实FG compact product，全部integrability由actual连续/compact/prob证明，得到∫F LG+∫G LF=−σ²∫ΣDpF DpG，F=G及FD真系数得∫F LF=−γβinv∫ΣDpF²。真实gradSquare沿原向量coordinate平方和约定；physicalsqrt与sameactualclosedC0已证domain/action能量也完整。

LF0是原zero_mode正当条件，compact∞F的nonnegative actualenergy integral与γβ正给∇pF真µae0。实际同canonicalρ由真实real densitylift+openquotient连续，strictpositive density withDensity reverseabsolutecontinuity导actualcanonical满支集；任意∞phaseF给定µae梯度零经真正连续与满支集得pointwise零，真实p sliceFrechet链式导数和finitecoordinatebasis+meanvalue给所有momentum值独立。这不是先假设独立性/InvLaw或目标energy。未重做既有C0核常数性结论；smooth阶段为weightedH1闭包证明提供实际measure/derivative依赖。

scope energy/bilinear/actualC0domain及LF0→AEgradient仅genuinecompact∞lifts、unitmass、U∞unitperiodic β正 N0 σ²physical；AE→pointwise/indep允许noncompact smoothobservable但有正当中间AEgradient条件。没有all weightedH1 extension、Hilbertfunctionaladjoint域、graphcore、实际κGibbsInv、真实jointpositive-time密度、compactresolvent/Fredholm或完整Proposition6.4/CORE结论。负责人语义签核pending。

原PDF277/printed256与278/printed257 currenttext核对并保存原raw ORIGINAL_PDF277_278.log；加权H1含q/p两gradient L2真实definition，Proposition6.4原Poisson/Fredholm说明不当作已证明。PDF239/268/272–275 priororiginaltext与239/268/273/278 priorvisual复用同exactPDF及278PNG hash，未新render277/278，完整H1space构造未冒称完成。

local01 unusedchange与single_le_sum inferred functionmetavar；02只hae零函数评价=0x不能用▸直接transport le目标，显式trans_eq；03扩入必要canonicalfullsupport/gradientpointwise/meanvalue时class实际在Measure namespace，04eq_of_ae_eq也在Measure，均改qualified实际API后05全12/private空log0。raw01–05保留，无options/resources/linter/transparency、新axiom或占位。exactsource/root/ledger冻结后统一验收一次。

'@
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$t.TrimEnd()+[char]10,$utf)
Save-LocalCheckpoint 'CanonicalEnergy12 local05空log零warning，唯一full01中' 'same actualcanonical真D/L product、fullweakFG及真可积导bilinear/energy、physicalnoise、actualclosedC0domain energy；compact smooth LF0给DpFµae0、actualcanonical fullsupport及smoothAE→pointwise/meanvalue动量独立共12public local05通过。原PDF277278文本raw保存、priorvisual278/hash复核。exactsource/root/DEP155 NOT164/273inputs冻结；H1/κInv/adjoint/core/Poisson未证。' '等唯一full01 all10zero/2728standardaxioms/273input/allSHA后allowlist提交；继续same originalweighted formaladjoint必要core/flux依赖，不重复C0核常数性。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
