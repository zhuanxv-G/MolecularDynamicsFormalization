# 第2–5章网站审计修复队列

当前任务：修复第2–5章网站审计问题；第6章暂停，不进入第7章。
修复顺序：第2→3→4→5章，每章按节，每批≤8条；不写新证明。
完成状态：第2–5章全部修复完成，等待用户提交EAUDIT复审包。
A/B/C/D初筛仅是关键词估计；须逐条阅读网站理由后确认，初筛D不代表已转导师。网站PASS只覆盖其绑定快照。

第2章：网站PASS 67 / 已修待复审 75 / 待导师 18 / 修复中 0。
第3章：网站PASS 51 / 已修待复审 78 / 待导师 20 / 修复中 0。
第4章：网站PASS 42 / 已修待复审 110 / 待导师 27 / 修复中 0。
第5章：网站PASS 51 / 已修待复审 117 / 待导师 15 / 修复中 0。

| 章 | source_id | 网站判定 | 问题类别 | 处理方式 | 状态 | EAUDIT批次 |
|---|---|---|---|---|---|---|
| 2 | MD-2-HamiltonianODE | FAIL | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT74 |
| 2 | MD-2-Hamiltonian | FAIL | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT74 |
| 2 | MD-2-Euler | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT74 |
| 2 | MD-2-OneStep | FAIL | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT74 |
| 2 | MD-2.1-Convergence | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.1-Order | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.1-Error | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.1-Thm2.1 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.1.2-SecondDerivative | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT75 |
| 2 | MD-2.1.2-Taylor2 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.1.2-Taylor2Order | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2-VerletOrder | FAIL | C | 网站首选路线：直接保留原文(q,v)速度变量，使用已定义velocityVerlet与真实速度场(v,M⁻¹F(q))；正对角质量及C⁴为充分但非最小资格，闭窗连续性为冗余明确限制。未更改正式mechanicalField/verlet，不新增证明。 | 已修待复审 | EAUDIT76 |
| 2 | MD-2.2.1-Lagrangian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.1-Admissible | NEEDS_HUMAN | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT03 |
| 2 | MD-2.2.1-Action | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.1-Variation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.1-FirstVariation | FAIL | B | 保留原三个结论，并补同一个真实点态Taylor余项的紧时间窗统一C/ε/²控制；没有把余项界当作前提，未新增证明。 | 已修待复审 | EAUDIT77 |
| 2 | MD-2.2.1-TaylorPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.1-StationaryAction | FAIL | B | 保留驻值定义，同一source_id补完整积分I=0等价式及自然Euler–Lagrange运动推出驻值的Hamilton原理；C²及a<b是充分资格。新结论只登记sorry陈述，证明留到网站PASS后。 | 已修待复审 | EAUDIT77 |
| 2 | MD-2.2.1-Parts | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.1-EulerLagrange | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT77 |
| 2 | MD-2.2.1-VariationalDerivativePrinted | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT77 |
| 2 | MD-2.2.1-StationaryNotMin | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT03 |
| 2 | MD-2.2.2-DiscretePath | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-DiscreteVelocity | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-DiscreteAction | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT04 |
| 2 | MD-2.2.2-DiscreteStationaryPrinted | FAIL | A | 保留原印0<k≤ν范围和端点疑误；改用HasFDerivAt表达经典零导数，防止不可微处fderiv总化为零；内部节点版本已有独立DiscreteVerlet条目，不裁定端点勘误。 | 已修待复审 | EAUDIT78 |
| 2 | MD-2.2.2-DiscreteDerivative | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT78 |
| 2 | MD-2.2.2-DiscreteVerlet | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-Stormer | FAIL | C | 直接使用原文质量乘法形式M(qₙ₊₁−2qₙ+qₙ₋₁)=h²F(qₙ)，避免零质量下逆质量总化造成对象不等价；仅更改Blueprint本条。 | 已修待复审 | EAUDIT78 |
| 2 | MD-2.2.2-VelocityVerlet | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-EliminateVelocity | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-MomentumVerlet | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-Leapfrog | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-LeapfrogInit | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-LeapfrogReconstruct | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.3-ErrorDifference | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.3-Consistency | FAIL | A | 显式0<p；本条只登记正自然数阶，属于[EXTRA]整数阶限制；保持统一K、δ及严格0<h<δ，不静默扩大端点。 | 已修待复审 | EAUDIT79 |
| 2 | MD-2.2.3-Stability | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.3-ErrorRecursion | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.3-ErrorBound | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT79 |
| 2 | MD-2.2.3-ConsistencyConvergence | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.3-ScalarVerlet | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.3-VerletExpansion | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT79 |
| 2 | MD-2.2.3-ExactExpansion | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT79 |
| 2 | MD-2.2.3-DefectPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT05 |
| 2 | MD-2.2.3-VerletConsistency | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT79 |
| 2 | MD-2.2.3-VerletStability | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT79 |
| 2 | MD-2.2.4-FirstIntegral | FAIL | A | 签名显式开放域与I在D经典可微；不再由不可微处fderiv=0总化值冒充守恒条件。 | 已修待复审 | EAUDIT80 |
| 2 | MD-2.2.4-IntegralPreserved | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT80 |
| 2 | MD-2.2.4-EnergyPreserved | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.4-AngularMomentum | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.4-IntegralMeanValue | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.4-IntegralLipschitz | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT80 |
| 2 | MD-2.2.4-IntegralErrorPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT06 |
| 2 | MD-2.3.1-Divergence | FAIL | B | 保留散度辅助定义，并补经典可微向量场的散度恒零谓词；覆盖原句零条件。 | 已修待复审 | EAUDIT81 |
| 2 | MD-2.3.1-Liouville | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT81 |
| 2 | MD-2.3.1-HamiltonDivergence | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.1-HamiltonVolume | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT81 |
| 2 | MD-2.3.1-VolumeChange | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.1-VariationalPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT07 |
| 2 | MD-2.3.1-DeterminantODE | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT81 |
| 2 | MD-2.3.1-DeterminantExponential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.1-FlowDet | FAIL | B | 补全可测集合真实Lebesgue体积结论，保留det=1；显式τ>0对应原[EXTRA]。已有证明仅用两条已证正式结论作合取小修补，无新证明路线。 | 已修待复审 | EAUDIT81 |
| 2 | MD-2.3.1-LJOscillator | FAIL | C | 本条绑定明确LJ势4ε[(σ/q)^12−(σ/q)^6]、正参数及正位置；原一般势关系另保留为辅助oscillatorEquation。 | 已修待复审 | EAUDIT81 |
| 2 | MD-2.3.1-LJBoundedPeriodic | PASS | C | 依赖小修：一般ODE关系改引辅助oscillatorEquation；原显式LJ势、正参数、正位置及全部周期结论逐字保留。 | 已修待复审 | EAUDIT81 |
| 2 | MD-2.3.2-LinearDivergence | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.2-LinearEuler | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.2-EulerVolumePrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT08 |
| 2 | MD-2.3.2-EulerVolumeCounterexample | FAIL | B | 强化见证为每个h≠0时/det(I+hS)/≠1，覆盖实际体积不守恒；原桥接只给det≠1，原已证结果完整保留为det_only辅助定理并重查，强化结论暂sorry，不写新证明。 | 已修待复审 | EAUDIT82 |
| 2 | MD-2.3.2-AsymmetricEuler | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.2-AsymmetricJacobian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.2-AsymmetricArea | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-SymplecticMap | FAIL | A | 采用原文经典可微辛映射资格，移除不必要C¹限制；正式库C¹定义保持不变。 | 已修待复审 | EAUDIT83 |
| 2 | MD-2.3.3-OneForm | FAIL | B | 保留逐点1-form类型，补由系数向量a构造连续线性泛函及α(z)(ξ)=a(z)ᵀξ评价式；新结论暂sorry。 | 已修待复审 | EAUDIT83 |
| 2 | MD-2.3.3-Differential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-CoordinateDifferentials | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-Wedge | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-SymplecticForm | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-FormSumWedges | FAIL | B | 保留原总楔积等式，补单项J⁽ⁱ⁾矩阵、逐项评价及ΣJ⁽ⁱ⁾=J；全部原结论保留，新补陈述不写证明。 | 已修待复审 | EAUDIT83 |
| 2 | MD-2.3.3-GeneralTwoForm | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-PullbackOne | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-PullbackTwo | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-PullbackMatrix | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-PreservesForm | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-SymplecticIffForm | FAIL | A | 教材定义等价式使用本章经典可微辛谓词；原正式桥接以C¹为定义，不能直接沿用，保留sorry，不宣称已证。 | 已修待复审 | EAUDIT83 |
| 2 | MD-2.3.3-SymplecticDet | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-HamiltonDet | FAIL | B | 补∀t流辛性合取，同时保留det=1和可测集合体积；时间域仍Icc0τ，不额外假称τ>0。已有证明仅将现成流辛性定理与原合取作小修补。 | 已修待复审 | EAUDIT83 |
| 2 | MD-2.3.4-Hessian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.4-HessianSymmetry | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.4-HamiltonVariationalPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT10 |
| 2 | MD-2.3.4-MatrixCancellation | FAIL | B | 保留已证代数消去；补真实时间矩阵曲线、对称S(t)、W′=JSW及完整乘积导数/零导数结论，未以导数结论为前提。 | 已修待复审 | EAUDIT84 |
| 2 | MD-2.3.4-FormConstant | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.4-HamiltonSymplectic | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT84 |
| 2 | MD-2.3.5-ChainRule | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT85 |
| 2 | MD-2.3.5-SymplecticComposition | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT85 |
| 2 | MD-2.3.5-SymplecticInverse | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT85 |
| 2 | MD-2.3.5-GlobalGroupPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT11 |
| 2 | MD-2.3.6-SymplecticIntegrator | FAIL | B | 补实际Hamiltonian流、正阶局部一致性及可用正步长域；保辛性质与数值近似资格合取，C²为充分[EXTRA]，未把无关辛映射冒充积分方法。 | 已修待复审 | EAUDIT86 |
| 2 | MD-2.3.6-SymplecticEuler | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.6-KickDifferential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.6-WedgeSelf | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.6-SymplecticEulerPreserves | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT86 |
| 2 | MD-2.3.7-Adjoint | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT87 |
| 2 | MD-2.3.7-FlowSelfAdjoint | NEEDS_HUMAN | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT87 |
| 2 | MD-2.3.7-BackwardEuler | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT87 |
| 2 | MD-2.3.7-EulerAdjoint | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.7-AdjointSymplecticEuler | FAIL | A | 本条显式正质量及U经典可微，并补原文(Q,P)两条坐标公式；原总化正式辅助Equiv保持，新增坐标陈述暂sorry。Mathlib Flow按用户标准含义直接采信，FlowSelfAdjoint只补材料复审。 | 已修待复审 | EAUDIT87 |
| 2 | MD-2.3.7-AdjointInvolution | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT87 |
| 2 | MD-2.4.1-Splitting | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT88 |
| 2 | MD-2.4.1-FieldAdd | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.4.1-SplittingLocal | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT88 |
| 2 | MD-2.4.1-KineticFlow | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT88 |
| 2 | MD-2.4.1-PotentialFlow | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT88 |
| 2 | MD-2.4.1-SplitEuler | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT88 |
| 2 | MD-2.4.1-VerletComposition | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT88 |
| 2 | MD-2.4.1-VerletSymplectic | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT88 |
| 2 | MD-2.4.1-SymmetricComposition | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT88 |
| 2 | MD-2.4.1-SymmetricEven | PASS | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT89 |
| 2 | MD-2.4.2-CompositionSymplectic | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT90 |
| 2 | MD-2.4.2-CompositionOrder | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT16 |
| 2 | MD-2.4.3-HarmonicSplit | FAIL | A | 保留原除法闭式，频率非零落实为证明参数；U全域经典可微为更新点导数的充分[EXTRA]，未擅加Ω=0延拓。 | 已修待复审 | EAUDIT91 |
| 2 | MD-2.4.4-ImplicitLocal | FAIL | B | 补g_h(U)⊆V，连同原左右逆完整表达局部微分同胚；不声称全域可解。 | 已修待复审 | EAUDIT92 |
| 2 | MD-2.4.4-BackwardEulerSolve | FAIL | B | 保留残差并补零点与隐式更新等价、给定G满足的映射方程；不假设任意f,h都有唯一解。 | 已修待复审 | EAUDIT92 |
| 2 | MD-2.4.4-Newton | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT92 |
| 2 | MD-2.4.4-NewtonQuadratic | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT92 |
| 2 | MD-2.4.4-FrozenNewton | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.4.5-Conjugacy | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.4.5-ConjugateIterates | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT93 |
| 2 | MD-2.4.5-ConjugateLimits | NEEDS_HUMAN | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT19 |
| 2 | MD-2.4.5-EulerConjugacy | FAIL | B | 原代数恒等式及证明完整保留；补正质量、连续力资格下的真实Homeomorph见证、双向kick及共轭方向。新结论暂sorry。 | 已修待复审 | EAUDIT93 |
| 2 | MD-2.4.5-Processing | FAIL | B | 保留预/后处理算法；补实际ODE流与共轭、正低阶s<r、高阶G及低阶B相对同一精确流F的局部阶资格，¬s+1明确低阶而非仅下界；不以共轭误差结论为假设。 | 已修待复审 | EAUDIT93 |
| 2 | MD-2.4.5-ProcessingIterates | FAIL | B | 本条明确仅承担算法与G迭代的精确恒等式；同一原句的r阶及低阶资格完整归MD-2.4.5-ProcessingOrder，保留原句不删并记录跨条映射。 | 已修待复审 | EAUDIT93 |
| 2 | MD-2.4.5-ProcessingOrder | FAIL | A | 补正时间窗与低阶B的s阶误差资格及0<s<r；原G高阶假设和两项误差转移结论、已证证明均保留。processingData另给严格低阶的一般方法资格。 | 已修待复审 | EAUDIT93 |
| 2 | MD-2.4.5-EulerEffectiveOrder | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.1-RK | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.1-RK4 | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT94 |
| 2 | MD-2.5.1-RK4Order | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.1-ExplicitRK | PASS | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT94 |
| 2 | MD-2.5.1-RKSymplectic | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT20 |
| 2 | MD-2.5.1-GaussFamily | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT20 |
| 2 | MD-2.5.1-Midpoint | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.1-MidpointProperties | FAIL | B | 补一般ODE局部二阶与Hamilton情形局部保辛；显式G0=id及实际方程、开状态域/小步长分支和真实流，移除全步长全初值解要求。C³分支及全域光滑场为充分[EXTRA]；二阶指至少二阶，非每个方程恰二阶。 | 已修待复审 | EAUDIT94 |
| 2 | MD-2.5.1-GaussTwo | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.1-GaussTwoOrder | FAIL | A | 改为紧轨迹开邻域U、δ小步长内的真实光滑阶段分支，显式G0=id；补充分细迭代留U，保留全网格四阶。C⁶分支为充分[EXTRA]，未无条件声称任意步长可解。 | 已修待复审 | EAUDIT94 |
| 2 | MD-2.5.2-PartitionedVerlet | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.2-PartitionedReduction | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.2-GeneralEuler | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.2-GeneralSymplectic | FAIL | B | 本条承担基本隐式辛Euler的辛性；同一原句的伴随半步复合、三步关系与对称性由MD-2.5.2-GeneralVerletSymplectic补全，原文不删。 | 已修待复审 | EAUDIT95 |
| 2 | MD-2.5.2-GeneralVerletSymplectic | FAIL | B | 以真实可逆且C¹的基本求解族构造伴随半步复合V，补三步关系、V自伴随及辛性；仅δ小步长要求真实Euler关系，全球可逆族明确为条件性[EXTRA]，不宣称一般隐式方程必有全球解。 | 已修待复审 | EAUDIT95 |
| 2 | MD-2.5.3-Newmark | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.3-NewmarkReduction | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT22 |
| 2 | MD-2.5.3-NewmarkDamping | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.3-NewmarkNotSymplectic | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT22 |
| 2 | MD-2.5.4-MultiTaylor | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT96 |
| 2 | MD-2.5.4-TIPotential | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT96 |
| 2 | MD-2.5.4-TIForce | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT23 |
| 2 | MD-2.5.4-TIOrder | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT23 |
| 2 | MD-2.5.5-Beeman | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.5-BeemanOrder | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT24 |
| 3 | MD-3-ModifiedConstruction | FAIL | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT67 |
| 3 | MD-3.1-AdjointEulerOscillator | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.1-ShadowHamiltonian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.1-EnergyFailure | FAIL | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT68 |
| 3 | MD-3.1-ShadowInvariant | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT68 |
| 3 | MD-3.1-ShadowEllipses | NEEDS_HUMAN | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT03 |
| 3 | MD-3.1-EulerGrowth | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.1-FormalHamiltonian | FAIL | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT68 |
| 3 | MD-3.1-FormalHamiltonianField | FAIL | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT68 |
| 3 | MD-3.2-LieDerivative | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.2-ObservableDerivative | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT69 |
| 3 | MD-3.2-ObservableSecondDerivative | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.2-OperatorExponential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.2-FormalObservable | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.2-FiniteLieTaylor | NEEDS_HUMAN | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT04 |
| 3 | MD-3.2-FlowCoordinates | NEEDS_HUMAN | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT04 |
| 3 | MD-3.2-PoissonBracket | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT69 |
| 3 | MD-3.2-PoissonCoordinates | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT69 |
| 3 | MD-3.2-PoissonBilinearity | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT69 |
| 3 | MD-3.2-PoissonSkew | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT69 |
| 3 | MD-3.2-PoissonSelf | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT69 |
| 3 | MD-3.2-PoissonJacobi | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT69 |
| 3 | MD-3.2-HamiltonianObservableDerivative | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.2-HamiltonianLie | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT69 |
| 3 | MD-3.2-HamiltonianCoordinateDerivative | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3-HamiltonianLieAdditivity | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT70 |
| 3 | MD-3.3-FormalSplitting | FAIL | B | 同时保留精确形式exp(A+B)及分裂形式expA expB，并用真实Hamiltonian Lie导数的卷积系数实例连接A=L_H1、B=L_H2；仅形式系数，不宣称解析收敛。 | 已修待复审 | EAUDIT70 |
| 3 | MD-3.3-ExactExponentialCubic | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT70 |
| 3 | MD-3.3-ProductExponentialCubic | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3-DifferenceCommutator | FAIL | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT70 |
| 3 | MD-3.3-DifferenceCubic | FAIL | B | 显式合取零次/一次/二次及本条三次系数，完整保留所引形式余项阶；原已证单系数定理保留为辅助并重查。新增完整陈述暂sorry。 | 已修待复审 | EAUDIT70 |
| 3 | MD-3.3-HamiltonianCommutator | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3-HamiltonianCommutatorPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3-LeadingModifiedExponential | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT70 |
| 3 | MD-3.3-LeadingShadowHamiltonian | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT06 |
| 3 | MD-3.3-BCH4 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3-BCHHamiltonian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3-BCHHamiltonianMatching | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT06 |
| 3 | MD-3.3-CommutingFlows | PASS | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT70 |
| 3 | MD-3.3.1-SymplecticEulerShadow | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.1-SymplecticEulerShadowMatching | PASS | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT71 |
| 3 | MD-3.3.2-VerletMaps | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.2-VerletHamiltonianParts | FAIL | C | 绑定真实正对角质量、T(p)=pᵀM⁻¹p/2及U(q)，补H1+H2+H3=H；移除任意相空间函数替代机械分解。 | 已修待复审 | EAUDIT72 |
| 3 | MD-3.3.2-VerletStructure | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.2-VerletModifiedHamiltonian | FAIL | B | 本条仅保留展示式到h⁴的有限多项式；一般可分离T(p),U(q)的完整形式系数及O(h⁶)匹配由MD-3.3.2-VerletModifiedMatching补全，原展示式及余项原文不删。 | 已修待复审 | EAUDIT72 |
| 3 | MD-3.3.2-VerletModifiedMatching | FAIL | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT72 |
| 3 | MD-3.3.2-ModifiedEven | FAIL | B | 补一阶log系数A+B并保留全部偶次零，表达至少二阶及Hamiltonian偶性/log奇性；不沿用不同步长log交换的错误推理。 | 已修待复审 | EAUDIT72 |
| 3 | MD-3.3.2-Strang | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT72 |
| 3 | MD-3.3.2-DifferentLogsCommute | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT07 |
| 3 | MD-3.3.2-StrangInverse | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.2-StrangCubic | FAIL | B | 补一次系数和全部偶次零，连同原三次公式覆盖完整奇次展开；原已证三次系数保留辅助并重查，新合取暂sorry。 | 已修待复审 | EAUDIT72 |
| 3 | MD-3.3.3-YoshidaComposition | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.3-YoshidaCoefficients | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.3-YoshidaCancellation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.3-YoshidaUnique | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.3-YoshidaRaiseOrder | FAIL | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT73 |
| 3 | MD-3.3.3-Yoshida4 | FAIL | A | 教材算法接口明确正质量与经典可微势；后续结构定理调用使用正式总化辅助组合，证明不新增。 | 已修待复审 | EAUDIT73 |
| 3 | MD-3.3.3-Yoshida4Structure | PASS | A | 依赖小修：原无质量限制的结构定理继续对应正式总化辅助算法；教材受限接口另有正质量/可微资格，原已证结论保留。 | 已修待复审 | EAUDIT73 |
| 3 | MD-3.3.3-GeneralSplitting | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.4-TakahashiPotential | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT74 |
| 3 | MD-3.3.4-PotentialDoubleBracket | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.4-TakahashiShadow | FAIL | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT74 |
| 3 | MD-3.3.4-TakahashiProcessor | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.4-ProcessorEnergyPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT09 |
| 3 | MD-3.3.4-TakahashiEffectiveOrder | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT09 |
| 3 | MD-3.4-ModifiedField | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.4-LeadingModifiedField | PASS | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT75 |
| 3 | MD-3.4-TruncatedHamiltonian | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT75 |
| 3 | MD-3.4-TruncationSmooth | FAIL | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT75 |
| 3 | MD-3.4-Thm3.1 | FAIL | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT75 |
| 3 | MD-3.4-CompactLipschitz | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.4-TruncatedFlow | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT75 |
| 3 | MD-3.4-FiniteMatchingConstruction | PASS | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT75 |
| 3 | MD-3.4-TruncatedConservation | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT75 |
| 3 | MD-3.4-EnergyTelescoping | FAIL | B | 保留已证首行望远镜恒等式；补给定守恒截断步F、真实差η=数值步−F的完整三行等式，不以待证能量差为前提。 | 已修待复审 | EAUDIT75 |
| 3 | MD-3.4-UniformTruncatedLipschitz | FAIL | B | 保留统一截断Lipschitz定理，补原完整能量差≤LΣ‖η‖≤LAνh^(k+1)链；A为原文缺陷常数重命名，F为所给守恒截断一步。 | 已修待复审 | EAUDIT76 |
| 3 | MD-3.4-TruncationRemainder | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT76 |
| 3 | MD-3.4-PhysicalEnergyDrift | FAIL | B | 保留已证实际缺陷和界，新增实际截断流的统一一步匹配误差资格与完整2Ch^r+LAνh^(k+1)结论；不是以能量结论为假设。 | 已修待复审 | EAUDIT76 |
| 3 | MD-3.4-PolynomialEnergyRate | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.4-StepCountPower | FAIL | B | 本条仅承担步数幂次代数辅助；原句的完整能量率由MD-3.4-PolynomialEnergyRate承担，原文不删并显式跨条映射。 | 已修待复审 | EAUDIT76 |
| 3 | MD-3.4-ArbitraryFiniteTruncation | PASS | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT76 |
| 3 | MD-3.4-AnalyticDefect | NEEDS_HUMAN | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT11 |
| 3 | MD-3.4-OptimalTruncation | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT11 |
| 3 | MD-3.4-ExponentialFlat | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.4-ScalarVerletShadow4 | FAIL | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT76 |
| 3 | MD-3.4-CommutingEnergy | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT21 |
| 3 | MD-3.4-CommutingEnergySymmetry | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.4-EnergySymplecticNoGo | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT21 |
| 3 | MD-3.5-EqualComponentIntegral | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.5-EqualEulerIntegral | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.5-LinearEulerIntegral | FAIL | B | 保留已证Euler精确保存；补连续ODE解上真实线性第一积分恒定，覆盖本条原句连续与离散两结论。 | 已修待复审 | EAUDIT77 |
| 3 | MD-3.5-LinearRKIntegral | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.5-VerletOscillatorEnergy | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT77 |
| 3 | MD-3.5-MomentumProjection | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT77 |
| 3 | MD-3.5-ProjectionConstraint | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT77 |
| 3 | MD-3.5-ProjectionFactor | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT77 |
| 3 | MD-3.5-ProjectionEnergy | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.5-KineticZero | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.5-EnergyProjectionRelation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.5-NoHamiltonianAttractor | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT77 |
| 3 | MD-3.5-LinearContinuousIntegral | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6-HamiltonianFlowStructures | FAIL | B | 补原文Hamiltonian能量沿流守恒，保留变分/辛/体积全部结论；localFlowC1实际资格无显式反步，撤销旧EXTRA对此的过度描述，时间反演由3.6.1处理。 | 已修待复审 | EAUDIT78 |
| 3 | MD-3.6-VolumeNotSymplectic | FAIL | B | 补真实可测集合体积保存及单射，保留det=1和非辛见证；其余原句明确跨条映射HamiltonianFlowStructures及ProjectionEnergy，不静默删原文。 | 已修待复审 | EAUDIT78 |
| 3 | MD-3.6.1-LinearInvolution | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.1-ReversedFieldPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.1-MomentumReversal | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.1-MechanicalReversal | FAIL | C | 按原页外部负号修复先前转录误读，两行均为−(−M⁻¹p,∇U)，原书此式无误；先前本条ERRATUM判断撤销，第三反演合取保留。 | 已修待复审 | EAUDIT79 |
| 3 | MD-3.6.1-ReversedTrajectoryPrinted | FAIL | C | 按PDF151真实链式法则写−R f(γ(−t))，另列纯坐标变化Rf(Rz̃)及纯时间反向−f；不以转置reversedField偷换原链式右端。 | 已修待复审 | EAUDIT79 |
| 3 | MD-3.6.1-ReversedTrajectory | FAIL | A | 补R的坐标矩阵对称资格，与R²=id合起来使Rᵀ=R=R⁻¹，现有经典反演条件才与原字面转置定义等价；该限制显式EXTRA。 | 已修待复审 | EAUDIT79 |
| 3 | MD-3.6.2-FlowReversal | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT80 |
| 3 | MD-3.6.2-FlowReversalIdentity | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT80 |
| 3 | MD-3.6.2-ReversibleMethod | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.2-SymmetricMethod | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT80 |
| 3 | MD-3.6.2-AffineInvariant | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT80 |
| 3 | MD-3.6.2-SymmetricAffineReversible | FAIL | A | 明确本条是原印省略方法类资格后的受限修复；符号/时间尺度相容仅要求固定f，不对所有无关g全称。保留原书疑误说明。 | 已修待复审 | EAUDIT80 |
| 3 | MD-3.6.2-RKAffine | FAIL | B | 仅承担普通RK阶段/更新的线性等变；PRK分区修复及对称方法反演另映射PartitionedAffine、SymmetricAffineReversible，原文整句保留。 | 已修待复审 | EAUDIT80 |
| 3 | MD-3.6.2-PartitionedAffinePrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT15 |
| 3 | MD-3.6.2-PartitionedAffine | FAIL | B | 本条显式仅为保持分区的PRK阶段/更新等变修复；普通RK及有符号相容、对称资格的时间反演推论归RKAffine/SymmetricAffineReversible。保留混合变换错误的Printed导师条目。 | 已修待复审 | EAUDIT80 |
| 3 | MD-3.6.3-SymplecticNotReversible | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.3-TrapezoidalRelation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.3-TrapezoidalProperties | PASS | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT81 |
| 3 | MD-3.6.3-HamiltonianSpectrum | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.3-SymplecticSpectrum | FAIL | B | 保留一般辛矩阵谱结论；补对称K的实际线性Hamiltonian流exp(tJK)、ODE、辛矩阵及对应倒数/共轭谱实例。 | 已修待复审 | EAUDIT81 |
| 3 | MD-3.6.3-ReversibleSpectrum | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.3-ConjugateIterates | FAIL | A | 纯迭代恒等式推广到任意类型及真实Equiv，不附拓扑/范数；原Homeomorph已证版本保留辅助，用于拓扑轨道结论。 | 已修待复审 | EAUDIT81 |
| 3 | MD-3.6.1-MechanicalReversalCorrect | PASS | C | 原已证独立机械反转结论保留；更正旧注释：原书展示式正确，先前原书错误判断已撤销。 | 已修待复审 | EAUDIT79 |
| 3 | MD-3.6.3-ConjugateOrderPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT16 |
| 3 | MD-3.6.3-ReversibleVolumeFailure | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT16 |
| 3 | MD-3.7-HardCoreDomain | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT82 |
| 3 | MD-3.7-ElasticReflection | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.7-ElasticEnergy | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.7-CollisionComposition | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT82 |
| 3 | MD-3.7-CollisionRegularity | FAIL | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT82 |
| 3 | MD-3.7.1-HardCorePotential | FAIL | C | 原印≤接触也取∞独立忠实定义，并补K+U+U_hs完整Hamiltonian；原接触允许的物理版本改名保留辅助。两种边界约定明确区分，不擅自勘误原书。 | 已修待复审 | EAUDIT83 |
| 3 | MD-3.7.1-PrimitiveSplitting | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.7.1-PrimitiveOrder | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT18 |
| 3 | MD-3.7.1-ObstacleReflection | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT83 |
| 3 | MD-3.7.1-PrimitiveDefect | FAIL | C | 仅小正h、单位接触点及初态趋近接触点的首次单碰撞物理分支；系数使用原书碰前P̄（含半kick），不再用初始p冒充；保留O(h²)余项。 | 已修待复审 | EAUDIT83 |
| 3 | MD-3.7.1-CollisionDefectZero | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.7.1-EndImpactThirdOrderPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT18 |
| 3 | MD-3.7.2-CollisionQuadraticPath | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.7.2-CollisionTimeRelation | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT84 |
| 3 | MD-3.7.2-CollisionQuartic | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.7.2-CollisionalVerletRelation | FAIL | A | 保留给定tc/Rc的更新辅助；补实际粒子二次路径、正质量/半径、F=−∇U的对偶资格、不同粒子对的最早真实接触、唯一单碰撞及该接触面的质量加权弹性反射。Option.none明确无正根；严格tc<hmax及等号else照原印保留，不静默修改算法。 | 已修待复审 | EAUDIT84 |
| 3 | MD-3.7.2-CollisionalVerletOrder | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT19 |
| 3 | MD-3.7.3-PairForceDecoupling | NEEDS_HUMAN | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT20 |
| 3 | MD-3.7.3-DecoupledOrder | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT20 |
| 3 | MD-3.7.3-ModifiedCollisionProjection | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT85 |
| 3 | MD-3.7.1-FreeHardSphereHamiltonian | FAIL | C | 忠实保留原印≤无穷势并显式正质量，接触允许物理版本另名存档；补非接触直线运动q′=M⁻¹p,p′=0，接触弹性反射由ElasticReflection/ElasticEnergy原有条目承担。 | 已修待复审 | EAUDIT83 |
| 4 | MD-4-LinearField | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4-EulerFactor | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT47 |
| 4 | MD-4-ScalarEulerStable | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4-EulerRegion | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4-OscillatorMatrix | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4-EulerImaginaryGrowth | FAIL | B | 保留已证趋无穷，并补精确指数率r>1和实际实振子Euler轨道的加权范数等式；矩阵完整复谱已由MD-4-OscillatorSpectrum单列承担，原ω=Ω。非零步长/频率为[EXTRA]资格，新结论暂sorry。 | 已修待复审 | EAUDIT47 |
| 4 | MD-4-SymplecticEulerMatrix | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4-SymplecticEulerCharacteristic | FAIL | B | 本条仅为特征多项式辅助计算；原完整两个复根（含零/负判别式及重根）已由MD-4-SymplecticEulerRoots明确承担，跨条目范围写明，保留原文。 | 已修待复审 | EAUDIT47 |
| 4 | MD-4-PRKThreshold | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT01 |
| 4 | MD-4-VerletStability | FAIL | A | 本条明确是严格稳定内区间的修订版本，另补h=0分支；原印含端点结论保留MD-4-VerletBoundaryPrinted待导师，不宣称与原句等价。 | 已修待复审 | EAUDIT47 |
| 4 | MD-4-SymplecticEulerBoundaryPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT01 |
| 4 | MD-4-VerletBoundaryPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT01 |
| 4 | MD-4-OscillatorSpectrum | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT47 |
| 4 | MD-4-SymplecticEulerRoots | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT47 |
| 4 | MD-4-SymplecticEulerUnitRoots | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT47 |
| 4 | MD-4-SymplecticEulerStability | FAIL | B | 明确为修订稳定内区间结论；补超阈值实谱恰为一内一外非零实根、真实指数增长轨道及正步长稳定集合上确界2/Ω。原端点错误单列保留，未新增证明。 | 已修待复审 | EAUDIT47 |
| 4 | MD-4.1-PrintedImplicitRelation | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT48 |
| 4 | MD-4.1-ActualMidpointRelation | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT03 |
| 4 | MD-4.1-ImplicitFactor | FAIL | B | 保留因子并补线性场iΩz的印刷隐式更新等价式；分母实部1不需额外非零假设，新定理暂sorry。 | 已修待复审 | EAUDIT48 |
| 4 | MD-4.1-ImplicitModulus | FAIL | B | 增加任意步长的标量迭代范数保持，准确对应当前线性振子模态；不扩大到任意线性系统。原模长证明保留。 | 已修待复审 | EAUDIT48 |
| 4 | MD-4.1-PrintedModifiedFrequency | NEEDS_HUMAN | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT03 |
| 4 | MD-4.1-ModifiedFrequencyLimit | FAIL | B | 补x=hΩ的频率比零点极限1与正无穷极限0及实际频率桥接，保留旧h→0证明；新结论不作证明。 | 已修待复审 | EAUDIT48 |
| 4 | MD-4.1-MechanicalMidpoint | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.1-MidpointElimination | FAIL | B | 保留消元公式及其已有证明，补实际相空间场的隐式Euler半步→显式Euler半步关系等价，不静默缩掉组合结论。 | 已修待复审 | EAUDIT48 |
| 4 | MD-4.2.1-SplitHamiltonian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.2.1-FastVerlet | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT49 |
| 4 | MD-4.2.1-RESPA | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT49 |
| 4 | MD-4.2.1-RESPAStructure | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT04 |
| 4 | MD-4.2.1-SlowMatrix | FAIL | B | 本条明确只承担S_h；同一展示中的F_h由MD-4.2.1-FastMatrix承担，原合引文字保留。 | 已修待复审 | EAUDIT49 |
| 4 | MD-4.2.1-FastMatrix | FAIL | A | F_h使用原Ω≫1模型的非零频率域，防止除零总化；S_h由SlowMatrix承担，原展示不删。 | 已修待复审 | EAUDIT49 |
| 4 | MD-4.2.1-ImpulseMatrix | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.2.1-ImpulseDet | FAIL | B | 保留三项行列式证明；补复特征多项式的完整首一二次分解及两根乘积1，重根以两个因子计重，非任取两个单根。 | 已修待复审 | EAUDIT49 |
| 4 | MD-4.2.1-ImpulseTrace | FAIL | B | 保留trace计算，并用同一个完整二次分解绑定按代数重数的两个根及根和，不重复任取同一简单根。 | 已修待复审 | EAUDIT49 |
| 4 | MD-4.2.1-ResonancePower | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT49 |
| 4 | MD-4.2.1-ResonanceTaylor | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT49 |
| 4 | MD-4.2.1-ResonanceInstability | FAIL | B | 补共振左邻域完整两实根分解、圆外根及实际指数轨道；δ≤π/Ω明确正步长。旧圆外复根结论保留。 | 已修待复审 | EAUDIT50 |
| 4 | MD-4.2.1-ResonanceEigenPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT05 |
| 4 | MD-4.2.2-MollifiedAverage | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.2.2-MollifiedPotential | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT51 |
| 4 | MD-4.2.1-ResonanceLinearRate | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT05 |
| 4 | MD-4.2.1-ResonanceGrowth | FAIL | B | 本条明确为发散推论；线性率由MD-4.2.1-ResonanceLinearRate、交替幂公式由MD-4.2.1-ResonancePower承担，原norm振荡疑误在LinearRate待导师，不删句。 | 已修待复审 | EAUDIT50 |
| 4 | MD-4.2.2-MollifiedStructure | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3-HolonomicRelation | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT52 |
| 4 | MD-4.3-TimeConstraintDerivative | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3-ConstrainedSolution | FAIL | A | 教材主接口固定F=−∇U、正质量、经典可微U/g及开时间域上真实导数；任意位置力/within总化接口改名保留辅助，不冒充教材机械系统。 | 已修待复审 | EAUDIT52 |
| 4 | MD-4.3-ConstraintSet | FAIL | C | C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | 已修待复审 | EAUDIT46 |
| 4 | MD-4.3-CotangentSet | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3-ConstraintJacobian | FAIL | B | 在同一source_id补原句真正的标量约束合并向量函数；Jacobian作为相邻(4.8)记号辅助保留，两对象明确。 | 已修待复审 | EAUDIT52 |
| 4 | MD-4.3-JacobianActualDerivative | FAIL | B | 保留Jacobian实际导数桥接已有证明，补实际曲线、邻域约束恒零及ODE速度的求导结论，完整包含Gqdot=0与隐藏GMinvp=0。 | 已修待复审 | EAUDIT52 |
| 4 | MD-4.3-ConstraintDegrees | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3-FlexiblePendulumHamiltonian | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT52 |
| 4 | MD-4.3-RestraintPotential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3-RestraintForcePrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT07 |
| 4 | MD-4.3-ConstrainedPendulum | FAIL | A | 增加开时间域，保证within导数确为经典运动导数，排除单点域任意导数的伪运动。 | 已修待复审 | EAUDIT52 |
| 4 | MD-4.3-ConstraintCurvature | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3-ReactionMultiplier | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT52 |
| 4 | MD-4.3-ReactionBalance | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT52 |
| 4 | MD-4.3-GramPositive | FAIL | B | 仅为正质量/梯度独立推出正定的充分条件辅助；原句可解且唯一的完整乘子结论由MD-4.3-GramInvertible补全，原文不删。 | 已修待复审 | EAUDIT53 |
| 4 | MD-4.3-GramInvertible | FAIL | B | 保留原可逆性充分条件证明，补det≠0下反力乘子唯一可解及明确逆Gram公式；F和φ是给定线性方程数据，不把所求λ作假设。 | 已修待复审 | EAUDIT53 |
| 4 | MD-4.3-CotangentInvariant | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT53 |
| 4 | MD-4.3-ReducedFieldRegularity | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT53 |
| 4 | MD-4.3.1-RestrictedForm | FAIL | B | 保留一般拉回定义，并补实际位置/隐藏约束余切流形切空间上限制标准二形式的非退化；正质量、C²、梯度独立为EXTRA正则资格。任意chart本身不声称辛。 | 已修待复审 | EAUDIT54 |
| 4 | MD-4.3.1-VariationalFormula | FAIL | B | 保留一般场导数公式，新增真实约束曲线的切向变分资格，将Gdq=0与两分量变分方程同一结论合取。新结论暂sorry。 | 已修待复审 | EAUDIT54 |
| 4 | MD-4.3.1-HessianPullbackCancel | FAIL | B | 保留动量项消去已有证明，补实际时间流/线性变分及合法约束切向量上的完整二形式导数零；位置项由常对角逆质量对称抵消，未把二形式守恒作前提。 | 已修待复审 | EAUDIT54 |
| 4 | MD-4.3.1-ConstrainedFlowPullback | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.2-PositionEulerPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.2-PositionEulerForceConvention | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT10 |
| 4 | MD-4.3.2-HiddenEulerError | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.2-ProjectionResidual | FAIL | B | 补真实零残差方程及原印F符号下base、η=h²λ与旧状态的消元等价；不把残差函数冒充已解投影方程。 | 已修待复审 | EAUDIT55 |
| 4 | MD-4.3.2-ProjectionJacobian | FAIL | B | 保留交叉Jacobian定义，并补实际Newton线性方程RΔΛ=r及Δ=η_next−η；Q依赖base−M⁻¹Gᵀη已在R中展开。 | 已修待复审 | EAUDIT55 |
| 4 | MD-4.3.2-NewtonConstraint | FAIL | A | 真实Newton主接口加入当前交叉矩阵det≠0；补建议初值0的有限序列且逐步可逆资格显式，不把奇异逆总化当合法迭代。Mathlib逆矩阵按标准含义采信。 | 已修待复审 | EAUDIT55 |
| 4 | MD-4.3.2-FrozenNewtonConstraint | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT10 |
| 4 | MD-4.3.2-NewtonQuadratic | NEEDS_HUMAN | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT55 |
| 4 | MD-4.3.2-FrozenNewtonLinear | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT55 |
| 4 | MD-4.3.2-ProjectionScale | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT55 |
| 4 | MD-4.3.2-FrozenGramPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT11 |
| 4 | MD-4.3.3-ComponentPrinted | FAIL | A | 补正质量、约束在旧点/当前点经典可微、当前分母非零的有效步骤资格；Fin首项0对应印刷j=1。Gsup1的原印参数保留；任意j的统一式为明确参数化解释。 | 已修待复审 | EAUDIT56 |
| 4 | MD-4.3.3-ComponentConstraintStep | FAIL | A | 补正质量、约束在旧点/当前点经典可微、当前分母非零的有效步骤资格；Fin首项0对应印刷j=1。Gsup1的原印参数保留；任意j的统一式为明确参数化解释。 | 已修待复审 | EAUDIT56 |
| 4 | MD-4.3.3-ComponentSweep | FAIL | B | 保留一次修订梯度扫描辅助；新增字面Gsup1分母的实际逐分量轨迹、多轮顺序循环与每步有效域，以及一轮全部增量停止检查。字面原式不暗换Gsup1，不添加收敛承诺。 | 已修待复审 | EAUDIT56 |
| 4 | MD-4.3.4-ProjectedEulerPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.4-ProjectedEulerRelation | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT13 |
| 4 | MD-4.3.4-Lemma41 | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT57 |
| 4 | MD-4.3.4-MultiMomentumPullback | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.4-ProjectedEulerPullback | FAIL | B | 原总拉回等式已有证明保留；同条补Q/Pbar与q/Pbar、q/Pbar与q/p的两条实际微分二形式中间等式，逐句覆盖原证明链。 | 已修待复审 | EAUDIT57 |
| 4 | MD-4.3.4-CotangentMultiplier | FAIL | A | Gram构造限定det≠0，并补Aμ=GDp及真实投影隐藏约束；这是(4.23–24)推导的受限构造，不用值函数替代方程。 | 已修待复审 | EAUDIT57 |
| 4 | MD-4.3.4-CotangentProjection | FAIL | A | 主声明忠实为任意μ的印刷投影等式；Gram专项实现独立命名且加可逆资格，隐藏约束由CotangentMultiplier补全，不暗中求解任意原式乘子。 | 已修待复审 | EAUDIT57 |
| 4 | MD-4.3.4-CotangentHidden | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.4-CotangentRegularity | FAIL | B | 本条显式仅为专项投影C¹正则性辅助；所引完整限制二形式等式已由MD-4.3.4-CotangentPullback承担并含真实邻域位置约束，不重复冒充同一结论。 | 已修待复审 | EAUDIT57 |
| 4 | MD-4.3.4-CotangentPullback | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT57 |
| 4 | MD-4.3.4-GramProjectedEuler | FAIL | C | 教材包装全部固定a=−h，对应原印−hF的特殊参数；任意a几何推广作为独立辅助保留，原已证apply仅参数实例化。未把a=h物理修订暗作原印；不声称隐式分支存在或全局微分同胚。 | 已修待复审 | EAUDIT57 |
| 4 | MD-4.3.5-SHAKEPositionPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.5-SHAKEPositionMass | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT14 |
| 4 | MD-4.3.5-SHAKEPhase | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.5-RATTLE | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.5-ConstrainedOrders | FAIL | B | 保留局部一致性辅助，补真实光滑正则求解分支及紧时间精确轨道上的全局Euler一阶/RATTLE二阶，并给无约束振子一阶下界表达only first order。SHAKE位置阶专归SHAKEPositionOrder，其质量勘误路线待导师；原文不删。 | 已修待复审 | EAUDIT58 |
| 4 | MD-4.3.5-RATTLESymplectic | FAIL | A | 改为正质量、C²势/约束、余切域满秩的开放邻域C¹求解分支上真实拉回辛性；不假设全局隐式单值法，不声称分支存在。 | 已修待复审 | EAUDIT58 |
| 4 | MD-4.3.5-StaggeredConstraint | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT14 |
| 4 | MD-4.3.5-SHAKERATTLEEquivalence | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT14 |
| 4 | MD-4.3.5-SHAKEElimination | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT14 |
| 4 | MD-4.3.5-SHAKEPositionOrder | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT14 |
| 4 | MD-4.3.5.1-AdjointEuler | FAIL | B | 保留原三式；补非零h、两端余切域上的真实逆步关系等价（对应所选局部逆分支），及正质量/光滑分支上实际ODE的O(h²)局部误差。未把逆映射或误差结论作为资格。 | 已修待复审 | EAUDIT59 |
| 4 | MD-4.3.5.1-ConstrainedComposition | FAIL | B | 分支关系限制小h窗口、C¹空间资格及独立约束，保留辛性；补无约束Euler/伴随退化及单位圆自由运动中与RATTLE/SHAKE位置不同的具体单值近分支实例。二阶精度明确由ConstrainedCompositionOrder承担；C³是本签名实际充分资格。 | 已修待复审 | EAUDIT59 |
| 4 | MD-4.3.5.1-ConstrainedCompositionOrder | FAIL | B | 本条限定二阶局部精度，辛性在ConstrainedComposition同域对应的空间光滑分支中单列；将关系限制实际小h窗口，避免强迫全步长隐式分支存在。 | 已修待复审 | EAUDIT59 |
| 4 | MD-4.3.5.1-MomentumProjector | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.5.1-ConstrainedPotentialFlow | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.5.1-GeodesicRelation | FAIL | B | 补正质量诱导度量∑m_i u_i v_i，并在开放时间、C²约束/轨迹及满秩域上，将质量正交加速度的嵌入测地线方程与真实零势约束ODE及p=Mqdot等价；不声称全局流存在。 | 已修待复审 | EAUDIT59 |
| 4 | MD-4.3.6-MShakeIteration | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.6-SETTLE | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.6-LINCSInverse | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT60 |
| 4 | MD-4.3.6-LINCSConvergence | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT60 |
| 4 | MD-4.4-WaterPairPotential | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT61 |
| 4 | MD-4.4-TotalMass | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4-CenterMass | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT61 |
| 4 | MD-4.4-RelativePositions | FAIL | B | 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅q_i=q_cm+δ_i的相对位置定义；加权零和由MD-4.4-RelativeWeightedZero承担。 | 已修待复审 | EAUDIT61 |
| 4 | MD-4.4-RelativeWeightedZero | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4-KineticSplit | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT61 |
| 4 | MD-4.4-SecondMoment | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT61 |
| 4 | MD-4.4-RotationKinetic | FAIL | B | 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅旋转动能trace定义；粒子有限和及两式等价由MD-4.4-RotationTraceIdentity承担。 | 已修待复审 | EAUDIT61 |
| 4 | MD-4.4-RotationTraceIdentity | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT61 |
| 4 | MD-4.4-RotationSkew | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT61 |
| 4 | MD-4.4-SkewMatrix | FAIL | B | 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅三维skew坐标定义；反对称表示存在性由MD-4.4-SkewRepresentation，真实旋转导数的反对称性由MD-4.4-RotationSkew承担。 | 已修待复审 | EAUDIT62 |
| 4 | MD-4.4-CrossProduct | FAIL | B | 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅三维右手叉积坐标定义；原整条(4.39)的真实轨道导数由MD-4.4-RigidVelocity、全部代数等式由MD-4.4-CrossIdentityFull承担。 | 已修待复审 | EAUDIT62 |
| 4 | MD-4.4-SkewRepresentation | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT62 |
| 4 | MD-4.4-CrossMatrix | FAIL | B | 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅skew(u)v=u×v首等式；原整条双等式由MD-4.4-CrossIdentityFull承担。 | 已修待复审 | EAUDIT62 |
| 4 | MD-4.4-RigidVelocity | FAIL | B | 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅真实旋转轨道的导数等于ω×δ；原段落全部代数等式由MD-4.4-CrossIdentityFull承担。 | 已修待复审 | EAUDIT62 |
| 4 | MD-4.4-InertiaTensor | FAIL | B | 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅T的欧氏有限和定义；skew平方关系由MD-4.4-InertiaSkewIdentity，质量旋转动能及ω_b关系由MD-4.4-RotationBodyEnergy承担。 | 已修待复审 | EAUDIT62 |
| 4 | MD-4.4-CrossIdentityFull | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4-RotationalEnergy | FAIL | B | 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅体角速度ω_b的二次型能量定义；ω_b=Θᵀω及真实旋转粒子能量由MD-4.4-RotationBodyEnergy承担。 | 已修待复审 | EAUDIT62 |
| 4 | MD-4.4-InertiaSkewIdentity | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4-InertiaTracePrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT18 |
| 4 | MD-4.4-InertiaTraceCorrected | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT62 |
| 4 | MD-4.4-DipolarHamiltonian | FAIL | A | 真实物理接口补质量/主惯性正性和每个μ单位长度；πbody明确为体坐标角动量，数值公式不变。 | 已修待复审 | EAUDIT63 |
| 4 | MD-4.4-DipolarPairPotential | FAIL | B | 保留代数核；新增实际非碰撞粒子对q_i−q_j、r_ij=√(r·r)实例和仅i<j的完整系统势能求和，避免任意r与q脱钩。 | 已修待复审 | EAUDIT63 |
| 4 | MD-4.4-DipolarRotationalPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT19 |
| 4 | MD-4.4-RigidHamiltonian | FAIL | A | 主接口增加M>0、R可逆及ΘᵀΘ=I的实际受约束域，公式不再将任意矩阵姿态当刚体状态。 | 已修待复审 | EAUDIT63 |
| 4 | MD-4.4-SecondMomentDiagonal | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT63 |
| 4 | MD-4.4-RotationBodyEnergy | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT63 |
| 4 | MD-4.4-DipolarConstraint | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT63 |
| 4 | MD-4.4-DipolarPotentialSum | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT63 |
| 4 | MD-4.4-RotationTrajectory | FAIL | B | 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅δ_i(t)=Θ(t)δ_i(0)的真实导数辅助；原段落旋转动能有限和及trace等价由MD-4.4-RotationTraceIdentity承担。 | 已修待复审 | EAUDIT63 |
| 4 | MD-4.4-RotationDerivativePrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT20 |
| 4 | MD-4.4-RigidMatrixRelation | FAIL | A | 增加开放时间域、势能联合经典可微、M>0及R可逆，使within导数等于真实时间导数，排除单点域伪运动；姿态正交约束仍逐t保留。 | 已修待复审 | EAUDIT64 |
| 4 | MD-4.4.1-AngularMomentum | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT65 |
| 4 | MD-4.4.1-BodyMomentum | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT65 |
| 4 | MD-4.4.1-AngularInertia | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT65 |
| 4 | MD-4.4.1-EulerRigidField | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT65 |
| 4 | MD-4.4.1-FreeRigidSolution | NEEDS_HUMAN | A | 采用开放时间域和正定惯性张量，明确within导数就是实际经典导数；Mathlib标准定义按用户约定直接采信，不再因未复制定义体待人工。 | 已修待复审 | EAUDIT65 |
| 4 | MD-4.4.1-RigidInvariants | FAIL | B | 本条仅保留原页的能量与角动量模长守恒，实际Hamiltonian梯度表示/反对称性由RigidPoissonMatrix补全，退化由PoissonDegeneracy原已有声明承担，完整原文保留。 | 已修待复审 | EAUDIT65 |
| 4 | MD-4.4.1-RigidPoissonMatrix | FAIL | B | 保留J定义，补实际二次能量定义、真实fderiv梯度Hamiltonian表示及反对称性；正定惯性是物理充分资格，不预设所求梯度公式。 | 已修待复审 | EAUDIT65 |
| 4 | MD-4.4.1-PoissonDegeneracy | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT65 |
| 4 | MD-4.4.1-AxisRotation | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT66 |
| 4 | MD-4.4.1-SecondAxisPrinted | NEEDS_HUMAN | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT22 |
| 4 | MD-4.4.1-ThirdAxisPrinted | NEEDS_HUMAN | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT22 |
| 4 | MD-4.4.1-PrincipalAxisField | FAIL | B | 本条为单轴分裂场定义；完整印刷五次轴复合由PrintedSpinStep承担，实际子流的负角与原印正角冲突保留AxisFlowFormal/ExactPlanarRotation待导师。 | 已修待复审 | EAUDIT66 |
| 4 | MD-4.4.2-PrintedSpinAxis | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.2-PrintedSpinStep | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.1-AxisFlowFormal | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT22 |
| 4 | MD-4.4.1-SpinPoissonFormal | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.1-RigidPoissonSkew | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.1-RigidHamiltonianField | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.2-RigidForce | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT67 |
| 4 | MD-4.4.2-MatrixRot | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.2-RigidTorque | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT67 |
| 4 | MD-4.4.2-DLMPrinted | FAIL | B | 保留N=1字面算法作为单体实例；完整任意N、耦合势、逐阶段重算所有力矩的原算法已由DLMPrintedSystem覆盖，显式跨条目映射，不以单体冒充全系统。 | 已修待复审 | EAUDIT67 |
| 4 | MD-4.4.2-DLMMassOnly | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT23 |
| 4 | MD-4.4.2-DriftSpinCommute | FAIL | B | 保留原交换性证明，并补漂移半步合成与完整Kick/Drift/Spin/Drift/Kick排列恒等式；M=1即字面原算法，新结论暂sorry。 | 已修待复审 | EAUDIT67 |
| 4 | MD-4.4.2-DLMStructureFormal | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT23 |
| 4 | MD-4.4.2-DLMPrintedStructure | FAIL | B | 本条仅为字面单体辛性实例；原句任意N耦合算法与输入/输出SO(3)域由DLMPrintedSystemStructure承担，不再把rbSymplectic名字当作完整输出约束。 | 已修待复审 | EAUDIT67 |
| 4 | MD-4.4.2-RigidSystemState | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.2-RigidSystemForce | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT67 |
| 4 | MD-4.4.2-RigidSystemTorque | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT67 |
| 4 | MD-4.4.2-RigidSystemKick | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT67 |
| 4 | MD-4.4.2-RigidSystemDriftPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.2-RigidSystemSpinPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.2-DLMPrintedSystem | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT68 |
| 4 | MD-4.4.2-SystemDriftSpinCommute | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.2-RigidSystemSymplectic | FAIL | B | 本条仅定义全系统受约束两形式拉回性质，原句算法确实满足该性质由已有DLMPrintedSystemStructure断言，区分性质定义与算法定理。 | 已修待复审 | EAUDIT68 |
| 4 | MD-4.4.2-DLMPrintedSystemStructure | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT68 |
| 4 | MD-4.4.1-ExactPlanarRotation | NEEDS_HUMAN | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT22 |
| 5 | MD-5.1-LieDerivative | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.1-TrajectoryChain | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.1-ActualFlow | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.1-ObservablePullback | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.1-FlowFieldTransport | FAIL | B | 补可观测量g、链式中间式及完整Lie拉回输运等式，保留原向量场输运引理。联合C²与g为C¹标为充分资格。 | 已修待复审 | EAUDIT24 |
| 5 | MD-5.1-PullbackPDE | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.1-SteadyFirstIntegral | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.1-CoordinatePullback | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.1-SolutionOperator | FAIL | A | 主定义加入实际自治流资格，补G₀g=g接口；e^(tL)作为该实际流拉回的记号，不构造无界算子级数。 | 已修待复审 | EAUDIT24 |
| 5 | MD-5.1-CoordinateLie | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT24 |
| 5 | MD-5.1-LiePullbackCommutes | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT24 |
| 5 | MD-5.2.1-DensityOn | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-ProbabilityDensityOn | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-DensityOnNormalization | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-DensityProbability | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-DensityMeasureOn | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-LebesgueClosure | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-BorelSigma | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-DensityProbabilityBounds | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-DomainL2 | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT25 |
| 5 | MD-5.2.1-L2Norm | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT25 |
| 5 | MD-5.2.1-L2Inner | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-L2NormSquare | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT25 |
| 5 | MD-5.2.1-L2Complete | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT25 |
| 5 | MD-5.2.1-L2SymmetricBilinear | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-CompactL2 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-DensityAverageOn | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-ClosedSupport | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-GaussianL2 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-FiniteJumpL2 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-NormalizedAverageFormula | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.2-MassFraction | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT26 |
| 5 | MD-5.2.2-MassDerivative | FAIL | B | 保留已证的一阶积分交换，补紧空间域和联合C∞密度下质量函数C∞结论；紧域给各阶局部支配的充分资格，非结论前提。 | 已修待复审 | EAUDIT26 |
| 5 | MD-5.2.2-OutwardNormal | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT26 |
| 5 | MD-5.2.2-GeneralFluxBalance | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT26 |
| 5 | MD-5.2.2-Divergence | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅Liouvillian展示式中散度符号的真实导数迹辅助定义；完整M_f w=−div(wf)由MD-5.2.2-Liouvillian承担。 | 已修待复审 | EAUDIT26 |
| 5 | MD-5.2.2-Liouvillian | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT26 |
| 5 | MD-5.2.2-LiouvilleEquation | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT26 |
| 5 | MD-5.2.2-LiouvilleProduct | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅Liouvillian乘积法则的静态辅助引理；包含真实输运前提的完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates及MD-5.2.2-LiouvilleEquation承担。 | 已修待复审 | EAUDIT26 |
| 5 | MD-5.2.2-LieCoordinates | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT27 |
| 5 | MD-5.2.2-DivergenceCoordinates | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅真实散度的坐标辅助引理；同段完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担。 | 已修待复审 | EAUDIT27 |
| 5 | MD-5.2.2-LiouvilleProductCoordinates | FAIL | B | 保留原坐标乘积法则证明，并以真实自治流、光滑密度和Measure.map输运条件补全部时间导数PDE；不把PDE作前提。 | 已修待复审 | EAUDIT27 |
| 5 | MD-5.2.2-RectangularDomain | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.2-FaceFlux | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅矩形单面的无定向通量辅助积分；原句全部面与质量导数结论由MD-5.2.2-BoxFluxBalance，光滑一般域由MD-5.2.2-GeneralFluxBalance承担。 | 已修待复审 | EAUDIT27 |
| 5 | MD-5.2.2-BoxFluxBalance | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT27 |
| 5 | MD-5.2.2-BoundaryTerm | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT27 |
| 5 | MD-5.2.2-TruncatedIntegrationByParts | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT27 |
| 5 | MD-5.2.2-RapidAdjoint | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT27 |
| 5 | MD-5.2.2-CompactAdjoint | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT28 |
| 5 | MD-5.2.2-MeasurePropagator | FAIL | A | 主接口限定实际自治流；保留一般Measure.map辅助定义，另列由实际初始密度推前得到的点态Liouville演化；ρ(0)是初值，形式指数作记号，不将PDE作为前提。 | 已修待复审 | EAUDIT28 |
| 5 | MD-5.2.3-HamiltonianDivergence | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.3-HamiltonianSkewExpression | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT29 |
| 5 | MD-5.2.3-HamiltonianDensityPropagation | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT29 |
| 5 | MD-5.2.3-MechanicalLiouvillian | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT29 |
| 5 | MD-5.2.3-MechanicalLiouvillianIdentity | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT29 |
| 5 | MD-5.3.1-TestSpace | FAIL | C | 将Cω误编码改为原书C∞（scoped ∞）；只改Blueprint实际测试空间，正式库冻结。 | 已修待复审 | EAUDIT30 |
| 5 | MD-5.3.1-SchwartzSpace | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.1-GeneralizedFunction | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.1-SchwartzFunctional | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.1-RegularDistribution | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT30 |
| 5 | MD-5.3.1-RegularDistributionLinearity | FAIL | C | 将不必要的实解析限制恢复为原书C∞，保留有界性、Schwartz选择及原可积/线性结论；已有证明随本批编译复查。 | 已修待复审 | EAUDIT30 |
| 5 | MD-5.3.1-DiracAction | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.1-DiracMeasure | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.1-DiracApproximation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.1-GaussianDelta | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT30 |
| 5 | MD-5.3.1-DiracEvaluates | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT30 |
| 5 | MD-5.3.1-GaussianDeltaProbability | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT30 |
| 5 | MD-5.3.1-GaussianDeltaWeak | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT30 |
| 5 | MD-5.3.2-WeakStationary | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT31 |
| 5 | MD-5.3.2-EnsembleAverage | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT31 |
| 5 | MD-5.3.2-ConvergenceHeuristic | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT08 |
| 5 | MD-5.3.2-HamiltonianEnergyIntegral | FAIL | B | 补真实Hamiltonian场的−div(u f)=−L_f u及实际解上能量恒定，H为C²、u为C¹、合法闭区间轨道；保留已证L_fH=0，不把散度零/能量守恒当假设。 | 已修待复审 | EAUDIT31 |
| 5 | MD-5.3.2-EnergyDensityInvariant | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.2-ShellWeight | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅归一化密度公式中的未归一化指数权因子；完整Z与ρ由MD-5.3.2-ShellPartition及MD-5.3.2-ShellDensity承担。 | 已修待复审 | EAUDIT31 |
| 5 | MD-5.3.2-ShellPartition | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT31 |
| 5 | MD-5.3.2-ShellDensity | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT31 |
| 5 | MD-5.3.2-EnergySurface | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.2-SurfaceMeasure | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.2-MicroRaw | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.2-ShellWeakPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT08 |
| 5 | MD-5.3.2-ShellWeakLimitCorrected | PASS | C | 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。 | 已修待复审 | EAUDIT31 |
| 5 | MD-5.3.2-SurfaceAreaFormula | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT31 |
| 5 | MD-5.3.2-NormalField | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.2-NormalEnergyTaylor | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅正向法线Taylor子引理；以ΔE为变量的逆存在及O(ΔE²)结论由MD-5.3.2-NormalInverseTaylor承担。 | 已修待复审 | EAUDIT32 |
| 5 | MD-5.3.2-NormalInverseTaylor | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT32 |
| 5 | MD-5.3.2-PatchShellVolume | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT09 |
| 5 | MD-5.3.2-WholeShellVolumeLimit | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT09 |
| 5 | MD-5.3.2-MicroRawInvariant | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT32 |
| 5 | MD-5.3.2-MicroInvariant | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT32 |
| 5 | MD-5.3.2-MicroPartition | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT32 |
| 5 | MD-5.3.2-ShellPointValuePrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT10 |
| 5 | MD-5.3.2-HarmonicEnergy | FAIL | B | 补非零频率、正能量下能量面椭圆的完整等价式；质量为单位，原定义与坐标顺序保留。 | 已修待复审 | EAUDIT32 |
| 5 | MD-5.3.2-HarmonicQuadraturePrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT10 |
| 5 | MD-5.3.2-HarmonicPartition | FAIL | B | 保留真实曲面微正则质量终值，补其与正确参数积分的等式及该积分的终值；不更改原印首积分疑误。 | 已修待复审 | EAUDIT32 |
| 5 | MD-5.3.2-IdealGasEnergy | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT32 |
| 5 | MD-5.3.2-IdealGasPositionDomain | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅有限位置立方胞辅助域定义；球面半径、位置体积因子和真实微正则分解由MD-5.3.2-IdealGasPartition补全，闭胞边界零测不声称逐点周期识别。 | 已修待复审 | EAUDIT33 |
| 5 | MD-5.3.2-IdealGasPartition | FAIL | B | 补真实动量(3N−1)维球面S、r=√(2mc)、位置体积(L³)^N及面积/Gamma两项中间分解，保留原终值；不以参数积分作microRaw定义。 | 已修待复审 | EAUDIT33 |
| 5 | MD-5.3.3-MicroMeasure | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT34 |
| 5 | MD-5.3.3-MicroProbability | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT34 |
| 5 | MD-5.3.3-LowerDimensionNull | FAIL | B | 保留紧面子引理，新增无需全能量面紧性的可数紧参数块零测推广，以及正则水平集局部同胚于开ℝ^(n−1)的维数结论（相空间n=2N_d）。环境Lebesgue零测也在本批同列。 | 已修待复审 | EAUDIT34 |
| 5 | MD-5.3.3-MicroAverage | FAIL | B | 补曲面限制逆梯度积分等式，并以真实对称薄壳积分比极限表达归一化δ配对；紧正则能量带控制尾部，不把δ当普通Lebesgue函数或同测度重命名。 | 已修待复审 | EAUDIT34 |
| 5 | MD-5.3.3-AmbientLowerDimensionNull | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.4-TimeAverage | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅式(5.9)有限截断平均因子；无限时间极限存在谓词由MD-5.4-HasTimeAverage承担。 | 已修待复审 | EAUDIT35 |
| 5 | MD-5.4-HasTimeAverage | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT35 |
| 5 | MD-5.4-ConservedAverage | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅守恒观测量的有限平均辅助恒等式；第一积分及任意函数复合的无限平均由MD-5.4-ConservedInfiniteAverage承担。 | 已修待复审 | EAUDIT35 |
| 5 | MD-5.4-ConservedInfiniteAverage | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT35 |
| 5 | MD-5.4-DoubleWellEnergy | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅双阱势与能量公式定义；非负及强制性由MD-5.4-DoubleWellCoercivity承担。 | 已修待复审 | EAUDIT35 |
| 5 | MD-5.4-DoubleWellCoercivity | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.4-DoubleWellDisconnected | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.4-DoubleWellBasin | FAIL | B | 保留左右阱不变性，补全局C∞紧支撑观测量的明确见证：它在两个分离能量分支上分别为0/1，时间平均与真实对称微正则空间平均1/2不等；不把平均不等作前提，也不把不连续全局indicator冒充原光滑观测量。 | 已修待复审 | EAUDIT35 |
| 5 | MD-5.4.1-UniformMicroErgodic | FAIL | A | 明示C² Hamiltonian、常非退化反对称J生成的实际流、能量保持与正有限正则能量面背景；保留AE后∀可积光滑观测量的原量词顺序。 并恢复C∞而非Cω资格。 | 已修待复审 | EAUDIT36 |
| 5 | MD-5.4.1-MicroErgodicStandard | FAIL | C | 主接口恢复原句共同AE后∀光滑可积观测量，实际Hamiltonian/概率背景显式；旧∀L¹后AE版本仅保留为标明的替代定义，等价连接在ErgodicTimeEquivalence补列。 并恢复C∞而非Cω资格。 | 已修待复审 | EAUDIT36 |
| 5 | MD-5.4.1-FlowInvariant | FAIL | A | 按原印精确限定t≠0；真实零时恒等流下等价全时间条件，不对任意Φ默加零时限制。 | 已修待复审 | EAUDIT36 |
| 5 | MD-5.4.1-SetErgodic | FAIL | A | 集合0/1定义限定概率测度、零时恒等、实际群律及联合可测流，排除任意测度/映射的伪遍历解释。 | 已修待复审 | EAUDIT36 |
| 5 | MD-5.4.1-InvariantIndicator | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅不变集合内补集indicator逐点恒零辅助引理；无限平均零由MD-5.4.1-InvariantIndicatorAverage承担。 | 已修待复审 | EAUDIT36 |
| 5 | MD-5.4.1-InvariantIndicatorAverage | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT36 |
| 5 | MD-5.4.1-ErgodicTimeEquivalence | FAIL | B | 保留标准L¹双向定理，补紧支持概率流上共同AE光滑定义的连接及正概率不变集分支/实际indicator平均，区分原定义与标准替代定义。 | 已修待复审 | EAUDIT36 |
| 5 | MD-5.4.1-NonergodicSet | FAIL | B | 补中间概率不变集合内真实轨道保持、补集indicator无限平均零及空间平均非零的见证；可用于实际能量面概率流，不把不等式作假设。 | 已修待复审 | EAUDIT36 |
| 5 | MD-5.4.1-HarmonicFlow | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅原系统推导的辅助解析流；原遍历结论由MD-5.4.1-HarmonicErgodic承担，频率正及能量正按该定理。 | 已修待复审 | EAUDIT37 |
| 5 | MD-5.4.1-HarmonicErgodic | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.4.1-TwoOscillatorEnergy | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅两项分能量H₁/H₂定义；总能量分解由MD-5.4.1-TwoOscillatorEnergyDecomposition，分能量不变性由MD-5.4.1-TwoOscillatorTori承担。 | 已修待复审 | EAUDIT37 |
| 5 | MD-5.4.1-TwoOscillatorFlow | FAIL | B | 保留解析流并补任意初值（包括零分能量退化层）的两个真实分能量不变量，不再只依赖正共同层的Tori结论。原非零频率资格显式。 | 已修待复审 | EAUDIT37 |
| 5 | MD-5.4.1-TwoOscillatorTori | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT14 |
| 5 | MD-5.4.1-Mixing | FAIL | A | 混合定义在谓词内记录概率参考测度、零时恒等、群律、联合可测实际流；保留AC初始概率与有界连续测试配对。相关已有证明取第二合取后重查。 | 已修待复审 | EAUDIT37 |
| 5 | MD-5.4.1-KAMPersistence | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT14 |
| 5 | MD-5.4.1-AnisotropicPotential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.4.1-AnisotropicAxisPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT14 |
| 5 | MD-5.4.1-TwoOscillatorEnergyDecomposition | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅含零分能量退化边界的静态能量层分解；正层拓扑/不变性/非遍历由MD-5.4.1-TwoOscillatorTori承担并保留其原书退化层疑误待导师。 | 已修待复审 | EAUDIT37 |
| 5 | MD-5.4.1-CurveImageDimension | PASS | C | 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。 | 已修待复审 | EAUDIT37 |
| 5 | MD-5.4.1-PendulumPotential | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT37 |
| 5 | MD-5.4.1-PendulumRegionPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT16 |
| 5 | MD-5.4.1-AnisotropicInitialCurve | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.4.1-AnisotropicInitialEnergy | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.4.1-InitialSegmentPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT16 |
| 5 | MD-5.4.1-CircleInitialPoints | FAIL | A | 将实际初值域限定可行能量及原x区间；θ为后条均匀角分布的取样变量，定性样本图像不强化为全样本必然分离。零半径为允许退化；总延拓仅作独立辅助定义。 | 已修待复审 | EAUDIT37 |
| 5 | MD-5.4.1-CircleInitialLaw | FAIL | A | 均匀圆概率主接口限定可行能量和原x区间，使用归一化角测度推前；c=U为退化Dirac，不默认负能差的sqrt总化初值。 | 已修待复审 | EAUDIT38 |
| 5 | MD-5.4.1-CircleInitialEnergy | PASS | A | 原能量恒等式保留为正式库总延拓的辅助证明；本条适用前提仍是非负能差，实际取样主接口由CircleInitialPoints/Law限定区间及可行域。 | 已修待复审 | EAUDIT38 |
| 5 | MD-5.5-Correlation | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT39 |
| 5 | MD-5.5-CorrelationPullback | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.5-CorrelationTimePrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT17 |
| 5 | MD-5.5-CorrelationTimeAE | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT39 |
| 5 | MD-5.5-VelocityCorrelation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.5-PositionTransition | FAIL | C | 恢复相关定义中完整归一化常数k，原k=1未归一化概率计数作为明确实例；位置投影及两个indicator积分均保留。 | 已修待复审 | EAUDIT39 |
| 5 | MD-5.5-TransitionProbability | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.5-MeasureDuality | FAIL | B | 保留推前对偶已有证明，补参考概率ν上的非负RN密度r、初始withDensity、演化Measure.map与全部加权配对链；公开ρ/ρ_E的RN解释，不对奇异δ作函数相除。 | 已修待复审 | EAUDIT39 |
| 5 | MD-5.5-MixingMemoryLoss | PASS | A | 对应补足资格后的weakMixing取第二合取，保持既有证明及原结论；不增加新证明。 | 已修待复审 | EAUDIT39 |
| 5 | MD-5.5-MixingCorrelationPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT17 |
| 5 | MD-5.5-MixingCorrelation | FAIL | B | 修订版扩至任意有限维向量观测量并以Bochner均值及inner表达完整k相关极限；保留原标量证明为辅助，新向量结论暂sorry，原漏k版本单列待导师。 | 已修待复审 | EAUDIT39 |
| 5 | MD-5.5-CenteredCorrelation | FAIL | B | 扩至向量观测量、任意一向量Bochner零均值及相关绝对值趋零，保留旧标量证明辅助；不添加单调衰减。 | 已修待复审 | EAUDIT39 |
| 5 | MD-5.6-DiscreteAveragePrinted | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT40 |
| 5 | MD-5.6-DiscreteAverage | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅标准N项平均的独立衍生变体；原印N+1项精确有限统计量由MD-5.6-DiscreteAveragePrinted承担，不宣称两有限值相同。 | 已修待复审 | EAUDIT40 |
| 5 | MD-5.6-DiscretePropagator | FAIL | A | 离散分布传播主接口显式限定可测G，避免不可测映射的Measure.map零总化被当概率推前。 | 已修待复审 | EAUDIT40 |
| 5 | MD-5.6-ModifiedField | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT40 |
| 5 | MD-5.6-ModifiedLiouvillian | FAIL | B | 保留算子线性证明，并新增原文假设的修正模型PDE定义（r≥1），与展开右侧的等价式；仅定义模型及其算子展开，不声称任意空间可微ρ自动满足PDE。 | 已修待复审 | EAUDIT40 |
| 5 | MD-5.6-ForwardEuler | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.6-ForwardComponentsPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT20 |
| 5 | MD-5.6-ForwardEnergyGrowth | FAIL | B | 保留能量精确增长率并补原谱结论：两个复特征值恰为1±ih及模√(1+h²)>1，非零步长显式；不替换原两分量疑误。 | 已修待复审 | EAUDIT40 |
| 5 | MD-5.6-EulerInvariant | FAIL | B | 除离散唯一性再补非Dirac初始概率的离散推前无任何弱概率极限；连续modified模型/稳态/非吸引分别明确绑定EulerLogCorrespondence与ForwardWeakStationary。 | 已修待复审 | EAUDIT40 |
| 5 | MD-5.6-BackwardEuler | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅隐式Euler的显式解映射定义；完整复谱与模由MD-5.6-BackwardEnergyDecay补列，所有迭代趋零由MD-5.6-BackwardEulerLimit承担。 | 已修待复审 | EAUDIT40 |
| 5 | MD-5.6-BackwardEnergyDecay | FAIL | B | 保留能量衰减已有证明，补两个完整复特征值及模严格小于1；迭代趋零由BackwardEulerLimit，实际模型由EulerLogCorrespondence/BackwardWeakStationary承担。 | 已修待复审 | EAUDIT41 |
| 5 | MD-5.6-BackwardEulerLimit | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅所有离散迭代趋零及任意初始概率弱趋Dirac；实际modified流一步对应由MD-5.6-EulerLogCorrespondence，概率弱稳态唯一及连续吸引由MD-5.6-BackwardWeakStationary承担。 | 已修待复审 | EAUDIT41 |
| 5 | MD-5.6-SymplecticEuler | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.6-SymplecticEulerShadow | FAIL | B | 保留一步不变量证明，补稳定区内主对数Hamiltonian=c(h)·二次不变量、c>0、实际矩阵指数Hamiltonian流及其时间h恰为离散步，并给两能量有界域O(h²)比例差；全部k/椭圆由SymplecticEulerEllipse、弱稳态由SymplecticWeakStationary承担。新增模型是显式技术选择，不冒称唯一修正能量。 | 已修待复审 | EAUDIT41 |
| 5 | MD-5.6-SymplecticEulerEllipse | PASS | B | 保留正定/全部k保持证明，并补正能级椭圆拓扑及零能级单点退化；二次不变量作为modified Hamiltonian的显式固定选择，实际场/流资格见SymplecticWeakStationary，不声称唯一修正能量。 | 已修待复审 | EAUDIT41 |
| 5 | MD-5.6-SymplecticEulerDensity | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅离散映射的函数能量密度不变；连续modified能量场、概率弱稳态多样与非吸引由MD-5.6-SymplecticWeakStationary承担，原整段保留。 | 已修待复审 | EAUDIT41 |
| 5 | MD-5.6-VerletShadow2 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.6-Theorem51 | PASS | C | 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。 | 已修待复审 | EAUDIT41 |
| 5 | MD-5.6-PerturbationDisplacement | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.6-PerturbationCorrection | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅Theorem5.1右端两个平均组成的校正项定义；完整正则能量族平均误差估计由MD-5.6-Theorem51承担。 | 已修待复审 | EAUDIT41 |
| 5 | MD-5.6-DenominatorBound | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅紧能量面横截分母的正下界衍生引理；原光滑与横截资格及完整平均扰动公式由MD-5.6-Theorem51承担。 | 已修待复审 | EAUDIT41 |
| 5 | MD-5.6-SmoothDenominatorBound | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅C² H/连续w的横截分母下界一般化衍生引理；原光滑资格及完整公式由MD-5.6-Theorem51承担。 | 已修待复审 | EAUDIT42 |
| 5 | MD-5.6-ZeroPerturbation | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅η≡0校正量为零的后果；一般位移定义由MD-5.6-PerturbationDisplacement、完整平均误差由MD-5.6-Theorem51承担。 | 已修待复审 | EAUDIT42 |
| 5 | MD-5.6-GradientTransverse | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.6-DynamicalCorrection | PASS | C | 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。 | 已修待复审 | EAUDIT42 |
| 5 | MD-5.6-ForwardNormDivergence | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT22 |
| 5 | MD-5.6-WeakStationary | FAIL | C | 仅弱PDE技术谓词，实际使用Blueprint修正后的C∞测试空间；原唯一概率断言由MD-5.6-ForwardWeakStationary承担。 | 已修待复审 | EAUDIT42 |
| 5 | MD-5.6-WeakAttractor | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅弱概率局部吸引的辅助技术定义；原负吸引性断言由MD-5.6-ForwardWeakStationary承担，不把定义本身当否定结论。 | 已修待复审 | EAUDIT42 |
| 5 | MD-5.6-EulerLogField | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅单位振子h>0时新增的精确对数场技术模型（h=0总延拓不用作物理解释）；实际一步/ODE对应由MD-5.6-EulerLogCorrespondence，唯一概率稳态由MD-5.6-ForwardWeakStationary承担。 | 已修待复审 | EAUDIT42 |
| 5 | MD-5.6-EulerLogFlow | FAIL | B | 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅单位振子h>0新增的精确对数流技术定义；ODE与实际Euler一步的识别由MD-5.6-EulerLogCorrespondence承担，不冒称一般有限截断modified场。 | 已修待复审 | EAUDIT23 |
| 5 | MD-5.6-EulerLogCorrespondence | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT23 |
| 5 | MD-5.6-ForwardWeakStationary | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT23 |
| 5 | MD-5.6-BackwardWeakStationary | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT23 |
| 5 | MD-5.6-SymplecticWeakStationary | PASS | B | 弱稳态接口使用前条实际一步对应的主对数modified Hamiltonian及其梯度场；函数能量密度、多种概率稳态和非吸引结论齐全，不把未按时间缩放的不变量场冒充数值步的时间h模型。 | 已修待复审 | EAUDIT23 |
