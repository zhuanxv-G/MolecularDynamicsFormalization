import MolecularDynamics.Chapter06.Statements
import MolecularDynamics.Chapter02.ReviewProofs
import MolecularDynamics.Chapter02.EulerConvergence
import MolecularDynamics.Chapter02.ActualFlowVariations
import MolecularDynamics.Chapter02.LiouvilleVolume
import MolecularDynamics.Chapter02.HamiltonianVolume
import MolecularDynamics.Chapter01.Lagrangian
import MolecularDynamics.Chapter06.WienerStratonovich
import MolecularDynamics.Chapter06.WienerDeterministicLaw
import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Analysis.Calculus.Deriv.Shift
import Mathlib.Analysis.Calculus.Taylor
import Mathlib.Tactic

open Set Filter Matrix MeasureTheory ProbabilityTheory MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter06Review
open scoped BigOperators Topology ContDiff InnerProductSpace Matrix.Norms.L2Operator ENNReal NNReal
noncomputable section
namespace MD.Ch06
variable {n Nc : ℕ}
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {R : Type*} [Ring R] [Algebra ℝ R]

/-- source_id: MD-6.1.1-Microcanonical · definition · §6.1.1 · 印刷p.214 / PDFp.235 -/
def microcanonical {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (energy : ℝ) :=
  MolecularDynamics.Chapter05Review.microMeasure H energy

/-- source_id: MD-6.1.2-Entropy · (6.1) · §6.1.2 · 印刷p.214 / PDFp.235 -/
def entropy (kB : ℝ) (Z : ℝ → ℝ) (E : ℝ) : ℝ := kB * Real.log (Z E)

/-- source_id: MD-6.1.2-IndependentPartition · unnumbered_claim · §6.1.2 · 印刷p.215 / PDFp.236
[EXTRA] [EXTRA]独立、分别固定能量的真实加权能量面测度乘积；不将固定总能量partition的卷积偷换为乘积。 -/
theorem independentPartition :
  ∀ {n m : ℕ} (HA : Chapter05Review.E n → ℝ)
    (HB : Chapter05Review.E m → ℝ) (EA EB : ℝ),
  Chapter05Review.regularEnergy HA EA → Chapter05Review.regularEnergy HB EB →
  let μA := Chapter05Review.microRaw HA EA
  let μB := Chapter05Review.microRaw HB EB
  (μA.prod μB) univ = μA univ * μB univ := by
  intro n m HA HB EA EB hA hB
  letI : IsFiniteMeasure (MolecularDynamics.Chapter05Review.microRaw HA EA) := ⟨hA.2.2.2.2⟩
  letI : IsFiniteMeasure (MolecularDynamics.Chapter05Review.microRaw HB EB) := ⟨hB.2.2.2.2⟩
  dsimp
  simpa only [univ_prod_univ] using (Measure.prod_prod
    (μ := MolecularDynamics.Chapter05Review.microRaw HA EA)
    (ν := MolecularDynamics.Chapter05Review.microRaw HB EB) univ univ)

/-- source_id: MD-6.1.2-EntropyAdditivity · unnumbered_claim · §6.1.2 · 印刷p.215 / PDFp.236
[EXTRA] [EXTRA]两个正实数partition；结论同时保留乘kB的熵加法，kB=1包含所印log式。 -/
theorem entropyAdditivity :
  ∀ (kB ZA ZB : ℝ), 0 < ZA → 0 < ZB →
  kB*Real.log (ZA*ZB) = kB*Real.log ZA+kB*Real.log ZB := by
  intro kB ZA ZB hA hB
  rw [Real.log_mul hA.ne' hB.ne']
  ring

/-- source_id: MD-6.1.2-EntropyEquilibrium · unnumbered_claim · §6.1.2 · 印刷p.215 / PDFp.236
[EXTRA] [EXTRA]固定总能量；两个熵函数在相应能量可微，内点局部最大为前提；实际导数相等为结论，不假设平衡导数关系。 -/
theorem entropyEquilibrium :
  ∀ (SA SB : ℝ → ℝ) (E e : ℝ),
  DifferentiableAt ℝ SA e → DifferentiableAt ℝ SB (E-e) →
  IsLocalMax (fun x ↦ SA x+SB (E-x)) e → deriv SA e = deriv SB (E-e) := by
  intro SA SB energy e hSA hSB hmax
  have hd := hSA.hasDerivAt.add (hSB.hasDerivAt.comp_const_sub energy e)
  have hz := hmax.hasDerivAt_eq_zero hd
  linarith

/-- source_id: MD-6.1.2-Temperature · definition · §6.1.2 · 印刷p.215 / PDFp.236 -/
def temperature (S : ℝ → ℝ) (E : ℝ) : ℝ := (MolecularDynamics.Chapter06Review.inverseTemperature S E)⁻¹

/-- source_id: MD-6.1.2-InverseThermal · (6.2) · §6.1.2 · 印刷p.216 / PDFp.237 -/
def inverseThermal (kB T : ℝ) : ℝ := (kB * T)⁻¹

/-- source_id: MD-6.1.2-BathTaylor · unnumbered_claim · §6.1.2 · 印刷p.216 / PDFp.237
[EXTRA] [EXTRA]熵C²、正热浴能量及kB；β以原页固定温度关系表示，不假设所需中间点导数恒定。
[ERRATUM?] [ERRATUM?]原书脚注3承认热浴推导不精确；S′(ξ)=1/T通常只能作为大热浴近似，完整精确Boltzmann因子保留字面NEEDS_HUMAN。 -/
theorem bathBoltzmannPrinted : ∀ (S : ℝ → ℝ) (energy kB β : ℝ),
  ContDiff ℝ 2 S → 0 < energy → 0 < kB → deriv S energy = kB * β →
  (∀ s : ℝ, 0 < s → ∃ ξ ∈ Icc (energy-s) energy,
    S (energy-s) = S energy - deriv S ξ * s) ∧
  (∀ s ∈ Icc (0 : ℝ) energy,
    Real.exp (S (energy-s)/kB) / Real.exp (S energy/kB) = Real.exp (-β*s)) := by
  sorry

theorem bathBoltzmannPrinted_counterexample : Real.exp ((0 : ℝ)^2-1^2) ≠ Real.exp (-2) := by
  intro h
  have hn := Real.exp_injective h
  norm_num at hn

/-- source_id: MD-6.1.2-LogTemperature · unnumbered_claim · §6.1.2 · 印刷p.215–216 / PDFp.236–237
[EXTRA] [EXTRA]partition在该能量可微且正；本条保留温度与log partition的实际微分关系，系统之间平衡关系由EntropyEquilibrium保留。 -/
theorem logTemperature : ∀ (kB : ℝ) (Z : ℝ → ℝ) (energy : ℝ),
  DifferentiableAt ℝ Z energy → 0 < Z energy →
  deriv (fun e ↦ Real.log (Z e)) energy = deriv Z energy / Z energy ∧
  MolecularDynamics.Chapter06Review.inverseTemperature
    (MolecularDynamics.Chapter06Review.entropy kB Z) energy = kB * deriv Z energy / Z energy := by
  intro kB Z energy hZ hpos
  have hd := hZ.hasDerivAt.log hpos.ne'
  constructor
  · exact hd.deriv
  · unfold MolecularDynamics.Chapter06Review.inverseTemperature
      MolecularDynamics.Chapter06Review.entropy
    rw [deriv_const_mul kB hd.differentiableAt, hd.deriv]
    ring

/-- source_id: MD-6.1.2-BathMeanValue · unnumbered_claim · §6.1.2 · 印刷p.216 / PDFp.237
[EXTRA] [EXTRA]C¹熵且s>0；只保留真实均值定理，不把ξ处导数改为E处导数。 -/
theorem bathMeanValue : ∀ (S : ℝ → ℝ) (energy s : ℝ),
  ContDiff ℝ 1 S → 0 < s → ∃ ξ ∈ Ioo (energy-s) energy,
    S (energy-s) = S energy - deriv S ξ * s := by
  intro S energy s hS hs
  have hlt : energy-s < energy := by linarith
  obtain ⟨ξ, hξ, hd⟩ := exists_deriv_eq_slope S hlt hS.continuous.continuousOn
    (hS.differentiable (by norm_num)).differentiableOn
  refine ⟨ξ, hξ, ?_⟩
  have hn : energy-(energy-s) ≠ 0 := by linarith
  have he := (eq_div_iff hn).mp hd
  nlinarith

/-- source_id: MD-6.1.2-BathTaylorEstimate · extra_claim · §6.1.2 · 印刷p.216 / PDFp.237
[EXTRA] [EXTRA]对原页热浴近似给出可核验的局部C²一阶展开及C·s²余项；这是额外严格表述，完整字面Boltzmann关系仍为NEEDS_HUMAN。 -/
theorem bathTaylorEstimate :
  ∀ (S : ℝ → ℝ) (E : ℝ), ContDiff ℝ 2 S →
  ∃ C δ : ℝ, 0 ≤ C ∧ 0 < δ ∧ ∀ e, |e| < δ →
    |S (E-e)-S E+deriv S E*e| ≤ C*e^2 := by
  sorry

/-- source_id: MD-6.1.2-BoltzmannConstantSlope · extra_claim · §6.1.2 · 印刷p.216 / PDFp.237
[EXTRA] [EXTRA]理想恒温热浴明确要求熵导数在整个实轴恒定；不从固定能量的温度偷推出该条件，不将本条代替字面版。 -/
theorem boltzmannConstantSlope : ∀ (S : ℝ → ℝ) (energy kB β : ℝ),
  Differentiable ℝ S → 0 < kB → (∀ e, deriv S e = kB * β) →
  ∀ s, Real.exp (S (energy-s)/kB) / Real.exp (S energy/kB) = Real.exp (-β*s) := by
  intro S energy kB β hS hkB hder s
  have hm : ∀ a b : ℝ, a < b → S b-S a = kB*β*(b-a) := by
    intro a b hab
    obtain ⟨ξ, hξ, hd⟩ := exists_deriv_eq_slope S hab hS.continuous.continuousOn hS.differentiableOn
    have hn : b-a ≠ 0 := by linarith
    rw [hder ξ] at hd
    exact ((eq_div_iff hn).mp hd).symm
  have he : S (energy-s)-S energy = -kB*β*s := by
    rcases lt_trichotomy s 0 with hs | rfl | hs
    · have hh := hm energy (energy-s) (by linarith)
      nlinarith
    · simp
    · have hh := hm (energy-s) energy (by linarith)
      nlinarith
  have hd : (S (energy-s)-S energy)/kB = -β*s := by
    apply (div_eq_iff hkB.ne').mpr
    nlinarith [he]
  rw [← Real.exp_sub, ← sub_div, hd]

/-- 修正版，对应原文 MD-6.1.2-BathTaylor；改动：精确Boltzmann因子增加整个能量区间的恒定熵斜率；一般热浴只保留带余项近似。 -/
theorem bathBoltzmannPrinted_corrected : ∀ (S : ℝ → ℝ) (energy kB β : ℝ),
  Differentiable ℝ S → 0 < kB → (∀ e, deriv S e = kB * β) →
  ∀ s, Real.exp (S (energy-s)/kB) / Real.exp (S energy/kB) = Real.exp (-β*s) := by
  intro S energy kB β hS hkB hder s
  have hm : ∀ a b : ℝ, a < b → S b-S a = kB*β*(b-a) := by
    intro a b hab
    obtain ⟨ξ, hξ, hd⟩ := exists_deriv_eq_slope S hab hS.continuous.continuousOn hS.differentiableOn
    have hn : b-a ≠ 0 := by linarith
    rw [hder ξ] at hd
    exact ((eq_div_iff hn).mp hd).symm
  have he : S (energy-s)-S energy = -kB*β*s := by
    rcases lt_trichotomy s 0 with hs | rfl | hs
    · have hh := hm energy (energy-s) (by linarith)
      nlinarith
    · simp
    · have hh := hm (energy-s) energy (by linarith)
      nlinarith
  have hd : (S (energy-s)-S energy)/kB = -β*s := by
    apply (div_eq_iff hkB.ne').mpr
    nlinarith [he]
  rw [← Real.exp_sub, ← sub_div, hd]

/-- source_id: MD-6.1.2-CanonicalCDFPrinted · unnumbered_claim · §6.1.2 · 印刷p.216 / PDFp.237
[ERRATUM?] [ERRATUM?]页末能量密度含ZA(α)，此前CDF却省略ZA(s)权重；一般ZA下两归一化CDF不相等。 -/
theorem canonicalCDFPrinted : ∀ (ZA ZB : ℝ → ℝ) (energy α : ℝ),
  Continuous ZA → Continuous ZB → (∀ e, 0 < ZA e) → (∀ e, 0 < ZB e) →
  0 < α → α < energy →
  (∫ s in 0..α, ZA s * ZB (energy-s)) / (∫ s in 0..energy, ZA s * ZB (energy-s)) =
  (∫ s in 0..α, ZB (energy-s)) / (∫ s in 0..energy, ZB (energy-s)) := by
  sorry

/-- 修正版，对应原文 MD-6.1.2-CanonicalCDFPrinted；改动：能量累计概率的分子分母均保留ZA(s)权重；改为正确累计概率的定义。 -/
def canonicalCDFPrinted_corrected (ZA ZB : ℝ → ℝ) (energy α : ℝ) : ℝ :=
  (∫ s in 0..α, ZA s*ZB (energy-s))/(∫ s in 0..energy, ZA s*ZB (energy-s))

/-- source_id: MD-6.1.2-CanonicalEnergyDensity · definition · §6.1.2 · 印刷p.216 / PDFp.237 -/
def canonicalEnergyDensity (Z : ℝ → ℝ) (β E : ℝ) : ℝ :=
  Z E * Real.exp (-β * E) / (∫ e, Z e * Real.exp (-β * e))

/-- source_id: MD-6.1.3-EntropyFunctional · definition · §6.1.3 · 印刷p.217 / PDFp.238 -/
def entropyFunctional {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (kB : ℝ) (ρ : D → ℝ) : ℝ := -kB * ∫ x, ρ x * Real.log (ρ x) ∂ν

/-- source_id: MD-6.1.3-ConstrainedEntropyModel · definition · §6.1.3 · 印刷p.217 / PDFp.238 -/
def constrainedEntropyModel {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H ρ : D → ℝ) (kB lambdaParam β meanEnergy : ℝ) : ℝ × Prop :=
  (MolecularDynamics.Chapter06Review.entropyFunctional ν kB ρ / kB -
    lambdaParam * ((∫ x, ρ x ∂ν)-1) - β * ((∫ x, H x * ρ x ∂ν)-meanEnergy),
    (∫ x, ρ x ∂ν) = 1 ∧ (∫ x, H x * ρ x ∂ν) = meanEnergy)

/-- source_id: MD-6.1.3-EntropyFirstVariation · extra_claim · §6.1.3 · 印刷p.217–218 / PDFp.238–239
[EXTRA] [EXTRA]实际正连续密度、可积熵/能量及光滑紧支变分；保存对V的实际HasDerivAt积分表达式，不把Euler–Lagrange结论作前提。
[EXTRA] [EXTRA]省略与ρ无关的λ+βĒ常数不影响本条导数；完整含常数V另见ConstrainedEntropyModel。 -/
theorem entropyFirstVariation :
  ∀ {n : ℕ} (H ρ : MolecularDynamics.Chapter06Review.V n → ℝ) (lambdaParam β : ℝ),
  Continuous H → Continuous ρ → (∀ x, 0 < ρ x) →
  Integrable ρ → Integrable (fun x ↦ ρ x*Real.log (ρ x)) → Integrable (fun x ↦ H x*ρ x) →
  ∀ ψ : MolecularDynamics.Chapter06Review.V n → ℝ, ContDiff ℝ ∞ ψ → HasCompactSupport ψ →
    HasDerivAt (fun e ↦ MolecularDynamics.Chapter06Review.entropyLagrangian H (fun x ↦ ρ x+e*ψ x) lambdaParam β)
      (∫ x, (-(1+Real.log (ρ x))-lambdaParam-β*H x)*ψ x) 0 := by
  sorry

/-- source_id: MD-6.1.3-EntropyVariation · unnumbered_claim · §6.1.3 · 印刷p.217–218 / PDFp.238–239
[EXTRA] [EXTRA]在每个光滑紧支实际密度方向的内点局部极值、正连续可积密度；不假设变分导数零或点态EL结论。 -/
theorem entropyVariation :
  ∀ {n : ℕ} (H ρ : MolecularDynamics.Chapter06Review.V n → ℝ) (lambdaParam β : ℝ),
  Continuous H → Continuous ρ → (∀ x, 0 < ρ x) →
  Integrable ρ → Integrable (fun x ↦ ρ x*Real.log (ρ x)) → Integrable (fun x ↦ H x*ρ x) →
  (∀ ψ : MolecularDynamics.Chapter06Review.V n → ℝ, ContDiff ℝ ∞ ψ → HasCompactSupport ψ →
    IsLocalMax (fun e ↦ MolecularDynamics.Chapter06Review.entropyLagrangian H (fun x ↦ ρ x+e*ψ x) lambdaParam β) 0) →
  ∀ x, -(1+Real.log (ρ x))-lambdaParam-β*H x=0 ∧
    ρ x=Real.exp (-1-lambdaParam)*Real.exp (-β*H x) := by
  sorry

/-- source_id: MD-6.1.3-CanonicalDensity · (6.3) · §6.1.3 · 印刷p.218 / PDFp.239 -/
def canonicalDensity {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ) (x : D) : ℝ := Real.exp (-β * H x) / (∫ z, Real.exp (-β * H z) ∂ν)

/-- source_id: MD-6.1.3-MassHamiltonian · definition · §6.1.3 · 印刷p.218 / PDFp.239 -/
def massHamiltonian {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (x : MolecularDynamics.Chapter06Review.Phase n) : ℝ :=
  (∑ i, (x.2 i) ^ 2 / (2 * m i)) + U x.1

/-- source_id: MD-6.1.3-PartitionMass · unnumbered_claim · §6.1.3 · 印刷p.218 / PDFp.239
[EXTRA] [EXTRA]此条取Q=全配置实空间；正β、任意正对角质量和配置权重可积；一般Q用下一条独立保存。 -/
theorem partitionMass :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) →
  (∫ x : MolecularDynamics.Chapter06Review.Phase n, Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)) =
    (∫ q, Real.exp (-β*U q)) * ∏ i, Real.sqrt (2*Real.pi*m i/β) := by
  sorry

/-- source_id: MD-6.1.3-PartitionDomain · unnumbered_claim · §6.1.3 · 印刷p.218 / PDFp.239
[EXTRA] [EXTRA]配置测度μ为sigma-finite，原Q对应μ=volume.restrict Q；真实乘积测度及一般正质量，不将有限域换为torus。 -/
theorem partitionDomain : ∀ {n : ℕ}
    (μ : Measure (MolecularDynamics.Chapter06Review.V n)) [SigmaFinite μ]
    (m : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) μ →
  (∫ x : MolecularDynamics.Chapter06Review.Phase n,
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)
    ∂μ.prod (volume : Measure (MolecularDynamics.Chapter06Review.V n))) =
  (∫ q, Real.exp (-β*U q) ∂μ) * ∏ i, Real.sqrt (2*Real.pi*m i/β) := by
  sorry

/-- source_id: MD-6.1.3-FiniteDomainPrinted · unnumbered_claim · §6.1.3 · 印刷p.218 / PDFp.239
[ERRATUM?] [ERRATUM?]仅有限体积、Q内部光滑不足以排除趋向边界的U→−∞；需要下界、紧域上的连续性或权重可积性。 -/
theorem finiteDomainPrinted : ∀ {n : ℕ} (Q : Set (MolecularDynamics.Chapter06Review.V n))
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  MeasurableSet Q → (volume : Measure (MolecularDynamics.Chapter06Review.V n)) Q < ⊤ →
  ContDiffOn ℝ ∞ U Q → 0 < β → IntegrableOn (fun q ↦ Real.exp (-β*U q)) Q := by
  sorry

/-- 修正版，对应原文 MD-6.1.3-FiniteDomainPrinted；改动：将有限体积域内光滑改为紧域上连续，使用紧性保证权重可积。 -/
theorem finiteDomainPrinted_corrected {n : ℕ} (Q : Set (Fin n → ℝ))
    (U : (Fin n → ℝ) → ℝ) (β : ℝ) (hQ : IsCompact Q) (hU : ContinuousOn U Q) :
    IntegrableOn (fun q ↦ Real.exp (-β*U q)) Q := by
  exact (Real.continuous_exp.comp_continuousOn (hU.const_mul (-β))).integrableOn_compact hQ

/-- source_id: MD-6.1.3-PeriodicPartitionBridge · extra_claim · §6.1.3 · 印刷p.218 / PDFp.239
[EXTRA] [EXTRA]仅独立特例：单位质量、单位周期torus、实际Haar配置测度与光滑周期U；完整一般质量/Q的两条义务仍保留，不将特例计为完整原结论已证。 -/
theorem periodicPartitionBridge {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    textbookLangevinCanonicalPartition U β =
      textbookConfigurationPartition U β * (Real.sqrt (2 * Real.pi * β⁻¹)) ^ N := by
  apply MolecularDynamics.textbookLangevinCanonicalPartition_formula <;> assumption

/-- source_id: MD-6.1.3-ConfiningPartition · unnumbered_claim · §6.1.3 · 印刷p.218–220 / PDFp.239–241
[EXTRA] [EXTRA]无奇点的连续全空间充分条件：U(q)≥c‖q‖ᵖ−C，其中c,p,β>0；把“足够快”明确量化，不将任意增长都视为足够。 -/
theorem confiningPartition :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β c p C : ℝ),
  Continuous U → 0 < β → 0 < c → 0 < p →
  (∀ q, c*Real.rpow ‖q‖ p-C ≤ U q) → Integrable (fun q ↦ Real.exp (-β*U q)) := by
  sorry

/-- source_id: MD-6.1.3-LennardJonesNonintegrable · unnumbered_claim · §6.1.3 · 印刷p.219 / PDFp.240
[EXTRA] [EXTRA]精确取原一自由度例子的q>0配置权重；动量Gaussian有限因子不会修复配置尾部发散。 -/
theorem lennardJonesNonintegrable : ∀ β : ℝ, 0 < β →
  ¬ IntegrableOn (fun q : ℝ ↦ Real.exp (-β*(q⁻¹^12-q⁻¹^6))) (Ioi 0) := by
  sorry

/-- source_id: MD-6.1.3-LennardJonesConfinement · unnumbered_claim · §6.1.3 · 印刷p.219 / PDFp.240
[EXTRA] [EXTRA]ε>0；保存完整势能公式，并给出足以控制无穷尾部的二次下界；q=0处总逆元记号不替代原q>0模型，不计奇点积分已证。 -/
theorem lennardJonesConfinement : ∀ ε : ℝ, 0 < ε → ∃ C : ℝ,
  ∀ q : ℝ, ε*q^2- C ≤ q⁻¹^12-q⁻¹^6+ε*q^2 := by
  intro ε hε
  refine ⟨1/4, ?_⟩
  intro q
  have hsq := sq_nonneg (q⁻¹^6 - 1/2)
  have heq : q⁻¹^12 = (q⁻¹^6)^2 := by ring
  rw [heq]
  nlinarith

/-- source_id: MD-6.1.3-PeriodicWeightIntegrable · extra_claim · §6.1.3 · 印刷p.218 / PDFp.239
[EXTRA] [EXTRA]独立单位质量/单位torus、光滑周期U特例；配置Haar×动量Lebesgue采用正式flatPhaseMeasure的实际定义，避免隐式不同测度。 -/
theorem periodicWeightIntegrable {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    Integrable (textbookLangevinPeriodicGibbsWeight U β)
      (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) := by
  exact MolecularDynamics.textbookLangevinPeriodicGibbsWeight_integrable U hU hp β hβ

/-- source_id: MD-6.1.3-PeriodicPartitionPositive · extra_claim · §6.1.3 · 印刷p.218 / PDFp.239
[EXTRA] [EXTRA]正式库现成真实周期、单位质量、正β特例；正finite partition由已证可积性和严格正权重推出，未假设所需归一化结论。 -/
theorem periodicPartitionPositive {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) : 0 < textbookLangevinCanonicalPartition U β := by
  apply MolecularDynamics.textbookLangevinCanonicalPartition_pos <;> assumption

/-- source_id: MD-6.1.4-PolynomialObservable · definition · §6.1.4 · 印刷p.220 / PDFp.241
[EXTRA] [EXTRA]q在实际紧torus上；用一致C(1+‖p‖)^r、C≥0及自然数r表达至多多项式增长，实α可取更大整数；不证明每个可观测量自动满足增长界。 -/
def polynomialObservable {n : ℕ} (f : textbookLangevinPeriodicPhase n → ℝ) : Prop :=
  ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |f x| ≤ C * (1 + ‖x.2‖) ^ r

/-- source_id: MD-6.1.4-CanonicalAveragePrinted · (6.4) · §6.1.4 · 印刷p.220 / PDFp.241
[ERRATUM?] [ERRATUM?]式(6.3)的ρβ已含Zcan⁻¹，式(6.4)再乘一次导致Avβ(1)=Zcan⁻¹，而后文p.221使用标准归一化平均。 -/
def canonicalAveragePrinted {Nc : ℕ} (H : SymplecticCoordinates Nc → ℝ) (β : ℝ)
    (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ *
    ∫ z, f z * MolecularDynamics.Chapter06Review.canonicalDensity volume H β z

/-- source_id: MD-6.1.4-CanonicalAverage · definition · §6.1.4 · 印刷p.220–221 / PDFp.241–242
[EXTRA] [EXTRA][ERRATUM?]按p.221的实际用法与概率平均标准定义去掉式(6.4)对已归一ρ的第二次Z⁻¹；原字面版仍保留NEEDS_HUMAN。 -/
noncomputable def canonicalAverage {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ * ∫ z, f z * textbookHamiltonianGibbsWeight H β z

/-- 修正版，对应原文 MD-6.1.4-CanonicalAveragePrinted；改动：去掉对已经归一化ρβ的第二次Zcan⁻¹；沿用未归一权重乘一次Zcan⁻¹的定义。 -/
noncomputable def canonicalAveragePrinted_corrected {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ * ∫ z, f z * textbookHamiltonianGibbsWeight H β z

/-- source_id: MD-6.1.4-CanonicalAverageOne · extra_claim · §6.1.4 · 印刷p.218–220 / PDFp.239–241
[EXTRA] [EXTRA]标准归一化概率平均的实际检验Avβ(1)=1；保留旧CH06-017，独立于错误的式(6.4)重复归一化字面定义。 -/
theorem canonicalAverageOne {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ)
    (hρ : Integrable (textbookHamiltonianGibbsWeight H β)) :
    textbookCanonicalAverage H β (fun _ ↦ 1) = 1 := by
  apply MolecularDynamics.textbookCanonicalAverage_one <;> assumption

/-- source_id: MD-6.1.5-Equipartition · unnumbered_claim · §6.1.5 · 印刷p.221 / PDFp.242
[EXTRA] [EXTRA]标准归一化真实全空间密度、正β及全部正质量；可积且正配置partition；β⁻¹=kBT，完整逐坐标和总动能两项保留。 -/
theorem equipartition :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) →
  0 < (∫ q, Real.exp (-β*U q)) →
  (∀ i, (∫ x : MolecularDynamics.Chapter06Review.Phase n, (x.2 i)^2 * MolecularDynamics.Chapter06Review.canonicalDensity volume (MolecularDynamics.Chapter06Review.massHamiltonian m U) β x) = m i/β) ∧
  (∫ x : MolecularDynamics.Chapter06Review.Phase n, (∑ i, (x.2 i)^2/m i) * MolecularDynamics.Chapter06Review.canonicalDensity volume (MolecularDynamics.Chapter06Review.massHamiltonian m U) β x) = n/β := by
  sorry

/-- source_id: MD-6.1.5-ConfigurationalTemperature · (6.5) · §6.1.5 · 印刷p.222 / PDFp.243
[EXTRA] [EXTRA]C²实际U、正β、真实梯度和二阶导数、各加权导数可积及严格正分母；不是将比值等式作前提。 -/
theorem configTemperature :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  ContDiff ℝ 2 U → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) →
  (∀ i, Integrable (fun q ↦ textbookConfigurationPartial U i q ^ 2 * Real.exp (-β*U q))) →
  (∀ i, Integrable (fun q ↦ textbookConfigurationPartial (textbookConfigurationPartial U i) i q * Real.exp (-β*U q))) →
  (∀ i, Integrable (fun q ↦ textbookConfigurationPartial U i q * Real.exp (-β*U q))) →
  0 < (∫ q, (∑ i, textbookConfigurationPartial (textbookConfigurationPartial U i) i q) * Real.exp (-β*U q)) →
  (∫ q, (∑ i, textbookConfigurationPartial U i q ^ 2) * Real.exp (-β*U q)) /
    (∫ q, (∑ i, textbookConfigurationPartial (textbookConfigurationPartial U i) i q) * Real.exp (-β*U q)) = β⁻¹ := by
  sorry

/-- source_id: MD-6.1.5-Proposition61 · Proposition 6.1 · §6.1.5 · 印刷p.222 / PDFp.243
[EXTRA] [EXTRA]正kB,T、实际C¹ H,G、Gibbs及两个加权可观测量可积，分母严格正；原|Ge⁻βH|<∞解释为统一有界C≥0，不采用仅逐点有限的空洞条件。 -/
theorem proposition61 {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (kB T : ℝ) (hkB : 0 < kB) (hT : 0 < T) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H (kB * T)⁻¹))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z • G z‖ ≤ C)
    (hpos : 0 < textbookCanonicalAverage H (kB * T)⁻¹ (textbookDivergence G)) :
    kB * T =
      textbookCanonicalAverage H (kB * T)⁻¹ (textbookLieDerivative G H) /
        textbookCanonicalAverage H (kB * T)⁻¹ (textbookDivergence G) := by
  apply MolecularDynamics.proposition_6_1 <;> assumption

/-- source_id: MD-6.1.5-WeightedFluxZero · extra_claim · §6.1.5 · 印刷p.222 / PDFp.243
[EXTRA] [EXTRA]真实全空间、原有统一加权场界及可积性，导出实际div(ρG)积分零，不把边界通量消失作假设。 -/
theorem weightedFluxZero {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H β))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H β z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H β z • G z‖ ≤ C) :
    (∫ z, textbookDivergence (fun x ↦ textbookHamiltonianGibbsWeight H β x • G x) z) = 0 := by
  apply MolecularDynamics.textbookCanonicalWeightedFlux_integral_divergence_eq_zero <;> assumption

