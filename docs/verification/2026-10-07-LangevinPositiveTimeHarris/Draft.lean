import MolecularDynamics.Chapter06.LangevinHarrisAllTime
import MolecularDynamics.Chapter06.LangevinPositiveTimeDensity

/-! The explicit positive-time density version of the necessary original Theorem 6.2
Harris proof for the same actual Langevin kernel, its physical Hamiltonian weight,
and original measurable observables. No existence of a positive-time density is
assumed as a proved fact or deduced here. The literal printed time-zero clause
remains unchanged, with its positive-dimensional impossibility separately proved. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

local instance positiveTimeHarrisHaarMeasureSpace : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance positiveTimeHarrisHaarIsAddHaar : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance positiveTimeHarrisHaarProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

section PositiveTimeSkeletonInputs
variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)


include hB in
/-- The same actual kernel on one common positive skeleton time has derived proper H^l drift and, conditional on the explicit positive-time density clause on its derived large energy set, true measure minorization. -/
theorem textbookLangevinPeriodicPositiveTimeDensityClause_hamiltonian_power_skeleton_inputs
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
      ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
        textbookLangevinPeriodicHamiltonianPower U l
          ((0 : UnitAddTorus (Fin N)), (0 : Fin N → ℝ)) < R ∧
        IsCompact {x : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l x ≤ R} ∧
        (interior {x : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l x ≤ R}).Nonempty ∧
        (∀ x : textbookLangevinPeriodicPhase N, Integrable (textbookLangevinPeriodicHamiltonianPower U l)
          (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x)) ∧
        (∀ x : textbookLangevinPeriodicPhase N,
          (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
            ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) ≤
            (1 / 2 : ℝ) * textbookLangevinPeriodicHamiltonianPower U l x + D) ∧
        (∀ x : textbookLangevinPeriodicPhase N,
          (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
            ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) ≤
            (3 / 4 : ℝ) * textbookLangevinPeriodicHamiltonianPower U l x +
              {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R}.indicator
                (fun _ ↦ D) x) ∧
        (∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
          textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ
            {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ →
          ∃ (η : ℝ≥0∞) (ν : ProbabilityMeasure (textbookLangevinPeriodicPhase N)),
            0 < η ∧ η ≤ 1 ∧ η ≠ (⊤ : ℝ≥0∞) ∧
            ∀ x : textbookLangevinPeriodicPhase N, textbookLangevinPeriodicHamiltonianPower U l x ≤ R →
              η • (ν : Measure (textbookLangevinPeriodicPhase N)) ≤
                textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_large_sublevel_drift
    B P hB U hU hp L hF γ σ hLower hγ
  refine ⟨τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, R, hD, hR4, hR0, hd, ho⟩ := h l hl τ le_rfl
  have hC := textbookLangevinPeriodicHamiltonianPower_isCompact_sublevel U hU hp hLower l hl R
  have hCi := textbookLangevinPeriodicHamiltonianPower_sublevel_interior_nonempty U hU hp l R hR0
  refine ⟨D, R, hD, hR4, hR0, hC, hCi, ?_, hd, ?_, ?_⟩
  · intro x
    exact textbookLangevinPeriodicTransitionKernel_hamiltonian_power_integrable
      B P hB U hU hp hLower L hF γ σ hγ τ x l hl
  · intro x
    by_cases hx : textbookLangevinPeriodicHamiltonianPower U l x ≤ R
    · rw [Set.indicator_of_mem (show x ∈ {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} from hx)]
      have hh := hd x
      have hp := (textbookLangevinPeriodicHamiltonianPower_pos U hLower l x).le
      linarith
    · rw [Set.indicator_of_notMem (show x ∉ {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} from hx)]
      simpa only [add_zero] using ho x (lt_of_not_ge hx)
  · intro ρ hρ
    exact textbookLangevinPeriodicPositiveTimeDensityClause_compact_minorization_at_time
      B P hB U hU hp L hF γ σ _ ρ hρ hC hCi hσ τ hτ
end PositiveTimeSkeletonInputs

private theorem positiveTimeHarrisHalfDrift_constants (D R ε : ℝ) (hD : 0 < D) (hR : 4 * D < R)
    (hε : 0 < ε) (hε1 : ε < 1) :
    ∃ β : ℝ, 0 < β ∧ ∃ a : ℝ, 0 < a ∧ a < 1 ∧
      (∀ S : ℝ, R ≤ S → 2 + β * (S / 2 + 2 * D) ≤ a * (2 + β * S)) ∧
      (∀ S : ℝ, 0 ≤ S → 2 * (1 - ε) + β * (S / 2 + 2 * D) ≤ a * (2 + β * S)) := by
  let β := ε / (4 * D)
  have hβ : 0 < β := by dsimp only [β]; positivity
  have hβD : β * D = ε / 4 := by dsimp only [β]; field_simp [hD.ne']
  have hR0 : 0 < R := by linarith
  have hden : 0 < 2 + β * R := by positivity
  let aL := (2 + β * (R / 2 + 2 * D)) / (2 + β * R)
  let aS := 1 - ε / 2
  let a := max aL aS
  have haLhalf : (1 / 2 : ℝ) ≤ aL := by
    dsimp only [aL]
    apply (le_div_iff₀ hden).mpr
    nlinarith [mul_pos hβ hD]
  have haL1 : aL < 1 := by
    dsimp only [aL]
    apply (div_lt_one hden).mpr
    nlinarith [mul_pos hβ (show 0 < R / 2 - 2 * D by linarith)]
  have haS0 : 0 < aS := by dsimp only [aS]; linarith
  have haS1 : aS < 1 := by dsimp only [aS]; linarith
  have haShalf : (1 / 2 : ℝ) ≤ aS := by dsimp only [aS]; linarith
  have hrel : aL * (2 + β * R) = 2 + β * (R / 2 + 2 * D) := by
    dsimp only [aL]
    exact div_mul_cancel₀ _ hden.ne'
  refine ⟨β, hβ, a, haS0.trans_le (le_max_right _ _), max_lt haL1 haS1, ?_, ?_⟩
  · intro S hRS
    have hS0 : 0 ≤ S := hR0.le.trans hRS
    have hm := mul_le_mul_of_nonneg_right haLhalf (mul_nonneg hβ.le (sub_nonneg.mpr hRS))
    have hl : 2 + β * (S / 2 + 2 * D) ≤ aL * (2 + β * S) := by nlinarith
    exact hl.trans (mul_le_mul_of_nonneg_right (le_max_left _ _) (by positivity))
  · intro S hS0
    have hm := mul_le_mul_of_nonneg_right haShalf (mul_nonneg hβ.le hS0)
    have hl : 2 * (1 - ε) + β * (S / 2 + 2 * D) ≤ aS * (2 + β * S) := by
      dsimp only [aS] at hm ⊢
      nlinarith
    exact hl.trans (mul_le_mul_of_nonneg_right (le_max_right _ _) (by positivity))

private theorem phaseKernel_positiveTimeHalfDrift_weighted_contraction {N : ℕ}
    (K : Kernel (textbookLangevinPeriodicPhase N) (textbookLangevinPeriodicPhase N)) [IsMarkovKernel K]
    (V : textbookLangevinPeriodicPhase N → ℝ) (hV0 : ∀ x, 0 ≤ V x)
    (hVI : ∀ x, Integrable V (K x)) (D R : ℝ) (hD : 0 < D) (hR : 4 * D < R)
    (hd : ∀ x, (∫ y, V y ∂K x) ≤ (1 / 2 : ℝ) * V x + D)
    (ε : ℝ) (hε : 0 < ε) (hε1 : ε < 1)
    (ρ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hsmall : ∀ x, V x ≤ R → ENNReal.ofReal ε • (ρ : Measure (textbookLangevinPeriodicPhase N)) ≤ K x) :
    ∃ β : ℝ, 0 < β ∧ ∃ a : ℝ, 0 < a ∧ a < 1 ∧
      ∀ (f : textbookLangevinPeriodicPhase N → ℝ) (C : ℝ), Measurable f → 0 ≤ C →
        textbookLangevinWeightedOscillationBound V β f C →
        (∀ x, Integrable f (K x)) ∧
          Measurable (fun x ↦ ∫ y, f y ∂K x) ∧
          textbookLangevinWeightedOscillationBound V β (fun x ↦ ∫ y, f y ∂K x) (a * C) := by
  obtain ⟨β, hβ, a, ha, ha1, hbig, hlittle⟩ := positiveTimeHarrisHalfDrift_constants D R ε hD hR hε hε1
  let μ : textbookLangevinPeriodicPhase N → ProbabilityMeasure (textbookLangevinPeriodicPhase N) :=
    fun x ↦ ⟨K x, inferInstance⟩
  refine ⟨β, hβ, a, ha, ha1, fun f C hf hC hosc ↦ ?_⟩
  refine ⟨fun x ↦ textbookLangevinWeightedOscillationBound_integrable V β f C hf hosc (μ x) (hVI x),
    hf.stronglyMeasurable.integral_kernel.measurable, ?_⟩
  intro x y
  have hS0 : 0 ≤ V x + V y := add_nonneg (hV0 x) (hV0 y)
  have hm : (∫ z, V z ∂K x) + (∫ z, V z ∂K y) ≤ (V x + V y) / 2 + 2 * D := by
    linarith [hd x, hd y]
  by_cases hlarge : R ≤ V x + V y
  · have hp := textbookLangevinWeightedOscillationBound_integral_difference V β f C hf hosc
      (μ x) (μ y) (hVI x) (hVI y)
    calc
      _ ≤ C * (2 + β * ((∫ z, V z ∂K x) + ∫ z, V z ∂K y)) := hp
      _ ≤ C * (2 + β * ((V x + V y) / 2 + 2 * D)) :=
        mul_le_mul_of_nonneg_left (add_le_add le_rfl (mul_le_mul_of_nonneg_left hm hβ.le)) hC
      _ ≤ C * (a * (2 + β * (V x + V y))) :=
        mul_le_mul_of_nonneg_left (hbig _ hlarge) hC
      _ = _ := by ring
  · have hx : V x ≤ R := by have hy0 := hV0 y; linarith
    have hy : V y ≤ R := by have hx0 := hV0 x; linarith
    have hp := textbookLangevinWeightedOscillationBound_minorized_integral_difference V hV0 β hβ.le
      f C hC hf hosc (μ x) (μ y) ρ (hVI x) (hVI y) ε hε hε1 (hsmall x hx) (hsmall y hy)
    calc
      _ ≤ C * (2 * (1 - ε) + β * ((∫ z, V z ∂K x) + ∫ z, V z ∂K y)) := hp
      _ ≤ C * (2 * (1 - ε) + β * ((V x + V y) / 2 + 2 * D)) :=
        mul_le_mul_of_nonneg_left (add_le_add le_rfl (mul_le_mul_of_nonneg_left hm hβ.le)) hC
      _ ≤ C * (a * (2 + β * (V x + V y))) :=
        mul_le_mul_of_nonneg_left (hlittle _ hS0) hC
      _ = _ := by ring

/-- The same actual original Langevin skeleton has a genuine strict Hamiltonian-weighted oscillation contraction, conditional only on the explicit positive-time density clause on its actually derived large energy set. Drift, moments, residual laws and the contraction constants are derived. -/
theorem textbookLangevinPeriodicPositiveTimeDensityClause_hamiltonian_weighted_one_step_contraction
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (hLower : ∀ q, 1 ≤ U q)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
      ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
        ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
          textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ
            {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ →
          ∃ β : ℝ, 0 < β ∧ ∃ a : ℝ, 0 < a ∧ a < 1 ∧
            ∀ (f : textbookLangevinPeriodicPhase N → ℝ) (C : ℝ), Measurable f → 0 ≤ C →
              textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β f C →
              (∀ x, Integrable f (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x)) ∧
                Measurable (fun x ↦ ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) ∧
                textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β
                  (fun x ↦ ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) (a * C) := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicPositiveTimeDensityClause_hamiltonian_power_skeleton_inputs
    B P hB U hU hp L hF γ σ hLower hγ hσ
  refine ⟨τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, R, hD, hR4, _, _, _, hVI, hd, _, hm⟩ := h l hl
  refine ⟨D, R, hD, hR4, fun ρ hρ ↦ ?_⟩
  obtain ⟨η, ν, hη, hη1, hηtop, hsmall⟩ := hm ρ hρ
  let ε := η.toReal / 2
  have hηreal : 0 < η.toReal := ENNReal.toReal_pos hη.ne' hηtop
  have hηreal1 : η.toReal ≤ 1 := by simpa using ENNReal.toReal_mono (by simp) hη1
  have hε : 0 < ε := by dsimp only [ε]; positivity
  have hε1 : ε < 1 := by dsimp only [ε]; linarith
  have hscalar : ENNReal.ofReal ε ≤ η := by
    rw [← ENNReal.ofReal_toReal hηtop]
    apply ENNReal.ofReal_le_ofReal
    dsimp only [ε]
    linarith
  let K := textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ
  have : IsMarkovKernel K := textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ τ
  have hm' (x : textbookLangevinPeriodicPhase N) (hx : textbookLangevinPeriodicHamiltonianPower U l x ≤ R) :
      ENNReal.ofReal ε • (ν : Measure (textbookLangevinPeriodicPhase N)) ≤ K x := by
    apply Measure.le_iff.mpr
    intro A hA
    have hh := Measure.le_iff.mp (hsmall x hx) A hA
    rw [Measure.smul_apply, smul_eq_mul] at hh ⊢
    exact (mul_le_mul' hscalar le_rfl).trans hh
  exact phaseKernel_positiveTimeHalfDrift_weighted_contraction K
    (textbookLangevinPeriodicHamiltonianPower U l)
    (fun x ↦ (textbookLangevinPeriodicHamiltonianPower_pos U hLower l x).le)
    hVI D R hD hR4 hd ε hε hε1 ν hm'

section PositiveTimeSkeleton
private theorem invariantKernel_integral_of_integrable {N : ℕ}
    (K : Kernel (textbookLangevinPeriodicPhase N) (textbookLangevinPeriodicPhase N)) [IsMarkovKernel K]
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hInv : K ∘ₘ (μ : Measure (textbookLangevinPeriodicPhase N)) = μ)
    (f : textbookLangevinPeriodicPhase N → ℝ)
    (hf : Integrable f (μ : Measure (textbookLangevinPeriodicPhase N))) :
    (∫ x, ∫ y, f y ∂K x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) =
      ∫ x, f x ∂(μ : Measure (textbookLangevinPeriodicPhase N)) := by
  have hc : Integrable f ((K ∘ₖ Kernel.const Unit (μ : Measure (textbookLangevinPeriodicPhase N))) ()) := by
    rw [← Measure.comp_eq_comp_const_apply, hInv]
    exact hf
  have he := Kernel.integral_comp hc
  rw [← Measure.comp_eq_comp_const_apply, hInv] at he
  exact he.symm

private theorem actualHamiltonianPower_one_le {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hLower : ∀ q, 1 ≤ U q) (l : ℕ)
    (x : textbookLangevinPeriodicPhase N) :
    1 ≤ textbookLangevinPeriodicHamiltonianPower U l x := by
  have hkin : 0 ≤ ∑ i : Fin N, x.2 i ^ 2 := Finset.sum_nonneg (fun i _ ↦ sq_nonneg _)
  have hH : 1 ≤ (∑ i : Fin N, x.2 i ^ 2) / 2 + U (textbookLangevinPeriodicRepresentative x.1) := by
    linarith [hLower (textbookLangevinPeriodicRepresentative x.1)]
  change 1 ≤ ((∑ i : Fin N, x.2 i ^ 2) / 2 + U (textbookLangevinPeriodicRepresentative x.1)) ^ l
  simpa only [one_pow] using pow_le_pow_left₀ (by norm_num : (0 : ℝ) ≤ 1) hH l

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB in
private theorem actualSkeleton_oscillation_iterate
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (τ : ℝ≥0) (l : ℕ) (hl : 1 ≤ l)
    (β a : ℝ) (ha : 0 ≤ a)
    (hstep : ∀ (g : textbookLangevinPeriodicPhase N → ℝ) (A : ℝ), Measurable g → 0 ≤ A →
      textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β g A →
      (∀ x, Integrable g (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x)) ∧
        Measurable (fun x ↦ ∫ y, g y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) ∧
        textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β
          (fun x ↦ ∫ y, g y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) (a * A))
    (f : textbookLangevinPeriodicPhase N → ℝ) (C : ℝ) (hf : Measurable f) (hC : 0 ≤ C)
    (hosc : textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β f C) :
    (∀ (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N),
      Integrable f (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x)) ∧
    ∀ n : ℕ, Measurable (fun x ↦ ∫ y, f y
      ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x) ∧
      textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β
        (fun x ↦ ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x)
        (a ^ n * C) := by
  let K := textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ
  let V := textbookLangevinPeriodicHamiltonianPower U l
  let F := fun (n : ℕ) (x : textbookLangevinPeriodicPhase N) ↦ ∫ y, f y ∂K ((n : ℝ≥0) * τ) x
  have hfK (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N) : Integrable f (K T x) := by
    have : IsMarkovKernel (K T) := textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ T
    let μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N) := ⟨K T x, inferInstance⟩
    exact textbookLangevinWeightedOscillationBound_integrable V β f C hf hosc μ
      (textbookLangevinPeriodicTransitionKernel_hamiltonian_power_integrable B P hB U hU hp hLower L hF γ σ hγ T x l hl)
  have hFm (n : ℕ) : Measurable (F n) := hf.stronglyMeasurable.integral_kernel.measurable
  have hF0 (x : textbookLangevinPeriodicPhase N) : F 0 x = f x := by
    dsimp only [F, K]
    rw [Nat.cast_zero, zero_mul, textbookLangevinPeriodicTransitionKernel_zero B P hB U hU hp L hF γ σ,
      Kernel.id_apply, integral_dirac]
  have hFsucc (n : ℕ) (x : textbookLangevinPeriodicPhase N) :
      F (n + 1) x = ∫ y, F n y ∂K τ x := by
    let S : ℝ≥0 := (n : ℝ≥0) * τ
    have : IsMarkovKernel (K S) := textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ S
    have : IsMarkovKernel (K τ) := textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ τ
    have ht : ((n + 1 : ℕ) : ℝ≥0) * τ = S + τ := by dsimp only [S]; push_cast; ring
    have hCK : K (S + τ) = K S ∘ₖ K τ := by
      rw [add_comm S τ]
      exact textbookLangevinPeriodicTransitionKernel_add B P hB U hU hp L hF γ σ τ S
    have hi : Integrable f ((K S ∘ₖ K τ) x) := by rw [← hCK]; exact hfK (S + τ) x
    change (∫ y, f y ∂K (((n + 1 : ℕ) : ℝ≥0) * τ) x) = _
    rw [ht, hCK]
    exact Kernel.integral_comp hi
  refine ⟨hfK, fun n ↦ ⟨hFm n, ?_⟩⟩
  change textbookLangevinWeightedOscillationBound V β (F n) (a ^ n * C)
  induction n with
  | zero =>
      intro x y
      rw [hF0 x, hF0 y, pow_zero, one_mul]
      exact hosc x y
  | succ n hn =>
      have hh := hstep (F n) (a ^ n * C) (hFm n) (mul_nonneg (pow_nonneg ha n) hC) hn
      intro x y
      rw [hFsucc n x, hFsucc n y]
      calc
        _ ≤ (a * (a ^ n * C)) * (2 + β * (V x + V y)) := hh.2.2 x y
        _ = _ := by rw [pow_succ]; ring

include hB in
/-- True Chapman–Kolmogorov integrals of the actual kernel iterate the derived strict weighted oscillation factor to a^n for all measurable unbounded weighted observables. -/
theorem textbookLangevinPeriodicPositiveTimeDensityClause_hamiltonian_weighted_skeleton_contraction
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
      ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
        ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
          textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ
            {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ →
          ∃ β : ℝ, 0 < β ∧ ∃ a : ℝ, 0 < a ∧ a < 1 ∧
            ∀ (f : textbookLangevinPeriodicPhase N → ℝ) (C : ℝ), Measurable f → 0 ≤ C →
              textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β f C →
              (∀ (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N),
                Integrable f (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x)) ∧
              ∀ n : ℕ, Measurable (fun x ↦ ∫ y, f y
                ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x) ∧
                textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β
                  (fun x ↦ ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x)
                  (a ^ n * C) := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicPositiveTimeDensityClause_hamiltonian_weighted_one_step_contraction
    B P hB U hU hp hLower L hF γ σ hγ hσ
  refine ⟨τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, R, hD, hR, hd⟩ := h l hl
  refine ⟨D, R, hD, hR, fun ρ hρ ↦ ?_⟩
  obtain ⟨β, hβ, a, ha, ha1, hstep⟩ := hd ρ hρ
  exact ⟨β, hβ, a, ha, ha1, fun f C hf hC hosc ↦
    actualSkeleton_oscillation_iterate B P hB U hU hp L hF γ σ hLower hγ τ l hl β a ha.le hstep f C hf hC hosc⟩

include hB in
/-- The same actual skeleton expectations approach every genuine full-time invariant law with the derived a^n weighted bound; the target invariant-law moment is derived, not assumed. -/
theorem textbookLangevinPeriodicPositiveTimeDensityClause_hamiltonian_weighted_skeleton_geometric_bound
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
      ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
        ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
          textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ
            {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ →
          ∃ β : ℝ, 0 < β ∧ ∃ a : ℝ, 0 < a ∧ a < 1 ∧
            ∀ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
              (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
                (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) →
              ∀ (f : textbookLangevinPeriodicPhase N → ℝ) (C : ℝ), Measurable f → 0 ≤ C →
                textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β f C →
                ∀ (n : ℕ) (x : textbookLangevinPeriodicPhase N),
                  ‖(∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x) -
                      ∫ y, f y ∂(μ : Measure (textbookLangevinPeriodicPhase N))‖ ≤
                    (a ^ n * C) * (2 + β * (textbookLangevinPeriodicHamiltonianPower U l x +
                      ∫ y, textbookLangevinPeriodicHamiltonianPower U l y
                        ∂(μ : Measure (textbookLangevinPeriodicPhase N)))) := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicPositiveTimeDensityClause_hamiltonian_weighted_skeleton_contraction
    B P hB U hU hp L hF γ σ hLower hγ hσ
  refine ⟨τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, R, hD, hR, hd⟩ := h l hl
  refine ⟨D, R, hD, hR, fun ρ hρ ↦ ?_⟩
  obtain ⟨β, hβ, a, ha, ha1, hi⟩ := hd ρ hρ
  refine ⟨β, hβ, a, ha, ha1, fun μ hμ f C hf hC hosc n x ↦ ?_⟩
  let V := textbookLangevinPeriodicHamiltonianPower U l
  have hVμ : Integrable V (μ : Measure (textbookLangevinPeriodicPhase N)) :=
    (textbookLangevinPeriodicInvariant_all_hamiltonian_power_moments B P hB U hU hp L hF γ σ
      hLower hγ μ hμ l hl).1
  have hfμ := textbookLangevinWeightedOscillationBound_integrable V β f C hf hosc μ hVμ
  have hiF := hi f C hf hC hosc
  let δ : ProbabilityMeasure (textbookLangevinPeriodicPhase N) := ⟨Measure.dirac x, inferInstance⟩
  have hVδ : Integrable V (δ : Measure (textbookLangevinPeriodicPhase N)) := by
    change Integrable V (Measure.dirac x)
    exact integrable_dirac (by finiteness)
  have hh := textbookLangevinWeightedOscillationBound_integral_difference V β
    (fun z ↦ ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) z)
    (a ^ n * C) (hiF.2 n).1 (hiF.2 n).2 δ μ hVδ hVμ
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ)) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ _
  have he := invariantKernel_integral_of_integrable
    (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ)) μ (hμ _) f hfμ
  have hδeq : (δ : Measure (textbookLangevinPeriodicPhase N)) = Measure.dirac x := rfl
  rw [hδeq, integral_dirac, integral_dirac] at hh
  rw [he] at hh
  exact hh

include hB in
/-- For the original observables |f|≤H^l, one true constant M independent of f, n and the initial phase gives the same actual skeleton's original H^l geometric error bound. -/
theorem textbookLangevinPeriodicPositiveTimeDensityClause_original_observable_skeleton_geometric_bound
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
      ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
        ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
          textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ
            {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ →
          ∃ a : ℝ, 0 < a ∧ a < 1 ∧
            ∀ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
              (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
                (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) →
              ∃ M : ℝ, 0 < M ∧ ∀ f : textbookLangevinPeriodicPhase N → ℝ, Measurable f →
                (∀ x, |f x| ≤ textbookLangevinPeriodicHamiltonianPower U l x) →
                ∀ (n : ℕ) (x : textbookLangevinPeriodicPhase N),
                  ‖(∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x) -
                      ∫ y, f y ∂(μ : Measure (textbookLangevinPeriodicPhase N))‖ ≤
                    M * a ^ n * textbookLangevinPeriodicHamiltonianPower U l x := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicPositiveTimeDensityClause_hamiltonian_weighted_skeleton_geometric_bound
    B P hB U hU hp L hF γ σ hLower hγ hσ
  refine ⟨τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, R, hD, hR, hd⟩ := h l hl
  refine ⟨D, R, hD, hR, fun ρ hρ ↦ ?_⟩
  obtain ⟨β, hβ, a, ha, ha1, hg⟩ := hd ρ hρ
  refine ⟨a, ha, ha1, fun μ hμ ↦ ?_⟩
  let V := textbookLangevinPeriodicHamiltonianPower U l
  let A := ∫ y, V y ∂(μ : Measure (textbookLangevinPeriodicPhase N))
  have hA : 0 ≤ A := integral_nonneg (fun x ↦ (textbookLangevinPeriodicHamiltonianPower_pos U hLower l x).le)
  let M := 2 * β⁻¹ + 1 + A
  have hβinv : 0 ≤ β⁻¹ := inv_nonneg.mpr hβ.le
  have hM : 0 < M := by
    dsimp only [M]
    linarith [mul_nonneg (by norm_num : (0 : ℝ) ≤ 2) hβinv]
  have hweight (S : ℝ) : β⁻¹ * (2 + β * S) = 2 * β⁻¹ + S := by
    field_simp [hβ.ne']
  refine ⟨M, hM, fun f hf hdom n x ↦ ?_⟩
  have hosc : textbookLangevinWeightedOscillationBound V β f β⁻¹ := by
    intro y z
    have hh : ‖f y - f z‖ ≤ V y + V z :=
      (norm_sub_le _ _).trans (add_le_add
        (by simpa only [Real.norm_eq_abs] using hdom y) (by simpa only [Real.norm_eq_abs] using hdom z))
    rw [hweight]
    exact hh.trans (le_add_of_nonneg_left (mul_nonneg (by norm_num) hβinv))
  have hh := hg μ hμ f β⁻¹ hf hβinv hosc n x
  have hx1 := actualHamiltonianPower_one_le U hLower l x
  have hm : 2 * β⁻¹ + V x + A ≤ M * V x := by
    have hnonneg : 0 ≤ 2 * β⁻¹ + A := add_nonneg (mul_nonneg (by norm_num) hβinv) hA
    have hs := mul_le_mul_of_nonneg_left hx1 hnonneg
    dsimp only [M]
    nlinarith
  calc
    _ ≤ (a ^ n * β⁻¹) * (2 + β * (V x + A)) := hh
    _ = a ^ n * (2 * β⁻¹ + V x + A) := by rw [mul_assoc, hweight]; ring
    _ ≤ a ^ n * (M * V x) := mul_le_mul_of_nonneg_left hm (pow_nonneg ha.le n)
    _ = _ := by ring

include hB in
/-- The real strict skeleton contraction forces any two genuine full-time invariant probability laws of the same actual original Langevin kernel to agree. No uniqueness conclusion is assumed. -/
theorem textbookLangevinPeriodicPositiveTimeDensityClause_invariant_unique
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
      ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
        textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ
          {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U 1 z ≤ R} ρ →
        ∀ μ ν : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
          (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
            (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) →
          (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
            (ν : Measure (textbookLangevinPeriodicPhase N)) = ν) → μ = ν := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicPositiveTimeDensityClause_hamiltonian_weighted_skeleton_contraction
    B P hB U hU hp L hF γ σ hLower hγ hσ
  obtain ⟨D, R, hD, hR, hd⟩ := h 1 le_rfl
  refine ⟨τ, hτ, D, R, hD, hR, fun ρ hρ μ ν hμ hν ↦ ?_⟩
  obtain ⟨β, hβ, a, ha, ha1, hi⟩ := hd ρ hρ
  let V := textbookLangevinPeriodicHamiltonianPower U 1
  have hVμ : Integrable V (μ : Measure (textbookLangevinPeriodicPhase N)) :=
    (textbookLangevinPeriodicInvariant_all_hamiltonian_power_moments B P hB U hU hp L hF γ σ
      hLower hγ μ hμ 1 le_rfl).1
  have hVν : Integrable V (ν : Measure (textbookLangevinPeriodicPhase N)) :=
    (textbookLangevinPeriodicInvariant_all_hamiltonian_power_moments B P hB U hU hp L hF γ σ
      hLower hγ ν hν 1 le_rfl).1
  apply (ProbabilityMeasure.toFiniteMeasure_isEmbedding (textbookLangevinPeriodicPhase N)).injective
  apply FiniteMeasure.ext_of_forall_integral_eq
  intro f
  change (∫ x, f x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) =
    ∫ x, f x ∂(ν : Measure (textbookLangevinPeriodicPhase N))
  have hosc : textbookLangevinWeightedOscillationBound V β f ‖f‖ := by
    intro x y
    have hh : ‖f x - f y‖ ≤ ‖f‖ + ‖f‖ := (norm_sub_le _ _).trans
      (add_le_add (f.norm_coe_le_norm x) (f.norm_coe_le_norm y))
    have hS : 0 ≤ V x + V y := add_nonneg
      (textbookLangevinPeriodicHamiltonianPower_pos U hLower 1 x).le
      (textbookLangevinPeriodicHamiltonianPower_pos U hLower 1 y).le
    have hn := mul_nonneg (norm_nonneg f) (mul_nonneg hβ.le hS)
    nlinarith
  have hifμ := textbookLangevinWeightedOscillationBound_integrable V β f ‖f‖ f.continuous.measurable hosc μ hVμ
  have hifν := textbookLangevinWeightedOscillationBound_integrable V β f ‖f‖ f.continuous.measurable hosc ν hVν
  have hiF := hi f ‖f‖ f.continuous.measurable (norm_nonneg f) hosc
  have hbound (n : ℕ) :
      ‖(∫ x, f x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) -
          ∫ x, f x ∂(ν : Measure (textbookLangevinPeriodicPhase N))‖ ≤
        a ^ n * ‖f‖ * (2 + β * ((∫ x, V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) +
          ∫ x, V x ∂(ν : Measure (textbookLangevinPeriodicPhase N)))) := by
    have hh := textbookLangevinWeightedOscillationBound_integral_difference V β
      (fun z ↦ ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) z)
      (a ^ n * ‖f‖) (hiF.2 n).1 (hiF.2 n).2 μ ν hVμ hVν
    have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ)) :=
      textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ _
    have hIμ := invariantKernel_integral_of_integrable
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ)) μ (hμ _) f hifμ
    have hIν := invariantKernel_integral_of_integrable
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ)) ν (hν _) f hifν
    rw [hIμ, hIν] at hh
    exact hh
  have hzlim : Tendsto (fun n : ℕ ↦ a ^ n * ‖f‖ *
      (2 + β * ((∫ x, V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) +
        ∫ x, V x ∂(ν : Measure (textbookLangevinPeriodicPhase N))))) atTop (𝓝 0) := by
    simpa only [zero_mul] using
      ((tendsto_pow_atTop_nhds_zero_of_lt_one ha.le ha1).mul_const ‖f‖).mul_const
        (2 + β * ((∫ x, V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) +
          ∫ x, V x ∂(ν : Measure (textbookLangevinPeriodicPhase N))))
  have hz : ‖(∫ x, f x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) -
      ∫ x, f x ∂(ν : Measure (textbookLangevinPeriodicPhase N))‖ ≤ 0 :=
    le_of_tendsto_of_tendsto tendsto_const_nhds hzlim (Eventually.of_forall hbound)
  exact sub_eq_zero.mp (norm_eq_zero.mp (le_antisymm hz (norm_nonneg _)))

