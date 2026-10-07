import MolecularDynamics.Chapter06.LangevinCanonicalWeightedAdjoint

/-! True density conjugation between the original Lebesgue forward expression
and the canonical-weight formal transpose. No closed operator domain is asserted. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ZeroAtInfty BigOperators
namespace MolecularDynamics
noncomputable section

private theorem conjugation_linear_basis {N : ℕ}
    (A : textbookLangevinPhase N →L[ℝ] ℝ) (q p : Fin N → ℝ) :
    A (q, p) =
      (∑ i : Fin N, q i * A (Pi.single i 1, 0)) +
      ∑ i : Fin N, p i * A (0, Pi.single i 1) := by
  classical
  have hq : (∑ i : Fin N, q i • ((Pi.single i 1 : Fin N → ℝ), (0 : Fin N → ℝ))) = (q, 0) := by
    apply Prod.ext
    · rw [Prod.fst_sum]
      change (∑ i : Fin N, q i • Pi.single i 1) = q
      exact (pi_eq_sum_univ' q).symm
    · rw [Prod.snd_sum]
      simp
  have hp : (∑ i : Fin N, p i • ((0 : Fin N → ℝ), (Pi.single i 1 : Fin N → ℝ))) = (0, p) := by
    apply Prod.ext
    · rw [Prod.fst_sum]
      simp
    · rw [Prod.snd_sum]
      change (∑ i : Fin N, p i • Pi.single i 1) = p
      exact (pi_eq_sum_univ' p).symm
  have he : (q, p) = (∑ i : Fin N, q i • ((Pi.single i 1 : Fin N → ℝ), (0 : Fin N → ℝ))) +
      ∑ i : Fin N, p i • ((0 : Fin N → ℝ), (Pi.single i 1 : Fin N → ℝ)) := by
    rw [hq, hp]
    simp only [Prod.mk_add_mk, add_zero, zero_add]
  rw [he, map_add, map_sum, map_sum]
  simp only [map_smul, smul_eq_mul]

private theorem conjugation_lift_mul {N : ℕ} (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) :
    ContDiff ℝ ∞ ((fun x ↦ F x * G x) ∘ textbookLangevinPeriodicProjection) := by
  simpa only [Function.comp_apply] using! hF.mul hG

private theorem conjugation_forward {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ σ (F ∘ textbookLangevinPeriodicProjection) z =
      textbookLangevinPeriodicDifferentialOperator U γ σ F (textbookLangevinPeriodicProjection z) -
        2 * textbookLangevinPeriodicDirectionalDerivative F (textbookLangevinDrift U γ z)
          (textbookLangevinPeriodicProjection z) -
        textbookLangevinPhaseDivergence (textbookLangevinDrift U γ) z * F (textbookLangevinPeriodicProjection z) := by
  rw [textbookLangevinPeriodicDifferentialOperator_C2_lift U hU hp γ σ F
    (hF.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)),
    textbookLangevinPeriodicDirectionalDerivative_lift]
  have hd : deriv (fun t : ℝ ↦ (F ∘ textbookLangevinPeriodicProjection)
      (z + t • textbookLangevinDrift U γ z)) 0 =
      fderiv ℝ (F ∘ textbookLangevinPeriodicProjection) z (textbookLangevinDrift U γ z) := by
    simpa only [zero_smul, add_zero] using
      (hF.differentiable (by simp) (z + (0 : ℝ) • textbookLangevinDrift U γ z)).deriv_comp_add_smul
  unfold textbookLangevinForwardDifferentialOperator textbookLangevinDifferentialOperator
  rw [hd]
  change -fderiv ℝ (F ∘ textbookLangevinPeriodicProjection) z (textbookLangevinDrift U γ z) -
    textbookLangevinPhaseDivergence (textbookLangevinDrift U γ) z * F (textbookLangevinPeriodicProjection z) + _ = _
  ring

private theorem conjugation_density_partial {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (z : textbookLangevinPhase N) (i : Fin N) :
    textbookLangevinPeriodicDirectionalDerivative (textbookLangevinCanonicalDensity U β) (0, Pi.single i 1)
      (textbookLangevinPeriodicProjection z) =
      -β * z.2 i * textbookLangevinCanonicalDensity U β (textbookLangevinPeriodicProjection z) := by
  have he : textbookLangevinCanonicalDensity U β ∘ textbookLangevinPeriodicProjection =
      textbookLangevinCanonicalDensityReal U β :=
    funext (textbookLangevinCanonicalDensity_lift U hU hp β hβ)
  rw [textbookLangevinPeriodicDirectionalDerivative_lift, he, textbookLangevinCanonicalDensity_lift U hU hp β hβ]
  have hd : deriv (fun t : ℝ ↦ textbookLangevinCanonicalDensityReal U β
      (z + t • ((0 : Fin N → ℝ), Pi.single i 1))) 0 =
      fderiv ℝ (textbookLangevinCanonicalDensityReal U β) z (0, Pi.single i 1) := by
    simpa only [zero_smul, add_zero] using
      ((textbookLangevinCanonicalDensityReal_contDiff U hU β).differentiable (by simp)
        (z + (0 : ℝ) • ((0 : Fin N → ℝ), Pi.single i 1))).deriv_comp_add_smul
  rw [← hd]
  unfold textbookLangevinCanonicalDensityReal
  rw [deriv_const_mul_field, (textbookLangevinGibbsWeight_momentum_hasDerivAt U β z i 0).deriv]
  simp only [zero_smul, add_zero]
  ring

private theorem conjugation_drift_split {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (γ : ℝ) (F : textbookLangevinPeriodicPhase N → ℝ) (z : textbookLangevinPhase N) :
    textbookLangevinPeriodicDirectionalDerivative F (textbookLangevinDrift U γ z)
        (textbookLangevinPeriodicProjection z) =
      textbookLangevinPeriodicHamiltonianTransportExpression U F (textbookLangevinPeriodicProjection z) -
        γ * ∑ i : Fin N, z.2 i * textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1)
          (textbookLangevinPeriodicProjection z) := by
  unfold textbookLangevinPeriodicHamiltonianTransportExpression
  simp_rw [textbookLangevinPeriodicDirectionalDerivative_lift]
  have heU (i : Fin N) : textbookConfigurationTorusObservable (textbookConfigurationPartial U i)
        (textbookLangevinPeriodicProjection z).1 = textbookConfigurationPartial U i z.1 :=
    textbookConfigurationTorusObservable_lift _ (textbookConfigurationPartial_periodic U hU hp i) z.1
  simp_rw [heU]
  change fderiv ℝ (F ∘ textbookLangevinPeriodicProjection) z
    (z.2, textbookPotentialForce U z.1 - γ • z.2) = _
  rw [conjugation_linear_basis]
  dsimp only [textbookLangevinPeriodicProjection]
  simp only [textbookPotentialForce, textbookConfigurationPartial, Pi.sub_apply, Pi.smul_apply, smul_eq_mul]
  simp only [sub_mul, neg_mul, mul_assoc, Finset.sum_sub_distrib,
    Finset.sum_neg_distrib, ← Finset.mul_sum]
  ring

/-- The actual normalized canonical density conjugates the original
Lebesgue forward differential expression to the canonical-weight formal
transpose, at every real representative and for every smooth phase test.
No compact support, core, adjoint domain or stationary law is assumed. -/
theorem textbookLangevinForwardDifferentialOperator_canonical_conjugation {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ σ
      (fun y ↦ textbookLangevinCanonicalDensityReal U β y * F (textbookLangevinPeriodicProjection y)) z =
    textbookLangevinCanonicalDensityReal U β z *
      textbookLangevinCanonicalWeightedFormalAdjointExpression U β γ F (textbookLangevinPeriodicProjection z) := by
  let R := textbookLangevinCanonicalDensity U β
  let x := textbookLangevinPeriodicProjection z
  have heR : R ∘ textbookLangevinPeriodicProjection = textbookLangevinCanonicalDensityReal U β :=
    funext (textbookLangevinCanonicalDensity_lift U hU hp β hβ)
  have hR : ContDiff ℝ ∞ (R ∘ textbookLangevinPeriodicProjection) := by
    rw [heR]
    exact textbookLangevinCanonicalDensityReal_contDiff U hU β
  have heProd : (fun y ↦ textbookLangevinCanonicalDensityReal U β y * F (textbookLangevinPeriodicProjection y)) =
      (fun y ↦ F y * R y) ∘ textbookLangevinPeriodicProjection := by
    funext y
    rw [← congrFun heR y]
    change R (textbookLangevinPeriodicProjection y) * F (textbookLangevinPeriodicProjection y) = _
    exact mul_comm _ _
  have hzero : textbookLangevinForwardDifferentialOperator U γ σ (R ∘ textbookLangevinPeriodicProjection) z = 0 := by
    rw [heR]
    exact textbookLangevinForwardDifferentialOperator_canonical_eq_zero U (hU.differentiable (by simp)) β γ σ hβ hσ z
  have heForward :
      textbookLangevinForwardDifferentialOperator U γ σ
        ((fun y ↦ F y * R y) ∘ textbookLangevinPeriodicProjection) z =
      F x * textbookLangevinForwardDifferentialOperator U γ σ (R ∘ textbookLangevinPeriodicProjection) z +
        R x * textbookLangevinPeriodicDifferentialOperator U γ σ F x -
        2 * R x * textbookLangevinPeriodicDirectionalDerivative F (textbookLangevinDrift U γ z) x +
        σ ^ 2 * ∑ i : Fin N, textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x *
          textbookLangevinPeriodicDirectionalDerivative R (0, Pi.single i 1) x := by
    rw [conjugation_forward U hU hp γ σ _ (conjugation_lift_mul F R hF hR),
      textbookLangevinPeriodicDifferentialOperator_product U hU hp β γ σ hβ hσ F R hF hR,
      textbookLangevinPeriodicDirectionalDerivative_mul F R hF hR,
      conjugation_forward U hU hp γ σ R hR]
    dsimp only [x]
    ring
  have heSum : (∑ i : Fin N, textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x *
      textbookLangevinPeriodicDirectionalDerivative R (0, Pi.single i 1) x) =
      -β * R x * ∑ i : Fin N, z.2 i * textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x := by
    dsimp only [R, x]
    simp_rw [conjugation_density_partial U hU hp β hβ z]
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i _
    ring
  have hecoef : σ ^ 2 * (-β) = -2 * γ := by
    rw [hσ]
    field_simp [hβ.ne']
  rw [heProd, heForward, hzero, mul_zero, zero_add, heSum]
  rw [conjugation_drift_split U hU hp γ F z,
    textbookLangevinPeriodicDifferentialOperator_canonical_split U hU hp β γ σ hβ hσ F hF]
  rw [← textbookLangevinCanonicalDensity_lift U hU hp β hβ z]
  change _ = R x * (-textbookLangevinPeriodicHamiltonianTransportExpression U F x +
    textbookLangevinPeriodicMomentumOUExpression β γ F x)
  change R x * (textbookLangevinPeriodicHamiltonianTransportExpression U F x +
      textbookLangevinPeriodicMomentumOUExpression β γ F x) -
    2 * R x * (textbookLangevinPeriodicHamiltonianTransportExpression U F x -
      γ * ∑ i : Fin N, z.2 i * textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x) +
    σ ^ 2 * (-β * R x * ∑ i : Fin N, z.2 i * textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x) = _
  have hecoef' : σ ^ 2 * (-β * R x *
      ∑ i : Fin N, z.2 i * textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x) =
      -2 * γ * R x * ∑ i : Fin N, z.2 i * textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x := by
    rw [← mul_assoc, ← mul_assoc, hecoef]
  rw [hecoef']
  ring

/-- The original positive-temperature square-root noise gives the same
true normalized-density conjugation without assuming its coefficient. -/
theorem textbookLangevinForwardDifferentialOperator_physical_canonical_conjugation {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β) (hγ : 0 < γ)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
      (fun y ↦ textbookLangevinCanonicalDensityReal U β y * F (textbookLangevinPeriodicProjection y)) z =
    textbookLangevinCanonicalDensityReal U β z *
      textbookLangevinCanonicalWeightedFormalAdjointExpression U β γ F (textbookLangevinPeriodicProjection z) := by
  apply textbookLangevinForwardDifferentialOperator_canonical_conjugation U hU hp β γ _ hβ _ F hF z
  simpa only [div_eq_mul_inv] using
    Real.sq_sqrt (mul_nonneg (mul_nonneg (by norm_num : (0 : ℝ) ≤ 2) hγ.le) (inv_nonneg.mpr hβ.le))

/-- At the smooth expression level, the actual strictly positive canonical
density gives true equivalence of forward zero density times F and weighted
formal-transpose zero F. This is not a statement on closed operator domains. -/
theorem textbookLangevinCanonicalWeightedFormalAdjointExpression_zero_iff_forward {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) :
    (∀ x, textbookLangevinCanonicalWeightedFormalAdjointExpression U β γ F x = 0) ↔
      ∀ z, textbookLangevinForwardDifferentialOperator U γ σ
        (fun y ↦ textbookLangevinCanonicalDensityReal U β y * F (textbookLangevinPeriodicProjection y)) z = 0 := by
  constructor
  · intro hz z
    rw [textbookLangevinForwardDifferentialOperator_canonical_conjugation U hU hp β γ σ hβ hσ F hF z,
      hz, mul_zero]
  · intro hz x
    obtain ⟨z, rfl⟩ := textbookLangevinPeriodicProjection_surjective N x
    have he := hz z
    rw [textbookLangevinForwardDifferentialOperator_canonical_conjugation U hU hp β γ σ hβ hσ F hF z] at he
    have hr : 0 < textbookLangevinCanonicalDensityReal U β z := by
      rw [← textbookLangevinCanonicalDensity_lift U hU hp β hβ z]
      exact textbookLangevinCanonicalDensity_pos U hU β hβ _
    exact (mul_eq_zero.mp he).resolve_left hr.ne'

end
end MolecularDynamics
