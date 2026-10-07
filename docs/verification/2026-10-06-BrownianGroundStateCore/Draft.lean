import MolecularDynamics.Chapter06.BrownianGroundStateIsometry

/-! Actual full smooth-domain multiplication and normalized original generator conjugation. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace

namespace MolecularDynamics

noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The actual inverse normalized factor on full original Euclidean configuration space. -/
def textbookGibbsNormalizedGroundStateInverse {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ)
    (q : Fin Nc → ℝ) : ℝ :=
  Real.sqrt (textbookConfigurationPartition U β) * textbookGibbsGroundStateInverse U β q

/-- The genuine normalized inverse is smooth, with no smooth inverse premise. -/
theorem textbookGibbsNormalizedGroundStateInverse_contDiff {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) :
    ContDiff ℝ ∞ (textbookGibbsNormalizedGroundStateInverse U β) :=
  contDiff_const.mul (textbookGibbsGroundStateInverse_contDiff U hU β)

/-- The actual normalized inverse preserves the same original lattice. -/
theorem textbookGibbsNormalizedGroundStateInverse_periodic {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookUnitPeriodicPotential (textbookGibbsNormalizedGroundStateInverse U β) := by
  intro q z
  unfold textbookGibbsNormalizedGroundStateInverse
  rw [textbookGibbsGroundStateInverse_periodic U hPU β q z]

/-- The true two normalized factors multiply to one, using the actual positive partition. -/
theorem textbookGibbsNormalizedGroundStateFactor_mul_inverse {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) (q : Fin Nc → ℝ) :
    textbookGibbsNormalizedGroundStateFactor U β q * textbookGibbsNormalizedGroundStateInverse U β q = 1 := by
  unfold textbookGibbsNormalizedGroundStateFactor textbookGibbsNormalizedGroundStateInverse
  calc
    _ = ((Real.sqrt (textbookConfigurationPartition U β))⁻¹ *
        Real.sqrt (textbookConfigurationPartition U β)) *
          (textbookGibbsGroundStateFactor U β q * textbookGibbsGroundStateInverse U β q) := by ring
    _ = 1 := by
      rw [inv_mul_cancel₀ (ne_of_gt (Real.sqrt_pos.mpr (textbookConfigurationPartition_pos U hU β))),
        textbookGibbsGroundStateFactor_mul_inverse, one_mul]

/-- Actual normalized multiplication is a genuine equivalence of the entire original smooth periodic space. -/
def textbookGibbsGroundStateSmoothEquiv {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookPeriodicSmoothSpace Nc ≃ₗ[ℝ] textbookPeriodicSmoothSpace Nc where
  toFun f := ⟨fun q ↦ textbookGibbsNormalizedGroundStateFactor U β q * (f : (Fin Nc → ℝ) → ℝ) q,
    ⟨(textbookGibbsNormalizedGroundStateFactor_contDiff U hU β).mul f.prop.1, by
      intro q z
      rw [textbookGibbsNormalizedGroundStateFactor_periodic U hPU β q z, f.prop.2 q z]⟩⟩
  invFun f := ⟨fun q ↦ textbookGibbsNormalizedGroundStateInverse U β q * (f : (Fin Nc → ℝ) → ℝ) q,
    ⟨(textbookGibbsNormalizedGroundStateInverse_contDiff U hU β).mul f.prop.1, by
      intro q z
      rw [textbookGibbsNormalizedGroundStateInverse_periodic U hPU β q z, f.prop.2 q z]⟩⟩
  left_inv f := by
    apply Subtype.ext
    funext q
    change textbookGibbsNormalizedGroundStateInverse U β q *
      (textbookGibbsNormalizedGroundStateFactor U β q * (f : (Fin Nc → ℝ) → ℝ) q) = _
    rw [← mul_assoc, mul_comm (textbookGibbsNormalizedGroundStateInverse U β q),
      textbookGibbsNormalizedGroundStateFactor_mul_inverse U hU β, one_mul]
  right_inv f := by
    apply Subtype.ext
    funext q
    change textbookGibbsNormalizedGroundStateFactor U β q *
      (textbookGibbsNormalizedGroundStateInverse U β q * (f : (Fin Nc → ℝ) → ℝ) q) = _
    rw [← mul_assoc, textbookGibbsNormalizedGroundStateFactor_mul_inverse U hU β, one_mul]
  map_add' f g := by
    apply Subtype.ext
    funext q
    change _ * ((f : (Fin Nc → ℝ) → ℝ) q + (g : (Fin Nc → ℝ) → ℝ) q) =
      _ * (f : (Fin Nc → ℝ) → ℝ) q + _ * (g : (Fin Nc → ℝ) → ℝ) q
    ring
  map_smul' c f := by
    apply Subtype.ext
    funext q
    change _ * (c * (f : (Fin Nc → ℝ) → ℝ) q) = c * (_ * (f : (Fin Nc → ℝ) → ℝ) q)
    ring

/-- The actual smooth equivalence has exactly the original normalized multiplier as its real lift. -/
theorem textbookGibbsGroundStateSmoothEquiv_apply {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (f : textbookPeriodicSmoothSpace Nc)
    (q : Fin Nc → ℝ) :
    (textbookGibbsGroundStateSmoothEquiv U hU hPU β f : (Fin Nc → ℝ) → ℝ) q =
      textbookGibbsNormalizedGroundStateFactor U β q * (f : (Fin Nc → ℝ) → ℝ) q := rfl

/-- The genuine full original smooth functions embedded in the same actual Haar Hilbert space. -/
def textbookPeriodicSmoothHaarEmbedding (Nc : ℕ) :
    textbookPeriodicSmoothSpace Nc →ₗ[ℝ] Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) where
  toFun f := textbookHaarContinuousToLp Nc (textbookPeriodicSmoothContinuous f)
  map_add' f g := by
    have he : textbookPeriodicSmoothContinuous (f + g) =
        textbookPeriodicSmoothContinuous f + textbookPeriodicSmoothContinuous g := by ext Q; rfl
    rw [he]
    exact (textbookHaarContinuousToLp Nc).map_add _ _
  map_smul' c f := by
    have he : textbookPeriodicSmoothContinuous (c • f) =
        c • textbookPeriodicSmoothContinuous f := by ext Q; rfl
    rw [he]
    exact (textbookHaarContinuousToLp Nc).map_smul c _

/-- The actual entire Hilbert isometry carries the full Gibbs smooth embedding to the true Haar smooth embedding. -/
theorem textbookGibbsHaarGroundStateIsometry_apply_smooth {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (f : textbookPeriodicSmoothSpace Nc) :
    textbookGibbsHaarGroundStateIsometry U hU hPU β (textbookPeriodicSmoothEmbedding U hU hPU β f) =
      textbookPeriodicSmoothHaarEmbedding Nc (textbookGibbsGroundStateSmoothEquiv U hU hPU β f) := by
  rw [textbookPeriodicSmoothEmbedding_eq_continuousToLp,
    textbookGibbsHaarGroundStateIsometry_apply_continuous]
  change textbookHaarContinuousToLp Nc
    (textbookTorusGibbsNormalizedGroundStateFactor U hU hPU β * textbookPeriodicSmoothContinuous f) =
    textbookHaarContinuousToLp Nc
      (textbookPeriodicSmoothContinuous (textbookGibbsGroundStateSmoothEquiv U hU hPU β f))
  congr 1
  ext Q
  rfl

/-- The actual full Gibbs smooth core maps onto the entire actual Haar smooth core, not a Fourier truncation. -/
theorem textbookGibbsHaarGroundStateIsometry_smooth_range {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    Set.range (fun f : textbookPeriodicSmoothSpace Nc ↦
      textbookGibbsHaarGroundStateIsometry U hU hPU β (textbookPeriodicSmoothEmbedding U hU hPU β f)) =
      Set.range (textbookPeriodicSmoothHaarEmbedding Nc) := by
  ext x
  constructor
  · rintro ⟨f, rfl⟩
    exact ⟨textbookGibbsGroundStateSmoothEquiv U hU hPU β f,
      (textbookGibbsHaarGroundStateIsometry_apply_smooth U hU hPU β f).symm⟩
  · rintro ⟨f, rfl⟩
    refine ⟨(textbookGibbsGroundStateSmoothEquiv U hU hPU β).symm f, ?_⟩
    rw [textbookGibbsHaarGroundStateIsometry_apply_smooth, LinearEquiv.apply_symm_apply]

/-- Actual normalized conjugation uses the same original positive partition and literal generator. -/
theorem textbookBrownianGenerator_normalized_groundState_conjugation {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) (hβ : β ≠ 0)
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (q : Fin Nc → ℝ) :
    textbookGibbsNormalizedGroundStateFactor U β q *
      textbookBrownianGenerator m U β (fun x ↦ textbookGibbsNormalizedGroundStateInverse U β x * f x) q =
      textbookBrownianGenerator m (fun _ ↦ 0) β f q +
        textbookBrownianGroundStatePotential m U β q * f q := by
  have he : (fun x ↦ textbookGibbsNormalizedGroundStateInverse U β x * f x) =
      Real.sqrt (textbookConfigurationPartition U β) •
        (fun x ↦ textbookGibbsGroundStateInverse U β x * f x) := by
    funext x
    simp only [textbookGibbsNormalizedGroundStateInverse, Pi.smul_apply, smul_eq_mul]
    ring
  rw [he, textbookBrownianGenerator_smul m U β _
    ((textbookGibbsGroundStateInverse_contDiff U hU β).mul hf)]
  unfold textbookGibbsNormalizedGroundStateFactor
  simp only [Pi.smul_apply, smul_eq_mul]
  calc
    _ = ((Real.sqrt (textbookConfigurationPartition U β))⁻¹ *
        Real.sqrt (textbookConfigurationPartition U β)) *
          (textbookGibbsGroundStateFactor U β q *
            textbookBrownianGenerator m U β (fun x ↦ textbookGibbsGroundStateInverse U β x * f x) q) := by ring
    _ = _ := by
      rw [inv_mul_cancel₀ (ne_of_gt (Real.sqrt_pos.mpr (textbookConfigurationPartition_pos U hU β))),
        one_mul, textbookBrownianGenerator_groundState_conjugation m U hU β hβ f hf q]

end

end MolecularDynamics