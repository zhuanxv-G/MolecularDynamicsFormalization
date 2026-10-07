
function Save-LocalCheckpoint([string]$Title,[string]$Details,[string]$Next) {
 $stamp=[DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('yyyy-MM-dd HH:mm:ss zzz')
 $head=(git rev-parse HEAD).Trim()
 $branch=(git branch --show-current).Trim()
 $latest=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalH1MeanZero/ACCEPTANCE.json' -Raw | ConvertFrom-Json
 $lines=@(
 '# 当前可操作状态'
 "最后更新时间（Asia/Shanghai）：$stamp"
 '当前聊天01a10bc0-bc8d-7043-8df9-21a6b0bde09a；handoff ready/new_thread_id正确。'
 "工程C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization；branch $branch；HEAD $head。"
 '固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435，只本地。'
 "既有最新正式验收基线LangevinCanonicalH1MeanZero十六声明：$head，$($latest.jobs)jobs/2814公理/282exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local02十六声明空log0。sameactualcanonical 真实H1常数/constantAE/weak导数0/norm|c|，H1value L1和true mean CLM=原integral/meanconstant/normbound1，原mean-zero closed complete空间及实际centering已证；closedL全kernel/H1范数密度/完整域能量/semigroupgenerator身份/core/κInv未证。"
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7、CanonicalHilbertGraph10、CanonicalHilbertClosed10、CanonicalHilbertDissipativity5、CanonicalCoordinateWeakDerivative11、CanonicalWeakH1十五声明、CanonicalH1MeanZero十六声明十八批共172public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalCoordinateClosed'
$source='MolecularDynamics/Chapter06/LangevinCanonicalCoordinateClosed.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local01.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local01.log")).Trim().Length -ne 0){throw 'Local01 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
$prior=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalH1MeanZero/full-check01/CHECK_REPORT.json' -Raw | ConvertFrom-Json
if($prior.machine_check_status -ne 'passed' -or $prior.inputs.Count -ne 282){throw 'Previous baseline not accepted'}
foreach($i in $prior.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Prior exact input changed $($i.relative_path)"}}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:abbrev|def|theorem|instance) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 11){throw 'Expected 11 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalCoordinateClosed'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_same_canonical_measure_Nzero_coordinates_independent_of_gamma_sigma",
  "actual_coordinate_Frechet_add_and_scalar_linearity": "proved_on_original_periodic_real_lift",
  "actual_coordinate_test_graph_submodule": "proved_from_true_F_DjF_AE_representatives_and_actual_linearity",
  "actual_minimal_closed_coordinate_operator": "constructed_from_actual_original_test_graph_topological_closure_toLinearPMap",
  "actual_minimal_coordinate_graph_functionality": "proved_using_actual_dense_test_zero_vertical",
  "actual_minimal_coordinate_operator_graph": "proved_equal_to_true_test_graph_topological_closure",
  "actual_minimal_coordinate_operator_isClosed": "proved_from_actual_graph_closure",
  "actual_minimal_coordinate_operator_dense_domain": "proved_contains_true_dense_original_smooth_test_domain",
  "actual_smooth_coordinate_closed_graph_membership": "proved_for_genuine_F_and_DjF_same_measure_L2_classes",
  "actual_smooth_coordinate_adjoint_domain_membership": "proved_from_actual_original_weighted_transpose_pairing",
  "actual_smooth_coordinate_adjoint_value": "proved_literal_minus_DjG_plus_logSlope_j_G_in_same_canonical_L2",
  "actual_weakH1_coordinate_compatibility": "proved_on_actual_minimal_closed_coordinate_domain_by_dense_tests_and_weak_derivative_uniqueness",
  "weakH1_minimal_domain_membership_hypothesis": "explicit_actual_domain_intersection_for_compatibility_only_not_full_domain_identity",
  "actual_weighted_weak_H1_complete_space_and_norm": "already_proved_in_accepted_previous_batch",
  "minimal_coordinate_domain_equals_full_weak_derivative_domain": "not_proved",
  "weighted_H1_norm_smooth_density": "not_proved",
  "full_closed_L_momentum_energy_extension": "not_proved",
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_actual_minimal_closed_coordinate_derivatives_and_weak_H1_compatibility_necessary_dependency';actual_minimal_coordinate_closed_domain_distinct_from_full_weak_H1_domain_or_norm_density=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8







$claim='CH06-DEP-165,Proposition6.4_dependency,6.4.4,256-257,277-278,analytic_dependency,原canonical坐标最小闭导数与weakH1相容桥,local01_passed_full_check01_pending,responsible_pending,unitmass_U_Cinfty_unitperiodic_beta_positive_Nzero_same_actual_mu,minimal_vs_weak_domain_equality_H1_smooth_density_closedL_energy_kernel_ActualInv_Prop6.4_CORE_pending,MolecularDynamics.textbookLangevinCanonicalCoordinateClosedOperator_weakH1_apply,module=MolecularDynamics/Chapter06/LangevinCanonicalCoordinateClosed.lean;11public;真实graphclosure闭导数及adjointsmooth值;weakH1相容只在实际minimaldomain'
$notation='NOT-CH06-174,Langevin_canonical_minimal_closed_coordinate_derivatives,原canonical坐标最小闭导数与weakH1相容,256-257,277-278,Proposition6.4_weighted_H1_coordinate_closed_derivative_necessary_dependency,currentread277278_exactpriorraw_priorvisual278_hash,MolecularDynamics.textbookLangevinCanonicalCoordinateClosedOperator_weakH1_apply,MolecularDynamics/Chapter06/LangevinCanonicalCoordinateClosed.lean,responsible_pending,local01_passed_full_check01_pending,full-check01-LangevinCanonicalCoordinateClosed,11public;真实闭坐标导数图与dense域;实际smoothadjoint值;最小域与全weak域等同性未证'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-165') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-174')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalCoordinateClosed / CH06-DEP-165 / NOT-CH06-174：11public。真实real lift一阶Frechet导数add/smul导actualcoordinate testGraph为submodule。其topologicalClosure转成LinearPMap，用已证sameµdense tests的zerovertical证明实际graph严格等于此closure，从而closed及domainDense；每真实compact∞ F和DjF确在实际closedgraph。原transpose pairing导smoothadjoint域和literal −DjG+logSlope_j G值。若trueweakH1value属于这个实际minimalclosedcoordinate domain，dense tests和两真实pairing证明operator值等于其唯一weakH1derivative；这个交集条件没有冒充全weakH1域等于minimaldomain。local01 clean；exactfull01待验。fullweakH1/minimaldomain等同性、H1范数密度、closedL全动量能量/全kernel、actualgenerator身份/core/κInv/Prop6.4未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalCoordinateClosed：同原canonicalµ，N允许0、unitmass、U∞且unitperiodic、β>0；实际smooth测试真实phasecompact及lift∞；γ/σ/FD不参与同µ坐标导数闭图及adjoint测试。coordinate最小闭域定义为原真实smoothtestgraph的topologicalclosure，其functionality/closed/dense/smoothtests和literaladjoint测试值均实证。weakH1compatibility的域条件只是explicit actualminimaldomain交集；没有假设全weakH1域=minimaldomain或H1smoothnormdensity。已验收真实weakH1 complete/norm/mean-zero保留，closedL全动量能量/kernel以及一般Poisson未完。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalCoordinateClosed11 local01通过，唯一full01待验；真实坐标minimalclosed算子、dense域、smoothadjoint值及weakH1交集相容；全weak域等同/H1密度/closedL能量及kernel/Prop6.4/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalCoordinateClosed'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='十一声明服务原PDF277/printed256 H1和278/printed257 Proposition6.4的闭坐标导数依赖。原真实lift Frechet一阶导数证明方向导数add/smul。两真实samecanonical L2 AE类构成originalcompact∞ coordinate testgraph，并按实际AE add/smul证明其submodule。对真正的topologicalClosure调用LinearPMap构造，已证actualzerovertical给graph严格等于closure，因此实际算子closed、actualdomainDense；原每个真正smoothcompact F/DjF实际graphmembership均从原AE代表导出。'
$reviewText+=[char]10+[char]10+'真实coordinateclosurepairing给所有actualminimaldomain上的weightedtranspose测试；从真实LinearPMap adjoint定义证明compact∞ G属于actualadjoint域，并按actualdomainDense证明其值就是原literal −DjG+logSlope_j G的同µL2类，不是形式表达式登记。若一个已经构造的trueweakH1函数的value另外属于这个actualminimalclosedcoordinate domain，比较原closurepairing和真正H1weakpairing，sameµsmoothtestdensity迫使actualoperator值等于唯一weakH1坐标导数。该明确交集条件没有隐藏全weak域等同、光滑H1密度、closedL core或Poisson结论。'
$reviewText+=[char]10+[char]10+'原trueweakH1闭Hilbert空间/norm/mean/closedmean-zero在前批已验收。仍未证minimalcoordinate域等于全weakderivative域、H1范数smoothdensity、closedL全动量能量与全kernel、actualsemigroupgenerator身份/core、κGibbsInv、完整Poisson/Fredholm/Prop6.4/CORE；负责人语义签核pending。local01记录真实11public/private检查结果，不设置资源/透明性/linter选项。原277278当前再次读，同SHA raw及既有visual278复用，无新render。冻结正式源码后唯一full01。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalCoordinateClosed11 local01 clean，唯一full01中' '实际坐标realFrechet add/smul、testgraphsubmodule及trueclosure闭算子、actualgraph/isClosed/domainDense/smoothgraph、actualsmoothadjoint域和值，及与trueweakH1坐标导数在实际minimaldomain交集上一致11public。local01空log0，DEP165/NOT174/283formalinputs冻结。全weak/minimal域等同与H1范数密度、closedL全动量能量及kernel、actualgeneratorcore/κInv/Prop6.4未证。' '等唯一full01实际jobs/2825standardaxioms/283inputs/all10zero/0Leanwarning/allSHA后allowlist验收；下一从actualclosedL graphclosure的能量估计构造动量闭导数并延伸实际能量，先不声称closedLdomain包含全H1。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
