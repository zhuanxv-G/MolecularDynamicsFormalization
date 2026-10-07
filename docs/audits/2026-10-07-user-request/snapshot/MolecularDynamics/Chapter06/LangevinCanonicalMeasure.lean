import MolecularDynamics.Chapter06.LangevinGibbsStationaryExpression
import MolecularDynamics.Chapter06.BrownianTorusGibbs
import Mathlib.MeasureTheory.Integral.Pi
import Mathlib.MeasureTheory.SpecificCodomains.Pi

/-! A genuinely normalized original canonical phase probability.
Its full density and momentum moments are derived, without an invariant-law premise. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ZeroAtInfty BigOperators

namespace MolecularDynamics
noncomputable section

local instance canonicalUnitAddCircleMeasureSpace : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance canonicalUnitAddCircleHaar : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance canonicalUnitAddCircleProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

private def canonicalVariance (β : ℝ) (hβ : 0 < β) : ℝ≥0 := ⟨β⁻¹, (inv_pos.mpr hβ).le⟩
private theorem canonicalVariance_ne_zero (β : ℝ) (hβ : 0 < β) : canonicalVariance β hβ ≠ 0 := by
  intro he
  have hc := congrArg (fun v : ℝ≥0 ↦ (v : ℝ)) he
  change β⁻¹ = 0 at hc
  exact (ne_of_gt (inv_pos.mpr hβ)) hc

/-- The actual independent Gaussian momenta of the original unit-mass
canonical ensemble, each with genuine variance beta-inverse. -/
def textbookLangevinCanonicalMomentumMeasure (N : ℕ) (β : ℝ) (hβ : 0 < β) :
    Measure (Fin N → ℝ) :=
  Measure.pi (fun _ : Fin N ↦ gaussianReal 0 (canonicalVariance β hβ))

/-- The genuine momentum law is a probability, including dimension zero. -/
theorem textbookLangevinCanonicalMomentumMeasure_isProbabilityMeasure
    (N : ℕ) (β : ℝ) (hβ : 0 < β) :
    IsProbabilityMeasure (textbookLangevinCanonicalMomentumMeasure N β hβ) := by
  unfold textbookLangevinCanonicalMomentumMeasure
  infer_instance

/-- Its actual momentum vector is in L2, derived coordinatewise from true
Gaussian moments and the finite product projection laws. -/
theorem textbookLangevinCanonicalMomentumMeasure_memLp_two
    (N : ℕ) (β : ℝ) (hβ : 0 < β) :
    MemLp (fun p : Fin N → ℝ ↦ p) 2 (textbookLangevinCanonicalMomentumMeasure N β hβ) := by
  apply memLp_pi_iff.mpr
  intro i
  simpa only [Function.comp_apply, id_eq] using!
    (memLp_id_gaussianReal (μ := (0 : ℝ)) (v := canonicalVariance β hβ) (2 : ℝ≥0)).comp_measurePreserving
      (measurePreserving_eval (fun _ : Fin N ↦ gaussianReal 0 (canonicalVariance β hβ)) i)

private def canonicalMomentumPDF (N : ℕ) (β : ℝ) (hβ : 0 < β) (p : Fin N → ℝ) : ℝ :=
  ∏ i : Fin N, gaussianPDFReal 0 (canonicalVariance β hβ) (p i)

private theorem canonicalMomentumPDF_nonneg (N : ℕ) (β : ℝ) (hβ : 0 < β) (p : Fin N → ℝ) :
    0 ≤ canonicalMomentumPDF N β hβ p :=
  Finset.prod_nonneg (fun _ _ ↦ gaussianPDFReal_nonneg _ _ _)

private theorem canonicalMomentumPDF_integrable (N : ℕ) (β : ℝ) (hβ : 0 < β) :
    Integrable (canonicalMomentumPDF N β hβ) := by
  exact Integrable.fintype_prod (fun _ : Fin N ↦ integrable_gaussianPDFReal 0 (canonicalVariance β hβ))

