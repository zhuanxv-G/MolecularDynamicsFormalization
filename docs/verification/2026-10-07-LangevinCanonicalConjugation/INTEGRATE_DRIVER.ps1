
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
 '既有最新正式验收基线LangevinCanonicalWeightedAdjoint9：00f856053fbfc03f342f686cf00f7d3cbfafd752，9191jobs/2737公理/274exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local05全9/private空log0。sameactualcanonical joint无权pIBP、Hanti/OU Dirichlet symmetry、smoothcompact加权形式转置及actualC0已证测试域/action成立；closedHilbertadjoint/H1/core/实际κGibbsInv未证。'
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9十批共95public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalConjugation'
$source='MolecularDynamics/Chapter06/LangevinCanonicalConjugation.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local03.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local03.log")).Trim().Length -ne 0){throw 'Local03 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
if(@(Get-CimInstance Win32_Process -Filter "Name='lean.exe' OR Name='lake.exe'").Count -gt 0){throw 'Active Lean'}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:def|theorem) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 3){throw 'Expected 3 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalConjugation'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_actual_normalized_canonical_density_Nzero",
  "tests": "all_actual_smooth_periodic_phase_observables_no_compact_support_required",
  "true_normalized_density_conjugation": "proved_original_Lebesgue_forward_rhoF_equals_same_normalized_rho_times_canonical_weighted_minus_H_plus_O_expression_every_real_representative",
  "actual_derivative_dependencies": "true_actual_Dp_rho_Frechet_drift_split_L_and_D_product_true_classical_forward_rho0",
  "physical_sqrt_noise": "proved_real_square_root_actual_fluctuation_dissipation",
  "smooth_expression_zero_equivalence": "proved_by_actual_strict_positive_density_and_true_projection_surjectivity_not_closed_domain",
  "no_target_conjugation_forwardIBP_adjoint_core_InvLaw_hypotheses": "true_all_actual_calculus_dependencies_proved",
  "functional_Lebesgue_forward_adjoint_domain": "not_proved",
  "closed_Hilbert_weighted_adjoint_domain": "not_proved",
  "weighted_H1_extension": "not_proved",
  "weighted_H1_kernel_Proposition6_4": "not_proved_complete",
  "graph_core": "not_proved",
  "actual_probability_Gibbs_invariance": "not_proved",
  "actual_joint_positive_time_density_existence": "not_proved",
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_forward_Poisson_Gibbs_density_kernel_necessary_true_canonical_density_conjugation_all_smooth_periodic_observables';weighted_formal_expression_distinct_from_Lebesgue_forward_expression=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8

$claim='CH06-DEP-157,Original normalized canonical density conjugation and smooth zero-expression equivalence,6.4.4;Proposition6.4,256-257,277-278,necessary_proof_dependency,true_Lebesgue_forward_rhoF_equals_actual_normalized_rho_weightedLsharpF_true_Dp_rho_Lproduct_driftbasis_physicalnoise_strictpositive_zeroexpression_equivalence,docs/reviews/2026-10-07-LangevinCanonicalConjugation/REVIEW.zh-CN.md;docs/verification/2026-10-07-LangevinCanonicalConjugation/full-check01/CHECK_REPORT.json,local03_passed_full_check01_pending,unitmass_U_Cinfty_unitperiodic_beta_positive_Nzero_all_actualsmooth_Flift_noCompact_sigma2FD_expressionlevel,3public_true_actualnormalizeddensity_conjugation_not_closedoperator_domain_or_H1,MolecularDynamics/Chapter06/LangevinCanonicalConjugation.lean,ClosedAdjointDomain/H1Extension/GraphCore/ActualGibbsInv/PoissonFredholm/CorePending'
$notation='NOT-CH06-166,Langevin_canonical_density_conjugation,原归一化canonical密度共轭Ldagger_rhoF_equals_rho_LsharpF,256-257,277-278,Proposition6.4_forwardkernel_Gibbsdensity_necessary_proof_dependency,currentread277278_exactpriorraw_priorvisual278_hash,textbookLangevinForwardDifferentialOperator_canonical_conjugation,MolecularDynamics/Chapter06/LangevinCanonicalConjugation.lean,responsible_pending,local03_passed_full_check01_pending,full-check01-LangevinCanonicalConjugation,3public truecanonicaldensity conjugation physicalsqrt and smoothzero equivalence noH1closedadjoint core Inv orfullProp6.4'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-157') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-166')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalConjugation / CH06-DEP-157 / NOT-CH06-166：3public sameactualnormalized canonical density ρReal真实共轭L†(ρF)=ρLsharpF，每real representative/all smoothperiodicF不要求compact；真实σ²FD及physicalsqrt；真densitystrictpositive和projection满射给smooth forwardρF零与weightedformal LsharpF零等价。trueDpρ、actualL/D product、driftfinitebasis与既有true经典Aρ0消项，未假设共轭/adjoint/InvLaw。local03 clean；exactfull01待验。闭Lebesgue/加权Hilbertadjoint域/H1extension/core/κInv/完整Prop6.4未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalConjugation：原unitmass U∞unitperiodic β正 N0，F实际phase且real lift∞，不要求compact或integrable，σ²=2γ/β、物理版本γ正sqrt。same归一化ρReal是真fullpartition倒数乘实际GibbsWeight，与actualcanonicalρ每representative lift已证；既有trueAρ0和actualL/D product、实际Dpρ=−βpρ、driftfinitebasis导共轭。零表达式等价由实际ρstrictpos和真实surjective projection，不假设函数空间kernel/Poisson或adjoint/domain/InvLaw。全pointwise smooth表达式级别，不是closedHilbert/forwardadjoint域、H1extension/core或κInv/Prop6.4完成。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalConjugation3 local03通过，唯一full01待验；true samecanonical normalizeddensity conjugation/all smooth phase，closedadjoint/H1/core/actualInv/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalConjugation'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='3公开声明围绕原PDF277/printed256真实加权H1和278/printed257 Proposition6.4 forward Poisson/kernel Gibbsdensity所需共轭。same实际canonical归一化ρReal由真实fullpartition normalization和originalGibbsWeight组成，lift每real代表一致。真实forward A与backward L满足A f=L f−2Db f−divb f；actualL/D product、Dpρ=−βpρ和既有trueAρ0、σ²FD消项，有限coordinatebasis实际drift分解使剩余正好ρ(−H+O)F，得到每realrepresentative L†(ρF)=ρLsharpF。physical sqrt参数真实系数由Real.sq_sqrt证明。实际ρstrictpositive和真实projection满射给全phase LsharpF0iff全real forwardρF0，这是smooth expression级别，不是先假设kernel结论。'
$reviewText+=[char]10+[char]10+'scope unitmass U∞unitperiodic β正 N0，实际F real lift∞，不要求compact/separable或integration premise；γ任意FD下形式等式，physical γ正。L†为原Lebesgue forward真实expression，Lsharp为canonical加权形式transpose，现由真实rho连接但未定义/证明functionalclosed adjoint domain、H1extension、graphcore、实际κGibbsInv、完整Prop6.4 Poisson/Fredholm/compactresolvent或CORE。负责人semanticpending。原277278 currentread复用同已验收raw，priorvisual278同PNG hash，无新render。'
$reviewText+=[char]10+[char]10+'local01 heForward的change括号形状不匹配真实左结合表达式、heSum R/x别名未展开，改直接dsimp truex后ring及dsimp R/x后真实densitypartial rewrite；02全3/private成立，field_simp已完成coef使后继ring unreachable/unused，删除冗余ring后03全3/private空log0。raw01–03原样保留，未改statement、假设、版本或options/linter/resources。exactinputs冻结后唯一full01。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalConjugation3 local03全部clean，唯一full01中' 'same实际normalizedcanonical密度真正L†ρF=ρLsharpF，每real代表/all smooth periodicF不要求compact，真实Dpρ/Lproduct/driftbasis/Aρ0及FD，physicalsqrt与strictpos零表达式等价3public局部03空log0。DEP157/NOT166/275exactinputs冻结。functionalclosedadjoint/H1/core/κInv/完整Prop6.4未证。' '等唯一full01 9192jobs/2740standardaxioms/275input/all10zero/0Leanwarnings及全部SHA后allowlist提交；进入实际加权L2/H1闭包/算子域问题。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