/-- source_id: MD-6.1.5-CanonicalDivergenceIdentity · extra_claim · §6.1.5 · 印刷p.222 / PDFp.243
[EXTRA] [EXTRA]同一真实全空间、实际权重可积及统一有界场；导出Avβ(divG)=βAvβ(G·∇H)，不假设IBP结论。 -/
theorem canonicalDivergenceIdentity {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H β))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H β z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H β z • G z‖ ≤ C) :
    textbookCanonicalAverage H β (textbookDivergence G) =
      β * textbookCanonicalAverage H β (textbookLieDerivative G H) := by
  apply MolecularDynamics.textbookCanonicalAverage_divergence_eq_beta_lieDerivative <;> assumption

/-- source_id: MD-6.1.5-TemperatureChoiceDerivatives · extra_claim · §6.1.5 · 印刷p.223 / PDFp.244
[EXTRA] [EXTRA]保存三个原实际向量场的真实方向导数/分子计算；完整动能、配置温度和virial平均公式分别在Equipartition、ConfigurationalTemperature、VirialTemperature保留，不将分子计算计为完整温度公式。 -/
theorem temperatureChoiceDerivatives :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (q p : MolecularDynamics.Chapter06Review.V n),
  (∀ i, 0 < m i) → ContDiff ℝ 2 U →
  fderiv ℝ (MolecularDynamics.Chapter06Review.massHamiltonian m U) (q,p) (0,p) = ∑ i, p i^2/m i ∧
  fderiv ℝ (MolecularDynamics.Chapter06Review.massHamiltonian m U) (q,p) ((fun i ↦ textbookConfigurationPartial U i q),0) =
    ∑ i, textbookConfigurationPartial U i q ^ 2 ∧
  fderiv ℝ (MolecularDynamics.Chapter06Review.massHamiltonian m U) (q,p) (q,0) = ∑ i, q i * textbookConfigurationPartial U i q := by
  sorry

/-- source_id: MD-6.1.5-PeriodicBoundaryCancellation · unnumbered_claim · §6.1.5 · 印刷p.223–224 / PDFp.244–245
[EXTRA] [EXTRA]正式现成单位周期配置cube的真实光滑向量场散度积分；F为实际各分量，可以对固定p取F=Gρ；无穷动量方向仍需原尾部资格，不计所有p积分可积性已证。 -/
theorem periodicBoundaryCancellation {Nc : ℕ}
    (F : Fin Nc → (Fin Nc → ℝ) → ℝ)
    (hF : ∀ i, ContDiff ℝ ∞ (F i))
    (hp : ∀ i, textbookUnitPeriodicPotential (F i)) :
    (∫ q in textbookConfigurationCube Nc,
      ∑ i, textbookConfigurationPartial (F i) i q) = 0 := by
  apply MolecularDynamics.textbookConfigurationCube_integral_divergence_eq_zero <;> assumption

/-- source_id: MD-6.1.3-MeanEnergyConstraint · definition · §6.1.3 · 印刷p.218 / PDFp.239 -/
def meanEnergyConstraint {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β meanEnergy : ℝ) : Prop :=
  (∫ z, H z * Real.exp (-β*H z) ∂ν) / (∫ z, Real.exp (-β*H z) ∂ν) = meanEnergy

/-- source_id: MD-6.1.3-DensityNormalization · extra_claim · §6.1.3 · 印刷p.218 / PDFp.239
[EXTRA] [EXTRA]任意实际参考测度、权重可积且分母正；结论是实际归一化，不假设密度积分一。 -/
theorem densityNormalization : ∀ {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ),
  Integrable (fun x ↦ Real.exp (-β*H x)) ν → 0 < (∫ x, Real.exp (-β*H x) ∂ν) →
  (∫ x, MolecularDynamics.Chapter06Review.canonicalDensity ν H β x ∂ν) = 1 := by
  intro D inst ν H β hI hZ
  simp only [MolecularDynamics.Chapter06Review.canonicalDensity]
  rw [integral_div]
  exact div_self hZ.ne' 

/-- source_id: MD-6.1.5-PartitionInversePrinted · unnumbered_claim · §6.1.5 · 印刷p.220 / PDFp.241
[ERRATUM?] [ERRATUM?]此页印刷Zcan⁻¹=积分，与p.218的Zcan=积分相反；字面保留，标准DensityNormalization仍按真实积分归一化。 -/
theorem partitionInversePrinted : ∀ {n : ℕ}
    (m : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β →
  Integrable (fun x : MolecularDynamics.Chapter06Review.Phase n ↦
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)) →
  (∫ x : MolecularDynamics.Chapter06Review.Phase n,
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x))⁻¹ =
  (∫ x : MolecularDynamics.Chapter06Review.Phase n,
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)) := by
  sorry

/-- 修正版，对应原文 MD-6.1.5-PartitionInversePrinted；改动：Zcan定义为积分本身；归一密度的结论另见DensityNormalization，避免把定义重述作新定理。 -/
def partitionInversePrinted_corrected {n : ℕ} (m : Fin n → ℝ)
    (U : (Fin n → ℝ) → ℝ) (β : ℝ) : ℝ :=
  ∫ x : MolecularDynamics.Chapter06Review.Phase n,
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)

/-- source_id: MD-6.1.5-WeightedFluxIdentity · extra_claim · §6.1.5 · 印刷p.222 / PDFp.243
[EXTRA] [EXTRA]真实Fréchet导数和散度乘法恒等式，β任意、H,G在该点可微；不假设加权散度恒等式。 -/
theorem weightedFluxIdentity {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (z : SymplecticCoordinates Nc)
    (hH : DifferentiableAt ℝ H z) (hG : DifferentiableAt ℝ G z) :
    textbookDivergence (fun x ↦ textbookHamiltonianGibbsWeight H β x • G x) z =
      textbookHamiltonianGibbsWeight H β z *
        (textbookDivergence G z - β * textbookLieDerivative G H z) := by
  apply MolecularDynamics.textbookCanonicalWeightedFlux_divergence <;> assumption

/-- source_id: MD-6.1.5-VirialTemperature · unnumbered_claim · §6.1.5 · 印刷p.223 / PDFp.244
[EXTRA] [EXTRA]实际全配置空间、n>0、一般正质量、正β及C²U；真实加权virial可积且配置通量统一有界，不假设平均温度公式。 -/
theorem virialTemperature : ∀ {n : ℕ} (hn : 0 < n)
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
  sorry

/-- source_id: MD-6.1.5-VirialFieldNotPeriodic · unnumbered_claim · §6.1.5 · 印刷p.224 / PDFp.245
[EXTRA] [EXTRA]沿实际单位周期坐标平移时配置部分q变化，因此G=(q,0)不定义周期torus向量场；i : Fin n自动排除零维空坐标情形。 -/
theorem virialFieldNotPeriodic : ∀ {n : ℕ} (i : Fin n) (q : Fin n → ℝ),
  q + Pi.single i 1 ≠ q := by
  intro n i q h
  have hi := congrFun h i
  simp at hi

/-- source_id: MD-6.1.3-DensityPositive · extra_claim · §6.1.3 · 印刷p.218 / PDFp.239
[EXTRA] [EXTRA]真实partition严格正时实际密度点态正；不将正密度作前提，积分为一在独立Normalization条目。 -/
theorem densityPositive : ∀ {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ),
  0 < (∫ z, Real.exp (-β*H z) ∂ν) →
  ∀ x, 0 < MolecularDynamics.Chapter06Review.canonicalDensity ν H β x := by
  intro D inst ν H β hZ x
  exact div_pos (Real.exp_pos _) hZ

/-- source_id: MD-6.1.5-KineticWeightFactorization · unnumbered_claim · §6.1.5 · 印刷p.221 / PDFp.242
[EXTRA] [EXTRA]保存每坐标质量和实际有限乘积；这是点态指数代数恒等式，正质量是物理解释所需，不计积分/能均分已证。 -/
theorem kineticWeightFactorization : ∀ {n : ℕ}
    (m q p : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U (q,p)) =
    Real.exp (-β*U q) * ∏ i, Real.exp (-β*(p i)^2/(2*m i)) := by
  intro n m q p U β
  unfold MolecularDynamics.Chapter06Review.massHamiltonian
  rw [mul_add, Real.exp_add, Finset.mul_sum, Real.exp_sum, mul_comm]
  congr 1
  apply Finset.prod_congr rfl
  intro i hi
  congr 1
  ring

/-- source_id: MD-6.2-EnergySupportObstruction · extra_claim · §6.2 · 印刷p.224 / PDFp.245
[EXTRA] [EXTRA]实际能量守恒轨道、连续H及另一能量区域有正μ测度；本条是支持障碍，完整积分/时间平均障碍在下一条保留。 -/
theorem energySupportObstruction :
  ∀ {n : ℕ} (H : MolecularDynamics.Chapter06Review.V n → ℝ) (E : ℝ)
    (z : ℝ → MolecularDynamics.Chapter06Review.V n) (μ : Measure (MolecularDynamics.Chapter06Review.V n)), Continuous H →
  (∀ t, H (z t) = E) → 0 < μ {x | H x ≠ E} →
  (∀ t, z t ∉ {x | H x ≠ E}) ∧ μ {x | H x ≠ E} ≠ 0 := by
  intro n H energy z μ hH hz hpositive
  constructor
  · intro t ht
    exact ht (hz t)
  · exact hpositive.ne'


/-- source_id: MD-6.2-CanonicalSamplingObstruction · unnumbered_claim · §6.2 · 印刷p.224 / PDFp.245
[EXTRA] [EXTRA]目标为真实概率测度、其他能量区域正测度；结论构造实际可积检验函数，其沿轨道时间平均为零而目标平均严格正；不以采样失败为前提。 -/
theorem canonicalSamplingObstruction : ∀ {n : ℕ}
    (H : MolecularDynamics.Chapter06Review.V n → ℝ) (energy : ℝ)
    (z : ℝ → MolecularDynamics.Chapter06Review.V n)
    (μ : Measure (MolecularDynamics.Chapter06Review.V n)) [IsProbabilityMeasure μ],
  Continuous H → (∀ t, H (z t) = energy) → 0 < μ {x | H x ≠ energy} →
  ∃ g : MolecularDynamics.Chapter06Review.V n → ℝ, Integrable g μ ∧
    0 < (∫ x, g x ∂μ) ∧
    Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 0) := by
  intro n H energy z μ inst hH hz hpositive
  let S : Set (MolecularDynamics.Chapter06Review.V n) := {x | H x ≠ energy}
  have hS : MeasurableSet S := (isClosed_singleton.preimage hH).isOpen_compl.measurableSet
  let g : MolecularDynamics.Chapter06Review.V n → ℝ := S.indicator (fun _ ↦ 1)
  have hgi : Integrable g μ := (integrable_const (1 : ℝ)).indicator hS
  have hIntegral : (∫ x, g x ∂μ)=μ.real S := integral_indicator_one hS
  have hzero : ∀ t : ℝ, g (z t)=0 := by
    intro t
    simp only [g, Set.indicator, S, Set.mem_setOf_eq, hz t, ne_eq, not_true_eq_false, ↓reduceIte]
  refine ⟨g,hgi,?_,?_⟩
  · rw [hIntegral]
    exact ENNReal.toReal_pos hpositive.ne' (measure_ne_top μ S)
  · have hfun : MolecularDynamics.Chapter05Review.timeAverage z g=(fun _ : ℝ ↦ 0) := by
      funext T
      simp [MolecularDynamics.Chapter05Review.timeAverage,hzero]
    rw [hfun]
    exact tendsto_const_nhds


/-- source_id: MD-6.2.1-RademacherJumps · definition · §6.2.1 · 印刷p.225 / PDFp.246
[EXTRA] [EXTRA]真实概率空间、独立可测L²跳跃、AE取±1且期望零；这些条件保留公平Rademacher意义，不把二阶有限和结论作假设。 -/
def rademacherJumps {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun J P ∧ ∀ k,
    Measurable (J k) ∧ MemLp (J k) 2 P ∧
    (∀ᵐ sample ∂P, J k sample = 1 ∨ J k sample = -1) ∧ (∫ sample, J k sample ∂P) = 0

/-- source_id: MD-6.2.1-RandomWalk · definition · §6.2.1 · 印刷p.225 / PDFp.246 -/
def randomWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω) : ℝ :=
  dx * ∑ k ∈ Finset.range n, J k sample

/-- source_id: MD-6.2.1-WalkRecurrence · unnumbered_claim · §6.2.1 · 印刷p.225 / PDFp.246 -/
theorem walkRecurrence :
  ∀ {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω),
  MolecularDynamics.Chapter06Review.randomWalk J dx (n+1) sample = MolecularDynamics.Chapter06Review.randomWalk J dx n sample + dx*J n sample := by
  intro Ω J dx n sample
  simp only [MolecularDynamics.Chapter06Review.randomWalk, Finset.sum_range_succ]
  ring

/-- source_id: MD-6.2.1-WalkInitial · unnumbered_claim · §6.2.1 · 印刷p.225 / PDFp.246 -/
theorem walkInitial : ∀ {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (sample : Ω),
  MolecularDynamics.Chapter06Review.randomWalk J dx 0 sample = 0 := by
  intro Ω J dx sample
  simp [MolecularDynamics.Chapter06Review.randomWalk]

/-- source_id: MD-6.2.1-WalkVariance · unnumbered_claim · §6.2.1 · 印刷p.225–226 / PDFp.246–247
[EXTRA] [EXTRA]完整真实概率、L²、独立且公平±1跳跃；同时保存零均值与原完整二阶矩，不将和的二阶矩或交叉项零作前提。 -/
theorem walkVariance :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ), MolecularDynamics.Chapter06Review.rademacherJumps P J →
  (∫ sample, MolecularDynamics.Chapter06Review.randomWalk J dx n sample ∂P) = 0 ∧ (∫ sample, MolecularDynamics.Chapter06Review.randomWalk J dx n sample ^ 2 ∂P) = n*dx^2 := by
  sorry

/-- source_id: MD-6.2.1-DiffusiveWalk · definition · §6.2.1 · 印刷p.226 / PDFp.247 -/
def diffusiveWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dt : ℝ) : ℕ → Ω → ℝ :=
  MolecularDynamics.Chapter06Review.randomWalk J (Real.sqrt dt)

/-- source_id: MD-6.2.1-InterpolatedWalk · definition · §6.2.1 · 印刷p.226 / PDFp.247 -/
def interpolatedWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dt t : ℝ) (sample : Ω) : ℝ :=
  let n := Nat.floor (t / dt)
  MolecularDynamics.Chapter06Review.diffusiveWalk J dt n sample + (t - n * dt) / dt *
    (MolecularDynamics.Chapter06Review.diffusiveWalk J dt (n+1) sample - MolecularDynamics.Chapter06Review.diffusiveWalk J dt n sample)

/-- source_id: MD-6.2.1-WalkIncrement · definition · §6.2.1 · 印刷p.225–226 / PDFp.246–247 -/
def walkIncrement {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω) : ℝ :=
  MolecularDynamics.Chapter06Review.randomWalk J dx (n+1) sample - MolecularDynamics.Chapter06Review.randomWalk J dx n sample

/-- source_id: MD-6.2.1-WalkGridMoments · unnumbered_claim · §6.2.1 · 印刷p.226 / PDFp.247
[EXTRA] [EXTRA]实际独立公平L²跳跃、正δt和k≤l；保存零均值与完整增量二阶矩，不假设这些结论。 -/
theorem walkGridMoments :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (dt : ℝ) (k l : ℕ), MolecularDynamics.Chapter06Review.rademacherJumps P J → 0 < dt → k ≤ l →
  (∫ sample, MolecularDynamics.Chapter06Review.diffusiveWalk J dt l sample-MolecularDynamics.Chapter06Review.diffusiveWalk J dt k sample ∂P) = 0 ∧
  (∫ sample, (MolecularDynamics.Chapter06Review.diffusiveWalk J dt l sample-MolecularDynamics.Chapter06Review.diffusiveWalk J dt k sample)^2 ∂P) = ((l : ℝ)-k)*dt := by
  sorry

/-- source_id: MD-6.2.1-InterpolatedWalkMean · unnumbered_claim · §6.2.1 · 印刷p.226 / PDFp.247
[EXTRA] [EXTRA]真实线性插值均值；任意有限正时间可置于τ窗口，不声称精确插值方差等于s−t。 -/
theorem interpolatedWalkMean : ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (J : ℕ → Ω → ℝ) (dt t s : ℝ),
  MolecularDynamics.Chapter06Review.rademacherJumps P J → 0 < dt → 0 ≤ t → t ≤ s →
  (∫ sample, MolecularDynamics.Chapter06Review.interpolatedWalk J dt s sample -
    MolecularDynamics.Chapter06Review.interpolatedWalk J dt t sample ∂P) = 0 := by
  sorry

/-- source_id: MD-6.2.1-WalkDiffusion · unnumbered_claim · §6.2.1 · 印刷p.226–227 / PDFp.247–248
[EXTRA] [EXTRA]完整连续路径空间C([0,T],ℝ)弱法则、各时Gaussian边际、独立增量和全部有界连续路径检验函数；使用实际线性插值的n项和，不将单时CLT计为路径Donsker已证。
[EXTRA] [EXTRA]印刷含端点的多一项有限和与标准n项版本之差在扩散极限消失须另核；连续版本和不可微性质另条保留。 -/
theorem walkDiffusion :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (T : ℝ), MolecularDynamics.Chapter06Review.rademacherJumps P J → 0 < T →
  ∃ μ : Measure (C(Icc (0 : ℝ) T, ℝ)), IsProbabilityMeasure μ ∧
    (∀ t : Icc (0 : ℝ) T, μ.map (fun w ↦ w t) = gaussianReal 0 t.1.toNNReal) ∧
    (∀ s t : Icc (0 : ℝ) T, s ≤ t →
      HasLaw (fun w : C(Icc (0 : ℝ) T, ℝ) ↦ w t-w s) (gaussianReal 0 (t.1-s.1).toNNReal) μ) ∧
    (∀ k : ℕ, ∀ ts : Fin (k+1) → Icc (0 : ℝ) T, Monotone ts →
      iIndepFun (fun i : Fin k ↦ fun w : C(Icc (0 : ℝ) T, ℝ) ↦ w (ts i.succ)-w (ts i.castSucc)) μ) ∧
    ∀ F : C(Icc (0 : ℝ) T, ℝ) → ℝ, Continuous F → Bornology.IsBounded (Set.range F) →
      ∃ Y : ℕ → Ω → C(Icc (0 : ℝ) T, ℝ),
        (∀ K : ℕ, 0 < K → ∀ sample t, Y K sample t = MolecularDynamics.Chapter06Review.interpolatedWalk J (T/K) t sample) ∧
        Tendsto (fun K ↦ ∫ sample, F (Y K sample) ∂P) atTop (𝓝 (∫ w, F w ∂μ)) := by
  sorry

/-- source_id: MD-6.2.1-WienerVector · definition · §6.2.1 · 印刷p.227 / PDFp.248 -/
def wienerVector {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω) : Prop :=
  MolecularDynamics.textbookIsWienerVector B P

/-- source_id: MD-6.2.1-WienerIncrement · (6.7) · §6.2.1 · 印刷p.227 / PDFp.248
[EXTRA] [EXTRA]实际IsPreBrownianReal模型、任意非负s,t、完整Gaussian法则与二阶矩；不局限等距网格。 -/
theorem wienerIncrement :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P → ∀ s t : ℝ≥0,
      HasLaw (fun sample ↦ W t sample-W s sample) (gaussianReal 0 (|((t : ℝ)-s)|).toNNReal) P ∧
      (∫ sample, (W t sample-W s sample)^2 ∂P)=|((t : ℝ)-s)| := by
  intro Ω inst P W hW s t
  have hl : HasLaw (fun sample ↦ W t sample-W s sample)
      (gaussianReal 0 (|((t : ℝ)-s)|).toNNReal) P := by
    convert hW.hasLaw_sub t s using 1
    apply congrArg (gaussianReal 0)
    apply NNReal.coe_injective
    simp [Real.nndist_eq, Real.nnabs]
  refine ⟨hl, ?_⟩
  simpa only [Real.coe_toNNReal _ (abs_nonneg _)] using
    MolecularDynamics.textbookCenteredGaussian_secondMoment hl

/-- source_id: MD-6.2.1-WienerContinuousVersion · unnumbered_claim · §6.2.1 · 印刷p.226–227 / PDFp.247–248
[EXTRA] [EXTRA]从实际PreBrownian Gaussian法则构造AE连续修改，保持每个时刻AE一致；不将连续性本身作存在连续版本定理的前提。 -/
theorem wienerContinuousVersion :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  ∃ V : ℝ≥0 → Ω → ℝ, (∀ t, W t =ᵐ[P] V t) ∧ ∀ᵐ sample ∂P, Continuous (fun t ↦ V t sample) := by
  sorry

/-- source_id: MD-6.2.1-WienerNondifferentiable · unnumbered_claim · §6.2.1 · 印刷p.226–227 / PDFp.247–248
[EXTRA] [EXTRA]实际PreBrownian法则与连续路径版本，结论AE每个正时刻不可微；不将不可微性作前提。 -/
theorem wienerNondifferentiable :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  (∀ᵐ sample ∂P, Continuous (fun t : ℝ≥0 ↦ W t sample)) →
  ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t → ¬ DifferentiableAt ℝ (fun s ↦ W s.toNNReal sample) t := by
  sorry

/-- source_id: MD-6.2.1-WienerFutureCompletedHistory · unnumbered_claim · §6.2.1 · 印刷p.227 / PDFp.248
[EXTRA] [EXTRA]真实多维Wiener、真实未来连续路径与整个零集完成的过去filtration独立；独立对象全部保留。粗事件条件概率式另条疑误，不将本条视为该式证明。 -/
theorem wienerFutureCompletedHistory
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (S : ℝ≥0) (T : ℝ) :
    Indep ((inferInstance : MeasurableSpace C(Icc (0 : ℝ) T, Fin Nc → ℝ)).comap
        (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T))
      (textbookWienerVectorCompletedFiltration B P hB S) P.completion := by
  apply MolecularDynamics.textbookWienerVectorFuture_independent_completed_filtration <;> assumption

/-- source_id: MD-6.2.1-GridWienerIncrementLaw · extra_claim · §6.2.1 · 印刷p.227 / PDFp.248
[EXTRA] [EXTRA]等距T/K网格完整Gaussian法则；任意时刻原结论另条WienerIncrement保留。 -/
theorem gridWienerIncrementLaw {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) (k : Fin K) :
    HasLaw (textbookWienerIncrement W T K k) (gaussianReal 0 (T / (K : ℝ≥0))) P := by
  apply MolecularDynamics.textbookWienerIncrement_hasLaw <;> assumption

/-- source_id: MD-6.2.1-GridIncrementIndependent · extra_claim · §6.2.1 · 印刷p.227 / PDFp.248
[EXTRA] [EXTRA]实际等距有限增量族iIndepFun；整条未来路径独立在上一条保留。 -/
theorem gridIncrementIndependent {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) :
    iIndepFun (textbookWienerIncrement W T K) P := by
  apply MolecularDynamics.textbookWienerIncrement_independent <;> assumption

