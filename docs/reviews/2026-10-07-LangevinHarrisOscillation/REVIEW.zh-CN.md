# Theorem 6.2 依赖：实际 Langevin 的 Hamiltonian 加权一步严格收缩

对应印刷252–254/PDF273–275原式(6.48)与H^l权重证明链。原PDF SHA核验一致，重读273–275正文文本，复用同一273已有视觉核对，未新增274、275视觉核对。5公开声明和必要私有证明只补原实际核 Harris 证明需要的内容。

定义真正pairwise weighted oscillation界 ‖f(x)-f(y)‖≤C(2+β(Vx+Vy))。measurable f允许无界，锚点(0,0)与真实V矩产生可积domination，导出f可积，不预设观测量可积。对两个真实概率律把原pairwise界逐次真实积分，得期待差界 C(2+β(µV+νV))。

共同测度下界ofReal(ε)•ρ≤µ,ν且0<ε<1时，使用固定版真正Measure.sub构造m=µ-ofReal(ε)•ρ，逐项证明m总质量ofReal(1-ε)非零有限，归一化为真实概率Q。原µ确实分解为共同ε•ρ与(1-ε)•Q。V对Q和ρ的可积性由测度单调及缩放从原µV可积导出；观测量可积再由weight界导出。期待差中共同ρ部分确实抵消，得到强化界 C(2(1-ε)+β(µV+νV))；没有把残余概率或耦合存在当成结构假设。

已验原actualcommonτ和Hl halfdrift给D>0/derivedR>4D。条件性density clause在这个实际derived C_R上通过已验真实smallset给ην，取ε=η.toReal/2，从η>0、η≤1及η有限推出0<ε<1，保留真实measureminorization。β=ε/(4D)>0。大能量sum≥R使用ratio (2+β(R/2+2D))/(2+βR)<1；小能量区域每个初值真在C_R，使用共享部分抵消和1-ε/2<1。max统一严格因子a∈(0,1)，同原actualκτ的真实无界test期待再满足(aC)的weightedoscillation界，并且真实point-kernel可积与measurable期待函数均已证明。

density仍显式条件在新derived C_R上，未从旧固定C假设或纯Lie-rank推其存在；原印刷time0jointcontinuity语义未修订。实际drift/矩/严格βa/残余law和目标期待差没有作为新假设。local01/02原真实接口诊断完整保留，local03全5退出0、零error/Leanwarning空日志；Draft/正式exactcopy，DEP117/NOT126待唯一full-check01。

此批只是一步严格收缩。κ(nτ)迭代、几何指数收敛、全时间(6.48)、不变律唯一性、L*ρ=0身份、实际jointdensity存在、Gibbs身份及负责人最终语义签核尚未证明；Theorem6.2整体及CORE_SCOPE未完成。下一接真实CK与无界weightedtest积分组成，继续同actualκ迭代。

full-check01 passed：9152 jobs/2450公理声明/235exact inputs；10checks退出0、全部input/rawlog SHA匹配、5public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。真实weightedpairoscillation导无界measurable观测量可积，两prob期待差界；真正Measure.sub/normalize residualprob与sharedmeasure抵消、actualhalfdrift/derivedC_R conditionaldensity下同原κτ一步严格Harris收缩a∈(0,1)已验证，β/a/residual和目标差不作为假设。densityonnewC_R显式条件，尚未证明κ(nτ)迭代/全timeweighted6.48/不变律唯一/generator身份/densityexists/Gibbs/ownersemantic，Theorem6.2整体未完成。
