
function Save-LocalCheckpoint([string]$Title,[string]$Details,[string]$Next) {
 $stamp=[DateTimeOffset]::Now.ToOffset([TimeSpan]::FromHours(8)).ToString('yyyy-MM-dd HH:mm:ss zzz')
 $head=(git rev-parse HEAD).Trim()
 $branch=(git branch --show-current).Trim()
 $latest=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalKernelTransport/ACCEPTANCE.json' -Raw | ConvertFrom-Json
 $lines=@(
 '# 当前可操作状态'
 "最后更新时间（Asia/Shanghai）：$stamp"
 '当前聊天01a10bc0-bc8d-7043-8df9-21a6b0bde09a；handoff ready/new_thread_id正确。'
 "工程C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization；branch $branch；HEAD $head。"
 '固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435，只本地。'
 "既有最新正式验收基线LangevinCanonicalKernelTransport五声明：$head，$($latest.jobs)jobs/2843公理/285exactinputs，full01全部10checks0/0Leanwarning/input/raw/index/postcommit SHA。local01五声明首次空log0。samecanonical原HtestL2及literalOUcoordtranspose、actualclosedLkernel的ptranspose/OU/Hamiltonian弱测试0已证；q弱导数0/p独立/全kernel常数性/H1密度/actualgeneratorcore/κInv/Poisson未证。"
 '本轮Orbit8、C0ConservedObservable5、GibbsStationaryExpression12、CanonicalMeasure14、CanonicalPartition11、CanonicalMomentumIBP8、CanonicalPositionIBP3、CanonicalWeakBalance13、CanonicalEnergy12、CanonicalWeightedAdjoint9、CanonicalConjugation3、CanonicalSmoothDensity7、CanonicalHilbertGraph10、CanonicalHilbertClosed10、CanonicalHilbertDissipativity5、CanonicalCoordinateWeakDerivative11、CanonicalWeakH1十五声明、CanonicalH1MeanZero十六声明、CanonicalCoordinateClosed十一声明、CanonicalMomentumClosedEnergy十三声明、CanonicalKernelTransport五声明二十一批共201public已正式验收；不代表整本教材完成。'
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
$base='docs/verification/2026-10-07-LangevinCanonicalKernelWeakH1'
$source='MolecularDynamics/Chapter06/LangevinCanonicalKernelWeakH1.lean'
$h=Get-Content -LiteralPath docs/handoff/THREAD_HANDOFF_20261005.json -Raw | ConvertFrom-Json
if($h.state -ne 'ready' -or $h.new_thread_id -cne '01a10bc0-bc8d-7043-8df9-21a6b0bde09a'){throw 'Handoff gate'}
if((Get-Content "$base/local03.exit" -Raw).Trim() -ne '0' -or [IO.File]::ReadAllText((Join-Path (Get-Location) "$base/local03.log")).Trim().Length -ne 0){throw 'Local03 not clean'}
if(Test-Path -LiteralPath $source){throw 'Already integrated'}
$prior=Get-Content -LiteralPath 'docs/verification/2026-10-07-LangevinCanonicalKernelTransport/full-check01/CHECK_REPORT.json' -Raw | ConvertFrom-Json
if($prior.machine_check_status -ne 'passed' -or $prior.inputs.Count -ne 285){throw 'Previous baseline not accepted'}
foreach($i in $prior.inputs){if((Get-FileHash -LiteralPath $i.relative_path).Hash.ToLowerInvariant() -cne $i.sha256){throw "Prior exact input changed $($i.relative_path)"}}
$text=[IO.File]::ReadAllText((Join-Path (Get-Location) "$base/Draft.lean"))
if($text -cmatch '\b(sorry|admit|axiom|unsafe)\b|(?m)^\s*set_option'){throw 'Forbidden source'}
$pub=@([regex]::Matches($text,'(?m)^(?:abbrev|def|theorem|instance) (textbook\S+)') | ForEach-Object {'MolecularDynamics.'+$_.Groups[1].Value})
if($pub.Count -ne 8){throw 'Expected 8 public'}
Copy-Item -LiteralPath "$base/Draft.lean" -Destination $source
$hash=(Get-FileHash $source).Hash.ToLowerInvariant()
if($hash -cne (Get-FileHash "$base/Draft.lean").Hash.ToLowerInvariant()){throw 'Exact copy'}
$utf=[Text.UTF8Encoding]::new($false)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'MolecularDynamicsFormalization.lean'),[char]10+'import MolecularDynamics.Chapter06.LangevinCanonicalKernelWeakH1'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'Scratch.lean'),[char]10+(($pub | ForEach-Object {'#check '+$_}) -join [char]10)+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'scripts/CheckAxioms.lean'),[char]10+(($pub | ForEach-Object {'#print axioms '+$_}) -join [char]10)+[char]10,$utf)
$pub | ConvertTo-Json | Set-Content "$base/PUBLIC_DECLARATIONS.json" -Encoding utf8
$flags='{
  "actual_model": "original_unit_mass_U_Cinfty_unitperiodic_beta_positive_gamma_strictly_positive_FD_same_canonical_measure_Nzero",
  "actual_Hamiltonian_Frechet_lift_and_smoothness": "proved",
  "actual_momentum_transpose_test_lift_smoothness": "proved",
  "genuine_unweighted_noise_Hamiltonian_commutator": "proved_using_actual_fixed_mathlib_Lie_derivative_formula",
  "genuine_weighted_commutator": "proved_literal_AqG_equals_ApHG_minus_HApG",
  "actual_closed_L_kernel_position_transpose_testing": "proved_on_genuine_compact_smooth_tests_with_actual_L2_product_integrability",
  "actual_closed_L_kernel_weak_H1": "constructed_from_proved_true_q_and_p_transpose_testing",
  "actual_closed_L_kernel_H1_value_identity": "proved_same_original_L2_class",
  "actual_closed_L_kernel_all_q_and_p_weak_derivatives_zero": "proved",
  "no_a_priori_kernel_H1_membership_or_full_H1_core_hypothesis": true,
  "weak_zero_gradient_implies_actual_canonical_constant": "not_proved",
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
$a=[ordered]@{original_pdf_sha256=$pdfHash;printed_pages=@(256,257);pdf_pages=@(277,278);original_text_read_current_reused_exact_path=$ref;original_text_sha256=$refHash;visual_checked_current_pages=@();visual_checked_prior_exact_unchanged_pages=@(278);prior_render_path=$png;prior_render_sha256=$pngHash;reference='Prop6_4_genuine_weighted_commutator_actual_closed_L_kernel_weakH1_all_derivatives_zero';actual_kernel_weakH1_all_derivatives_zero_distinct_from_full_constancy_or_Poisson=$true;no_new_original_page_render=$true}
foreach($k in $flags.Keys){$a[$k]=$flags[$k]}
$a | ConvertTo-Json -Depth 10 | Set-Content "$base/SOURCE_AUDIT.json" -Encoding utf8









