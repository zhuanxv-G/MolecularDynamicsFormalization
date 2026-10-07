
function Save-LocalCheckpoint([string]$Title,[string]$Details,[string]$Next) {
 $stamp=[DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('yyyy-MM-dd HH:mm:ss zzz')
 $head=(git rev-parse HEAD).Trim()
 $branch=(git branch --show-current).Trim()
 $latest=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalKernelContinuousTest/ACCEPTANCE.json' -Raw | ConvertFrom-Json
 $lines=@(
 '# 当前可操作状态'
 "最后更新时间（Asia/Shanghai）：$stamp"
 '当前聊天01a10bc0-bc8d-7043-8df9-21a6b0bde09a；handoff ready/new_thread_id正确。'
 "工程C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization；branch $branch；HEAD $head。"
 '固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435，只本地。'
 "既有最新正式验收基线LangevinCanonicalKernelContinuousTest七声明：$head，$($latest.jobs)jobs/2879公理/290exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local02七声明空log0。原smoothapprox真正samecompact支持和uniformapprox、reference translatedf localL1/实际积分errorbound，所有continuouscompact测试泛函phase shiftinvariance已证；roughkernel AE常数/完整kernelidentity/H1密度/actualgeneratorcore/κInv/Poisson未证。"
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7、CanonicalHilbertGraph10、CanonicalHilbertClosed10、CanonicalHilbertDissipativity5、CanonicalCoordinateWeakDerivative11、CanonicalWeakH1十五声明、CanonicalH1MeanZero十六声明、CanonicalCoordinateClosed十一声明、CanonicalMomentumClosedEnergy十三声明、CanonicalKernelTransport五声明、CanonicalKernelWeakH1八声明、CanonicalKernelUnweighted八声明、CanonicalKernelShift七声明、CanonicalKernelPairingShift六声明、CanonicalKernelContinuousTest七声明二十六批共237public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-08-LangevinCanonicalKernelConstant'
$source='MolecularDynamics/Chapter06/LangevinCanonicalKernelConstant.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local04.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local04.log")).Trim().Length -ne 0){throw 'Local04 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
$prior=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalKernelContinuousTest/full-check01/CHECK_REPORT.json' -Raw | ConvertFrom-Json
if($prior.machine_check_status -ne 'passed' -or $prior.inputs.Count -ne 290){throw 'Previous baseline not accepted'}
foreach($i in $prior.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Prior exact input changed $($i.relative_path)"}}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:abbrev|def|theorem|instance) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 6){throw 'Expected 6 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalKernelContinuousTest'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_gamma_strictly_positive_FD_same_canonical_measure_Nzero",
  "actual_continuous_compact_test_dual": "proved_true_compact_thickened_indicator_DCT_actual_locally_L1_integrable_dominator",
  "actual_kernel_reference_AE_each_phase_shift": "proved_actual_continuous_test_pairing_and_true_integral_sub_products_integrable",
  "actual_kernel_reference_AE_constant": "proved_true_Borel_measurable_representative_actual_Fubini_AE_quantifiers_nonzero_Haar_times_Lebesgue_and_inverse_translation",
  "actual_kernel_original_canonical_AE_constant": "proved_original_withDensity_absolute_continuity_from_actual_reference_constancy",
  "actual_kernel_constant_equals_original_canonical_mean": "proved_actual_canonical_probability_and_true_original_integral",
  "actual_kernel_L2_equals_original_H1_constant_value": "proved_true_Lp_AE_extensionality",
  "actual_zero_mean_closed_kernel_trivial": "proved_original_same_measure_actual_closed_domain_kernel_condition",
  "no_assumed_AE_constancy_shift_invariance_test_duality_or_Fubini_conclusion": true,
  "arbitrary_constants_in_minimal_closed_L_domain": "not_proved",
  "full_closed_L_kernel_identity": "not_proved",
  "weighted_H1_norm_smooth_density": "not_proved",
  "actual_L2_semigroup_generator_identification": "not_proved",
  "actual_semigroup_generator_graph_core": "not_proved",
  "actual_probability_Gibbs_invariance": "not_proved",
  "forward_Poisson_compact_resolvent_Fredholm_Proposition6_4": "not_proved",
  "responsible_semantic_review": "pending",
  "whole_theorem6_2": "incomplete",
  "core_scope": "incomplete"
}' | ConvertFrom-Json -AsHashtable
$local=[ordered]@{draft_path="$base/Draft.lean";source_path=$source;draft_sha256=$hash;source_sha256=$hash;local_check_log='local04.log';local_check_log_sha256=(Get-FileHash "$base/local04.log").Hash.ToLowerInvariant();local_exit_code=0;local_lean_warnings=0;local_log_empty=$true;exact_source_copy_verified=$true;public_declarations=$pub;integrated=$true;full_check='pending_full_check01'}
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_actual_rough_kernel_AE_constancy_mean_and_mean_zero_kernel_trivial';actual_kernel_to_constant_distinct_from_all_constants_minimal_domain_full_kernel_identity_and_Poisson=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8












$claim='CH06-DEP-173,Proposition6.4_dependency,6.4.4,256-257,277-278,analytic_dependency,actual粗糙闭算子kernel AE常数和零均值核平凡,local04_passed_full_check01_pending,responsible_pending,unitmass_U_Cinfty_unitperiodic_beta_positive_gamma_positive_FD_Nzero_same_actual_mu,constant_minimal_domain_reverse_full_kernel_identity_ActualInv_Prop6.4_CORE_pending,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_kernel_ae_constant,module=MolecularDynamics/Chapter06/LangevinCanonicalKernelConstant.lean;6public;真实DCTtestdual与measurableFubini得reference和samecanonicalAE常数且等mean'
$notation='NOT-CH06-182,Langevin_canonical_closed_kernel_actual_AE_constant,原实际closedkernel常数均值及meanzerotrivial,256-257,277-278,Proposition6.4_kernel_to_constant_actual_necessary_dependency,currentread277278_exactpriorraw_priorvisual278_hash,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_kernel_ae_constant,MolecularDynamics/Chapter06/LangevinCanonicalKernelConstant.lean,responsible_pending,local04_passed_full_check01_pending,full-check01-LangevinCanonicalKernelConstant,6public;actualreferenceshiftAE;referenceconstant;originalcanonicalconstant;truecanonicalmean;L2constantvalue;meanzerokerneltrivial'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-173') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-182')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalKernelConstant / CH06-DEP-173 / NOT-CH06-182：6public。private truecontinuous testdual：原locallyL1 f、每compact K真实cthickeningcompact R，actualpositive趋0半径thickenedIndicator连续compact/bound≤1，trueindicatorRnormf可积支配，实际DCT与原全部continuouscompact测试积分0推出compactset integral0，再fixedmathlib AE0。对实际kernel translatedf-f，原reference translatedlocalL1和产品integrability允许拆sub，actual连续pairing不变及actualchangevariable得reference每phase AEshift。真实AEmeasurable representative g为Borelmeasurable，使(g(x+a)=gx)jointpred真正measurable，actualFubini交换AE量词，原reference非零允许切片，inverseactualreferencepreserving shift得到referenceAEconstant。原samecanonicalµwithDensity AC转canonicalAEconstant，trueprobability给其值就是原mean，Lp.ext等实际H1ConstantValue且meanzerokerneltrivial。local04 clean；exactfull01待验。任意constant实际minimalLdomain反向与完整kernelidentity未证；H1density/actualgeneratorcore/κInv/Poisson/完整Prop6.4未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalKernelConstant：N0有效，原sameµ L2、actualminimalgraphclosure Ldomain/Af0，U∞unitperiodic/β>0/γ>0与FD。testdual需locallyL1和真实全部continuouscompact测试，但这些均从原actualkernel在证明内推出，不作为kernel结论新增假设；AEshift和AEconstant均真正证明。Fubini先选Borelrepresentative保原reference AE值再真jointmeasurable，reference非零是原Haar×Leb正开集自动事实；原canonicalµAC由真正withDensity身份，不假设InvLaw。原kernelmean是trueprobability积分且L2实际可积。未假设任意constants minimaldomain、fullkernelidentity、adjointcore/compactresolvent或Poisson存在。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalKernelConstant 6public local04通过，唯一full01待验；真实roughkernel reference/samecanonical AEconstant及meanidentity/L2constantvalue/meanzerotrivial。constants minimaldomain反向和完整kernelidentity/Prop6.4/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-08-LangevinCanonicalKernelConstant'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='六声明落实PDF278/printed257原核常数性证明的kernel-to-constant方向。对象仍原U∞unitperiodic/β>0/γ>0FD、原samecanonicalµ L2与真实compact∞测试graphclosure L，不是用全H1或generatorcore假设替代。DCT testdual在actualphase上证明：每compact K挑真compactcthickening R，radius r/(n+1)>0且≤r趋0；真实thickenedIndicator有continuouscompact支撑和norm≤1，原localL1在R给indicatorRnormf真正integrable；真DCT使原全部continuouscompact配对0推出每compactset integral0，fixedmathlib compactset integral唯一性得AE0。'
$reviewText+=[char]10+[char]10+'对kernel真translatedf-f，两项reference locallyL1和continuouscompact products真integrable后才拆积分sub。actualchangevariable和上一truecontinuous pairing shiftinvariance给所有测试积分0，得每phase shift的reference AE不变。原reference AEstrongmeasurable f选真Borel measurable representative g，AEequal经actualreference preserving shifts保留，所以joint(g(x+a)=g x)pred真measurable。actualFubini交换两个原reference的AE量词、原reference非零取真实slice、inverseactualshift将slice equality推成referenceAEconstant。最后原canonicalµ真withDensity AC转samecanonicalAEconstant，trueprobability integral确定c=原mean，Lp.ext与实际H1constantvalueAE身份给相等及mean0kernel为0。未宣称任意constant属于实际最小Ldomain：反向与完整kernelidentity仍未证。'
$reviewText+=[char]10+[char]10+'local01错误仅NNReal→real composition需Function.comp_apply、Pi.sub_apply、measurableSet_eq_fun名称及Measure.ae_ae_comm namespace；actualdominator/compact bound和mean后端编译。local02仅Fubini两个measure隐参需明确原reference；local03仅inverse shift function composition未展开；local04补真实Function.comp_apply后六public/private clean emptylog0。raw01–04保留，无资源/透明性/linter选项。任意constants minimaldomain/完整kernelidentity、H1normdensity、actualgeneratorcore/κInv/Poisson/Prop6.4/CORE未证，semantic pending。原页复用exact277278text/priorvisual278，无newrender。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalKernelConstant六声明local04 clean，唯一full01中' 'trueDCT compactcontinuous testdual、actualreference每phase AEshift、真实jointmeasurable representative/Fubini/slice/inverseshift导referenceAEconstant，原canonicalµAC得sameµAEconstant/true mean/L2constantvalue/meanzerokerneltrivial。local04空log0，DEP173/NOT182/291formalinputs冻结，raw01–04保留。' '等唯一full01 9208jobs/2885standardaxioms/291inputs/all10zero/0warning/全SHA，allowlist验收；下一actualconstants的momentumcutoff graphapprox证明minimaldomain反向及fullkernelidentity，或独立Prop6.4唯一性。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
