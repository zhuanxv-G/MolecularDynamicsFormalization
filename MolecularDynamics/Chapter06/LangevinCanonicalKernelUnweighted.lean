import MolecularDynamics.Chapter06.LangevinCanonicalKernelWeakH1

/-! Necessary unweighted testing bridge for the original closed Langevin kernel.
The genuine positive canonical density is removed inside compact smooth tests.
Weak-gradient constancy and full Poisson solvability remain separate targets. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ENNReal BigOperators InnerProductSpace LinearPMap
namespace MolecularDynamics
noncomputable section

local instance unweightedKernelUnitCircleMeasureSpace : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance unweightedKernelUnitCircleHaar : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance unweightedKernelUnitCircleProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The actual probability density has its genuine smooth periodic real lift. -/
theorem textbookLangevinCanonicalDensity_lift_contDiff {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    ContDiff ℝ ∞ (textbookLangevinCanonicalDensity U β ∘ textbookLangevinPeriodicProjection) := by
  have he : textbookLangevinCanonicalDensity U β ∘ textbookLangevinPeriodicProjection =
      textbookLangevinCanonicalDensityReal U β :=
    funext (textbookLangevinCanonicalDensity_lift U hU hp β hβ)
  rw [he]
  exact textbookLangevinCanonicalDensityReal_contDiff U hU β

/-- Positivity of the same actual density proves smoothness of its reciprocal;
no bounded reciprocal on the full noncompact phase space is assumed. -/
theorem textbookLangevinCanonicalDensity_reciprocal_lift_contDiff {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    ContDiff ℝ ∞ ((fun x ↦ (textbookLangevinCanonicalDensity U β x)⁻¹) ∘ textbookLangevinPeriodicProjection) :=
  (textbookLangevinCanonicalDensity_lift_contDiff U hU hp β hβ).inv
    (fun z ↦ ne_of_gt (textbookLangevinCanonicalDensity_pos U hU β hβ (textbookLangevinPeriodicProjection z)))

private theorem unweightedKernel_density_q_curve {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ)
    (z : textbookLangevinPhase N) (i : Fin N) :
    HasDerivAt (fun t : ℝ ↦ textbookLangevinCanonicalDensityReal U β (z + t • (Pi.single i 1, 0)))
      (-β * textbookConfigurationPartial U i z.1 * textbookLangevinCanonicalDensityReal U β z) 0 := by
  have hline : HasDerivAt (fun t : ℝ ↦ z.1 + t • Pi.single i (1 : ℝ)) (Pi.single i 1) 0 := by
    simpa only [id_eq, one_smul] using! ((hasDerivAt_id (0 : ℝ)).smul_const (Pi.single i (1 : ℝ))).const_add z.1
  have huc := (hU.differentiable (by simp) (z.1 + (0 : ℝ) • Pi.single i 1)).hasFDerivAt.comp_hasDerivAt 0 hline
  have hu : HasDerivAt (fun t : ℝ ↦ U (z.1 + t • Pi.single i (1 : ℝ)))
      (textbookConfigurationPartial U i z.1) 0 := by
    simpa only [Function.comp_apply, zero_smul, add_zero, textbookConfigurationPartial] using! huc
  have hc := ((hu.const_add ((∑ k : Fin N, z.2 k ^ 2) / 2)).const_mul (-β)).exp
  have hd := hc.const_mul ((textbookLangevinCanonicalPartition U β)⁻¹)
  convert! hd using 1
  · funext t
    simp [textbookLangevinCanonicalDensityReal, textbookLangevinGibbsWeight, textbookLangevinHamiltonian]
  · simp only [textbookLangevinCanonicalDensityReal, textbookLangevinGibbsWeight, textbookLangevinHamiltonian,
      zero_smul, add_zero]
    ring

/-- Every actual coordinate derivative of the original density is minus its
literal logarithmic slope times that same normalized density. -/
theorem textbookLangevinCanonicalDensity_coordinate_derivative {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDirectionalDerivative (textbookLangevinCanonicalDensity U β)
      (textbookLangevinCanonicalCoordinateDirection j) x =
      -textbookLangevinCanonicalCoordinateLogSlope U β j x * textbookLangevinCanonicalDensity U β x := by
  obtain ⟨z, rfl⟩ := textbookLangevinPeriodicProjection_surjective N x
  have he : textbookLangevinCanonicalDensity U β ∘ textbookLangevinPeriodicProjection =
      textbookLangevinCanonicalDensityReal U β :=
    funext (textbookLangevinCanonicalDensity_lift U hU hp β hβ)
  rw [textbookLangevinPeriodicDirectionalDerivative_lift, he,
    textbookLangevinCanonicalDensity_lift U hU hp β hβ]
  have hd : deriv (fun t : ℝ ↦ textbookLangevinCanonicalDensityReal U β
      (z + t • textbookLangevinCanonicalCoordinateDirection j)) 0 =
      fderiv ℝ (textbookLangevinCanonicalDensityReal U β) z
        (textbookLangevinCanonicalCoordinateDirection j) := by
    simpa only [zero_smul, add_zero] using
      ((textbookLangevinCanonicalDensityReal_contDiff U hU β).differentiable (by simp)
        (z + (0 : ℝ) • textbookLangevinCanonicalCoordinateDirection j)).deriv_comp_add_smul
  rw [← hd]
  cases j with
  | inl i =>
    rw [textbookLangevinCanonicalCoordinateDirection,
      (unweightedKernel_density_q_curve U hU β z i).deriv]
    simp only [textbookLangevinCanonicalCoordinateLogSlope, neg_mul]
    change -(β * textbookConfigurationPartial U i z.1 * textbookLangevinCanonicalDensityReal U β z) =
      -(β * textbookConfigurationTorusObservable (textbookConfigurationPartial U i)
        (textbookConfigurationTorusProjection z.1) * textbookLangevinCanonicalDensityReal U β z)
    rw [textbookConfigurationTorusObservable_lift _ (textbookConfigurationPartial_periodic U hU hp i)]
  | inr i =>
    unfold textbookLangevinCanonicalCoordinateDirection textbookLangevinCanonicalDensityReal
    rw [deriv_const_mul_field, (textbookLangevinGibbsWeight_momentum_hasDerivAt U β z i 0).deriv]
    simp only [zero_smul, add_zero, textbookLangevinCanonicalCoordinateLogSlope]
    change _ = -(β * z.2 i) * _
    ring

private theorem unweightedKernel_D_one {N : ℕ} (v : textbookLangevinPhase N)
    (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDirectionalDerivative (fun _ ↦ (1 : ℝ)) v x = 0 := by
  unfold textbookLangevinPeriodicDirectionalDerivative
  change fderiv ℝ (fun _ : textbookLangevinPhase N ↦ (1 : ℝ)) _ v = 0
  simp

/-- The reciprocal coordinate derivative follows from genuine product differentiation
and pointwise density positivity, avoiding any global reciprocal bound. -/
theorem textbookLangevinCanonicalDensity_reciprocal_coordinate_derivative {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDirectionalDerivative (fun y ↦ (textbookLangevinCanonicalDensity U β y)⁻¹)
      (textbookLangevinCanonicalCoordinateDirection j) x =
      textbookLangevinCanonicalCoordinateLogSlope U β j x * (textbookLangevinCanonicalDensity U β x)⁻¹ := by
  let R := textbookLangevinCanonicalDensity U β
  have hR := textbookLangevinCanonicalDensity_lift_contDiff U hU hp β hβ
  have hRi := textbookLangevinCanonicalDensity_reciprocal_lift_contDiff U hU hp β hβ
  have hn (y : textbookLangevinPeriodicPhase N) : R y ≠ 0 := ne_of_gt (textbookLangevinCanonicalDensity_pos U hU β hβ y)
  have he : (fun y ↦ R y * (R y)⁻¹) = fun _ ↦ (1 : ℝ) := funext (fun y ↦ mul_inv_cancel₀ (hn y))
  have hd := textbookLangevinPeriodicDirectionalDerivative_mul R (fun y ↦ (R y)⁻¹) hR hRi
    (textbookLangevinCanonicalCoordinateDirection j) x
  rw [he, unweightedKernel_D_one, textbookLangevinCanonicalDensity_coordinate_derivative U hU hp β hβ j x] at hd
  apply (mul_left_cancel₀ (hn x))
  calc
    R x * textbookLangevinPeriodicDirectionalDerivative (fun y ↦ (R y)⁻¹)
        (textbookLangevinCanonicalCoordinateDirection j) x =
      (R x)⁻¹ * (textbookLangevinCanonicalCoordinateLogSlope U β j x * R x) := by linarith [hd]
    _ = R x * (textbookLangevinCanonicalCoordinateLogSlope U β j x * (R x)⁻¹) := by ring

/-- Dividing a genuine smooth test by the actual density cancels the full
weighted transpose slope and gives the literal unweighted coordinate derivative. -/
theorem textbookLangevinCanonicalCoordinateAdjointTestExpression_reciprocal_density {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinCanonicalCoordinateAdjointTestExpression U β j
      (fun y ↦ (textbookLangevinCanonicalDensity U β y)⁻¹ * G y) x =
      -(textbookLangevinCanonicalDensity U β x)⁻¹ *
        textbookLangevinPeriodicDirectionalDerivative G (textbookLangevinCanonicalCoordinateDirection j) x := by
  rw [textbookLangevinCanonicalCoordinateAdjointTestExpression,
    textbookLangevinPeriodicDirectionalDerivative_mul _ G
      (textbookLangevinCanonicalDensity_reciprocal_lift_contDiff U hU hp β hβ) hG,
    textbookLangevinCanonicalDensity_reciprocal_coordinate_derivative U hU hp β hβ j x]
  ring

private theorem unweightedKernel_density_continuous {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) : Continuous (textbookLangevinCanonicalDensity U β) :=
  (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr
    (textbookLangevinCanonicalDensity_lift_contDiff U hU hp β hβ).continuous

/-- Every actual canonical L2 representative is locally integrable in the
original unweighted phase measure. Positivity removes the genuine density
locally; no global bound on its reciprocal is used. -/
theorem textbookLangevinCanonicalL2_unweighted_locallyIntegrable {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) :
    LocallyIntegrable (fun x ↦ f x)
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
  let F : textbookLangevinPeriodicPhase N → ℝ := fun x ↦ f x
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  have hi : Integrable F (textbookLangevinCanonicalMeasure U β hβ) :=
    MemLp.integrable (q := 2) (by norm_num) (Lp.memLp f)
  have hRc := unweightedKernel_density_continuous U hU hp β hβ
  rw [textbookLangevinCanonicalMeasure_withDensity U hU hp β hβ,
    integrable_withDensity_iff_integrable_smul' hRc.measurable.ennreal_ofReal
      (Eventually.of_forall (fun _ ↦ ENNReal.ofReal_lt_top))] at hi
  simp_rw [ENNReal.toReal_ofReal (textbookLangevinCanonicalDensity_pos U hU β hβ _).le, smul_eq_mul] at hi
  have hRi : Continuous (fun x ↦ (textbookLangevinCanonicalDensity U β x)⁻¹) :=
    hRc.inv₀ (fun x ↦ ne_of_gt (textbookLangevinCanonicalDensity_pos U hU β hβ x))
  have hl := LocallyIntegrable.continuous_mul hRi hi.locallyIntegrable
  have he : (fun x ↦ (textbookLangevinCanonicalDensity U β x)⁻¹ *
      (textbookLangevinCanonicalDensity U β x * F x)) = F := by
    funext x
    rw [← mul_assoc, inv_mul_cancel₀ (ne_of_gt (textbookLangevinCanonicalDensity_pos U hU β hβ x)), one_mul]
  rw [he] at hl
  exact hl

private theorem unweightedKernel_integral_density {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ) :
    (∫ x, F x ∂textbookLangevinCanonicalMeasure U β hβ) =
      ∫ x, textbookLangevinCanonicalDensity U β x * F x
        ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
  have hm := (unweightedKernel_density_continuous U hU hp β hβ).measurable.ennreal_ofReal
  rw [textbookLangevinCanonicalMeasure_withDensity U hU hp β hβ,
    integral_withDensity_eq_integral_toReal_smul hm
      (Eventually.of_forall (fun _ ↦ ENNReal.ofReal_lt_top)) _]
  simp_rw [ENNReal.toReal_ofReal (textbookLangevinCanonicalDensity_pos U hU β hβ _).le, smul_eq_mul]

private theorem unweightedKernel_test_integrable {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
    (j : Fin N ⊕ Fin N) (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    Integrable (fun x ↦ f x * textbookLangevinCanonicalCoordinateAdjointTestExpression U β j
      (fun y ↦ (textbookLangevinCanonicalDensity U β y)⁻¹ * G y) x)
      (textbookLangevinCanonicalMeasure U β hβ) := by
  have ht : ContDiff ℝ ∞ ((fun y ↦ (textbookLangevinCanonicalDensity U β y)⁻¹ * G y) ∘
      textbookLangevinPeriodicProjection) :=
    (textbookLangevinCanonicalDensity_reciprocal_lift_contDiff U hU hp β hβ).mul hG
  exact (Lp.memLp f).integrable_mul
    (textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two U hU hp β hβ j _ ht hsG.mul_left)

/-- The original canonical L2 representative is genuinely integrable against
every compact smooth coordinate derivative in Haar times momentum Lebesgue measure.
This is a proved local integrability bridge, not a totalized-integral convention. -/
theorem textbookLangevinCanonicalL2_unweighted_derivative_test_integrable {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
    (j : Fin N ⊕ Fin N) (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    Integrable (fun x ↦ f x *
      textbookLangevinPeriodicDirectionalDerivative G (textbookLangevinCanonicalCoordinateDirection j) x)
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
  let F : textbookLangevinPeriodicPhase N → ℝ := fun x ↦ f x *
    textbookLangevinCanonicalCoordinateAdjointTestExpression U β j
      (fun y ↦ (textbookLangevinCanonicalDensity U β y)⁻¹ * G y) x
  have hi : Integrable F (textbookLangevinCanonicalMeasure U β hβ) :=
    unweightedKernel_test_integrable U hU hp β hβ f j G hG hsG
  rw [textbookLangevinCanonicalMeasure_withDensity U hU hp β hβ,
    integrable_withDensity_iff_integrable_smul'
      (unweightedKernel_density_continuous U hU hp β hβ).measurable.ennreal_ofReal
      (Eventually.of_forall (fun _ ↦ ENNReal.ofReal_lt_top))] at hi
  have he : (fun x ↦ (ENNReal.ofReal (textbookLangevinCanonicalDensity U β x)).toReal • F x) =
      fun x ↦ -(f x * textbookLangevinPeriodicDirectionalDerivative G
        (textbookLangevinCanonicalCoordinateDirection j) x) := by
    funext x
    dsimp only [F]
    rw [ENNReal.toReal_ofReal (textbookLangevinCanonicalDensity_pos U hU β hβ x).le,
      textbookLangevinCanonicalCoordinateAdjointTestExpression_reciprocal_density U hU hp β hβ j G hG x]
    simp only [smul_eq_mul]
    field_simp [ne_of_gt (textbookLangevinCanonicalDensity_pos U hU β hβ x)]
  rw [he] at hi
  exact integrable_neg_iff.mp hi

/-- The actual closed Langevin kernel has zero ordinary weak coordinate
derivative on every genuine compact smooth periodic test in the unweighted
Haar times Lebesgue phase measure, derived by removing its actual density. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_unweighted_coordinate_testing {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0)
    (j : Fin N ⊕ Fin N) (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinPeriodicDirectionalDerivative G (textbookLangevinCanonicalCoordinateDirection j) x
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) = 0 := by
  let T : textbookLangevinPeriodicPhase N → ℝ := fun y ↦ (textbookLangevinCanonicalDensity U β y)⁻¹ * G y
  have ht : ContDiff ℝ ∞ (T ∘ textbookLangevinPeriodicProjection) :=
    (textbookLangevinCanonicalDensity_reciprocal_lift_contDiff U hU hp β hβ).mul hG
  have hsT : HasCompactSupport T := hsG.mul_left
  have hz : (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinCanonicalCoordinateAdjointTestExpression U β j T x
      ∂textbookLangevinCanonicalMeasure U β hβ) = 0 := by
    cases j with
    | inl i =>
      exact textbookLangevinCanonicalHilbertClosedOperator_kernel_position_testing U hU hp β γ σ hβ hγ hσ f hf i T ht hsT
    | inr i =>
      exact textbookLangevinCanonicalHilbertClosedOperator_kernel_momentum_testing U hU hp β γ σ hβ hγ hσ f hf i T ht hsT
  rw [unweightedKernel_integral_density U hU hp β hβ] at hz
  have he : (∫ x, textbookLangevinCanonicalDensity U β x *
      ((f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
        textbookLangevinCanonicalCoordinateAdjointTestExpression U β j T x)
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) =
      -(∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
        textbookLangevinPeriodicDirectionalDerivative G (textbookLangevinCanonicalCoordinateDirection j) x
        ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) := by
    rw [← integral_neg]
    apply integral_congr_ae
    filter_upwards [] with x
    dsimp only [T]
    rw [textbookLangevinCanonicalCoordinateAdjointTestExpression_reciprocal_density U hU hp β hβ j G hG x]
    field_simp [ne_of_gt (textbookLangevinCanonicalDensity_pos U hU β hβ x)]
  linarith [he, hz]

end
end MolecularDynamics
