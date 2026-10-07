
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
 '既有最新正式验收基线LangevinCanonicalHilbertGraph10：52319058b3e150f6ec12ddfefe18a472bdd0af79，9194jobs/2757公理/277exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local02全10/private空log0。sameactualcanonical Hilbert测试图domainDense/closuretranspose/zerovertical已证；完整closedpartialoperator/adjoint域/H1/实际semigroupgraphcore/κInv未证。'
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7、CanonicalHilbertGraph10十三批共115public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalHilbertClosed'
$source='MolecularDynamics/Chapter06/LangevinCanonicalHilbertClosed.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local05.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local05.log")).Trim().Length -ne 0){throw 'Local05 not clean'}
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
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalHilbertClosed'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_same_canonical_measure_Nzero_true_sigma_squared_FD",
  "actual_differential_linearity": "proved_actual_real_lift_first_and_second_Frechet_add_and_scalar_rules",
  "actual_test_graph_submodule": "constructed_from_same_compact_smooth_F_LF_AE_graph_using_actual_linearity_and_Lp_AE_operations",
  "actual_Hilbert_closed_realization": "constructed_from_true_test_graph_topologicalClosure_toLinearPMap_graph_proved_functional_no_junk",
  "actual_closed_operator_graph": "proved_exact_actual_smooth_test_graph_closure",
  "actual_closed_operator_domain_dense": "proved_by_actual_test_graph_domain_density_and_true_graph_inclusion",
  "actual_smooth_test_closed_graph_membership": "proved_same_F_and_literal_LF_actual_Lp_classes",
  "actual_Hilbert_adjoint_smooth_test_domain": "proved_actual_compact_smooth_classes_belong_to_constructed_closed_operator_adjoint_domain",
  "actual_Hilbert_adjoint_smooth_test_value": "proved_literal_original_canonical_weighted_minus_H_plus_O_L2_image_using_actual_domain_density",
  "no_operator_domain_or_graph_core_or_InvLaw_hypotheses": true,
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_actual_Hilbert_closed_realization_and_true_compact_smooth_adjoint_domain_action_necessary_dependency';actual_closed_realization_and_adjoint_tests_distinct_from_full_adjoint_domain_or_semigroup_graph_core=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8




