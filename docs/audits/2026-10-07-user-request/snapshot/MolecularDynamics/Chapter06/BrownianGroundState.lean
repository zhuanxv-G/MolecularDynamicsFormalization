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
  change HasFDerivAt (fun x ↦ f x * g x) _ q at h
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
  rw [he, textbookConfigurationPartial_add (textbookConfigurationPartial f i * g)
    (f * textbookConfigurationPartial g i)
    (by exact (textbookConfigurationPartial_contDiff f hf i).mul hg)
    (by exact hf.mul (textbookConfigurationPartial_contDiff g hg i)) i]
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
    rw [textbookConfigurationGibbsWeight_partial U hU θ i x]
    ring
  rw [he, textbookConfigurationPartial_smul
    (textbookConfigurationPartial U i * textbookConfigurationGibbsWeight U θ)
    (by exact (textbookConfigurationPartial_contDiff U hU i).mul hW) (-θ) i]
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

/-- The actual bounded-potential expression generated by the original Gibbs conjugation. -/
def textbookBrownianGroundStatePotential {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (q : Fin Nc → ℝ) : ℝ :=
  ∑ i, (m i)⁻¹ * (textbookConfigurationPartial (textbookConfigurationPartial U i) i q / 2 -
    β * (textbookConfigurationPartial U i q) ^ 2 / 4)

/-- The actual transformed potential is smooth, derived from the original smooth potential. -/
theorem textbookBrownianGroundStatePotential_contDiff {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) :
    ContDiff ℝ ∞ (textbookBrownianGroundStatePotential m U β) := by
  apply ContDiff.sum
  intro i _
  exact contDiff_const.mul
    (((textbookConfigurationPartial_contDiff _ (textbookConfigurationPartial_contDiff U hU i) i).div_const 2).sub
      ((contDiff_const.mul ((textbookConfigurationPartial_contDiff U hU i).pow 2)).div_const 4))

/-- The actual transformed potential is periodic under the original integer lattice. -/
theorem textbookBrownianGroundStatePotential_periodic {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookUnitPeriodicPotential (textbookBrownianGroundStatePotential m U β) := by
  intro q z
  unfold textbookBrownianGroundStatePotential
  apply Finset.sum_congr rfl
  intro i _
  rw [textbookConfigurationPartial_periodic U hU hPU i q z,
    textbookConfigurationPartial_periodic _ (textbookConfigurationPartial_contDiff U hU i)
      (textbookConfigurationPartial_periodic U hU hPU i) i q z]

/-- The actual real transformed potential on the same full original torus. -/
def textbookBrownianTorusGroundStatePotential {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) : C(UnitAddTorus (Fin Nc), ℝ) :=
  ⟨textbookConfigurationTorusObservable (textbookBrownianGroundStatePotential m U β),
    textbookConfigurationTorusObservable_continuous _
      (textbookBrownianGroundStatePotential_contDiff m U hU β).continuous
      (textbookBrownianGroundStatePotential_periodic m U hU hPU β)⟩

/-- The genuine torus potential lifts to the same original partial-derivative expression. -/
theorem textbookBrownianTorusGroundStatePotential_lift {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (q : Fin Nc → ℝ) :
    textbookBrownianTorusGroundStatePotential m U hU hPU β (textbookConfigurationTorusProjection q) =
      textbookBrownianGroundStatePotential m U β q :=
  textbookConfigurationTorusObservable_lift _
    (textbookBrownianGroundStatePotential_periodic m U hU hPU β) q

/-- The actual transformed potential is uniformly bounded by its derived compact-torus norm. -/
theorem textbookBrownianGroundStatePotential_abs_le_norm {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (q : Fin Nc → ℝ) :
    |textbookBrownianGroundStatePotential m U β q| ≤
      ‖textbookBrownianTorusGroundStatePotential m U hU hPU β‖ := by
  rw [← textbookBrownianTorusGroundStatePotential_lift m U hU hPU β q]
  exact (textbookBrownianTorusGroundStatePotential m U hU hPU β).norm_coe_le_norm _

private theorem groundState_coordinate_conjugation {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) (hβ : β ≠ 0)
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (i : Fin Nc) (q : Fin Nc → ℝ) :
    β⁻¹ * textbookConfigurationPartial (textbookConfigurationPartial
      (fun x ↦ textbookGibbsGroundStateInverse U β x * f x) i) i q -
      textbookConfigurationPartial U i q * textbookConfigurationPartial
        (fun x ↦ textbookGibbsGroundStateInverse U β x * f x) i q =
      textbookGibbsGroundStateInverse U β q *
        (β⁻¹ * textbookConfigurationPartial (textbookConfigurationPartial f i) i q +
          (textbookConfigurationPartial (textbookConfigurationPartial U i) i q / 2 -
            β * (textbookConfigurationPartial U i q) ^ 2 / 4) * f q) := by
  rw [textbookConfigurationPartial_second_mul _ f (textbookGibbsGroundStateInverse_contDiff U hU β) hf,
    textbookConfigurationPartial_mul _ f (textbookGibbsGroundStateInverse_contDiff U hU β) hf]
  simp only [textbookGibbsGroundStateInverse]
  rw [textbookConfigurationGibbsWeight_second_partial U hU (-β / 2) i q,
    textbookConfigurationGibbsWeight_partial U hU (-β / 2) i q]
  field_simp
  ring

/-- Literal original generator conjugation retains all original mass, drift and derivative terms. -/
theorem textbookBrownianGenerator_groundState_inverse {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) (hβ : β ≠ 0)
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (q : Fin Nc → ℝ) :
    textbookBrownianGenerator m U β (fun x ↦ textbookGibbsGroundStateInverse U β x * f x) q =
      textbookGibbsGroundStateInverse U β q *
        (textbookBrownianGenerator m (fun _ ↦ 0) β f q +
          textbookBrownianGroundStatePotential m U β q * f q) := by
  calc
    _ = ∑ i, (m i)⁻¹ * (textbookGibbsGroundStateInverse U β q *
        (β⁻¹ * textbookConfigurationPartial (textbookConfigurationPartial f i) i q +
          (textbookConfigurationPartial (textbookConfigurationPartial U i) i q / 2 -
            β * (textbookConfigurationPartial U i q) ^ 2 / 4) * f q)) := by
      apply Finset.sum_congr rfl
      intro i _
      rw [groundState_coordinate_conjugation U hU β hβ f hf i q]
    _ = _ := by
      rw [textbookBrownianGenerator_mass_flat]
      unfold textbookBrownianGroundStatePotential
      simp only [Finset.mul_sum, Finset.sum_mul, ← Finset.sum_add_distrib]
      apply Finset.sum_congr rfl
      intro i _
      ring

/-- Multiplication by the actual ground-state factor yields the actual Laplace plus real potential. -/
theorem textbookBrownianGenerator_groundState_conjugation {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) (hβ : β ≠ 0)
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (q : Fin Nc → ℝ) :
    textbookGibbsGroundStateFactor U β q *
      textbookBrownianGenerator m U β (fun x ↦ textbookGibbsGroundStateInverse U β x * f x) q =
      textbookBrownianGenerator m (fun _ ↦ 0) β f q +
        textbookBrownianGroundStatePotential m U β q * f q := by
  rw [textbookBrownianGenerator_groundState_inverse m U hU β hβ f hf q,
    ← mul_assoc, textbookGibbsGroundStateFactor_mul_inverse, one_mul]
/-- The true normalized ground-state factor uses the same original configuration partition. -/
def textbookGibbsNormalizedGroundStateFactor {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ)
    (q : Fin Nc → ℝ) : ℝ :=
  (Real.sqrt (textbookConfigurationPartition U β))⁻¹ * textbookGibbsGroundStateFactor U β q

/-- The actual normalized factor is smooth on full original configuration space. -/
theorem textbookGibbsNormalizedGroundStateFactor_contDiff {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) :
    ContDiff ℝ ∞ (textbookGibbsNormalizedGroundStateFactor U β) :=
  contDiff_const.mul (textbookGibbsGroundStateFactor_contDiff U hU β)

/-- The true normalized factor preserves the same original periodic lattice. -/
theorem textbookGibbsNormalizedGroundStateFactor_periodic {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookUnitPeriodicPotential (textbookGibbsNormalizedGroundStateFactor U β) := by
  intro q z
  unfold textbookGibbsNormalizedGroundStateFactor
  rw [textbookGibbsGroundStateFactor_periodic U hPU β q z]

/-- The actual normalized factor is everywhere strictly positive, with partition positivity proved. -/
theorem textbookGibbsNormalizedGroundStateFactor_pos {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) (q : Fin Nc → ℝ) :
    0 < textbookGibbsNormalizedGroundStateFactor U β q :=
  mul_pos (inv_pos.mpr (Real.sqrt_pos.mpr (textbookConfigurationPartition_pos U hU β)))
    (textbookGibbsGroundStateFactor_pos U β q)

/-- The actual square of the normalized factor is the original normalized Gibbs weight. -/
theorem textbookGibbsNormalizedGroundStateFactor_sq {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) (q : Fin Nc → ℝ) :
    (textbookGibbsNormalizedGroundStateFactor U β q) ^ 2 =
      (textbookConfigurationPartition U β)⁻¹ * textbookConfigurationGibbsWeight U β q := by
  unfold textbookGibbsNormalizedGroundStateFactor
  rw [mul_pow, inv_pow, Real.sq_sqrt (textbookConfigurationPartition_pos U hU β).le,
    textbookGibbsGroundStateFactor_sq]

/-- The same original normalized factor as an actual continuous function on the full torus. -/
def textbookTorusGibbsNormalizedGroundStateFactor {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) : C(UnitAddTorus (Fin Nc), ℝ) :=
  ⟨textbookConfigurationTorusObservable (textbookGibbsNormalizedGroundStateFactor U β),
    textbookConfigurationTorusObservable_continuous _
      (textbookGibbsNormalizedGroundStateFactor_contDiff U hU β).continuous
      (textbookGibbsNormalizedGroundStateFactor_periodic U hPU β)⟩

/-- The genuine normalized torus factor lifts to the same original Euclidean factor. -/
theorem textbookTorusGibbsNormalizedGroundStateFactor_lift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (q : Fin Nc → ℝ) :
    textbookTorusGibbsNormalizedGroundStateFactor U hU hPU β (textbookConfigurationTorusProjection q) =
      textbookGibbsNormalizedGroundStateFactor U β q :=
  textbookConfigurationTorusObservable_lift _
    (textbookGibbsNormalizedGroundStateFactor_periodic U hPU β) q

/-- The actual torus factor squares to the density of the same original Gibbs withDensity measure. -/
theorem textbookTorusGibbsNormalizedGroundStateFactor_sq {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (Q : UnitAddTorus (Fin Nc)) :
    (textbookTorusGibbsNormalizedGroundStateFactor U hU hPU β Q) ^ 2 =
      textbookConfigurationTorusGibbsDensity U β Q := by
  change (textbookGibbsNormalizedGroundStateFactor U β (textbookConfigurationTorusRepresentative Q)) ^ 2 =
    (textbookConfigurationPartition U β)⁻¹ * Real.exp (-β * textbookConfigurationTorusObservable U Q)
  rw [textbookGibbsNormalizedGroundStateFactor_sq U hU β]
  rfl

/-- The actual normalized multiplier preserves the true Gibbs-to-Haar square integral. -/
theorem textbookTorusGibbsGroundState_square_integral {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    (∫ Q : UnitAddTorus (Fin Nc),
      (textbookTorusGibbsNormalizedGroundStateFactor U hU hPU β Q * g Q) ^ 2) =
      ∫ Q, (g Q) ^ 2 ∂textbookConfigurationTorusGibbsMeasure U β := by
  have hi := textbookTorusGibbsDensity_integral U hU hPU β (g ^ 2)
  simp only [ContinuousMap.pow_apply] at hi
  rw [hi]
  apply integral_congr_ae
  filter_upwards [] with Q
  rw [mul_pow, textbookTorusGibbsNormalizedGroundStateFactor_sq]
end

end MolecularDynamics
