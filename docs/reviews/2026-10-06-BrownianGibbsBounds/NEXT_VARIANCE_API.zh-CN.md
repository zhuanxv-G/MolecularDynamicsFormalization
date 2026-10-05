# 下一批：same Gibbs mean/variance 与实际 Poincare 必要依赖

目标 BrownianVariance.lean，固定imports BrownianGibbsBounds和Mathlib.Probability.Moments.Variance。µ是真已归一化Gibbs概率、g为actualtorus continuous realfunction；由ContinuousMap.memLp µ ℝ g真正deriveMemLp2、1及square integrability。

已读固定mathlib源码：
- ProbabilityTheory.variance_eq_integral（AEMeasurable）给actual ∫(g-meanµg)²，variance_eq_sub（MemLp2和probability）给∫g²-(meanµg)²。
- variance_sub_const（AEStronglyMeasurable、probability）和variance_le_expectation_sq给varianceµg≤∫µ(g-c)²，c自由，不把Poincare/gap放进premise。
- ae_eq_integral_of_variance_eq_zero（MemLp2和finite）给g=meanµg AE；actualµ OpenPosMeasure已证明，Continuous.ae_eq_iff_eq给pointwise constant，真实variance zero等价constants。
- actualGibbsContinuousToLp AE/inner identity连接mean0与actualconstantone Hilbert orthogonality；canonicalmean不是长期轨道average。
- 用上批deriveddensity积分比较把actualvarianceµg ≤exp(2A)*Haar∫(g-Haarmean g)²，量词是所有actual continuousg，不假定HaarPoincare。然后需要真实Haar variance/gradientPoincare证明才能给weightedgap；不能做假定Poincare的目标定理冒充完成。

Haar Poincare尚未证明：固定AddCircleMulti有hasSum_sq_mFourierCoeff与truefullcube coeff公式；actualpartial IBP coefficient identity尚缺。有限cube逐coordinate FTC/CS tensorization是备用真实路线。必须完成其中一条，不能假设gap。

原Theorem6.1selfadjoint/compactresolvent/discrete谱/actualsemigroup仍未完成；closed+dense+formal symmetric只保留已验收事实。全部scope/ownersemanticpending继续遵守。以上新variance依赖尚未实现或验证；下一先ApiProbe精确检查固定签名。
