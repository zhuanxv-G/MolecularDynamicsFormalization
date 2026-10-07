import MolecularDynamics.Chapter06.LangevinCanonicalEnergy

/-! Canonical-weight formal transpose on genuine compact smooth phase tests.
This is a required analytic identity, not a closed Hilbert adjoint domain. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ZeroAtInfty BigOperators
namespace MolecularDynamics
noncomputable section

private theorem adjoint_slice_compact {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (hs : HasCompactSupport F)
    (Q : UnitAddTorus (Fin N)) :
    HasCompactSupport (fun p : Fin N → ℝ ↦ F (Q, p)) := by
  have hK : IsCompact (Prod.snd '' tsupport F) := hs.isCompact.image continuous_snd
  apply hK.of_isClosed_subset isClosed_closure
  apply closure_minimal _ hK.isClosed
  intro p hp
  exact ⟨(Q, p), subset_closure hp, rfl⟩

private theorem adjoint_slice_p_derivative {N : ℕ}
    (g : textbookLangevinPhase N → ℝ) (hg : ContDiff ℝ ∞ g)
    (q p v : Fin N → ℝ) :
    fderiv ℝ (fun y ↦ g (q, y)) p v = fderiv ℝ g (q, p) (0, v) := by
  have hi : HasFDerivAt (fun y : Fin N → ℝ ↦ (q, y))
      ((0 : (Fin N → ℝ) →L[ℝ] (Fin N → ℝ)).prod (ContinuousLinearMap.id ℝ (Fin N → ℝ))) p := by
    simpa only [id_eq] using! (hasFDerivAt_const q p).prodMk (hasFDerivAt_id (𝕜 := ℝ) p)
  have h : HasFDerivAt (fun y ↦ g (q, y))
      ((fderiv ℝ g (q, p)).comp
        ((0 : (Fin N → ℝ) →L[ℝ] (Fin N → ℝ)).prod (ContinuousLinearMap.id ℝ (Fin N → ℝ)))) p := by
    simpa only [Function.comp_def] using! (hg.differentiable (by simp) (q, p)).hasFDerivAt.comp p hi
  rw [h.fderiv]
  rfl

private theorem adjoint_rep {N : ℕ} (F : textbookLangevinPeriodicPhase N → ℝ)
    (Q : UnitAddTorus (Fin N)) (p : Fin N → ℝ) :
    (F ∘ textbookLangevinPeriodicProjection) (textbookConfigurationTorusRepresentative Q, p) = F (Q, p) := by
  change F (textbookConfigurationTorusProjection (textbookConfigurationTorusRepresentative Q), p) = _
  rw [textbookConfigurationTorusRepresentative_projects]

private theorem adjoint_p_partial {N : ℕ} (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (Q : UnitAddTorus (Fin N)) (p v : Fin N → ℝ) :
    fderiv ℝ (fun y ↦ F (Q, y)) p v =
      textbookLangevinPeriodicDirectionalDerivative F (0, v) (Q, p) := by
  have he : (fun y ↦ F (Q, y)) =
      fun y ↦ (F ∘ textbookLangevinPeriodicProjection) (textbookConfigurationTorusRepresentative Q, y) :=
    funext (fun y ↦ (adjoint_rep F Q y).symm)
  rw [he]
  exact adjoint_slice_p_derivative _ hG _ p v

private theorem adjoint_lift_mul {N : ℕ} (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) :
    ContDiff ℝ ∞ ((fun x ↦ F x * G x) ∘ textbookLangevinPeriodicProjection) := by
  simpa only [Function.comp_apply] using! hF.mul hG

/-- True unweighted momentum integration by parts under the actual full
canonical probability, derived for arbitrary compact smooth phase tests
by genuine Gaussian slices and joint Fubini. -/
theorem textbookLangevinCanonicalMeasure_unweighted_momentum_integrationByParts {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F)
    (i : Fin N) :
    (∫ x, textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x
      ∂textbookLangevinCanonicalMeasure U β hβ) =
      β * ∫ x, x.2 i * F x ∂textbookLangevinCanonicalMeasure U β hβ := by
  have : IsProbabilityMeasure (textbookConfigurationTorusGibbsMeasure U β) :=
    textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hp β
  have : IsProbabilityMeasure (textbookLangevinCanonicalMomentumMeasure N β hβ) :=
    textbookLangevinCanonicalMomentumMeasure_isProbabilityMeasure N β hβ
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  have hFc : Continuous F :=
    (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hF.continuous
  have hi1 : Integrable (textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1))
      (textbookLangevinCanonicalMeasure U β hβ) :=
    (textbookLangevinPeriodicDirectionalDerivative_continuous F hF _).integrable_of_hasCompactSupport
      (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hs _)
  have hi2 : Integrable (fun x : textbookLangevinPeriodicPhase N ↦ x.2 i * F x)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    (((continuous_apply i).comp continuous_snd).mul hFc).integrable_of_hasCompactSupport hs.mul_left
  have he (Q : UnitAddTorus (Fin N)) :
      (∫ p, textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) (Q, p)
        ∂textbookLangevinCanonicalMomentumMeasure N β hβ) =
      β * ∫ p, p i * F (Q, p) ∂textbookLangevinCanonicalMomentumMeasure N β hβ := by
    have hf : ContDiff ℝ ∞ (fun p : Fin N → ℝ ↦ F (Q, p)) := by
      have heF : (fun p ↦ F (Q, p)) =
        fun p ↦ (F ∘ textbookLangevinPeriodicProjection) (textbookConfigurationTorusRepresentative Q, p) :=
          funext (fun p ↦ (adjoint_rep F Q p).symm)
      rw [heF]
      exact hF.comp (contDiff_const.prodMk contDiff_id)
    have hb := textbookLangevinCanonicalMomentumMeasure_integrationByParts N β hβ (fun p ↦ F (Q, p))
      (hf.of_le (by simp)) (adjoint_slice_compact F hs Q) i
    simp_rw [adjoint_p_partial F hF Q] at hb
    exact hb
  change (∫ x, textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x
    ∂(textbookConfigurationTorusGibbsMeasure U β).prod (textbookLangevinCanonicalMomentumMeasure N β hβ)) = _
  rw [integral_prod _ hi1]
  change _ = β * ∫ x, x.2 i * F x
    ∂(textbookConfigurationTorusGibbsMeasure U β).prod (textbookLangevinCanonicalMomentumMeasure N β hβ)
  rw [integral_prod _ hi2]
  simp_rw [he, integral_const_mul]

/-- The original unit-mass Hamiltonian transport expression on actual
periodic phase observables, with genuine descended derivatives. -/
def textbookLangevinPeriodicHamiltonianTransportExpression {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (F : textbookLangevinPeriodicPhase N → ℝ)
    (x : textbookLangevinPeriodicPhase N) : ℝ :=
  ∑ i : Fin N, (x.2 i * textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) x -
    textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 *
      textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x)

/-- The original fluctuation-dissipation momentum expression on the actual
full phase space; the constant factor is gamma / beta. -/
def textbookLangevinPeriodicMomentumOUExpression {N : ℕ}
    (β γ : ℝ) (F : textbookLangevinPeriodicPhase N → ℝ)
    (x : textbookLangevinPeriodicPhase N) : ℝ :=
  γ * ∑ i : Fin N, (β⁻¹ * textbookLangevinPeriodicDirectionalDerivative
      (textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1)) (0, Pi.single i 1) x -
    x.2 i * textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x)

