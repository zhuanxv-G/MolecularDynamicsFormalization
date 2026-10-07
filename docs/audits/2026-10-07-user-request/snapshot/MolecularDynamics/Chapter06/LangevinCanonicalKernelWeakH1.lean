import MolecularDynamics.Chapter06.LangevinCanonicalKernelTransport
import Mathlib.Analysis.Calculus.VectorField

/-! Necessary original weighted commutator stage for actual closed kernel H1.
This candidate batch is incomplete until the q-testing and actual H1 construction
are appended and verified; no kernel constancy or Poisson statement is asserted. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ENNReal BigOperators InnerProductSpace LinearPMap
namespace MolecularDynamics
noncomputable section

private theorem kernelH1_H_eq {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) :
    textbookLangevinPeriodicHamiltonianTransportExpression U G =
      textbookLangevinPeriodicDifferentialOperator U 0 0 G := by
  funext x
  rw [textbookLangevinPeriodicDifferentialOperator_canonical_split U hU hp 1 0 0
    (by norm_num) (by simp) G hG]
  simp [textbookLangevinPeriodicHamiltonianTransportExpression]

/-- The original Hamiltonian expression is the actual real Frechet derivative
along the genuine Hamiltonian drift at every real phase lift. -/
theorem textbookLangevinPeriodicHamiltonianTransportExpression_lift {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (z : textbookLangevinPhase N) :
    textbookLangevinPeriodicHamiltonianTransportExpression U G (textbookLangevinPeriodicProjection z) =
      fderiv ℝ (G ∘ textbookLangevinPeriodicProjection) z (textbookLangevinDrift U 0 z) := by
  have h2 : ContDiff ℝ 2 (G ∘ textbookLangevinPeriodicProjection) :=
    hG.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)
  rw [kernelH1_H_eq U hU hp G hG,
    textbookLangevinPeriodicDifferentialOperator_C2_lift U hU hp 0 0 G h2 z,
    textbookLangevinDifferentialOperator_C2_frechet U 0 0 _ h2 z]
  simp

private theorem kernelH1_drift_smooth {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) :
    ContDiff ℝ ∞ (textbookLangevinDrift U 0) := by
  apply textbookLangevinSeed_contDiff U hU 0 0
  change textbookLangevinDrift U 0 = textbookLangevinDrift U 0 ∨
    ∃ i, textbookLangevinNoise N 0 i = textbookLangevinDrift U 0
  exact Or.inl rfl

/-- Genuine smoothness of the original Hamiltonian test lift follows from the
actual Frechet derivative and the actual smooth periodic force. -/
theorem textbookLangevinPeriodicHamiltonianTransportExpression_lift_contDiff {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) :
    ContDiff ℝ ∞ (textbookLangevinPeriodicHamiltonianTransportExpression U G ∘ textbookLangevinPeriodicProjection) := by
  have he : textbookLangevinPeriodicHamiltonianTransportExpression U G ∘ textbookLangevinPeriodicProjection =
      fun z ↦ fderiv ℝ (G ∘ textbookLangevinPeriodicProjection) z (textbookLangevinDrift U 0 z) :=
    funext (textbookLangevinPeriodicHamiltonianTransportExpression_lift U hU hp G hG)
  rw [he]
  exact (hG.fderiv_right (by simp)).clm_apply (kernelH1_drift_smooth U hU)

private theorem kernelH1_p_smooth {N : ℕ} (i : Fin N) :
    ContDiff ℝ ∞ ((fun x : textbookLangevinPeriodicPhase N ↦ x.2 i) ∘ textbookLangevinPeriodicProjection) := by
  change ContDiff ℝ ∞ (fun z : textbookLangevinPhase N ↦ z.2 i)
  fun_prop