/-- source_id: MD-6.2.1-WienerContinuousPathEval · extra_claim · §6.2.1 · 印刷p.226–227 / PDFp.247–248
[EXTRA] [EXTRA]给定连续样本的真实C([0,T],ℝⁿ)值与所有时刻原路径一致；不证明从PreBrownian构造连续修改。 -/
theorem wienerContinuousPathEval {Nc : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (T : ℝ) (sample : Ω)
    (hc : Continuous (fun t ↦ B t sample)) (t : Icc 0 T) :
    textbookWienerVectorContinuousPath B T sample t = B ⟨t.1, t.2.1⟩ sample := by
  apply MolecularDynamics.textbookWienerVectorContinuousPath_eval <;> assumption

/-- source_id: MD-6.2.1-WienerContinuousPathMeasurable · extra_claim · §6.2.1 · 印刷p.226–227 / PDFp.247–248
[EXTRA] [EXTRA]给定真实连续Wiener模型导出整个连续路径空间AE可测性；不是将路径可测结论作假设。 -/
theorem wienerContinuousPathMeasurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (T : ℝ) :
    AEMeasurable (textbookWienerVectorContinuousPath B T) P := by
  apply MolecularDynamics.textbookWienerVectorContinuousPath_aemeasurable <;> assumption

/-- source_id: MD-6.2.1-CoarseMarkovPrinted · unnumbered_claim · §6.2.1 · 印刷p.227 / PDFp.248
[ERRATUM?] 印刷用任意粗事件B(X(t0))替代完整当前状态的条件σ代数；一般不成立，例如B=univ时过去事件仍可影响未来。 -/
theorem coarseMarkovPrinted : ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  ∀ (a b c : Set ℝ) (past present future : ℝ≥0),
    MeasurableSet a → MeasurableSet b → MeasurableSet c → past < present → present < future →
    0 < P ((W present ⁻¹' b) ∩ (W past ⁻¹' c)) →
    P ((W future ⁻¹' a) ∩ ((W present ⁻¹' b) ∩ (W past ⁻¹' c))) /
      P ((W present ⁻¹' b) ∩ (W past ⁻¹' c)) =
    P ((W future ⁻¹' a) ∩ (W present ⁻¹' b)) / P (W present ⁻¹' b) := by
  sorry

/-- source_id: MD-6.2.1-StateMarkovMeaning · definition · §6.2.1 · 印刷p.227 / PDFp.248
[EXTRA] [EXTRA]明确以真实当前状态σ(Xs)及过去history作条件期望；仅定义完整Markov意义，不计任意过程满足它已证。 -/
def stateMarkovMeaning {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (X : ℝ≥0 → Ω → ℝ) (history : ℝ≥0 → MeasurableSpace Ω) : Prop :=
  ∀ s t : ℝ≥0, s ≤ t → ∀ a : Set ℝ, MeasurableSet a →
    MeasureTheory.condExp (history s) P (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample)) =ᵐ[P]
    MeasureTheory.condExp (MeasurableSpace.comap (X s) inferInstance) P
      (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample))

/-- 修正版，对应原文 MD-6.2.1-CoarseMarkovPrinted；改动：以完整当前状态生成的σ代数写条件期望Markov性质。 -/
def coarseMarkovPrinted_corrected {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (X : ℝ≥0 → Ω → ℝ) (history : ℝ≥0 → MeasurableSpace Ω) : Prop :=
  ∀ s t : ℝ≥0, s ≤ t → ∀ a : Set ℝ, MeasurableSet a →
    MeasureTheory.condExp (history s) P (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample)) =ᵐ[P]
    MeasureTheory.condExp (MeasurableSpace.comap (X s) inferInstance) P
      (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample))

/-- source_id: MD-6.2.2-RiemannTags · unnumbered_claim · §6.2.2 · 印刷p.228 / PDFp.249
[EXTRA] [EXTRA]非负窗口和所有合法任意tags；完整标签无关性，没有缩减为仅左端点特例。 -/
theorem riemannTags : ∀ (g : ℝ → ℝ) (T : ℝ) (tags : ℕ → ℕ → ℝ),
  0 ≤ T → ContinuousOn g (Icc 0 T) →
  (∀ K k : ℕ, 0 < K → k < K → tags K k ∈ Icc ((k : ℝ)*T/K) (((k : ℝ)+1)*T/K)) →
  Tendsto (fun K : ℕ ↦ ∑ k ∈ Finset.range K, g (tags K k)*(T/K)) atTop
    (𝓝 (∫ t in (0 : ℝ)..T, g t)) := by
  sorry

/-- source_id: MD-6.2.2-ItoLeftSum · definition · §6.2.2 · 印刷p.228 / PDFp.249 -/
def itoLeftSum {Ω : Type*} (W g : ℝ → Ω → ℝ) (T : ℝ) (K : ℕ) (sample : Ω) : ℝ :=
  ∑ k ∈ Finset.range K, g ((k : ℝ) * T / K) sample *
    (W (((k : ℝ)+1) * T / K) sample - W ((k : ℝ) * T / K) sample)

/-- source_id: MD-6.2.2-StrictItoIntegral · definition · §6.2.2 · 印刷p.228–229 / PDFp.249–250
[EXTRA] [EXTRA]显式所有有限和与极限的L²资格，防止Bochner非可积默认值0伪造均方收敛；真实取样和极限，不假设任何求值结论。 -/
def strictItoIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample,
    (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample-Y sample)^2 ∂P) atTop (𝓝 0)

/-- 修正版，对应原文 MD-6.2.2-WeakItoAlias；改动：严格定义要求每个有限和及极限变量均属于L²；正式库冻结，只在Blueprint使用严格版。 -/
def weakItoAlias_corrected {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample,
    (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample-Y sample)^2 ∂P) atTop (𝓝 0)

/-- source_id: MD-6.2.2-WeakItoAlias · definition · §6.2.2 · 印刷p.228–229 / PDFp.249–250
[ERRATUM?] 既有Review定义仅要求Y∈L²及误差Bochner积分收敛，未要求各有限和L²，非可积默认积分0会掩盖错误；不得用于新PASS SDE证明。 -/
def weakItoAlias {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample, (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample - Y sample)^2 ∂P) atTop (𝓝 0)

/-- source_id: MD-6.2.2-StratonovichSum · definition · §6.2.2 · 印刷p.228 / PDFp.249 -/
def stratonovichSum {Ω : Type*} (W g : ℝ → Ω → ℝ) (T : ℝ) (K : ℕ) (sample : Ω) : ℝ :=
  ∑ k ∈ Finset.range K, g (((k : ℝ)+1/2)*T/K) sample *
    (W (((k : ℝ)+1)*T/K) sample-W ((k : ℝ)*T/K) sample)

/-- source_id: MD-6.2.2-SelfItoFiniteIdentity · unnumbered_claim · §6.2.2 · 印刷p.228–229 / PDFp.249–250
[EXTRA] [EXTRA]真实PreBrownian、K>0和AE W0=0；保存完整有限和望远镜恒等。 -/
theorem selfItoFiniteIdentity {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    ∀ᵐ sample ∂P, 2 * textbookWienerSelfItoSum W T K sample =
      W T sample ^ 2 - textbookWienerQuadraticSum W T K sample := by
  apply MolecularDynamics.textbookWienerSelfItoSum_identity <;> assumption

/-- source_id: MD-6.2.2-Proposition62 · Proposition 6.2 · §6.2.2 · 印刷p.229–230 / PDFp.250–251
[EXTRA] [EXTRA]实际PreBrownian law、τ≥0、全部均方极限；印刷最后K→0是笔误，更正K→∞。
[ERRATUM?] 印刷证明的独立交叉项展开带负号；平方展开应正号，见单独疑误条。 -/
theorem proposition62 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ sample,
      (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) atTop (𝓝 0) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_meanSquare_tendsto <;> assumption

/-- 修正版，对应原文 MD-6.2.2-Proposition62；改动：保持已证二次变差结论；独立记录印刷平方展开与其正确代数式，并注明极限方向。 -/
theorem proposition62_corrected {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ sample,
      (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) atTop (𝓝 0) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_meanSquare_tendsto <;> assumption

/-- 【原书疑误】p.229错误交叉项展开；双变量形式，原文不证。 -/
def proposition62Printed (x y : ℝ) : ℝ := x^2+y^2-4*x*y

/-- 修正平方展开；有序交叉和的系数为+1。 -/
theorem proposition62Expansion_corrected (x y : ℝ) : (x+y)^2=x^2+y^2+2*x*y := by
  ring

theorem proposition62Printed_counterexample : ¬ ((1+1 : ℝ)^2=1^2+1^2-4*1*1) := by
  norm_num

/-- source_id: MD-6.2.2-MeanSquareConvergence · definition · §6.2.2 · 印刷p.229 / PDFp.250
[EXTRA] [EXTRA]显式L²随机变量资格防止非可积Bochner默认值；不假设收敛结论。 -/
def meanSquareConvergence {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (A : ℕ → Ω → ℝ) (B : Ω → ℝ) : Prop :=
  (∀ K, MemLp (A K) 2 P) ∧ MemLp B 2 P ∧
  Tendsto (fun K ↦ ∫ sample, (A K sample-B sample)^2 ∂P) atTop (𝓝 0)

/-- source_id: MD-6.2.2-WienerMidpointSum · definition · §6.2.2 · 印刷p.228 / PDFp.249 -/
noncomputable def wienerMidpointSum {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} (W : ℝ≥0 → Ω → ℝ) (T : ℝ≥0) (K : ℕ) : Ω → ℝ :=
  fun sample ↦ ∑ k : Fin K, W (textbookWienerTime T (2 * K) (2 * k.val + 1)) sample *
    textbookWienerIncrement W T K k sample

/-- source_id: MD-6.2.2-GaussianIncrementMean · unnumbered_claim · §6.2.2 · 印刷p.230 / PDFp.251
[EXTRA] [EXTRA]任意真实中心Gaussian完整法则推出零均值；增量law桥接先前已保存。 -/
theorem gaussianIncrementMean {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}
    {X : Ω → ℝ} {v : ℝ≥0} (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ∂P) = 0 := by
  rw [hX.integral_eq, integral_id_gaussianReal]

/-- source_id: MD-6.2.2-GaussianIncrementSecond · unnumbered_claim · §6.2.2 · 印刷p.230 / PDFp.251
[EXTRA] [EXTRA]真实中心Gaussian法则导出完整矩；不将矩结论前置。 -/
theorem gaussianIncrementSecond {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ^ 2 ∂P) = (v : ℝ) := by
  apply MolecularDynamics.textbookCenteredGaussian_secondMoment <;> assumption

/-- source_id: MD-6.2.2-GaussianIncrementFourth · unnumbered_claim · §6.2.2 · 印刷p.230 / PDFp.251
[EXTRA] [EXTRA]真实中心Gaussian法则导出完整矩；不将矩结论前置。 -/
theorem gaussianIncrementFourth {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ^ 4 ∂P) = 3 * (v : ℝ) ^ 2 := by
  apply MolecularDynamics.textbookCenteredGaussian_fourthMoment <;> assumption

/-- source_id: MD-6.2.2-QuadraticMeanSquareError · unnumbered_claim · §6.2.2 · 印刷p.230 / PDFp.251
[EXTRA] [EXTRA]实际PreBrownian且K>0；精确误差，不是仅Tendsto0。 -/
theorem quadraticMeanSquareError {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ sample, (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) =
      2 * (T : ℝ) ^ 2 / (K : ℝ) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_meanSquareError <;> assumption

/-- source_id: MD-6.2.2-SelfItoIntegral · unnumbered_claim · §6.2.2 · 印刷p.230 / PDFp.251
[EXTRA] [EXTRA]真实L²见证、全均方收敛及AE求值三项保留；有限和L²另条补足。 -/
theorem selfItoIntegral {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerSelfItoSum W T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ sample ∂P, Y sample = (W T sample ^ 2 - (T : ℝ)) / 2 := by
  apply MolecularDynamics.textbookWienerSelfItoIntegral_exists <;> assumption

/-- source_id: MD-6.2.2-SelfStratonovichIntegral · unnumbered_claim · §6.2.2 · 印刷p.230 / PDFp.251
[EXTRA] [EXTRA]真实时间中点和、L²见证、整体均方极限、AE求值；原O(√δt)单步启发不足，正式整体均方误差证明不直接丢弃逐步残项。 -/
theorem selfStratonovichIntegral {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerMidpointSum W T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ sample ∂P, Y sample = W T sample ^ 2 / 2 := by
  apply MolecularDynamics.textbookWienerSelfStratonovichIntegral_exists <;> assumption

/-- source_id: MD-6.2.2-Proposition63 · Proposition 6.3 · §6.2.2 · 印刷p.231 / PDFp.252
[EXTRA] [EXTRA]实际PreBrownian与C¹ g已足；完整构造L²见证、均方极限、Gaussian law、零均值及二阶矩，不仅保存矩。 -/
theorem proposition63 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) {g : ℝ → ℝ} (hg : ContDiff ℝ 1 g) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerDeterministicSum W g T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧
      HasLaw Y (gaussianReal 0 (textbookWienerDeterministicVariance g T)) P ∧
      (∫ sample, Y sample ∂P) = 0 ∧ (∫ sample, Y sample ^ 2 ∂P) = ∫ x in (0 : ℝ)..T, g x ^ 2 := by
  apply MolecularDynamics.textbookWienerDeterministicIto_proposition63 <;> assumption

/-- source_id: MD-6.2.2-QuadraticSumExpectation · unnumbered_claim · §6.2.2 · 印刷p.229 / PDFp.250
[EXTRA] [EXTRA]实际上每个K>0有限和期望已经恰等于τ；均方极限在Prop6.2保留。 -/
theorem quadraticSumExpectation {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ sample, textbookWienerQuadraticSum W T K sample ∂P) = (T : ℝ) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_integral <;> assumption

/-- source_id: MD-6.2.2-SelfItoLimitL2 · extra_claim · §6.2.2 · 印刷p.230 / PDFp.251
[EXTRA] [EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。 -/
theorem selfItoLimitL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    MemLp (fun sample ↦ (W T sample ^ 2 - (T : ℝ)) / 2) 2 P := by
  apply MolecularDynamics.textbookWienerSelfItoLimit_memLp <;> assumption

/-- source_id: MD-6.2.2-SelfItoSumsL2 · extra_claim · §6.2.2 · 印刷p.230 / PDFp.251
[EXTRA] [EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。 -/
theorem selfItoSumsL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    MemLp (textbookWienerSelfItoSum W T K) 2 P := by
  apply MolecularDynamics.textbookWienerSelfItoSum_memLp <;> assumption

/-- source_id: MD-6.2.2-MidpointSumsL2 · extra_claim · §6.2.2 · 印刷p.230 / PDFp.251
[EXTRA] [EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。 -/
theorem midpointSumsL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    MemLp (textbookWienerMidpointSum W T K) 2 P := by
  apply MolecularDynamics.textbookWienerMidpointSum_memLp <;> assumption

/-- source_id: MD-6.2.2-DeterministicIntegralProcess · (6.8) · §6.2.2 · 印刷p.231 / PDFp.252
[EXTRA] [EXTRA]全部非负时间真实严格L²积分关系；Y0=0从零时间L²极限导出，不能把单时Gaussian独立采样当同一过程。 -/
def deterministicIntegralProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W (fun s _ ↦ g s) T (Y T)

/-- source_id: MD-6.2.2-DeterministicStrobePrinted · unnumbered_claim · §6.2.2 · 印刷p.231 / PDFp.252
[ERRATUM?] 生成增量使用σ(tn)而非相邻时刻方差差；单时边际法则也不能确定同一过程联合分布。保持印刷式，不以独立边际偷换过程。 -/
theorem deterministicStrobePrinted : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  ∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 (Real.sqrt (∫ s in (0 : ℝ)..times (k+1), g s^2)).toNNReal) P := by
  sorry

/-- source_id: MD-6.2.2-DeterministicStrobeCorrected · unnumbered_claim · §6.2.2 · 印刷p.231 / PDFp.252
[EXTRA] [EXTRA]相邻时间积分g²为完整增量方差，并保存整个增量族独立性；不是仅单时law；强L²模型。 -/
theorem deterministicStrobeCorrected : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  (∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 (∫ s in times k..times (k+1), g s^2).toNNReal) P) ∧
  iIndepFun (fun k sample ↦ Y (times (k+1)) sample-Y (times k) sample) P := by
  sorry

/-- 修正版，对应原文 MD-6.2.2-DeterministicStrobePrinted；改动：采用区间积分∫[tₙ,tₙ₊₁]g²及同一过程的独立增量资格。 -/
theorem deterministicStrobePrinted_corrected : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  (∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 (∫ s in times k..times (k+1), g s^2).toNNReal) P) ∧
  iIndepFun (fun k sample ↦ Y (times (k+1)) sample-Y (times k) sample) P := by
  sorry

/-- source_id: MD-6.2.2-StochasticDifferentialIntegral · definition · §6.2.2 · 印刷p.231 / PDFp.252 -/
def stochasticDifferentialIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (Y integralOfDifferential : ℝ → Ω → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → integralOfDifferential T =ᵐ[P] (fun sample ↦ Y T sample-Y 0 sample)

/-- source_id: MD-6.3-BiasedWalk · (6.9) · §6.3 · 印刷p.232 / PDFp.253
[EXTRA] [EXTRA]按正文h=δt及δx=√δt解释真实递归与x0初值；印刷h/δt记号不一致已保留。 -/
def biasedWalk {Ω : Type*} (a b : ℝ → ℝ → ℝ) (J : ℕ → Ω → ℝ)
    (dt x0 : ℝ) : ℕ → Ω → ℝ
  | 0 => fun _ ↦ x0
  | n+1 => fun sample ↦ let x := MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 n sample
    x + a x (n * dt) * dt + b x (n * dt) * Real.sqrt dt * J n sample

/-- source_id: MD-6.3-BiasedWalkSum · (6.10) · §6.3 · 印刷p.232 / PDFp.253 -/
theorem biasedWalkSum : ∀ {Ω : Type*} (a b : ℝ → ℝ → ℝ) (J : ℕ → Ω → ℝ)
    (dt x0 : ℝ) (K : ℕ) (sample : Ω),
  MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 K sample-x0 =
    (∑ k ∈ Finset.range K, a (MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample) (k*dt)*dt) +
    ∑ k ∈ Finset.range K, b (MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample) (k*dt)*Real.sqrt dt*J k sample := by
  intro Ω a b J dt x0 K sample
  induction K with
  | zero => simp [MolecularDynamics.Chapter06Review.biasedWalk]
  | succ K ih =>
    simp only [MolecularDynamics.Chapter06Review.biasedWalk, Finset.sum_range_succ]
    linarith [ih]

/-- source_id: MD-6.3-ScalarSDE · (6.11)–(6.14) · §6.3 · 印刷p.232 / PDFp.253
[EXTRA] [EXTRA]真实连续路径、实际可积漂移及全部有限和L²的Ito极限；是方程意义，不计随机游走扩散极限已证。 -/
def strictScalarSDE {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) : Prop :=
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  ∀ T : ℝ, 0 ≤ T → (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample) s) volume 0 T) ∧
    strictItoIntegral P W (fun s sample ↦ b (X s sample) s) T
      (fun sample ↦ X T sample-x0-∫ s in 0..T, a (X s sample) s)

/-- source_id: MD-6.3-VectorSDE · (6.15)–(6.16) · §6.3 · 印刷p.232–233 / PDFp.253–254
[EXTRA] [EXTRA]完整状态及时间依赖矩阵B(Z,t)，每坐标真实严格Ito积分与漂移；没有缩成常矩阵加性特例。 -/
def strictVectorSDE {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → ℝ → (Fin n → ℝ))
    (B : (Fin n → ℝ) → ℝ → Matrix (Fin n) (Fin r) ℝ) (x0 : Fin n → ℝ) : Prop :=
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  ∀ i : Fin n, ∀ T : ℝ, 0 ≤ T →
    (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample) s i) volume 0 T) ∧
    ∃ integrals : Fin r → Ω → ℝ,
      (∀ j, strictItoIntegral P (fun s sample ↦ W s sample j)
        (fun s sample ↦ B (X s sample) s i j) T (integrals j)) ∧
      (∀ᵐ sample ∂P, X T sample i-x0 i-(∫ s in 0..T, a (X s sample) s i)=∑ j, integrals j sample)

/-- source_id: MD-6.3.1-ScalarItoFormula · (6.17) · §6.3.1 · 印刷p.233 / PDFp.254
[EXTRA] [EXTRA]原C²φ、真实PreBrownian和严格积分方程；完整漂移、噪声、二阶Ito校正；适应/可积技术资格保留。 -/
theorem scalarItoFormula :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X a b x0 →
  ContDiff ℝ 2 φ → ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ a w.1 w.2) →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ b w.1 w.2) →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) →
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) T
    (fun sample ↦ φ (X T sample)-φ x0 - ∫ s in 0..T,
      deriv φ (X s sample)*a (X s sample) s + deriv (deriv φ) (X s sample)*b (X s sample) s^2/2) := by
  sorry

/-- source_id: MD-6.3.1-DiffusiveTaylorPrinted · unnumbered_claim · §6.3.1 · 印刷p.233 / PDFp.254
[ERRATUM?] C² Taylor余项仅o(h²)，不能自动提升为O(h³)；在h≈√δt时原O(δt³⁄²)需要更高阶正则性。 -/
theorem diffusiveTaylorPrinted : ∀ (φ : ℝ → ℝ) (x a b : ℝ), ContDiff ℝ 2 φ →
  Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
    (fun dt ↦ φ (x+a*dt+b*Real.sqrt dt)-φ x-deriv φ x*(a*dt+b*Real.sqrt dt)-
      deriv (deriv φ) x*b^2*dt/2) (fun dt ↦ Real.rpow dt (3/2 : ℝ)) := by
  sorry

/-- 修正版，对应原文 MD-6.3.1-DiffusiveTaylorPrinted；改动：C²加强为C³，使三阶Taylor余项与扩散缩放匹配。 -/
theorem diffusiveTaylorPrinted_corrected : ∀ (φ : ℝ → ℝ) (x a b : ℝ), ContDiff ℝ 3 φ →
  Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
    (fun dt ↦ φ (x+a*dt+b*Real.sqrt dt)-φ x-deriv φ x*(a*dt+b*Real.sqrt dt)-
      deriv (deriv φ) x*b^2*dt/2) (fun dt ↦ Real.rpow dt (3/2 : ℝ)) := by
  sorry

/-- source_id: MD-6.3.1-TimeItoFormula · (6.18) · §6.3.1 · 印刷p.234 / PDFp.255
[EXTRA] [EXTRA]Lean保留完整积分陈述，以φ_t dt的正确时间积分表达；原无dt的字面式仍在逐字JSON，不宣称字面式已证。
[ERRATUM?] 印刷φ_t(X,t)项漏dt，字面微分式不具一致类型；补dt需要网站审计裁定。 -/
theorem timeItoFormula :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ×ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X a b x0 → ContDiff ℝ 2 φ →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W
    (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) T
    (fun sample ↦ φ (X T sample,T)-φ (x0,0) - ∫ s in 0..T,
      fderiv ℝ φ (X s sample,s) (0,1) + fderiv ℝ φ (X s sample,s) (1,0)*a (X s sample) s +
        fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (X s sample,s) (1,0)*b (X s sample) s^2/2) := by
  sorry

/-- 修正版，对应原文 MD-6.3.1-TimeItoFormula；改动：原文右端以形式微分占位量记录，时间偏导补dt；完整修正积分公式独立命名。 -/
theorem timeItoFormula_corrected :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ×ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X a b x0 → ContDiff ℝ 2 φ →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W
    (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) T
    (fun sample ↦ φ (X T sample,T)-φ (x0,0) - ∫ s in 0..T,
      fderiv ℝ φ (X s sample,s) (0,1) + fderiv ℝ φ (X s sample,s) (1,0)*a (X s sample) s +
        fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (X s sample,s) (1,0)*b (X s sample) s^2/2) := by
  sorry

/-- 【原书疑误】(6.17)逐字右端形式表达，dX/dXX为形式微分占位；不宣称它是正确积分等式。 -/
def timeItoFormulaPrinted (φ : ℝ×ℝ → ℝ) (x t dX dXX : ℝ) : ℝ :=
  fderiv ℝ φ (x,t) (0,1)+fderiv ℝ φ (x,t) (1,0)*dX+
    fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (x,t) (1,0)*dXX/2

/-- source_id: MD-6.3-BiasedWalkDiffusion · unnumbered_claim · §6.3 · 印刷p.232 / PDFp.253
[EXTRA] [EXTRA]明确全局Lipschitz技术资格及AE连续W版本；完整SDE解存在与真实偏置有限游走线性插值的路径空间弱极限，没有只以定义取代扩散极限。 -/
theorem biasedWalkDiffusion : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (W : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 T : ℝ),
  MolecularDynamics.Chapter06Review.rademacherJumps P J →
  IsPreBrownianReal (fun t sample ↦ W t sample) P →
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ W t sample) (Ici 0)) →
  (∃ L : ℝ≥0, LipschitzWith L (Function.uncurry a) ∧ LipschitzWith L (Function.uncurry b)) → 0 < T →
  ∃ X : ℝ → Ω → ℝ, strictScalarSDE P W X a b x0 ∧
    ∃ paths : Ω → C(Icc 0 T, ℝ),
      (∀ᵐ sample ∂P, ∀ t : Icc 0 T, paths sample t=X t sample) ∧
      ∃ walks : ℕ → Ω → C(Icc 0 T, ℝ),
        (∀ K : ℕ, 0 < K → ∀ sample (t : Icc 0 T),
          walks K sample t = let dt := T/K; let k := Nat.floor ((t : ℝ)/dt);
            MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample +
            ((t : ℝ)-k*dt)/dt*(MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 (k+1) sample-
              MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample)) ∧
        (∀ F : C(Icc 0 T, ℝ) → ℝ, Continuous F → Bornology.IsBounded (Set.range F) →
          Tendsto (fun K ↦ ∫ sample, F (walks K sample) ∂P) atTop (𝓝 (∫ sample, F (paths sample) ∂P))) := by
  sorry

/-- source_id: MD-6.3.2-OUProcess · (6.19) · §6.3.2 · 印刷p.234 / PDFp.255
[EXTRA] [EXTRA]原显式γ>0保留在真实严格L²积分方程的资格中，不将分布式解作方程前提。 -/
def strictOUProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (γ σ x0 : ℝ) : Prop :=
  0 < γ ∧ strictScalarSDE P W X (fun x _ ↦ -γ*x) (fun _ _ ↦ σ) x0

/-- source_id: MD-6.3.2-OUIntegratingFactor · unnumbered_claim · §6.3.2 · 印刷p.234 / PDFp.255
[EXTRA] [EXTRA]实际PreBrownian、严格OU与严格确定性Ito积分见证、γ>0和t≥0；完整求值，不以解公式作假设。 -/
theorem ouIntegratingFactor :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  ∃ Y : Ω → ℝ, strictItoIntegral P W (fun s _ ↦ Real.exp (γ*s)) T Y ∧
    ∀ᵐ sample ∂P, X T sample = Real.exp (-γ*T)*x0 + σ*Real.exp (-γ*T)*Y sample := by
  sorry

/-- source_id: MD-6.3.2-OUVarianceIntegral · unnumbered_claim · §6.3.2 · 印刷p.235 / PDFp.256
[EXTRA] [EXTRA]γ>0使分母非零；随机变量完整Gaussian law在Prop6.3和OULawCorrect保留。 -/
theorem ouVarianceIntegral : ∀ (γ T : ℝ), 0 < γ → 0 ≤ T →
  (∫ s in (0 : ℝ)..T, Real.exp (2*γ*s))=(Real.exp (2*γ*T)-1)/(2*γ) := by
  intro γ T hγ hT
  have hc : 2*γ ≠ 0 := mul_ne_zero (by norm_num) hγ.ne'
  have hd : ∀ x : ℝ, HasDerivAt (fun s : ℝ ↦ Real.exp (2*γ*s)/(2*γ))
      (Real.exp (2*γ*x)) x := by
    intro x
    simpa [hc] using
      ((Real.hasDerivAt_exp (2*γ*x)).comp x
        ((hasDerivAt_id x).const_mul (2*γ))).div_const (2*γ)
  have hi : IntervalIntegrable (fun s : ℝ ↦ Real.exp (2*γ*s)) volume 0 T :=
    Continuous.intervalIntegrable (by fun_prop) _ _
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt (fun x _ ↦ hd x) hi]
  simp only [mul_zero, Real.exp_zero]
  ring

/-- source_id: MD-6.3.2-OULawPrinted · unnumbered_claim · §6.3.2 · 印刷p.235 / PDFp.256
[ERRATUM?] 原页根号只覆盖(2γ)⁻¹，(1−e⁻²γt)漏在根号内；方差因此被错误平方。单时分布等价不确定整个过程耦合。 -/
theorem ouLawPrinted : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 →
  0 < γ → 0 ≤ T → HasLaw (X T)
    (gaussianReal (Real.exp (-γ*T)*x0)
      ((σ*Real.sqrt ((2*γ)⁻¹)*(1-Real.exp (-2*γ*T)))^2).toNNReal) P := by
  sorry

/-- source_id: MD-6.3.2-OULawCorrect · unnumbered_claim · §6.3.2 · 印刷p.235 / PDFp.256
[EXTRA] [EXTRA]修正标准差σ√((1−e⁻²γt)/(2γ))，完整真实单时Gaussian法则；均值e⁻γtx0、方差σ²(1−e⁻²γt)/(2γ)，不预置law结论。 -/
theorem ouLawCorrect :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  HasLaw (X T) (gaussianReal (MolecularDynamics.Chapter06Review.ouMean γ x0 T) (MolecularDynamics.Chapter06Review.ouVariance γ σ T).toNNReal) P := by
  sorry

/-- 修正版，对应原文 MD-6.3.2-OULawPrinted；改动：把整个(1−e^(−2γt))/(2γ)放入根号；只断言同一OU过程的单时刻法则。 -/
theorem ouLawPrinted_corrected :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  HasLaw (X T) (gaussianReal (MolecularDynamics.Chapter06Review.ouMean γ x0 T) (MolecularDynamics.Chapter06Review.ouVariance γ σ T).toNNReal) P := by
  sorry

/-- source_id: MD-6.3.2-OUGibbsLimit · unnumbered_claim · §6.3.2 · 印刷p.235 / PDFp.256
[EXTRA] [EXTRA]θ=kBT>0,m>0,γ>0；完整弱收敛，全部有界连续检验函数；不只证明均值/方差参数极限。 -/
theorem ouGibbsLimit :
  ∀ (γ θ m x0 : ℝ), 0 < γ → 0 < θ → 0 < m →
  ∀ f : ℝ → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ x, f x ∂gaussianReal (MolecularDynamics.Chapter06Review.ouMean γ x0 t)
      (MolecularDynamics.Chapter06Review.ouVariance γ (Real.sqrt (2*γ*θ*m)) t).toNNReal) atTop
      (𝓝 (∫ x, f x ∂gaussianReal 0 (θ*m).toNNReal)) := by
  sorry

/-- source_id: MD-6.3.2-MomentumOU · (6.20)–(6.21) · §6.3.2 · 印刷p.235 / PDFp.256
[EXTRA] [EXTRA]全部正对角质量mi、γ>0、θ=kBT>0和真实各坐标严格积分关系；独立多维W资格另给，不把单位质量桥接当一般质量已证。 -/
def momentumOU {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W p : ℝ → Ω → MolecularDynamics.Chapter06Review.V n) (m : MolecularDynamics.Chapter06Review.V n) (γ θ : ℝ) (p0 : MolecularDynamics.Chapter06Review.V n) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧
  ∀ i, strictOUProcess P (fun t sample ↦ W t sample i) (fun t sample ↦ p t sample i) γ (Real.sqrt (2*γ*θ*m i)) (p0 i)

/-- source_id: MD-6.3.2-GibbsGaussianDensity · definition · §6.3.2 · 印刷p.235 / PDFp.256 -/
def gibbsGaussianDensity (θ m u : ℝ) : ℝ :=
  Real.exp (-(u^2/(2*m))/θ)/Real.sqrt (2*Real.pi*m*θ)

