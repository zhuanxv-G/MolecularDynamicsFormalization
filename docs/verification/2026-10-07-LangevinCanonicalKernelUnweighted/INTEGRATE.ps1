
function Save-LocalCheckpoint([string]$Title,[string]$Details,[string]$Next) {
 $stamp=[DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('yyyy-MM-dd HH:mm:ss zzz')
 $head=(git rev-parse HEAD).Trim()
 $branch=(git branch --show-current).Trim()
 $latest=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalKernelWeakH1/ACCEPTANCE.json' -Raw | ConvertFrom-Json
 $lines=@(
 '# 当前可操作状态'
 "最后更新时间（Asia/Shanghai）：$stamp"
 '当前聊天01a10bc0-bc8d-7043-8df9-21a6b0bde09a；handoff ready/new_thread_id正确。'
 "工程C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization；branch $branch；HEAD $head。"
 '固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435，只本地。'
 "既有最新正式验收基线LangevinCanonicalKernelWeakH1八声明：$head，$($latest.jobs)jobs/2851公理/286exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local03八声明空log0。真实weighted commutator导actualkernel qtranspose0及真weakH1jet/value/全部q/pweak导数0；weakgradient0至constants/全kernel常数性/H1密度/actualgeneratorcore/κInv/Poisson未证。"
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7、CanonicalHilbertGraph10、CanonicalHilbertClosed10、CanonicalHilbertDissipativity5、CanonicalCoordinateWeakDerivative11、CanonicalWeakH1十五声明、CanonicalH1MeanZero十六声明、CanonicalCoordinateClosed十一声明、CanonicalMomentumClosedEnergy十三声明、CanonicalKernelTransport五声明、CanonicalKernelWeakH1八声明二十二批共209public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalKernelUnweighted'
$source='MolecularDynamics/Chapter06/LangevinCanonicalKernelUnweighted.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local05.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local05.log")).Trim().Length -ne 0){throw 'Local05 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
$prior=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalKernelWeakH1/full-check01/CHECK_REPORT.json' -Raw | ConvertFrom-Json
if($prior.machine_check_status -ne 'passed' -or $prior.inputs.Count -ne 286){throw 'Previous baseline not accepted'}
foreach($i in $prior.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Prior exact input changed $($i.relative_path)"}}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:abbrev|def|theorem|instance) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 8){throw 'Expected 8 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalKernelUnweighted'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_gamma_strictly_positive_FD_same_canonical_measure_Nzero",
  "actual_density_and_reciprocal_real_lift_smoothness": "proved_from_same_true_normalized_density_and_everywhere_positivity",
  "actual_density_coordinate_derivatives": "proved_literal_DR_equals_minus_coordinateLogSlope_times_R",
  "actual_reciprocal_coordinate_derivatives": "proved_true_product_rule_and_positivity",
  "actual_density_removed_coordinate_transpose": "proved_literal_AdjGoverR_equals_minus_DGoverR",
  "actual_canonical_L2_unweighted_locallyIntegrable": "proved_from_true_Rf_integrability_and_continuous_Rinverse_local_multiplier",
  "actual_canonical_L2_unweighted_DG_product_integrable": "proved_actual_withDensity_integrability_and_true_compact_smooth_GoverR_tests",
  "actual_closed_L_kernel_unweighted_coordinate_testing": "proved_true_Haar_times_Lebesgue_integral_zero",
  "no_global_reciprocal_bound_or_constant_kernel_hypothesis": true,
  "weak_zero_gradient_implies_actual_canonical_constant": "not_proved",
  "full_closed_L_kernel_constancy": "not_proved",
  "weighted_H1_norm_smooth_density": "not_proved",
  "actual_L2_semigroup_generator_identification": "not_proved",
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_actual_closed_L_kernel_true_unweighted_coordinate_testing_and_local_integrability';actual_kernel_true_unweighted_testing_distinct_from_full_constancy_or_Poisson=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8









$claim='CH06-DEP-169,Proposition6.4_dependency,6.4.4,256-257,277-278,analytic_dependency,真实消密度权重的actual闭L核普通弱测试0和局部可积,local05_passed_full_check01_pending,responsible_pending,unitmass_U_Cinfty_unitperiodic_beta_positive_gamma_positive_FD_Nzero_same_actual_mu,ordinary_weak_zero_gradient_to_constant_full_kernel_constancy_ActualInv_Prop6.4_CORE_pending,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_kernel_unweighted_coordinate_testing,module=MolecularDynamics/Chapter06/LangevinCanonicalKernelUnweighted.lean;8public;真实G/R测试去除权重并证明reference局部可积与fDG可积'
$notation='NOT-CH06-178,Langevin_canonical_kernel_unweighted_testing,原canonical实际闭L核Haar乘Leb普通弱测试,256-257,277-278,Proposition6.4_kernel_constancy_unweighted_necessary_dependency,currentread277278_exactpriorraw_priorvisual278_hash,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_kernel_unweighted_coordinate_testing,MolecularDynamics/Chapter06/LangevinCanonicalKernelUnweighted.lean,responsible_pending,local05_passed_full_check01_pending,full-check01-LangevinCanonicalKernelUnweighted,8public;density及reciprocal真∞和coordinate导数;G/Rtranspose取消slope;originalL2 reference局部可积;kernel普通weak测试0'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-169') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-178')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalKernelUnweighted / CH06-DEP-169 / NOT-CH06-178：8public。真实canonical density R和Rinv的lift∞从原partition及真positivity导出；逐q/p原curve微分给DR=−slopeR，真productrule与RRinv=1给Dinv=slopeRinv。原transpose产品公式给Adj(G/R)=−DG/R。实际canonical L2 f在probability下L1，withDensity真实转换导Rf在Haar×Leb可积，continuousRinv局部乘积导真LocallyIntegrable f；compact∞ G/R和actualtranspose同µL2给真实fDG在reference可积，actualkernel q/ptranspose0真转成Haar×Leb ordinaryweak coordinate testing0。local05 clean；exactfull01待验。无需全局Rinv界或kernel常数性；ordinary弱零梯度⇒constant/完整核常数性/H1normdensity/actualgeneratorcore/κInv/完整Prop6.4仍未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalKernelUnweighted：原samecanonicalµ，unitmass、N0有效、U∞unitperiodic、β>0，后kernel测试实际γ>0与FD及actualclosedLdomain/Af=0。Rinv smooth来自原density处处positive，不假设noncompactphase上的globalbound。Rf实际reference可积通过原withDensity和canonicalprobabilityL2⇒L1，局部Rinv连续乘积导f真LocallyIntegrable；fDG真实可积单独证明后保留kernel普通弱测试0。没有假设ordinaryweak0⇒constant、H1smoothcore、generator身份或InvLaw。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalKernelUnweighted 8public local05通过，唯一full01待验；actualL2真reference局部可积/fDG可积及actualkernel ordinaryweak测试0，常数性/Prop6.4/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalKernelUnweighted'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='八声明是PDF278/printed257原核常数性所需消权重步骤。原density R实际partitionnormalized且处处positive；trueRlift∞及positive inverse∞。真实qcurve从原U Frechet和exp求导，pcurve复用实际原GibbsGaussian求导给DR=−slopeR；RRinv=1真product导Dinv=slopeRinv，原transpose真乘积律导Adj(G/R)=−DG/R。无需noncompactphase全局inversebound。'
$reviewText+=[char]10+[char]10+'canonical actualL2 f在实际probability下L1，通过原withDensity integrability iff得到Rf在真正Haar×Leb可积，再continuousRinv局部乘积给f真LocallyIntegrable。G/R真实∞compact，actualadjointtest同µL2给fAdj(G/R)实际可积，原withDensity等价和pointwisepositivity消R导reference fDG真正可积。actualclosedLkernel q/ptranspose0应用到这个真测试，原density integral identity与literaltransposeformula导每普通coordinate DG积分0。没有以totalized integral替代可积。'
$reviewText+=[char]10+[char]10+'local01 vector/module shape、derivative点及依赖µ重写失败；local02修真实闭函数/using!，补LocallyIntegrable，仍负函数形状及unused ring；local03剩负函数形状，local04用integrable_neg_iff编译通过但仍有unused ring，local05删除确切多余tactic。8public/private clean emptylog0，raw01–05全保留，未用资源/透明性/linter选项。ordinaryweak0⇒constant/完整kernelconstancy/H1normdensity/actualgeneratorcore/κInv/Poisson/Prop6.4/CORE未证，负责人semantic pending。原277278复读复用exactraw/priorvisual278，无newrender。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalKernelUnweighted 8public local05 clean，唯一full01中' 'actualdensity/reciprocal∞及全部coordinate微分，literalAdj(G/R)=−DG/R，原canonical L2类真Haar×Leb LocallyIntegrable/fDG integrable及actualkernel ordinaryweak测试0；未假设globalinversebound或常数性。local05空log0，DEP169/NOT178/287formalinputs冻结，raw01–05保留。' '等唯一full01 actualjobs/2859standardaxioms/287inputs/all10zero/0Leanwarning/allSHA，再自身allowlist验收；下一phase平移测试微分及ordinaryweak0至constant桥。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
