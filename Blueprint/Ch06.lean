import MolecularDynamics.Chapter06.Statements
import MolecularDynamics.Chapter02.ReviewProofs
import MolecularDynamics.Chapter02.EulerConvergence
import MolecularDynamics.Chapter02.ActualFlowVariations
import MolecularDynamics.Chapter02.LiouvilleVolume
import MolecularDynamics.Chapter02.HamiltonianVolume
import MolecularDynamics.Chapter01.Lagrangian
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

/-- source_id: MD-6.1.2-CanonicalCDFPrinted · unnumbered_claim · §6.1.2 · 印刷p.216 / PDFp.237
[ERRATUM?] [ERRATUM?]页末能量密度含ZA(α)，此前CDF却省略ZA(s)权重；一般ZA下两归一化CDF不相等。 -/
theorem canonicalCDFPrinted : ∀ (ZA ZB : ℝ → ℝ) (energy α : ℝ),
  Continuous ZA → Continuous ZB → (∀ e, 0 < ZA e) → (∀ e, 0 < ZB e) →
  0 < α → α < energy →
  (∫ s in 0..α, ZA s * ZB (energy-s)) / (∫ s in 0..energy, ZA s * ZB (energy-s)) =
  (∫ s in 0..α, ZB (energy-s)) / (∫ s in 0..energy, ZB (energy-s)) := by
  sorry

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

end MD.Ch06