/-- The actual canonical momentum transpose of a smooth phase test has a genuine
smooth real lift, so it can itself be used as a Hamiltonian test. -/
theorem textbookLangevinCanonicalMomentumAdjointTest_lift_contDiff {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (i : Fin N)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) :
    ContDiff ℝ ∞ (textbookLangevinCanonicalCoordinateAdjointTestExpression U β (Sum.inr i) G ∘
      textbookLangevinPeriodicProjection) := by
  change ContDiff ℝ ∞ (fun z ↦
    -textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1) (textbookLangevinPeriodicProjection z) +
      β * (textbookLangevinPeriodicProjection z).2 i * G (textbookLangevinPeriodicProjection z))
  exact (textbookLangevinPeriodicDirectionalDerivative_lift_contDiff G hG (0, Pi.single i 1)).neg.add
    (((kernelH1_p_smooth i).const_smul β).mul hG)

private theorem kernelH1_H_compact {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport G) :
    HasCompactSupport (textbookLangevinPeriodicHamiltonianTransportExpression U G) := by
  rw [kernelH1_H_eq U hU hp G hG]
  exact textbookLangevinPeriodicDifferentialOperator_compactC2_hasCompactSupport U 0 0 G
    (hG.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)) hs

private theorem kernelH1_Ap_compact {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (i : Fin N)
    (G : textbookLangevinPeriodicPhase N → ℝ) (hs : HasCompactSupport G) :
    HasCompactSupport (textbookLangevinCanonicalCoordinateAdjointTestExpression U β (Sum.inr i) G) :=
  (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport G hs (0, Pi.single i 1)).neg.add hs.mul_left

private theorem kernelH1_unweighted_commutator {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (i : Fin N) (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDirectionalDerivative (textbookLangevinPeriodicHamiltonianTransportExpression U G)
      (0, Pi.single i 1) x -
      textbookLangevinPeriodicHamiltonianTransportExpression U
        (textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1)) x =
      textbookLangevinPeriodicDirectionalDerivative G (Pi.single i 1, 0) x := by
  obtain ⟨z, rfl⟩ := textbookLangevinPeriodicProjection_surjective N x
  let P := textbookLangevinNoise N 1 i
  let V := textbookLangevinDrift U 0
  have hV : ContDiff ℝ ∞ V := kernelH1_drift_smooth U hU
  have hP : DifferentiableAt ℝ P z := differentiableAt_const _
  have hb : VectorField.lieBracket ℝ P V z = (Pi.single i 1, 0) := by
    rw [VectorField.lieBracket_swap]
    dsimp only [V, P]
    rw [textbookLangevinDrift_noise_bracket U
      (hU.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)) 0 1 i z]
    simp
  have he := VectorField.fderiv_apply_lieBracket (𝕜 := ℝ) (V := P) (W := V)
    hG.contDiffAt (by simp) (hV.differentiable (by simp) z) hP
  have hH : (fun y ↦ fderiv ℝ (G ∘ textbookLangevinPeriodicProjection) y (V y)) =
      textbookLangevinPeriodicHamiltonianTransportExpression U G ∘ textbookLangevinPeriodicProjection :=
    funext (fun y ↦ (textbookLangevinPeriodicHamiltonianTransportExpression_lift U hU hp G hG y).symm)
  have hD : (fun y ↦ fderiv ℝ (G ∘ textbookLangevinPeriodicProjection) y (P y)) =
      textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1) ∘ textbookLangevinPeriodicProjection := by
    funext y
    simpa only [P, textbookLangevinNoise, one_smul, Function.comp_apply] using
      (textbookLangevinPeriodicDirectionalDerivative_lift G (0, Pi.single i 1) y).symm
  rw [hb, hH, hD] at he
  rw [textbookLangevinPeriodicDirectionalDerivative_lift,
    textbookLangevinPeriodicHamiltonianTransportExpression_lift U hU hp _
      (textbookLangevinPeriodicDirectionalDerivative_lift_contDiff G hG _),
    textbookLangevinPeriodicDirectionalDerivative_lift]
  simpa only [P, V, textbookLangevinNoise, one_smul] using he.symm


