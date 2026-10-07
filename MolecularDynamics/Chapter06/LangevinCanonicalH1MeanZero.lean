import MolecularDynamics.Chapter06.LangevinCanonicalWeakH1
import Mathlib.Analysis.InnerProductSpace.LinearMap

/-! The true canonical H1 constants and the actual zero-integral condition in
Proposition 6.4. The mean is a bounded linear functional and its zero subspace
is a complete closed Hilbert subspace. This does not identify a generator kernel
or prove the Fredholm alternative, a compact resolvent, or Poisson solvability. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ENNReal BigOperators InnerProductSpace
namespace MolecularDynamics
noncomputable section

private theorem canonicalMean_F_continuous {N : ℕ} (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) : Continuous F :=
  (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hF.continuous

private def canonicalMean_constantL2 {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (c : ℝ) : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  exact (memLp_const c : MemLp (fun _ : textbookLangevinPeriodicPhase N ↦ c) 2
    (textbookLangevinCanonicalMeasure U β hβ)).toLp _

private theorem canonicalMean_constantL2_ae {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (c : ℝ) :
    canonicalMean_constantL2 U hU hp β hβ c =ᵐ[textbookLangevinCanonicalMeasure U β hβ]
      fun _ ↦ c := by
  unfold canonicalMean_constantL2
  exact MemLp.coeFn_toLp _

private theorem canonicalMean_constantL2_norm {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (c : ℝ) :
    ‖canonicalMean_constantL2 U hU hp β hβ c‖ = |c| := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  have he : ‖canonicalMean_constantL2 U hU hp β hβ c‖ ^ 2 = c ^ 2 := by
    rw [← real_inner_self_eq_norm_sq, L2.inner_def]
    calc
      _ = ∫ _ : textbookLangevinPeriodicPhase N, c * c
          ∂textbookLangevinCanonicalMeasure U β hβ := by
        apply integral_congr_ae
        filter_upwards [canonicalMean_constantL2_ae U hU hp β hβ c] with x hx
        rw [hx, Real.inner_apply]
      _ = c ^ 2 := by simp [pow_two]
  apply (sq_eq_sq₀ (norm_nonneg _) (abs_nonneg c)).mp
  simpa only [sq_abs] using he

private theorem canonicalMean_coordinateAdjoint_integral_zero {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    (∫ x, textbookLangevinCanonicalCoordinateAdjointTestExpression U β j G x
      ∂textbookLangevinCanonicalMeasure U β hβ) = 0 := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  let D := textbookLangevinPeriodicDirectionalDerivative G (textbookLangevinCanonicalCoordinateDirection j)
  let s := textbookLangevinCanonicalCoordinateLogSlope U β j
  have hD : Integrable D (textbookLangevinCanonicalMeasure U β hβ) :=
    (textbookLangevinPeriodicDirectionalDerivative_continuous G hG _).integrable_of_hasCompactSupport
      (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport G hsG _)
  have hA : Integrable (textbookLangevinCanonicalCoordinateAdjointTestExpression U β j G)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    MemLp.integrable (by norm_num)
      (textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two U hU hp β hβ j G hG hsG)
  have hS : Integrable (fun x ↦ s x * G x) (textbookLangevinCanonicalMeasure U β hβ) := by
    have he : (fun x ↦ s x * G x) =
        (fun x ↦ textbookLangevinCanonicalCoordinateAdjointTestExpression U β j G x + D x) := by
      funext x
      dsimp [D, s, textbookLangevinCanonicalCoordinateAdjointTestExpression]
      ring
    rw [he]
    exact hA.add hD
  have he := textbookLangevinCanonicalMeasure_coordinate_integrationByParts U hU hp β hβ G hG hsG j
  change (∫ x, D x ∂textbookLangevinCanonicalMeasure U β hβ) =
    ∫ x, s x * G x ∂textbookLangevinCanonicalMeasure U β hβ at he
  change (∫ x, -D x + s x * G x ∂textbookLangevinCanonicalMeasure U β hβ) = 0
  have hDN : Integrable (fun x ↦ -D x) (textbookLangevinCanonicalMeasure U β hβ) := hD.neg
  rw [integral_add hDN hS, integral_neg]
  linarith [he]

/-- An actual constant belongs to the original weak H1 space with every genuine
coordinate weak derivative zero, derived from true canonical IBP of compact tests. -/
def textbookLangevinCanonicalWeakH1Constant {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (c : ℝ) : textbookLangevinCanonicalWeakH1 U hU hp β hβ :=
  ⟨WithLp.toLp 2 (fun j : Option (Fin N ⊕ Fin N) ↦ match j with
    | none => canonicalMean_constantL2 U hU hp β hβ c
    | some _ => 0), by
      intro j G hG hsG
      change ⟪(0 : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)),
        textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G (canonicalMean_F_continuous G hG) hsG⟫_ℝ =
        ⟪canonicalMean_constantL2 U hU hp β hβ c,
          (textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two U hU hp β hβ j G hG hsG).toLp _⟫_ℝ
      rw [inner_zero_left, L2.inner_def]
      calc
        0 = c * ∫ x, textbookLangevinCanonicalCoordinateAdjointTestExpression U β j G x
            ∂textbookLangevinCanonicalMeasure U β hβ := by
          rw [canonicalMean_coordinateAdjoint_integral_zero U hU hp β hβ j G hG hsG, mul_zero]
        _ = ∫ x, c * textbookLangevinCanonicalCoordinateAdjointTestExpression U β j G x
            ∂textbookLangevinCanonicalMeasure U β hβ := (integral_const_mul _ _).symm
        _ = _ := by
          apply integral_congr_ae
          filter_upwards [canonicalMean_constantL2_ae U hU hp β hβ c,
            (textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two U hU hp β hβ j G hG hsG).coeFn_toLp] with x hx hy
          rw [hx, hy, Real.inner_apply]⟩

/-- The actual H1 constant function class has the stated literal AE representative. -/
theorem textbookLangevinCanonicalWeakH1Constant_value_ae {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (c : ℝ) :
    textbookLangevinCanonicalWeakH1Value U hU hp β hβ
      (textbookLangevinCanonicalWeakH1Constant U hU hp β hβ c) =ᵐ[textbookLangevinCanonicalMeasure U β hβ]
      fun _ ↦ c :=
  canonicalMean_constantL2_ae U hU hp β hβ c

/-- Every actual q/p coordinate weak derivative of the true H1 constant is zero. -/
theorem textbookLangevinCanonicalWeakH1Constant_derivative {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (c : ℝ) (j : Fin N ⊕ Fin N) :
    textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ j
      (textbookLangevinCanonicalWeakH1Constant U hU hp β hβ c) = 0 := rfl

/-- The actual normalized canonical H1 norm of a constant is its absolute value. -/
theorem textbookLangevinCanonicalWeakH1Constant_norm {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (c : ℝ) :
    ‖textbookLangevinCanonicalWeakH1Constant U hU hp β hβ c‖ = |c| := by
  have he : ‖textbookLangevinCanonicalWeakH1Constant U hU hp β hβ c‖ ^ 2 = c ^ 2 := by
    rw [textbookLangevinCanonicalWeakH1_norm_sq]
    change ‖canonicalMean_constantL2 U hU hp β hβ c‖ ^ 2 +
      (∑ _ : Fin N, ‖(0 : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))‖ ^ 2) +
      (∑ _ : Fin N, ‖(0 : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))‖ ^ 2) = c ^ 2
    simp [canonicalMean_constantL2_norm]
  apply (sq_eq_sq₀ (norm_nonneg _) (abs_nonneg c)).mp
  simpa only [sq_abs] using he

/-- Every original weak H1 function class is genuinely integrable under the
same canonical probability; its mean integral is not a nonintegrable totalization. -/
theorem textbookLangevinCanonicalWeakH1Value_integrable {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ) :
    Integrable (textbookLangevinCanonicalWeakH1Value U hU hp β hβ f)
      (textbookLangevinCanonicalMeasure U β hβ) := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  exact MemLp.integrable (q := 2) (by norm_num) (Lp.memLp (textbookLangevinCanonicalWeakH1Value U hU hp β hβ f))

/-- The actual canonical mean on the original weak H1 space as a continuous linear functional. -/
def textbookLangevinCanonicalWeakH1Mean {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) : textbookLangevinCanonicalWeakH1 U hU hp β hβ →L[ℝ] ℝ :=
  (innerSL ℝ (textbookLangevinCanonicalWeakH1Value U hU hp β hβ
    (textbookLangevinCanonicalWeakH1Constant U hU hp β hβ 1))).comp
      (textbookLangevinCanonicalWeakH1Value U hU hp β hβ)

/-- The true continuous mean is precisely the original canonical integral of the actual H1 function. -/
theorem textbookLangevinCanonicalWeakH1Mean_eq_integral {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ) :
    textbookLangevinCanonicalWeakH1Mean U hU hp β hβ f =
    ∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ f x
      ∂textbookLangevinCanonicalMeasure U β hβ := by
  change ⟪textbookLangevinCanonicalWeakH1Value U hU hp β hβ
    (textbookLangevinCanonicalWeakH1Constant U hU hp β hβ 1),
    textbookLangevinCanonicalWeakH1Value U hU hp β hβ f⟫_ℝ = _
  rw [L2.inner_def]
  apply integral_congr_ae
  filter_upwards [textbookLangevinCanonicalWeakH1Constant_value_ae U hU hp β hβ 1] with x hx
  rw [hx, Real.inner_apply, one_mul]

/-- The actual canonical mean of the true H1 constant is that constant. -/
theorem textbookLangevinCanonicalWeakH1Mean_constant {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (c : ℝ) :
    textbookLangevinCanonicalWeakH1Mean U hU hp β hβ
      (textbookLangevinCanonicalWeakH1Constant U hU hp β hβ c) = c := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  rw [textbookLangevinCanonicalWeakH1Mean_eq_integral]
  calc
    _ = ∫ _ : textbookLangevinPeriodicPhase N, c
        ∂textbookLangevinCanonicalMeasure U β hβ :=
      integral_congr_ae (textbookLangevinCanonicalWeakH1Constant_value_ae U hU hp β hβ c)
    _ = c := by simp

/-- The genuine canonical mean has norm bound one in the original H1 norm. -/
theorem textbookLangevinCanonicalWeakH1Mean_norm_le {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ) :
    ‖textbookLangevinCanonicalWeakH1Mean U hU hp β hβ f‖ ≤ ‖f‖ := by
  change ‖⟪canonicalMean_constantL2 U hU hp β hβ 1,
    textbookLangevinCanonicalWeakH1Value U hU hp β hβ f⟫_ℝ‖ ≤ ‖f‖
  have he := norm_inner_le_norm (𝕜 := ℝ) (canonicalMean_constantL2 U hU hp β hβ 1)
    (textbookLangevinCanonicalWeakH1Value U hU hp β hβ f)
  rw [canonicalMean_constantL2_norm, abs_one, one_mul] at he
  exact he.trans (PiLp.norm_apply_le (f : textbookLangevinCanonicalH1Jet U β hβ) none)

/-- The original zero canonical integral condition, as a true H1 closed linear subspace. -/
def textbookLangevinCanonicalWeakH1MeanZero {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) : Submodule ℝ (textbookLangevinCanonicalWeakH1 U hU hp β hβ) :=
  (textbookLangevinCanonicalWeakH1Mean U hU hp β hβ).ker

/-- Membership is exactly the original Proposition 6.4 zero-integral condition. -/
theorem textbookLangevinCanonicalWeakH1MeanZero_mem_iff {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ) :
    f ∈ textbookLangevinCanonicalWeakH1MeanZero U hU hp β hβ ↔
    (∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ f x
      ∂textbookLangevinCanonicalMeasure U β hβ) = 0 := by
  change textbookLangevinCanonicalWeakH1Mean U hU hp β hβ f = 0 ↔ _
  rw [textbookLangevinCanonicalWeakH1Mean_eq_integral]

/-- Closedness of the actual zero-mean subspace follows from the true continuous mean. -/
theorem textbookLangevinCanonicalWeakH1MeanZero_isClosed {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    IsClosed (textbookLangevinCanonicalWeakH1MeanZero U hU hp β hβ :
      Set (textbookLangevinCanonicalWeakH1 U hU hp β hβ)) :=
  (textbookLangevinCanonicalWeakH1Mean U hU hp β hβ).isClosed_ker

/-- The actual mean-zero H1 subspace is complete, without any Poisson solvability premise. -/
instance textbookLangevinCanonicalWeakH1MeanZero_completeSpace {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) : CompleteSpace (textbookLangevinCanonicalWeakH1MeanZero U hU hp β hβ) :=
  (textbookLangevinCanonicalWeakH1MeanZero_isClosed U hU hp β hβ).completeSpace_coe

/-- Actual centering subtracts the true canonical mean times the true H1 constant one. -/
def textbookLangevinCanonicalWeakH1Centering {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    textbookLangevinCanonicalWeakH1 U hU hp β hβ →L[ℝ] textbookLangevinCanonicalWeakH1 U hU hp β hβ :=
  ContinuousLinearMap.id ℝ _ - (textbookLangevinCanonicalWeakH1Mean U hU hp β hβ).smulRight
    (textbookLangevinCanonicalWeakH1Constant U hU hp β hβ 1)

/-- Actual canonical centering always belongs to the original zero-integral subspace. -/
theorem textbookLangevinCanonicalWeakH1Centering_mem_meanZero {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ) :
    textbookLangevinCanonicalWeakH1Centering U hU hp β hβ f ∈
      textbookLangevinCanonicalWeakH1MeanZero U hU hp β hβ := by
  change textbookLangevinCanonicalWeakH1Mean U hU hp β hβ
    (f - textbookLangevinCanonicalWeakH1Mean U hU hp β hβ f •
      textbookLangevinCanonicalWeakH1Constant U hU hp β hβ 1) = 0
  rw [map_sub, map_smul, textbookLangevinCanonicalWeakH1Mean_constant]
  simp

/-- Actual centering fixes every original zero-integral H1 function. -/
theorem textbookLangevinCanonicalWeakH1Centering_of_meanZero {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ)
    (hf : f ∈ textbookLangevinCanonicalWeakH1MeanZero U hU hp β hβ) :
    textbookLangevinCanonicalWeakH1Centering U hU hp β hβ f = f := by
  change textbookLangevinCanonicalWeakH1Mean U hU hp β hβ f = 0 at hf
  change f - textbookLangevinCanonicalWeakH1Mean U hU hp β hβ f •
    textbookLangevinCanonicalWeakH1Constant U hU hp β hβ 1 = f
  simp only [hf, zero_smul, sub_zero]

end
end MolecularDynamics
