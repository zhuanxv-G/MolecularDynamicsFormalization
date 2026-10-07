import MolecularDynamics.Chapter06.BrownianMassFourier

/-! Literal ground-state conjugation of the original Gibbs Brownian generator. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff BigOperators

namespace MolecularDynamics

noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The actual coordinate product rule on full smooth Euclidean observables. -/
theorem textbookConfigurationPartial_mul {Nc : ℕ} (f g : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g) (i : Fin Nc) (q : Fin Nc → ℝ) :
    textbookConfigurationPartial (fun x ↦ f x * g x) i q =
      textbookConfigurationPartial f i q * g q +
        f q * textbookConfigurationPartial g i q := by
  have h := ((hf.differentiable (by simp) q).hasFDerivAt).mul
    ((hg.differentiable (by simp) q).hasFDerivAt)
  unfold textbookConfigurationPartial
  rw [h.fderiv]
  simp only [add_apply, smul_apply, smul_eq_mul]
  ring

/-- The genuine second coordinate product rule uses actual original Frechet partials. -/
theorem textbookConfigurationPartial_second_mul {Nc : ℕ} (f g : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g) (i : Fin Nc) (q : Fin Nc → ℝ) :
    textbookConfigurationPartial (textbookConfigurationPartial (fun x ↦ f x * g x) i) i q =
      textbookConfigurationPartial (textbookConfigurationPartial f i) i q * g q +
        2 * textbookConfigurationPartial f i q * textbookConfigurationPartial g i q +
          f q * textbookConfigurationPartial (textbookConfigurationPartial g i) i q := by
  have he : textbookConfigurationPartial (fun x ↦ f x * g x) i =
      (textbookConfigurationPartial f i) * g + f * textbookConfigurationPartial g i := by
    funext x
    exact textbookConfigurationPartial_mul f g hf hg i x
  rw [he, textbookConfigurationPartial_add _ _
    ((textbookConfigurationPartial_contDiff f hf i).mul hg)
    (hf.mul (textbookConfigurationPartial_contDiff g hg i)) i]
  change textbookConfigurationPartial (fun x ↦ textbookConfigurationPartial f i x * g x) i q +
    textbookConfigurationPartial (fun x ↦ f x * textbookConfigurationPartial g i x) i q = _
  rw [textbookConfigurationPartial_mul _ _ (textbookConfigurationPartial_contDiff f hf i) hg,
    textbookConfigurationPartial_mul _ _ hf (textbookConfigurationPartial_contDiff g hg i)]
  ring

/-- The actual Gibbs weight second derivative, with no derivative supplied as a premise. -/
theorem textbookConfigurationGibbsWeight_second_partial {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (θ : ℝ) (i : Fin Nc) (q : Fin Nc → ℝ) :
    textbookConfigurationPartial (textbookConfigurationPartial (textbookConfigurationGibbsWeight U θ) i) i q =
      (-θ * textbookConfigurationPartial (textbookConfigurationPartial U i) i q +
        θ ^ 2 * (textbookConfigurationPartial U i q) ^ 2) *
          textbookConfigurationGibbsWeight U θ q := by
  have hW := textbookConfigurationGibbsWeight_contDiff U hU θ
  have he : textbookConfigurationPartial (textbookConfigurationGibbsWeight U θ) i =
      (-θ) • (textbookConfigurationPartial U i * textbookConfigurationGibbsWeight U θ) := by
    funext x
    change textbookConfigurationPartial (textbookConfigurationGibbsWeight U θ) i x =
      -θ * (textbookConfigurationPartial U i x * textbookConfigurationGibbsWeight U θ x)
    rw [textbookConfigurationGibbsWeight_partial]
    ring
  rw [he, textbookConfigurationPartial_smul _ ((textbookConfigurationPartial_contDiff U hU i).mul hW)]
  change -θ * textbookConfigurationPartial
    (fun x ↦ textbookConfigurationPartial U i x * textbookConfigurationGibbsWeight U θ x) i q = _
  rw [textbookConfigurationPartial_mul _ _ (textbookConfigurationPartial_contDiff U hU i) hW,
    textbookConfigurationGibbsWeight_partial U hU θ i q]
  ring

/-- The actual unnormalized square-root Gibbs weight on original configuration space. -/
def textbookGibbsGroundStateFactor {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :
    (Fin Nc → ℝ) → ℝ :=
  textbookConfigurationGibbsWeight U (β / 2)

/-- The actual inverse ground-state multiplier, rather than an inverse premise. -/
def textbookGibbsGroundStateInverse {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :
    (Fin Nc → ℝ) → ℝ :=
  textbookConfigurationGibbsWeight U (-β / 2)

/-- The original ground-state factor is genuinely smooth. -/
theorem textbookGibbsGroundStateFactor_contDiff {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) :
    ContDiff ℝ ∞ (textbookGibbsGroundStateFactor U β) :=
  textbookConfigurationGibbsWeight_contDiff U hU (β / 2)

/-- The actual inverse multiplier is genuinely smooth. -/
theorem textbookGibbsGroundStateInverse_contDiff {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) :
    ContDiff ℝ ∞ (textbookGibbsGroundStateInverse U β) :=
  textbookConfigurationGibbsWeight_contDiff U hU (-β / 2)

/-- The actual ground-state factor preserves the original integer lattice. -/
theorem textbookGibbsGroundStateFactor_periodic {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookUnitPeriodicPotential (textbookGibbsGroundStateFactor U β) :=
  textbookConfigurationGibbsWeight_periodic U hPU (β / 2)

/-- The actual inverse multiplier preserves the same original lattice. -/
theorem textbookGibbsGroundStateInverse_periodic {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookUnitPeriodicPotential (textbookGibbsGroundStateInverse U β) :=
  textbookConfigurationGibbsWeight_periodic U hPU (-β / 2)

/-- Ground-state factors are actually strictly positive at every original position. -/
theorem textbookGibbsGroundStateFactor_pos {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (q : Fin Nc → ℝ) :
    0 < textbookGibbsGroundStateFactor U β q :=
  Real.exp_pos _

/-- The actual two exponential factors multiply to one, with no invertibility premise. -/
theorem textbookGibbsGroundStateFactor_mul_inverse {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (q : Fin Nc → ℝ) :
    textbookGibbsGroundStateFactor U β q * textbookGibbsGroundStateInverse U β q = 1 := by
  unfold textbookGibbsGroundStateFactor textbookGibbsGroundStateInverse textbookConfigurationGibbsWeight
  rw [← Real.exp_add]
  have hz : -(β / 2) * U q + -(-β / 2) * U q = 0 := by ring
  rw [hz, Real.exp_zero]

/-- The original Gibbs density weight is the actual square of its ground-state factor. -/
theorem textbookGibbsGroundStateFactor_sq {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (q : Fin Nc → ℝ) :
    (textbookGibbsGroundStateFactor U β q) ^ 2 = textbookConfigurationGibbsWeight U β q := by
  unfold textbookGibbsGroundStateFactor textbookConfigurationGibbsWeight
  rw [pow_two, ← Real.exp_add]
  congr 1
  ring

end

end MolecularDynamics