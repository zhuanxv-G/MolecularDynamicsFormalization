from ch07_data import add

add('ConfigurationalSampling','7.1',262,
r'''we often only wish to know the average of a given function $\phi(q)$ with respect the configurational density $\exp(-\beta U(q))$, where $U$ is the potential energy function of a molecular system.''',
'''def configurationalSamplingAverage (U φ : V n → ℝ) (β : ℝ) : ℝ :=
  ∫ q, φ q ∂positionGibbs U β

def configurationalSamplingQualified (U φ : V n → ℝ) (β : ℝ) : Prop :=
  0 < β ∧ IsProbabilityMeasure (positionGibbs U β) ∧ Integrable φ (positionGibbs U β)''',
kind='definition',extra=['原文省略归一常数；positionGibbs定义体保留实际配分积分。可积性与概率归一资格单列，不把未归一指数直接视为概率密度。'])

add('HamiltonianSamplingObstruction','7.1',262,
r'''Note that deterministic methods (e.g. Hamiltonian dynamics itself) can sometimes be used for molecular sampling, but without stochastic perturbation, such methods are not rigorously ergodic, since the Liouvillian operator does not possess a spectral gap and does not provide a unique stationary solution.''',
'''def energyConservingFlow (H : Phase n → ℝ) (F : ℝ → Phase n → Phase n) : Prop :=
  (∀ x, F 0 x = x) ∧ (∀ s t x, F (s+t) x = F s (F t x)) ∧ ∀ t x, H (F t x) = H x

theorem energySublevel_invariant (H : Phase n → ℝ) (F : ℝ → Phase n → Phase n)
    (hf : energyConservingFlow H F) (a t : ℝ) :
    (F t) ⁻¹' {x | H x ≤ a} = {x | H x ≤ a} := by
  ext x
  change H (F t x) ≤ a ↔ H x ≤ a
  rw [hf.2.2 t x]

def energyObstructionQualified (μ : Measure (Phase n)) (H : Phase n → ℝ)
    (F : ℝ → Phase n → Phase n) : Prop :=
  IsProbabilityMeasure μ ∧ energyConservingFlow H F ∧
    (∀ t, MeasurePreserving (F t) μ μ) ∧
    ∃ a, MeasurableSet {x | H x ≤ a} ∧ 0 < μ {x | H x ≤ a} ∧ μ {x | H x ≤ a} < 1''',
extra=['本条只证明保能流的能量子水平集不变；结合非平凡概率质量可形成遍历性障碍。能量壳上的遍历性不能由原句否定。',
       '原句未指定Liouvillian定义域、函数空间与参考概率。谱隙缺失和多个平稳解的完整算子陈述列为覆盖缺口，不把子水平集恒等式标作整段谱理论的证明。'],
scope='保能流、非平凡不变集资格及不变集恒等式；原文的谱隙与平稳解主张仅逐字登记，尚缺明确函数空间后的完整陈述。',verdict='NEEDS_HUMAN')