include hB in
/-- The already constructed genuine actual all-time invariant probability is unique under the original density clause on the actual derived energy set; neither existence nor uniqueness is put into assumptions. -/
theorem textbookLangevinPeriodicPositiveTimeDensityClause_invariant_existsUnique
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
      ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
        textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ
          {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U 1 z ≤ R} ρ →
        ∃! μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N), ∀ T : ℝ≥0,
          textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
            (μ : Measure (textbookLangevinPeriodicPhase N)) = μ := by
  obtain ⟨τ, hτ, D, R, hD, hR, hu⟩ := textbookLangevinPeriodicPositiveTimeDensityClause_invariant_unique
    B P hB U hU hp L hF γ σ hLower hγ hσ
  refine ⟨τ, hτ, D, R, hD, hR, fun ρ hρ ↦ ?_⟩
  obtain ⟨μ, hμ⟩ := textbookLangevinPeriodicTransitionKernel_invariant_exists
    B P hB U hU hp L hF γ σ hLower hγ
  exact ⟨μ, hμ, fun ν hν ↦ hu ρ hρ ν μ hν hμ⟩
end PositiveTimeSkeleton

section PositiveTimeAllTime
private theorem floor_geometric_exponential (a tau : ℝ) (ha : 0 < a) (ha1 : a < 1)
    (htau : 0 < tau) :
    ∃ rate : ℝ, 0 < rate ∧ ∀ t : ℝ, 0 ≤ t →
      a ^ (Nat.floor (t / tau)) ≤ a⁻¹ * Real.exp (-rate * t) := by
  let rate : ℝ := -Real.log a / tau
  have hlog : Real.log a < 0 := Real.log_neg ha ha1
  have hr : 0 < rate := div_pos (neg_pos.mpr hlog) htau
  refine ⟨rate, hr, fun t _ht ↦ ?_⟩
  let n := Nat.floor (t / tau)
  have hn : t / tau - 1 ≤ (n : ℝ) := by
    have hh := Nat.lt_floor_add_one (t / tau)
    dsimp only [n]
    linarith
  have hprod : (n : ℝ) * Real.log a ≤ (t / tau - 1) * Real.log a :=
    mul_le_mul_of_nonpos_right hn hlog.le
  calc
    _ = Real.exp ((n : ℝ) * Real.log a) := by rw [Real.exp_nat_mul, Real.exp_log ha]
    _ ≤ Real.exp ((t / tau - 1) * Real.log a) := Real.exp_le_exp.mpr hprod
    _ = a⁻¹ * Real.exp (-rate * t) := by
      have he : (t / tau - 1) * Real.log a = -Real.log a + -rate * t := by
        dsimp only [rate]
        ring
      rw [he, Real.exp_add, Real.exp_neg, Real.exp_log ha]