/-- Rectangle uniqueness and real finite-dimensional Fubini give the actual
Gaussian product density on the genuine full momentum Lebesgue space. -/
theorem textbookLangevinCanonicalMomentumMeasure_withDensity
    (N : ℕ) (β : ℝ) (hβ : 0 < β) :
    textbookLangevinCanonicalMomentumMeasure N β hβ =
      (volume : Measure (Fin N → ℝ)).withDensity
        (fun p ↦ ENNReal.ofReal (canonicalMomentumPDF N β hβ p)) := by
  unfold textbookLangevinCanonicalMomentumMeasure
  apply Measure.pi_eq
  intro s hs
  rw [withDensity_apply _ (MeasurableSet.univ_pi hs)]
  rw [← ofReal_integral_eq_lintegral_ofReal
    ((canonicalMomentumPDF_integrable N β hβ).restrict)
    (Eventually.of_forall (canonicalMomentumPDF_nonneg N β hβ))]
  change ENNReal.ofReal (∫ p : Fin N → ℝ, ∏ i, gaussianPDFReal 0 (canonicalVariance β hβ) (p i)
    ∂(Measure.pi (fun _ : Fin N ↦ (volume : Measure ℝ))).restrict (Set.univ.pi s)) = _
  rw [Measure.restrict_pi_pi, integral_fintype_prod_eq_prod]
  rw [ENNReal.ofReal_prod_of_nonneg
    (fun i _ ↦ integral_nonneg (fun _ ↦ gaussianPDFReal_nonneg 0 (canonicalVariance β hβ) _))]
  apply Finset.prod_congr rfl
  intro i _
  exact (gaussianReal_apply_eq_integral 0 (canonicalVariance_ne_zero β hβ) (s i)).symm

/-- The true Gaussian product PDF is precisely its original Boltzmann
kinetic factor, with the derived normalization coefficient. -/
theorem textbookLangevinCanonicalMomentumMeasure_pdf_product
    (N : ℕ) (β : ℝ) (hβ : 0 < β) (p : Fin N → ℝ) :
    canonicalMomentumPDF N β hβ p =
      ((Real.sqrt (2 * Real.pi * β⁻¹))⁻¹) ^ N *
        Real.exp (-β * (∑ i : Fin N, p i ^ 2) / 2) := by
  have ht (i : Fin N) : gaussianPDFReal 0 (canonicalVariance β hβ) (p i) =
      (Real.sqrt (2 * Real.pi * β⁻¹))⁻¹ * Real.exp (-β * p i ^ 2 / 2) := by
    change (Real.sqrt (2 * Real.pi * β⁻¹))⁻¹ * Real.exp (-(p i - 0) ^ 2 / (2 * β⁻¹)) = _
    simp only [sub_zero]
    congr 1
    congr 1
    field_simp [ne_of_gt hβ]
  unfold canonicalMomentumPDF
  simp_rw [ht]
  rw [Finset.prod_mul_distrib]
  simp only [Finset.prod_const, Finset.card_univ, Fintype.card_fin]
  rw [← Real.exp_sum]
  have hs : (∑ i : Fin N, -β * p i ^ 2 / 2) = -β * (∑ i : Fin N, p i ^ 2) / 2 := by
    rw [← Finset.sum_div, Finset.mul_sum]
  rw [hs]

/-- The original canonical phase measure is the genuine configurational
Gibbs probability times the actual independent Gaussian momentum law. -/
def textbookLangevinCanonicalMeasure {N : ℕ} (U : (Fin N → ℝ) → ℝ)
    (β : ℝ) (hβ : 0 < β) : Measure (textbookLangevinPeriodicPhase N) :=
  (textbookConfigurationTorusGibbsMeasure U β).prod (textbookLangevinCanonicalMomentumMeasure N β hβ)

/-- Normalization of the complete original phase law is proved from the
two true marginal probabilities, with no invariant-law premise. -/
theorem textbookLangevinCanonicalMeasure_isProbabilityMeasure {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) := by
  have : IsProbabilityMeasure (textbookConfigurationTorusGibbsMeasure U β) :=
    textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hp β
  have : IsProbabilityMeasure (textbookLangevinCanonicalMomentumMeasure N β hβ) :=
    textbookLangevinCanonicalMomentumMeasure_isProbabilityMeasure N β hβ
  unfold textbookLangevinCanonicalMeasure
  infer_instance