/-- The canonical-weight formal transpose expression reverses Hamiltonian
transport and retains momentum OU. It does not define a closed Hilbert
adjoint or assume a core or stationary transition law. -/
def textbookLangevinCanonicalWeightedFormalAdjointExpression {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β γ : ℝ) (F : textbookLangevinPeriodicPhase N → ℝ)
    (x : textbookLangevinPeriodicPhase N) : ℝ :=
  -textbookLangevinPeriodicHamiltonianTransportExpression U F x +
    textbookLangevinPeriodicMomentumOUExpression β γ F x

private theorem adjoint_H_eq {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) :
    textbookLangevinPeriodicHamiltonianTransportExpression U F =
      textbookLangevinPeriodicDifferentialOperator U 0 0 F := by
  funext x
  rw [textbookLangevinPeriodicDifferentialOperator_canonical_split U hU hp 1 0 0
    (by norm_num) (by simp) F hF]
  simp [textbookLangevinPeriodicHamiltonianTransportExpression]

private theorem adjoint_H_continuous {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) :
    Continuous (textbookLangevinPeriodicHamiltonianTransportExpression U F) := by
  rw [adjoint_H_eq U hU hp F hF]
  exact textbookLangevinPeriodicDifferentialOperator_C2_continuous U hU hp 0 0 F
    (hF.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp))