/-- source_id: MD-6.3.3-BathHamiltonian · definition · §6.3.3 · 印刷p.236 / PDFp.257
[EXTRA] [EXTRA]显式k>0及全部μi>0，避免零质量/零热浴大小的总化除法冒充物理模型。 -/
def bathHamiltonian {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (U : ℝ → ℝ) (Q P : ℝ) (q p : MolecularDynamics.Chapter06Review.V k) : ℝ :=
  P^2/2 + (∑ i, (p i)^2/(2*μ i)) + U Q + (∑ i, (q i-Q)^2)/(2*k)

/-- source_id: MD-6.3.3-BathHamiltonEquations · (6.22)–(6.25) · §6.3.3 · 印刷p.236 / PDFp.257
[EXTRA] [EXTRA]实际Hamiltonian全部偏导、正质量、k>0和U沿Q可微；全部四组等式，不只定义方程。 -/
theorem bathHamiltonEquations :
  ∀ {k : ℕ} (μ : MolecularDynamics.Chapter06Review.V k) (U : ℝ → ℝ)
    (Q P : ℝ) (q p : MolecularDynamics.Chapter06Review.V k), 0 < k → (∀ i, 0 < μ i) → DifferentiableAt ℝ U Q →
  deriv (fun z ↦ MolecularDynamics.Chapter06Review.bathHamiltonian μ U Q z q p) P = P ∧
  -deriv (fun z ↦ MolecularDynamics.Chapter06Review.bathHamiltonian μ U z P q p) Q = -deriv U Q-(∑ i : Fin k, (Q - q i))/(k : ℝ) ∧
  (∀ i, fderiv ℝ (fun v ↦ MolecularDynamics.Chapter06Review.bathHamiltonian μ U Q P q v) p (Pi.single i 1) = p i/μ i) ∧
  (∀ i, -fderiv ℝ (fun v ↦ MolecularDynamics.Chapter06Review.bathHamiltonian μ U Q P v p) q (Pi.single i 1) = (Q-q i)/(k : ℝ)) := by
  sorry

/-- source_id: MD-6.3.3-BathFrequency · definition · §6.3.3 · 印刷p.237 / PDFp.258
[EXTRA] [EXTRA]k>0和全部μi>0已编码为真实参数资格。 -/
def bathFrequency {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (i : Fin k) : ℝ := (Real.sqrt ((k : ℝ)*μ i))⁻¹

/-- source_id: MD-6.3.3-BathOscillatorSolution · (6.26) · §6.3.3 · 印刷p.236–237 / PDFp.257–258
[EXTRA] [EXTRA]实际二阶受迫振子ODE、C²q、连续Q及t≥0；显式全部k>0、正μ、原初始动量p0与真实初始化q′0=p0/μ，Ω实际计算为(kμ)⁻¹/²；保留原k⁻¹μ⁻¹卷积系数，不以解公式作前提。 -/
theorem bathOscillatorSolution : ∀ (Q q : ℝ → ℝ) (k : ℕ) (μ p0 t : ℝ),
  0 < k → 0 < μ → ContDiff ℝ 2 q → Continuous Q → 0 ≤ t →
  (deriv q 0=p0/μ) →
  (∀ s ∈ Icc 0 t, deriv (deriv q) s=(Q s-q s)/((k : ℝ)*μ)) →
  let Ω : ℝ := (Real.sqrt ((k : ℝ)*μ))⁻¹
  q t=Real.cos (Ω*t)*q 0+Ω⁻¹*Real.sin (Ω*t)*p0/μ+
    (k : ℝ)⁻¹*μ⁻¹*(∫ s in 0..t, Ω⁻¹*Real.sin (Ω*(t-s))*Q s) := by
  sorry

/-- source_id: MD-6.3.3-BathConvolutionIBP · unnumbered_claim · §6.3.3 · 印刷p.237 / PDFp.258
[EXTRA] [EXTRA]真实C¹ Q和Q′=P；完整实际卷积IBP，不以通量结论作假设。 -/
theorem bathConvolutionIBP :
  ∀ (Q P : ℝ → ℝ) (Ω t : ℝ),
  ContDiff ℝ 1 Q → (∀ s, deriv Q s=P s) → 0 ≤ t →
  (∫ s in 0..t, Ω*Real.sin (Ω*(t-s))*Q s) = Q t-Real.cos (Ω*t)*Q 0 -
    ∫ s in 0..t, Real.cos (Ω*(t-s))*P s := by
  sorry

/-- source_id: MD-6.3.3-BathForce · definition · §6.3.3 · 印刷p.237 / PDFp.258
[EXTRA] [EXTRA]按(6.23)推导得到正k⁻¹实际合力；原页负号与+f项冲突，字面版本另列；不宣称更正已由网站裁定。
[EXTRA] [EXTRA]k>0和全部μi>0已编码，排除非物理逆质量/频率总化值。 -/
def bathForce {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (q0 p0 : MolecularDynamics.Chapter06Review.V k) (Q0 t : ℝ) : ℝ :=
  (k : ℝ)⁻¹ * ∑ i, (Real.cos (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)*(q0 i-Q0) +
    (MolecularDynamics.Chapter06Review.bathFrequency μ i)⁻¹ * Real.sin (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)*p0 i/μ i)

/-- 修正版，对应原文 MD-6.3.3-BathForcePrinted；改动：选择正的初值合力f，使(6.29)保留+f；等价选项是保留原f并将(6.29)改为−f。 -/
def bathForcePrinted_corrected {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (q0 p0 : MolecularDynamics.Chapter06Review.V k) (Q0 t : ℝ) : ℝ :=
  (k : ℝ)⁻¹ * ∑ i, (Real.cos (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)*(q0 i-Q0) +
    (MolecularDynamics.Chapter06Review.bathFrequency μ i)⁻¹ * Real.sin (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)*p0 i/μ i)

/-- source_id: MD-6.3.3-BathForcePrinted · definition · §6.3.3 · 印刷p.237 / PDFp.258
[EXTRA] [EXTRA]保持原物理k>0与全部μi>0资格；字面符号仍待裁定。
[ERRATUM?] 印刷f含负k⁻¹，而(6.29)写+f；从(6.23)代入振子解得到正k⁻¹合力。 -/
def bathForcePrinted {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (q0 p0 : MolecularDynamics.Chapter06Review.V k) (Q0 t : ℝ) : ℝ := -MolecularDynamics.Chapter06Review.bathForce μ q0 p0 Q0 t

/-- source_id: MD-6.3.3-MemoryKernel · definition · §6.3.3 · 印刷p.237 / PDFp.258
[EXTRA] [EXTRA]实际k>0与全部μi>0参数资格。 -/
def memoryKernel {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (t : ℝ) : ℝ :=
  (k : ℝ)⁻¹ * ∑ i, Real.cos (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)

/-- source_id: MD-6.3.3-BathReduction · unnumbered_claim · §6.3.3 · 印刷p.237 / PDFp.258
[EXTRA] [EXTRA]保留全部原Hamilton ODE与初值、正质量、真实卷积，按导出正k⁻¹合力；不将约化等式作前提。 -/
theorem bathReduction :
  ∀ {k : ℕ} (μ : MolecularDynamics.Chapter06Review.V k) (U Q P : ℝ → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter06Review.V k) (t : ℝ), 0 < k → (∀ i, 0 < μ i) → 0 ≤ t →
  ContDiff ℝ 2 Q → ContDiff ℝ 2 q →
  (∀ s, deriv Q s=P s) → (∀ s, deriv P s = -deriv U (Q s)-(∑ i : Fin k, (Q s - q s i))/(k : ℝ)) →
  (∀ i s, deriv (fun u ↦ q u i) s=p s i/μ i) →
  (∀ i s, deriv (deriv (fun u ↦ q u i)) s=(Q s-q s i)/((k : ℝ)*μ i)) →
  deriv P t = -deriv U (Q t)+MolecularDynamics.Chapter06Review.bathForce μ (q 0) (p 0) (Q 0) t -
    ∫ s in 0..t, MolecularDynamics.Chapter06Review.memoryKernel μ (t-s)*P s := by
  sorry

/-- 修正版，对应原文 MD-6.3.3-BathReductionPrinted；改动：使用从原Hamilton方程实际代入所得的正合力卷积方程。 -/
theorem bathReductionPrinted_corrected :
  ∀ {k : ℕ} (μ : MolecularDynamics.Chapter06Review.V k) (U Q P : ℝ → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter06Review.V k) (t : ℝ), 0 < k → (∀ i, 0 < μ i) → 0 ≤ t →
  ContDiff ℝ 2 Q → ContDiff ℝ 2 q →
  (∀ s, deriv Q s=P s) → (∀ s, deriv P s = -deriv U (Q s)-(∑ i : Fin k, (Q s - q s i))/(k : ℝ)) →
  (∀ i s, deriv (fun u ↦ q u i) s=p s i/μ i) →
  (∀ i s, deriv (deriv (fun u ↦ q u i)) s=(Q s-q s i)/((k : ℝ)*μ i)) →
  deriv P t = -deriv U (Q t)+MolecularDynamics.Chapter06Review.bathForce μ (q 0) (p 0) (Q 0) t -
    ∫ s in 0..t, MolecularDynamics.Chapter06Review.memoryKernel μ (t-s)*P s := by
  sorry

/-- source_id: MD-6.3.3-BathReductionPrinted · unnumbered_claim · §6.3.3 · 印刷p.237 / PDFp.258
[ERRATUM?] 原负f与+f约化式符号冲突；保留完整字面卷积方程。 -/
theorem bathReductionPrinted :
  ∀ {k : ℕ} (μ : MolecularDynamics.Chapter06Review.V k) (U Q P : ℝ → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter06Review.V k) (t : ℝ), 0 < k → (∀ i, 0 < μ i) → 0 ≤ t →
  ContDiff ℝ 2 Q → ContDiff ℝ 2 q →
  (∀ s, deriv Q s=P s) → (∀ s, deriv P s = -deriv U (Q s)-(∑ i : Fin k, (Q s - q s i))/(k : ℝ)) →
  (∀ i s, deriv (fun u ↦ q u i) s=p s i/μ i) →
  (∀ i s, deriv (deriv (fun u ↦ q u i)) s=(Q s-q s i)/((k : ℝ)*μ i)) →
  deriv P t = -deriv U (Q t)+MolecularDynamics.Chapter06Review.bathForcePrinted μ (q 0) (p 0) (Q 0) t -
    ∫ s in 0..t, MolecularDynamics.Chapter06Review.memoryKernel μ (t-s)*P s := by
  sorry

/-- source_id: MD-6.3.3-MemoryKernelDeltaMeaning · definition · §6.3.3 · 印刷p.238 / PDFp.259
[EXTRA] [EXTRA]明确ηk→γδ0的实际分布意义，仅定义该近似资格；不计极限或Langevin推导已证。
[ERRATUM?] 原“sufficient high frequency/typically”没有给频率序列、归一化、热浴初值法则及白噪声弱收敛资格，不能声明任意热浴自动满足δ极限。 -/
def memoryKernelDeltaMeaning (masses : (k : ℕ) → (Fin k → ℝ)) (γ : ℝ) : Prop :=
  0 < γ ∧ ∀ f : ℝ → ℝ, ContDiff ℝ ∞ f → HasCompactSupport f →
    Tendsto (fun k ↦ ∫ t, MolecularDynamics.Chapter06Review.memoryKernel (masses k) t*f t)
      atTop (𝓝 (γ*f 0))

/-- 修正版，对应原文 MD-6.3.3-MemoryKernelDeltaMeaning；改动：仅给分布收敛的精确定义，并明确正质量资格；不声称任意热浴满足该极限。 -/
def memoryKernelDeltaMeaning_corrected (masses : (k : ℕ) → (Fin k → ℝ)) (γ : ℝ) : Prop :=
  (∀ k, ∀ i, 0 < masses k i) ∧ 0 < γ ∧ ∀ f : ℝ → ℝ, ContDiff ℝ ∞ f → HasCompactSupport f →
    Tendsto (fun k ↦ ∫ t, MolecularDynamics.Chapter06Review.memoryKernel (masses k) t*f t)
      atTop (𝓝 (γ*f 0))

/-- source_id: MD-6.3.3-ScalarLangevin · definition · §6.3.3 · 印刷p.238 / PDFp.259
[EXTRA] [EXTRA]真实耦合随机Q(t,sample)及动量漂移、实际可积性、初值与严格Ito积分；无任意样本代替随机状态。
[EXTRA] [EXTRA]明确真正Wiener driver及当前全域C∞势（Γ模型还要求Γ C∞）的充分技术范围，全部实际漂移可积；不是把不可微梯度或非可积Bochner默认值当经典过程，不声称此范围覆盖奇异势的正规域版本。 -/
def scalarLangevin {Ω : Type*} [MeasurableSpace Ω] (law : Measure Ω)
    (W Q momentum : ℝ → Ω → ℝ) (U : ℝ → ℝ) (γ σ q0 p0 : ℝ) : Prop :=
  0 < γ ∧ ContDiff ℝ ∞ U ∧
  textbookIsWienerVector (fun t sample (_i : Fin 1) ↦ W t sample) law ∧
  (∀ᵐ sample ∂law, ContinuousOn (fun t ↦ Q t sample) (Ici 0) ∧
    ContinuousOn (fun t ↦ momentum t sample) (Ici 0) ∧ momentum 0 sample=p0 ∧ ∀ T : ℝ, 0 ≤ T →
    IntervalIntegrable (fun s ↦ momentum s sample) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -deriv U (Q s sample)-γ*momentum s sample) volume 0 T ∧
    Q T sample=q0+∫ s in 0..T, momentum s sample) ∧
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral law W (fun _ _ ↦ σ) T
    (fun sample ↦ momentum T sample-p0-∫ s in 0..T, -deriv U (Q s sample)-γ*momentum s sample)

/-- source_id: MD-6.3.3-MassLangevin · (6.32)–(6.33) · §6.3.3 · 印刷p.239 / PDFp.260
[EXTRA] [EXTRA]明确真正Wiener driver及当前全域C∞势（Γ模型还要求Γ C∞）的充分技术范围，全部实际漂移可积；不是把不可微梯度或非可积Bochner默认值当经典过程，不声称此范围覆盖奇异势的正规域版本。 -/
def langevinMassSDE {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → MolecularDynamics.Chapter06Review.V n) (X : ℝ → Ω → MolecularDynamics.Chapter06Review.Phase n) (m : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (γ θ : ℝ) (x0 : MolecularDynamics.Chapter06Review.Phase n) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ ∞ U ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧ (∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T →
    IntervalIntegrable (fun s ↦ fun i ↦ (m i)⁻¹*(X s sample).2 i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ fun i ↦ -textbookConfigurationPartial U i (X s sample).1-
      γ*(X s sample).2 i) volume 0 T) ∧
  ∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ ∀ t ∈ Ici 0,
    (X t sample).1 = x0.1 + (∫ s in 0..t, fun i ↦ (m i)⁻¹ * (X s sample).2 i) ∧
    (X t sample).2 = x0.2 + (∫ s in 0..t, fun i ↦
      -textbookConfigurationPartial U i (X s sample).1 - γ*(X s sample).2 i) +
      fun i ↦ Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i)

/-- source_id: MD-6.3.3-VariableFriction · (6.34)–(6.35) · §6.3.3 · 印刷p.239 / PDFp.260
[EXTRA] [EXTRA]完整任意矩形Γ(q)、任意质量和真实全部噪声坐标严格Ito积分；未缩成对角或单位质量，不宣称自动Gibbs不变。
[EXTRA] [EXTRA]明确真正Wiener driver及当前全域C∞势（Γ模型还要求Γ C∞）的充分技术范围，全部实际漂移可积；不是把不可微梯度或非可积Bochner默认值当经典过程，不声称此范围覆盖奇异势的正规域版本。 -/
def variableFriction {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → ((Fin n → ℝ) × (Fin n → ℝ)))
    (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ)
    (x0 : (Fin n → ℝ) × (Fin n → ℝ)) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < θ ∧ ContDiff ℝ ∞ U ∧ ContDiff ℝ ∞ Γ ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0 ∧
    ∀ T : ℝ, 0 ≤ T → IntervalIntegrable (fun s ↦ fun i ↦ (m i)⁻¹*(X s sample).2 i) volume 0 T ∧
      (X T sample).1=x0.1+∫ s in 0..T, fun i ↦ (m i)⁻¹*(X s sample).2 i) ∧
  ∀ i : Fin n, ∀ T : ℝ, 0 ≤ T →
    ∃ integrals : Fin r → Ω → ℝ,
      (∀ j, strictItoIntegral P (fun s sample ↦ W s sample j)
        (fun s sample ↦ Real.sqrt (2*θ*m i)*Γ (X s sample).1 i j) T (integrals j)) ∧
      (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ -textbookConfigurationPartial U i (X s sample).1-
          ((Γ (X s sample).1*(Γ (X s sample).1).transpose).mulVec (X s sample).2) i) volume 0 T ∧
        (X T sample).2 i-x0.2 i-(∫ s in 0..T, -textbookConfigurationPartial U i (X s sample).1-
          ((Γ (X s sample).1*(Γ (X s sample).1).transpose).mulVec (X s sample).2) i)=∑ j, integrals j sample)

/-- source_id: MD-6.3.3-ParticleDiagonalFriction · definition · §6.3.3 · 印刷p.239 / PDFp.260 -/
def particleDiagonalFriction {N : ℕ} (γ : Fin N → (Fin (N*3) → ℝ) → ℝ)
    (q : Fin (N*3) → ℝ) : Matrix (Fin (N*3)) (Fin (N*3)) ℝ :=
  Matrix.diagonal (fun i ↦ γ ⟨i.val/3, by omega⟩ q)

/-- source_id: MD-6.3.4-BrownianMassModel · (6.36) · §6.3.4 · 印刷p.240 / PDFp.261
[EXTRA] [EXTRA]明确真正Wiener driver及当前全域C∞势（Γ模型还要求Γ C∞）的充分技术范围，全部实际漂移可积；不是把不可微梯度或非可积Bochner默认值当经典过程，不声称此范围覆盖奇异势的正规域版本。 -/
def brownianMassSDE {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W q : ℝ → Ω → MolecularDynamics.Chapter06Review.V n) (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (γ θ : ℝ) (q0 : MolecularDynamics.Chapter06Review.V n) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ ∞ U ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧ (∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T →
    IntervalIntegrable (fun s ↦ fun i ↦ -(γ*m i)⁻¹*textbookConfigurationPartial U i (q s sample))
      volume 0 T) ∧
  ∀ᵐ sample ∂P, ContinuousOn (fun t ↦ q t sample) (Ici 0) ∧ ∀ t ∈ Ici 0,
    q t sample = q0 + (∫ s in 0..t, fun i ↦ -(γ*m i)⁻¹*textbookConfigurationPartial U i (q s sample)) +
      fun i ↦ Real.sqrt (2*θ/(γ*m i))*(W t sample i-W 0 sample i)

/-- source_id: MD-6.3.3-FrequencyMemoryKernel · definition · §6.3.3 · 印刷p.237 / PDFp.258
[EXTRA] [EXTRA]以实际给定频率直接表达原核，方便记录图6.4/6.5全部数值族；k>0用于物理解释，有限函数定义不计δ极限已证。 -/
def frequencyMemoryKernel {k : ℕ} (Ω : Fin k → ℝ) (t : ℝ) : ℝ :=
  (k : ℝ)⁻¹*∑ i, Real.cos (Ω i*t)

/-- source_id: MD-6.3.3-Figure64Frequencies · Fig. 6.4 · §6.3.3 · 印刷p.238 / PDFp.259
[EXTRA] [EXTRA]Fin下标val+1恢复原i=1,…,k；长度1区间限制Lebesgue测度是U[0,1]，记录原边际law，未擅加原未明说的独立性。green/10完整表示10×Uniform频率。图中核使用前条实际频率求和定义。 -/
def figure64Frequencies {A : Type*} [MeasurableSpace A] (P : Measure A)
    (blue : Fin 400 → ℝ) (red green : Fin 1000 → A → ℝ) : Prop :=
  (∀ i, blue i=(1/100 : ℝ)*(i.val+1)) ∧
  (∀ i, HasLaw (red i) (volume.restrict (Icc (0 : ℝ) 1)) P) ∧
  ∀ i, HasLaw (fun sample ↦ green i sample/10) (volume.restrict (Icc (0 : ℝ) 1)) P

/-- source_id: MD-6.3.3-Figure65Frequencies · Fig. 6.5 · §6.3.3 · 印刷p.238 / PDFp.259
[EXTRA] [EXTRA]两个原数列分别7/10项、完整全部频率及随机边际；Fin下标+1；不把绘图外观当严格极限定理。 -/
def figure65Frequencies {A : Type*} [MeasurableSpace A] (P : Measure A)
    (left : (k : ℕ) → Fin k → ℝ) (center right : (k : ℕ) → Fin k → A → ℝ) : Prop :=
  (∀ j ∈ Finset.range 7, ∀ i : Fin ((5*(j+1))^2),
    left ((5*(j+1))^2) i=(i.val+1 : ℝ)/Real.sqrt ((5*(j+1))^2 : ℕ)) ∧
  (∀ j ∈ Finset.range 10, ∀ i : Fin (10*(j+1)),
    HasLaw (fun sample ↦ center (10*(j+1)) i sample/Real.sqrt (10*(j+1) : ℕ))
      (volume.restrict (Icc (0 : ℝ) 1)) P) ∧
  ∀ j ∈ Finset.range 10, ∀ i : Fin (10*(j+1)),
    HasLaw (fun sample ↦ right (10*(j+1)) i sample/(10*(j+1) : ℕ))
      (volume.restrict (Icc (0 : ℝ) 1)) P

/-- source_id: MD-6.3.3-BathForceWeakLimitMeaning · definition · §6.3.3 · 印刷p.237–238 / PDFp.258–259
[EXTRA] [EXTRA]完整连续路径空间的弱法则，而非只收敛均值/某单时边际；实际有限热浴力路径与Wiener路径逐点关联，只定义原希望的资格，不宣称任意族满足。
[ERRATUM?] 原many choices没有给热浴初值法则/频率条件/拓扑；此处f像Wiener process、下页f(t)作为Wiener increment还存在力与积分过程的类型疑问。 -/
def bathForceWeakLimitMeaning {A : Type*} [MeasurableSpace A] (P : Measure A)
    (masses : (k : ℕ) → Fin k → ℝ) (q0 p0 : (k : ℕ) → A → (Fin k → ℝ))
    (Q0 : ℝ) (W : ℝ → A → ℝ)
    (forcePaths : (k : ℕ) → (T : ℝ) → A → C(Icc (0 : ℝ) T, ℝ))
    (wienerPaths : (T : ℝ) → A → C(Icc (0 : ℝ) T, ℝ)) : Prop :=
  IsPreBrownianReal (fun t sample ↦ W t sample) P ∧
  (∀ k, 0 < k → ∀ i, 0 < masses k i) ∧
  (∀ k T sample s, forcePaths k T sample s =
    MolecularDynamics.Chapter06Review.bathForcePrinted (masses k) (q0 k sample) (p0 k sample) Q0 s) ∧
  (∀ T sample s, wienerPaths T sample s=W s sample) ∧
  ∀ T : ℝ, 0 < T → ∀ f : C(Icc (0 : ℝ) T, ℝ) → ℝ,
    Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun k ↦ ∫ sample, f (forcePaths k T sample) ∂P) atTop
      (𝓝 (∫ sample, f (wienerPaths T sample) ∂P))

/-- 修正版，对应原文 MD-6.3.3-BathForceWeakLimitMeaning；改动：将与Wiener过程比较的对象改为时间积分后的热浴力；仍只定义极限意义。 -/
def bathForceWeakLimitMeaning_corrected {A : Type*} [MeasurableSpace A] (P : Measure A)
    (masses : (k : ℕ) → Fin k → ℝ) (q0 p0 : (k : ℕ) → A → (Fin k → ℝ))
    (Q0 : ℝ) (W : ℝ → A → ℝ)
    (forcePaths : (k : ℕ) → (T : ℝ) → A → C(Icc (0 : ℝ) T, ℝ))
    (wienerPaths : (T : ℝ) → A → C(Icc (0 : ℝ) T, ℝ)) : Prop :=
  IsPreBrownianReal (fun t sample ↦ W t sample) P ∧
  (∀ k, 0 < k → ∀ i, 0 < masses k i) ∧
  (∀ k T sample s, forcePaths k T sample s =
    ∫ u in (0 : ℝ)..(s : ℝ), MolecularDynamics.Chapter06Review.bathForce (masses k) (q0 k sample) (p0 k sample) Q0 u) ∧
  (∀ T sample s, wienerPaths T sample s=W s sample) ∧
  ∀ T : ℝ, 0 < T → ∀ f : C(Icc (0 : ℝ) T, ℝ) → ℝ,
    Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun k ↦ ∫ sample, f (forcePaths k T sample) ∂P) atTop
      (𝓝 (∫ sample, f (wienerPaths T sample) ∂P))

/-- source_id: MD-6.3.4-OverdampedLimit · unnumbered_claim · §6.3.4 · 印刷p.240 / PDFp.261
[EXTRA] [EXTRA]全部正对角质量、正β、光滑周期U，原热浴路径模型；高γ需按γT观察，完整任意有界连续检验弱极限，没有把极限本身作前提。 -/
theorem overdampedLimit : ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (B : ℝ≥0 → Ω → (Fin n → ℝ)) (m : Fin n → ℝ)
    (U : (Fin n → ℝ) → ℝ) (β : ℝ) (x0 : (Fin n → ℝ) × (Fin n → ℝ))
    (X : ℝ → ℝ → Ω → ((Fin n → ℝ) × (Fin n → ℝ))) (q : ℝ → Ω → (Fin n → ℝ)),
  textbookIsWienerVector B P → (∀ i, 0 < m i) → ContDiff ℝ ∞ U →
  textbookUnitPeriodicPotential U → 0 < β →
  (∀ γ : ℝ, 0 < γ → MolecularDynamics.Chapter06Review.langevinMassSDE P
    (fun t sample ↦ B t.toNNReal sample) (X γ) m U γ β⁻¹ x0) →
  MolecularDynamics.Chapter06Review.brownianMassSDE P (fun t sample ↦ B t.toNNReal sample) q m U 1 β⁻¹ x0.1 →
  ∀ T : ℝ, 0 < T → ∀ f : (Fin n → ℝ) → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun γ : ℝ ↦ ∫ sample, f (X γ (γ*T) sample).1 ∂P) atTop
      (𝓝 (∫ sample, f (q T sample) ∂P)) := by
  sorry

/-- source_id: MD-6.3.5-ScalarGenerator · (6.38) · §6.3.5 · 印刷p.240 / PDFp.261 -/
def scalarGenerator (a b f : ℝ → ℝ) (x : ℝ) : ℝ := a x*deriv f x + b x^2/2*deriv (deriv f) x

/-- source_id: MD-6.3.5-GeneratorExpectation · (6.37) · §6.3.5 · 印刷p.240 / PDFp.261
[EXTRA] [EXTRA]真实严格SDE、C²φ、适应平方可积资格、Lφ实际可积且时间期望连续；完整期望时间导数，不只定义L。
[EXTRA] [EXTRA]自然Wiener历史适应、联合可测X、C¹a/b及Lφ在每个有限时间×样本上的绝对可积资格，保证实际Fubini；有符号期望连续不自动蕴含此资格。 -/
theorem generatorExpectation :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (a b φ : ℝ → ℝ) (x0 : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X (fun x _ ↦ a x) (fun x _ ↦ b x) x0 →
  ContDiff ℝ 1 a → ContDiff ℝ 1 b → ContDiff ℝ 2 φ → MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample)) →
  (∀ t : ℝ, 0 ≤ t → Integrable (fun sample ↦ MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X t sample)) P) →
  ContinuousOn (fun t ↦ ∫ sample, MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X t sample) ∂P) (Ici 0) →
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) →
  Measurable (Function.uncurry X) →
  (∀ T : ℝ, 0 ≤ T → Integrable
    (fun w : ℝ × Ω ↦ |MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X w.1 w.2)|)
    ((volume.restrict (Icc 0 T)).prod P)) →
  ∀ t : ℝ, 0 < t → HasDerivAt (fun s ↦ ∫ sample, φ (X s sample) ∂P)
    (∫ sample, MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X t sample) ∂P) t := by
  sorry

/-- source_id: MD-6.3.6-PolynomialSmooth · definition · §6.3.6 · 印刷p.241 / PDFp.262 -/
def polynomialSmooth (f : ℝ → ℝ) : Prop :=
  ContDiff ℝ ∞ f ∧ ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |f x| ≤ C*(1+|x|)^r

/-- source_id: MD-6.3.6-DensityExpectation · unnumbered_claim · §6.3.6 · 印刷p.241 / PDFp.262
[EXTRA] [EXTRA]真实非负可测density与全局指数尾界；完整可积与积分law等式，不预置这些结论。 -/
theorem densityExpectation : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (X : Ω → ℝ) (ρ φ : ℝ → ℝ),
  HasLaw X (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ x))) P →
  (∀ x, 0 ≤ ρ x) → Measurable ρ → MolecularDynamics.Chapter06Review.polynomialSmooth φ →
  (∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x, ρ x ≤ C*Real.exp (-c*|x|)) →
  Integrable (fun sample ↦ φ (X sample)) P ∧
    (∫ sample, φ (X sample) ∂P)=(∫ x, φ x*ρ x) := by
  sorry

/-- source_id: MD-6.3.6-ScalarForward · definition · §6.3.6 · 印刷p.242 / PDFp.263 -/
def scalarForward (a b ρ : ℝ → ℝ) (x : ℝ) : ℝ :=
  -deriv (fun z ↦ a z*ρ z) x + deriv (deriv (fun z ↦ b z^2*ρ z)) x/2

/-- source_id: MD-6.3.6-FPDriftAdjoint · unnumbered_claim · §6.3.6 · 印刷p.241–242 / PDFp.262–263
[EXTRA] [EXTRA]当前完整紧支撑C¹检验桥接；原指数尾和多项式检验的全域版本在FPPolynomialAdjoint保留，不将紧支撑特例计为原全部检验已证。 -/
theorem fpDriftAdjoint :
  ∀ (a ρ φ : ℝ → ℝ),
  ContDiff ℝ 1 a → ContDiff ℝ 1 ρ → ContDiff ℝ 1 φ →
  HasCompactSupport φ → (∫ x, a x*deriv φ x*ρ x) = ∫ x, φ x*(-deriv (fun z ↦ a z*ρ z) x) := by
  intro a ρ φ ha hρ hφ hc
  have hg : ContDiff ℝ 1 (fun x ↦ a x*ρ x) := ha.mul hρ
  have hi1 : Integrable (fun x ↦ (a x*ρ x)*deriv φ x) :=
    (hg.continuous.mul hφ.continuous_deriv_one).integrable_of_hasCompactSupport hc.deriv.mul_left
  have hi2 : Integrable (fun x ↦ deriv (fun z ↦ a z*ρ z) x*φ x) :=
    (hg.continuous_deriv_one.mul hφ.continuous).integrable_of_hasCompactSupport hc.mul_left
  have hi3 : Integrable (fun x ↦ (a x*ρ x)*φ x) :=
    (hg.continuous.mul hφ.continuous).integrable_of_hasCompactSupport hc.mul_left
  have he := MeasureTheory.integral_mul_deriv_eq_deriv_mul_of_integrable
    (u := fun x ↦ a x*ρ x) (v := φ)
    (fun x _ ↦ (hg.differentiable_one x).hasDerivAt)
    (fun x _ ↦ (hφ.differentiable_one x).hasDerivAt) hi1 hi2 hi3
  simpa only [Pi.mul_apply, mul_comm, mul_left_comm, mul_assoc, mul_neg, integral_neg] using he

/-- source_id: MD-6.3.6-FPDiffusionPrinted · unnumbered_claim · §6.3.6 · 印刷p.242 / PDFp.263
[ERRATUM?] 原页两次IBP后仍打印负号；正确应正号，且(6.39)最终算子已经使用正号。 -/
theorem fpDiffusionPrinted : ∀ (b ρ φ : ℝ → ℝ),
  ContDiff ℝ 2 b → ContDiff ℝ 2 ρ → ContDiff ℝ 2 φ → HasCompactSupport φ →
  (∫ x, b x^2*deriv (deriv φ) x*ρ x)=
    -(∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) := by
  sorry

/-- 修正版，对应原文 MD-6.3.6-FPDiffusionPrinted；改动：仅将两次分部积分后的外负号改为正号，保留原C²和紧支资格。 -/
theorem fpDiffusionPrinted_corrected : ∀ (b ρ φ : ℝ → ℝ),
  ContDiff ℝ 2 b → ContDiff ℝ 2 ρ → ContDiff ℝ 2 φ → HasCompactSupport φ →
  (∫ x, b x^2*deriv (deriv φ) x*ρ x)=
    (∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) := by
  intro b ρ φ hb hρ hφ hc
  have ibp : ∀ (g f : ℝ → ℝ), ContDiff ℝ 1 g → ContDiff ℝ 1 f → HasCompactSupport f →
      (∫ x, g x*deriv f x)=-(∫ x, deriv g x*f x) := by
    intro g f hg hf hs
    have he := fpDriftAdjoint g (fun _ ↦ 1) f hg contDiff_const hf hs
    simpa only [mul_one, mul_neg, integral_neg, mul_comm] using he
  have hG : ContDiff ℝ 2 (fun x ↦ b x^2*ρ x) := (hb.pow 2).mul hρ
  have hG1 : ContDiff ℝ 1 (fun x ↦ b x^2*ρ x) := hG.of_le (by norm_num)
  have hφ1 : ContDiff ℝ 1 φ := hφ.of_le (by norm_num)
  have h1 := ibp (fun x ↦ b x^2*ρ x) (deriv φ) hG1 hφ.deriv' hc.deriv
  have h2 := ibp (deriv (fun x ↦ b x^2*ρ x)) φ hG.deriv' hφ1 hc
  calc
    _ = (∫ x, (b x^2*ρ x)*deriv (deriv φ) x) := by
      apply integral_congr_ae
      filter_upwards [] with x
      ring
    _ = _ := by
      rw [h1,h2,neg_neg]
      apply integral_congr_ae
      filter_upwards [] with x
      ring