$claim='CH06-DEP-160,proposition_dependency,6,256-257,277-278,Proposition6.4_actual_Hilbert_closed_realization_and_true_adjoint_tests,Original_unitmass_U_Cinfty_periodic_beta_positive_Nzero_same_canonical_mu_true_FD,no_domain_core_InvLaw_assumptions,textbookLangevinCanonicalHilbertClosedOperator_adjoint_smooth_apply,MolecularDynamics/Chapter06/LangevinCanonicalHilbertClosed.lean,responsible_pending,local05_passed_full_check01_pending,full-check01-LangevinCanonicalHilbertClosed,10public trueLlinearity_graphSubmodule_closedrealization_dense_smoothgraph_adjointdomain_and_action,FullAdjointDomain_H1Closure_SemigroupGeneratorIdentity_GraphCore_ActualInv_Prop6.4_Core_pending'
$notation='NOT-CH06-169,Langevin_canonical_Hilbert_closed_operator,原canonical_L2微分图闭算子及真实Hilbert伴随测试域作用,256-257,277-278,Proposition6.4_closed_operator_and_actual_adjoint_tests_necessary_dependency,currentread277278_exactpriorraw_priorvisual278_hash,textbookLangevinCanonicalHilbertClosedOperator_adjoint_smooth_apply,MolecularDynamics/Chapter06/LangevinCanonicalHilbertClosed.lean,responsible_pending,local05_passed_full_check01_pending,full-check01-LangevinCanonicalHilbertClosed,10public actualclosedrealization dense smoothgraph and genuineadjointtests no domain core InvLaw hypothesis'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-160') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-169')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalHilbertClosed / CH06-DEP-160 / NOT-CH06-169：10public actualL add/scalar真实C2Frechet导，sameactualF/LF测试图真Submodule，topologicalClosure.toLinearPMap的graph由既有zerovertical证为实际测试图closure而非junk；actualclosed partiallinearoperator isClosed/domainDense，实际compact∞F与LF两sameL2classes属closedgraph。trueclosuretranspose配对导真实Hilbertadjoint smoothtestdomain membership，并由actualdomainDense证adjointvalue正好literalLsharpF原加权−H+O。local05 clean；exactfull01待验。完整adjoint域刻画/weightedH1closure/actualL2semigroupgenerator身份及core/κInv/Prop6.4未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalHilbertClosed：actualL线性和测试图Submodule不需U regularity或FD，只actualphaseF/G real∞lift；closedrealization图非junk/isClosed/domainDense/adjoint测试需samecanonical µ N0 U∞unitperiodic β正 σ²=2γ/β，actualcompact∞tests。真正构造actualTestGraphSubmodule.topologicalClosure.toLinearPMap，graph_functional由此前actualL2dense/IBP得zerovertical，不假设闭域或core。actualsmoothF/LF图membership给domain，Hilbertadjointmembership由真实LsharpL2与closuretranspose配对给continuousfunctional，actualdomainDense导实际adjointvalue，未以adjointdomain/action作为假设。完整adjoint域/H1/semigroupgenerator身份/core/κInv/Prop6.4仍未完。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalHilbertClosed10 local05通过，唯一full01待验；actualclosedrealization/domainDense及genuineadjointtests/value，完整adjoint域/H1/semigroupgeneratorcore/actualInv/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalHilbertClosed'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='10公开声明服务原PDF277/printed256 weightedH1及278/printed257 Proposition6.4 closedoperator/adjoint域必要定义依赖。literalactualL在选定real代表的真实first/second Frechet规则导add/scalar线性；samecanonical Hilbert actualtestgraph由actualcompact∞F/LF两AEclasses构成，真LpAE加法与scalar给Submodule。对该真实图topologicalClosure.toLinearPMap，先用已有actualdense测试/weightedIBP得到zerovertical证明functionality，toLinearPMap graph确实为原测试图closure，不是junk。图closed与含真实dense测试domain给实际closedpartiallinearoperator、dense domain；actualF/LF同µtoLp两classes真实属graph。'
$reviewText+=[char]10+[char]10+'actualHilbert graphclosure transposeTesting对每真实compact∞G及每actualclosedoperator域元素成立；LsharpG入同L2，给有界Hilbert pairing，mem_adjoint_domain_of_exists证明G真正属于这个closedrealization的Hilbertadjoint域。用已证actualdomainDense保证adjoint不是非稠密junk，adjoint_apply_eq证明实际值等于literalcanonical加权−H+O。未宣称全adjoint域刻画、weightedH1extension/closure、actualstochasticL2semigroupgenerator身份或该generatorgraphcore/GibbsInv；完整Prop6.4 Poisson/Fredholm/compactresolvent/CORE仍未证。负责人semanticpending。'
$reviewText+=[char]10+[char]10+'local01–03是Pi函数与lambda的C2/fderiv/iterated rewrite形状和namediterated基点推断问题，改先保存明确lambda规则、显式真实z；Lp productscalar先change实际componentcoercion，graphmember先changeactualTestGraph；未改变statement/数学假设或任何资源/透明性/options。local04全部10/private证明0，只有global规则已涵盖的CML旧add_apply/smul_apply冗余deprecated/unused；删除两项后local05全10/private空log0。raw01–05 byteexact保留。原277278当前读取复用sameacceptedraw，priorvisual278 unchanged hash，无新render。exactinputs冻结后唯一full01。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalHilbertClosed10 local05全部clean，唯一full01中' '真实samecanonical测试图线性/Submodule，actualtopologicalClosure.toLinearPMap graph经zerovertical证非junk真实closure，actualisClosed/domainDense、smoothF/LF图membership，真实Hilbertadjoint测试domain及literalLsharpvalue10public。local05全10/private空log0，DEP160/NOT169/278formalinputs冻结。完整adjoint域/H1/actualsemigroupgeneratorcore/κInv/Prop6.4未完。' '等唯一full01实际jobs/2767standardaxioms/278inputs/all10zero/0Leanwarning/allSHA后allowlist验收；继续真实coordinate弱导数/weightedH1闭包或closedrealization energy/H1限界桥。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