private theorem adjoint_O_continuous {N : ℕ} (β γ : ℝ)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) :
    Continuous (textbookLangevinPeriodicMomentumOUExpression β γ F) := by
  apply Continuous.const_mul
  apply continuous_finsetSum
  intro i _
  exact ((textbookLangevinPeriodicDirectionalDerivative_continuous _
    (textbookLangevinPeriodicDirectionalDerivative_lift_contDiff F hF _) _).const_mul β⁻¹).sub
    (((continuous_apply i).comp continuous_snd).mul
      (textbookLangevinPeriodicDirectionalDerivative_continuous F hF _))

private theorem adjoint_continuous {N : ℕ} (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) : Continuous F :=
  (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hF.continuous

private theorem adjoint_mul_integrable {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hFc : Continuous F) (hGc : Continuous G) (hs : HasCompactSupport F) :
    Integrable (fun x ↦ F x * G x) (textbookLangevinCanonicalMeasure U β hβ) := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  exact (hFc.mul hGc).integrable_of_hasCompactSupport hs.mul_right

private theorem adjoint_H_product {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicHamiltonianTransportExpression U (fun y ↦ F y * G y) x =
      F x * textbookLangevinPeriodicHamiltonianTransportExpression U G x +
        G x * textbookLangevinPeriodicHamiltonianTransportExpression U F x := by
  rw [adjoint_H_eq U hU hp _ (adjoint_lift_mul F G hF hG),
    adjoint_H_eq U hU hp G hG, adjoint_H_eq U hU hp F hF]
  simpa using textbookLangevinPeriodicDifferentialOperator_product U hU hp 1 0 0
    (by norm_num) (by simp) F G hF hG x

/-- Hamiltonian transport is genuinely antisymmetric for the same actual
canonical probability on arbitrary compact smooth phase tests. -/
theorem textbookLangevinCanonicalMeasure_hamiltonian_antisymmetry {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection))
    (hsF : HasCompactSupport F) (hsG : HasCompactSupport G) :
    (∫ x, F x * textbookLangevinPeriodicHamiltonianTransportExpression U G x
      ∂textbookLangevinCanonicalMeasure U β hβ) =
    -(∫ x, G x * textbookLangevinPeriodicHamiltonianTransportExpression U F x
      ∂textbookLangevinCanonicalMeasure U β hβ) := by
  have hi1 := adjoint_mul_integrable U hU hp β hβ F _ (adjoint_continuous F hF)
    (adjoint_H_continuous U hU hp G hG) hsF
  have hi2 := adjoint_mul_integrable U hU hp β hβ G _ (adjoint_continuous G hG)
    (adjoint_H_continuous U hU hp F hF) hsG
  have hz := textbookLangevinCanonicalMeasure_weak_balance U hU hp β 0 0 hβ (by simp)
    (fun x ↦ F x * G x) (adjoint_lift_mul F G hF hG) hsF.mul_right
  rw [← adjoint_H_eq U hU hp _ (adjoint_lift_mul F G hF hG)] at hz
  have he : textbookLangevinPeriodicHamiltonianTransportExpression U (fun x ↦ F x * G x) =
      fun x ↦ F x * textbookLangevinPeriodicHamiltonianTransportExpression U G x +
        G x * textbookLangevinPeriodicHamiltonianTransportExpression U F x :=
    funext (adjoint_H_product U hU hp F G hF hG)
  rw [he, integral_add hi1 hi2] at hz
  linarith

/-- The momentum OU Dirichlet identity is proved by actual full-phase
momentum integration by parts of F times the true momentum derivative of G.
No adjoint, energy or integrability identity is a hypothesis. -/
theorem textbookLangevinCanonicalMeasure_momentum_ou_dirichlet {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β) (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsF : HasCompactSupport F) :
    (∫ x, F x * textbookLangevinPeriodicMomentumOUExpression β γ G x
      ∂textbookLangevinCanonicalMeasure U β hβ) =
    -(γ * β⁻¹) * ∫ x, ∑ i : Fin N,
      textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x *
        textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1) x
      ∂textbookLangevinCanonicalMeasure U β hβ := by
  let canonicalLaw := textbookLangevinCanonicalMeasure U β hβ
  let v : Fin N → textbookLangevinPhase N := fun i ↦ (0, Pi.single i 1)
  let D := fun i : Fin N ↦ textbookLangevinPeriodicDirectionalDerivative G (v i)
  have hD (i : Fin N) : ContDiff ℝ ∞ (D i ∘ textbookLangevinPeriodicProjection) :=
    textbookLangevinPeriodicDirectionalDerivative_lift_contDiff G hG (v i)
  have hDc (i : Fin N) : Continuous (D i) :=
    textbookLangevinPeriodicDirectionalDerivative_continuous G hG (v i)
  have hDDc (i : Fin N) : Continuous (textbookLangevinPeriodicDirectionalDerivative (D i) (v i)) :=
    textbookLangevinPeriodicDirectionalDerivative_continuous (D i) (hD i) (v i)
  have hiA (i : Fin N) : Integrable (fun x ↦ textbookLangevinPeriodicDirectionalDerivative F (v i) x * D i x) canonicalLaw :=
    adjoint_mul_integrable U hU hp β hβ _ _ (textbookLangevinPeriodicDirectionalDerivative_continuous F hF (v i))
      (hDc i) (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hsF (v i))
  have hiB (i : Fin N) : Integrable (fun x ↦ F x * textbookLangevinPeriodicDirectionalDerivative (D i) (v i) x) canonicalLaw :=
    adjoint_mul_integrable U hU hp β hβ _ _ (adjoint_continuous F hF) (hDDc i) hsF
  have hiC (i : Fin N) : Integrable (fun x : textbookLangevinPeriodicPhase N ↦ F x * (x.2 i * D i x)) canonicalLaw :=
    adjoint_mul_integrable U hU hp β hβ _ _ (adjoint_continuous F hF)
      (((continuous_apply i).comp continuous_snd).mul (hDc i)) hsF
  have hiZ (i : Fin N) : Integrable (fun x : textbookLangevinPeriodicPhase N ↦
      F x * (β⁻¹ * textbookLangevinPeriodicDirectionalDerivative (D i) (v i) x - x.2 i * D i x)) canonicalLaw := by
    convert! ((hiB i).const_mul β⁻¹).sub (hiC i) using 1
    funext x
    simp only [Pi.sub_apply]
    ring
  have hz (i : Fin N) :
      (∫ x, F x * (β⁻¹ * textbookLangevinPeriodicDirectionalDerivative (D i) (v i) x - x.2 i * D i x) ∂canonicalLaw) =
      -β⁻¹ * ∫ x, textbookLangevinPeriodicDirectionalDerivative F (v i) x * D i x ∂canonicalLaw := by
    have hb := textbookLangevinCanonicalMeasure_unweighted_momentum_integrationByParts U hU hp β hβ
      (fun x ↦ F x * D i x) (adjoint_lift_mul F (D i) hF (hD i)) hsF.mul_right i
    have heD : textbookLangevinPeriodicDirectionalDerivative (fun x ↦ F x * D i x) (v i) =
        fun x ↦ textbookLangevinPeriodicDirectionalDerivative F (v i) x * D i x +
          F x * textbookLangevinPeriodicDirectionalDerivative (D i) (v i) x := by
      funext x
      rw [textbookLangevinPeriodicDirectionalDerivative_mul F (D i) hF (hD i)]
      ring
    have heC : (fun x : textbookLangevinPeriodicPhase N ↦ x.2 i * (F x * D i x)) =
        (fun x ↦ F x * (x.2 i * D i x)) := by funext x; ring
    change (∫ x, textbookLangevinPeriodicDirectionalDerivative (fun x ↦ F x * D i x) (v i) x ∂canonicalLaw) =
      β * ∫ x, x.2 i * (F x * D i x) ∂canonicalLaw at hb
    rw [heD, heC, integral_add (hiA i) (hiB i)] at hb
    have heZ : (fun x : textbookLangevinPeriodicPhase N ↦
        F x * (β⁻¹ * textbookLangevinPeriodicDirectionalDerivative (D i) (v i) x - x.2 i * D i x)) =
        (fun x ↦ β⁻¹ * (F x * textbookLangevinPeriodicDirectionalDerivative (D i) (v i) x) -
          F x * (x.2 i * D i x)) := by funext x; ring
    rw [heZ, integral_sub ((hiB i).const_mul β⁻¹) (hiC i), integral_const_mul]
    calc
      _ = β⁻¹ * ((∫ x, textbookLangevinPeriodicDirectionalDerivative F (v i) x * D i x ∂canonicalLaw) +
          (∫ x, F x * textbookLangevinPeriodicDirectionalDerivative (D i) (v i) x ∂canonicalLaw)) -
          (∫ x, F x * (x.2 i * D i x) ∂canonicalLaw) -
          β⁻¹ * (∫ x, textbookLangevinPeriodicDirectionalDerivative F (v i) x * D i x ∂canonicalLaw) := by ring
      _ = -β⁻¹ * ∫ x, textbookLangevinPeriodicDirectionalDerivative F (v i) x * D i x ∂canonicalLaw := by
        rw [hb, ← mul_assoc, inv_mul_cancel₀ hβ.ne', one_mul]
        ring
  have heL : (fun x ↦ F x * textbookLangevinPeriodicMomentumOUExpression β γ G x) =
      (fun x ↦ γ * ∑ i : Fin N,
        F x * (β⁻¹ * textbookLangevinPeriodicDirectionalDerivative (D i) (v i) x - x.2 i * D i x)) := by
    funext x
    unfold textbookLangevinPeriodicMomentumOUExpression
    rw [mul_left_comm, Finset.mul_sum]
  rw [heL, integral_const_mul, integral_finsetSum _ (fun i _ ↦ hiZ i)]
  simp_rw [hz]
  change γ * (∑ i : Fin N, -β⁻¹ * ∫ x, textbookLangevinPeriodicDirectionalDerivative F (v i) x * D i x ∂canonicalLaw) = _
  rw [← Finset.mul_sum, integral_finsetSum _ (fun i _ ↦ hiA i)]
  ring

/-- Momentum OU is genuinely symmetric for the actual canonical
probability on arbitrary compact smooth phase tests. -/
theorem textbookLangevinCanonicalMeasure_momentum_ou_symmetry {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β) (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection))
    (hsF : HasCompactSupport F) (hsG : HasCompactSupport G) :
    (∫ x, F x * textbookLangevinPeriodicMomentumOUExpression β γ G x ∂textbookLangevinCanonicalMeasure U β hβ) =
      ∫ x, G x * textbookLangevinPeriodicMomentumOUExpression β γ F x ∂textbookLangevinCanonicalMeasure U β hβ := by
  rw [textbookLangevinCanonicalMeasure_momentum_ou_dirichlet U hU hp β γ hβ F G hF hG hsF,
    textbookLangevinCanonicalMeasure_momentum_ou_dirichlet U hU hp β γ hβ G F hG hF hsG]
  congr 1
  apply integral_congr_ae
  filter_upwards [] with x
  apply Finset.sum_congr rfl
  intro i _
  exact mul_comm _ _

