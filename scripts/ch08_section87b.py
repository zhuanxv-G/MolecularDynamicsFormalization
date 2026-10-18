from ch08_data import add

add('PronyLangevinLimit','8.7.1','376–377',r'''Formally τₖ→0 gives σᵢₖdt=−cₖpᵢdt+√(2k_BT cₖ)dWᵢₖ and Langevin friction γ̂=Σₖcₖ. Independent Gaussian variances add.''',
'''def pronyEffectiveFriction {K : ℕ} (c : Fin K → ℝ) : ℝ := ∑ k, c k
theorem pronyLimit_drift {K : ℕ} (c : Fin K → ℝ) (F p : ℝ) :
    F-∑ k, c k*p=F-pronyEffectiveFriction c*p := by
  simp [pronyEffectiveFriction,Finset.sum_mul]
theorem independentGaussian_varianceSum {K : ℕ} (P : Measure Ω)
    (R : Ω → (Fin K → ℝ)) (c : Fin K → ℝ) (hc : ∀ k, 0 ≤ c k)
    (hR : HasLaw R (Measure.pi (fun _ : Fin K ↦ gaussianReal 0 1)) P) :
    HasLaw (fun sample ↦ ∑ k, Real.sqrt (c k)*R sample k)
      (gaussianReal 0 (Real.toNNReal (pronyEffectiveFriction c))) P := by
  sorry''',extra=['仅形式极限系数与真实有限个独立Gaussian线性组合；τ→0过程弱收敛、初始层、统一时间界不在本条声明，列覆盖缺口。'],missing='有限乘积Gaussian线性映射的现成定理桥接。',scope='有效摩擦定义、合并漂移和有限Gaussian求和分布，不是小记忆时间极限定理。')

add('GeneralizedLangevinIntegrator','8.7.1',377,r'''The four-step method updates p_half, q_new, σ_new,k=θₖσₖ−(1−θₖ)cₖp_half+αₖ√(2k_BT cₖ)Zₖ, then p_new with the new force and new σ.''',
'''def gleIntegrator {K : ℕ} (invm : Vec n) (U : Vec n → ℝ) (c decay noise : Fin K → ℝ)
    (θ h : ℝ) (Z : Fin K → Vec n) (z : GLEState n K) : GLEState n K :=
  let ph := z.1.2+(h/2) • (-gradient U z.1.1+∑ k, z.2 k)
  let qn := z.1.1+(h • fun i ↦ invm i*ph i)
  let sn := fun k i ↦ decay k*z.2 k i-(1-decay k)*c k*ph i+
    noise k*Real.sqrt (2*θ*c k)*Z k i
  ((qn,ph+(h/2) • (-gradient U qn+∑ k, sn k)),sn)
def gleNormalSequence {K : ℕ} (P : Measure Ω) (Z : ℕ → Ω → Fin K → Vec n) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun Z P ∧ ∀ j,
    HasLaw (Z j) (Measure.pi (fun _ : Fin K ↦ Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1))) P''',kind='definition',extra=['h>0，正质量/c/τ/温度下作物理解读；跨步、模式与空间分量的完整独立正态资格另列gleNormalSequence。','此处完整单步定义，不包含离散不变分布、全局弱阶或Langevin极限保持的定理。'],scope='四个实际更新及其全部噪声资格。')

add('GLEConsistentCoefficients','8.7.1',377,r'''For consistency θₖ=1−h/τₖ+O(h²), αₖ=√h/τₖ+O(h). Choose θₖ=exp(−h/τₖ), αₖ=√((1−θₖ)²/h).''',
'''def gleDecay (τ h : ℝ) : ℝ := Real.exp (-h/τ)
def gleNoiseCoefficient (τ h : ℝ) : ℝ := Real.sqrt ((1-gleDecay τ h)^2/h)
def gleCoefficientConsistency (τ : ℝ) (decay noise : ℝ → ℝ) : Prop :=
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0)
    (fun h ↦ decay h-(1-h/τ)) (fun h ↦ h^2) ∧
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0)
    (fun h ↦ noise h-Real.sqrt h/τ) (fun h ↦ h)
theorem gleCoefficients_consistent (τ : ℝ) (hτ : 0 < τ) :
    gleCoefficientConsistency τ (gleDecay τ) (gleNoiseCoefficient τ) := by
  sorry
theorem gleCoefficient_smallMemory (h : ℝ) (hh : 0 < h) :
    Tendsto (fun τ ↦ (gleDecay τ h,gleNoiseCoefficient τ h))
      (𝓝[Set.Ioi (0 : ℝ)] 0) (𝓝 ((0 : ℝ),1/Real.sqrt h)) := by
  sorry''',extra=['h从正侧趋0、τ固定正；小记忆极限另固定h>0，只陈述单步系数极限，未把它当成随机过程极限或长期采样结论。'],missing='指数Taylor余项、平方根正侧渐近及指数衰减的短桥接；不建设广义Langevin极限理论。',scope='两项一致性渐近和所选单步系数的τ→0极限。')
