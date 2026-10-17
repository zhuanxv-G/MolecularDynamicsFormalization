"""Complete all-mass Langevin forward operator and the friction/Gibbs qualification."""
from ch06_data import add,copied,D
add('LangevinMassForward','6.3.8',244,[77],r'''In the special case of Langevin dynamics (6.32)–(6.33) for a system with $N_c$ configuration variables, the density is a function of the vectors of positions $q$, momenta $p$, and time, and the formula for the Kolmogorov operator becomes
\[\mathcal L_{\rm LD}^*\rho=-\nabla_q\cdot(M^{-1}p\rho)+\nabla_p\cdot([\nabla U(q)+\gamma p]\rho)+\gamma k_BT\Delta_M\rho;\tag{6.42}\]
where the mass-weighted Laplacian $\Delta_M$ is defined as
\[\Delta_M\stackrel{\rm def}=\nabla\cdot(M\nabla)=\sum_{i=1}^{N_c}m_i\frac{\partial^2}{\partial p_i^2}.\]''',copied(D,'langevinMassForward'),kind='definition',label='(6.42)',context=['β⁻¹=kBT，完整全部mi；动量扩散正质量mi，区别于过阻尼配置逆质量mi⁻¹。定义不计真实密度PDE已证。'])
add('MomentumMassLaplacian','6.3.8',244,[77],r'''\[\Delta_M\stackrel{\rm def}=\nabla\cdot(M\nabla)=\sum_{i=1}^{N_c}m_i\frac{\partial^2}{\partial p_i^2}.\]''',
'''def momentumMassLaplacian {n : ℕ} (m : Fin n → ℝ)
    (ρ : ((Fin n → ℝ) × (Fin n → ℝ)) → ℝ) (x : (Fin n → ℝ) × (Fin n → ℝ)) : ℝ :=
  ∑ i, m i*fderiv ℝ (fun y ↦ fderiv ℝ ρ y (0,Pi.single i 1)) x (0,Pi.single i 1)''',kind='definition',context=['实际全部动量坐标二阶偏导正质量权重。'])
add('LangevinFPEquation','6.3.8',244,[77],r'''the formula for the Kolmogorov operator becomes
\[\mathcal L_{\rm LD}^*\rho=-\nabla_q\cdot(M^{-1}p\rho)+\nabla_p\cdot([\nabla U(q)+\gamma p]\rho)+\gamma k_BT\Delta_M\rho.\]''',
'''theorem langevinFPEquation : ∀ {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin n → ℝ)) (X : ℝ → Ω → ((Fin n → ℝ) × (Fin n → ℝ)))
    (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ) (γ β : ℝ)
    (x0 : (Fin n → ℝ) × (Fin n → ℝ)) (ρ : ℝ → ((Fin n → ℝ) × (Fin n → ℝ)) → ℝ),
  textbookIsWienerVector (fun t sample ↦ W t sample) P → (∀ i, 0 < m i) → 0 < γ → 0 < β →
  MolecularDynamics.Chapter06Review.langevinMassSDE P W X m U γ β⁻¹ x0 → ContDiff ℝ ∞ U →
  ContDiff ℝ ∞ (Function.uncurry ρ) →
  (∀ t : ℝ, 0 < t → (∀ x, 0 ≤ ρ t x) ∧ HasLaw (X t) (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ t x))) P) →
  (∀ lo hi : ℝ, 0 < lo → lo ≤ hi → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ t ∈ Icc lo hi,
    ∀ x, |ρ t x|+|deriv (fun s ↦ ρ s x) t| ≤ C*Real.exp (-c*‖x‖)) →
  ∀ t x, 0 < t → deriv (fun s ↦ ρ s x) t=MolecularDynamics.Chapter06Review.langevinMassForward m U γ β (ρ t) x := by
  sorry''',extra=['[EXTRA]真实任意质量Langevin过程和实际非负平滑密度law及求导尾部资格；不以弱PDE或强PDE作假设。'],missing='缺一般质量Langevin law的完整Fokker–Planck桥接；单位质量形式算子不是过程密度PDE证明。')
add('MassGibbsStationary','6.4.2',247,[84],r'''We have a stationary distribution if $\mathcal L^*\rho=0$.''',
'''theorem massGibbsStationary : ∀ {n : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ) (γ β : ℝ),
  (∀ i, 0 < m i) → ContDiff ℝ ∞ U → 0 < γ → 0 < β →
  ∀ x, MolecularDynamics.Chapter06Review.langevinMassForward m U γ β
    (fun z ↦ Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U z)) x=0 := by
  sorry''',kind='extra_claim',extra=['[EXTRA]真实任意正质量与匹配β⁻¹噪声；完整原Gibbs权重的形式stationarity验证，不将它计为Markov演化测度不变性。'],missing='现成单位质量表达已证，任意质量坐标包装尚缺短桥；实际过程不变另条。')
