
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
 '既有最新正式验收基线LangevinCanonicalEnergy12：3b23a309995561d277ca5b467039e1ab968aacd4，9190jobs/2728公理/273exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local05全12/private空log0。same actual canonical probability完整phase smoothcompact弱平衡、双线性/平方能量、actualclosedC0 generator测试能量、canonical fullsupport与smooth momentum-gradient AE到pointwise/independence已证；actualκGibbsInv未证。'
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12九批共86public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalWeightedAdjoint'
$source='MolecularDynamics/Chapter06/LangevinCanonicalWeightedAdjoint.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local05.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local05.log")).Trim().Length -ne 0){throw 'Local05 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
if(@(Get-CimInstance Win32_Process -Filter "Name='lean.exe' OR Name='lake.exe'").Count -gt 0){throw 'Active Lean'}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:def|theorem) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 9){throw 'Expected 9 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalWeightedAdjoint'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_actual_fullcanonical_probability_Nzero",
  "tests": "arbitrary_actual_phase_F_G_compact_Cinfty_real_lifts",
  "actual_unweighted_fullphase_momentum_IBP": "proved_true_Gaussian_slice_and_actual_joint_Fubini",
  "actual_Hamiltonian_antisymmetry": "proved_true_product_rule_and_zero_friction_zero_noise_classical_weak_balance_no_zero_friction_process_assumption",
  "actual_momentum_OU_dirichlet": "proved_full_joint_IBP_F_times_true_DpG_all_actual_integrability_Fcompact_Gsmooth",
  "actual_momentum_OU_symmetry": "proved_by_true_actual_Dirichlet_identity",
  "weighted_formal_transpose": "proved_expression_minus_H_plus_O_same_actual_mu_sigma2_equals_2gamma_over_beta",
  "actual_closed_C0_generator_test_transpose": "proved_same_actual_generator_proved_compact_smooth_domain_and_action",
  "Lebesgue_forward_adjoint_identification": "not_claimed_weighted_expression_is_distinct",
  "no_target_IBP_balance_InvLaw_adjoint_core_integrability_hypotheses": "true_all_analytic_dependencies_proved",
  "closed_Hilbert_adjoint_domain": "not_proved",
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
$local=[ordered]@{draft_path="$base/Draft.lean";source_path=$source;draft_sha256=$hash;source_sha256=$hash;local_check_log='local05.log';local_check_log_sha256=(Get-FileHash "$base/local05.log").Hash.ToLowerInvariant();local_exit_code=0;local_lean_warnings=0;local_log_empty=$true;exact_source_copy_verified=$true;public_declarations=$pub;integrated=$true;full_check='pending_full_check01'}
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_weighted_H1_and_forward_Poisson_conserved_quantity_duality_necessary_compact_smooth_weighted_transpose_dependency';weighted_formal_expression_distinct_from_Lebesgue_forward_expression=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8
$claim='CH06-DEP-156,Original canonical-weight formal transpose on compact smooth Langevin tests,6.4.4;Proposition6.4,256-257,277-278,necessary_proof_dependency,actual_joint_unweighted_pIBP_true_H_antisymmetry_OU_Dirichlet_symmetry_fullcanonical_formaltranspose_sameactual_C0testdomain_action,docs/reviews/2026-10-07-LangevinCanonicalWeightedAdjoint/REVIEW.zh-CN.md;docs/verification/2026-10-07-LangevinCanonicalWeightedAdjoint/full-check01/CHECK_REPORT.json,local05_passed_full_check01_pending,unitmass_U_Cinfty_unitperiodic_beta_positive_Nzero_actualcompact_FG_Cinfty_lifts_sigma2FD_expression_only_no_closedHilbertAdjoint_or_core,9public_true_actualcanonical_analytic_transpose_dependencies,MolecularDynamics/Chapter06/LangevinCanonicalWeightedAdjoint.lean,H1Extension/HilbertAdjointDomain/GraphCore/ActualGibbsInv/PoissonFredholm/CorePending'
$notation='NOT-CH06-165,Langevin_canonical_weighted_formal_adjoint_expression,原canonical权重形式转置表达式负H加OU,256-257,277-278,weightedH1_Proposition6.4_necessary_duality_dependency,currentread277278_exactpreviousraw_priorvisual278_samehash,textbookLangevinCanonicalWeightedFormalAdjointExpression,MolecularDynamics/Chapter06/LangevinCanonicalWeightedAdjoint.lean,responsible_pending,local05_passed_full_check01_pending,full-check01-LangevinCanonicalWeightedAdjoint,9public actualcanonical compact smooth transpose distinctLebesgueforward noHilbertclosedadjoint domain core Inv orH1extension'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-156') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-165')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalWeightedAdjoint / CH06-DEP-156 / NOT-CH06-165：9public 同实际fullcanonical无权joint动量IBP（trueGaussian slices/Fubini），真实H/O/Lsharp expression；真实product+零friction/noise经典weakbalance得H反对称，F*DpG真实jointIBP导OU Dirichlet/对称，完整weighted形式转置∫F LG=∫LsharpF G及sameactualclosedC0已证domain/action corollary。local05 clean；exactfull01待验。Lsharp=−H+O是canonical加权表达式，区别原Lebesgue L†，未证明closedHilbertadjointdomain/H1extension/core/κInv/完整Prop6.4。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalWeightedAdjoint：原unitmass U∞unitperiodic β正 N0，同真实canonical概率。phase F/G smooth lift∞及compact，OU Dirichlet仅Fcompact Gsmooth，其交换symmetry/fulltranspose两者compact；σ²=2γ/β仅原L split需。H anti用γ=σ=0经典表达式的真weakbalance，不假设零friction过程/半群；全部可积性从真实continuity/compact及actualprobability。joint无权pIBP从真实Gaussian p slices及全phase Fubini，非separable test。actualC0 corollary γ正真实Wiener/forceLipschitz/既有proveddomain/action，无targetIBP/energy/adjoint/core/InvLaw/integrability假设。weighted Lsharp=−H+O仅formal表达式，与Lebesgue forward L†分开，不计作Hilbertadjointclosed domain或graphcore/H1/κInv/Poisson/Fredholm完整结论。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalWeightedAdjoint9 local05通过，唯一full01待验；真实samecanonical smooth compact加权形式转置，closedHilbertadjoint/H1/core/实际Inv/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalWeightedAdjoint'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='9公开声明围绕原PDF277/printed256加权H1 notation及278/printed257 Proposition6.4正反算子/守恒量证明必要依赖。原PDF/currentread真实277278文本从已验收Energy同exactraw复用，priorvisual278同PNG哈希核对，无新render或完整原H1证明主张。真实fullcanonical无权pIBP从actualGaussian每Q切片及真实joint integrability/Fubini，适用任意紧支撑smooth phase test，不要求separable。H=Σ(pDq−DU Dp)，O=γΣ(βinvDpp−pDp)，Lsharp=−H+O明确定义为canonical加权形式转置，与原Lebesgue forward L†分开。H真product规则及γ=σ=0经典L的既有trueweakbalance给反对称，不声称零friction过程。对F*DpG施真jointIBP及Dproduct给∫F OG=−γβinv∫ΣDpF DpG，交换真实commutative乘积给OU对称；全部真实joint可积经continuous/compact/prob证明。结合真实原L split得∫F LG=∫LsharpF G，同actualclosedC0 genuineproved testdomain/action亦成立。'
$reviewText+=[char]10+[char]10+'scope unitmass U∞unitperiodic β正 N0，formaltranspose F/G genuinecompact∞real lifts σ²FD；OU Dirichlet只要求Fcompact G∞，H/symmetry两者compact，γ不要求positive除actualC0 corollary。无targetadjoint/core/IBP/energy/InvLaw/integrability前提。closedHilbertadjointdomain/H1extension/完整Prop6.4/graphcore/actualκGibbsInv/positive-timejointdensity/compactresolvent/Poisson/Fredholm未证，负责人semanticpending。'
$reviewText+=[char]10+[char]10+'local01 Unicode micro sign µ非合法binder与deprecated sum API，改普通canonicalLaw及固定API continuous_finsetSum；02 Pi.single direction type显式phase及integral_add neg函数eta显式lambda integrable；03 hiZ congr后Pi函数差应用先simp only再ring；04证明成立一条unusedsimp后移除Pi.mul_apply，05全9/private空log0。01–05保留原raw，无option/resource/linter/transparency、新axiom/unsafe或占位。exact source/root/ledger冻结统一full01。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalWeightedAdjoint9 local05全9/private clean，唯一full01中' '真实fullcanonical joint无权pIBP、H/O/Lsharp expression、H anti/OU Dirichlet symmetry、完整smoothcompact weightedformaltranspose及actualC0 domain/action9public local05空log0。DEP156/NOT165/274exactinputs冻结。H1extension/closedHilbertadjoint/core/κInv/完整Prop6.4未证；上一Energy12复用既有exact验收。' '等唯一full01 all10zero/2737standardaxioms/274input及raw/index/postcommit SHA后allowlist提交；继续density conjugation与真正weightedL2/H1闭包依赖。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