/-- source_id: MD-6.3.6-FPAdjointCompact · unnumbered_claim · §6.3.6 · 印刷p.242 / PDFp.263
[EXTRA] [EXTRA]紧支撑C²检验的完整正号伴随恒等；多项式检验及指数尾版本另条保留。 -/
theorem fpAdjointCompact :
  ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ 2 a → ContDiff ℝ 2 b → ContDiff ℝ 2 ρ → ContDiff ℝ 2 φ →
  HasCompactSupport φ → (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x) = ∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x := by
  intro a b ρ φ ha hb hρ hφ hc
  have ha1 : ContDiff ℝ 1 a := ha.of_le (by norm_num)
  have hρ1 : ContDiff ℝ 1 ρ := hρ.of_le (by norm_num)
  have hφ1 : ContDiff ℝ 1 φ := hφ.of_le (by norm_num)
  have hG : ContDiff ℝ 2 (fun x ↦ b x^2*ρ x) := (hb.pow 2).mul hρ
  have hG1 : ContDiff ℝ 1 (fun x ↦ b x^2*ρ x) := hG.of_le (by norm_num)
  have ibp : ∀ (g f : ℝ → ℝ), ContDiff ℝ 1 g → ContDiff ℝ 1 f → HasCompactSupport f →
      (∫ x, g x*deriv f x)=-(∫ x, deriv g x*f x) := by
    intro g f hg hf hs
    have he := fpDriftAdjoint g (fun _ ↦ 1) f hg contDiff_const hf hs
    simpa only [mul_one, mul_neg, integral_neg, mul_comm] using he
  have hh1 := ibp (fun x ↦ b x^2*ρ x) (deriv φ) hG1 hφ.deriv' hc.deriv
  have hh2 := ibp (deriv (fun x ↦ b x^2*ρ x)) φ hG.deriv' hφ1 hc
  have hdiff : (∫ x, (b x^2*ρ x)*deriv (deriv φ) x)=
      (∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) := by
    rw [hh1, hh2, neg_neg]
    congr 1
    funext x
    ring
  have hD := fpDriftAdjoint a ρ φ ha1 hρ1 hφ1 hc
  have hiA : Integrable (fun x ↦ a x*deriv φ x*ρ x) :=
    ((ha.continuous.mul hφ1.continuous_deriv_one).mul hρ.continuous).integrable_of_hasCompactSupport hc.deriv.mul_left.mul_right
  have hiB : Integrable (fun x ↦ (b x^2*ρ x)*deriv (deriv φ) x) :=
    (hG.continuous.mul hφ.deriv'.continuous_deriv_one).integrable_of_hasCompactSupport hc.deriv.deriv.mul_left
  have hiC : Integrable (fun x ↦ φ x*(-deriv (fun z ↦ a z*ρ z) x)) :=
    (hφ.continuous.mul (ha1.mul hρ1).continuous_deriv_one.neg).integrable_of_hasCompactSupport hc.mul_right
  have hiE : Integrable (fun x ↦ φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) :=
    (hφ.continuous.mul hG.deriv'.continuous_deriv_one).integrable_of_hasCompactSupport hc.mul_right
  have hleft : (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x)=
      (∫ x, a x*deriv φ x*ρ x)+(1/2 : ℝ)*(∫ x, (b x^2*ρ x)*deriv (deriv φ) x) := by
    rw [← integral_const_mul, ← integral_add hiA (hiB.const_mul (1/2))]
    apply integral_congr_ae
    filter_upwards [] with x
    dsimp [MolecularDynamics.Chapter06Review.scalarGenerator]
    ring
  have hright : (∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x)=
      (∫ x, φ x*(-deriv (fun z ↦ a z*ρ z) x))+
        (1/2 : ℝ)*(∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) := by
    rw [← integral_const_mul, ← integral_add hiC (hiE.const_mul (1/2))]
    apply integral_congr_ae
    filter_upwards [] with x
    dsimp [MolecularDynamics.Chapter06Review.scalarForward]
    ring
  rw [hleft, hright, hD, hdiff]

/-- source_id: MD-6.3.6-FPPolynomialAdjoint · unnumbered_claim · §6.3.6 · 印刷p.241–242 / PDFp.262–263
[EXTRA] [EXTRA]原C∞P值增长不足以控制所有IBP边界；明确一、二阶a,b,φ多项式增长及ρ导数指数尾，保存整个非紧支撑真实积分恒等。
[ERRATUM?] 原只给函数值尾部增长而未约束导数；完整IBP及边界消失需技术资格，已全部明示，不静默添加。 -/
theorem fpPolynomialAdjoint : ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ ρ → ContDiff ℝ ∞ φ →
  (∀ f ∈ ({a,b,φ} : Set (ℝ → ℝ)), ∀ k : ℕ, k ≤ 2 →
    ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |iteratedDeriv k f x| ≤ C*(1+|x|)^r) →
  (∀ k : ℕ, k ≤ 2 → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x,
    |iteratedDeriv k ρ x| ≤ C*Real.exp (-c*|x|)) →
  (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x)=
    (∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x) := by
  sorry

/-- 修正版，对应原文 MD-6.3.6-FPPolynomialAdjoint；改动：显式约束所需导数的多项式增长和密度导数的指数衰减。 -/
theorem fpPolynomialAdjoint_corrected : ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ ρ → ContDiff ℝ ∞ φ →
  (∀ f ∈ ({a,b,φ} : Set (ℝ → ℝ)), ∀ k : ℕ, k ≤ 2 →
    ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |iteratedDeriv k f x| ≤ C*(1+|x|)^r) →
  (∀ k : ℕ, k ≤ 2 → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x,
    |iteratedDeriv k ρ x| ≤ C*Real.exp (-c*|x|)) →
  (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x)=
    (∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x) := by
  sorry

/-- 【原书疑误】仅函数值增长条件的字面伴随断言；不证。 -/
theorem fpPolynomialAdjointPrinted : ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ ρ → ContDiff ℝ ∞ φ →
  (∀ f ∈ ({a,b,φ} : Set (ℝ → ℝ)), ∀ k : ℕ, k = 0 →
    ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |iteratedDeriv k f x| ≤ C*(1+|x|)^r) →
  (∀ k : ℕ, k = 0 → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x,
    |iteratedDeriv k ρ x| ≤ C*Real.exp (-c*|x|)) →
  (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x)=
    (∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x) := by
  sorry

/-- source_id: MD-6.3.6-FPEquation · unnumbered_claim · §6.3.6 · 印刷p.242 / PDFp.263
[EXTRA] [EXTRA]实际严格SDE与其真实平滑非负密度law、局部一致指数尾可求导资格；没有把弱PDE或所求点态PDE当假设。 -/
theorem fpEquation : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ) (x0 : ℝ) (ρ : ℝ → ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P →
  strictScalarSDE P W X (fun x _ ↦ a x) (fun x _ ↦ b x) x0 →
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ (Function.uncurry ρ) →
  (∀ t : ℝ, 0 < t → (∀ x, 0 ≤ ρ t x) ∧
    HasLaw (X t) (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ t x))) P) →
  (∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |a x|+|b x| ≤ C*(1+|x|)^r) →
  (∀ lo hi : ℝ, 0 < lo → lo ≤ hi → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧
    ∀ t ∈ Icc lo hi, ∀ x, |ρ t x|+|deriv (fun s ↦ ρ s x) t| ≤ C*Real.exp (-c*|x|)) →
  ∀ t x : ℝ, 0 < t → deriv (fun s ↦ ρ s x) t=MolecularDynamics.Chapter06Review.scalarForward a b (ρ t) x := by
  sorry

/-- source_id: MD-6.3.6-ZeroNoise · unnumbered_claim · §6.3.6 · 印刷p.242 / PDFp.263 -/
theorem zeroNoise :
  ∀ (a f ρ : ℝ → ℝ) (x : ℝ),
  MolecularDynamics.Chapter06Review.scalarGenerator a (fun _ ↦ 0) f x=a x*deriv f x ∧
    MolecularDynamics.Chapter06Review.scalarForward a (fun _ ↦ 0) ρ x = -deriv (fun z ↦ a z*ρ z) x := by
  intro a f ρ x
  constructor
  · simp [MolecularDynamics.Chapter06Review.scalarGenerator]
  · simp [MolecularDynamics.Chapter06Review.scalarForward]

/-- source_id: MD-6.3.7-VectorIto · (6.40)–(6.41) · §6.3.7 · 印刷p.243 / PDFp.264
[EXTRA] [EXTRA]按本节实际常矩阵B范围；真实全部坐标严格Ito积分与Hessian/trace完整校正，未缩成仅漂移定义。 -/
theorem vectorIto : ∀ {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → (Fin n → ℝ)) (B : Matrix (Fin n) (Fin r) ℝ)
    (x0 : Fin n → ℝ) (φ : (Fin n → ℝ) → ℝ),
  textbookIsWienerVector (fun t sample ↦ W t sample) P →
  strictVectorSDE P W X (fun x _ ↦ a x) (fun _ _ ↦ B) x0 → ContDiff ℝ 2 φ →
  (∀ j, MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P (fun t sample ↦ W t sample j)
    (fun t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j))) →
  ∀ T : ℝ, 0 ≤ T → ∃ integrals : Fin r → Ω → ℝ,
    (∀ j, strictItoIntegral P (fun t sample ↦ W t sample j)
      (fun t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j)) T (integrals j)) ∧
    (∀ᵐ sample ∂P, φ (X T sample)-φ x0-
      (∫ s in 0..T, MolecularDynamics.Chapter06Review.vectorGenerator a B φ (X s sample))=∑ j, integrals j sample) := by
  sorry

/-- source_id: MD-6.3.7-VectorForward · definition · §6.3.7 · 印刷p.243 / PDFp.264 -/
def vectorForward {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorForward a B ρ x

/-- 修正版，对应原文 MD-6.4.2-CylinderForwardPrinted；改动：扩散项中的φ″改为ρ″。 -/
def cylinderForwardPrinted_corrected {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorForward a B ρ x

/-- source_id: MD-6.3.7-DiffusionTrace · unnumbered_claim · §6.3.7 · 印刷p.243 / PDFp.264 -/
theorem diffusionTrace :
  ∀ {n r : ℕ} (B : Matrix (Fin n) (Fin r) ℝ)
    (H : Matrix (Fin n) (Fin n) ℝ),
  Matrix.trace (B.transpose*H*B)=∑ i : Fin n, ∑ j : Fin n, (B*B.transpose) i j*H i j := by
  intro n r B H
  rw [Matrix.trace_mul_cycle B.transpose H B, Matrix.trace_mul_cycle B B.transpose H]
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply,
    Finset.mul_sum, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro i hi
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro j hj
  apply Finset.sum_congr rfl
  intro k hk
  ring

/-- source_id: MD-6.3.7-VectorFPEquation · unnumbered_claim · §6.3.7 · 印刷p.243 / PDFp.264
[EXTRA] [EXTRA]真实多维Wiener、严格SDE、完整非负密度law、光滑和局部尾部求导资格；没有将弱PDE结论作假设。 -/
theorem vectorFPEquation : ∀ {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → (Fin n → ℝ)) (B : Matrix (Fin n) (Fin r) ℝ)
    (x0 : Fin n → ℝ) (ρ : ℝ → (Fin n → ℝ) → ℝ),
  textbookIsWienerVector (fun t sample ↦ W t sample) P →
  strictVectorSDE P W X (fun x _ ↦ a x) (fun _ _ ↦ B) x0 →
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ (Function.uncurry ρ) →
  (∀ t : ℝ, 0 < t → (∀ x, 0 ≤ ρ t x) ∧ HasLaw (X t) (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ t x))) P) →
  (∃ C : ℝ, 0 ≤ C ∧ ∃ k : ℕ, ∀ x, ‖a x‖ ≤ C*(1+‖x‖)^k) →
  (∀ lo hi : ℝ, 0 < lo → lo ≤ hi → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧
    ∀ t ∈ Icc lo hi, ∀ x, |ρ t x|+|deriv (fun s ↦ ρ s x) t| ≤ C*Real.exp (-c*‖x‖)) →
  ∀ t x, 0 < t → deriv (fun s ↦ ρ s x) t=vectorForward a B (ρ t) x := by
  sorry

/-- source_id: MD-6.3.8-LangevinMassForward · (6.42) · §6.3.8 · 印刷p.244 / PDFp.265 -/
def langevinMassForward {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (γ β : ℝ)
    (ρ : MolecularDynamics.Chapter06Review.Phase n → ℝ) (x : MolecularDynamics.Chapter06Review.Phase n) : ℝ :=
  ∑ i, (-(m i)⁻¹*x.2 i * fderiv ℝ ρ x (Pi.single i 1,0) +
    fderiv ℝ (fun z : MolecularDynamics.Chapter06Review.Phase n ↦ (textbookConfigurationPartial U i z.1+γ*z.2 i)*ρ z) x (0,Pi.single i 1) +
    γ*β⁻¹*m i*fderiv ℝ (fun z ↦ fderiv ℝ ρ z (0,Pi.single i 1)) x (0,Pi.single i 1))

/-- source_id: MD-6.3.8-MomentumMassLaplacian · definition · §6.3.8 · 印刷p.244 / PDFp.265 -/
def momentumMassLaplacian {n : ℕ} (m : Fin n → ℝ)
    (ρ : ((Fin n → ℝ) × (Fin n → ℝ)) → ℝ) (x : (Fin n → ℝ) × (Fin n → ℝ)) : ℝ :=
  ∑ i, m i*fderiv ℝ (fun y ↦ fderiv ℝ ρ y (0,Pi.single i 1)) x (0,Pi.single i 1)

/-- source_id: MD-6.3.8-LangevinFPEquation · unnumbered_claim · §6.3.8 · 印刷p.244 / PDFp.265
[EXTRA] [EXTRA]真实任意质量Langevin过程和实际非负平滑密度law及求导尾部资格；不以弱PDE或强PDE作假设。 -/
theorem langevinFPEquation : ∀ {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
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
  sorry

/-- source_id: MD-6.4.2-MassGibbsStationary · extra_claim · §6.4.2 · 印刷p.247 / PDFp.268
[EXTRA] [EXTRA]真实任意正质量与匹配β⁻¹噪声；完整原Gibbs权重的形式stationarity验证，不将它计为Markov演化测度不变性。 -/
theorem massGibbsStationary : ∀ {n : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ) (γ β : ℝ),
  (∀ i, 0 < m i) → ContDiff ℝ ∞ U → 0 < γ → 0 < β →
  ∀ x, MolecularDynamics.Chapter06Review.langevinMassForward m U γ β
    (fun z ↦ Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U z)) x=0 := by
  sorry

/-- source_id: MD-6.4.2-UnitMassGibbsStationaryBridge · extra_claim · §6.4.2 · 印刷p.247 / PDFp.268
[EXTRA] [EXTRA]现成真实单位质量原机械Hamiltonian权重、σ²=2γ/β的前向形式表达；未代表任意质量或真实过程测度不变性全部已证。 -/
theorem unitMassGibbsStationaryBridge {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : Differentiable ℝ U) (β γ σ : ℝ) (hβ : 0 < β)
    (hσ : σ ^ 2 = 2 * γ / β) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ σ (textbookLangevinGibbsWeight U β) z = 0 := by
  apply MolecularDynamics.textbookLangevinForwardDifferentialOperator_gibbs_eq_zero <;> assumption

/-- source_id: MD-6.3.3-VariableFrictionForward · extra_claim · §6.3.3 · 印刷p.239 / PDFp.260
[EXTRA] [EXTRA]完整原矩形Γ、任意质量的实际漂移与噪声协方差导出形式前向表达，供验证canonical资格；没有偷换为常矩阵或单位质量。 -/
def variableFrictionForward {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ)
    (ρ : ((Fin n → ℝ) × (Fin n → ℝ)) → ℝ) (x : (Fin n → ℝ) × (Fin n → ℝ)) : ℝ :=
  (∑ i, (-(m i)⁻¹*x.2 i*fderiv ℝ ρ x (Pi.single i 1,0) +
    fderiv ℝ (fun z ↦ (textbookConfigurationPartial U i z.1+
      ((Γ z.1*(Γ z.1).transpose).mulVec z.2) i)*ρ z) x (0,Pi.single i 1))) +
  ∑ i, ∑ k, θ*Real.sqrt (m i)*Real.sqrt (m k)*(Γ x.1*(Γ x.1).transpose) i k *
    fderiv ℝ (fun z ↦ fderiv ℝ ρ z (0,Pi.single k 1)) x (0,Pi.single i 1)

/-- source_id: MD-6.3.3-VariableFrictionCanonicalPrinted · unnumbered_claim · §6.3.3 · 印刷p.239 / PDFp.260
[EXTRA] [EXTRA]该条为原恢复canonical目标的必要形式stationarity检验；完整任意质量/Γ对象保留，不以必要检验计完整采样收敛已证。
[ERRATUM?] 任意ΓΓᵀ与对角质量不交换时，印刷漂移ΓΓᵀp与噪声M½Γ不自动满足Gibbs涨落耗散平衡；原canonical目标不能推广为任意质量/任意矩阵全称定理。 -/
theorem variableFrictionCanonicalPrinted : ∀ {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ),
  (∀ i, 0 < m i) → ContDiff ℝ ∞ U → ContDiff ℝ ∞ Γ → 0 < θ →
  ∀ x, variableFrictionForward m U Γ θ
    (fun z ↦ Real.exp (-θ⁻¹*MolecularDynamics.Chapter06Review.massHamiltonian m U z)) x=0 := by
  sorry

/-- source_id: MD-6.3.3-VariableFrictionCommutingStationary · unnumbered_claim · §6.3.3 · 印刷p.239 / PDFp.260
[EXTRA] [EXTRA]明确ΓΓᵀ与M交换，保留任意维度/矩形Γ及完整Gibbs权重stationarity；未直接假设stationarity或声称采样收敛。 -/
theorem variableFrictionCommutingStationary : ∀ {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ),
  (∀ i, 0 < m i) → ContDiff ℝ ∞ U → ContDiff ℝ ∞ Γ → 0 < θ →
  (∀ q, (Γ q*(Γ q).transpose)*Matrix.diagonal m=Matrix.diagonal m*(Γ q*(Γ q).transpose)) →
  ∀ x, variableFrictionForward m U Γ θ
    (fun z ↦ Real.exp (-θ⁻¹*MolecularDynamics.Chapter06Review.massHamiltonian m U z)) x=0 := by
  sorry

/-- 修正版，对应原文 MD-6.3.3-VariableFrictionCanonicalPrinted；改动：增加ΓΓᵀ与质量矩阵M交换条件；另一个可选修法是修改漂移以匹配噪声协方差。 -/
theorem variableFrictionCanonicalPrinted_corrected : ∀ {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ),
  (∀ i, 0 < m i) → ContDiff ℝ ∞ U → ContDiff ℝ ∞ Γ → 0 < θ →
  (∀ q, (Γ q*(Γ q).transpose)*Matrix.diagonal m=Matrix.diagonal m*(Γ q*(Γ q).transpose)) →
  ∀ x, variableFrictionForward m U Γ θ
    (fun z ↦ Real.exp (-θ⁻¹*MolecularDynamics.Chapter06Review.massHamiltonian m U z)) x=0 := by
  sorry

/-- source_id: MD-6.4.1-StochasticMatrix · definition · §6.4.1 · 印刷p.245 / PDFp.266 -/
def stochasticMatrix {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop :=
  (∀ i j, 0 ≤ PiMark i j) ∧ ∀ i, ∑ j, PiMark i j = 1

/-- source_id: MD-6.4.1-FiniteDistribution · definition · §6.4.1 · 印刷p.245 / PDFp.266
[EXTRA] [EXTRA]概率权重取非负，允许零概率状态；原nonzero作为“typically”的描述而非概率的必要条件，不添加严格正初值要求。
[ERRATUM?] 印刷nonzero应区分典型正权重与一般非负概率；原句完整保留，未声明字面nonzero定义网站PASS。 -/
def finiteDistribution {k : ℕ} (ψ : MolecularDynamics.Chapter06Review.V k) : Prop := (∀ i, 0 ≤ ψ i) ∧ ∑ i, ψ i = 1

/-- 修正版，对应原文 MD-6.4.1-FiniteDistribution；改动：原nonzero单独保留为严格正权重版本；一般定义采用非负权重、总和1。 -/
def finiteDistribution_corrected {k : ℕ} (ψ : MolecularDynamics.Chapter06Review.V k) : Prop := (∀ i, 0 ≤ ψ i) ∧ ∑ i, ψ i = 1

/-- 【原书疑误】保留nonzero按正概率权重的字面版本。 -/
def finiteDistributionPrinted {k : ℕ} (ψ : Fin k → ℝ) : Prop :=
  (∀ i, 0 < ψ i) ∧ ∑ i, ψ i=1

/-- 边界概率向量(1,0)是概率分布，但不满足印刷nonzero权重资格。 -/
theorem finiteDistributionPrinted_counterexample :
    finiteDistribution (fun i : Fin 2 ↦ if i=0 then 1 else 0) ∧
      ¬ finiteDistributionPrinted (fun i : Fin 2 ↦ if i=0 then 1 else 0) := by
  constructor
  · constructor
    · intro i
      dsimp only
      split_ifs <;> norm_num
    · norm_num [Fin.sum_univ_two]
  · intro h
    have hi := h.1 (1 : Fin 2)
    norm_num at hi

/-- source_id: MD-6.4.1-FiniteEvolution · definition · §6.4.1 · 印刷p.245 / PDFp.266 -/
def finiteEvolution {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (ψ : MolecularDynamics.Chapter06Review.V k) (n : ℕ) : MolecularDynamics.Chapter06Review.V k :=
  Matrix.vecMul ψ (PiMark^n)

/-- source_id: MD-6.4.1-FiniteEvolutionRecurrence · unnumbered_claim · §6.4.1 · 印刷p.245 / PDFp.266 -/
theorem finiteEvolutionRecurrence : ∀ {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ)
    (initial : Fin k → ℝ) (n : ℕ),
  MolecularDynamics.Chapter06Review.finiteEvolution matrix initial (n+1)=
    Matrix.vecMul (MolecularDynamics.Chapter06Review.finiteEvolution matrix initial n) matrix := by
  intro k matrix initial n
  simp only [MolecularDynamics.Chapter06Review.finiteEvolution, pow_succ]
  exact (Matrix.vecMul_vecMul initial (matrix^n) matrix).symm

/-- source_id: MD-6.4.1-ReturnTimes · definition · §6.4.1 · 印刷p.245 / PDFp.266
[EXTRA] [EXTRA]真实Πˡ正返回时间l>0，排除0步恒等阵；原gcd周期定义必须如此解读。 -/
def returnTimes {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (i : Fin k) : Set ℕ :=
  {n | 0 < n ∧ 0 < (PiMark^n) i i}

/-- source_id: MD-6.4.1-Period · definition · §6.4.1 · 印刷p.245 / PDFp.266 -/
def period {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (i : Fin k) : ℕ :=
  sSup {d : ℕ | ∀ n ∈ MolecularDynamics.Chapter06Review.returnTimes PiMark i, d ∣ n}

/-- source_id: MD-6.4.1-Aperiodic · definition · §6.4.1 · 印刷p.245 / PDFp.266 -/
def aperiodic {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop := ∀ i, MolecularDynamics.Chapter06Review.period PiMark i = 1

/-- source_id: MD-6.4.1-Irreducible · definition · §6.4.1 · 印刷p.245–246 / PDFp.266–267 -/
def irreducible {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop := ∀ i j, ∃ n : ℕ, 0 < (PiMark^n) i j

/-- source_id: MD-6.4.1-FiniteInvariant · definition · §6.4.1 · 印刷p.246 / PDFp.267 -/
def finiteInvariant {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (ψ : MolecularDynamics.Chapter06Review.V k) : Prop :=
  MolecularDynamics.Chapter06Review.finiteDistribution ψ ∧ Matrix.vecMul ψ PiMark = ψ

/-- source_id: MD-6.4.1-FiniteErgodicity · unnumbered_claim · §6.4.1 · 印刷p.246 / PDFp.267
[EXTRA] [EXTRA]非空真实有限状态、右随机矩阵、全部幂Πⁿ、真实全部初始概率；完整存在、唯一性及任意初值向量收敛，不假设谱隙或收敛结论。 -/
theorem finiteErgodicity :
  ∀ {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ),
  0 < k → MolecularDynamics.Chapter06Review.stochasticMatrix PiMark → MolecularDynamics.Chapter06Review.irreducible PiMark → MolecularDynamics.Chapter06Review.aperiodic PiMark →
  ∃ ψ : MolecularDynamics.Chapter06Review.V k, MolecularDynamics.Chapter06Review.finiteInvariant PiMark ψ ∧ (∀ χ, MolecularDynamics.Chapter06Review.finiteInvariant PiMark χ → χ=ψ) ∧
    ∀ ψ0 : MolecularDynamics.Chapter06Review.V k, MolecularDynamics.Chapter06Review.finiteDistribution ψ0 → Tendsto (MolecularDynamics.Chapter06Review.finiteEvolution PiMark ψ0) atTop (𝓝 ψ) := by
  sorry

/-- source_id: MD-6.4.1-StochasticEntryBound · unnumbered_claim · §6.4.1 · 印刷p.245 / PDFp.266 -/
theorem stochasticEntryBound : ∀ {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ),
  MolecularDynamics.Chapter06Review.stochasticMatrix matrix → ∀ i j, matrix i j ≤ 1 := by
  intro k matrix h i j
  rw [← h.2 i]
  exact Finset.single_le_sum (fun k _ ↦ h.1 i k) (Finset.mem_univ j)

/-- source_id: MD-6.4.1-FiniteChainExample · Fig. 6.6 · §6.4.1 · 印刷p.246 / PDFp.267 -/
def finiteChainExample : Matrix (Fin 5) (Fin 5) ℝ :=
  !![(1/5),(1/10),(7/10),0,0;
     0,0,0,1,0;
     (3/10),0,0,(3/10),(2/5);
     0,(1/2),0,(3/10),(1/5);
     0,0,0,1,0]

/-- source_id: MD-6.4.1-ExampleStochastic · extra_claim · §6.4.1 · 印刷p.246 / PDFp.267
[EXTRA] [EXTRA]原具体数值矩阵的真实随机行资格检查。 -/
theorem exampleStochastic : MolecularDynamics.Chapter06Review.stochasticMatrix finiteChainExample := by
  constructor
  · intro i j
    fin_cases i <;> fin_cases j <;> norm_num [finiteChainExample]
  · intro i
    fin_cases i <;> norm_num [finiteChainExample, Fin.sum_univ_succ]

/-- source_id: MD-6.4.1-ExampleNotIrreducible · Fig. 6.6 · §6.4.1 · 印刷p.246 / PDFp.267 -/
theorem exampleNotIrreducible : ¬ MolecularDynamics.Chapter06Review.irreducible finiteChainExample := by
  have hz : ∀ n : ℕ,
      (finiteChainExample^n) (1 : Fin 5) 0=0 ∧
      (finiteChainExample^n) (3 : Fin 5) 0=0 ∧
      (finiteChainExample^n) (4 : Fin 5) 0=0 := by
    intro n
    induction n with
    | zero => norm_num
    | succ n ih =>
      rw [pow_succ']
      simp only [finiteChainExample] at ih
      norm_num [Matrix.mul_apply, Fin.sum_univ_succ, finiteChainExample,
        ih.1, ih.2.1, ih.2.2]
  intro h
  obtain ⟨n,hn⟩ := h (1 : Fin 5) (0 : Fin 5)
  rw [(hz n).1] at hn
  linarith

/-- source_id: MD-6.4.1-Communicates · definition · §6.4.1 · 印刷p.245–246 / PDFp.266–267 -/
def communicates {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ) (i j : Fin k) : Prop :=
  (∃ n : ℕ, 0 < (matrix^n) i j) ∧ ∃ n : ℕ, 0 < (matrix^n) j i

/-- source_id: MD-6.4.1-DirectedGraphIrreducible · unnumbered_claim · §6.4.1 · 印刷p.246 / PDFp.267
[EXTRA] [EXTRA]真实正权边与有向路径可达关系；∀i,j强连通，不用无向连通偷换。 -/
theorem directedGraphIrreducible : ∀ {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ),
  MolecularDynamics.Chapter06Review.stochasticMatrix matrix →
  (MolecularDynamics.Chapter06Review.irreducible matrix ↔
    ∀ i j, Relation.ReflTransGen (fun a b ↦ 0 < matrix a b) i j) := by
  sorry

/-- source_id: MD-6.4.2-CylinderCoordinates · extra_claim · §6.4.2 · 印刷p.247 / PDFp.268
[EXTRA] [EXTRA]实际圆环商坐标与Euclidean非紧坐标；局部微分表达通过周期lift解释，不偷换D为纯ℝⁿ。 -/
def cylinderCoordinates {k₁ k₂ : ℕ} (z : Fin (k₁+k₂) → ℝ) :
    (Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ) :=
  (fun i ↦ (z ⟨i.val, by omega⟩ : AddCircle (1 : ℝ)), fun j ↦ z ⟨k₁+j.val, by omega⟩)

/-- source_id: MD-6.4.2-CylinderSDE · (6.43) · §6.4.2 · 印刷p.247 / PDFp.268
[EXTRA] [EXTRA]真实D及其周期lift、原C∞漂移、常矩形B和全部严格Ito积分；仅方程意义，不预置遍历/不变结论。 -/
def cylinderSDE {Ω : Type*} [MeasurableSpace Ω] {k₁ k₂ r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ))
    (X : ℝ → Ω → ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)))
    (b₀ : ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)) → (Fin (k₁+k₂) → ℝ))
    (B : Matrix (Fin (k₁+k₂)) (Fin r) ℝ) (x0 : Fin (k₁+k₂) → ℝ) : Prop :=
  ContDiff ℝ ∞ (fun z ↦ b₀ (cylinderCoordinates z)) ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  ∃ lift : ℝ → Ω → (Fin (k₁+k₂) → ℝ),
    strictVectorSDE P W lift (fun z _ ↦ b₀ (cylinderCoordinates z)) (fun _ _ ↦ B) x0 ∧
    (∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t → X t sample=cylinderCoordinates (lift t sample))

/-- source_id: MD-6.4.2-CylinderGenerator · definition · §6.4.2 · 印刷p.247 / PDFp.268 -/
def cylinderGenerator {k₁ k₂ r : ℕ}
    (b₀ : ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)) → (Fin (k₁+k₂) → ℝ))
    (B : Matrix (Fin (k₁+k₂)) (Fin r) ℝ)
    (φ : ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)) → ℝ) (z : Fin (k₁+k₂) → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorGenerator (fun y ↦ b₀ (cylinderCoordinates y)) B
    (fun y ↦ φ (cylinderCoordinates y)) z

/-- source_id: MD-6.4.2-CylinderForwardPrinted · definition · §6.4.2 · 印刷p.247 / PDFp.268
[EXTRA] [EXTRA]周期lift中的完整实际负散度与错误φ扩散，正确ρ算子已有VectorForward定义。
[ERRATUM?] 印刷forward密度算子仍写φ″，应ρ″；本条保留两个不同对象的字面表达，不宣称其是密度演化算子。 -/
def cylinderForwardPrinted {n r : ℕ} (b₀ : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ φ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  -(∑ i, fderiv ℝ (fun z ↦ b₀ z i*ρ z) x (Pi.single i 1)) +
    MolecularDynamics.Chapter06Review.vectorDiffusion B φ x

/-- source_id: MD-6.4.2-StationaryDensity · definition · §6.4.2 · 印刷p.247 / PDFp.268 -/
def stationaryDensity {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) : Prop :=
  ∀ x, MolecularDynamics.Chapter06Review.vectorForward a B ρ x=0

/-- source_id: MD-6.4.2-StationaryInvariant · unnumbered_claim · §6.4.2 · 印刷p.247 / PDFp.268
[EXTRA] [EXTRA]实际Markov kernel semigroup、真实generator对演化检验的导数关系与弱stationarity，并明确局部可积支配保证求导换积分；完整kernel测度不变，未假设不变结论或把形式exp当实际流。 -/
theorem stationaryInvariant :
  ∀ {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) (L : (D → ℝ) → D → ℝ),
  MolecularDynamics.Chapter06Review.markovSemigroup K → IsProbabilityMeasure μ →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) → ∀ T : ℝ, 0 ≤ T →
    ∃ bound : D → ℝ, Integrable bound μ ∧ ∀ s ∈ Icc 0 T, ∀ x,
      |L (fun y ↦ MolecularDynamics.Chapter06Review.kernelAverage K f s.toNNReal y) x| ≤ bound x) →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) →
    (∀ t, Integrable (L (fun x ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t x)) μ) ∧
    (∀ x t, HasDerivWithinAt (fun s : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f s.toNNReal x)
      (L (fun y ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal y) x) (Ici 0) t)) →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) → (∫ x, L f x ∂μ)=0) →
  MolecularDynamics.Chapter06Review.invariantKernel K μ := by
  sorry

