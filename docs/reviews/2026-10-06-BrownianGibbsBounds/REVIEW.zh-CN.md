# Theorem6.1：实际Gibbs density双边界/真实weighted积分与L²比较

沿用原印刷250–251/PDF271–272actual finite unit torus、U C∞且integerperiodic、同一actual normalized Gibbs µ。β任意；质量无关本批。C(UnitAddTorus,ℝ)的真实descended原U由前批continuity推出，M是真supnorm，A=|β|M；不是额外bound参数或bounds前提。实际unit Haar probability已固定，与前批同一convention一致。

原coordinate quotient/observable不变，CM.norm_coe_le_norm推出∀Q |Utorus(Q)|≤M，真指数绝对值≤A→literal Gibbs unnormalized weight在[e^-A,e^A]。原truepartition=Haar积分weight，与constant integrals和integral_mono推出Z在[e^-A,e^A]。Z原已证明positive，inverse与product inequalities给actual µ所使用density=Zinv weight∈[e^-2A,e^2A]，并strict positive、continuous，全部显式真实证明，不假设densitybound。

实际withDensity积分公式给continuousg的true µ integral=∫Haar density*g；真实compact/finite积分性来自ContinuousMap.memLp1。对g≥0 derive双边积分界；actualg²给予平方积分比较，同一actualcontinuous-to-L² AE identity/L2.inner_def给真实Hilbert norm²=weighted mean square，最后deriveactual Hilbert norm²双边Haar mean-square比较。

新结果仅原Theorem6.1 Poincare/compactness必要依赖；HaarPoincare、weightedgap、selfadjoint、compactresolvent、谱与actualsemigroup仍未证明。上一批actualclosed/dense/core/形式对称非正保持验收，不把其改称selfadjoint。全CORE_SCOPE未完成，负责人教材语义pending。

local01仅density_pos的section hU未在statement中出现而需include，及匿名noncomputable section缺end；基础literalweight/partition/densitybounds已完整elaborate。local02修scope并加入真实积分/norm比较后，Continuous.exp短名无该API，改Real.continuous_exp.comp；CM.pow_apply在simp implicit transparency未匹配，actualdirect exact可defeq；norm_sq_eq_real_inner名称不存在，采用先前已验收real_inner_self_eq_norm_sq。local03全部23public退出0空日志/零警告。失败原始日志保留；formalinputs frozen，full-check01统一验收中。

full-check01 passed：9069jobs/1320公理声明/152exact inputs；10checks退出0，全部input/rawlog SHA256匹配，23public逐名只基础三公理，Lean警告0；Lean4.34.0/mathlib5ed2965；负责人semanticpending。