$claim='CH06-DEP-168,Proposition6.4_dependency,6.4.4,256-257,277-278,analytic_dependency,真实加权交换子及actual闭L核的全弱导数0H1构造,local03_passed_full_check01_pending,responsible_pending,unitmass_U_Cinfty_unitperiodic_beta_positive_gamma_positive_FD_Nzero_same_actual_mu,weak_zero_gradient_to_constant_full_kernel_constancy_ActualInv_Prop6.4_CORE_pending,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperatorKernelWeakH1_derivative,module=MolecularDynamics/Chapter06/LangevinCanonicalKernelWeakH1.lean;8public;由实际compact∞测试commutator导qtranspose0及真实H1jet'
$notation='NOT-CH06-177,Langevin_canonical_kernel_weakH1,原canonical实际闭L核真实H1与全弱导数0,256-257,277-278,Proposition6.4_kernel_constancy_weakH1_necessary_dependency,currentread277278_exactpriorraw_priorvisual278_hash,MolecularDynamics.textbookLangevinCanonicalHilbertClosedOperatorKernelWeakH1_derivative,MolecularDynamics/Chapter06/LangevinCanonicalKernelWeakH1.lean,responsible_pending,local03_passed_full_check01_pending,full-check01-LangevinCanonicalKernelWeakH1,8public;trueweighted commutator;qtranspose0;actualkernel真H1value及全部q/p弱导数0;常数性仍未证'
if((Import-Csv 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv' | Where-Object item_id -eq 'CH06-DEP-168') -or (Import-Csv 'docs/NOTATION_INVENTORY.csv' | Where-Object item_id -eq 'NOT-CH06-177')){throw 'Duplicate ledger'}
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv'),$claim+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'docs/NOTATION_INVENTORY.csv'),$notation+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'FORMALIZATION_MAP.md'),[char]10+'LangevinCanonicalKernelWeakH1 / CH06-DEP-168 / NOT-CH06-177：8public。原H表达式真实Frechet drift lift及∞smooth；真实ptranspose∞，compact support由实际directional support和原H differential支撑。actualnoise/drift Lie bracket与固定mathlib fderiv_apply_lieBracket导DpHG−HDpG=DqG；原H(p_i)=−DqUi和真实H线性乘积律导literal AqG=ApHG−HApG。已证actualkernel ptranspose和H弱测试应用到真实∞compact HG/ApG，所有同µL2产品integrable给qtranspose配对0；以真WeakGraph定义证明actualkernel的真实H1jet，其value=原fclass且全部q/pweak导数0。local03 clean；exactfull01待验。γ>0/FD显式，无前提H1域或core。weak梯度0⇒常数、完整kernel常数性、H1normdensity、actualgeneratorcore/κInv/完整Prop6.4未证。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'ASSUMPTIONS.md'),[char]10+'LangevinCanonicalKernelWeakH1：原samecanonicalµ及unitmass、N允许0、U∞unitperiodic、β>0、γ>0及实际FD σ²=2γ/β。truecommutator公式本身β任意且无kernel假设；qtesting/actualkernelH1仅actualclosedLdomain和Af=0，真正weakH1 membership由已有p测试0及本批q测试0导出。HG/ApG真实∞compact，真µL2产品可积后才拆积分。没有假设前提H1membership、weakgradientzero⇒constant、fullH1core、actualsemigroupgenerator身份或InvLaw。'+[char]10,$utf)
[IO.File]::AppendAllText((Join-Path (Get-Location) 'STATUS.md'),[char]10+'LangevinCanonicalKernelWeakH1 8public local03通过，唯一full01待验；actualkernel真实weakH1/allq/pweak导数0，gradientzero⇒constant/全kernel常数性/Prop6.4/CORE未完。'+[char]10,$utf)
$review='docs/reviews/2026-10-07-LangevinCanonicalKernelWeakH1'
$null=New-Item -ItemType Directory -Path $review -Force
$reviewText='八声明服务原PDF278/printed257 Proposition6.4的真实核常数性证明链。实际H=原Uγ0σ0 differential，原realFrechet给Hlift∞，ptranspose由真实DpG∞及p_i∞乘G构成。真实noise/drift Lie bracket的符号在固定VectorField.fderiv_apply_lieBracket中核对，导DpHG−HDpG=DqG；真正H(p_i)=−DqUi与原H线性/乘积律导AqG=ApHG−HApG。公式无需compact和β正，原canonical核测试需β>0/γ>0/FD。'
$reviewText+=[char]10+[char]10+'实际HG/ApG真实∞compact可作已证ptranspose/H测试，各实际同µL2产品integrable，原积分按真commutator拆成两项0，得到qtranspose testing0。把原actualkernel fclass和全部0derivative放入真H1Jet时，WeakGraph全部pairing由真q/p测试0证出；value身份及所有q/p导数0是实际projection，而非把H1或weakgradient0放进假设。N0仍有效。'
$reviewText+=[char]10+[char]10+'local01首段const_mul不存在，local02实际函数形状/CLM.snd/Hadd元变量3处错误，local03修固定API及显式函数后全部8public和private clean emptylog0。未用资源/透明性/linter选项。全部raw保留。前批ACCEPT.ps1仅终端2853误印改2843，285formalinput完全未变，复用原验收。weak梯度0⇒canonical常数、完整kernel常数性、H1normdensity、actualgeneratorcore/κInv、compactresolvent/Fredholm/Poisson/Prop6.4/CORE仍未证，负责人semantic pending。原277278复读复用exactraw及priorvisual278，无newrender。'+[char]10
[IO.File]::WriteAllText((Join-Path (Get-Location) "$review/REVIEW.zh-CN.md"),$reviewText,$utf)
Save-LocalCheckpoint 'CanonicalKernelWeakH1 8public local03 clean，唯一full01中' '真实Hlift∞/ptranspose∞/weighted commutator、actualkernel qtranspose0以及真weakH1jet/value/全q/pweak导数0已局部验证；无前提H1core或kernel常数性。local03空log0，DEP168/NOT177/286formalinputs冻结；rawlocal01–03保留，前批终端公理显示修正一并登记。' '等唯一full01 actualjobs/2851standardaxioms/286inputs/all10zero/0Leanwarning/allSHA，再自身allowlist验收；下一真正weakgradient0至canonical常数性桥。'
& pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory "$base/full-check01" *> "$base/FULL_DRIVER.log"
$ec=$LASTEXITCODE
Write-Output "full01 exit $ec"
if($ec -ne 0){Get-Content "$base/FULL_DRIVER.log" -Tail 25}
exit $ec
