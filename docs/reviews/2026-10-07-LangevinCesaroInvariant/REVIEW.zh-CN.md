# Theorem 6.2 依赖：真实离散时刻不变概率律存在

对应印刷251–254/PDF272–275原Theorem6.2的不变律存在证明链。原PDF SHA重新核对一致，复用相同PDF272、273页既有视觉核对，未新增274、275页视觉检查。本批8公开声明证明sameactualκ的正离散时刻不变律，不宣称全连续时间invariance、唯一性或weighted-test指数收敛。

以同一实际κ_T∘μ构造真正ProbabilityMeasure evolution；真实Markov性确保总质量1，真实Kernel.integral_comp将原BCF f的积分转为真实BCF期待算子的积分。已验weak Feller保证该算子仍是原phase上的BCF；ProbabilityMeasure weak topology的真正BCF积分连续性给初始概率律的弱连续演化。

对μ_n=(n+1)⁻¹Σ_{i=0}^n κ_(iτ)x，用同一actual核的真CK、κ_0 Dirac及原有限平均积分证明telescoping身份：积分κ_τf减积分f=(n+1)⁻¹(κ_((n+1)τ)f(x)-f(x))。真实probability test norm估计给2‖f‖/(n+1)界，固定版本自然数极限及squeeze推该一步误差真正趋零。

给定真实严格递增Cesaro weak subsequence，分别将原f和真正κ_τf作为BCF weak tests，真误差趋零推出极限μ两种期待相同。FiniteMeasure BCF extensionality将此提升到同一actual测度κ_τ∘μ=μ，没有把目标stationarity放进假设。最后从上一已验真正Prokhorov weaksubsequence存在（初始原phase零点）实际推出正τ及不变概率律存在；exists定理只用真实Wiener/单位质量/C∞periodicU/forceLip/U≥1/γ>0，σ任意，无density或invariant-law premise。

local01只因漏显式导入已验LangevinWeakFeller产生未知算子及autoImplicit级联diagnostics，补原已验模块import后local02全部8退出0零error/Leanwarning空日志；不改变资源、数学假设或透明度，原失败日志保留。源码不存在占位或新公理，Draft和正式文件exactSHA一致。

DEP113/NOT122待唯一full-check01。实际continuousgenerator身份、jointdensity存在/原time0连续性语义、Harris唯一性/weighted-test指数收敛、Theorem6.2整体及负责人最终语义仍未完成。下一推真正NNReal时间期待、概率演化continuity与measurable time-law kernel，以构造全时间不变律；单个τ不变尚不等于全时间不变。

full-check01 passed：9148 jobs/2415公理声明/231exact inputs；10checks退出0、全部input/rawlog SHA匹配、8public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。sameactualκ真实probability evolution/期待/weakcontinuity，真实Cesaro一步telescoping/2normf除n加1界/趋零、weaksubseq由trueweakFeller推同κτ不变prob存在已机器验证；exists无density或目标invariant-law premise。仍仅skeleton stationarity，alltime invariance/continuousgenerator/densityexists/Harris未证，ownersemanticpending，Theorem6.2整体未完成。
