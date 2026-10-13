"""Sixth batch: omitted printed formulas and independent normalization checks."""
from ch06_data import add,copied,proposition,D,NS,EXCLUDED
C='MolecularDynamics/Chapter06/CanonicalTemperature.lean'
add('MeanEnergyConstraint','6.1.3',218,[10],r'''whereas $\beta$ and hence the temperature arises from the choice of average energy, i.e. from solving the equation
\[\frac{\int H(z)e^{-\beta H(z)}d\omega}{\int e^{-\beta H(z)}d\omega}=\bar E.\]
Alternatively, we may take the position that the temperature is specified and the mean energy is a direct consequence of this choice.''',
'''def meanEnergyConstraint {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β meanEnergy : ℝ) : Prop :=
  (∫ z, H z * Real.exp (-β*H z) ∂ν) / (∫ z, Real.exp (-β*H z) ∂ν) = meanEnergy''',kind='definition',context=['完整确定β的实际积分方程作为约束定义；不给定任意Ē就伪造β存在/唯一性，物理建模假设仍待审。'])
add('DensityNormalization','6.1.3',218,[11],r'''The quantity $Z_{\rm can}$ is a normalizing constant so that this is a probability density.''',
'''theorem densityNormalization : ∀ {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ),
  Integrable (fun x ↦ Real.exp (-β*H x)) ν → 0 < (∫ x, Real.exp (-β*H x) ∂ν) →
  (∫ x, MolecularDynamics.Chapter06Review.canonicalDensity ν H β x ∂ν) = 1 := by
  sorry''',kind='extra_claim',extra=['[EXTRA]任意实际参考测度、权重可积且分母正；结论是实际归一化，不假设密度积分一。'],missing='待常数除法移出Bochner积分和正分母消去的短证明。')
add('PartitionInversePrinted','6.1.5',220,[],r'''The associated canonical density is
\[\rho_\beta=Z_{\rm can}^{-1}\exp\left(-\beta\left[\frac{p^2}{2m}+U(q)\right]\right),\]
where
\[Z_{\rm can}^{-1}=\int_{-\infty}^{\infty}\int_{-\infty}^{\infty}\exp\left(-\beta\left[\frac{p^2}{2m}+U(q)\right]\right)dpdq.\]''',
'''theorem partitionInversePrinted : ∀ {n : ℕ}
    (m : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β →
  Integrable (fun x : MolecularDynamics.Chapter06Review.Phase n ↦
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)) →
  (∫ x : MolecularDynamics.Chapter06Review.Phase n,
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x))⁻¹ =
  (∫ x : MolecularDynamics.Chapter06Review.Phase n,
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)) := by
  sorry''',verdict='NEEDS_HUMAN',issues=['[ERRATUM?]此页印刷Zcan⁻¹=积分，与p.218的Zcan=积分相反；字面保留，标准DensityNormalization仍按真实积分归一化。'],explanation='不默改原式、不从可积性偷推partition=1；保留不成立的字面反转等式。',missing='p.220的Zcan上标−1疑似笔误，待人工审校；不证明字面关系。')
add('WeightedFluxIdentity','6.1.5',222,[21],r'''Since $\nabla\rho_\beta=-\beta\nabla H\rho_\beta$, we obtain, in the limit $R\to\infty$, the desired result.''',copied(C,'textbookCanonicalWeightedFlux_divergence','weightedFluxIdentity'),kind='extra_claim',extra=['[EXTRA]真实Fréchet导数和散度乘法恒等式，β任意、H,G在该点可微；不假设加权散度恒等式。'],prior=['MolecularDynamics.textbookCanonicalWeightedFlux_divergence'])
add('VirialTemperature','6.1.5',223,[22],r'''An even simpler configuration-dependent choice is derived from $G=(q,0)^T$, corresponding to
\[k_BT=\frac{\operatorname{Av}_\beta(q\cdot\nabla U)}{N_c}.\]''',
'''theorem virialTemperature : ∀ {n : ℕ} (hn : 0 < n)
    (m : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → ContDiff ℝ 2 U →
  Integrable (fun q ↦ Real.exp (-β*U q)) →
  Integrable (fun q ↦ (∑ i, q i * textbookConfigurationPartial U i q) * Real.exp (-β*U q)) →
  (∃ C : ℝ, 0 ≤ C ∧ ∀ q, ‖q‖ * Real.exp (-β*U q) ≤ C) →
  (∫ x : MolecularDynamics.Chapter06Review.Phase n,
    (∑ i, x.1 i * textbookConfigurationPartial U i x.1) *
      MolecularDynamics.Chapter06Review.canonicalDensity volume
        (MolecularDynamics.Chapter06Review.massHamiltonian m U) β x) / n = β⁻¹ := by
  sorry''',extra=['[EXTRA]实际全配置空间、n>0、一般正质量、正β及C²U；真实加权virial可积且配置通量统一有界，不假设平均温度公式。'],missing='缺一般质量相空间归一化到配置IBP的完整桥接；不将方向导数计算当作本条已证，保留sorry。')
add('VirialFieldNotPeriodic','6.1.5',224,[22],r'''However $G(z)=(q,0)^T$ is problematic for periodic boundary conditions.''',
'''theorem virialFieldNotPeriodic : ∀ {n : ℕ} (i : Fin n) (q : Fin n → ℝ),
  q + Pi.single i 1 ≠ q := by
  sorry''',extra=['[EXTRA]沿实际单位周期坐标平移时配置部分q变化，因此G=(q,0)不定义周期torus向量场；i : Fin n自动排除零维空坐标情形。'],missing='待对第i分量求值的短证明；不假设非周期结论。')
add('DensityPositive','6.1.3',218,[11],r'''The quantity $Z_{\rm can}$ is a normalizing constant so that this is a probability density.''',
'''theorem densityPositive : ∀ {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ),
  0 < (∫ z, Real.exp (-β*H z) ∂ν) →
  ∀ x, 0 < MolecularDynamics.Chapter06Review.canonicalDensity ν H β x := by
  sorry''',kind='extra_claim',extra=['[EXTRA]真实partition严格正时实际密度点态正；不将正密度作前提，积分为一在独立Normalization条目。'],missing='待Real.exp_pos与正分母的短证明。')
add('KineticWeightFactorization','6.1.5',221,[18],r'''then we may decompose the unnormalized canonical distribution as
\[\exp(-\beta[K(p)+U(q)])=\exp(-\beta K(p))\exp(-\beta U(q))
=\exp(-\beta U(q))\prod_{i=1}^{N_c}\exp\left(-\beta\frac{p_i^2}{2m_i}\right).\]''',
'''theorem kineticWeightFactorization : ∀ {n : ℕ}
    (m q p : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U (q,p)) =
    Real.exp (-β*U q) * ∏ i, Real.exp (-β*(p i)^2/(2*m i)) := by
  sorry''',extra=['[EXTRA]保存每坐标质量和实际有限乘积；这是点态指数代数恒等式，正质量是物理解释所需，不计积分/能均分已证。'],missing='待Real.exp_add、exp_sum与有限和常数乘法的短证明。')
EXCLUDED += [dict(printed_page='223–224',pdf_page='244–245',reason='分母接近零导致数值不稳、优先使用动能温度是定性计算建议；三个实际温度公式、周期边界消去及q场非周期性均已单列。')]
