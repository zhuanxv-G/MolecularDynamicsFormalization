
function Save-LocalCheckpoint([string]$Title,[string]$Details,[string]$Next) {
 $stamp=[DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('yyyy-MM-dd HH:mm:ss zzz')
 $head=(git rev-parse HEAD).Trim()
 $branch=(git branch --show-current).Trim()
 $latest=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalMomentumClosedEnergy/ACCEPTANCE.json' -Raw | ConvertFrom-Json
 $lines=@(
 '# 当前可操作状态'
 "最后更新时间（Asia/Shanghai）：$stamp"
 '当前聊天01a10bc0-bc8d-7043-8df9-21a6b0bde09a；handoff ready/new_thread_id正确。'
 "工程C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization；branch $branch；HEAD $head。"
 '固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435，只本地。'
 "既有最新正式验收基线LangevinCanonicalMomentumClosedEnergy十三声明：$head，$($latest.jobs)jobs/2838公理/284exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local02十三声明空log0。γ>0原FD samecanonical实际graphnormmomentum导数CLM及有效closure延伸，各p闭graphmembership、actualclosedL完整域momentum导数及原energy、weakH1相容和kernelmomentum0已证；全qH1域包含/H1密度/全kernel常数性/actualgenerator身份/core/κInv/Poisson未证。"
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7、CanonicalHilbertGraph10、CanonicalHilbertClosed10、CanonicalHilbertDissipativity5、CanonicalCoordinateWeakDerivative11、CanonicalWeakH1十五声明、CanonicalH1MeanZero十六声明、CanonicalCoordinateClosed十一声明、CanonicalMomentumClosedEnergy十三声明二十批共196public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalKernelTransport'
$source='MolecularDynamics/Chapter06/LangevinCanonicalKernelTransport.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local01.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local01.log")).Trim().Length -ne 0){throw 'Local01 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
$prior=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalMomentumClosedEnergy/full-check01/CHECK_REPORT.json' -Raw | ConvertFrom-Json
if($prior.machine_check_status -ne 'passed' -or $prior.inputs.Count -ne 284){throw 'Previous baseline not accepted'}
foreach($i in $prior.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Prior exact input changed $($i.relative_path)"}}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:abbrev|def|theorem|instance) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 5){throw 'Expected 5 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalKernelTransport'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_gamma_strictly_positive_FD_same_canonical_measure_Nzero",
  "actual_Hamiltonian_test_L2": "proved_from_actual_original_H_equals_original_zero_friction_zero_noise_differential_expression",
  "actual_OU_coordinate_transpose_identity": "proved_literal_original_OU_equals_minus_gamma_over_beta_sum_p_transpose_of_DpG",
  "actual_closed_L_kernel_momentum_transpose_testing": "proved_from_entire_closed_domain_momentum_energy_and_true_coordinate_graph_pairing",
  "actual_closed_L_kernel_OU_testing": "proved_using_true_smooth_DpG_tests_literal_OU_identity_and_actual_L2_product_integrability",
  "actual_closed_L_kernel_Hamiltonian_testing": "proved_from_original_closed_graph_weighted_transpose_pairing_minus_H_plus_OU_and_actual_vanishing_OU_pairing",
  "all_actual_L2_test_products_integrable": "proved_in_original_canonical_measure",
  "no_momentum_independence_H1_domain_or_kernel_constancy_hypotheses": true,
  "full_closed_L_kernel_momentum_independence": "not_proved",
  "full_closed_L_kernel_q_weak_derivative_zero": "not_proved",
  "full_closed_L_kernel_constancy": "not_proved",
  "actual_closed_L_domain_full_q_and_p_H1_inclusion": "not_proved_or_assumed",
  "weighted_H1_norm_smooth_density": "not_proved",
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_actual_closed_L_kernel_momentum_OU_Hamiltonian_weak_testing_necessary_dependency';actual_kernel_weak_transport_distinct_from_p_independence_q_derivative_zero_full_constancy_or_Poisson=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8









$claim='CH06-DEP-167,Proposition6.4_dependency,6.4.4,256-257,277-278,analytic_dependency,实际closedL核的p转置OU及Hamiltonian弱测试0,local01_passed_full_check01_pending,responsible_pending,unitmass_U_Cinfty_unitperiodic_beta_positive_gamma_positive_FD_Nzero_same_actual_mu,p_independence_q_weak_derivative_zero_full_kernel_constancy_ActualInv_Prop6.4_CORE_pending,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_kernel_hamiltonian_testing,module=MolecularDynamics/Chapter06/LangevinCanonicalKernelTransport.lean;5public;实际closuretranspose测试与kernelmomentum0导literalOU和Hamiltonian配对0'
$notation='NOT-CH06-176,Langevin_canonical_kernel_weak_transport,原canonical实际闭L核的p转置OU和Hamiltonian弱测试,256-257,277-278,Proposition6.4_kernel_constancy_weak_transport_necessary_dependency,currentread277278_exactpriorraw_priorvisual278_hash,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_kernel_hamiltonian_testing,MolecularDynamics/Chapter06/LangevinCanonicalKernelTransport.lean,responsible_pending,local01_passed_full_check01_pending,full-check01-LangevinCanonicalKernelTransport,5public;真实核p导数0导p转置与OU配对0;实际Lclosuretranspose给Hamiltonian弱守恒;全kernel常数性未证'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-167') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-176')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalKernelTransport / CH06-DEP-167 / NOT-CH06-176：5public。原Hamiltonian测试实际同µL2，literalOU严格等于−γ/β各pAdjTest(DpG)之和。实际closedLkernel由已证全域energy得momentumvector0及真正coordinateclosedgraphpairing，故每ptranspose测试配对0；DpG真实lift∞compact且同µL2，原有限和/可积乘积给literalOU配对0。实际Lclosedgraph原transpose测试−H+OU为0，再按真正L2乘积可积拆积分，导actualkernel对原Hamiltonian测试的配对0。local01 clean；exactfull01待验。γ>0及原FD显式；未假设p独立/fullqH1域/全kernel常数性，p独立/qweak导数0/全kernel常数性、actualgeneratorcore/κInv/完整Prop6.4未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalKernelTransport：原samecanonicalµ，N允许0、unitmass、U∞unitperiodic、β>0、γ>0和实际FD σ²=2γ/β；前两puretest公式不额外要求kernel或fullH1。后3kernel测试从actualclosedLdomain且Af=0及已证全域energy/actualcoordinateclosedgraph/原weightedtranspose导出；每真compact∞测试及DpG实际同µL2、所有乘积integrable、literalOU因子是−γ/β。p独立/q弱导数0/完整核常数性未当假设或结果；全qH1域包含、H1smoothcore、generator身份或InvLaw均未用。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalKernelTransport5 local01通过，唯一full01待验；actualkernel ptranspose/OU/Hamiltonian弱测试0，p独立/q导数0/全kernel常数性/Prop6.4/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalKernelTransport'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='五声明服务原PDF278/printed257 Proposition6.4完整核常数性必要的弱传输步骤。原Hamiltonian测试严格等于原differential operator Uγ0σ0，已有真实compact∞ differentialmemLp导其同canonical L2。直接真实定义逐项代数证明literalOU=−γ/β∑Adj_p(DpG)，位置势没有参与这个p表达式，β>0仅用于真实非零β消去。'
$reviewText+=[char]10+[char]10+'actualclosedLkernel的full-domainenergy已证momentumvector0；真正coordinateclosedgraph与原closurepairing导任意compact∞ G的ptranspose积分配对0。DpG真实lift∞且compact，actualadjointTest类是真同µL2，实际f L2与每测试L2的乘积integrable，原OU finiteSumidentity给OU积分配对0。actualclosedL truegraphclosure的原weightedtranspose(−H+OU)配对0，H/O真实同µL2与产品可积允许原积分真实拆开；由OU0得原Hamiltonian弱测试0。没有假设kernel常数、p独立、fullH1core或新增stationarylaw。'
$reviewText+=[char]10+[char]10+'保持γ>0原FD范围及N0。仍未证actualkernel的p独立/q弱导数0/全kernel常数性，H1范数smoothdensity、actualgenerator身份/core、κGibbsInv、compactresolvent/Fredholm/完整Poisson/Prop6.4/CORE；负责人语义签核pending。local01全5/public/private首次emptylog0，无资源/透明性/linter选项。原277278复读并复用同SHA raw及既有visual278，无新render。冻结正式源码后唯一full01。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalKernelTransport5 local01 clean，唯一full01中' 'actualH测试L2、literalOU=−γ/β∑Adj_p(DpG)，actualclosedLkernel ptranspose/OU/Hamiltonian弱测试0，共5public。真实同µL2产品integrable，不假设p独立/fullH1core或全kernel常数。local01空log0，DEP167/NOT176/285formalinputs冻结。qweak导数0/fullkernel常数性、actualgeneratorcore/κInv/完整Prop6.4未证。' '等唯一full01实际jobs/2843standardaxioms/285inputs/all10zero/0Leanwarning/allSHA后allowlist验收；继续原weighted ptranspose/Hamiltonian testcommutator导q弱导数0及kernel真正H1，常数性另证。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
