# 第2–5章网站审计修复队列

当前任务：修复第2–5章网站审计问题；第6章暂停，不进入第7章。
修复顺序：第2→3→4→5章，每章按节，每批≤8条；不写新证明。
完成状态：修复进行中（待处理项目/原文审校计数 459；章末验收待完成 [2, 3, 4, 5]）。
A/B/C/D初筛仅是关键词估计；须逐条阅读网站理由后确认，初筛D不代表已转导师。网站PASS只覆盖其绑定快照。

第2章：网站PASS 67 / 已修待复审 75 / 待导师 18 / 修复中 0。
第3章：网站PASS 91 / 已修待复审 4 / 待导师 5 / 修复中 49。
第4章：网站PASS 89 / 已修待复审 3 / 待导师 3 / 修复中 84。
第5章：网站PASS 108 / 已修待复审 0 / 待导师 0 / 修复中 75。

| 章 | source_id | 网站判定 | 问题类别 | 处理方式 | 状态 | EAUDIT批次 |
|---|---|---|---|---|---|---|
| 2 | MD-2-HamiltonianODE | FAIL | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT25 |
| 2 | MD-2-Hamiltonian | FAIL | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT25 |
| 2 | MD-2-Euler | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT25 |
| 2 | MD-2-OneStep | FAIL | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT25 |
| 2 | MD-2.1-Convergence | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.1-Order | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.1-Error | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.1-Thm2.1 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.1.2-SecondDerivative | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT25 |
| 2 | MD-2.1.2-Taylor2 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.1.2-Taylor2Order | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2-VerletOrder | FAIL | C | 网站首选路线：直接保留原文(q,v)速度变量，使用已定义velocityVerlet与真实速度场(v,M⁻¹F(q))；正对角质量及C⁴为充分但非最小资格，闭窗连续性为冗余明确限制。未更改正式mechanicalField/verlet，不新增证明。 | 已修待复审 | EAUDIT02 |
| 2 | MD-2.2.1-Lagrangian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.1-Admissible | NEEDS_HUMAN | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT03 |
| 2 | MD-2.2.1-Action | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.1-Variation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.1-FirstVariation | FAIL | B | 保留原三个结论，并补同一个真实点态Taylor余项的紧时间窗统一C/ε/²控制；没有把余项界当作前提，未新增证明。 | 已修待复审 | EAUDIT03 |
| 2 | MD-2.2.1-TaylorPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.1-StationaryAction | FAIL | B | 保留驻值定义，同一source_id补完整积分I=0等价式及自然Euler–Lagrange运动推出驻值的Hamilton原理；C²及a<b是充分资格。新结论只登记sorry陈述，证明留到网站PASS后。 | 已修待复审 | EAUDIT03 |
| 2 | MD-2.2.1-Parts | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.1-EulerLagrange | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT03 |
| 2 | MD-2.2.1-VariationalDerivativePrinted | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT03 |
| 2 | MD-2.2.1-StationaryNotMin | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT03 |
| 2 | MD-2.2.2-DiscretePath | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-DiscreteVelocity | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-DiscreteAction | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT04 |
| 2 | MD-2.2.2-DiscreteStationaryPrinted | FAIL | A | 保留原印0<k≤ν范围和端点疑误；改用HasFDerivAt表达经典零导数，防止不可微处fderiv总化为零；内部节点版本已有独立DiscreteVerlet条目，不裁定端点勘误。 | 已修待复审 | EAUDIT04 |
| 2 | MD-2.2.2-DiscreteDerivative | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT04 |
| 2 | MD-2.2.2-DiscreteVerlet | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-Stormer | FAIL | C | 直接使用原文质量乘法形式M(qₙ₊₁−2qₙ+qₙ₋₁)=h²F(qₙ)，避免零质量下逆质量总化造成对象不等价；仅更改Blueprint本条。 | 已修待复审 | EAUDIT04 |
| 2 | MD-2.2.2-VelocityVerlet | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-EliminateVelocity | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-MomentumVerlet | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-Leapfrog | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-LeapfrogInit | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.2-LeapfrogReconstruct | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.3-ErrorDifference | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.3-Consistency | FAIL | A | 显式0<p；本条只登记正自然数阶，属于[EXTRA]整数阶限制；保持统一K、δ及严格0<h<δ，不静默扩大端点。 | 已修待复审 | EAUDIT05 |
| 2 | MD-2.2.3-Stability | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.3-ErrorRecursion | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.3-ErrorBound | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT05 |
| 2 | MD-2.2.3-ConsistencyConvergence | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.3-ScalarVerlet | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.3-VerletExpansion | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT05 |
| 2 | MD-2.2.3-ExactExpansion | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT05 |
| 2 | MD-2.2.3-DefectPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT05 |
| 2 | MD-2.2.3-VerletConsistency | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT05 |
| 2 | MD-2.2.3-VerletStability | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT05 |
| 2 | MD-2.2.4-FirstIntegral | FAIL | A | 签名显式开放域与I在D经典可微；不再由不可微处fderiv=0总化值冒充守恒条件。 | 已修待复审 | EAUDIT06 |
| 2 | MD-2.2.4-IntegralPreserved | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT06 |
| 2 | MD-2.2.4-EnergyPreserved | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.4-AngularMomentum | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.4-IntegralMeanValue | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.2.4-IntegralLipschitz | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT06 |
| 2 | MD-2.2.4-IntegralErrorPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT06 |
| 2 | MD-2.3.1-Divergence | FAIL | B | 保留散度辅助定义，并补经典可微向量场的散度恒零谓词；覆盖原句零条件。 | 已修待复审 | EAUDIT07 |
| 2 | MD-2.3.1-Liouville | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT07 |
| 2 | MD-2.3.1-HamiltonDivergence | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.1-HamiltonVolume | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT07 |
| 2 | MD-2.3.1-VolumeChange | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.1-VariationalPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT07 |
| 2 | MD-2.3.1-DeterminantODE | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT07 |
| 2 | MD-2.3.1-DeterminantExponential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.1-FlowDet | FAIL | B | 补全可测集合真实Lebesgue体积结论，保留det=1；显式τ>0对应原[EXTRA]。已有证明仅用两条已证正式结论作合取小修补，无新证明路线。 | 已修待复审 | EAUDIT07 |
| 2 | MD-2.3.1-LJOscillator | FAIL | C | 本条绑定明确LJ势4ε[(σ/q)^12−(σ/q)^6]、正参数及正位置；原一般势关系另保留为辅助oscillatorEquation。 | 已修待复审 | EAUDIT07 |
| 2 | MD-2.3.1-LJBoundedPeriodic | PASS | C | 依赖小修：一般ODE关系改引辅助oscillatorEquation；原显式LJ势、正参数、正位置及全部周期结论逐字保留。 | 已修待复审 | EAUDIT07 |
| 2 | MD-2.3.2-LinearDivergence | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.2-LinearEuler | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.2-EulerVolumePrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT08 |
| 2 | MD-2.3.2-EulerVolumeCounterexample | FAIL | B | 强化见证为每个h≠0时/det(I+hS)/≠1，覆盖实际体积不守恒；原桥接只给det≠1，原已证结果完整保留为det_only辅助定理并重查，强化结论暂sorry，不写新证明。 | 已修待复审 | EAUDIT08 |
| 2 | MD-2.3.2-AsymmetricEuler | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.2-AsymmetricJacobian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.2-AsymmetricArea | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-SymplecticMap | FAIL | A | 采用原文经典可微辛映射资格，移除不必要C¹限制；正式库C¹定义保持不变。 | 已修待复审 | EAUDIT09 |
| 2 | MD-2.3.3-OneForm | FAIL | B | 保留逐点1-form类型，补由系数向量a构造连续线性泛函及α(z)(ξ)=a(z)ᵀξ评价式；新结论暂sorry。 | 已修待复审 | EAUDIT09 |
| 2 | MD-2.3.3-Differential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-CoordinateDifferentials | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-Wedge | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-SymplecticForm | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-FormSumWedges | FAIL | B | 保留原总楔积等式，补单项J⁽ⁱ⁾矩阵、逐项评价及ΣJ⁽ⁱ⁾=J；全部原结论保留，新补陈述不写证明。 | 已修待复审 | EAUDIT09 |
| 2 | MD-2.3.3-GeneralTwoForm | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-PullbackOne | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-PullbackTwo | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-PullbackMatrix | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-PreservesForm | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-SymplecticIffForm | FAIL | A | 教材定义等价式使用本章经典可微辛谓词；原正式桥接以C¹为定义，不能直接沿用，保留sorry，不宣称已证。 | 已修待复审 | EAUDIT09 |
| 2 | MD-2.3.3-SymplecticDet | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.3-HamiltonDet | FAIL | B | 补∀t流辛性合取，同时保留det=1和可测集合体积；时间域仍Icc0τ，不额外假称τ>0。已有证明仅将现成流辛性定理与原合取作小修补。 | 已修待复审 | EAUDIT09 |
| 2 | MD-2.3.4-Hessian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.4-HessianSymmetry | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.4-HamiltonVariationalPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT10 |
| 2 | MD-2.3.4-MatrixCancellation | FAIL | B | 保留已证代数消去；补真实时间矩阵曲线、对称S(t)、W′=JSW及完整乘积导数/零导数结论，未以导数结论为前提。 | 已修待复审 | EAUDIT10 |
| 2 | MD-2.3.4-FormConstant | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.4-HamiltonSymplectic | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT10 |
| 2 | MD-2.3.5-ChainRule | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT11 |
| 2 | MD-2.3.5-SymplecticComposition | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT11 |
| 2 | MD-2.3.5-SymplecticInverse | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT11 |
| 2 | MD-2.3.5-GlobalGroupPrinted | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT11 |
| 2 | MD-2.3.6-SymplecticIntegrator | FAIL | B | 补实际Hamiltonian流、正阶局部一致性及可用正步长域；保辛性质与数值近似资格合取，C²为充分[EXTRA]，未把无关辛映射冒充积分方法。 | 已修待复审 | EAUDIT12 |
| 2 | MD-2.3.6-SymplecticEuler | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.6-KickDifferential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.6-WedgeSelf | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.6-SymplecticEulerPreserves | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT12 |
| 2 | MD-2.3.7-Adjoint | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT13 |
| 2 | MD-2.3.7-FlowSelfAdjoint | NEEDS_HUMAN | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT13 |
| 2 | MD-2.3.7-BackwardEuler | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT13 |
| 2 | MD-2.3.7-EulerAdjoint | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.3.7-AdjointSymplecticEuler | FAIL | A | 本条显式正质量及U经典可微，并补原文(Q,P)两条坐标公式；原总化正式辅助Equiv保持，新增坐标陈述暂sorry。Mathlib Flow按用户标准含义直接采信，FlowSelfAdjoint只补材料复审。 | 已修待复审 | EAUDIT13 |
| 2 | MD-2.3.7-AdjointInvolution | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT13 |
| 2 | MD-2.4.1-Splitting | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT14 |
| 2 | MD-2.4.1-FieldAdd | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.4.1-SplittingLocal | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT14 |
| 2 | MD-2.4.1-KineticFlow | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT14 |
| 2 | MD-2.4.1-PotentialFlow | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT14 |
| 2 | MD-2.4.1-SplitEuler | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT14 |
| 2 | MD-2.4.1-VerletComposition | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT14 |
| 2 | MD-2.4.1-VerletSymplectic | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT14 |
| 2 | MD-2.4.1-SymmetricComposition | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT14 |
| 2 | MD-2.4.1-SymmetricEven | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT15 |
| 2 | MD-2.4.2-CompositionSymplectic | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT16 |
| 2 | MD-2.4.2-CompositionOrder | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT16 |
| 2 | MD-2.4.3-HarmonicSplit | FAIL | A | 保留原除法闭式，频率非零落实为证明参数；U全域经典可微为更新点导数的充分[EXTRA]，未擅加Ω=0延拓。 | 已修待复审 | EAUDIT17 |
| 2 | MD-2.4.4-ImplicitLocal | FAIL | B | 补g_h(U)⊆V，连同原左右逆完整表达局部微分同胚；不声称全域可解。 | 已修待复审 | EAUDIT18 |
| 2 | MD-2.4.4-BackwardEulerSolve | FAIL | B | 保留残差并补零点与隐式更新等价、给定G满足的映射方程；不假设任意f,h都有唯一解。 | 已修待复审 | EAUDIT18 |
| 2 | MD-2.4.4-Newton | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT18 |
| 2 | MD-2.4.4-NewtonQuadratic | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT18 |
| 2 | MD-2.4.4-FrozenNewton | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.4.5-Conjugacy | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.4.5-ConjugateIterates | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT19 |
| 2 | MD-2.4.5-ConjugateLimits | NEEDS_HUMAN | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT19 |
| 2 | MD-2.4.5-EulerConjugacy | FAIL | B | 原代数恒等式及证明完整保留；补正质量、连续力资格下的真实Homeomorph见证、双向kick及共轭方向。新结论暂sorry。 | 已修待复审 | EAUDIT19 |
| 2 | MD-2.4.5-Processing | FAIL | B | 保留预/后处理算法；补实际ODE流与共轭、正低阶s<r、高阶G及低阶B相对同一精确流F的局部阶资格，¬s+1明确低阶而非仅下界；不以共轭误差结论为假设。 | 已修待复审 | EAUDIT19 |
| 2 | MD-2.4.5-ProcessingIterates | FAIL | B | 本条明确仅承担算法与G迭代的精确恒等式；同一原句的r阶及低阶资格完整归MD-2.4.5-ProcessingOrder，保留原句不删并记录跨条映射。 | 已修待复审 | EAUDIT19 |
| 2 | MD-2.4.5-ProcessingOrder | FAIL | A | 补正时间窗与低阶B的s阶误差资格及0<s<r；原G高阶假设和两项误差转移结论、已证证明均保留。processingData另给严格低阶的一般方法资格。 | 已修待复审 | EAUDIT19 |
| 2 | MD-2.4.5-EulerEffectiveOrder | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.1-RK | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.1-RK4 | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT20 |
| 2 | MD-2.5.1-RK4Order | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.1-ExplicitRK | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT20 |
| 2 | MD-2.5.1-RKSymplectic | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT20 |
| 2 | MD-2.5.1-GaussFamily | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT20 |
| 2 | MD-2.5.1-Midpoint | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.1-MidpointProperties | FAIL | B | 补一般ODE局部二阶与Hamilton情形局部保辛；显式G0=id及实际方程、开状态域/小步长分支和真实流，移除全步长全初值解要求。C³分支及全域光滑场为充分[EXTRA]；二阶指至少二阶，非每个方程恰二阶。 | 已修待复审 | EAUDIT20 |
| 2 | MD-2.5.1-GaussTwo | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.1-GaussTwoOrder | FAIL | A | 改为紧轨迹开邻域U、δ小步长内的真实光滑阶段分支，显式G0=id；补充分细迭代留U，保留全网格四阶。C⁶分支为充分[EXTRA]，未无条件声称任意步长可解。 | 已修待复审 | EAUDIT20 |
| 2 | MD-2.5.2-PartitionedVerlet | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.2-PartitionedReduction | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.2-GeneralEuler | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.2-GeneralSymplectic | FAIL | B | 本条承担基本隐式辛Euler的辛性；同一原句的伴随半步复合、三步关系与对称性由MD-2.5.2-GeneralVerletSymplectic补全，原文不删。 | 已修待复审 | EAUDIT21 |
| 2 | MD-2.5.2-GeneralVerletSymplectic | FAIL | B | 以真实可逆且C¹的基本求解族构造伴随半步复合V，补三步关系、V自伴随及辛性；仅δ小步长要求真实Euler关系，全球可逆族明确为条件性[EXTRA]，不宣称一般隐式方程必有全球解。 | 已修待复审 | EAUDIT21 |
| 2 | MD-2.5.3-Newmark | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.3-NewmarkReduction | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT22 |
| 2 | MD-2.5.3-NewmarkDamping | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.3-NewmarkNotSymplectic | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT22 |
| 2 | MD-2.5.4-MultiTaylor | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT23 |
| 2 | MD-2.5.4-TIPotential | PASS | B | 原文CORRECTED原页复核合并；签名复用，补材料复审 | 已修待复审 | EAUDIT23 |
| 2 | MD-2.5.4-TIForce | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT23 |
| 2 | MD-2.5.4-TIOrder | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT23 |
| 2 | MD-2.5.5-Beeman | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 f24b625cda35） | — |
| 2 | MD-2.5.5-BeemanOrder | FAIL | D | 仅登记问题/选项/网站反例，保持签名现状 | 待导师 | EAUDIT24 |
| 3 | MD-3-ModifiedConstruction | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 已修待复审 | EAUDIT01 |
| 3 | MD-3.1-AdjointEulerOscillator | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.1-ShadowHamiltonian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.1-EnergyFailure | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 已修待复审 | EAUDIT01 |
| 3 | MD-3.1-ShadowInvariant | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.1-ShadowEllipses | NEEDS_HUMAN | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待导师；原文CORRECTED待原页复核 | — |
| 3 | MD-3.1-EulerGrowth | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.1-FormalHamiltonian | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 已修待复审 | EAUDIT01 |
| 3 | MD-3.1-FormalHamiltonianField | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 已修待复审 | EAUDIT01 |
| 3 | MD-3.2-LieDerivative | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.2-ObservableDerivative | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.2-ObservableSecondDerivative | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.2-OperatorExponential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.2-FormalObservable | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.2-FiniteLieTaylor | NEEDS_HUMAN | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待导师 | — |
| 3 | MD-3.2-FlowCoordinates | NEEDS_HUMAN | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待导师；原文CORRECTED待原页复核 | — |
| 3 | MD-3.2-PoissonBracket | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.2-PoissonCoordinates | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.2-PoissonBilinearity | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.2-PoissonSkew | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.2-PoissonSelf | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.2-PoissonJacobi | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.2-HamiltonianObservableDerivative | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.2-HamiltonianLie | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.2-HamiltonianCoordinateDerivative | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3-HamiltonianLieAdditivity | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.3-FormalSplitting | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 3 | MD-3.3-ExactExponentialCubic | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.3-ProductExponentialCubic | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3-DifferenceCommutator | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 3 | MD-3.3-DifferenceCubic | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 3 | MD-3.3-HamiltonianCommutator | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3-HamiltonianCommutatorPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3-LeadingModifiedExponential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.3-LeadingShadowHamiltonian | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 3 | MD-3.3-BCH4 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3-BCHHamiltonian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3-BCHHamiltonianMatching | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 3 | MD-3.3-CommutingFlows | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.1-SymplecticEulerShadow | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.1-SymplecticEulerShadowMatching | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.2-VerletMaps | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.2-VerletHamiltonianParts | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 3 | MD-3.3.2-VerletStructure | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.2-VerletModifiedHamiltonian | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.3.2-VerletModifiedMatching | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.3.2-ModifiedEven | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.3.2-Strang | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.3.2-DifferentLogsCommute | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.3.2-StrangInverse | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.2-StrangCubic | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.3.3-YoshidaComposition | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.3-YoshidaCoefficients | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.3-YoshidaCancellation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.3-YoshidaUnique | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.3-YoshidaRaiseOrder | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 3 | MD-3.3.3-Yoshida4 | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 3 | MD-3.3.3-Yoshida4Structure | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.3-GeneralSplitting | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.4-TakahashiPotential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.3.4-PotentialDoubleBracket | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.4-TakahashiShadow | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 3 | MD-3.3.4-TakahashiProcessor | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.3.4-ProcessorEnergyPrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 3 | MD-3.3.4-TakahashiEffectiveOrder | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 3 | MD-3.4-ModifiedField | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.4-LeadingModifiedField | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.4-TruncatedHamiltonian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.4-TruncationSmooth | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.4-Thm3.1 | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.4-CompactLipschitz | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.4-TruncatedFlow | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.4-FiniteMatchingConstruction | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.4-TruncatedConservation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.4-EnergyTelescoping | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.4-UniformTruncatedLipschitz | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.4-TruncationRemainder | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.4-PhysicalEnergyDrift | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 3 | MD-3.4-PolynomialEnergyRate | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.4-StepCountPower | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.4-ArbitraryFiniteTruncation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.4-AnalyticDefect | NEEDS_HUMAN | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待导师；原文CORRECTED待原页复核 | — |
| 3 | MD-3.4-OptimalTruncation | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.4-ExponentialFlat | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.4-ScalarVerletShadow4 | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.4-CommutingEnergy | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 3 | MD-3.4-CommutingEnergySymmetry | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.4-EnergySymplecticNoGo | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 3 | MD-3.5-EqualComponentIntegral | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.5-EqualEulerIntegral | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.5-LinearEulerIntegral | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.5-LinearRKIntegral | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.5-VerletOscillatorEnergy | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.5-MomentumProjection | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.5-ProjectionConstraint | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.5-ProjectionFactor | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.5-ProjectionEnergy | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.5-KineticZero | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.5-EnergyProjectionRelation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.5-NoHamiltonianAttractor | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.5-LinearContinuousIntegral | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6-HamiltonianFlowStructures | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.6-VolumeNotSymplectic | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.6.1-LinearInvolution | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.1-ReversedFieldPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.1-MomentumReversal | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.1-MechanicalReversal | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.6.1-ReversedTrajectoryPrinted | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.6.1-ReversedTrajectory | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 3 | MD-3.6.2-FlowReversal | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.6.2-FlowReversalIdentity | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.6.2-ReversibleMethod | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.2-SymmetricMethod | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.6.2-AffineInvariant | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.6.2-SymmetricAffineReversible | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.6.2-RKAffine | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.6.2-PartitionedAffinePrinted | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 3 | MD-3.6.2-PartitionedAffine | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 3 | MD-3.6.3-SymplecticNotReversible | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.3-TrapezoidalRelation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.3-TrapezoidalProperties | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.3-HamiltonianSpectrum | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.3-SymplecticSpectrum | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.6.3-ReversibleSpectrum | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.3-ConjugateIterates | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.6.1-MechanicalReversalCorrect | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.6.3-ConjugateOrderPrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 3 | MD-3.6.3-ReversibleVolumeFailure | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 3 | MD-3.7-HardCoreDomain | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.7-ElasticReflection | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.7-ElasticEnergy | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.7-CollisionComposition | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.7-CollisionRegularity | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 3 | MD-3.7.1-HardCorePotential | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 3 | MD-3.7.1-PrimitiveSplitting | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.7.1-PrimitiveOrder | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 3 | MD-3.7.1-ObstacleReflection | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.7.1-PrimitiveDefect | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.7.1-CollisionDefectZero | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.7.1-EndImpactThirdOrderPrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 3 | MD-3.7.2-CollisionQuadraticPath | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.7.2-CollisionTimeRelation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.7.2-CollisionQuartic | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407） | — |
| 3 | MD-3.7.2-CollisionalVerletRelation | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 3 | MD-3.7.2-CollisionalVerletOrder | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 3 | MD-3.7.3-PairForceDecoupling | NEEDS_HUMAN | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待导师 | — |
| 3 | MD-3.7.3-DecoupledOrder | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 3 | MD-3.7.3-ModifiedCollisionProjection | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 433a13ca6407）；原文CORRECTED待原页复核 | — |
| 3 | MD-3.7.1-FreeHardSphereHamiltonian | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 4 | MD-4-LinearField | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4-EulerFactor | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4-ScalarEulerStable | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4-EulerRegion | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4-OscillatorMatrix | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4-EulerImaginaryGrowth | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 4 | MD-4-SymplecticEulerMatrix | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4-SymplecticEulerCharacteristic | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 4 | MD-4-PRKThreshold | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4-VerletStability | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 4 | MD-4-SymplecticEulerBoundaryPrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 4 | MD-4-VerletBoundaryPrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 4 | MD-4-OscillatorSpectrum | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4-SymplecticEulerRoots | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4-SymplecticEulerUnitRoots | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4-SymplecticEulerStability | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 4 | MD-4.1-PrintedImplicitRelation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.1-ActualMidpointRelation | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.1-ImplicitFactor | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 4 | MD-4.1-ImplicitModulus | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 4 | MD-4.1-PrintedModifiedFrequency | NEEDS_HUMAN | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待导师 | — |
| 4 | MD-4.1-ModifiedFrequencyLimit | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 4 | MD-4.1-MechanicalMidpoint | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.1-MidpointElimination | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 4 | MD-4.2.1-SplitHamiltonian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.2.1-FastVerlet | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.2.1-RESPA | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.2.1-RESPAStructure | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 4 | MD-4.2.1-SlowMatrix | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 4 | MD-4.2.1-FastMatrix | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 4 | MD-4.2.1-ImpulseMatrix | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.2.1-ImpulseDet | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 4 | MD-4.2.1-ImpulseTrace | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.2.1-ResonancePower | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.2.1-ResonanceTaylor | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.2.1-ResonanceInstability | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.2.1-ResonanceEigenPrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.2.2-MollifiedAverage | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.2.2-MollifiedPotential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.2.1-ResonanceLinearRate | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.2.1-ResonanceGrowth | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.2.2-MollifiedStructure | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3-HolonomicRelation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3-TimeConstraintDerivative | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3-ConstrainedSolution | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 4 | MD-4.3-ConstraintSet | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 4 | MD-4.3-CotangentSet | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3-ConstraintJacobian | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 4 | MD-4.3-JacobianActualDerivative | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 4 | MD-4.3-ConstraintDegrees | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3-FlexiblePendulumHamiltonian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3-RestraintPotential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3-RestraintForcePrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3-ConstrainedPendulum | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 4 | MD-4.3-ConstraintCurvature | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3-ReactionMultiplier | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3-ReactionBalance | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3-GramPositive | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 4 | MD-4.3-GramInvertible | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3-CotangentInvariant | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3-ReducedFieldRegularity | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.1-RestrictedForm | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 4 | MD-4.3.1-VariationalFormula | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 4 | MD-4.3.1-HessianPullbackCancel | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.1-ConstrainedFlowPullback | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.2-PositionEulerPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.2-PositionEulerForceConvention | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 4 | MD-4.3.2-HiddenEulerError | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.2-ProjectionResidual | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 4 | MD-4.3.2-ProjectionJacobian | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 4 | MD-4.3.2-NewtonConstraint | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 4 | MD-4.3.2-FrozenNewtonConstraint | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.2-NewtonQuadratic | NEEDS_HUMAN | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 已修待复审；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.2-FrozenNewtonLinear | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.2-ProjectionScale | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.2-FrozenGramPrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.3-ComponentPrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.3-ComponentConstraintStep | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.3-ComponentSweep | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.4-ProjectedEulerPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.4-ProjectedEulerRelation | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 4 | MD-4.3.4-Lemma41 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.4-MultiMomentumPullback | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.4-ProjectedEulerPullback | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 4 | MD-4.3.4-CotangentMultiplier | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 4 | MD-4.3.4-CotangentProjection | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 4 | MD-4.3.4-CotangentHidden | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.4-CotangentRegularity | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.4-CotangentPullback | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.4-GramProjectedEuler | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.5-SHAKEPositionPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.5-SHAKEPositionMass | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 4 | MD-4.3.5-SHAKEPhase | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.5-RATTLE | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.5-ConstrainedOrders | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.5-RATTLESymplectic | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 4 | MD-4.3.5-StaggeredConstraint | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 4 | MD-4.3.5-SHAKERATTLEEquivalence | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 4 | MD-4.3.5-SHAKEElimination | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.5-SHAKEPositionOrder | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.5.1-AdjointEuler | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 4 | MD-4.3.5.1-ConstrainedComposition | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.5.1-ConstrainedCompositionOrder | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 4 | MD-4.3.5.1-MomentumProjector | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.5.1-ConstrainedPotentialFlow | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.5.1-GeodesicRelation | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 4 | MD-4.3.6-MShakeIteration | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.6-SETTLE | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.3.6-LINCSInverse | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.3.6-LINCSConvergence | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-WaterPairPotential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-TotalMass | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4-CenterMass | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-RelativePositions | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-RelativeWeightedZero | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4-KineticSplit | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-SecondMoment | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-RotationKinetic | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-RotationTraceIdentity | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-RotationSkew | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-SkewMatrix | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-CrossProduct | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-SkewRepresentation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-CrossMatrix | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-RigidVelocity | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-InertiaTensor | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-CrossIdentityFull | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4-RotationalEnergy | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-InertiaSkewIdentity | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4-InertiaTracePrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-InertiaTraceCorrected | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-DipolarHamiltonian | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-DipolarPairPotential | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-DipolarRotationalPrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 4 | MD-4.4-RigidHamiltonian | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-SecondMomentDiagonal | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-RotationBodyEnergy | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-DipolarConstraint | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-DipolarPotentialSum | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-RotationTrajectory | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-RotationDerivativePrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4-RigidMatrixRelation | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.1-AngularMomentum | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.1-BodyMomentum | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.1-AngularInertia | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.1-EulerRigidField | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.1-FreeRigidSolution | NEEDS_HUMAN | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 已修待复审；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.1-RigidInvariants | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.1-RigidPoissonMatrix | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.1-PoissonDegeneracy | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.1-AxisRotation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.1-SecondAxisPrinted | NEEDS_HUMAN | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待导师 | — |
| 4 | MD-4.4.1-ThirdAxisPrinted | NEEDS_HUMAN | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待导师 | — |
| 4 | MD-4.4.1-PrincipalAxisField | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.2-PrintedSpinAxis | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.2-PrintedSpinStep | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.1-AxisFlowFormal | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 4 | MD-4.4.1-SpinPoissonFormal | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.1-RigidPoissonSkew | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.1-RigidHamiltonianField | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.2-RigidForce | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.2-MatrixRot | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.2-RigidTorque | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.2-DLMPrinted | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.2-DLMMassOnly | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 4 | MD-4.4.2-DriftSpinCommute | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 4 | MD-4.4.2-DLMStructureFormal | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 4 | MD-4.4.2-DLMPrintedStructure | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 4 | MD-4.4.2-RigidSystemState | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.2-RigidSystemForce | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.2-RigidSystemTorque | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.2-RigidSystemKick | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.2-RigidSystemDriftPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.2-RigidSystemSpinPrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.2-DLMPrintedSystem | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.2-SystemDriftSpinCommute | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd） | — |
| 4 | MD-4.4.2-RigidSystemSymplectic | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.2-DLMPrintedSystemStructure | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 fd88a08d64fd）；原文CORRECTED待原页复核 | — |
| 4 | MD-4.4.1-ExactPlanarRotation | NEEDS_HUMAN | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 已修待复审；原文CORRECTED待原页复核 | — |
| 5 | MD-5.1-LieDerivative | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.1-TrajectoryChain | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.1-ActualFlow | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.1-ObservablePullback | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.1-FlowFieldTransport | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 5 | MD-5.1-PullbackPDE | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.1-SteadyFirstIntegral | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.1-CoordinatePullback | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.1-SolutionOperator | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 5 | MD-5.1-CoordinateLie | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.1-LiePullbackCommutes | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.1-DensityOn | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-ProbabilityDensityOn | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-DensityOnNormalization | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-DensityProbability | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-DensityMeasureOn | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-LebesgueClosure | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-BorelSigma | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-DensityProbabilityBounds | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-DomainL2 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.1-L2Norm | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.1-L2Inner | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-L2NormSquare | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.1-L2Complete | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.1-L2SymmetricBilinear | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-CompactL2 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-DensityAverageOn | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-ClosedSupport | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-GaussianL2 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-FiniteJumpL2 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.1-NormalizedAverageFormula | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.2-MassFraction | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-MassDerivative | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-OutwardNormal | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-GeneralFluxBalance | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-Divergence | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-Liouvillian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-LiouvilleEquation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-LiouvilleProduct | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-LieCoordinates | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-DivergenceCoordinates | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-LiouvilleProductCoordinates | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-RectangularDomain | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.2-FaceFlux | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-BoxFluxBalance | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-BoundaryTerm | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-TruncatedIntegrationByParts | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-RapidAdjoint | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-CompactAdjoint | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.2-MeasurePropagator | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.3-HamiltonianDivergence | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.2.3-HamiltonianSkewExpression | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.3-HamiltonianDensityPropagation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.3-MechanicalLiouvillian | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.2.3-MechanicalLiouvillianIdentity | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.1-TestSpace | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 5 | MD-5.3.1-SchwartzSpace | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.1-GeneralizedFunction | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.1-SchwartzFunctional | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.1-RegularDistribution | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.1-RegularDistributionLinearity | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 5 | MD-5.3.1-DiracAction | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.1-DiracMeasure | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.1-DiracApproximation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.1-GaussianDelta | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.1-DiracEvaluates | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.1-GaussianDeltaProbability | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.1-GaussianDeltaWeak | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-WeakStationary | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-EnsembleAverage | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-ConvergenceHeuristic | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-HamiltonianEnergyIntegral | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-EnergyDensityInvariant | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.2-ShellWeight | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-ShellPartition | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-ShellDensity | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-EnergySurface | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.2-SurfaceMeasure | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.2-MicroRaw | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.2-ShellWeakPrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-ShellWeakLimitCorrected | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-SurfaceAreaFormula | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-NormalField | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.3.2-NormalEnergyTaylor | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 5 | MD-5.3.2-NormalInverseTaylor | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-PatchShellVolume | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-WholeShellVolumeLimit | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-MicroRawInvariant | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-MicroInvariant | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-MicroPartition | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-ShellPointValuePrinted | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-HarmonicEnergy | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-HarmonicQuadraturePrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-HarmonicPartition | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-IdealGasEnergy | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-IdealGasPositionDomain | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.2-IdealGasPartition | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.3-MicroMeasure | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.3-MicroProbability | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.3-LowerDimensionNull | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 5 | MD-5.3.3-MicroAverage | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.3.3-AmbientLowerDimensionNull | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.4-TimeAverage | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4-HasTimeAverage | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4-ConservedAverage | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 5 | MD-5.4-ConservedInfiniteAverage | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4-DoubleWellEnergy | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 5 | MD-5.4-DoubleWellCoercivity | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.4-DoubleWellDisconnected | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.4-DoubleWellBasin | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 5 | MD-5.4.1-UniformMicroErgodic | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4.1-MicroErgodicStandard | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4.1-FlowInvariant | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4.1-SetErgodic | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4.1-InvariantIndicator | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4.1-InvariantIndicatorAverage | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4.1-ErgodicTimeEquivalence | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4.1-NonergodicSet | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4.1-HarmonicFlow | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4.1-HarmonicErgodic | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.4.1-TwoOscillatorEnergy | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 5 | MD-5.4.1-TwoOscillatorFlow | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4.1-TwoOscillatorTori | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 5 | MD-5.4.1-Mixing | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复 | — |
| 5 | MD-5.4.1-KAMPersistence | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 5 | MD-5.4.1-AnisotropicPotential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.4.1-AnisotropicAxisPrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4.1-TwoOscillatorEnergyDecomposition | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4.1-CurveImageDimension | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.4.1-PendulumPotential | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4.1-PendulumRegionPrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4.1-AnisotropicInitialCurve | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.4.1-AnisotropicInitialEnergy | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.4.1-InitialSegmentPrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.4.1-CircleInitialPoints | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 5 | MD-5.4.1-CircleInitialLaw | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复 | — |
| 5 | MD-5.4.1-CircleInitialEnergy | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.5-Correlation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.5-CorrelationPullback | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.5-CorrelationTimePrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.5-CorrelationTimeAE | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.5-VelocityCorrelation | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.5-PositionTransition | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.5-TransitionProbability | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.5-MeasureDuality | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.5-MixingMemoryLoss | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.5-MixingCorrelationPrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.5-MixingCorrelation | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.5-CenteredCorrelation | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-DiscreteAveragePrinted | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-DiscreteAverage | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-DiscretePropagator | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-ModifiedField | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-ModifiedLiouvillian | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-ForwardEuler | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.6-ForwardComponentsPrinted | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 5 | MD-5.6-ForwardEnergyGrowth | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 5 | MD-5.6-EulerInvariant | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-BackwardEuler | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 5 | MD-5.6-BackwardEnergyDecay | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 5 | MD-5.6-BackwardEulerLimit | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-SymplecticEuler | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.6-SymplecticEulerShadow | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 5 | MD-5.6-SymplecticEulerEllipse | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.6-SymplecticEulerDensity | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-VerletShadow2 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.6-Theorem51 | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.6-PerturbationDisplacement | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.6-PerturbationCorrection | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复 | — |
| 5 | MD-5.6-DenominatorBound | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 5 | MD-5.6-SmoothDenominatorBound | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复 | — |
| 5 | MD-5.6-ZeroPerturbation | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-GradientTransverse | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.6-DynamicalCorrection | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.6-ForwardNormDivergence | FAIL | D（初筛，未确认） | 核对是否需数学判断；确认后仅登记NEEDS_HUMAN | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-WeakStationary | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-WeakAttractor | FAIL | B（初筛，未确认） | 补全结论；跨条目才显式缩范围并追加repair_log | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-EulerLogField | FAIL | A（初筛，未确认） | 补前提/定义域并标[EXTRA] | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-EulerLogFlow | FAIL | C（初筛，未确认） | 核对对象与网站路线；需选择则待导师 | 待分类/修复；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-EulerLogCorrespondence | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-ForwardWeakStationary | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a）；原文CORRECTED待原页复核 | — |
| 5 | MD-5.6-BackwardWeakStationary | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
| 5 | MD-5.6-SymplecticWeakStationary | PASS | — | 复用绑定快照证据 | 网站PASS（绑定版本 e9c5ec7b563a） | — |