/-- The canonical-weight formal transpose identity for the original
Langevin differential expression, under its genuine canonical probability.
All terms are truly integrable; no closed adjoint or graph core is assumed. -/
theorem textbookLangevinCanonicalMeasure_weighted_formal_adjoint {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection))
    (hsF : HasCompactSupport F) (hsG : HasCompactSupport G) :
    (∫ x, F x * textbookLangevinPeriodicDifferentialOperator U γ σ G x ∂textbookLangevinCanonicalMeasure U β hβ) =
      ∫ x, textbookLangevinCanonicalWeightedFormalAdjointExpression U β γ F x * G x
        ∂textbookLangevinCanonicalMeasure U β hβ := by
  let canonicalLaw := textbookLangevinCanonicalMeasure U β hβ
  have hiH1 := adjoint_mul_integrable U hU hp β hβ F _ (adjoint_continuous F hF)
    (adjoint_H_continuous U hU hp G hG) hsF
  have hiO1 := adjoint_mul_integrable U hU hp β hβ F _ (adjoint_continuous F hF)
    (adjoint_O_continuous β γ G hG) hsF
  have hiH2 := adjoint_mul_integrable U hU hp β hβ G _ (adjoint_continuous G hG)
    (adjoint_H_continuous U hU hp F hF) hsG
  have hiO2 := adjoint_mul_integrable U hU hp β hβ G _ (adjoint_continuous G hG)
    (adjoint_O_continuous β γ F hF) hsG
  have heL : (fun x ↦ F x * textbookLangevinPeriodicDifferentialOperator U γ σ G x) =
      (fun x ↦ F x * textbookLangevinPeriodicHamiltonianTransportExpression U G x +
        F x * textbookLangevinPeriodicMomentumOUExpression β γ G x) := by
    funext x
    rw [textbookLangevinPeriodicDifferentialOperator_canonical_split U hU hp β γ σ hβ hσ G hG]
    change F x * (textbookLangevinPeriodicHamiltonianTransportExpression U G x +
      textbookLangevinPeriodicMomentumOUExpression β γ G x) = _
    ring
  have heR : (fun x ↦ textbookLangevinCanonicalWeightedFormalAdjointExpression U β γ F x * G x) =
      (fun x ↦ -(G x * textbookLangevinPeriodicHamiltonianTransportExpression U F x) +
        G x * textbookLangevinPeriodicMomentumOUExpression β γ F x) := by
    funext x
    unfold textbookLangevinCanonicalWeightedFormalAdjointExpression
    ring
  have hiNegH2 : Integrable (fun x ↦ -(G x * textbookLangevinPeriodicHamiltonianTransportExpression U F x))
      (textbookLangevinCanonicalMeasure U β hβ) := by
    simpa only [Pi.neg_apply] using! hiH2.neg
  rw [heL, heR, integral_add hiH1 hiO1, integral_add hiNegH2 hiO2, integral_neg,
    textbookLangevinCanonicalMeasure_hamiltonian_antisymmetry U hU hp β hβ F G hF hG hsF hsG,
    textbookLangevinCanonicalMeasure_momentum_ou_symmetry U hU hp β γ hβ F G hF hG hsF hsG]

