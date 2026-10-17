import MolecularDynamics.Chapter06.Statements
import Mathlib.MeasureTheory.Function.LpSpace.Indicator
import Mathlib.Analysis.Calculus.MeanValue
import MolecularDynamics.Chapter06.WienerStratonovich
import MolecularDynamics.Chapter06.WienerDeterministicLaw
import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Analysis.Calculus.Deriv.Shift
import Mathlib.Analysis.Calculus.Taylor
import Mathlib.Tactic
open Set Filter Matrix MeasureTheory ProbabilityTheory MolecularDynamics MolecularDynamics.Chapter06Review
open scoped BigOperators Topology ContDiff InnerProductSpace ENNReal NNReal Matrix.Norms.L2Operator
noncomputable section
set_option maxHeartbeats 500000
namespace MD.Ch06Short
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
def microcanonical {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (energy : ℝ) :=
  MolecularDynamics.Chapter05Review.microMeasure H energy

def entropy (kB : ℝ) (Z : ℝ → ℝ) (E : ℝ) : ℝ := kB * Real.log (Z E)

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

theorem entropyAdditivity :
  ∀ (kB ZA ZB : ℝ), 0 < ZA → 0 < ZB →
  kB*Real.log (ZA*ZB) = kB*Real.log ZA+kB*Real.log ZB := by
  intro kB ZA ZB hA hB
  rw [Real.log_mul hA.ne' hB.ne']
  ring

theorem entropyEquilibrium :
  ∀ (SA SB : ℝ → ℝ) (E e : ℝ),
  DifferentiableAt ℝ SA e → DifferentiableAt ℝ SB (E-e) →
  IsLocalMax (fun x ↦ SA x+SB (E-x)) e → deriv SA e = deriv SB (E-e) := by
  intro SA SB energy e hSA hSB hmax
  have hd := hSA.hasDerivAt.add (hSB.hasDerivAt.comp_const_sub energy e)
  have hz := hmax.hasDerivAt_eq_zero hd
  linarith

def temperature (S : ℝ → ℝ) (E : ℝ) : ℝ := (MolecularDynamics.Chapter06Review.inverseTemperature S E)⁻¹

def inverseThermal (kB T : ℝ) : ℝ := (kB * T)⁻¹

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

def canonicalEnergyDensity (Z : ℝ → ℝ) (β E : ℝ) : ℝ :=
  Z E * Real.exp (-β * E) / (∫ e, Z e * Real.exp (-β * e))

def entropyFunctional {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (kB : ℝ) (ρ : D → ℝ) : ℝ := -kB * ∫ x, ρ x * Real.log (ρ x) ∂ν

def constrainedEntropyModel {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H ρ : D → ℝ) (kB lambdaParam β meanEnergy : ℝ) : ℝ × Prop :=
  (MolecularDynamics.Chapter06Review.entropyFunctional ν kB ρ / kB -
    lambdaParam * ((∫ x, ρ x ∂ν)-1) - β * ((∫ x, H x * ρ x ∂ν)-meanEnergy),
    (∫ x, ρ x ∂ν) = 1 ∧ (∫ x, H x * ρ x ∂ν) = meanEnergy)

def canonicalDensity {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ) (x : D) : ℝ := Real.exp (-β * H x) / (∫ z, Real.exp (-β * H z) ∂ν)

def massHamiltonian {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (x : MolecularDynamics.Chapter06Review.Phase n) : ℝ :=
  (∑ i, (x.2 i) ^ 2 / (2 * m i)) + U x.1

theorem periodicPartitionBridge {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    textbookLangevinCanonicalPartition U β =
      textbookConfigurationPartition U β * (Real.sqrt (2 * Real.pi * β⁻¹)) ^ N := by
  apply MolecularDynamics.textbookLangevinCanonicalPartition_formula <;> assumption

theorem lennardJonesConfinement : ∀ ε : ℝ, 0 < ε → ∃ C : ℝ,
  ∀ q : ℝ, ε*q^2- C ≤ q⁻¹^12-q⁻¹^6+ε*q^2 := by
  intro ε hε
  refine ⟨1/4, ?_⟩
  intro q
  have hsq := sq_nonneg (q⁻¹^6 - 1/2)
  have heq : q⁻¹^12 = (q⁻¹^6)^2 := by ring
  rw [heq]
  nlinarith

theorem periodicWeightIntegrable {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    Integrable (textbookLangevinPeriodicGibbsWeight U β)
      (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) := by
  exact MolecularDynamics.textbookLangevinPeriodicGibbsWeight_integrable U hU hp β hβ

theorem periodicPartitionPositive {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) : 0 < textbookLangevinCanonicalPartition U β := by
  apply MolecularDynamics.textbookLangevinCanonicalPartition_pos <;> assumption

def polynomialObservable {n : ℕ} (f : textbookLangevinPeriodicPhase n → ℝ) : Prop :=
  ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |f x| ≤ C * (1 + ‖x.2‖) ^ r

def canonicalAveragePrinted {Nc : ℕ} (H : SymplecticCoordinates Nc → ℝ) (β : ℝ)
    (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ *
    ∫ z, f z * MolecularDynamics.Chapter06Review.canonicalDensity volume H β z

noncomputable def canonicalAverage {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ * ∫ z, f z * textbookHamiltonianGibbsWeight H β z

theorem canonicalAverageOne {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ)
    (hρ : Integrable (textbookHamiltonianGibbsWeight H β)) :
    textbookCanonicalAverage H β (fun _ ↦ 1) = 1 := by
  apply MolecularDynamics.textbookCanonicalAverage_one <;> assumption

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

theorem periodicBoundaryCancellation {Nc : ℕ}
    (F : Fin Nc → (Fin Nc → ℝ) → ℝ)
    (hF : ∀ i, ContDiff ℝ ∞ (F i))
    (hp : ∀ i, textbookUnitPeriodicPotential (F i)) :
    (∫ q in textbookConfigurationCube Nc,
      ∑ i, textbookConfigurationPartial (F i) i q) = 0 := by
  apply MolecularDynamics.textbookConfigurationCube_integral_divergence_eq_zero <;> assumption

def meanEnergyConstraint {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β meanEnergy : ℝ) : Prop :=
  (∫ z, H z * Real.exp (-β*H z) ∂ν) / (∫ z, Real.exp (-β*H z) ∂ν) = meanEnergy

theorem densityNormalization : ∀ {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ),
  Integrable (fun x ↦ Real.exp (-β*H x)) ν → 0 < (∫ x, Real.exp (-β*H x) ∂ν) →
  (∫ x, MolecularDynamics.Chapter06Review.canonicalDensity ν H β x ∂ν) = 1 := by
  intro D inst ν H β hI hZ
  simp only [MolecularDynamics.Chapter06Review.canonicalDensity]
  rw [integral_div]
  exact div_self hZ.ne' 

theorem weightedFluxIdentity {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (z : SymplecticCoordinates Nc)
    (hH : DifferentiableAt ℝ H z) (hG : DifferentiableAt ℝ G z) :
    textbookDivergence (fun x ↦ textbookHamiltonianGibbsWeight H β x • G x) z =
      textbookHamiltonianGibbsWeight H β z *
        (textbookDivergence G z - β * textbookLieDerivative G H z) := by
  apply MolecularDynamics.textbookCanonicalWeightedFlux_divergence <;> assumption

theorem virialFieldNotPeriodic : ∀ {n : ℕ} (i : Fin n) (q : Fin n → ℝ),
  q + Pi.single i 1 ≠ q := by
  intro n i q h
  have hi := congrFun h i
  simp at hi

theorem densityPositive : ∀ {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ),
  0 < (∫ z, Real.exp (-β*H z) ∂ν) →
  ∀ x, 0 < MolecularDynamics.Chapter06Review.canonicalDensity ν H β x := by
  intro D inst ν H β hZ x
  exact div_pos (Real.exp_pos _) hZ

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


def rademacherJumps {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun J P ∧ ∀ k,
    Measurable (J k) ∧ MemLp (J k) 2 P ∧
    (∀ᵐ sample ∂P, J k sample = 1 ∨ J k sample = -1) ∧ (∫ sample, J k sample ∂P) = 0

def randomWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω) : ℝ :=
  dx * ∑ k ∈ Finset.range n, J k sample

theorem walkRecurrence :
  ∀ {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω),
  MolecularDynamics.Chapter06Review.randomWalk J dx (n+1) sample = MolecularDynamics.Chapter06Review.randomWalk J dx n sample + dx*J n sample := by
  intro Ω J dx n sample
  simp only [MolecularDynamics.Chapter06Review.randomWalk, Finset.sum_range_succ]
  ring

theorem walkInitial : ∀ {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (sample : Ω),
  MolecularDynamics.Chapter06Review.randomWalk J dx 0 sample = 0 := by
  intro Ω J dx sample
  simp [MolecularDynamics.Chapter06Review.randomWalk]

def diffusiveWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dt : ℝ) : ℕ → Ω → ℝ :=
  MolecularDynamics.Chapter06Review.randomWalk J (Real.sqrt dt)

def interpolatedWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dt t : ℝ) (sample : Ω) : ℝ :=
  let n := Nat.floor (t / dt)
  MolecularDynamics.Chapter06Review.diffusiveWalk J dt n sample + (t - n * dt) / dt *
    (MolecularDynamics.Chapter06Review.diffusiveWalk J dt (n+1) sample - MolecularDynamics.Chapter06Review.diffusiveWalk J dt n sample)

def walkIncrement {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω) : ℝ :=
  MolecularDynamics.Chapter06Review.randomWalk J dx (n+1) sample - MolecularDynamics.Chapter06Review.randomWalk J dx n sample

def wienerVector {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω) : Prop :=
  MolecularDynamics.textbookIsWienerVector B P

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

theorem wienerFutureCompletedHistory
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (S : ℝ≥0) (T : ℝ) :
    Indep ((inferInstance : MeasurableSpace C(Icc (0 : ℝ) T, Fin Nc → ℝ)).comap
        (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T))
      (textbookWienerVectorCompletedFiltration B P hB S) P.completion := by
  apply MolecularDynamics.textbookWienerVectorFuture_independent_completed_filtration <;> assumption

theorem gridWienerIncrementLaw {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) (k : Fin K) :
    HasLaw (textbookWienerIncrement W T K k) (gaussianReal 0 (T / (K : ℝ≥0))) P := by
  apply MolecularDynamics.textbookWienerIncrement_hasLaw <;> assumption

theorem gridIncrementIndependent {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) :
    iIndepFun (textbookWienerIncrement W T K) P := by
  apply MolecularDynamics.textbookWienerIncrement_independent <;> assumption

theorem wienerContinuousPathEval {Nc : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (T : ℝ) (sample : Ω)
    (hc : Continuous (fun t ↦ B t sample)) (t : Icc 0 T) :
    textbookWienerVectorContinuousPath B T sample t = B ⟨t.1, t.2.1⟩ sample := by
  apply MolecularDynamics.textbookWienerVectorContinuousPath_eval <;> assumption

theorem wienerContinuousPathMeasurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (T : ℝ) :
    AEMeasurable (textbookWienerVectorContinuousPath B T) P := by
  apply MolecularDynamics.textbookWienerVectorContinuousPath_aemeasurable <;> assumption

def stateMarkovMeaning {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (X : ℝ≥0 → Ω → ℝ) (history : ℝ≥0 → MeasurableSpace Ω) : Prop :=
  ∀ s t : ℝ≥0, s ≤ t → ∀ a : Set ℝ, MeasurableSet a →
    MeasureTheory.condExp (history s) P (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample)) =ᵐ[P]
    MeasureTheory.condExp (MeasurableSpace.comap (X s) inferInstance) P
      (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample))

def itoLeftSum {Ω : Type*} (W g : ℝ → Ω → ℝ) (T : ℝ) (K : ℕ) (sample : Ω) : ℝ :=
  ∑ k ∈ Finset.range K, g ((k : ℝ) * T / K) sample *
    (W (((k : ℝ)+1) * T / K) sample - W ((k : ℝ) * T / K) sample)

def strictItoIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample,
    (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample-Y sample)^2 ∂P) atTop (𝓝 0)

def weakItoAlias {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample, (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample - Y sample)^2 ∂P) atTop (𝓝 0)

def stratonovichSum {Ω : Type*} (W g : ℝ → Ω → ℝ) (T : ℝ) (K : ℕ) (sample : Ω) : ℝ :=
  ∑ k ∈ Finset.range K, g (((k : ℝ)+1/2)*T/K) sample *
    (W (((k : ℝ)+1)*T/K) sample-W ((k : ℝ)*T/K) sample)

theorem selfItoFiniteIdentity {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    ∀ᵐ sample ∂P, 2 * textbookWienerSelfItoSum W T K sample =
      W T sample ^ 2 - textbookWienerQuadraticSum W T K sample := by
  apply MolecularDynamics.textbookWienerSelfItoSum_identity <;> assumption

theorem proposition62 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ sample,
      (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) atTop (𝓝 0) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_meanSquare_tendsto <;> assumption

def meanSquareConvergence {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (A : ℕ → Ω → ℝ) (B : Ω → ℝ) : Prop :=
  (∀ K, MemLp (A K) 2 P) ∧ MemLp B 2 P ∧
  Tendsto (fun K ↦ ∫ sample, (A K sample-B sample)^2 ∂P) atTop (𝓝 0)

noncomputable def wienerMidpointSum {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} (W : ℝ≥0 → Ω → ℝ) (T : ℝ≥0) (K : ℕ) : Ω → ℝ :=
  fun sample ↦ ∑ k : Fin K, W (textbookWienerTime T (2 * K) (2 * k.val + 1)) sample *
    textbookWienerIncrement W T K k sample

theorem gaussianIncrementMean {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}
    {X : Ω → ℝ} {v : ℝ≥0} (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ∂P) = 0 := by
  rw [hX.integral_eq, integral_id_gaussianReal]

theorem gaussianIncrementSecond {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ^ 2 ∂P) = (v : ℝ) := by
  apply MolecularDynamics.textbookCenteredGaussian_secondMoment <;> assumption

theorem gaussianIncrementFourth {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ^ 4 ∂P) = 3 * (v : ℝ) ^ 2 := by
  apply MolecularDynamics.textbookCenteredGaussian_fourthMoment <;> assumption

theorem quadraticMeanSquareError {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ sample, (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) =
      2 * (T : ℝ) ^ 2 / (K : ℝ) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_meanSquareError <;> assumption

theorem selfItoIntegral {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerSelfItoSum W T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ sample ∂P, Y sample = (W T sample ^ 2 - (T : ℝ)) / 2 := by
  apply MolecularDynamics.textbookWienerSelfItoIntegral_exists <;> assumption

theorem selfStratonovichIntegral {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerMidpointSum W T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ sample ∂P, Y sample = W T sample ^ 2 / 2 := by
  apply MolecularDynamics.textbookWienerSelfStratonovichIntegral_exists <;> assumption

theorem proposition63 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) {g : ℝ → ℝ} (hg : ContDiff ℝ 1 g) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerDeterministicSum W g T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧
      HasLaw Y (gaussianReal 0 (textbookWienerDeterministicVariance g T)) P ∧
      (∫ sample, Y sample ∂P) = 0 ∧ (∫ sample, Y sample ^ 2 ∂P) = ∫ x in (0 : ℝ)..T, g x ^ 2 := by
  apply MolecularDynamics.textbookWienerDeterministicIto_proposition63 <;> assumption

theorem quadraticSumExpectation {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ sample, textbookWienerQuadraticSum W T K sample ∂P) = (T : ℝ) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_integral <;> assumption

theorem selfItoLimitL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    MemLp (fun sample ↦ (W T sample ^ 2 - (T : ℝ)) / 2) 2 P := by
  apply MolecularDynamics.textbookWienerSelfItoLimit_memLp <;> assumption

theorem selfItoSumsL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    MemLp (textbookWienerSelfItoSum W T K) 2 P := by
  apply MolecularDynamics.textbookWienerSelfItoSum_memLp <;> assumption

theorem midpointSumsL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    MemLp (textbookWienerMidpointSum W T K) 2 P := by
  apply MolecularDynamics.textbookWienerMidpointSum_memLp <;> assumption

def deterministicIntegralProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W (fun s _ ↦ g s) T (Y T)

def stochasticDifferentialIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (Y integralOfDifferential : ℝ → Ω → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → integralOfDifferential T =ᵐ[P] (fun sample ↦ Y T sample-Y 0 sample)

def biasedWalk {Ω : Type*} (a b : ℝ → ℝ → ℝ) (J : ℕ → Ω → ℝ)
    (dt x0 : ℝ) : ℕ → Ω → ℝ
  | 0 => fun _ ↦ x0
  | n+1 => fun sample ↦ let x := MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 n sample
    x + a x (n * dt) * dt + b x (n * dt) * Real.sqrt dt * J n sample

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

def strictScalarSDE {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) : Prop :=
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  ∀ T : ℝ, 0 ≤ T → (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample) s) volume 0 T) ∧
    strictItoIntegral P W (fun s sample ↦ b (X s sample) s) T
      (fun sample ↦ X T sample-x0-∫ s in 0..T, a (X s sample) s)

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

def strictOUProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (γ σ x0 : ℝ) : Prop :=
  0 < γ ∧ strictScalarSDE P W X (fun x _ ↦ -γ*x) (fun _ _ ↦ σ) x0

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

def momentumOU {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W p : ℝ → Ω → MolecularDynamics.Chapter06Review.V n) (m : MolecularDynamics.Chapter06Review.V n) (γ θ : ℝ) (p0 : MolecularDynamics.Chapter06Review.V n) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧
  ∀ i, strictOUProcess P (fun t sample ↦ W t sample i) (fun t sample ↦ p t sample i) γ (Real.sqrt (2*γ*θ*m i)) (p0 i)

def gibbsGaussianDensity (θ m u : ℝ) : ℝ :=
  Real.exp (-(u^2/(2*m))/θ)/Real.sqrt (2*Real.pi*m*θ)

def bathHamiltonian {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (U : ℝ → ℝ) (Q P : ℝ) (q p : MolecularDynamics.Chapter06Review.V k) : ℝ :=
  P^2/2 + (∑ i, (p i)^2/(2*μ i)) + U Q + (∑ i, (q i-Q)^2)/(2*k)

def bathFrequency {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (i : Fin k) : ℝ := (Real.sqrt ((k : ℝ)*μ i))⁻¹

def bathForce {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (q0 p0 : MolecularDynamics.Chapter06Review.V k) (Q0 t : ℝ) : ℝ :=
  (k : ℝ)⁻¹ * ∑ i, (Real.cos (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)*(q0 i-Q0) +
    (MolecularDynamics.Chapter06Review.bathFrequency μ i)⁻¹ * Real.sin (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)*p0 i/μ i)

def bathForcePrinted {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (q0 p0 : MolecularDynamics.Chapter06Review.V k) (Q0 t : ℝ) : ℝ := -MolecularDynamics.Chapter06Review.bathForce μ q0 p0 Q0 t

def memoryKernel {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (t : ℝ) : ℝ :=
  (k : ℝ)⁻¹ * ∑ i, Real.cos (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)

def memoryKernelDeltaMeaning (masses : (k : ℕ) → (Fin k → ℝ)) (γ : ℝ) : Prop :=
  0 < γ ∧ ∀ f : ℝ → ℝ, ContDiff ℝ ∞ f → HasCompactSupport f →
    Tendsto (fun k ↦ ∫ t, MolecularDynamics.Chapter06Review.memoryKernel (masses k) t*f t)
      atTop (𝓝 (γ*f 0))

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

def particleDiagonalFriction {N : ℕ} (γ : Fin N → (Fin (N*3) → ℝ) → ℝ)
    (q : Fin (N*3) → ℝ) : Matrix (Fin (N*3)) (Fin (N*3)) ℝ :=
  Matrix.diagonal (fun i ↦ γ ⟨i.val/3, by omega⟩ q)

def brownianMassSDE {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W q : ℝ → Ω → MolecularDynamics.Chapter06Review.V n) (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (γ θ : ℝ) (q0 : MolecularDynamics.Chapter06Review.V n) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ ∞ U ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧ (∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T →
    IntervalIntegrable (fun s ↦ fun i ↦ -(γ*m i)⁻¹*textbookConfigurationPartial U i (q s sample))
      volume 0 T) ∧
  ∀ᵐ sample ∂P, ContinuousOn (fun t ↦ q t sample) (Ici 0) ∧ ∀ t ∈ Ici 0,
    q t sample = q0 + (∫ s in 0..t, fun i ↦ -(γ*m i)⁻¹*textbookConfigurationPartial U i (q s sample)) +
      fun i ↦ Real.sqrt (2*θ/(γ*m i))*(W t sample i-W 0 sample i)

def frequencyMemoryKernel {k : ℕ} (Ω : Fin k → ℝ) (t : ℝ) : ℝ :=
  (k : ℝ)⁻¹*∑ i, Real.cos (Ω i*t)

def figure64Frequencies {A : Type*} [MeasurableSpace A] (P : Measure A)
    (blue : Fin 400 → ℝ) (red green : Fin 1000 → A → ℝ) : Prop :=
  (∀ i, blue i=(1/100 : ℝ)*(i.val+1)) ∧
  (∀ i, HasLaw (red i) (volume.restrict (Icc (0 : ℝ) 1)) P) ∧
  ∀ i, HasLaw (fun sample ↦ green i sample/10) (volume.restrict (Icc (0 : ℝ) 1)) P

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

def scalarGenerator (a b f : ℝ → ℝ) (x : ℝ) : ℝ := a x*deriv f x + b x^2/2*deriv (deriv f) x

def polynomialSmooth (f : ℝ → ℝ) : Prop :=
  ContDiff ℝ ∞ f ∧ ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |f x| ≤ C*(1+|x|)^r

def scalarForward (a b ρ : ℝ → ℝ) (x : ℝ) : ℝ :=
  -deriv (fun z ↦ a z*ρ z) x + deriv (deriv (fun z ↦ b z^2*ρ z)) x/2

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

theorem zeroNoise :
  ∀ (a f ρ : ℝ → ℝ) (x : ℝ),
  MolecularDynamics.Chapter06Review.scalarGenerator a (fun _ ↦ 0) f x=a x*deriv f x ∧
    MolecularDynamics.Chapter06Review.scalarForward a (fun _ ↦ 0) ρ x = -deriv (fun z ↦ a z*ρ z) x := by
  intro a f ρ x
  constructor
  · simp [MolecularDynamics.Chapter06Review.scalarGenerator]
  · simp [MolecularDynamics.Chapter06Review.scalarForward]

def vectorForward {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorForward a B ρ x

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

def langevinMassForward {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (γ β : ℝ)
    (ρ : MolecularDynamics.Chapter06Review.Phase n → ℝ) (x : MolecularDynamics.Chapter06Review.Phase n) : ℝ :=
  ∑ i, (-(m i)⁻¹*x.2 i * fderiv ℝ ρ x (Pi.single i 1,0) +
    fderiv ℝ (fun z : MolecularDynamics.Chapter06Review.Phase n ↦ (textbookConfigurationPartial U i z.1+γ*z.2 i)*ρ z) x (0,Pi.single i 1) +
    γ*β⁻¹*m i*fderiv ℝ (fun z ↦ fderiv ℝ ρ z (0,Pi.single i 1)) x (0,Pi.single i 1))

def momentumMassLaplacian {n : ℕ} (m : Fin n → ℝ)
    (ρ : ((Fin n → ℝ) × (Fin n → ℝ)) → ℝ) (x : (Fin n → ℝ) × (Fin n → ℝ)) : ℝ :=
  ∑ i, m i*fderiv ℝ (fun y ↦ fderiv ℝ ρ y (0,Pi.single i 1)) x (0,Pi.single i 1)

theorem unitMassGibbsStationaryBridge {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : Differentiable ℝ U) (β γ σ : ℝ) (hβ : 0 < β)
    (hσ : σ ^ 2 = 2 * γ / β) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ σ (textbookLangevinGibbsWeight U β) z = 0 := by
  apply MolecularDynamics.textbookLangevinForwardDifferentialOperator_gibbs_eq_zero <;> assumption

def variableFrictionForward {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ)
    (ρ : ((Fin n → ℝ) × (Fin n → ℝ)) → ℝ) (x : (Fin n → ℝ) × (Fin n → ℝ)) : ℝ :=
  (∑ i, (-(m i)⁻¹*x.2 i*fderiv ℝ ρ x (Pi.single i 1,0) +
    fderiv ℝ (fun z ↦ (textbookConfigurationPartial U i z.1+
      ((Γ z.1*(Γ z.1).transpose).mulVec z.2) i)*ρ z) x (0,Pi.single i 1))) +
  ∑ i, ∑ k, θ*Real.sqrt (m i)*Real.sqrt (m k)*(Γ x.1*(Γ x.1).transpose) i k *
    fderiv ℝ (fun z ↦ fderiv ℝ ρ z (0,Pi.single k 1)) x (0,Pi.single i 1)

def stochasticMatrix {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop :=
  (∀ i j, 0 ≤ PiMark i j) ∧ ∀ i, ∑ j, PiMark i j = 1

def finiteDistribution {k : ℕ} (ψ : MolecularDynamics.Chapter06Review.V k) : Prop := (∀ i, 0 ≤ ψ i) ∧ ∑ i, ψ i = 1

def finiteEvolution {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (ψ : MolecularDynamics.Chapter06Review.V k) (n : ℕ) : MolecularDynamics.Chapter06Review.V k :=
  Matrix.vecMul ψ (PiMark^n)

def returnTimes {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (i : Fin k) : Set ℕ :=
  {n | 0 < n ∧ 0 < (PiMark^n) i i}

def period {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (i : Fin k) : ℕ :=
  sSup {d : ℕ | ∀ n ∈ MolecularDynamics.Chapter06Review.returnTimes PiMark i, d ∣ n}

def aperiodic {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop := ∀ i, MolecularDynamics.Chapter06Review.period PiMark i = 1

def irreducible {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop := ∀ i j, ∃ n : ℕ, 0 < (PiMark^n) i j

def finiteInvariant {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (ψ : MolecularDynamics.Chapter06Review.V k) : Prop :=
  MolecularDynamics.Chapter06Review.finiteDistribution ψ ∧ Matrix.vecMul ψ PiMark = ψ

def finiteChainExample : Matrix (Fin 5) (Fin 5) ℝ :=
  !![(1/5),(1/10),(7/10),0,0;
     0,0,0,1,0;
     (3/10),0,0,(3/10),(2/5);
     0,(1/2),0,(3/10),(1/5);
     0,0,0,1,0]

def communicates {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ) (i j : Fin k) : Prop :=
  (∃ n : ℕ, 0 < (matrix^n) i j) ∧ ∃ n : ℕ, 0 < (matrix^n) j i

theorem exampleStochastic : MolecularDynamics.Chapter06Review.stochasticMatrix finiteChainExample := by
  constructor
  · intro i j
    fin_cases i <;> fin_cases j <;> norm_num [finiteChainExample]
  · intro i
    fin_cases i <;> norm_num [finiteChainExample, Fin.sum_univ_succ]

end MD.Ch06Short
