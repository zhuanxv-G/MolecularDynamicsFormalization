from ch07_data import add
add('ABOHarmonic','7.4.1','275–276',
r'''Example 7.1 Consider the scheme coded $[ABO]$.
In the case of the one-dimensional harmonic oscillator, we have $U'(q)=\Omega^2q$, yielding the compact form of one iteration as
\[\binom{q_{n+1}}{p_{n+1}}=\begin{bmatrix}1&h/m\\-\Omega^2he^{-h\gamma}&(1-\Omega^2h^2/m)e^{-h\gamma}\end{bmatrix}\binom{q_n}{p_n}+\binom0{\zeta m^{1/2}R_n}.\tag{7.12}\]
Taking expectations of (7.12) and then taking the limit as $n\to\infty$, we see immediately that
$\langle q\rangle_h^{[ABO]}=\langle p\rangle_h^{[ABO]}=0$, as $\mathbb E(R_n)=0$.''',
'''def aboHarmonic (m Ω γ θ h R : ℝ) (x : ℝ × ℝ) : ℝ × ℝ :=
  linearUpdate 1 (h/m) (-Ω^2*h*Real.exp (-h*γ)) ((1-Ω^2*h^2/m)*Real.exp (-h*γ)) x
    (0, Real.sqrt (θ*(1-Real.exp (-2*γ*h)))*Real.sqrt m*R)

theorem aboStationaryMean (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hh : 0 < h)
    (hμ : IsProbabilityMeasure μ) (hq : Integrable (fun x ↦ x.1) μ) (hp : Integrable (fun x ↦ x.2) μ)
    (hinv : Measure.map (fun z ↦ aboHarmonic m Ω γ θ h z.2 z.1) (μ.prod (gaussianReal 0 1)) = μ) :
    (∫ x, x.1 ∂μ) = 0 ∧ (∫ x, x.2 ∂μ) = 0 := by
  sorry''',label='Example 7.1 / (7.12)',extra=['原文长时间极限前提改为已存在的实际平稳概率分布及一阶矩可积；趋平稳结论不在本条覆盖。'],
missing='需推前期望方程与二元线性系统短桥；不建立Markov遍历性。')
add('ABOVariance','7.4.1',276,
r'''For example, the relative increase in the variance of position is computed for the $[ABO]$ scheme as
\[\frac{\langle q^2\rangle_h^{[ABO]}}{\langle q^2\rangle}=\frac{e^{h\gamma}m(1+e^{-h\gamma})^2}{2m(1+e^{-h\gamma})-h^2\Omega^2e^{-h\gamma}}
=1+\gamma h/2+(\Omega^2+\gamma^2m)h^2/(4m)+O(h^3).\]''',
'''def aboVarianceRatio (m Ω γ h : ℝ) : ℝ :=
  Real.exp (h*γ)*m*(1+Real.exp (-h*γ))^2 /
    (2*m*(1+Real.exp (-h*γ))-h^2*Ω^2*Real.exp (-h*γ))

theorem aboVarianceRatio_expansion (m Ω γ : ℝ) (hm : 0 < m) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ aboVarianceRatio m Ω γ h - (1+γ*h/2+(Ω^2+γ^2*m)*h^2/(4*m)))
      (fun h ↦ h^3) := by
  sorry

theorem aboStationaryVariance (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hμ : IsProbabilityMeasure μ) (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hden : 0 < 2*m*(1+Real.exp (-h*γ))-h^2*Ω^2*Real.exp (-h*γ))
    (hinv : Measure.map (fun z ↦ aboHarmonic m Ω γ θ h z.2 z.1) (μ.prod (gaussianReal 0 1)) = μ) :
    momentQ μ / (θ/Ω^2) = aboVarianceRatio m Ω γ h := by
  sorry''',
extra=['完整保留方差有理式与Taylor展开；实际平稳概率、L²及稳定区分母为正明示，不假设目标方差公式。'],
missing='需实际平稳矩方程求解及三阶Taylor余项；各路线超出短桥，保留未证。')
add('Table71','7.4.1',277,
r'''Table 7.1 The expected long-time computed average using the given second-order Langevin dynamics discretization scheme
\[\begin{array}{c|ccc}
\text{Scheme}&\langle q^2\rangle_h/\langle q^2\rangle&\langle p^2\rangle_h/\langle p^2\rangle&\langle qp\rangle\\
[ABOBA]&1&[1-h^2\Omega^2/(4m)]^{-1}&0\\
[OBABO]&[1-h^2\Omega^2/(4m)]^{-1}&1&0\\
[BAOAB]&1&1-h^2\Omega^2/(4m)&0\\
[OABAO]&1-h^2\Omega^2/(4m)&1&0
\end{array}\]''',
'''def scalarLift (F : Phase 1 → Phase 1) (x : ℝ × ℝ) : ℝ × ℝ :=
  let y := F ((fun _ ↦ x.1),(fun _ ↦ x.2))
  (y.1 0,y.2 0)

def symmetricHarmonicStep (scheme : Fin 4) (m Ω γ θ h : ℝ) (R S : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let masses : V 1 := fun _ ↦ m
  let U : V 1 → ℝ := fun q ↦ Ω^2*(q 0)^2/2
  scalarLift (if scheme = 0 then aboba masses U γ θ h (fun _ ↦ R)
    else if scheme = 1 then obabo masses U γ θ h (fun _ ↦ R) (fun _ ↦ S)
    else if scheme = 2 then baoab masses U γ θ h (fun _ ↦ R)
    else oabao masses U γ θ h (fun _ ↦ R) (fun _ ↦ S))

def symmetricInvariant (scheme : Fin 4) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ)) : Prop :=
  IsProbabilityMeasure μ ∧ MemLp (fun x ↦ x.1) 2 μ ∧ MemLp (fun x ↦ x.2) 2 μ ∧
  Measure.map (fun z : (ℝ × ℝ) × (ℝ × ℝ) ↦ symmetricHarmonicStep scheme m Ω γ θ h z.2.1 z.2.2 z.1)
    (μ.prod ((gaussianReal 0 1).prod (gaussianReal 0 1))) = μ

theorem table71 (scheme : Fin 4) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m) (hinv : symmetricInvariant scheme m Ω γ θ h μ) :
    momentQ μ/(θ/Ω^2) = (if scheme = 1 then (1-h^2*Ω^2/(4*m))⁻¹
      else if scheme = 3 then 1-h^2*Ω^2/(4*m) else 1) ∧
    momentP μ/(θ*m) = (if scheme = 0 then (1-h^2*Ω^2/(4*m))⁻¹
      else if scheme = 2 then 1-h^2*Ω^2/(4*m) else 1) ∧ momentQP μ = 0 := by
  sorry''',label='Table 7.1',
extra=['表7.1是由矩方程推导的精确数学公式，保留为待证；与数值实验观测表区分。','4个算法均使用本章完整定义、独立标准正态乘积与实际平稳推前；不把所需矩值写成假设。','只陈述已存在平稳概率的矩；长期收敛和遍历解释另列缺口。'],
missing='四种真实分裂映射的Gaussian矩输运与线性方程求解；不建立一般离散遍历理论。')
add('NonsymmetricExactMoments','7.4.1',277,
r'''For example, analysis shows that the schemes denoted $[AOAB]$ or $[BAOA]$ both exhibit a first order error in the covariance $\langle qp\rangle_h=O(h)$, however they give exact results for both $\langle q^2\rangle_h$ and $\langle p^2\rangle_h$.''',
'''def nonsymmetricHarmonicStep (flip : Bool) (m Ω γ θ h R : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let masses : V 1 := fun _ ↦ m
  let U : V 1 → ℝ := fun q ↦ Ω^2*(q 0)^2/2
  scalarLift (if flip then kickStep U h ∘ driftStep masses (h/2) ∘ ouStep masses γ θ h (fun _ ↦ R) ∘ driftStep masses (h/2)
    else driftStep masses (h/2) ∘ ouStep masses γ θ h (fun _ ↦ R) ∘ driftStep masses (h/2) ∘ kickStep U h)

theorem nonsymmetricExactMoments (flip : Bool) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m) (hμ : IsProbabilityMeasure μ)
    (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hinv : Measure.map (fun z ↦ nonsymmetricHarmonicStep flip m Ω γ θ h z.2 z.1)
      (μ.prod (gaussianReal 0 1)) = μ) :
    momentQ μ = θ/Ω^2 ∧ momentP μ = θ*m := by
  sorry''',extra=['AOAB和BAOA按字母总时间h定义；实际平稳概率、L²、稳定参数显式。','本条仅覆盖两个精确方差；O(h)协方差及其随h统一常数未陈述，列入覆盖缺口。'],
scope='两个非对称算法精确位置/动量二阶矩；协方差阶数暂缺。',missing='需要真实平稳矩输运及代数求解；不建立通用弱误差理论。')