add('UnitMassGibbsStationaryBridge','6.4.2',247,[84],r'''We have a stationary distribution if $\mathcal L^*\rho=0$.''',copied('MolecularDynamics/Chapter06/LangevinGibbsStationaryExpression.lean','textbookLangevinForwardDifferentialOperator_gibbs_eq_zero','unitMassGibbsStationaryBridge'),kind='extra_claim',extra=['[EXTRA]现成真实单位质量原机械Hamiltonian权重、σ²=2γ/β的前向形式表达；未代表任意质量或真实过程测度不变性全部已证。'],prior=['MolecularDynamics.textbookLangevinForwardDifferentialOperator_gibbs_eq_zero'])
add('VariableFrictionForward','6.3.3',239,[64],r'''\[dp=-\nabla U(q)dt-\Gamma(q)\Gamma(q)^T pdt+\sqrt{2k_BT}M^{1/2}\Gamma(q)d\widetilde W.\]''',
'''def variableFrictionForward {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ)
    (ρ : ((Fin n → ℝ) × (Fin n → ℝ)) → ℝ) (x : (Fin n → ℝ) × (Fin n → ℝ)) : ℝ :=
  (∑ i, (-(m i)⁻¹*x.2 i*fderiv ℝ ρ x (Pi.single i 1,0) +
    fderiv ℝ (fun z ↦ (textbookConfigurationPartial U i z.1+
      ((Γ z.1*(Γ z.1).transpose).mulVec z.2) i)*ρ z) x (0,Pi.single i 1))) +
  ∑ i, ∑ k, θ*Real.sqrt (m i)*Real.sqrt (m k)*(Γ x.1*(Γ x.1).transpose) i k *
    fderiv ℝ (fun z ↦ fderiv ℝ ρ z (0,Pi.single k 1)) x (0,Pi.single i 1)''',kind='extra_claim',extra=['[EXTRA]完整原矩形Γ、任意质量的实际漂移与噪声协方差导出形式前向表达，供验证canonical资格；没有偷换为常矩阵或单位质量。'])
add('VariableFrictionCanonicalPrinted','6.3.3',239,[64],r'''However, it should be noted that in many types of modelling, the physical nature of the interaction with the solvent bath is neglected and $\gamma$ or $\Gamma(q)$ are simply viewed as artificial parameters which allow recovery of averages with respect to the canonical distribution.''',
'''theorem variableFrictionCanonicalPrinted : ∀ {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ),
  (∀ i, 0 < m i) → ContDiff ℝ ∞ U → ContDiff ℝ ∞ Γ → 0 < θ →
  ∀ x, variableFrictionForward m U Γ θ
    (fun z ↦ Real.exp (-θ⁻¹*MolecularDynamics.Chapter06Review.massHamiltonian m U z)) x=0 := by
  sorry''',verdict='NEEDS_HUMAN',issues=['任意ΓΓᵀ与对角质量不交换时，印刷漂移ΓΓᵀp与噪声M½Γ不自动满足Gibbs涨落耗散平衡；原canonical目标不能推广为任意质量/任意矩阵全称定理。'],extra=['[EXTRA]该条为原恢复canonical目标的必要形式stationarity检验；完整任意质量/Γ对象保留，不以必要检验计完整采样收敛已证。'],missing='等待网站/导师明确Γ与M的交换或正确漂移；不证明一般错误stationarity，更不伪造采样收敛。')
add('VariableFrictionCommutingStationary','6.3.3',239,[64],r'''$\gamma$ or $\Gamma(q)$ are simply viewed as artificial parameters which allow recovery of averages with respect to the canonical distribution.''',
'''theorem variableFrictionCommutingStationary : ∀ {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ),
  (∀ i, 0 < m i) → ContDiff ℝ ∞ U → ContDiff ℝ ∞ Γ → 0 < θ →
  (∀ q, (Γ q*(Γ q).transpose)*Matrix.diagonal m=Matrix.diagonal m*(Γ q*(Γ q).transpose)) →
  ∀ x, variableFrictionForward m U Γ θ
    (fun z ↦ Real.exp (-θ⁻¹*MolecularDynamics.Chapter06Review.massHamiltonian m U z)) x=0 := by
  sorry''',extra=['[EXTRA]明确ΓΓᵀ与M交换，保留任意维度/矩形Γ及完整Gibbs权重stationarity；未直接假设stationarity或声称采样收敛。'],missing='缺任意质量/矩阵交换的完整坐标涨落耗散代数打包；不建设一般随机理论。')
