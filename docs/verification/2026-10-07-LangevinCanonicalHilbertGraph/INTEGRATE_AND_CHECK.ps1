
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
 '既有最新正式验收基线LangevinCanonicalSmoothDensity7：7e7d3c40605909ac2f91f52f62d7fa56b2d1c5d9，9193jobs/2747公理/276exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local02全7/private空log0。sameactualcanonical HilbertL2光滑紧支撑测试dense已证；H1closure/graphcore/closedadjoint/实际κGibbsInv未证。'
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7十二批共105public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalHilbertGraph'
$source='MolecularDynamics/Chapter06/LangevinCanonicalHilbertGraph.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local02.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local02.log")).Trim().Length -ne 0){throw 'Local02 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
if(@(Get-CimInstance Win32_Process -Filter "Name='lean.exe' OR Name='lake.exe'").Count -gt 0){throw 'Active Lean'}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:def|theorem) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 10){throw 'Expected 10 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalHilbertGraph'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_same_canonical_measure_Nzero",
  "actual_L2_embedding": "proved_continuous_compact_original_phase_MemLp_toLp_AE_and_true_integral_inner",
  "actual_differential_image_L2": "proved_literal_L_F_and_weighted_formal_transpose_Lsharp_F_actual_compact_smooth_tests",
  "actual_Hilbert_test_graph": "defined_by_actual_compact_smooth_F_and_AE_representatives_of_F_and_literal_LF",
  "actual_test_graph_domain_dense": "proved_using_accepted_actual_canonical_L2_smooth_compact_density",
  "graph_closure_weighted_transpose_testing": "proved_same_Hilbert_pairing_from_true_weighted_IBP_and_continuous_closed_equations",
  "graph_closure_zero_vertical": "proved_no_nonzero_vertical_limit_by_actual_dense_test_class",
  "no_graph_core_or_adjoint_domain_or_InvLaw_hypotheses": true,
  "closed_partial_operator_construction": "not_yet_defined_graph_linearity_and_functionality_remaining",
  "functional_Lebesgue_forward_adjoint_domain": "not_proved",
  "full_closed_Hilbert_weighted_adjoint_domain": "not_proved",
  "actual_L2_semigroup_generator_identification": "not_proved",
  "weighted_H1_derivative_closure": "not_proved",
  "graph_core_for_actual_semigroup_generator": "not_proved",
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_actual_Hilbert_operator_domain_necessary_true_differential_graph_closure_testing_and_zero_vertical';actual_Hilbert_graph_closure_testing_distinct_from_full_adjoint_domain_or_semigroup_graph_core=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8



$claim='CH06-DEP-159,proposition_dependency,6,256-257,277-278,Proposition6.4_actual_Hilbert_test_graph_closure_transpose_and_zero_vertical,Original_unitmass_U_Cinfty_periodic_beta_positive_Nzero_same_canonical_mu_true_FD,no_graphcore_adjointdomain_InvLaw_assumptions,textbookLangevinCanonicalHilbertTestGraph_closure_zero_vertical,MolecularDynamics/Chapter06/LangevinCanonicalHilbertGraph.lean,responsible_pending,local02_passed_full_check01_pending,full-check01-LangevinCanonicalHilbertGraph,10public truecompactL2_embedding_images_graph_domainDensity_closureTesting_zeroVertical,ClosedPartialOperatorConstruction_H1Closure_FullAdjoint_SemigroupGraphCore_ActualInv_Prop6.4_Core_pending'
$notation='NOT-CH06-168,Langevin_canonical_Hilbert_test_graph,原canonical_Hilbert_微分表达式测试图闭包及零竖直极限,256-257,277-278,Proposition6.4_operator_domain_necessary_dependency,currentread277278_exactpriorraw_priorvisual278_hash,textbookLangevinCanonicalHilbertTestGraph_closure_zero_vertical,MolecularDynamics/Chapter06/LangevinCanonicalHilbertGraph.lean,responsible_pending,local02_passed_full_check01_pending,full-check01-LangevinCanonicalHilbertGraph,10public actualgraph and transpose testing no core adjointdomain InvLaw hypothesis'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-159') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-168')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalHilbertGraph / CH06-DEP-159 / NOT-CH06-168：10public samecanonical µ actualcontinuouscompact MemLp/toLp/AE/inner，真实LF与LsharpF的compact/continuous导同L2；actualsmoothcompact testgraph定义为actualF与LF两AEclasses，domain由已证实际L2density真dense；既有trueweightedIBP在actualHilbert pair上成立，连续配对闭等式使测试transpose延伸truegraphclosure，dense测试导closure(0,g)必g0。local02 clean；exactfull01待验。仅graphclosure testing/novertical；未构造完整closedLinearPMap，未识别实际semigroupL2generator/closedadjoint全域或H1/core/κInv/Prop6.4。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalHilbertGraph：N0 sameactualcanonical µ，U∞unitperiodic β正；actualcontinuouscompactF的Lp嵌入与LF/LsharpF平方可积。图由真实compact∞phaseF和F/LF同µAErepresentative定义；closure配对和zerovertical另需真实σ²=2γ/β，γσ不另要求正。Lsharp compact来自Hamiltonian等于actualL000、实际D/D²compact及OUfinitecoeffsum；trueweightedIBP导closedpairingequation，测试dense来自此前真实canonicalL2density。无graphcore/closedadjointdomain/κInv或closedlinearoperator假设。未构造全部partialoperator/adjointdomain，未证明H1closure/semigroupgenerator身份/完整Prop6.4。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalHilbertGraph10 local02通过，唯一full01待验；actualHilbert图domainDense/closuretranspose/novertical，closedLinearPMap/fulladjoint/H1/semigroupcore/actualInv/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalHilbertGraph'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='10公开声明服务原PDF277/printed256 weightedH1和278/printed257 Proposition6.4实际Hilbert算子域的必要定义桥。sameactualcanonical probability µ上actualcontinuouscompactF MemLp2、toLp/AE与inner原真实加权积分一致。actualLF continuous/compact由既有C2表达式定理，Lsharp通过实际H=L000和OU D/D²真实compact及finitecoeffsum continuous/compact而入同L2。actualsmoothcompact differential graph只用真实F与literalLF在同µAEclasses，不假设图closure/adjoint/InvLaw结论。domainDense从真实既有actualcanonicalL2 smoothtestdensity获得。'
$reviewText+=[char]10+[char]10+'对每actualcompact∞G，既有真实weightedIBP给图上sameHilbert配对(g,G)=(f,LsharpG)。Hilbertinner连续使等式集closed，closure_minimal延伸actualgraphclosure。若closure(0,g)，则g正交于真实dense光滑紧支撑测试类，推出g=0。这里仅已证明测试图domainDense、closuretranspose/novertical；完整closedLinearPMap构造/graph线性与closurefunctionality仍待补；未将图识别为actualL2semigroupgenerator，未证明全Hilbertadjointdomain、H1closure/H1dense、actualsemigroupgraphcore、κInv、完整Prop6.4/PoissonFredholm/CORE。负责人semanticpending。'
$reviewText+=[char]10+[char]10+'local01 OUcompact未约束Pi.mulleft/sub类型推断实际触default200000heartbeat；未提高资源/透明性/options，改明确typed真实a_i/b_i函数和compactfinite函数sum；inner rw已完成删除冗余ring，transposeLF*G与G*LF补实际mulcomm。local02全10/private空log0，raw01–02 byteexact。原277278 currentread复用sameacceptedraw，priorvisual278 unchanged hash，无新render。exactinputs冻结后唯一full01。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalHilbertGraph10 local02全部clean，唯一full01中' '同actualcanonical µ真实compactLp嵌入/AE/inner、LF/LsharpF MemLp2、actualTestGraph与domainDense，trueweightedIBP闭等式导actualgraphclosure transpose及dense测试导zerovertical10public。local02全10/private空log0，DEP159/NOT168及formalinputs冻结。未构造完整closedLinearPMap/全adjoint域/实际semigroupgraphcore/H1/κInv/Prop6.4。' '等唯一full01实际jobs/2757standardaxioms/277inputs/all10zero/0Leanwarning/allSHA验收allowlist；下一实际测试图线性/闭图functionality和canonical闭partialoperator构造。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