private theorem kernelH1_H_add {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicHamiltonianTransportExpression U (F + G) x =
      textbookLangevinPeriodicHamiltonianTransportExpression U F x +
        textbookLangevinPeriodicHamiltonianTransportExpression U G x := by
  have hFG : ContDiff ℝ ∞ ((F + G) ∘ textbookLangevinPeriodicProjection) := hF.add hG
  rw [kernelH1_H_eq U hU hp _ hFG, kernelH1_H_eq U hU hp F hF, kernelH1_H_eq U hU hp G hG]
  exact textbookLangevinPeriodicDifferentialOperator_smooth_add U 0 0 F G hF hG x

private theorem kernelH1_H_smul {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (c : ℝ) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicHamiltonianTransportExpression U (c • F) x =
      c * textbookLangevinPeriodicHamiltonianTransportExpression U F x := by
  have hcF : ContDiff ℝ ∞ ((c • F) ∘ textbookLangevinPeriodicProjection) := hF.const_smul c
  rw [kernelH1_H_eq U hU hp _ hcF, kernelH1_H_eq U hU hp F hF]
  exact textbookLangevinPeriodicDifferentialOperator_smooth_smul U 0 0 c F hF x

private theorem kernelH1_H_product {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicHamiltonianTransportExpression U (fun y ↦ F y * G y) x =
      F x * textbookLangevinPeriodicHamiltonianTransportExpression U G x +
        G x * textbookLangevinPeriodicHamiltonianTransportExpression U F x := by
  have hFG : ContDiff ℝ ∞ ((fun y ↦ F y * G y) ∘ textbookLangevinPeriodicProjection) := hF.mul hG
  rw [kernelH1_H_eq U hU hp _ hFG, kernelH1_H_eq U hU hp G hG, kernelH1_H_eq U hU hp F hF]
  simpa using textbookLangevinPeriodicDifferentialOperator_product U hU hp 1 0 0
    (by norm_num) (by simp) F G hF hG x

private theorem kernelH1_H_p {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (i : Fin N) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicHamiltonianTransportExpression U (fun y ↦ y.2 i) x =
      -textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 := by
  obtain ⟨z, rfl⟩ := textbookLangevinPeriodicProjection_surjective N x
  rw [textbookLangevinPeriodicHamiltonianTransportExpression_lift U hU hp _ (kernelH1_p_smooth i) z]
  have he := (hasFDerivAt_apply (𝕜 := ℝ) i z.2).comp z (hasFDerivAt_snd (𝕜 := ℝ) (p := z))
  change HasFDerivAt (fun y : textbookLangevinPhase N ↦ y.2 i)
    ((ContinuousLinearMap.proj i).comp (ContinuousLinearMap.snd ℝ (Fin N → ℝ) (Fin N → ℝ))) z at he
  change fderiv ℝ (fun y : textbookLangevinPhase N ↦ y.2 i) z (textbookLangevinDrift U 0 z) = _
  rw [he.fderiv]
  simp only [ContinuousLinearMap.comp_apply, ContinuousLinearMap.proj_apply,
    textbookLangevinDrift, zero_smul, sub_zero]
  change textbookPotentialForce U z.1 i =
    -textbookConfigurationTorusObservable (textbookConfigurationPartial U i) (textbookConfigurationTorusProjection z.1)
  rw [textbookConfigurationTorusObservable_lift _ (textbookConfigurationPartial_periodic U hU hp i)]
  rfl

/-- The genuine original weighted commutator converts momentum transpose and
Hamiltonian testing into position transpose testing, without a Sobolev core assumption. -/
theorem textbookLangevinCanonicalCoordinateAdjointTestExpression_hamiltonian_commutator {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (i : Fin N) (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinCanonicalCoordinateAdjointTestExpression U β (Sum.inl i) G x =
      textbookLangevinCanonicalCoordinateAdjointTestExpression U β (Sum.inr i)
        (textbookLangevinPeriodicHamiltonianTransportExpression U G) x -
      textbookLangevinPeriodicHamiltonianTransportExpression U
        (textbookLangevinCanonicalCoordinateAdjointTestExpression U β (Sum.inr i) G) x := by
  let D := textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1)
  let P : textbookLangevinPeriodicPhase N → ℝ := fun y ↦ y.2 i
  have hD : ContDiff ℝ ∞ (D ∘ textbookLangevinPeriodicProjection) :=
    textbookLangevinPeriodicDirectionalDerivative_lift_contDiff G hG _
  have hP : ContDiff ℝ ∞ (P ∘ textbookLangevinPeriodicProjection) := kernelH1_p_smooth i
  have hPG : ContDiff ℝ ∞ ((fun y ↦ P y * G y) ∘ textbookLangevinPeriodicProjection) := hP.mul hG
  have hA : textbookLangevinCanonicalCoordinateAdjointTestExpression U β (Sum.inr i) G =
      (-1 : ℝ) • D + β • (fun y ↦ P y * G y) := by
    funext y
    simp only [textbookLangevinCanonicalCoordinateAdjointTestExpression,
      textbookLangevinCanonicalCoordinateDirection, textbookLangevinCanonicalCoordinateLogSlope,
      Pi.add_apply, Pi.smul_apply, smul_eq_mul, D, P]
    ring
  have hHA : textbookLangevinPeriodicHamiltonianTransportExpression U
      (textbookLangevinCanonicalCoordinateAdjointTestExpression U β (Sum.inr i) G) x =
      -textbookLangevinPeriodicHamiltonianTransportExpression U D x +
        β * (P x * textbookLangevinPeriodicHamiltonianTransportExpression U G x -
          G x * textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1) := by
    rw [hA, kernelH1_H_add U hU hp ((-1 : ℝ) • D) (β • (fun y ↦ P y * G y))
      (hD.const_smul (-1 : ℝ)) (hPG.const_smul β),
      kernelH1_H_smul U hU hp (-1) D hD, kernelH1_H_smul U hU hp β _ hPG,
      kernelH1_H_product U hU hp P G hP hG]
    change -1 * textbookLangevinPeriodicHamiltonianTransportExpression U D x +
      β * (P x * textbookLangevinPeriodicHamiltonianTransportExpression U G x +
        G x * textbookLangevinPeriodicHamiltonianTransportExpression U (fun y ↦ y.2 i) x) = _
    rw [kernelH1_H_p U hU hp i x]
    ring
  have hc := kernelH1_unweighted_commutator U hU hp i G hG x
  rw [hHA]
  simp only [textbookLangevinCanonicalCoordinateAdjointTestExpression,
    textbookLangevinCanonicalCoordinateDirection, textbookLangevinCanonicalCoordinateLogSlope]
  rw [sub_eq_iff_eq_add.mp hc]
  dsimp only [D, P]
  ring

/-- Every actual closed Langevin kernel element annihilates true position
transpose tests, derived from the original commutator on genuine compact smooth tests. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_position_testing {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0)
    (i : Fin N) (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinCanonicalCoordinateAdjointTestExpression U β (Sum.inl i) G x
      ∂textbookLangevinCanonicalMeasure U β hβ) = 0 := by
  let H := textbookLangevinPeriodicHamiltonianTransportExpression U G
  let A := textbookLangevinCanonicalCoordinateAdjointTestExpression U β (Sum.inr i) G
  have hH := textbookLangevinPeriodicHamiltonianTransportExpression_lift_contDiff U hU hp G hG
  have hsH := kernelH1_H_compact U hU hp G hG hsG
  have hA := textbookLangevinCanonicalMomentumAdjointTest_lift_contDiff U β i G hG
  have hsA := kernelH1_Ap_compact U β i G hsG
  have hI1 : Integrable (fun x ↦ (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinCanonicalCoordinateAdjointTestExpression U β (Sum.inr i) H x)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    (Lp.memLp (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))).integrable_mul
      (textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two U hU hp β hβ (Sum.inr i) H hH hsH)
  have hI2 : Integrable (fun x ↦ (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinPeriodicHamiltonianTransportExpression U A x)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    (Lp.memLp (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))).integrable_mul
      (textbookLangevinCanonicalMeasure_hamiltonianTest_memLp_two U hU hp β hβ A hA hsA)
  calc
    _ = ∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
          textbookLangevinCanonicalCoordinateAdjointTestExpression U β (Sum.inr i) H x -
        (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
          textbookLangevinPeriodicHamiltonianTransportExpression U A x
        ∂textbookLangevinCanonicalMeasure U β hβ := by
      apply integral_congr_ae
      filter_upwards [] with x
      rw [textbookLangevinCanonicalCoordinateAdjointTestExpression_hamiltonian_commutator U hU hp β i G hG x]
      exact mul_sub _ _ _
    _ = 0 := by
      rw [integral_sub hI1 hI2,
        textbookLangevinCanonicalHilbertClosedOperator_kernel_momentum_testing U hU hp β γ σ hβ hγ hσ f hf i H hH hsH,
        textbookLangevinCanonicalHilbertClosedOperator_kernel_hamiltonian_testing U hU hp β γ σ hβ hγ hσ f hf A hA hsA,
        sub_self]

private theorem kernelH1_inner_integral {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : MemLp G 2 (textbookLangevinCanonicalMeasure U β hβ)) :
    ⟪f, hG.toLp G⟫_ℝ = ∫ x, f x * G x ∂textbookLangevinCanonicalMeasure U β hβ := by
  rw [L2.inner_def]
  apply integral_congr_ae
  filter_upwards [hG.coeFn_toLp] with x hx
  rw [hx, Real.inner_apply]

/-- An actual closed Langevin kernel element has a genuine original weighted H1
jet with every actual weak coordinate derivative zero. Membership is proved from
true transpose testing; it is not an assumption about the operator domain. -/
def textbookLangevinCanonicalHilbertClosedOperatorKernelWeakH1 {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0) :
    textbookLangevinCanonicalWeakH1 U hU hp β hβ :=
  ⟨WithLp.toLp 2 (fun j : Option (Fin N ⊕ Fin N) ↦ match j with
    | none => (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
    | some _ => 0), by
      intro j G hG hsG
      change ⟪(0 : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)), _⟫_ℝ =
        ⟪(f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)),
          (textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two U hU hp β hβ j G hG hsG).toLp _⟫_ℝ
      rw [inner_zero_left, kernelH1_inner_integral]
      cases j with
      | inl i =>
        exact (textbookLangevinCanonicalHilbertClosedOperator_kernel_position_testing U hU hp β γ σ hβ hγ hσ f hf i G hG hsG).symm
      | inr i =>
        exact (textbookLangevinCanonicalHilbertClosedOperator_kernel_momentum_testing U hU hp β γ σ hβ hγ hσ f hf i G hG hsG).symm⟩

/-- The constructed genuine H1 value is exactly the original actual closed kernel class. -/
theorem textbookLangevinCanonicalHilbertClosedOperatorKernelWeakH1_value {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0) :
    textbookLangevinCanonicalWeakH1Value U hU hp β hβ
      (textbookLangevinCanonicalHilbertClosedOperatorKernelWeakH1 U hU hp β γ σ hβ hγ hσ f hf) =
      (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) := rfl

/-- All genuine weak position and momentum derivative classes of the constructed
actual kernel H1 element vanish, including the zero-dimensional case. -/
theorem textbookLangevinCanonicalHilbertClosedOperatorKernelWeakH1_derivative {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0)
    (j : Fin N ⊕ Fin N) :
    textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ j
      (textbookLangevinCanonicalHilbertClosedOperatorKernelWeakH1 U hU hp β γ σ hβ hγ hσ f hf) = 0 := rfl

end
end MolecularDynamics
