"""Actual torus-cylinder model, stationary density and whole-kernel invariance."""
from ch06_data import add,proposition,D,NS,copied
add('CylinderCoordinates','6.4.2',247,[83],r'''Now consider an SDE system defined on the space $D=\mathbb T^{k_1}\times\mathbb R^{k_2}$ for non-negative integers $k_1$ and $k_2$.''',
'''def cylinderCoordinates {k₁ k₂ : ℕ} (z : Fin (k₁+k₂) → ℝ) :
    (Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ) :=
  (fun i ↦ (z ⟨i.val, by omega⟩ : AddCircle (1 : ℝ)), fun j ↦ z ⟨k₁+j.val, by omega⟩)''',kind='extra_claim',extra=['[EXTRA]实际圆环商坐标与Euclidean非紧坐标；局部微分表达通过周期lift解释，不偷换D为纯ℝⁿ。'])
add('CylinderSDE','6.4.2',247,[83],r'''Now consider an SDE system defined on the space $D=\mathbb T^{k_1}\times\mathbb R^{k_2}$ for non-negative integers $k_1$ and $k_2$:
\[dX=b_0(X)dt+\sum_{i=1}^r b_i dW_i;\tag{6.43}\]
where $b_0$ is $C^\infty$ and the $W_i$ are independent standard Wiener processes. In this book, we will only consider the analysis for the case of additive noise (i.e. the $b_i$ vectors multiplying a Wiener process are constant).''',
'''def cylinderSDE {Ω : Type*} [MeasurableSpace Ω] {k₁ k₂ r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ))
    (X : ℝ → Ω → ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)))
    (b₀ : ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)) → (Fin (k₁+k₂) → ℝ))
    (B : Matrix (Fin (k₁+k₂)) (Fin r) ℝ) (x0 : Fin (k₁+k₂) → ℝ) : Prop :=
  ContDiff ℝ ∞ (fun z ↦ b₀ (cylinderCoordinates z)) ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  ∃ lift : ℝ → Ω → (Fin (k₁+k₂) → ℝ),
    strictVectorSDE P W lift (fun z _ ↦ b₀ (cylinderCoordinates z)) (fun _ _ ↦ B) x0 ∧
    (∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t → X t sample=cylinderCoordinates (lift t sample))''',kind='definition',label='(6.43)',extra=['[EXTRA]真实D及其周期lift、原C∞漂移、常矩形B和全部严格Ito积分；仅方程意义，不预置遍历/不变结论。'])
add('CylinderGenerator','6.4.2',247,[83],r'''Working in flat $L^2$ space, we have that the infinitesmal generator for (6.43) acting on a smooth test function $\phi(X)$ is
\[\mathcal L\phi=b_0\cdot\nabla\phi+\tfrac12\operatorname{Tr}(B^T\phi''B);\]''',
'''def cylinderGenerator {k₁ k₂ r : ℕ}
    (b₀ : ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)) → (Fin (k₁+k₂) → ℝ))
    (B : Matrix (Fin (k₁+k₂)) (Fin r) ℝ)
    (φ : ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)) → ℝ) (z : Fin (k₁+k₂) → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorGenerator (fun y ↦ b₀ (cylinderCoordinates y)) B
    (fun y ↦ φ (cylinderCoordinates y)) z''',kind='definition',context=['D上标量检验的真实周期lift表达；非紧方向真实导数，不断言任意不光滑输入仍是经典generator域。'])
add('CylinderForwardPrinted','6.4.2',247,[83],r'''Taking the adjoint, the forward Kolmogorov or Fokker-Planck operator is $\mathcal L^*$, acting on a density $\rho(X)$ as
\[\mathcal L^*\rho=-\nabla\cdot(b_0\rho)+\tfrac12\operatorname{Tr}(B^T\phi''B).\]''',
'''def cylinderForwardPrinted {n r : ℕ} (b₀ : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ φ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  -(∑ i, fderiv ℝ (fun z ↦ b₀ z i*ρ z) x (Pi.single i 1)) +
    MolecularDynamics.Chapter06Review.vectorDiffusion B φ x''',kind='definition',verdict='NEEDS_HUMAN',issues=['印刷forward密度算子仍写φ″，应ρ″；本条保留两个不同对象的字面表达，不宣称其是密度演化算子。'],extra=['[EXTRA]周期lift中的完整实际负散度与错误φ扩散，正确ρ算子已有VectorForward定义。'],missing='网站/导师待裁定印刷φ/ρ笔误。')