/-- The same proved compact smooth tests of the actual closed C0 generator
satisfy the canonical-weight transpose identity. This only uses their
proved domain membership and action, not a Hilbert adjoint domain. -/
theorem textbookLangevinCanonicalMeasure_C0_generator_weighted_formal_adjoint
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hForce : LipschitzWith L (textbookPotentialForce U))
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection))
    (hsF : HasCompactSupport F) (hsG : HasCompactSupport G) :
    (∫ x, F x *
      (textbookLangevinPeriodicC0Generator B P hB U hU hp L hForce γ σ hγ
        ⟨textbookLangevinPeriodicCompactC2Observable G (hG.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)) hsG,
          textbookLangevinPeriodicCompactC2_mem_generator_domain B P hB U hU hp L hForce γ σ hγ G
            (hG.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)) hsG⟩) x
        ∂textbookLangevinCanonicalMeasure U β hβ) =
      ∫ x, textbookLangevinCanonicalWeightedFormalAdjointExpression U β γ F x * G x
        ∂textbookLangevinCanonicalMeasure U β hβ := by
  rw [textbookLangevinPeriodicC0Generator_compactC2_apply]
  exact textbookLangevinCanonicalMeasure_weighted_formal_adjoint U hU hp β γ σ hβ hσ F G hF hG hsF hsG

end
end MolecularDynamics
