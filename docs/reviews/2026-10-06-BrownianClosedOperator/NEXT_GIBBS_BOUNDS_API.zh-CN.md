# 下一批：Theorem6.1实际 Gibbs 密度双边界与Poincare转换依赖

目标 BrownianGibbsBounds.lean。只有原actual unit torus/sameµ与U C∞ integer periodic，不替换模型或假设gap。

1. 原actual torus potential scalar continuous，从已proved quotient continuity打包C(UnitAddTorus(FinNc),ℝ)，M=该实际ContinuousMap sup norm；norm_coe_le_norm推出所有Q |Utorus(Q)|≤M。β任意，A=|β|*M≥0；真实Real.exp单调性给e^-A≤exp(-βUtorusQ)≤e^A。
2. 原actual partition=∫Haar weight（已证明textbookConfigurationTorusGibbsWeight_integral）；unit normalized Haar genuineprobability。Integrable/constant integral与integral_mono推出e^-A≤Z≤e^A。
3. actual density ρ=Z⁻¹exp(-βUtorusQ)，actual Zpositive；inverse inequalities给e^-2A≤ρ(Q)≤e^2A。上/下界全显式由原U derived，无bounds输入假设。
4. μ.withDensity真实积分公式将continuous nonnegative g（或平方观测）与Haar integral联系；derived bounds给双边积分/L²范数比较。目标用于原Gibbs Poincare/compactness证明，不做一般measure新库。
5. Haar Poincare路线固定Mathlib.Analysis.Fourier.AddCircleMulti含mFourierCoeff_eq_integral和hasSum_sq_mFourierCoeff；真实coordinate derivative coefficient/periodic IBP仍需实现。另一条实际有限cube FTC/CS tensorization可作备用。不得以假定HaarPoincare或σgap代替原证明。
6. Closed graph已构造但selfadjoint/resolvent仍未完成；先完成以上实际bounds依赖，再将true Poincare与closed operator/resolvent联结。全Theorem6.1/CORE_SCOPE未完成，负责人pending。

固定API已在源码定位；新bounds/Poincare阶段尚未实现或验证。BrownianClosedOperator22public fullcheck正在运行，正式Lean输入冻结。