/-- source_id: MD-6.4-CanonicalMixingMeaning · definition · §6.4 · 印刷p.244 / PDFp.265
[EXTRA] [EXTRA]真实概率目标和任意点初始law、全部有界连续检验函数弱混合定义；没有宣称所有SDE自动满足。 -/
def canonicalMixingMeaning {D : Type*} [TopologicalSpace D] [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) : Prop :=
  IsProbabilityMeasure μ ∧ ∀ x : D, ∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ z, f z ∂K t.toNNReal x) atTop (𝓝 (∫ z, f z ∂μ))

/-- source_id: MD-6.4.2-LangevinCanonicalMixing · unnumbered_claim · §6.4.2 · 印刷p.248 / PDFp.269
[EXTRA] [EXTRA]真实现有周期单位质量Langevin kernel、正γ/β、原光滑力全局Lipschitz；完整任意点初值的正时刻严格正连续转移密度以及全部有界连续检验弱混合，原一般混合意义另条，不以单位质量特例替代一般定义。 -/
theorem langevinCanonicalMixing :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β γ : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)),
  textbookIsWienerVector B P → 0 < γ →
  (∀ t : ℝ≥0, 0 < t → ∃ density : textbookLangevinPeriodicPhase n × textbookLangevinPeriodicPhase n → ℝ,
    Continuous density ∧ (∀ x y, 0 < density (x,y)) ∧
    ∀ x, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
      (Real.sqrt (2*γ*β⁻¹)) t x =
        (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun y ↦ ENNReal.ofReal (density (x,y)))) ∧
  ∀ x : textbookLangevinPeriodicPhase n,
    ∀ f : textbookLangevinPeriodicPhase n → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ z, f z ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
      (Real.sqrt (2*γ*β⁻¹)) t.toNNReal x) atTop
        (𝓝 (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)) := by
  sorry

/-- source_id: MD-6.4.3-BrownianGenerator · (6.46) · §6.4.3 · 印刷p.249 / PDFp.270
[EXTRA] [EXTRA]实际任意对角质量版本，取m≡1即此处公式；不声称原6.46本身含一般质量。 -/
noncomputable def brownianGenerator {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ)
    (q : Fin Nc → ℝ) : ℝ :=
  ∑ i, (m i)⁻¹ * (β⁻¹ * textbookConfigurationPartial
    (textbookConfigurationPartial f i) i q -
      textbookConfigurationPartial U i q * textbookConfigurationPartial f i q)

/-- source_id: MD-6.4.3-BrownianWeightedInner · definition · §6.4.3 · 印刷p.249 / PDFp.270
[EXTRA] [EXTRA]本章后续周期Q的单位基本域；保留原未归一权重，不偷加Z⁻¹。C₀²域与闭算子域另行区别。 -/
def brownianWeightedInner {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ)
    (f g : (Fin n → ℝ) → ℝ) : ℝ :=
  ∫ q in textbookConfigurationCube n, f q*g q*Real.exp (-β*U q)

/-- source_id: MD-6.4.3-BrownianDirichlet · unnumbered_claim · §6.4.3 · 印刷p.249–250 / PDFp.270–271
[EXTRA] [EXTRA]真实C∞周期资格保证边界通量消去；实际全质量逆M梯度积，m≡1还原原式；β≠0。 -/
theorem brownianDirichlet {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    (∫ q in textbookConfigurationCube Nc,
      f q * textbookBrownianGenerator m U β g q * textbookConfigurationGibbsWeight U β q) =
      -β⁻¹ * ∫ q in textbookConfigurationCube Nc,
        textbookConfigurationGradientPair m f g q * textbookConfigurationGibbsWeight U β q := by
  apply MolecularDynamics.textbookBrownianGenerator_integral_dirichlet <;> assumption

/-- source_id: MD-6.4.3-BrownianSymmetry · unnumbered_claim · §6.4.3 · 印刷p.250 / PDFp.271
[EXTRA] [EXTRA]完整未归一配对等式，由现成归一配对消去正Z⁻¹；C∞周期核心上的形式对称，不宣称C₀²核心本身已闭自伴。 -/
theorem brownianSymmetry {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β g) =
      brownianWeightedInner U β (textbookBrownianGenerator m U β f) g := by
  have hs := textbookBrownianGenerator_inner_symmetric m U β hβ f g hU hf hg hPU hPf hPg
  unfold textbookConfigurationInner at hs
  have hz := (textbookConfigurationPartition_pos U hU β).ne'
  have hc := mul_left_cancel₀ (inv_ne_zero hz) hs
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc

/-- source_id: MD-6.4.3-BrownianNonpositive · unnumbered_claim · §6.4.3 · 印刷p.250 / PDFp.271
[EXTRA] [EXTRA]正质量与β>0，未归一配对；本条结论精确保留≤0，原negative definite术语错误另记录。
[ERRATUM?] 常数属于核，≤0只证明半负定，不能升级严格负定。 -/
theorem brownianNonpositive {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β f) ≤ 0 := by
  have hn := textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf
  unfold textbookConfigurationInner at hn
  have hc := nonpos_of_mul_nonpos_right hn (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc

/-- 修正版，对应原文 MD-6.4.3-BrownianNonpositive；改动：采用≤0并区分闭算子实现与光滑核心；严格负定字面另见BrownianNegativeDefinitePrinted。 -/
theorem brownianNonpositive_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β f) ≤ 0 := by
  have hn := textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf
  unfold textbookConfigurationInner at hn
  have hc := nonpos_of_mul_nonpos_right hn (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc

/-- source_id: MD-6.4.3-BrownianRealEigenvalue · unnumbered_claim · §6.4.3 · 印刷p.250 / PDFp.271
[EXTRA] [EXTRA]真正非零L²特征函数、C∞周期、正质量与β>0；不以特征值符号作假设。 -/
theorem brownianRealEigenvalue {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hne : ¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0)
    (ℓ : ℝ) (heig : ∀ q, textbookBrownianGenerator m U β f q = ℓ * f q) :
    ℓ ≤ 0 := by
  exact MolecularDynamics.textbookBrownianGenerator_real_eigenvalue_nonpos m hm U β hβ f hU hf hPU hPf hne ℓ heig

/-- source_id: MD-6.4.3-BrownianClosedSelfAdjoint · unnumbered_claim · §6.4.3 · 印刷p.249–250 / PDFp.270–271
[EXTRA] [EXTRA]使用现成实际Gibbs复L²闭实现及完整adjoint域；原C₀²核心对称不等于闭自伴。权重归一不改变自伴关系。 -/
theorem brownianClosedSelfAdjoint {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ) := by
  apply MolecularDynamics.textbookBrownianGibbsComplexOperator_isSelfAdjoint <;> assumption

/-- source_id: MD-6.4.3-BrownianCompactResolvent · unnumbered_claim · §6.4.3 · 印刷p.250 / PDFp.271
[EXTRA] [EXTRA]实际Gibbs复L²闭实现的(1−L)⁻¹；全部离散谱子结论另条保留，未从本条自动声称原C₀²域自伴。 -/
theorem brownianCompactResolvent {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsCompactOperator (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ) := by
  apply MolecularDynamics.textbookBrownianGibbsComplexResolvent_isCompact <;> assumption

/-- source_id: MD-6.4.3-BrownianDiscreteSpectrum · unnumbered_claim · §6.4.3 · 印刷p.250 / PDFp.271
[EXTRA] [EXTRA]实际闭Gibbs复L²域的全谱，非另选某有限模式；包含可数、实值与每个点孤立。 -/
theorem brownianDiscreteSpectrum {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ, z.im=0) ∧
  ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ,
    ∃ N : Set ℂ, IsOpen N ∧ z ∈ N ∧
      N ∩ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ={z} := by
  refine ⟨textbookBrownianGibbsGeneratorComplexSpectrum_countable m hm U hU hPU β hβ, ?_, ?_⟩
  · exact fun z hz ↦ textbookBrownianGibbsGeneratorComplexSpectrum_im_zero m hm U hU hPU β hβ z hz
  · exact fun z hz ↦ textbookBrownianGibbsGeneratorComplexSpectrum_isolated m hm U hU hPU β hβ z hz

/-- source_id: MD-6.4.3-BrownianSpectralGap · unnumbered_claim · §6.4.3 · 印刷p.251 / PDFp.272
[EXTRA] [EXTRA]现成实际全闭谱；正谱隙从真实Poincaré常数得出，不把目标谱隙作前提。 -/
theorem brownianSpectralGap {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
  ∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ,
    z ≠ 0 → z.im=0 ∧ z.re ≤ -α := by
  refine ⟨textbookBrownianGibbsCoercivityRate m U hU hPU β,
    textbookBrownianGibbsCoercivityRate_pos m U hU hPU β hβ, ?_⟩
  intro z hz hn
  exact ⟨textbookBrownianGibbsGeneratorComplexSpectrum_im_zero m hm U hU hPU β hβ z hz,
    textbookBrownianGibbsGeneratorComplexSpectrum_gap m hm U hU hPU β hβ z hn hz⟩

/-- source_id: MD-6.4.3-Theorem61 · Theorem 6.1 · §6.4.3 · 印刷p.250–251 / PDFp.271–272
[EXTRA] [EXTRA]明确采用现成闭复Gibbs-L²实现、非正谱和完整离散/谱隙；第三部分选择实际演化分布平均，并限定真实非负质量1的L²初始相对密度。全部条款保留，不用部分桥接代替整个定理。
[ERRATUM?] 原C₀²核心域、自伴闭实现及negative definite术语需要签核；原末句时间平均与前句分布平均冲突。原一般初始分布未证明，本条技术范围限定另行披露。 -/
theorem theorem61 :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (hm : ∀ i, 0 < m i)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β),
  IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z.im=0 ∧ z.re ≤ 0) ∧
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, ∃ ε : ℝ, 0 < ε ∧
    ∀ w ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, dist w z < ε → w=z) ∧
  (∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z ≠ 0 → z.re ≤ -α) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω),
    textbookIsWienerVector B P →
    ∀ ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β),
      0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ →
      (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β)=1 →
      ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace n) (t : ℝ≥0),
        |textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ * Real.exp (-α*(t : ℝ)) := by
  sorry

/-- 修正版，对应原文 MD-6.4.3-Theorem61；改动：明确闭Gibbs-L²实现、半负定、离散谱、谱隙和L²初始相对密度的演化分布平均；Brownian扩散使用逆质量权重，不混用p.244动量算子的ΔM；不声称已证原轨道时间平均。 -/
theorem theorem61_corrected :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (hm : ∀ i, 0 < m i)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β),
  IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z.im=0 ∧ z.re ≤ 0) ∧
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, ∃ ε : ℝ, 0 < ε ∧
    ∀ w ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, dist w z < ε → w=z) ∧
  (∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z ≠ 0 → z.re ≤ -α) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω),
    textbookIsWienerVector B P →
    ∀ ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β),
      0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ →
      (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β)=1 →
      ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace n) (t : ℝ≥0),
        |textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ * Real.exp (-α*(t : ℝ)) := by
  sorry

/-- 【原书疑误】Theorem6.1三款并列，保留严格负定及(5.6)轨道时间平均；闭算子实现与质量Laplacian歧义另列，不证明此版。 -/
theorem theorem61Printed :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (hm : ∀ i, 0 < m i)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β),
  IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z.im=0 ∧ z.re ≤ 0) ∧
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, ∃ ε : ℝ, 0 < ε ∧
    ∀ w ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, dist w z < ε → w=z) ∧
  (∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z ≠ 0 → z.re ≤ -α) ∧
  (∀ f : (Fin n → ℝ) → ℝ, ContDiff ℝ ∞ f → textbookUnitPeriodicPotential f →
    (¬ f =ᵐ[volume.restrict (textbookConfigurationCube n)] 0) →
      brownianWeightedInner U β f (textbookBrownianGenerator m U β f) < 0) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω), textbookIsWienerVector B P →
    ∀ x : UnitAddTorus (Fin n), ∃ K α : ℝ, 0 < K ∧ 0 < α ∧
      ∀ f : textbookPeriodicSmoothSpace n, ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t →
        |t⁻¹*(∫ s in (0 : ℝ)..t,
            textbookConfigurationTorusObservable f
              (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hp β hβ x B s sample)) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K*‖textbookPeriodicSmoothEmbedding U hU hp β f‖*Real.exp (-α*t) := by
  sorry

/-- 【原书疑误】按p.244既定ΔM=Σmi∂ii逐字代入Theorem6.1的形式表达；不宣称它是Brownian过程生成元。 -/
def brownianMassGeneratorPrinted {n : ℕ} (m : Fin n → ℝ) (U f : (Fin n → ℝ) → ℝ)
    (β : ℝ) (x : Fin n → ℝ) : ℝ :=
  ∑ i, (-(m i)⁻¹*fderiv ℝ U x (Pi.single i 1)*fderiv ℝ f x (Pi.single i 1)+
    β⁻¹*m i*fderiv ℝ (fun y ↦ fderiv ℝ f y (Pi.single i 1)) x (Pi.single i 1))

/-- 修正版，Brownian扩散使用逆质量权重；实际生成元的表达式定义。 -/
noncomputable def brownianMassGeneratorPrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ)
    (q : Fin Nc → ℝ) : ℝ :=
  ∑ i, (m i)⁻¹ * (β⁻¹ * textbookConfigurationPartial
    (textbookConfigurationPartial f i) i q -
      textbookConfigurationPartial U i q * textbookConfigurationPartial f i q)

/-- source_id: MD-6.4.3-Theorem61TimeAveragePrinted · Theorem 6.1(3) printed time average · §6.4.3 · 印刷p.251 / PDFp.272
[EXTRA] [EXTRA]实际Brownian全时torus过程、任意点初值、AE路径资格和t>0明确；原C∞紧支检验在紧torus周期表示。
[ERRATUM?] 保留原5.6轨道时间平均读法；通常随机时间平均并无原指称指数路径误差界。原文未说明随机量的概率资格，不能改成分布平均后冒称原结论已证。 -/

