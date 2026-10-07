
function Save-LocalCheckpoint([string]$Title,[string]$Details,[string]$Next) {
 $stamp=[DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('yyyy-MM-dd HH:mm:ss zzz')
 $head=(git rev-parse HEAD).Trim()
 $branch=(git branch --show-current).Trim()
 $latest=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalKernelPairingShift/ACCEPTANCE.json' -Raw | ConvertFrom-Json
 $lines=@(
 '# 当前可操作状态'
 "最后更新时间（Asia/Shanghai）：$stamp"
 '当前聊天01a10bc0-bc8d-7043-8df9-21a6b0bde09a；handoff ready/new_thread_id正确。'
 "工程C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization；branch $branch；HEAD $head。"
 '固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435，只本地。'
 "既有最新正式验收基线LangevinCanonicalKernelPairingShift六声明：$head，$($latest.jobs)jobs/2872公理/289exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local02六声明空log0。真实共同compact支撑、constructed integrabledominator、原pairing曲线dominated HasDerivAt0及所有smoothcompact测试泛函phase shiftinvariance已证；roughkernel AE常数/完整kernelidentity/H1密度/actualgeneratorcore/κInv/Poisson未证。"
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7、CanonicalHilbertGraph10、CanonicalHilbertClosed10、CanonicalHilbertDissipativity5、CanonicalCoordinateWeakDerivative11、CanonicalWeakH1十五声明、CanonicalH1MeanZero十六声明、CanonicalCoordinateClosed十一声明、CanonicalMomentumClosedEnergy十三声明、CanonicalKernelTransport五声明、CanonicalKernelWeakH1八声明、CanonicalKernelUnweighted八声明、CanonicalKernelShift七声明、CanonicalKernelPairingShift六声明二十五批共230public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalKernelContinuousTest'
$source='MolecularDynamics/Chapter06/LangevinCanonicalKernelContinuousTest.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local02.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local02.log")).Trim().Length -ne 0){throw 'Local02 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
$prior=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalKernelPairingShift/full-check01/CHECK_REPORT.json' -Raw | ConvertFrom-Json
if($prior.machine_check_status -ne 'passed' -or $prior.inputs.Count -ne 289){throw 'Previous baseline not accepted'}
foreach($i in $prior.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Prior exact input changed $($i.relative_path)"}}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:abbrev|def|theorem|instance) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 7){throw 'Expected 7 public'}
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
  "actual_common_smooth_approximation_support_region": "proved_original_momentum_support_plus_projected_real_unit_ball_times_true_compact_torus",
  "actual_uniform_support_for_all_radius_at_most_one": "proved_actual_normed_bump_support_and_original_descended_convolution",
  "actual_smooth_compact_uniform_approx_with_common_support": "proved_real_radius_min_one_actual_uniform_continuity_and_true_normalized_convolution",
  "actual_reference_translated_canonical_L2_locallyIntegrable": "proved_actual_reference_measure_preserving_homeomorphism_and_compact_integrability",
  "actual_continuous_compact_kernel_test_pairing_phase_shift_invariance": "proved_true_local_L1_integral_error_estimates_on_same_compact_and_original_smooth_pairing_invariance",
  "no_assumed_common_support_integral_continuity_pairing_invariance_or_kernel_constancy": true,
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_actual_common_support_smooth_approx_and_continuous_test_shift_invariance';actual_kernel_continuous_test_shift_invariance_distinct_from_rough_kernel_AE_constancy_and_Poisson=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8











$claim='CH06-DEP-172,Proposition6.4_dependency,6.4.4,256-257,277-278,analytic_dependency,统一实际紧支撑光滑逼近和连续kernel测试平移不变,local02_passed_full_check01_pending,responsible_pending,unitmass_U_Cinfty_unitperiodic_beta_positive_gamma_positive_FD_Nzero_same_actual_mu,rough_kernel_AE_constancy_ActualInv_Prop6.4_CORE_pending,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_kernel_continuous_pairing_shift_invariant,module=MolecularDynamics/Chapter06/LangevinCanonicalKernelContinuousTest.lean;7public;实际commoncompactsupport和局部L1积分error导连续测试不变'
$notation='NOT-CH06-181,Langevin_canonical_kernel_continuous_test_phase_shift,统一compact支撑逼近和真实连续测试积分平移不变,256-257,277-278,Proposition6.4_kernel_constancy_continuous_test_necessary_dependency,currentread277278_exactpriorraw_priorvisual278_hash,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperator_kernel_continuous_pairing_shift_invariant,MolecularDynamics/Chapter06/LangevinCanonicalKernelContinuousTest.lean,responsible_pending,local02_passed_full_check01_pending,full-check01-LangevinCanonicalKernelContinuousTest,7public;actualcommoncompact;originalsupport;allradiusleone;trueuniformapprox;translatedL1;continuouspairingphaseinvariance'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-172') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-181')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalKernelContinuousTest / CH06-DEP-172 / NOT-CH06-181：7public。K是真compacttorus乘原momentum support及realphase closedball1的momentum投影compactsum，原Fsupport包含K；原实际normalizedsmoothapprox半径≤1时从真bump support和原convolution支撑推出所有tsupport在K。真正radius=min r 1保uniformcontinuity误差，得到任意正ε实际∞compactuniformapprox且sameK。原canonicalL2代表的reference translated localL1由actualreference measurepreserving homeomorphism及compactimage积分证明。原积分产品真可积后拆sub，pointwise normdifference受εindicatorKnormf支配，积分单调给真正error≤εlocalL1。应用原f和translatedf两bound及已证smooth pairing shiftinvariance，导每continuouscompact测试配对phase平移不变。local02 clean；exactfull01待验。roughkernel AE常数性/完整核identity、H1density、actualgeneratorcore/κInv/Prop6.4未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalKernelContinuousTest：N0有效，原actualsmoothapprox、unit-torus phase与reference Haar×Leb。F continuous和真实compact，radiuspositive且≤1的support结论是真证明非输入；commonsupport approximation用原normalizedconvolution不另假设。canonicalL2 f原U∞unitperiodic/β>0给reference局部L1，translation从真实measurepreservinghomeomorphism保该性质；最终原actualclosedLdomain/Af0、γ>0/FD。没有全reference可积或canonicalµ平移保持假设；所有积分拆差与monotonicity前给真产品integrable，ε选择原实际finite localL1A/B。未假设kernel AE常数、core/InvLaw。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalKernelContinuousTest 7public local02通过，唯一full01待验；真实commonsupport smoothapprox/reference translatedlocalL1/errorbound/continuouscompact pairing shiftinvariance；roughkernel AE常数性/Prop6.4/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalKernelContinuousTest'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='七声明用于PDF278/printed257原核常数性论证从实际smoothcompact测试过渡到continuouscompact测试。K是真compacttorus乘原Fmomentum support加真实realphase closedball1的momentum投影，含原Fsupport。实际原normalizedbump卷积支撑及半径≤1证明全部approx support在同K，不以每个approx分别compact冒充uniformcompact。实际uniformcontinuity radius r裁min r1仍满足真实误差，原smoothapprox就是既有已证对象。'
$reviewText+=[char]10+[char]10+'actualreference measurepreserving addhomeomorphism把局部L1在compactimage的实际integrability带回translatedf。private积分error：先证明fF和fG真integrable才拆差；pointwise norm差≤εindicatorKnormf、真正可积支配和Bochner integralmono给error≤ε∫Knormf。shiftedpairing真实changevariable等于translatedf普通测试配对；用两个真实localL1常数A/B、δ=ε/(A+B+1)>0及原smooth pairing shiftinvariance，actualtriangleerror≤ε，∀ε得continuouscompact不变。无全referenceL1、canonical概率平移保持或kernelconstant假设。'
$reviewText+=[char]10+[char]10+'local01仅原private phase_smooth_kernel与local φ.normed真实definition相同但rw未自动匹配；其余六public及private积分证明已编译。local02用原lift真等式显式change到φ.normed convolution再rw后七public/private clean emptylog0，raw01–02保留，无资源/透明性/linter选项。roughkernel AE常数/完整核identity、H1normdensity、actualgeneratorcore/κInv/Poisson/Prop6.4/CORE未证，semantic pending。原页复用exact277278text/priorvisual278，无newrender。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalKernelContinuousTest七声明local02 clean，唯一full01中' '真commoncompact K包含原F及所有实际radius≤1normalizedapprox，实际uniformapprox带sameK；reference translatedf localL1和合法积分errorbound导continuouscompact测试泛函phase shiftinvariance。local02空log0，DEP172/NOT181/290formalinputs冻结，raw01–02保留。' '等唯一full01 9207jobs/2879standardaxioms/290inputs/all10zero/0warning/全SHA，allowlist验收；下一actualcontinuous测试唯一性⇒reference AE平移再trueFubini/Haar常数性，未假设。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
