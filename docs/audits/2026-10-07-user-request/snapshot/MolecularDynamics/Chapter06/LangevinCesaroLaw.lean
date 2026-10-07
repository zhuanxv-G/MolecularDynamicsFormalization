import MolecularDynamics.Chapter06.LangevinSkeletonMoments
import Mathlib.MeasureTheory.Measure.Prokhorov
import Mathlib.MeasureTheory.Measure.LevyProkhorovMetric

/-! Actual probability Cesaro laws for the original Langevin invariant-law construction. Tight weak subsequences are not asserted to be invariant. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

/-- The actual Cesaro mean of the first n+1 genuine skeleton transition laws, with the real finite nonzero normalization. -/
def textbookLangevinPeriodicCesaroMeasure (τ : ℝ≥0) (x : textbookLangevinPeriodicPhase N) (n : ℕ) :
    Measure (textbookLangevinPeriodicPhase N) :=
  ((n + 1 : ℕ) : ℝ≥0∞)⁻¹ •
    ∑ i ∈ Finset.range (n + 1),
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((i : ℝ≥0) * τ) x

include hB in
/-- These actual finite averages are genuine probability measures; no probability or stationary conclusion is supplied as a premise. -/
theorem textbookLangevinPeriodicCesaroMeasure_isProbability
    (τ : ℝ≥0) (x : textbookLangevinPeriodicPhase N) (n : ℕ) :
    IsProbabilityMeasure (textbookLangevinPeriodicCesaroMeasure B P U hU hp L hF γ σ τ x n) := by
  have hm (i : ℕ) :
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((i : ℝ≥0) * τ) x univ = 1 := by
    have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((i : ℝ≥0) * τ)) :=
      textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ _
    exact measure_univ
  have hn : ((n + 1 : ℕ) : ℝ≥0∞) ≠ 0 := by exact_mod_cast Nat.succ_ne_zero n
  constructor
  unfold textbookLangevinPeriodicCesaroMeasure
  rw [Measure.smul_apply, smul_eq_mul, Measure.finsetSum_apply]
  simp only [hm, Finset.sum_const, Finset.card_range, nsmul_eq_mul, mul_one]
  exact ENNReal.inv_mul_cancel hn (ENNReal.natCast_ne_top (n + 1))

/-- The exact same actual Cesaro mean in the genuine weak topology of probability measures. -/
def textbookLangevinPeriodicCesaroProbability (τ : ℝ≥0) (x : textbookLangevinPeriodicPhase N) (n : ℕ) :
    ProbabilityMeasure (textbookLangevinPeriodicPhase N) :=
  ⟨textbookLangevinPeriodicCesaroMeasure B P U hU hp L hF γ σ τ x n,
    textbookLangevinPeriodicCesaroMeasure_isProbability B P hB U hU hp L hF γ σ τ x n⟩

include hB in
/-- The probability-average expectation is the true finite average of the actual kernel expectations for every bounded continuous original-phase observable. -/
theorem textbookLangevinPeriodicCesaroProbability_integral
    (τ : ℝ≥0) (x : textbookLangevinPeriodicPhase N) (n : ℕ)
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) :
    (∫ y, f y ∂(textbookLangevinPeriodicCesaroProbability B P hB U hU hp L hF γ σ τ x n :
      Measure (textbookLangevinPeriodicPhase N))) =
      ((n + 1 : ℕ) : ℝ)⁻¹ * ∑ i ∈ Finset.range (n + 1),
        (∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((i : ℝ≥0) * τ) x) := by
  have hi (i : ℕ) : Integrable f
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((i : ℝ≥0) * τ) x) := by
    have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((i : ℝ≥0) * τ)) :=
      textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ _
    exact (integrable_const ‖f‖).mono' f.continuous.aestronglyMeasurable
      (Eventually.of_forall f.norm_coe_le_norm)
  change (∫ y, f y ∂textbookLangevinPeriodicCesaroMeasure B P U hU hp L hF γ σ τ x n) = _
  unfold textbookLangevinPeriodicCesaroMeasure
  rw [integral_smul_measure, integral_finsetSum_measure (fun i _ ↦ hi i)]
  simp only [ENNReal.toReal_inv, ENNReal.toReal_natCast, smul_eq_mul]