private theorem energy_weight_one_le {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hLower : ∀ q, 1 ≤ U q) (l : ℕ)
    (x : textbookLangevinPeriodicPhase N) :
    1 ≤ textbookLangevinPeriodicHamiltonianPower U l x := by
  have hk : 0 ≤ ∑ i : Fin N, x.2 i ^ 2 := Finset.sum_nonneg (fun i _ ↦ sq_nonneg _)
  have hh : 1 ≤ (∑ i : Fin N, x.2 i ^ 2) / 2 + U (textbookLangevinPeriodicRepresentative x.1) := by
    linarith [hLower (textbookLangevinPeriodicRepresentative x.1)]
  change 1 ≤ ((∑ i : Fin N, x.2 i ^ 2) / 2 + U (textbookLangevinPeriodicRepresentative x.1)) ^ l
  simpa only [one_pow] using pow_le_pow_left₀ (by norm_num : (0 : ℝ) ≤ 1) hh l

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB in
/-- For the original measurable observables |f|≤H^l, the same actual original kernel satisfies the genuine all-time exponential bound (6.48) with constants uniform in f, time and initial phase. The invariant moment is derived; the density clause on the derived set remains explicit. -/
theorem textbookLangevinPeriodicPositiveTimeDensityClause_original_observable_exponential_bound
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
      ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
        ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
          textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ
            {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ →
          ∀ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
            (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
              (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) →
            ∃ M rate : ℝ, 0 < M ∧ 0 < rate ∧
              ∀ f : textbookLangevinPeriodicPhase N → ℝ, Measurable f →
                (∀ x, |f x| ≤ textbookLangevinPeriodicHamiltonianPower U l x) →
                ∀ (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N),
                  ‖(∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) -
                      ∫ y, f y ∂(μ : Measure (textbookLangevinPeriodicPhase N))‖ ≤
                    M * Real.exp (-rate * (T : ℝ)) * textbookLangevinPeriodicHamiltonianPower U l x := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicPositiveTimeDensityClause_original_observable_skeleton_geometric_bound
    B P hB U hU hp L hF γ σ hLower hγ hσ
  have htau : 0 < (τ : ℝ) := hτ
  refine ⟨τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, R, hD, hR, hd⟩ := h l hl
  obtain ⟨A, Q, hA, hQ, hmoment⟩ := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_bounded_time
    B P hB U hU hp hLower L hF γ σ hγ τ hτ l hl
  refine ⟨D, R, hD, hR, fun ρ hρ μ hμ ↦ ?_⟩
  obtain ⟨a, ha, ha1, hsk⟩ := hd ρ hρ
  obtain ⟨C, hC, hbound⟩ := hsk μ hμ
  obtain ⟨rate, hrate, hexp⟩ := floor_geometric_exponential a τ ha ha1 htau
  let M : ℝ := C * (A + Q) * a⁻¹
  have hM : 0 < M := mul_pos (mul_pos hC (add_pos hA hQ)) (inv_pos.mpr ha)
  refine ⟨M, rate, hM, hrate, fun f hf hdom T x ↦ ?_⟩
  let K := textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ
  let V := textbookLangevinPeriodicHamiltonianPower U l
  have hVi (s : ℝ≥0) (z : textbookLangevinPeriodicPhase N) : Integrable V (K s z) :=
    textbookLangevinPeriodicTransitionKernel_hamiltonian_power_integrable B P hB U hU hp hLower L hF γ σ hγ s z l hl
  have hfi (s : ℝ≥0) (z : textbookLangevinPeriodicPhase N) : Integrable f (K s z) := by
    apply (hVi s z).mono' hf.aestronglyMeasurable
    exact Eventually.of_forall (fun y ↦ by simpa only [Real.norm_eq_abs] using hdom y)
  let n := Nat.floor ((T : ℝ) / (τ : ℝ))
  let S : ℝ≥0 := (n : ℝ≥0) * τ
  have hST : S ≤ T := by
    change (n : ℝ) * (τ : ℝ) ≤ (T : ℝ)
    exact (le_div_iff₀ htau).mp (Nat.floor_le (div_nonneg T.property htau.le))
  let r : ℝ≥0 := T - S
  have hrS : r + S = T := tsub_add_cancel_of_le hST
  have hrτ : r ≤ τ := by
    change ((T - S : ℝ≥0) : ℝ) ≤ (τ : ℝ)
    rw [NNReal.coe_sub hST]
    change (T : ℝ) - (n : ℝ) * (τ : ℝ) ≤ (τ : ℝ)
    have hh : (T : ℝ) < ((n : ℝ) + 1) * (τ : ℝ) :=
      (div_lt_iff₀ htau).mp (Nat.lt_floor_add_one ((T : ℝ) / (τ : ℝ)))
    nlinarith
  have : IsMarkovKernel (K r) := textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ r
  have : IsMarkovKernel (K S) := textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ S
  have hCK : K T = K S ∘ₖ K r := by
    rw [← hrS]
    exact textbookLangevinPeriodicTransitionKernel_add B P hB U hU hp L hF γ σ r S
  have hi : Integrable f ((K S ∘ₖ K r) x) := by rw [← hCK]; exact hfi T x
  let F := fun z ↦ ∫ y, f y ∂K S z
  let m := ∫ y, f y ∂(μ : Measure (textbookLangevinPeriodicPhase N))
  have hF : Integrable F (K r x) := hi.integral_comp
  have hdiff : Integrable (fun z ↦ F z - m) (K r x) := hF.sub (integrable_const m)
  have hEq : (∫ y, f y ∂K T x) - m = ∫ z, F z - m ∂K r x := by
    rw [hCK, Kernel.integral_comp hi, integral_sub hF (integrable_const m)]
    simp only [F, integral_const, probReal_univ, one_smul]
  have hVx : 1 ≤ V x := energy_weight_one_le U hLower l x
  have hAQ : A * V x + Q ≤ (A + Q) * V x := by
    have hh := mul_le_mul_of_nonneg_left hVx hQ.le
    nlinarith
  have hb (z : textbookLangevinPeriodicPhase N) : ‖F z - m‖ ≤ C * a ^ n * V z :=
    hbound f hf hdom n z
  have hCV : Integrable (fun z ↦ C * a ^ n * V z) (K r x) := (hVi r x).const_mul _
  have hp : 0 ≤ C * a ^ n := mul_nonneg hC.le (pow_nonneg ha.le n)
  have hV0 : 0 ≤ V x := le_trans (by norm_num) hVx
  calc
    _ = ‖∫ z, F z - m ∂K r x‖ := congrArg norm hEq
    _ ≤ ∫ z, ‖F z - m‖ ∂K r x := norm_integral_le_integral_norm _
    _ ≤ ∫ z, C * a ^ n * V z ∂K r x := integral_mono_ae hdiff.norm hCV (Eventually.of_forall hb)
    _ = C * a ^ n * ∫ z, V z ∂K r x := integral_const_mul _ _
    _ ≤ C * a ^ n * (A * V x + Q) := mul_le_mul_of_nonneg_left (hmoment r hrτ x) hp
    _ ≤ C * a ^ n * ((A + Q) * V x) := mul_le_mul_of_nonneg_left hAQ hp
    _ = (C * (A + Q) * V x) * a ^ n := by ring
    _ ≤ (C * (A + Q) * V x) * (a⁻¹ * Real.exp (-rate * (T : ℝ))) :=
      mul_le_mul_of_nonneg_left (hexp T T.property) (mul_nonneg (mul_nonneg hC.le (add_nonneg hA.le hQ.le)) hV0)
    _ = _ := by dsimp only [M]; ring

include hB in
/-- A genuinely constructed full-time invariant law has the original all-time H^l-observable exponential bound whenever the original density clause holds on the corresponding derived energy set. No existence, invariant-moment or exponential-bound premise is used. -/
theorem textbookLangevinPeriodicPositiveTimeDensityClause_invariant_exists_with_original_exponential_bound
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
      (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
        (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) ∧
      ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
        ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
          ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
            textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ
              {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ →
            ∃ M rate : ℝ, 0 < M ∧ 0 < rate ∧
              ∀ f : textbookLangevinPeriodicPhase N → ℝ, Measurable f →
                (∀ x, |f x| ≤ textbookLangevinPeriodicHamiltonianPower U l x) →
                ∀ (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N),
                  ‖(∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) -
                      ∫ y, f y ∂(μ : Measure (textbookLangevinPeriodicPhase N))‖ ≤
                    M * Real.exp (-rate * (T : ℝ)) * textbookLangevinPeriodicHamiltonianPower U l x := by
  obtain ⟨μ, hμ⟩ := textbookLangevinPeriodicTransitionKernel_invariant_exists
    B P hB U hU hp L hF γ σ hLower hγ
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicPositiveTimeDensityClause_original_observable_exponential_bound
    B P hB U hU hp L hF γ σ hLower hγ hσ
  refine ⟨μ, hμ, τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, R, hD, hR, hb⟩ := h l hl
  exact ⟨D, R, hD, hR, fun ρ hρ ↦ hb ρ hρ μ hμ⟩


include hB in
/-- For any original smooth periodic U, a genuinely derived additive energy normalization gives the same original kernel and a genuinely constructed invariant law with the all-time weighted exponential bound. The weight is H(U+c)^l, explicitly. -/
theorem textbookLangevinPeriodicPositiveTimeDensityClause_original_exponential_bound_unrestricted_potential
    (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ c : ℝ, (∀ q, 1 ≤ U q + c) ∧
      ∃ hFc : LipschitzWith L (textbookPotentialForce (fun q ↦ U q + c)),
        ∃ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
          (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
            (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) ∧
          ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
            ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
              ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
                textbookLangevinPeriodicPositiveTimeDensityClause B P (fun q ↦ U q + c) (hU.add contDiff_const)
                  (textbookUnitPeriodicPotential_add_const U hp c) L hFc γ σ
                  {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower (fun q ↦ U q + c) l z ≤ R} ρ →
                ∃ M rate : ℝ, 0 < M ∧ 0 < rate ∧
                  ∀ f : textbookLangevinPeriodicPhase N → ℝ, Measurable f →
                    (∀ x, |f x| ≤ textbookLangevinPeriodicHamiltonianPower (fun q ↦ U q + c) l x) →
                    ∀ (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N),
                      ‖(∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) -
                          ∫ y, f y ∂(μ : Measure (textbookLangevinPeriodicPhase N))‖ ≤
                        M * Real.exp (-rate * (T : ℝ)) * textbookLangevinPeriodicHamiltonianPower (fun q ↦ U q + c) l x := by
  obtain ⟨c, hc⟩ := textbookUnitPeriodicPotential_normalization U hU.continuous hp
  let V := fun q ↦ U q + c
  have hV : ContDiff ℝ ∞ V := hU.add contDiff_const
  have hpV : textbookUnitPeriodicPotential V := textbookUnitPeriodicPotential_add_const U hp c
  have hFV : LipschitzWith L (textbookPotentialForce V) := by
    dsimp only [V]
    rw [textbookPotentialForce_add_const]
    exact hF
  obtain ⟨μ, hμ, τ, hτ, hg⟩ := textbookLangevinPeriodicPositiveTimeDensityClause_invariant_exists_with_original_exponential_bound
    B P hB V hV hpV L hFV γ σ hc hγ hσ
  have hK (T : ℝ≥0) :
      textbookLangevinPeriodicTransitionKernel B P V hV hpV L hFV γ σ T =
        textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T :=
    textbookLangevinPeriodicTransitionKernel_add_const B P hB U hU hp L hF c L hFV γ σ T
  refine ⟨c, hc, hFV, μ, (fun T ↦ ?_), τ, hτ, fun l hl ↦ ?_⟩
  · rw [← hK]
    exact hμ T
  · obtain ⟨D, R, hD, hR, hh⟩ := hg l hl
    refine ⟨D, R, hD, hR, fun ρ hρ ↦ ?_⟩
    obtain ⟨M, rate, hM, hr, hb⟩ := hh ρ hρ
    refine ⟨M, rate, hM, hr, fun f hf hdom T x ↦ ?_⟩
    rw [← hK]
    exact hb f hf hdom T x
end PositiveTimeAllTime

end
end MolecularDynamics