add('StationaryDensity','6.4.2',247,[84],r'''We have a stationary distribution if $\mathcal L^*\rho=0$.''',
'''def stationaryDensity {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) : Prop :=
  ∀ x, MolecularDynamics.Chapter06Review.vectorForward a B ρ x=0''',kind='definition',context=['仅实际形式stationarity；非负、归一化、generator域及真实kernel演化另给，不能由定义计测度不变性已证。'])
stationary=proposition('stationaryInvariant_statement','stationaryInvariant')
stationary=stationary.replace('markovSemigroup K → IsProbabilityMeasure μ →','markovSemigroup K → IsProbabilityMeasure μ →')
anchor=NS+'markovSemigroup K → IsProbabilityMeasure μ →'
assert anchor in stationary
stationary=stationary.replace(anchor,anchor+'''
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) → ∀ T : ℝ, 0 ≤ T →
    ∃ bound : D → ℝ, Integrable bound μ ∧ ∀ s ∈ Icc 0 T, ∀ x,
      |L (fun y ↦ MolecularDynamics.Chapter06Review.kernelAverage K f s.toNNReal y) x| ≤ bound x) →''',1)
add('StationaryInvariant','6.4.2',247,[84],r'''This is completely analogous to the deterministiccase in which stationary distributions were defined by $\mathcal L^*\rho=0$ where $\mathcal L^*$ refers to the Liouvillian. Any stationary solution is also referred to as an invariant probability distribution, or invariant probability measure for the system. The condition $\mathcal L^*\rho=0$ implies the property that the distribution is unchanged in time, $\exp(t\mathcal L^*)\rho=\rho$.''',stationary,extra=['[EXTRA]实际Markov kernel semigroup、真实generator对演化检验的导数关系与弱stationarity，并明确局部可积支配保证求导换积分；完整kernel测度不变，未假设不变结论或把形式exp当实际流。'],missing='缺抽象generator域与求导换积分/测度分离的完整短桥；不建一般半群理论。')
add('CanonicalMixingMeaning','6.4',244,[85],r'''At any time $t$ we take a snapshot $M_t$ of the resulting set of random variables. Eventually we hope that the points will be distributed in the entire phase space in accordance with the target measure (usually the Gibbs distribution $e^{-\beta H}$).''',
'''def canonicalMixingMeaning {D : Type*} [TopologicalSpace D] [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) : Prop :=
  IsProbabilityMeasure μ ∧ ∀ x : D, ∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ z, f z ∂K t.toNNReal x) atTop (𝓝 (∫ z, f z ∂μ))''',kind='definition',extra=['[EXTRA]真实概率目标和任意点初始law、全部有界连续检验函数弱混合定义；没有宣称所有SDE自动满足。'])
mixing=proposition('canonicalMixing_statement','langevinCanonicalMixing')
anchor='0 < γ → ∀ x : textbookLangevinPeriodicPhase n,'
assert anchor in mixing
mixing=mixing.replace(anchor,'''0 < γ →
  (∀ t : ℝ≥0, 0 < t → ∃ density : textbookLangevinPeriodicPhase n × textbookLangevinPeriodicPhase n → ℝ,
    Continuous density ∧ (∀ x y, 0 < density (x,y)) ∧
    ∀ x, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
      (Real.sqrt (2*γ*β⁻¹)) t x =
        (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun y ↦ ENNReal.ofReal (density (x,y)))) ∧
  ∀ x : textbookLangevinPeriodicPhase n,''',1)
add('LangevinCanonicalMixing','6.4.2',248,[85],r'''Even a single phase space point, which corresponds to a delta-function initial distribution, will instantly diffuse as the solution of the Fokker-Planck equation and, eventually, would cover the entire phase space.''',mixing,extra=['[EXTRA]真实现有周期单位质量Langevin kernel、正γ/β、原光滑力全局Lipschitz；完整任意点初值的正时刻严格正连续转移密度以及全部有界连续检验弱混合，原一般混合意义另条，不以单位质量特例替代一般定义。'],missing='缺完整原Langevin正密度/Harris/kernel混合验收桥接；不恢复封存的Theorem6.2长证明。')