theorem theorem61TimeAveragePrinted {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) :
  ∀ x : UnitAddTorus (Fin Nc), ∃ K α : ℝ, 0 < K ∧ 0 < α ∧
    ∀ f : textbookPeriodicSmoothSpace Nc, ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t →
      |t⁻¹*(∫ s in (0 : ℝ)..t,
          textbookConfigurationTorusObservable f
            (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ x B s sample)) -
        (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
          K*‖textbookPeriodicSmoothEmbedding U hU hPU β f‖*Real.exp (-α*t) := by
  sorry

/-- source_id: MD-6.4.3-BrownianEnsembleExponential · unnumbered_claim · §6.4.3 · 印刷p.251 / PDFp.272
[EXTRA] [EXTRA]选择实际演化分布平均；真实Wiener/kernel和非负质量1的L²初始相对密度，所有光滑周期检验同时受界。范围限定不覆盖singular点初始law，不是原轨道时间平均证明。 -/
theorem brownianEnsembleExponential {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace Nc) (t : ℝ≥0),
      |textbookBrownianDensityAverage m hm U hU hPU β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube Nc, (f : (Fin Nc → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hPU β f‖ * Real.exp (-α * (t : ℝ)) := by
  apply MolecularDynamics.textbookBrownianDensityAverage_smooth_exponential <;> assumption

/-- 修正版，对应原文 MD-6.4.3-Theorem61TimeAveragePrinted；改动：选择演化分布平均，限定L²初始相对密度；轨道遍历极限应另行陈述，不赋予指数逐路径率。 -/
theorem theorem61TimeAveragePrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace Nc) (t : ℝ≥0),
      |textbookBrownianDensityAverage m hm U hU hPU β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube Nc, (f : (Fin Nc → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hPU β f‖ * Real.exp (-α * (t : ℝ)) := by
  apply MolecularDynamics.textbookBrownianDensityAverage_smooth_exponential <;> assumption

/-- source_id: MD-6.4.3-BrownianNegativeDefinitePrinted · unnumbered_claim · §6.4.3 · 印刷p.250 / PDFp.271
[EXTRA] [EXTRA]明确严格负定含全部非零周期光滑L²函数的读法。
[ERRATUM?] 常数非零函数给零二次型，严格负定字面不成立；原非正谱正确子结论独立保留。 -/
theorem brownianNegativeDefinitePrinted {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
  ∀ f : (Fin Nc → ℝ) → ℝ, ContDiff ℝ ∞ f → textbookUnitPeriodicPotential f →
    (¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0) →
      brownianWeightedInner U β f (textbookBrownianGenerator m U β f) < 0 := by
  sorry

/-- source_id: MD-6.4.2-OUDensityPrinted · (6.44)–(6.45) · §6.4.2 · 印刷p.248 / PDFp.269
[EXTRA] [EXTRA]定义中使用通用噪声σ，取σ=√(2γkBTm)即6.45；t=0资格另记录。
[ERRATUM?] (6.44)遗漏(2πσ²(t))⁻¹/²归一化系数；t=0为Dirac，不能声称每个有限t都是非退化Lebesgue密度。 -/
def ouDensityPrinted (γ σ x0 t x : ℝ) : ℝ :=
  Real.exp (-(x-MolecularDynamics.Chapter06Review.ouMean γ x0 t)^2/(2*MolecularDynamics.Chapter06Review.ouVariance γ σ t))

/-- source_id: MD-6.4.2-OUDensityCorrect · (6.44) correction · §6.4.2 · 印刷p.248 / PDFp.269
[EXTRA] [EXTRA]补归一化系数，正γ/温度/质量且t>0使用；仅实际密度公式定义，原OU严格law结论在§6.3.2保留，不计密度积分或过程law已证。 -/
def ouDensity (γ σ x0 t x : ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.ouDensityPrinted γ σ x0 t x / Real.sqrt (2*Real.pi*MolecularDynamics.Chapter06Review.ouVariance γ σ t)

/-- source_id: MD-6.4.4-Assumption1Printed · Assumption 1 printed · §6.4.4 · 印刷p.252 / PDFp.273
[EXTRA] [EXTRA]真实Borel Markov kernel与局部参考测度；完整同一内点可达、全部初值与可测子集及联合连续资格。
[ERRATUM?] 正维连续状态中t=0初始Dirac通常不具有可连续延拓的Lebesgue转移密度；字面[0,∞)与正时刻密度不能混同。 -/
def assumption1Printed {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ici 0)

/-- source_id: MD-6.4.4-Assumption1Correct · Assumption 1 positive-time version · §6.4.4 · 印刷p.252 / PDFp.273
[EXTRA] [EXTRA]联合连续域改为C×C×(0,∞)，正时刻实际密度与全部可达资格保留；只定义修正版，未计任何具体SDE已满足。 -/
def assumption1 {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ioi 0)

/-- source_id: MD-6.4.4-Assumption2 · Assumption 2 · §6.4.4 · 印刷p.252 / PDFp.273
[EXTRA] [EXTRA]柱形相空间以真实compact sublevels表达趋无穷；连续正Lyapunov及正α/δ，未把Harris结论藏进定义。具体generator域资格在对应命题明确。 -/
def assumption2 {D : Type*} [TopologicalSpace D] (L : (D → ℝ) → D → ℝ)
    (φ : D → ℝ) (α δ : ℝ) : Prop :=
  (∀ x, 0 < φ x) ∧ Continuous φ ∧ (∀ R : ℝ, IsCompact {x | φ x ≤ R}) ∧
    0 < α ∧ 0 < δ ∧ ∀ x, L φ x ≤ -α*φ x+δ
local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩

/-- source_id: MD-6.4.4-MinorizationPrinted · unnumbered_claim · §6.4.4 · 印刷p.252 / PDFp.273
[ERRATUM?] 原tantamount按双向等价读取；一般小集下界并不自动产生原要求的联合连续密度，且原时间0连续性需勘误。不能只证单向后冒称原等价已证。 -/
theorem minorizationPrinted : ∀ {S : Type*} [MetricSpace S] [MeasurableSpace S] [BorelSpace S]
    (ν : Measure S) (K : ℝ≥0 → Kernel S S) (C : Set S),
  MolecularDynamics.Chapter06Review.assumption1Printed ν K C ↔
    ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure S,
      IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x := by
  sorry

/-- source_id: MD-6.4.4-MinorizationCorrectedImplication · unnumbered_claim · §6.4.4 · 印刷p.252 / PDFp.273
[EXTRA] [EXTRA]仅单向充分条件，正时刻Assumption1加全部非空开集严格可达；实际测度下界完整，字面双向版独立保留。 -/
theorem minorizationCorrectedImplication :
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D), MolecularDynamics.Chapter06Review.assumption1 ν K C →
  (∀ t : ℝ≥0, ∀ x : D, ∀ A : Set D, IsOpen A → A.Nonempty → 0 < t → 0 < K t x A) →
  ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure D,
    IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x := by
  sorry

/-- source_id: MD-6.4.4-Theorem62 · Theorem 6.2 · §6.4.4 · 印刷p.252 / PDFp.273
[EXTRA] [EXTRA]阈值函数先于全部过程/Lyapunov量词选择，不能临时选使Assumption1假而空真；真实Markov semigroup/Feller、Polish局部紧状态及σ有限参考测度。全状态正时刻密度资格用于完整不变概率密度结论；L*ρ=0按真实generator检验的弱意义，不是先假定不变性。全部函数/初值/时刻统一加权指数界与唯一性均保留。
[ERRATUM?] 原未指定阈值、generator域或非爆炸/Markov域识别；原Assumption1时间0勘误和全状态密度资格需要明确签核。 -/
theorem theorem62 :
  ∃ threshold : ℝ → ℝ → ℝ,
    (∀ α δ : ℝ, 0 < α → 0 < δ → 0 < threshold α δ) ∧
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D] [CompleteSpace D] [SecondCountableTopology D] [LocallyCompactSpace D]
    (ν : Measure D) [SigmaFinite ν] (K : ℝ≥0 → Kernel D D), MolecularDynamics.Chapter06Review.markovSemigroup K →
  (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) → ∀ t,
    Continuous (MolecularDynamics.Chapter06Review.kernelAverage K f t)) →
  (∀ t : ℝ≥0, 0 < t → ∀ x : D, ∃ density : D → ℝ,
    Measurable density ∧ (∀ z, 0 ≤ density z) ∧
      K t x = ν.withDensity (fun z ↦ ENNReal.ofReal (density z))) →
  ∀ (φ : D → ℝ) (α δ : ℝ), MolecularDynamics.Chapter06Review.assumption2 (MolecularDynamics.Chapter06Review.kernelGenerator K) φ α δ →
    MolecularDynamics.Chapter06Review.assumption1 ν K {x | φ x ≤ threshold α δ} →
      ∃ μ : Measure D, IsProbabilityMeasure μ ∧ MolecularDynamics.Chapter06Review.invariantKernel K μ ∧
      (∀ μ' : Measure D, IsProbabilityMeasure μ' → MolecularDynamics.Chapter06Review.invariantKernel K μ' → μ'=μ) ∧
      (∃ ρ : D → ℝ, Measurable ρ ∧ (∀ x, 0 ≤ ρ x) ∧
        μ=ν.withDensity (fun x ↦ ENNReal.ofReal (ρ x))) ∧
      (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
        Integrable (MolecularDynamics.Chapter06Review.kernelGenerator K f) μ → (∫ x, MolecularDynamics.Chapter06Review.kernelGenerator K f x ∂μ)=0) ∧
      ∃ κ lambdaParam : ℝ, 0 < κ ∧ 0 < lambdaParam ∧ ∀ f : D → ℝ, Measurable f → (∀ x, |f x| ≤ φ x) →
        Integrable f μ ∧ ∀ (t : ℝ≥0) (x : D),
          |MolecularDynamics.Chapter06Review.kernelAverage K f t x-(∫ z, f z ∂μ)| ≤ κ*Real.exp (-lambdaParam*(t : ℝ))*φ x := by
  sorry

/-- source_id: MD-6.4.4-PeriodicPotentialBound · unnumbered_claim · §6.4.4 · 印刷p.253 / PDFp.274
[EXTRA] [EXTRA]完整全域有限范数界，给上下界±M；正下界>1需实际势能平移，另条给出。原周期与q→∞围束资格冲突另留字面记录，不由本条消去。
[ERRATUM?] 非恒零维周期势在lift上不会趋∞；光滑周期本身也不推出原1<Umin。 -/
theorem periodicPotentialBound {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Continuous U) (hP : textbookUnitPeriodicPotential U) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ q, ‖U q‖ ≤ M := by
  apply MolecularDynamics.textbookUnitPeriodicPotential_bound <;> assumption

/-- source_id: MD-6.4.4-PotentialNormalization · unnumbered_claim · §6.4.4 · 印刷p.253 / PDFp.274
[EXTRA] [EXTRA]将Umin>1解释为实际加常数归一；严格>1与真实力不变全部保留，而非直接假定任何原势已大于1。 -/
theorem potentialNormalization {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : Continuous U) (hp : textbookUnitPeriodicPotential U) :
  ∃ c : ℝ, (∀ q, 1 < U q+c) ∧
    textbookPotentialForce (fun q ↦ U q+c)=textbookPotentialForce U := by
  obtain ⟨c,hc⟩ := textbookUnitPeriodicPotential_normalization U hU hp
  refine ⟨c+1, ?_, textbookPotentialForce_add_const U (c+1)⟩
  intro q
  linarith [hc q]

/-- source_id: MD-6.4.4-UnitLangevinModel · (6.47) · §6.4.4 · 印刷p.251 / PDFp.272
[EXTRA] [EXTRA]真实单位质量完整耦合路径方程；β>0及光滑势保证原梯度存在，γ>0由实际MassLangevin资格保留。Wiener law在对应定理另给，不宣称任意W是Wiener。 -/
def unitLangevinModel {n : ℕ} {A : Type*} [MeasurableSpace A] (P : Measure A)
    (W : ℝ → A → (Fin n → ℝ)) (X : ℝ → A → ((Fin n → ℝ) × (Fin n → ℝ)))
    (U : (Fin n → ℝ) → ℝ) (γ β : ℝ) (x0 : (Fin n → ℝ) × (Fin n → ℝ)) : Prop :=
  0 < β ∧ ContDiff ℝ ∞ U ∧ MD.Ch06.langevinMassSDE P W X (fun _ ↦ 1) U γ β⁻¹ x0

/-- source_id: MD-6.4.4-PeriodicConfiningPrinted · definition · §6.4.4 · 印刷p.253 / PDFp.274
[EXTRA] [EXTRA]实际正维单位周期lift，cocompact表达配置无穷远；不是动量Hamiltonian的围束。
[ERRATUM?] 原周期位置域与同一势能lift的q→∞围束条件冲突；保留字面资格而非构造一个不存在的周期围束势。 -/
def periodicConfiningPrinted {n : ℕ} (_hn : 0 < n) (U : (Fin n → ℝ) → ℝ) : Prop :=
  ContDiff ℝ ∞ U ∧ textbookUnitPeriodicPotential U ∧
    Tendsto U (cocompact (Fin n → ℝ)) atTop

/-- source_id: MD-6.4.4-HamiltonianPower · definition · §6.4.4 · 印刷p.253 / PDFp.274
[EXTRA] [EXTRA]l≥1编码，真实单位质量Hamiltonian，未把形式jet当真实函数；正性与柱形proper在后续实际桥接证明。 -/
noncomputable def hamiltonianPower {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (l : ℕ) (_hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) : ℝ := textbookLangevinHamiltonian U z ^ l

/-- source_id: MD-6.4.4-HamiltonianPowerCancellation · unnumbered_claim · §6.4.4 · 印刷p.253 / PDFp.274
[EXTRA] [EXTRA]实际沿Hamiltonian方向的真实导数为0；γ=0只在此Hamiltonian部分，非把整个物理Langevin摩擦设零。 -/
theorem hamiltonianPowerCancellation {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : Differentiable ℝ U) (l : ℕ) (_hl : 1 ≤ l) (z : textbookLangevinPhase n) :
  HasDerivAt (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
    (z+t • textbookLangevinDrift U 0 z)) 0 0 := by
  simpa using textbookLangevinHamiltonianPower_drift_hasDerivAt U hU (0 : ℝ) l z

/-- source_id: MD-6.4.4-HamiltonianPowerMomentumDerivative · unnumbered_claim · §6.4.4 · 印刷p.253 / PDFp.274
[EXTRA] [EXTRA]真实沿动量p方向的导数及全部两个表达式，不仅登记事先给定的导数值；实际所有坐标平方和。 -/
theorem hamiltonianPowerMomentumDerivative : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (l : ℕ) (z : textbookLangevinPhase n), 1 ≤ l →
  HasDerivAt (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l (z.1,(1+t) • z.2))
    ((l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*(∑ i, z.2 i^2)) 0 ∧
  (l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*(∑ i, z.2 i^2) =
    2*(l : ℝ)*textbookLangevinHamiltonianPower U l z -
      2*(l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*U z.1 := by
  intro n U l z hl
  let S : ℝ := ∑ i, z.2 i^2
  have he : ∀ t : ℝ, textbookLangevinHamiltonian U (z.1,(1+t) • z.2)=
      (1+t)^2*S/2+U z.1 := by
    intro t
    simp only [textbookLangevinHamiltonian, Pi.smul_apply, smul_eq_mul, mul_pow,
      ← Finset.mul_sum]
    rfl
  have hd : HasDerivAt (fun t : ℝ ↦ ((1+t)^2*S/2+U z.1)^l)
      ((l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*S) 0 := by
    convert! (((((hasDerivAt_id (0 : ℝ)).const_add 1).pow 2).mul_const S).div_const 2 |>.add_const (U z.1)).pow l using 1 <;>
      simp [textbookLangevinHamiltonian, S] <;> ring
  constructor
  · simpa only [textbookLangevinHamiltonianPower, he] using hd
  · change (l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*S=
      2*(l : ℝ)*textbookLangevinHamiltonian U z^l-
        2*(l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*U z.1
    rw [show textbookLangevinHamiltonian U z^l=
      textbookLangevinHamiltonian U z^(l-1)*textbookLangevinHamiltonian U z by
      rw [← pow_succ, Nat.sub_add_cancel hl]]
    dsimp [textbookLangevinHamiltonian, S]
    ring

/-- source_id: MD-6.4.4-HamiltonianPowerMomentumLaplacian · unnumbered_claim · §6.4.4 · 印刷p.253 / PDFp.274
[EXTRA] [EXTRA]完整实际坐标二阶导数和及正确等式，l≥1；原随后不等式单独原样保存，未据等式声称它成立。 -/
theorem hamiltonianPowerMomentumLaplacian {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (l : ℕ) (hl : 1 ≤ l) (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) =
      (l : ℝ) * ((l : ℝ) - 1) * textbookLangevinHamiltonian U z ^ (l - 2) * (∑ i, z.2 i ^ 2) +
        (Nc : ℝ) * l * textbookLangevinHamiltonian U z ^ (l - 1) := by
  apply MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian <;> assumption

/-- source_id: MD-6.4.4-LaplacianBoundPrinted · unnumbered_claim · §6.4.4 · 印刷p.253 / PDFp.274
[ERRATUM?] 用|p|²≤2H推导时遗漏系数2；一般原界不成立，具体52>40反例另给。 -/
theorem laplacianBoundPrinted : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ),
  (∀ q, 1 ≤ U q) → ∀ (l : ℕ), 1 ≤ l → ∀ z : textbookLangevinPhase n,
    (∑ i : Fin n, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z+t • ((0 : Fin n → ℝ), Pi.single i 1)))) 0) ≤
      (l : ℝ)*((l : ℝ)+(n : ℝ)-1)*textbookLangevinHamiltonian U z^(l-1) := by
  sorry

/-- source_id: MD-6.4.4-LaplacianBoundCounterexample · unnumbered_claim · §6.4.4 · 印刷p.253 / PDFp.274
[EXTRA] [EXTRA]现成具体n=1、U=2、l=2、p=4反例52>40；仅差异证据，未用它替代原全量词界或完整Lyapunov论证。 -/
theorem laplacianBoundCounterexample :
    deriv (deriv (fun p : ℝ ↦ (p ^ 2 / 2 + 2) ^ 2)) 4 = 52 ∧
      ¬ deriv (deriv (fun p : ℝ ↦ (p ^ 2 / 2 + 2) ^ 2)) 4 ≤
        (2 : ℝ) * (2 + 1 - 1) * (4 ^ 2 / 2 + 2) ^ (2 - 1 : ℕ) := by
  apply MolecularDynamics.textbookLangevinLyapunov_printed_laplacian_bound_counterexample <;> assumption

/-- source_id: MD-6.4.4-HamiltonianPowerGenerator · unnumbered_claim · §6.4.4 · 印刷p.253–254 / PDFp.274–275
[EXTRA] [EXTRA]实际全坐标一二阶导数与完整H^l，现成通用σ算子取σ=√(2γkBT)使σ²/2=γkBT；不是给定目标导数再改写。物理热参数代入在下一完整Lyapunov桥接实际出现。 -/
theorem hamiltonianPowerGenerator {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Differentiable ℝ U) (γ σ : ℝ) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    textbookLangevinDifferentialOperator U γ σ (textbookLangevinHamiltonianPower U l) z =
      -γ * l * textbookLangevinHamiltonian U z ^ (l - 1) * (∑ i, z.2 i ^ 2) +
        σ ^ 2 / 2 * ((l : ℝ) * ((l : ℝ) - 1) * textbookLangevinHamiltonian U z ^ (l - 2) *
          (∑ i, z.2 i ^ 2) + (Nc : ℝ) * l * textbookLangevinHamiltonian U z ^ (l - 1)) := by
  apply MolecularDynamics.textbookLangevinHamiltonianPower_differentialOperator <;> assumption

/-- source_id: MD-6.4.4-LaplacianBoundCorrect · unnumbered_claim · §6.4.4 · 印刷p.253 / PDFp.274
[EXTRA] [EXTRA]修正上界系数为2l(l−1)+Nc l；原错误l(l+Nc−1)另列NEEDS，未静默更换JSON原句。 -/
theorem laplacianBoundCorrect {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) ≤
      (2 * (l : ℝ) * ((l : ℝ) - 1) + (Nc : ℝ) * l) * textbookLangevinHamiltonian U z ^ (l - 1) := by
  apply MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian_bound <;> assumption

/-- source_id: MD-6.4.4-LyapunovYoungBounds · unnumbered_claim · §6.4.4 · 印刷p.253 / PDFp.274
[EXTRA] [EXTRA]完整同时覆盖原两个标量界与修正系数界，常数可依赖l/n/Umax但不依赖H；H≥1来自已归一物理势。原U(q)<Umax一环需选择严格外界，本条没有从≤假推出<。
[ERRATUM?] 原中间严格U上界需要Umax选严格外界；原错误Laplacian系数不能由这些正确标量估计证明。 -/
theorem lyapunovYoungBounds : ∀ (l n : ℕ) (Umax : ℝ), 1 ≤ l → 1 ≤ Umax →
  ∃ c d : ℝ, 0 < c ∧ 0 < d ∧ ∀ H : ℝ, 1 ≤ H →
    ((l : ℝ)*((l : ℝ)+(n : ℝ)-1)*H^(l-1) ≤ (l : ℝ)/2*H^l+c) ∧
    (2*(l : ℝ)*H^(l-1)*Umax ≤ (l : ℝ)/2*H^l+d) ∧
    ((2*(l : ℝ)*((l : ℝ)-1)+(n : ℝ)*l)*H^(l-1) ≤ (l : ℝ)/2*H^l+c) := by
  intro l n Umax hl hU
  have hlpos : (0 : ℝ) < l := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hl)
  let A1 : ℝ := (l : ℝ)*((l : ℝ)+(n : ℝ)-1)
  let A2 : ℝ := 2*(l : ℝ)*Umax
  let A3 : ℝ := 2*(l : ℝ)*((l : ℝ)-1)+(n : ℝ)*l
  let A : ℝ := max 0 (max A1 (max A2 A3))
  let ε : ℝ := (l : ℝ)/2
  have hε : 0 < ε := by dsimp [ε]; positivity
  have hA : 0 ≤ A := le_max_left _ _
  let M : ℝ := max 1 (A/ε)
  have hM : 0 ≤ M := le_trans zero_le_one (le_max_left _ _)
  have hAM : A ≤ ε*M := by
    have hd : A/ε ≤ M := le_max_right _ _
    simpa only [mul_comm] using (div_le_iff₀ hε).mp hd
  let C : ℝ := A*M^(l-1)+1
  have hC : 0 < C := by dsimp [C]; positivity
  have hbound : ∀ H : ℝ, 1 ≤ H → A*H^(l-1) ≤ ε*H^l+C := by
    intro H hH
    have hH0 : 0 ≤ H := le_trans zero_le_one hH
    by_cases h : M ≤ H
    · have hAH := hAM.trans (mul_le_mul_of_nonneg_left h hε.le)
      calc
        _ ≤ (ε*H)*H^(l-1) := mul_le_mul_of_nonneg_right hAH (pow_nonneg hH0 _)
        _ = ε*(H^(l-1)*H) := by ring
        _ = ε*H^l := by rw [← pow_succ, Nat.sub_add_cancel hl]
        _ ≤ ε*H^l+C := le_add_of_nonneg_right hC.le
    · have hpow := pow_le_pow_left₀ hH0 (le_of_lt (lt_of_not_ge h)) (l-1)
      have hb := mul_le_mul_of_nonneg_left hpow hA
      have hp : 0 ≤ ε*H^l := mul_nonneg hε.le (pow_nonneg hH0 _)
      dsimp [C]
      linarith
  have h1 : A1 ≤ A := (le_max_left _ _).trans (le_max_right _ _)
  have h2 : A2 ≤ A := (le_max_left _ _).trans ((le_max_right _ _).trans (le_max_right _ _))
  have h3 : A3 ≤ A := (le_max_right _ _).trans ((le_max_right _ _).trans (le_max_right _ _))
  refine ⟨C,C,hC,hC,fun H hH ↦ ?_⟩
  have hp : 0 ≤ H^(l-1) := pow_nonneg (le_trans zero_le_one hH) _
  exact ⟨(mul_le_mul_of_nonneg_right h1 hp).trans (hbound H hH),
    (by simpa only [A2, mul_assoc, mul_left_comm, mul_comm] using (mul_le_mul_of_nonneg_right h2 hp).trans (hbound H hH)),
    (mul_le_mul_of_nonneg_right h3 hp).trans (hbound H hH)⟩

/-- source_id: MD-6.4.4-LangevinLyapunov · unnumbered_claim · §6.4.4 · 印刷p.253–254 / PDFp.274–275
[EXTRA] [EXTRA]实际单位质量周期模型、归一U≥1、γ/β>0及l≥1；完整正性/紧子水平集/无穷远proper/正δ全域线性恢复界，采用真实更正系数2。原证明计算的错系数仍按原句保留；不是整个Thm6.2或canonical invariance桥接。 -/
theorem langevinLyapunov {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (hL : ∀ q, 1 ≤ U q) (γ β : ℝ) (hγ : 0 < γ) (hβ : 0 < β) (l : ℕ) (hl : 1 ≤ l) :
    0 < γ * l ∧ (Real.sqrt (2 * γ * β⁻¹)) ^ 2 / 2 = γ * β⁻¹ ∧
      (∀ z : textbookLangevinPeriodicPhase Nc, 0 < textbookLangevinPeriodicHamiltonianPower U l z) ∧
      (∀ R : ℝ, IsCompact {z : textbookLangevinPeriodicPhase Nc | textbookLangevinPeriodicHamiltonianPower U l z ≤ R}) ∧
      Tendsto (textbookLangevinPeriodicHamiltonianPower U l)
        (cocompact (textbookLangevinPeriodicPhase Nc)) atTop ∧
      ∃ δ : ℝ, 0 < δ ∧ ∀ z : textbookLangevinPeriodicPhase Nc,
        textbookLangevinPeriodicDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
          (textbookLangevinPeriodicHamiltonianPower U l) z ≤
            -(γ * l) * textbookLangevinPeriodicHamiltonianPower U l z + δ := by
  apply MolecularDynamics.textbookLangevinPeriodicHamiltonianPower_physical_lyapunov <;> assumption

/-- source_id: MD-6.4.4-LieBracket · definition · §6.4.4 · 印刷p.254 / PDFp.275
[EXTRA] [EXTRA]实际Fréchet导数括号，具体性质/迭代均要求适当可微字段；其通用辅助函数的非可微总化值不作经典Jacobian解释。有限坐标式由真实fderiv在basis上取分量。
[EXTRA] [EXTRA]实际字段仅需原开域内C¹，输出点属于D，非可微/域外的总化fderiv值不作为经典Jacobian。 -/
def lieBracket {n : ℕ} (D : Set (Fin n → ℝ)) (_hD : IsOpen D)
    (u v : (Fin n → ℝ) → (Fin n → ℝ)) (_hu : ContDiffOn ℝ 1 u D)
    (_hv : ContDiffOn ℝ 1 v D) (x : D) : (Fin n → ℝ) :=
  MolecularDynamics.Chapter06Review.lieBracket u v x

/-- source_id: MD-6.4.4-LieBracketProperties · unnumbered_claim · §6.4.4 · 印刷p.254 / PDFp.275
[EXTRA] [EXTRA]全部双槽线性、skew及自身零明确，真实全域可微资格；不只保存某一固定字段或单槽例子。 -/
theorem lieBracketProperties : ∀ {n : ℕ} (u v w : (Fin n → ℝ) → (Fin n → ℝ)) (a b : ℝ),
  Differentiable ℝ u → Differentiable ℝ v → Differentiable ℝ w →
  (MolecularDynamics.Chapter06Review.lieBracket (fun x ↦ a • u x+b • v x) w =
    fun x ↦ a • MolecularDynamics.Chapter06Review.lieBracket u w x+b • MolecularDynamics.Chapter06Review.lieBracket v w x) ∧
  (MolecularDynamics.Chapter06Review.lieBracket u (fun x ↦ a • v x+b • w x) =
    fun x ↦ a • MolecularDynamics.Chapter06Review.lieBracket u v x+b • MolecularDynamics.Chapter06Review.lieBracket u w x) ∧
  MolecularDynamics.Chapter06Review.lieBracket u v = -MolecularDynamics.Chapter06Review.lieBracket v u ∧
  MolecularDynamics.Chapter06Review.lieBracket u u=0 := by
  intro n u v w a b hu hv hw
  have hb : ∀ (u v : (Fin n → ℝ) → (Fin n → ℝ)),
      MolecularDynamics.Chapter06Review.lieBracket u v=VectorField.lieBracket ℝ u v :=
    fun u v ↦ rfl
  simp_rw [hb]
  refine ⟨?_,?_,?_,?_⟩
  · funext x
    change VectorField.lieBracket ℝ (a • u+b • v) w x = _
    rw [VectorField.lieBracket_add_left ((hu x).const_smul a) ((hv x).const_smul b),
      VectorField.lieBracket_const_smul_left (hu x),
      VectorField.lieBracket_const_smul_left (hv x)]
  · funext x
    change VectorField.lieBracket ℝ u (a • v+b • w) x = _
    rw [VectorField.lieBracket_add_right ((hv x).const_smul a) ((hw x).const_smul b),
      VectorField.lieBracket_const_smul_right (hv x),
      VectorField.lieBracket_const_smul_right (hw x)]
  · funext x
    exact VectorField.lieBracket_swap
  · exact VectorField.lieBracket_self

/-- source_id: MD-6.4.4-Definition61 · Definition 6.1 · §6.4.4 · 印刷p.254 / PDFp.275
[EXTRA] [EXTRA]Fin(S+1)完整包含原drift b0与全部噪声，实际无限次括号及实span；明确C∞字段资格。保留原定义含b0，不冒充一般parabolic噪声生成条件；具体Langevin rank另证。
[EXTRA] [EXTRA]原开域U和域内点完整保留；坐标字段全空间任意总化只用于函数表示，C∞仅要求在原开域，不要求全局光滑延拓。开域内真实fderiv/全部迭代括号是局部对象。 -/
def definition61 {m S : ℕ} (D : Set (Fin m → ℝ)) (_hD : IsOpen D)
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) (x : Fin m → ℝ) : Prop :=
  x ∈ D ∧ (∀ i, ContDiffOn ℝ ∞ (b i) D) ∧ textbookHormanderAt (Set.range b) x

/-- source_id: MD-6.4.4-LangevinFields · definition · §6.4.4 · 印刷p.255 / PDFp.276
[EXTRA] [EXTRA]实际全部2Nc相空间坐标的真实drift/noise，C∞势资格编码，通用σ在物理定理取√(2γkBT)；不把noise定义计作独立Wiener law或密度存在证明。 -/
noncomputable def langevinDrift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ : ℝ) (_hU : ContDiff ℝ ∞ U) : textbookLangevinPhase Nc → textbookLangevinPhase Nc :=
  fun z ↦ (z.2, textbookPotentialForce U z.1 - γ • z.2)

def langevinNoise (Nc : ℕ) (σ : ℝ) (i : Fin Nc) :
    textbookLangevinPhase Nc → textbookLangevinPhase Nc := fun _ ↦ (0, σ • Pi.single i 1)

/-- source_id: MD-6.4.4-LangevinNoiseBracket · unnumbered_claim · §6.4.4 · 印刷p.255 / PDFp.276
[EXTRA] [EXTRA]真实C²势的Fréchet Jacobian、全部噪声坐标；σ任意，非零条件在独立性条明确。 -/
theorem langevinNoiseBracket {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (γ σ : ℝ)
    (i : Fin Nc) (z : textbookLangevinPhase Nc) :
    VectorField.lieBracket ℝ (textbookLangevinDrift U γ) (textbookLangevinNoise Nc σ i) z =
      (-σ • Pi.single i 1, (σ * γ) • Pi.single i 1) := by
  apply MolecularDynamics.textbookLangevinDrift_noise_bracket <;> assumption

/-- source_id: MD-6.4.4-LangevinBracketIndependent · unnumbered_claim · §6.4.4 · 印刷p.255 / PDFp.276
[EXTRA] [EXTRA]真实Fin Nc⊕Fin Nc的全部2Nc向量族、σ≠0；不以维数计数代替独立性。 -/
theorem langevinBracketIndependent (Nc : ℕ) (γ σ : ℝ) (hσ : σ ≠ 0) :
    LinearIndependent ℝ (textbookLangevinBracketFamily Nc γ σ) := by
  apply MolecularDynamics.textbookLangevinBracketFamily_linearIndependent <;> assumption

/-- source_id: MD-6.4.4-LangevinHormander · unnumbered_claim · §6.4.4 · 印刷p.255 / PDFp.276
[EXTRA] [EXTRA]完整物理σ=√(2γθ)、γ/θ>0、C∞ U的实际噪声及括号span；本桥只证rank，转移密度存在另条未证。 -/
theorem langevinHormander {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ θ : ℝ)
    (hγ : 0 < γ) (hθ : 0 < θ) (z : textbookLangevinPhase Nc) :
    textbookHormanderAt (textbookLangevinSeed U γ (Real.sqrt (2 * γ * θ))) z := by
  apply MolecularDynamics.textbookLangevin_hormander_physicalNoise <;> assumption

/-- source_id: MD-6.4.4-LangevinTransitionDensity · unnumbered_claim · §6.4.4 · 印刷p.255 / PDFp.276
[EXTRA] [EXTRA]具体实际单位周期Langevin、C∞势、正γ/β，全部点初值的正时间连续转移密度及真实平坦相空间测度表示；没有从含drift的任意原Definition6.1断言一般parabolic密度定理。 -/
theorem langevinTransitionDensity :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β γ : ℝ)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω),
  textbookIsWienerVector B P → 0 < β → 0 < γ →
  ∃ ρ : textbookLangevinPeriodicPhase n → textbookLangevinPeriodicPhase n → ℝ → ℝ,
    (∀ x z t, 0 < t → 0 ≤ ρ x z t) ∧
    ContinuousOn (fun w : (textbookLangevinPeriodicPhase n × textbookLangevinPeriodicPhase n) × ℝ ↦
      ρ w.1.1 w.1.2 w.2) (univ ×ˢ Ioi 0) ∧
    ∀ (t : ℝ≥0), 0 < t → ∀ x A, MeasurableSet A →
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹)) t x A =
        ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n := by
  sorry

/-- source_id: MD-6.4.4-Lemma61Printed · Lemma 6.1 · §6.4.4 · 印刷p.255 / PDFp.276
[ERRATUM?] 字面all open C包括空集，概率为0；需Nonempty。原(6.47)单位质量，旧清单一般质量扩展须另标技术范围。 -/
theorem lemma61Printed :
  ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (γ β : ℝ) (x0 : MolecularDynamics.Chapter06Review.Phase n) (X : ℝ → Ω → MolecularDynamics.Chapter06Review.Phase n),
  textbookIsWienerVector B P → (∀ i, 0 < m i) → ContDiff ℝ ∞ U →
  0 < γ → 0 < β → MolecularDynamics.Chapter06Review.langevinMassSDE P (fun t sample ↦ B t.toNNReal sample) X m U γ β⁻¹ x0 →
  (∀ t : ℝ, 0 ≤ t → AEMeasurable (X t) P) →
  ∀ t : ℝ, 0 < t → ∀ C : Set (MolecularDynamics.Chapter06Review.Phase n), IsOpen C → 0 < P {sample | X t sample ∈ C} := by
  sorry

/-- source_id: MD-6.4.4-Lemma61Nonempty · unnumbered_claim · §6.4.4 · 印刷p.255 / PDFp.276
[EXTRA] [EXTRA]补非空目标；桥接实际单位周期相空间、原单位质量、真实Wiener/实际完整Langevin核，σ≠0。原一般质量扩大版不计已证。 -/
theorem lemma61Nonempty {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) (hT : (0 : ℝ) < T)
    (hσ : σ ≠ 0) (x : textbookLangevinPeriodicPhase N)
    (C : Set (textbookLangevinPeriodicPhase N)) (hC : IsOpen C) (hCN : C.Nonempty) :
    0 < textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x C := by
  apply MolecularDynamics.textbookLangevinPeriodicTransitionKernel_open_pos <;> assumption

/-- source_id: MD-6.4.4-ControlPath · unnumbered_claim · §6.4.4 · 印刷p.255 / PDFp.276
[EXTRA] [EXTRA]完整实际任意位置/速度端点、q/p/R全光滑、R0=0及真实全时ODE；σ≠0，未冒充随机正概率。 -/
theorem controlPath {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (x y : textbookLangevinPhase Nc) :
    ∃ q p R : ℝ → (Fin Nc → ℝ),
      ContDiff ℝ ∞ q ∧ ContDiff ℝ ∞ p ∧ ContDiff ℝ ∞ R ∧
      q 0 = x.1 ∧ p 0 = x.2 ∧ q T = y.1 ∧ p T = y.2 ∧ R 0 = 0 ∧
      ∀ t, HasDerivAt q (p t) t ∧
        HasDerivAt p (textbookPotentialForce U (q t) - γ • p t + σ • deriv R t) t := by
  apply MolecularDynamics.textbookLangevinControlledEndpoint <;> assumption

/-- source_id: MD-6.4.4-ControlEndpointStable · unnumbered_claim · §6.4.4 · 印刷p.256 / PDFp.277
[EXTRA] [EXTRA]实际完整受控积分方程和原平滑势局部cutoff稳定性，全部端点/δ/ε；未假设全局Lipschitz势，原环面投影由上一真实核桥接。 -/
theorem controlEndpointStable {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T δ : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (hδ : 0 < δ) (x y : textbookLangevinPhase Nc) :
    ∃ ε > 0, ∀ W q p : ℝ → (Fin Nc → ℝ),
      textbookLangevinIntegralSolution U γ σ T x W q p →
      (∀ t ∈ Icc 0 T, ‖W t - textbookLangevinControlPath U γ σ T x y t‖ ≤ ε) →
      dist (q T, p T) y < δ := by
  apply MolecularDynamics.textbookLangevinControlledEndpoint_stable <;> assumption

/-- source_id: MD-6.4.4-WienerControlTube · unnumbered_claim · §6.4.4 · 印刷p.256 / PDFp.277
[EXTRA] [EXTRA]完整实际标准多维Wiener法则、真实连续控制R0=0、T/ε>0及sup管道事件；非仅某单时Gaussian边际。 -/
theorem wienerControlTube {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 < T) (R : ℝ → (Fin Nc → ℝ)) (hR : Continuous R)
    (hR0 : R 0 = 0) (ε : ℝ) (hε : 0 < ε) :
    0 < P (textbookWienerVectorRealControlTube B T R ε) := by
  apply MolecularDynamics.textbookWienerVectorRealControlTube_pos <;> assumption

/-- source_id: MD-6.4.4-LangevinCanonicalStationary · unnumbered_claim · §6.4.4 · 印刷p.256 / PDFp.277
[EXTRA] [EXTRA]实际归一canonical density（原式缺Z为未归一权重，常数不影响微分式）、全部相空间点及物理噪声；这里只证stationary differential expression，真实invariance/ergodicity在下一条。 -/
theorem langevinCanonicalStationary {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
      (fun y ↦ textbookLangevinCanonicalDensity U β (textbookLangevinPeriodicProjection y)) z = 0 := by
  apply MolecularDynamics.textbookLangevinForwardDifferentialOperator_physical_canonical_eq_zero <;> assumption

/-- source_id: MD-6.4.4-LangevinGeometricErgodicity · unnumbered_claim · §6.4.4 · 印刷p.256 / PDFp.277
[EXTRA] [EXTRA]实际单位周期Langevin完整Gibbs不变/唯一概率及任意l≥1全部可测加权可积观测量的统一指数估计，常数在x/f/t之外；有界周期U使H^l与(1+‖p‖²)^l等价，没有弱化为紧支函数。 -/
theorem langevinGeometricErgodicity :
  ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω) (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ β : ℝ) (hβ : 0 < β), textbookIsWienerVector B P → 0 < γ →
  MolecularDynamics.Chapter06Review.invariantKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹)))
    (textbookLangevinCanonicalMeasure U β hβ) ∧
  (∀ ν : Measure (textbookLangevinPeriodicPhase n), IsProbabilityMeasure ν →
    MolecularDynamics.Chapter06Review.invariantKernel
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) ν →
    ν=textbookLangevinCanonicalMeasure U β hβ) ∧
  ∀ l : ℕ, 1 ≤ l → ∃ C lambdaParam : ℝ, 0 < C ∧ 0 < lambdaParam ∧
    ∀ x : textbookLangevinPeriodicPhase n, ∀ f : textbookLangevinPeriodicPhase n → ℝ,
      Measurable f → (∀ y, |f y| ≤ (1+‖y.2‖^2)^l) → ∀ t : ℝ≥0,
      |MolecularDynamics.Chapter06Review.kernelAverage
        (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) f t x
        -(∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)| ≤
        C*(1+‖x.2‖^2)^l*Real.exp (-lambdaParam*(t : ℝ)) := by
  sorry

/-- source_id: MD-6.4.4-LangevinTimeAverage · unnumbered_claim · §6.4.4 · 印刷p.256 / PDFp.277
[EXTRA] [EXTRA]实际同一全时随机周期Langevin轨迹，任意点初始状态、全部可测多项式动量增长观测量、几乎处处时间均值；不把初始density的ensemble衰减当轨迹时间均值。 -/
theorem langevinTimeAverage :
  ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω) (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (_hU : ContDiff ℝ ∞ U) (_hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ β : ℝ) (hβ : 0 < β), textbookIsWienerVector B P → 0 < γ →
  ∀ x : textbookLangevinPeriodicPhase n, ∀ f : textbookLangevinPeriodicPhase n → ℝ,
    Measurable f →
    (∃ l : ℕ, ∃ C : ℝ, 0 ≤ C ∧ ∀ y, |f y| ≤ C*(1+‖y.2‖^2)^l) → ∀ᵐ sample ∂P,
      Tendsto (fun T : ℝ ↦ T⁻¹ * ∫ s in 0..T,
        f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ (Real.sqrt (2*γ*β⁻¹)) x B s sample))
        atTop (𝓝 (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)) := by
  sorry