/-- The derived actual phase probability wrapper, for use in original
kernel expectations and finite-moment dominated convergence. -/
def textbookLangevinCanonicalProbability {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) : ProbabilityMeasure (textbookLangevinPeriodicPhase N) :=
  ⟨textbookLangevinCanonicalMeasure U β hβ,
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ⟩

/-- The original complete Boltzmann density, with both actual partition
factors, on normalized position Haar times momentum Lebesgue volume. -/
def textbookLangevinCanonicalDensity {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (x : textbookLangevinPeriodicPhase N) : ℝ :=
  (textbookConfigurationPartition U β)⁻¹ * ((Real.sqrt (2 * Real.pi * β⁻¹))⁻¹) ^ N *
    textbookLangevinPeriodicGibbsWeight U β x

private theorem canonical_rho_factor {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicGibbsWeight U β x =
      textbookConfigurationTorusGibbsWeight U β x.1 *
        Real.exp (-β * (∑ i : Fin N, x.2 i ^ 2) / 2) := by
  let r := textbookLangevinPeriodicRepresentative x.1
  have hr : textbookConfigurationTorusProjection r = x.1 :=
    textbookLangevinPeriodicRepresentative_projects x.1
  have he := textbookConfigurationTorusGibbsWeight_lift U hp β r
  rw [hr] at he
  unfold textbookLangevinPeriodicGibbsWeight textbookLangevinPeriodicHamiltonianPower
    textbookLangevinHamiltonianPower textbookLangevinHamiltonian
  simp only [pow_one]
  rw [he]
  change Real.exp (-β * ((∑ i, x.2 i ^ 2) / 2 + U r)) =
    Real.exp (-β * U r) * Real.exp (-β * (∑ i, x.2 i ^ 2) / 2)
  rw [← Real.exp_add]
  congr 1
  ring

private theorem canonical_density_factor {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinCanonicalDensity U β x =
      ((textbookConfigurationPartition U β)⁻¹ * textbookConfigurationTorusGibbsWeight U β x.1) *
        canonicalMomentumPDF N β hβ x.2 := by
  unfold textbookLangevinCanonicalDensity
  rw [canonical_rho_factor U hp β x, textbookLangevinCanonicalMomentumMeasure_pdf_product N β hβ x.2]
  ring

/-- The full derived canonical density is strictly positive at every phase
point, without a stationarity or density-normalization assumption. -/
theorem textbookLangevinCanonicalDensity_pos {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) (hβ : 0 < β)
    (x : textbookLangevinPeriodicPhase N) : 0 < textbookLangevinCanonicalDensity U β x := by
  unfold textbookLangevinCanonicalDensity textbookLangevinPeriodicGibbsWeight
  exact mul_pos (mul_pos (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
    (pow_pos (inv_pos.mpr (Real.sqrt_pos.mpr (mul_pos
      (mul_pos (by norm_num : (0 : ℝ) < 2) Real.pi_pos) (inv_pos.mpr hβ)))) _)) (Real.exp_pos _)

/-- The actual constructed canonical probability has exactly the original
normalized Boltzmann density against position Haar times momentum Lebesgue. -/
theorem textbookLangevinCanonicalMeasure_withDensity {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    textbookLangevinCanonicalMeasure U β hβ =
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))).withDensity
        (fun x ↦ ENNReal.ofReal (textbookLangevinCanonicalDensity U β x)) := by
  have hq : Measurable (fun Q : UnitAddTorus (Fin N) ↦ ENNReal.ofReal
      ((textbookConfigurationPartition U β)⁻¹ * textbookConfigurationTorusGibbsWeight U β Q)) := by
    unfold textbookConfigurationTorusGibbsWeight
    exact ENNReal.measurable_ofReal.comp
      (((textbookConfigurationTorusObservable_measurable U hU.continuous).const_mul (-β)).exp.const_mul _)
  have hpD : Measurable (fun p : Fin N → ℝ ↦ ENNReal.ofReal (canonicalMomentumPDF N β hβ p)) := by
    unfold canonicalMomentumPDF
    fun_prop
  unfold textbookLangevinCanonicalMeasure textbookConfigurationTorusGibbsMeasure
  rw [textbookLangevinCanonicalMomentumMeasure_withDensity N β hβ, prod_withDensity hq hpD]
  congr 1
  funext x
  rw [canonical_density_factor U hp β hβ x]
  have hqN : 0 ≤ (textbookConfigurationPartition U β)⁻¹ * textbookConfigurationTorusGibbsWeight U β x.1 := by
    exact mul_nonneg (inv_nonneg.mpr (textbookConfigurationPartition_pos U hU β).le)
      (Real.exp_pos _).le
  exact (ENNReal.ofReal_mul hqN).symm

/-- The constructed true canonical phase probability has an integrable
momentum norm square, derived from the actual Gaussian L2 marginal. -/
theorem textbookLangevinCanonicalMeasure_momentum_norm_square_integrable {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    Integrable (fun x : textbookLangevinPeriodicPhase N ↦ ‖x.2‖ ^ 2)
      (textbookLangevinCanonicalMeasure U β hβ) := by
  have : IsProbabilityMeasure (textbookConfigurationTorusGibbsMeasure U β) :=
    textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hp β
  have : IsProbabilityMeasure (textbookLangevinCanonicalMomentumMeasure N β hβ) :=
    textbookLangevinCanonicalMomentumMeasure_isProbabilityMeasure N β hβ
  have hm : MeasurePreserving Prod.snd (textbookLangevinCanonicalMeasure U β hβ)
      (textbookLangevinCanonicalMomentumMeasure N β hβ) := measurePreserving_snd
  have hh : MemLp (fun x : textbookLangevinPeriodicPhase N ↦ x.2) 2
      (textbookLangevinCanonicalMeasure U β hβ) := by
    simpa only [Function.comp_apply] using!
      (textbookLangevinCanonicalMomentumMeasure_memLp_two N β hβ).comp_measurePreserving hm
  exact hh.integrable_norm_pow (by norm_num)

/-- The genuine normalized Boltzmann density is integrable on the full
original phase reference measure, proved through both derived factors. -/
theorem textbookLangevinCanonicalDensity_integrable {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    Integrable (textbookLangevinCanonicalDensity U β)
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
  have hi := ((textbookConfigurationTorusGibbsWeight_integrable U hU hp β).const_mul
    (textbookConfigurationPartition U β)⁻¹).mul_prod (canonicalMomentumPDF_integrable N β hβ)
  exact hi.congr (Eventually.of_forall (fun x ↦ (canonical_density_factor U hp β hβ x).symm))

/-- The actual full original canonical density integrates to one.
Normalization comes from the constructed probability and true integrability. -/
theorem textbookLangevinCanonicalDensity_integral_one {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    (∫ x : textbookLangevinPeriodicPhase N, textbookLangevinCanonicalDensity U β x
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) = 1 := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  have he : ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))).withDensity
      (fun x ↦ ENNReal.ofReal (textbookLangevinCanonicalDensity U β x)) univ = 1 := by
    rw [← textbookLangevinCanonicalMeasure_withDensity U hU hp β hβ]
    exact measure_univ
  rw [withDensity_apply _ MeasurableSet.univ, Measure.restrict_univ,
    ← ofReal_integral_eq_lintegral_ofReal (textbookLangevinCanonicalDensity_integrable U hU hp β hβ)
      (Eventually.of_forall (fun x ↦ (textbookLangevinCanonicalDensity_pos U hU β hβ x).le))] at he
  exact ENNReal.ofReal_eq_ofReal_iff (integral_nonneg (fun x ↦ (textbookLangevinCanonicalDensity_pos U hU β hβ x).le))
    (by norm_num : (0 : ℝ) ≤ 1) |>.mp (by simpa using he)

end
end MolecularDynamics
