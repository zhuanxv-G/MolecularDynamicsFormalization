# Theorem 6.2 依赖：真实 Langevin 噪声卷积二阶矩

本批对应印刷251–253/PDF272–274 的原(6.47)及 Theorem6.2 的过程 Lyapunov 必要矩依赖。原PDF SHA本批重新核对；视觉核对复用此前相同PDF的272、273页，不将274页说成本批新增视觉检查。11个公开声明不作为独立一般化或单独教材定理交付。

使用同一实际Wiener过程的连续路径版本。Gaussian真实坐标二阶矩、联合可测性、真实可积性与Fubini给出 E∫₀ᵀ Bᵢ(s)²ds=T²/2，不预先假设时间能量矩。普通积分Cauchy平方界、阻尼指数≤1和原连续路径 AE 身份给出同一真实噪声卷积 ξ=σ[W(T)−γ∫₀ᵀexp(−γ(T−s))W(s)ds] 的坐标可测、平方可积和 Eξᵢ²≤2σ²T+σ²γ²T³。γ≥0、T≥0明确；此界用于指定有限时间，不宣称精确OU方差或全时间一致界。

所有坐标合成真实向量L²，并单独证明物理动能所用的 ∑ᵢξᵢ² 可积及期望≤N(2σ²T+σ²γ²T³)，没有用 Lean Fin 函数 sup norm 平方替代物理欧氏平方和。正摩擦和原C∞周期势能下，同一已经构造的 periodic all-time process 的动量L²由其真实阻尼动量界、原周期force常数和实际noise L²推出，不把过程矩放入假设。

local01–05保留固定API、真实函数/测度类型、求和代数及默认心跳失败。local06通过11声明，退出0、零error/Leanwarning、日志为空；过期API改为固定版本finsetSum，显式分解AEstronglymeasurable/constant/noise的类型解决自动推断超时，未提高资源或压制警告。Draft与正式源逐字节SHA一致。DEP106/NOT115；全工程验收等待full-check01。

实际核密度存在、SDE过程生成元与原微分表达式身份、真正过程Lyapunov/Harris完整定理、负责人最终教材语义仍未完成。下一从物理坐标平方和推出真实固定时间 Hamiltonian 期望漂移；不将它计作原连续时间生成元Assumption2已经完成。

full-check01 passed：9141 jobs/2366公理声明/224exact inputs；10checks退出0、全部input/rawlog SHA匹配、11public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。真实有限时刻noise矩及sameprocess momentum L²已机器验证，owner semanticpending，Theorem6.2整体未完成。
