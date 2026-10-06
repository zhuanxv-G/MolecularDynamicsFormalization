# Theorem 6.2 依赖：真实不变律的 Hamiltonian 高次矩

对应印刷251–254/PDF272–275原单位质量周期 Langevin 的 Hamiltonian 权重及不变律证明链。原 PDF SHA 重新核对一致，复用同一 PDF272、273既有视觉核对，未新增274、275视觉检查。

4个公开声明及必要私有证明只使用同一原 Wiener/实际 transition kernel。此前已经证明每个初始点的实际核对 H_l 可积以及真实共同时间 half drift。本批不把目标不变律的 H_l 可积性当作前提：f_n=min(V,n) 和 w_n=min(V/2+D,n) 是真实有界连续测试，不变性只用于这些天然可积函数。实际 Markov 核及已验点核可积性推出 Kτ f_n ≤ w_n，从而 ∫f_n≤∫w_n。

G_n=f_n-w_n+D非负、可积且积分≤D；原V正性和D正性逐项证明非负，n→∞时逐点 G_n→V/2。固定版本真实 Fatou 引理推出 ∫⁻ofReal(V/2)≤ofReal D<∞，再真正导出目标µ的V可积性以及∫V≤2D。没有在使用不变性之前假设无界测试可积，也没有先把目标结论塞入 stationary-law 结构。

首个公开声明显式接受实际 half-drift 中间前提和 skeleton stationarity，后续 all-moments 声明从已验原实际 common-skeleton drift 供给各l的D。无前提的存在版本使用此前真∀T actualκ不变律存在，再应用这里导出的全部 l≥1 矩有限。最终任意原光滑周期势版本给出明确c使U+c≥1，通过已经证明的 actual kernel 加常数 identity，在原U的真实全时间不变律上得到全部归一化能量幂的可积性；只声称归一化 H_l(U+c)，没有偷换为可能负的原 H_l(U)。

local01原两处非负性/积分表示诊断保留，local02全4退出0、零error/Leanwarning空日志。Draft和正式源码exactSHA一致，DEP116/NOT125待唯一full-check01。γ>0、σ任意、原单位质量模型保持；不预设目标矩，不用密度存在或连续生成元身份。Gibbs身份、唯一性、weighted-test指数收敛、actualcontinuousgenerator与jointdensity存在及负责人语义签核仍未完成，Theorem6.2整体未完成。

full-check01 passed：9151 jobs/2445公理声明/234exact inputs；10checks退出0、全部input/rawlog SHA匹配、4public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。同原actualκ的halfdrift/BCF截断stationarity/真实Fatou推目标µHl矩可积及∫Hl≤2D，实际commonτ给全l，真实∀T不变律存在兼所有矩已验证；任意原U明确c归一化Hl(U+c)矩，在原κ真实不变律上可积。γ>0/σ任意，无目标µ矩/密度/最终stationaritypremise。未识别Gibbs/未证唯一weighted指数/continuousgenerator/densityexists/Harris/ownersemanticpending，Theorem6.2整体未完成。