/-- source_id: MD-6.4.4-WeightedH1 · definition · §6.4.4 · 印刷p.256 / PDFp.277
[EXTRA] [EXTRA]实际Gibbs加权弱导数闭图及AE商的完整Hilbert H1；不是smooth jet子集，函数/导数投影和范数下一条明确。 -/
def weightedH1 {N : ℕ} (U : (Fin N → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) : Type :=
  textbookLangevinCanonicalWeakH1 U hU hp β hβ

/-- source_id: MD-6.4.4-WeightedH1Norm · unnumbered_claim · §6.4.4 · 印刷p.257 / PDFp.278
[EXTRA] [EXTRA]实际全部位置/动量弱导数的L²范数平方和；真实函数/弱导数投影定义随compact依赖闭包给出。 -/
theorem weightedH1Norm {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ) :
    ‖f‖ ^ 2 = ‖textbookLangevinCanonicalWeakH1Value U hU hp β hβ f‖ ^ 2 +
      (∑ i : Fin N, ‖textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ (Sum.inl i) f‖ ^ 2) +
      (∑ i : Fin N, ‖textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ (Sum.inr i) f‖ ^ 2) := by
  apply MolecularDynamics.textbookLangevinCanonicalWeakH1_norm_sq <;> assumption

/-- source_id: MD-6.4.4-Proposition64Printed · Proposition 6.4 · §6.4.4 · 印刷p.257 / PDFp.278
[ERRATUM?] 印刷flat forward PDE与Gibbs加权mean-zero/adjoint pairing混用；测度及density-vs-relative-density选择待导师，原式完整保留。 -/
theorem proposition64Printed :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  ∀ g : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ g x ∂textbookLangevinCanonicalMeasure U β hβ)=0 →
    ∃ φ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
      MolecularDynamics.Chapter06Review.flatForwardWeak U β γ (textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ)
        (textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∧
      ∀ ψ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
        MolecularDynamics.Chapter06Review.flatForwardWeak U β γ (textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ)
          (textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) →
        ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ x -
            textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ x = c*textbookLangevinCanonicalDensity U β x := by
  sorry

/-- source_id: MD-6.4.4-Proposition64Relative · unnumbered_claim · §6.4.4 · 印刷p.257 / PDFp.278
[EXTRA] [EXTRA]明确相对Gibbs密度坐标，实际加权Hilbert闭算子adjoint图与完整H1、加权零均值、解存在/唯一模常数；与印刷flat-density Gibbs倍数版分列，非静默纠错。 -/
theorem proposition64Relative :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  let A := (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).adjoint
  ∀ g : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ g x ∂textbookLangevinCanonicalMeasure U β hβ)=0 →
    ∃ φ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
      (textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ,
        textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∈ A.graph ∧
      ∀ ψ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
        (textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∈ A.graph →
        ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ x -
            textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ x=c := by
  sorry

/-- source_id: MD-6.4.4-FredholmAlternative · unnumbered_claim · §6.4.4 · 印刷p.257 / PDFp.278
[EXTRA] [EXTRA]实际稠密域闭Hilbert partialoperator图、actual adjoint以及shift1的完整紧resolvent（含逆的存在/唯一）；全部g可解当且仅当adjoint kernel正交，没有假设目标可解性。 -/
theorem fredholmAlternative :
  ∀ {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [CompleteSpace E] (A : E →ₗ.[ℝ] E), Dense (A.domain : Set E) → IsClosed (A.graph : Set (E × E)) →
  (∃ R : E →L[ℝ] E, IsCompactOperator R ∧
    (∀ x, (R x, R x-x) ∈ A.graph) ∧
    ∀ x y, (y,y-x) ∈ A.graph → y=R x) →
  ∀ g : E, (∃ φ : E, (φ,g) ∈ A.graph) ↔ ∀ y : E, (y,0) ∈ A.adjoint.graph → ⟪y,g⟫_ℝ=0 := by
  sorry

/-- source_id: MD-6.4.4-BackwardKernelConstants · unnumbered_claim · §6.4.4 · 印刷p.257 / PDFp.278
[EXTRA] [EXTRA]真实Gibbs加权Lp²闭backward operator图的全部粗域元素；不能用已证C0固定观测量特例替代。 -/
theorem backwardKernelConstants :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (_hU : ContDiff ℝ ∞ U) (_hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  ∀ f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ),
    (f,0) ∈ (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).graph →
    ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ, f x=c := by
  sorry

/-- source_id: MD-6.4.4-ForwardKernelGibbs · unnumbered_claim · §6.4.4 · 印刷p.257 / PDFp.278
[EXTRA] [EXTRA]完整原flat forward弱PDE与真实H1类，全部stationary modes为Gibbs倍数；相对加权adjoint kernel对应常数而非Gibbs，不能混同二者。 -/
theorem forwardKernelGibbs : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β γ : ℝ) (hβ : 0 < β),
  0 < γ → ∀ w : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    MolecularDynamics.Chapter06Review.flatForwardWeak U β γ
      (textbookLangevinCanonicalWeakH1Value U hU hp β hβ w) 0 →
    ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
      textbookLangevinCanonicalWeakH1Value U hU hp β hβ w x=c*textbookLangevinCanonicalDensity U β x := by
  sorry

/-- source_id: MD-6.4.4-WeightedFunctionNorm · definition · §6.4.4 · 印刷p.256 / PDFp.277
[EXTRA] [EXTRA]实际Lp² AE类范数；Mathlib的eLpNorm定义为真实二阶积分，不把任意非可积函数的默认Bochner积分当范数。 -/
def weightedFunctionNorm {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) : ℝ := ‖f‖^2

/-- source_id: MD-6.4.4-WeightedVectorNorm · definition · §6.4.4 · 印刷p.257 / PDFp.278
[EXTRA] [EXTRA]完整任意维度的所有真实L²分量，弱导数族使用同一实际Gibbs测度；不遗漏向量范数定义。 -/
def weightedVectorNorm {n r : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (w : Fin r → Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) : ℝ := ∑ i, ‖w i‖^2

/-- source_id: MD-6.4.5-KernelEvolution · definition · §6.4.5 · 印刷p.257 / PDFp.278
[EXTRA] [EXTRA]真实Markov kernel应用初始measure的compProd边缘，形式exp解释为实际演化，非无资格幂级数。 -/
def kernelEvolution {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D)
    (μ : Measure D) (t : ℝ≥0) : Measure D := K t ∘ₘ μ

/-- source_id: MD-6.4.5-KernelAverage · definition · §6.4.5 · 印刷p.258 / PDFp.279
[EXTRA] [EXTRA]真实核积分的backward检验函数传播，可积资格在Duality定理明确。 -/
def kernelAverage {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D)
    (f : D → ℝ) (t : ℝ≥0) (x : D) : ℝ := ∫ z, f z ∂K t x

/-- source_id: MD-6.4.5-DensityEvolutionMeaning · definition · §6.4.5 · 印刷p.257–258 / PDFp.278–279
[EXTRA] [EXTRA]真实初始概率density、全部时刻density及实际kernel measure等式的语义定义；未假设每个任意SDE必存在平滑density，未计存在性已证。 -/
def densityEvolutionMeaning {n : ℕ} (K : ℝ≥0 → Kernel (textbookLangevinPeriodicPhase n) (textbookLangevinPeriodicPhase n))
    (ρ0 : textbookLangevinPeriodicPhase n → ℝ) (ρ : ℝ≥0 → textbookLangevinPeriodicPhase n → ℝ) : Prop :=
  (∀ x, 0 ≤ ρ0 x) ∧ Integrable ρ0 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, ρ0 x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1 ∧
  ∀ t, (∀ x, 0 ≤ ρ t x) ∧ Integrable (ρ t) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
    MolecularDynamics.Chapter06Review.kernelEvolution K
      ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal (ρ0 x))) t =
      (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal (ρ t x))

/-- source_id: MD-6.4.5-KernelDuality · unnumbered_claim · §6.4.5 · 印刷p.258 / PDFp.279
[EXTRA] [EXTRA]全部实际可测可积检验、真实Markov kernel及初始概率measure；非仅Brownian谱模型配对。 -/
theorem kernelDuality :
  ∀ {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) (t : ℝ≥0) (f : D → ℝ),
  IsProbabilityMeasure μ → IsMarkovKernel (K t) → Measurable f →
  Integrable f (MolecularDynamics.Chapter06Review.kernelEvolution K μ t) →
  (∫ x, f x ∂MolecularDynamics.Chapter06Review.kernelEvolution K μ t) = ∫ x, MolecularDynamics.Chapter06Review.kernelAverage K f t x ∂μ := by
  intro D _ K μ t f hμ hK hf hi
  letI : IsProbabilityMeasure μ := hμ
  letI : IsMarkovKernel (K t) := hK
  unfold MolecularDynamics.Chapter06Review.kernelEvolution MolecularDynamics.Chapter06Review.kernelAverage at *
  rw [Measure.comp_eq_comp_const_apply]
  apply Kernel.integral_comp
  simpa only [← Measure.comp_eq_comp_const_apply] using hi

/-- source_id: MD-6.4.5-SmoothTestL2Printed · unnumbered_claim · §6.4.5 · 印刷p.258 / PDFp.279
[ERRATUM?] 环面×无界动量上C∞不自动L²；常数1已不在flat L²，指数增长函数也可能不在Gibbs L²。需适当weighted空间/增长资格。 -/
theorem smoothTestL2Printed : ∀ {n : ℕ} (f : textbookLangevinPeriodicPhase n → ℝ),
  ContDiff ℝ ∞ (f ∘ textbookLangevinPeriodicProjection) →
  MemLp f 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) := by
  sorry

/-- source_id: MD-6.4.5-ComplexInitialDensity · definition · §6.4.5 · 印刷p.258 / PDFp.279
[EXTRA] [EXTRA]明确真实初始概率的实性/非负/积分1，原单复模式不自动是概率；保留复Lp空间与复本征值，未缩成实负λ玩具。复共轭成对构造可另建，但原单模式需这些资格。 -/
def complexInitialDensity {n : ℕ}
    (ρeq ρ1 : Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)) (α : ℝ) : Prop :=
  (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n, (ρeq x).im=0 ∧ 0 ≤ (ρeq x).re) ∧
  Integrable (fun x ↦ (ρeq x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, (ρeq x).re ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1 ∧
  (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n,
    (ρeq x+(α : ℂ)*ρ1 x).im=0 ∧ 0 ≤ (ρeq x+(α : ℂ)*ρ1 x).re) ∧
  Integrable (fun x ↦ (ρeq x+(α : ℂ)*ρ1 x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, (ρeq x+(α : ℂ)*ρ1 x).re ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1

/-- source_id: MD-6.4.5-LangevinForwardSemigroupMeaning · definition · §6.4.5 · 印刷p.257–258 / PDFp.278–279
[EXTRA] [EXTRA]对所有真实非负实初始density的actual kernel/complex Lp²传播关联定义；不凭空把任意线性S命名Langevin，原forward identification仍未证。 -/
def langevinForwardSemigroupMeaning {n : ℕ}
    (K : ℝ≥0 → Kernel (textbookLangevinPeriodicPhase n) (textbookLangevinPeriodicPhase n))
    (S : ℝ≥0 → Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) →L[ℂ]
      Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)) : Prop :=
  ∀ v : Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n),
    (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n, (v x).im=0 ∧ 0 ≤ (v x).re) →
    Integrable (fun x ↦ (v x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) →
    ∀ t, MolecularDynamics.Chapter06Review.kernelEvolution K
      ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal (v x).re)) t =
      (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal ((S t v x).re))

/-- source_id: MD-6.4.5-ComplexEigenmodeDecay · unnumbered_claim · §6.4.5 · 印刷p.258 / PDFp.279
[EXTRA] [EXTRA]完整复λ/Reλ<0及原α∈ℝ，真实flat Lp² initial probability资格；实际C0 semigroup/0处generator图关系、stationary/eigenvector为前提，完整全时exp模式及所有L²检验CS衰减为结论，没有把全时模式演化作假设。S需识别为实际Langevin前向传播，下一条登记，不冒充已识别。
[EXTRA] [EXTRA]S与原实际周期Langevin核在全部非负可积初始密度上的关联及rhoeq与真实归一Gibbs density的AE识别均显式编码；模式演化、平均恒等、CS界及极限全部为结论，仍未计forward semigroup的存在/识别已证。 -/
theorem complexEigenmodeDecay : ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω) (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (β γ : ℝ)
    (hβ : 0 < β) (_hγ : 0 < γ), textbookIsWienerVector B P →
  let E := Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)
  ∀ (S : ℝ≥0 → E →L[ℂ] E) (A : E →ₗ.[ℂ] E) (ρeq ρ1 : E) (α : ℝ) (ev : ℂ),
    langevinForwardSemigroupMeaning
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) S →
    (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n,
      ρeq x=(textbookLangevinCanonicalDensity U β x : ℂ)) →
    S 0=ContinuousLinearMap.id ℂ E → (∀ s t, S (s+t)=(S s).comp (S t)) →
    (∀ v, Continuous (fun t : ℝ≥0 ↦ S t v)) →
    (∀ v w, (v,w) ∈ A.graph → HasDerivWithinAt (fun t : ℝ ↦ S t.toNNReal v) w (Ici 0) 0) →
    (ρeq,0) ∈ A.graph → (ρ1,ev • ρ1) ∈ A.graph → ρ1 ≠ 0 → ev.re < 0 →
    complexInitialDensity ρeq ρ1 α →
    (∀ t : ℝ≥0, S t (ρeq+(α : ℂ) • ρ1)=ρeq+((α : ℂ)*Complex.exp ((t : ℂ)*ev)) • ρ1) ∧
    (∀ f : E, ∀ t : ℝ≥0,
      ⟪f,S t (ρeq+(α : ℂ) • ρ1)⟫_ℂ=⟪f,ρeq⟫_ℂ+
        ((α : ℂ)*Complex.exp ((t : ℂ)*ev))*⟪f,ρ1⟫_ℂ) ∧
    (∀ f : E, ∀ t : ℝ≥0,
      ‖⟪f,S t (ρeq+(α : ℂ) • ρ1)⟫_ℂ-⟪f,ρeq⟫_ℂ‖ ≤
        |α| * ‖f‖*‖ρ1‖*Real.exp (ev.re*(t : ℝ))) ∧
    ∀ f : E, Tendsto (fun t : ℝ≥0 ↦ ⟪f,S t (ρeq+(α : ℂ) • ρ1)⟫_ℂ)
      atTop (𝓝 ⟪f,ρeq⟫_ℂ) := by
  sorry

end MD.Ch06


#print axioms MD.Ch06.microcanonical
#print axioms MD.Ch06.entropy
#print axioms MD.Ch06.independentPartition
#print axioms MD.Ch06.entropyAdditivity
#print axioms MD.Ch06.entropyEquilibrium
#print axioms MD.Ch06.temperature
#print axioms MD.Ch06.inverseThermal
#print axioms MD.Ch06.bathBoltzmannPrinted
#print axioms MD.Ch06.bathBoltzmannPrinted_counterexample
#print axioms MD.Ch06.logTemperature
#print axioms MD.Ch06.bathMeanValue
#print axioms MD.Ch06.bathTaylorEstimate
#print axioms MD.Ch06.boltzmannConstantSlope
#print axioms MD.Ch06.bathBoltzmannPrinted_corrected
#print axioms MD.Ch06.canonicalCDFPrinted
#print axioms MD.Ch06.canonicalCDFPrinted_corrected
#print axioms MD.Ch06.canonicalEnergyDensity
#print axioms MD.Ch06.entropyFunctional
#print axioms MD.Ch06.constrainedEntropyModel
#print axioms MD.Ch06.entropyFirstVariation
#print axioms MD.Ch06.entropyVariation
#print axioms MD.Ch06.canonicalDensity
#print axioms MD.Ch06.massHamiltonian
#print axioms MD.Ch06.partitionMass
#print axioms MD.Ch06.partitionDomain
#print axioms MD.Ch06.finiteDomainPrinted
#print axioms MD.Ch06.finiteDomainPrinted_corrected
#print axioms MD.Ch06.periodicPartitionBridge
#print axioms MD.Ch06.confiningPartition
#print axioms MD.Ch06.lennardJonesNonintegrable
#print axioms MD.Ch06.lennardJonesConfinement
#print axioms MD.Ch06.periodicWeightIntegrable
#print axioms MD.Ch06.periodicPartitionPositive
#print axioms MD.Ch06.polynomialObservable
#print axioms MD.Ch06.canonicalAveragePrinted
#print axioms MD.Ch06.canonicalAverage
#print axioms MD.Ch06.canonicalAveragePrinted_corrected
#print axioms MD.Ch06.canonicalAverageOne
#print axioms MD.Ch06.equipartition
#print axioms MD.Ch06.configTemperature
#print axioms MD.Ch06.proposition61
#print axioms MD.Ch06.weightedFluxZero
#print axioms MD.Ch06.canonicalDivergenceIdentity
#print axioms MD.Ch06.temperatureChoiceDerivatives
#print axioms MD.Ch06.periodicBoundaryCancellation
#print axioms MD.Ch06.meanEnergyConstraint
#print axioms MD.Ch06.densityNormalization
#print axioms MD.Ch06.partitionInversePrinted
#print axioms MD.Ch06.partitionInversePrinted_corrected
#print axioms MD.Ch06.weightedFluxIdentity
#print axioms MD.Ch06.virialTemperature
#print axioms MD.Ch06.virialFieldNotPeriodic
#print axioms MD.Ch06.densityPositive
#print axioms MD.Ch06.kineticWeightFactorization
#print axioms MD.Ch06.energySupportObstruction
#print axioms MD.Ch06.canonicalSamplingObstruction
#print axioms MD.Ch06.rademacherJumps
#print axioms MD.Ch06.randomWalk
#print axioms MD.Ch06.walkRecurrence
#print axioms MD.Ch06.walkInitial
#print axioms MD.Ch06.walkVariance
#print axioms MD.Ch06.diffusiveWalk
#print axioms MD.Ch06.interpolatedWalk
#print axioms MD.Ch06.walkIncrement
#print axioms MD.Ch06.walkGridMoments
#print axioms MD.Ch06.interpolatedWalkMean
#print axioms MD.Ch06.walkDiffusion
#print axioms MD.Ch06.wienerVector
#print axioms MD.Ch06.wienerIncrement
#print axioms MD.Ch06.wienerContinuousVersion
#print axioms MD.Ch06.wienerNondifferentiable
#print axioms MD.Ch06.wienerFutureCompletedHistory
#print axioms MD.Ch06.gridWienerIncrementLaw
#print axioms MD.Ch06.gridIncrementIndependent
#print axioms MD.Ch06.wienerContinuousPathEval
#print axioms MD.Ch06.wienerContinuousPathMeasurable
#print axioms MD.Ch06.coarseMarkovPrinted
#print axioms MD.Ch06.stateMarkovMeaning
#print axioms MD.Ch06.coarseMarkovPrinted_corrected
#print axioms MD.Ch06.riemannTags
#print axioms MD.Ch06.itoLeftSum
#print axioms MD.Ch06.strictItoIntegral
#print axioms MD.Ch06.weakItoAlias_corrected
#print axioms MD.Ch06.weakItoAlias
#print axioms MD.Ch06.stratonovichSum
#print axioms MD.Ch06.selfItoFiniteIdentity
#print axioms MD.Ch06.proposition62
#print axioms MD.Ch06.proposition62_corrected
#print axioms MD.Ch06.proposition62Printed
#print axioms MD.Ch06.proposition62Expansion_corrected
#print axioms MD.Ch06.proposition62Printed_counterexample
#print axioms MD.Ch06.meanSquareConvergence
#print axioms MD.Ch06.wienerMidpointSum
#print axioms MD.Ch06.gaussianIncrementMean
#print axioms MD.Ch06.gaussianIncrementSecond
#print axioms MD.Ch06.gaussianIncrementFourth
#print axioms MD.Ch06.quadraticMeanSquareError
#print axioms MD.Ch06.selfItoIntegral
#print axioms MD.Ch06.selfStratonovichIntegral
#print axioms MD.Ch06.proposition63
#print axioms MD.Ch06.quadraticSumExpectation
#print axioms MD.Ch06.selfItoLimitL2
#print axioms MD.Ch06.selfItoSumsL2
#print axioms MD.Ch06.midpointSumsL2
#print axioms MD.Ch06.deterministicIntegralProcess
#print axioms MD.Ch06.deterministicStrobePrinted
#print axioms MD.Ch06.deterministicStrobeCorrected
#print axioms MD.Ch06.deterministicStrobePrinted_corrected
#print axioms MD.Ch06.stochasticDifferentialIntegral
#print axioms MD.Ch06.biasedWalk
#print axioms MD.Ch06.biasedWalkSum
#print axioms MD.Ch06.strictScalarSDE
#print axioms MD.Ch06.strictVectorSDE
#print axioms MD.Ch06.scalarItoFormula
#print axioms MD.Ch06.diffusiveTaylorPrinted
#print axioms MD.Ch06.diffusiveTaylorPrinted_corrected
#print axioms MD.Ch06.timeItoFormula
#print axioms MD.Ch06.timeItoFormula_corrected
#print axioms MD.Ch06.timeItoFormulaPrinted
#print axioms MD.Ch06.biasedWalkDiffusion
#print axioms MD.Ch06.strictOUProcess
#print axioms MD.Ch06.ouIntegratingFactor
#print axioms MD.Ch06.ouVarianceIntegral
#print axioms MD.Ch06.ouLawPrinted
#print axioms MD.Ch06.ouLawCorrect
#print axioms MD.Ch06.ouLawPrinted_corrected
#print axioms MD.Ch06.ouGibbsLimit
#print axioms MD.Ch06.momentumOU
#print axioms MD.Ch06.gibbsGaussianDensity
#print axioms MD.Ch06.bathHamiltonian
#print axioms MD.Ch06.bathHamiltonEquations
#print axioms MD.Ch06.bathFrequency
#print axioms MD.Ch06.bathOscillatorSolution
#print axioms MD.Ch06.bathConvolutionIBP
#print axioms MD.Ch06.bathForce
#print axioms MD.Ch06.bathForcePrinted_corrected
#print axioms MD.Ch06.bathForcePrinted
#print axioms MD.Ch06.memoryKernel
#print axioms MD.Ch06.bathReduction
#print axioms MD.Ch06.bathReductionPrinted_corrected
#print axioms MD.Ch06.bathReductionPrinted
#print axioms MD.Ch06.memoryKernelDeltaMeaning
#print axioms MD.Ch06.memoryKernelDeltaMeaning_corrected
#print axioms MD.Ch06.scalarLangevin
#print axioms MD.Ch06.langevinMassSDE
#print axioms MD.Ch06.variableFriction
#print axioms MD.Ch06.particleDiagonalFriction
#print axioms MD.Ch06.brownianMassSDE
#print axioms MD.Ch06.frequencyMemoryKernel
#print axioms MD.Ch06.figure64Frequencies
#print axioms MD.Ch06.figure65Frequencies
#print axioms MD.Ch06.bathForceWeakLimitMeaning
#print axioms MD.Ch06.bathForceWeakLimitMeaning_corrected
#print axioms MD.Ch06.overdampedLimit
#print axioms MD.Ch06.scalarGenerator
#print axioms MD.Ch06.generatorExpectation
#print axioms MD.Ch06.polynomialSmooth
#print axioms MD.Ch06.densityExpectation
#print axioms MD.Ch06.scalarForward
#print axioms MD.Ch06.fpDriftAdjoint
#print axioms MD.Ch06.fpDiffusionPrinted
#print axioms MD.Ch06.fpDiffusionPrinted_corrected
#print axioms MD.Ch06.fpAdjointCompact
#print axioms MD.Ch06.fpPolynomialAdjoint
#print axioms MD.Ch06.fpPolynomialAdjoint_corrected
#print axioms MD.Ch06.fpPolynomialAdjointPrinted
#print axioms MD.Ch06.fpEquation
#print axioms MD.Ch06.zeroNoise
#print axioms MD.Ch06.vectorIto
#print axioms MD.Ch06.vectorForward
#print axioms MD.Ch06.cylinderForwardPrinted_corrected
#print axioms MD.Ch06.diffusionTrace
#print axioms MD.Ch06.vectorFPEquation
#print axioms MD.Ch06.langevinMassForward
#print axioms MD.Ch06.momentumMassLaplacian
#print axioms MD.Ch06.langevinFPEquation
#print axioms MD.Ch06.massGibbsStationary
#print axioms MD.Ch06.unitMassGibbsStationaryBridge
#print axioms MD.Ch06.variableFrictionForward
#print axioms MD.Ch06.variableFrictionCanonicalPrinted
#print axioms MD.Ch06.variableFrictionCommutingStationary
#print axioms MD.Ch06.variableFrictionCanonicalPrinted_corrected
#print axioms MD.Ch06.stochasticMatrix
#print axioms MD.Ch06.finiteDistribution
#print axioms MD.Ch06.finiteDistribution_corrected
#print axioms MD.Ch06.finiteDistributionPrinted
#print axioms MD.Ch06.finiteDistributionPrinted_counterexample
#print axioms MD.Ch06.finiteEvolution
#print axioms MD.Ch06.finiteEvolutionRecurrence
#print axioms MD.Ch06.returnTimes
#print axioms MD.Ch06.period
#print axioms MD.Ch06.aperiodic
#print axioms MD.Ch06.irreducible
#print axioms MD.Ch06.finiteInvariant
#print axioms MD.Ch06.finiteErgodicity
#print axioms MD.Ch06.stochasticEntryBound
#print axioms MD.Ch06.finiteChainExample
#print axioms MD.Ch06.exampleStochastic
#print axioms MD.Ch06.exampleNotIrreducible
#print axioms MD.Ch06.communicates
#print axioms MD.Ch06.directedGraphIrreducible
#print axioms MD.Ch06.cylinderCoordinates
#print axioms MD.Ch06.cylinderSDE
#print axioms MD.Ch06.cylinderGenerator
#print axioms MD.Ch06.cylinderForwardPrinted
#print axioms MD.Ch06.stationaryDensity
#print axioms MD.Ch06.stationaryInvariant
#print axioms MD.Ch06.canonicalMixingMeaning
#print axioms MD.Ch06.langevinCanonicalMixing
#print axioms MD.Ch06.brownianGenerator
#print axioms MD.Ch06.brownianWeightedInner
#print axioms MD.Ch06.brownianDirichlet
#print axioms MD.Ch06.brownianSymmetry
#print axioms MD.Ch06.brownianNonpositive
#print axioms MD.Ch06.brownianNonpositive_corrected
#print axioms MD.Ch06.brownianRealEigenvalue
#print axioms MD.Ch06.brownianClosedSelfAdjoint
#print axioms MD.Ch06.brownianCompactResolvent
#print axioms MD.Ch06.brownianDiscreteSpectrum
#print axioms MD.Ch06.brownianSpectralGap
#print axioms MD.Ch06.theorem61
#print axioms MD.Ch06.theorem61_corrected
#print axioms MD.Ch06.theorem61Printed
#print axioms MD.Ch06.brownianMassGeneratorPrinted
#print axioms MD.Ch06.brownianMassGeneratorPrinted_corrected
#print axioms MD.Ch06.theorem61TimeAveragePrinted
#print axioms MD.Ch06.brownianEnsembleExponential
#print axioms MD.Ch06.theorem61TimeAveragePrinted_corrected
#print axioms MD.Ch06.brownianNegativeDefinitePrinted
#print axioms MD.Ch06.ouDensityPrinted
#print axioms MD.Ch06.ouDensity
#print axioms MD.Ch06.assumption1Printed
#print axioms MD.Ch06.assumption1
#print axioms MD.Ch06.assumption2
#print axioms MD.Ch06.minorizationPrinted
#print axioms MD.Ch06.minorizationCorrectedImplication
#print axioms MD.Ch06.theorem62
#print axioms MD.Ch06.periodicPotentialBound
#print axioms MD.Ch06.potentialNormalization
#print axioms MD.Ch06.unitLangevinModel
#print axioms MD.Ch06.periodicConfiningPrinted
#print axioms MD.Ch06.hamiltonianPower
#print axioms MD.Ch06.hamiltonianPowerCancellation
#print axioms MD.Ch06.hamiltonianPowerMomentumDerivative
#print axioms MD.Ch06.hamiltonianPowerMomentumLaplacian
#print axioms MD.Ch06.laplacianBoundPrinted
#print axioms MD.Ch06.laplacianBoundCounterexample
#print axioms MD.Ch06.hamiltonianPowerGenerator
#print axioms MD.Ch06.laplacianBoundCorrect
#print axioms MD.Ch06.lyapunovYoungBounds
#print axioms MD.Ch06.langevinLyapunov
#print axioms MD.Ch06.lieBracket
#print axioms MD.Ch06.lieBracketProperties
#print axioms MD.Ch06.definition61
#print axioms MD.Ch06.langevinDrift
#print axioms MD.Ch06.langevinNoise
#print axioms MD.Ch06.langevinNoiseBracket
#print axioms MD.Ch06.langevinBracketIndependent
#print axioms MD.Ch06.langevinHormander
#print axioms MD.Ch06.langevinTransitionDensity
#print axioms MD.Ch06.lemma61Printed
#print axioms MD.Ch06.lemma61Nonempty
#print axioms MD.Ch06.controlPath
#print axioms MD.Ch06.controlEndpointStable
#print axioms MD.Ch06.wienerControlTube
#print axioms MD.Ch06.langevinCanonicalStationary
#print axioms MD.Ch06.langevinGeometricErgodicity
#print axioms MD.Ch06.langevinTimeAverage
#print axioms MD.Ch06.weightedH1
#print axioms MD.Ch06.weightedH1Norm
#print axioms MD.Ch06.proposition64Printed
#print axioms MD.Ch06.proposition64Relative
#print axioms MD.Ch06.fredholmAlternative
#print axioms MD.Ch06.backwardKernelConstants
#print axioms MD.Ch06.forwardKernelGibbs
#print axioms MD.Ch06.weightedFunctionNorm
#print axioms MD.Ch06.weightedVectorNorm
#print axioms MD.Ch06.kernelEvolution
#print axioms MD.Ch06.kernelAverage
#print axioms MD.Ch06.densityEvolutionMeaning
#print axioms MD.Ch06.kernelDuality
#print axioms MD.Ch06.smoothTestL2Printed
#print axioms MD.Ch06.complexInitialDensity
#print axioms MD.Ch06.langevinForwardSemigroupMeaning
#print axioms MD.Ch06.complexEigenmodeDecay
