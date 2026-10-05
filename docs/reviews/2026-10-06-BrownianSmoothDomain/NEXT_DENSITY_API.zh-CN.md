# 下一批：同一 Gibbs L² 上实际光滑周期定义域的稠密性

目标文件 BrownianSmoothDensity.lean；先局部验证再一次完整验收。沿用actual Gibbs µ、真实无限维smooth periodic domain，不能以finite Fourier截断替换域或假设稠密性。

1. 固定mathlib Analysis/Fourier/AddCircleMulti.lean: UnitAddTorus.mFourier n = coordinate fourier product。AddCircle.fourier_coe_apply给literal exp(2*pi*I*n*q/1)。用Complex.contDiff_exp.restrict_scalars ℝ、Complex.ofRealCLM和coordinate continuous linear evaluation证明实际Euclidean lift C∞。
2. C(UnitAddTorus(FinNc),ℂ) 中carrier为lift C∞的实际Submodule，zero/add/complex scalar smooth closure；Submodule.span_le证明包含每个mFourier及全span。UnitAddTorus.span_mFourier_closure_eq_top结合Submodule.dense_iff_topologicalClosure_eq_top给真实complex span dense。
3. Complex.reCLM.compLeftContinuous的连续满射（右逆Complex.ofRealCLM.compLeftContinuous）将complex smooth dense set送到real smooth continuous函数，DenseRange.dense_image/dense_of_mapsTo证明real smooth set dense。
4. real torus continuous smooth-lift g组成 f=g∘actualπ。actualπ(q+integer)=πq由AddCircle.coe_add/coe_eq_zero_iff；原representative_projects给原torusObservable f=g。进入全smooth periodic domain，绝非有限Fourier模型。
5. µ是已证明probability；有限actual torus Borel/pseudometrizable给µ.WeaklyRegular。ContinuousMap.toLp_denseRange ℝ µ ℝ (p=2)及连续映射将上述dense集送到同一L²。用ContinuousMap.coeFn_toLp与已证明sameµ observable AE相等，Lp.ext证明每项是实际embedding.range。最终 actual domain dense。
6. 稠密性完成后另行解决closed/selfadjoint realization、compact resolvent/discrete spectrum/Poincare-gap/semigroup。这些尚未证明，不能把形式对称替代自伴。

所有条目是固定源码已找到的路线；上述新density证明尚未实现或验证。前批22public fullcheck正在运行，保持正式Lean冻结。
