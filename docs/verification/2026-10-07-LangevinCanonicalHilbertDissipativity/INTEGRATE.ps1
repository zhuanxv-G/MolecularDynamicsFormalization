
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
 '既有最新正式验收基线LangevinCanonicalHilbertClosed10：fe54a5f20934b41bfc0166bdec8553a9c40bc521，9195jobs/2767公理/278exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local05全10/private空log0。sameactualcanonical true测试图closure构造closedpartialoperator、domainDense、actualsmoothtest adjointdomain与literalLsharp值已证；全adjoint域/H1/actualsemigroupgenerator/core/κInv未证。'
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7、CanonicalHilbertGraph10、CanonicalHilbertClosed10十四批共125public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalHilbertDissipativity'
$source='MolecularDynamics/Chapter06/LangevinCanonicalHilbertDissipativity.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local03.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local03.log")).Trim().Length -ne 0){throw 'Local03 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:def|theorem) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 5){throw 'Expected 10 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalHilbertDissipativity'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_same_canonical_measure_Nzero_true_sigma_squared_FD",
  "actual_test_graph_energy_nonpositive": "proved_from_original_canonical_energy_and_true_AE_L2_classes",
  "actual_graph_closure_pairing_nonpositive": "proved_by_continuity_on_true_smooth_test_graph_closure",
  "actual_closed_operator_dissipativity": "proved_on_every_element_of_true_closed_operator_domain",
  "positive_shift_norm_bound": "proved_norm_f_le_norm_r_f_minus_g_div_r_for_r_positive_on_true_graph_closure",
  "actual_closed_operator_positive_shift_injective": "proved_on_actual_domain_by_true_graph_difference_and_norm_bound",
  "gamma_beta_inverse_nonnegative": "derived_from_actual_sigma_squared_fluctuation_dissipation_identity",
  "no_extra_operator_domain_core_InvLaw_or_dissipativity_hypotheses": true,
  "full_graph_domain_energy_identity_or_weighted_H1_estimate": "not_proved",
  "positive_shift_surjectivity_or_resolvent_existence": "not_proved",
  "full_closed_Hilbert_adjoint_domain_characterization": "not_proved",
  "actual_L2_semigroup_generator_identification": "not_proved",
  "weighted_H1_derivative_closure": "not_proved",
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_true_canonical_closed_Hilbert_dissipativity_and_positive_shift_norm_injectivity_necessary_dependency';actual_closed_dissipativity_distinct_from_H1_energy_identity_or_resolvent_surjectivity=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8





$claim='CH06-DEP-161,Proposition6.4_dependency,6.4.4,256-257,277-278,analytic_dependency,实际canonical闭Hilbert算子耗散及正移位范数下界与单射性,local03_passed_full_check01_pending,responsible_pending,unitmass_U_Cinfty_unitperiodic_beta_positive_true_FD_Nzero_same_actual_mu,H1_energy_identity_resolvent_surjectivity_SemigroupGeneratorIdentity_GraphCore_ActualInv_Prop6.4_CORE_pending,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_shift_injective,module=MolecularDynamics/Chapter06/LangevinCanonicalHilbertDissipativity.lean;5public;真实能量导耗散而非作为假设'
$notation='NOT-CH06-170,Langevin_canonical_Hilbert_dissipativity,原canonical闭Hilbert算子耗散和正移位范数下界,256-257,277-278,Proposition6.4_closed_operator_estimates_necessary_dependency,currentread277278_exactpriorraw_priorvisual278_hash,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_shift_injective,MolecularDynamics/Chapter06/LangevinCanonicalHilbertDissipativity.lean,responsible_pending,local03_passed_full_check01_pending,full-check01-LangevinCanonicalHilbertDissipativity,5public;真实图与真实域;没有移位满射或完整Poisson结论'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-161') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-170')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalHilbertDissipativity / CH06-DEP-161 / NOT-CH06-170：5public。实际canonical compact∞测试图的Hilbert配对由原能量恒等式非正，σ²=2γ/β直接导γβ⁻¹非负；通过内积连续性扩展到真实图闭包及已构造闭算子的每个实际域元素。Hilbert Cauchy–Schwarz与非零范数消去导r>0时‖f‖≤‖r•f−g‖/r；应用真实图的差证明rI−A在真实域上单射。local03 clean；exactfull01待验。完整H1能量恒等式、移位满射/预解式存在、semigroupgenerator身份/core/GibbsInv/Prop6.4仍未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalHilbertDissipativity：同一原canonical µ，N允许0，unitmass、U∞且unitperiodic、β>0、σ²=2γ/β；正移位另需真实r>0。未额外假设γ≥0或耗散性，它们的所需符号从实际FD及σ²≥0推出。真正使用既有同µ实际compact∞F/LF AE图、真实图闭包和已证明无竖直分量的闭算子；差的图元素来自实际Submodule。r>0用于除法及单射结论，未将移位满射、完整H1梯度域、semigroupgenerator身份或GibbsInv隐藏为假设。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalHilbertDissipativity5 local03通过，唯一full01待验；实际闭Hilbert算子耗散及正移位范数下界/单射，移位满射/H1/完整Prop6.4/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalHilbertDissipativity'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='五个公开声明补充原PDF277/printed256 weightedH1与278/printed257 Proposition6.4所需真实闭算子估计。原canonical能量等式及实际F/LF两L2类的AE代表得到测试图内积非正；σ²=2γ/β与真实平方非负给γβ⁻¹≥0，无额外γ或耗散性假设。内积是连续函数，非正集合闭，故真实图闭包仍耗散；已证的actualclosedoperator_graph将它落实到每个实际定义域元素。'
$reviewText+=[char]10+[char]10+'对真实图闭包中的(f,g)，展开内积并使用Hilbert Cauchy–Schwarz得r‖f‖²≤‖f‖‖r•f−g‖。f=0分支直接，f≠0用严格正范数消去，然后r>0给‖f‖≤‖r•f−g‖/r。对真实闭算子域f/g，图Submodule的实际差及此界证明rI−A单射。没有建立其满射、预解式存在或紧性，也没有把完整weightedH1梯度范数/能量恒等式延伸到闭域；actualL2semigroupgenerator身份/core、κGibbsInv、完整Poisson/Fredholm/Prop6.4/CORE仍未证，负责人语义签核pending。'
$reviewText+=[char]10+[char]10+'local01：rw已经完成Hilbert内积等式而后续exact多余，λ保留字参数解析失败；删冗余步骤，改实数r/hr。local02：固定版本mul_le_mul_left是右乘保序而非Iff，按真实固定源码换le_of_mul_le_mul_left he hn。local03五个声明全部空log0，无资源/透明性/linter选项或statement弱化。raw01–03按字节保留。原277278已读，复用同SHA原文本与既有visual278，无新render。冻结正式源码后唯一full01。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalHilbertDissipativity5 local03 clean，唯一full01中' '实际canonical测试图、图闭包及闭算子全域耗散，真实正移位范数下界及实际域单射5public。local03空log0，DEP161/NOT170/279formalinputs冻结。完整H1能量恒等式、移位满射/预解式、actualsemigroupgenerator身份/core、κInv/Prop6.4未证。' '等唯一full01实际jobs/2772standardaxioms/279inputs/all10zero/0Leanwarning/allSHA后allowlist验收；接续真实coordinate弱导数/weightedH1闭包。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