include hB in
/-- Actual skeleton tightness is preserved by the actual Cesaro probability averages, on the same derived positive time and every fixed original initial phase. -/
theorem textbookLangevinPeriodicCesaroMeasure_isTight
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ x : textbookLangevinPeriodicPhase N,
      IsTightMeasureSet (Set.range (textbookLangevinPeriodicCesaroMeasure B P U hU hp L hF γ σ τ x)) := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_skeleton_isTight
    B P hB U hU hp L hF γ σ hLower hγ
  refine ⟨τ, hτ, fun x ↦ ?_⟩
  rw [isTightMeasureSet_iff_exists_isCompact_measure_compl_le]
  intro ε hε
  obtain ⟨C, hC, hb⟩ := isTightMeasureSet_iff_exists_isCompact_measure_compl_le.mp (h x) ε hε
  refine ⟨C, hC, ?_⟩
  rintro μ ⟨n, rfl⟩
  have hn : ((n + 1 : ℕ) : ℝ≥0∞) ≠ 0 := by exact_mod_cast Nat.succ_ne_zero n
  unfold textbookLangevinPeriodicCesaroMeasure
  rw [Measure.smul_apply, smul_eq_mul, Measure.finsetSum_apply]
  calc
    _ ≤ ((n + 1 : ℕ) : ℝ≥0∞)⁻¹ * ∑ _i ∈ Finset.range (n + 1), ε := by
      gcongr with i hi
      exact hb _ ⟨i, rfl⟩
    _ = ε := by
      simp only [Finset.sum_const, Finset.card_range, nsmul_eq_mul]
      rw [← mul_assoc, ENNReal.inv_mul_cancel hn (ENNReal.natCast_ne_top (n + 1)), one_mul]

include hB in
/-- Prokhorov's actual probability-space compactness applies to the genuine Cesaro averages on the original noncompact phase space. -/
theorem textbookLangevinPeriodicCesaroProbability_isCompact_closure
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ x : textbookLangevinPeriodicPhase N,
      IsCompact (closure (Set.range (textbookLangevinPeriodicCesaroProbability B P hB U hU hp L hF γ σ τ x))) := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicCesaroMeasure_isTight B P hB U hU hp L hF γ σ hLower hγ
  refine ⟨τ, hτ, fun x ↦ ?_⟩
  apply isCompact_closure_of_isTightMeasureSet
  rw [isTightMeasureSet_iff_exists_isCompact_measure_compl_le]
  intro ε hε
  obtain ⟨C, hC, hb⟩ := isTightMeasureSet_iff_exists_isCompact_measure_compl_le.mp (h x) ε hε
  refine ⟨C, hC, ?_⟩
  rintro μ ⟨ν, ⟨n, rfl⟩, rfl⟩
  exact hb _ ⟨n, rfl⟩

include hB in
/-- Genuine Cesaro probabilities have a weakly convergent subsequence; this is an actual law construction input and not yet an invariant-law assertion. -/
theorem textbookLangevinPeriodicCesaroProbability_weak_subsequence
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ x : textbookLangevinPeriodicPhase N,
      ∃ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N), ∃ φ : ℕ → ℕ,
        StrictMono φ ∧
        Tendsto (fun n ↦ textbookLangevinPeriodicCesaroProbability B P hB U hU hp L hF γ σ τ x (φ n))
          atTop (𝓝 μ) := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicCesaroProbability_isCompact_closure B P hB U hU hp L hF γ σ hLower hγ
  refine ⟨τ, hτ, fun x ↦ ?_⟩
  obtain ⟨μ, _, φ, hφ, hlim⟩ := (h x).tendsto_subseq
    (fun n ↦ subset_closure ⟨n, rfl⟩)
  exact ⟨μ, φ, hφ, hlim⟩

end
end MolecularDynamics
