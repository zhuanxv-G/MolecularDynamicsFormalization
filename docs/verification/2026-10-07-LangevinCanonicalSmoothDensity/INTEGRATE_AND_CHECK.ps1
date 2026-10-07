
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
 '既有最新正式验收基线LangevinCanonicalConjugation3：8434798a820bf166d5bbf2e2b9613d27605c1c9e，9192jobs/2740公理/275exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local03全3/private空log0。same normalizedcanonical真实L†ρF=ρLsharpF、physicalsqrt和smooth zeroexpression iff已证；closedadjoint/H1/core/实际κGibbsInv未证。'
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3十一批共98public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalSmoothDensity'
$source='MolecularDynamics/Chapter06/LangevinCanonicalSmoothDensity.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local02.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local02.log")).Trim().Length -ne 0){throw 'Local02 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
if(@(Get-CimInstance Win32_Process -Filter "Name='lean.exe' OR Name='lake.exe'").Count -gt 0){throw 'Active Lean'}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:def|theorem) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 7){throw 'Expected 7 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalSmoothDensity'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_same_canonical_measure_Nzero",
  "actual_smoothing": "normalized_true_compact_smooth_real_phase_kernel_with_auxiliary_addHaar_descended_by_proved_integer_periodicity",
  "actual_support": "original_torus_compact_times_true_compact_momentum_support_sum_no_compact_real_position_lift_claim",
  "true_uniform_smooth_compact_approximation": "proved_for_actual_continuous_compact_phase_functions",
  "true_canonical_L2_approximation": "proved_same_actual_canonical_measure_for_every_MemLp_two_function",
  "true_Hilbert_L2_dense_smooth_compact": "proved_actual_Lp_classes_and_AE_representatives",
  "no_density_or_core_or_adjoint_or_InvLaw_hypotheses": true,
  "auxiliary_addHaar_not_target_measure": true,
  "weighted_H1_derivative_closure": "not_proved",
  "closed_Hilbert_weighted_adjoint_domain": "not_proved",
  "weighted_H1_kernel_Proposition6_4": "not_proved_complete",
  "graph_core": "not_proved",
  "actual_probability_Gibbs_invariance": "not_proved",
  "actual_joint_positive_time_density_existence": "not_proved",
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_weighted_H1_and_Hilbert_adjoint_necessary_actual_smooth_compact_L2_test_density';actual_Hilbert_L2_density_distinct_from_generator_graph_core=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8


$claim='CH06-DEP-158,proposition_dependency,6,256-257,277-278,Proposition6.4_actual_canonical_Hilbert_L2_smooth_compact_test_density,Original_unitmass_U_Cinfty_periodic_beta_positive_Nzero_same_canonical_mu,no_density_core_adjoint_InvLaw_assumptions,textbookLangevinCanonicalL2_dense_smooth_compact,MolecularDynamics/Chapter06/LangevinCanonicalSmoothDensity.lean,responsible_pending,local02_passed_full_check01_pending,full-check01-LangevinCanonicalSmoothDensity,7public true_periodic_smoothing_support_uniform_approx_and_same_canonical_L2_density,GraphCore_H1Closure_ClosedAdjoint_ActualInv_Prop6.4_Core_pending'
$notation='NOT-CH06-167,Langevin_canonical_smooth_compact_L2_density,原canonical_Hilbert_L2_光滑紧支撑测试稠密性,256-257,277-278,Proposition6.4_weighted_H1_and_adjoint_domain_necessary_dependency,currentread277278_exactpriorraw_priorvisual278_hash,textbookLangevinCanonicalL2_dense_smooth_compact,MolecularDynamics/Chapter06/LangevinCanonicalSmoothDensity.lean,responsible_pending,local02_passed_full_check01_pending,full-check01-LangevinCanonicalSmoothDensity,7public sameactualcanonical L2dense no graphcore H1closure adjoint InvLaw hypothesis'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-158') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-167')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalSmoothDensity / CH06-DEP-158 / NOT-CH06-167：7public actual periodic phase smoothing，真实compact∞kernel以辅助addHaar归一化并卷积actualF real lift，integerperiodicity导回同torus且每real代表等式；真实momentum支持落在original support+kernel support的compactsum，位置由actualtoruscompact，不称real lift紧支撑；已证uniformprojection导实际continuouscompactF的∞compact uniformapprox，再由sameactualcanonical µ probability和真实continuouscompact L2approx得任意MemLp2逼近及actualHilbertLp测试dense。local02 clean；exactfull01待验。辅助addHaar只用于卷积核，目标µ未换；H1导数closure、generatorgraphcore、closedHilbertadjoint/κInv/完整Prop6.4未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalSmoothDensity：真实phase=(FinN→UnitAddCircle)×(FinN→ℝ)，N0保留；uniformapprox仅actualContinuous和HasCompactSupport F、ε正。canonical L2部分U∞unitperiodic β正、同actualcanonical probability µ，任意actualf MemLp2和ε正。normalizedcompact∞realphase kernel选择标准辅助Measure.addHaar，真实卷积periodicity、support compact与uniformprojection导approx，不假设smoothtestdensity/core/adjoint/InvLaw。原qreal lift通常非compact，用actualqtoruscompact及真实momentumcompactsum控制支持。仅L2dense；未给H1范数密度/导数closure或generator graphcore/closedadjoint/实际GibbsInv。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalSmoothDensity7 local02通过，唯一full01待验；sameactualcanonical HilbertL2 smoothcompactdensity，H1closure/graphcore/closedadjoint/actualInv/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalSmoothDensity'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='7公开声明服务原PDF277/printed256加权H1及278/printed257 Proposition6.4的Hilbert算子域/弱导数所需测试类稠密性。真实phase的actualcontinuouscompactF real lift与normalizedcompact∞kernel卷积，kernel辅助Measure.addHaar为固定mathlib标准平移不变有限维Haar；实际canonical µ为目标L2测度未改。逐integer位置平移下actualprojection不变，导卷积保periodicity并descend同torus，每real代表lift完全一致。∞来自truecompactkernel convolution API；支持通过真实support_convolution_subset，actualtoruscompact和momentum原support+kernel supportcompactsum，未把periodic real qlift称compact。'
$reviewText+=[char]10+[char]10+'实际continuouscompactF的uniformcontinuity与已证明actualprojection uniformcontinuous导uniformapprox；samecanonical trueprobability下continuouscompact L2approx加uniformapprox、真实eLpNorm bound/triangle导任意MemLp2 smoothcompactapprox；真实toLp/coercionAE/dist控制给sameHilbert L2 dense。N0保留，无density/graphcore/adjoint/domain/InvLaw假设。仅L2范数dense；未证明weightedH1导数闭包或H1范数dense、generatorgraphcore、closedHilbertadjointdomain、实际κGibbsInv或完整Prop6.4/PoissonFredholm/CORE。负责人semanticpending。'
$reviewText+=[char]10+[char]10+'local01 normed measure API位置参数误用、lambda卷积rw未归约和realphase product.volume缺Haar/invariant实例；改明确φ/implicitμ、change真实卷积及标准辅助addHaar，openFunction提供support。local02全7/private空log0。raw01–02 byteexact保留，未改目标测度或数学假设/资源/透明性/版本/linter/options。原277278当前读取复用sameacceptedraw，priorvisual278 unchanged hash，无新render。exactinputs冻结后唯一full01。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalSmoothDensity7 local02全部clean，唯一full01中' 'sameactualcanonical µ L2 smoothcompactdensity7public：真实辅助Haar normalized∞compactkernel、periodic descent、actualmomentumcompact support、uniformapprox、任意MemLp2approx与actualHilbert dense。local02全7/private空log0。DEP158/NOT167及formalinputs冻结；H1closure/graphcore/closedadjoint/κInv/完整Prop6.4未证。' '等待唯一full01实际jobs/2747standardaxioms/276inputs/all10zero/0Leanwarning及allSHA，allowlist验收提交后推进actualweightedH1导数闭包。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
