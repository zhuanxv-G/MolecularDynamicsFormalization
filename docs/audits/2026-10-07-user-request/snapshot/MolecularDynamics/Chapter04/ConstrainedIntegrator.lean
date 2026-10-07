import MolecularDynamics.Chapter04.ConstrainedProjection

/-!
# Actual constrained Euler stages preserve the restricted two-form

Printed159--160/PDF181--182, equations (4.20)--(4.23) and the following proof.
The force kick coefficient a is explicit: a=-h gives the literal -hF when
F is the negative gradient, and a=h gives the Hamiltonian-consistent +hF.
The form proof holds for both; no numerical order or implicit solver
existence is inferred from this purely geometric identity.
-/

open Set Filter
open scoped BigOperators Topology

namespace MolecularDynamics

/-- The actual momentum kick and finite initial constraint correction. -/
noncomputable def textbookProjectedEulerPreMomentum {Nc : ℕ} {E ι : Type*}
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (lam : ι → E → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ) (q p : E → Fin Nc → ℝ) : E → Fin Nc → ℝ :=
  textbookMultiConstrainedMomentum s γ (fun j y => h * lam j y) q
    (fun y => p y + a • textbookPotentialForce U (q y))

/-- The actual position update with the diagonal inverse mass coefficients. -/
noncomputable def textbookProjectedEulerPosition {Nc : ℕ} {E : Type*}
    (m : Fin Nc → ℝ) (h : ℝ) (q P : E → Fin Nc → ℝ) (x : E) : Fin Nc → ℝ :=
  fun i => q x i + (h * (m i)⁻¹) * P x i

/-- The full actual pre-projection, position drift, and final momentum correction. -/
noncomputable def textbookProjectedEulerChart {Nc : ℕ} {E ι : Type*}
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (lam μ : ι → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ)
    (q p : E → Fin Nc → ℝ) : E → SymplecticCoordinates Nc :=
  let P := textbookProjectedEulerPreMomentum s γ lam U h a q p
  let Q := textbookProjectedEulerPosition m h q P
  textbookCotangentChart Q (textbookMultiConstrainedMomentum s γ μ Q P)

theorem differentiableAt_textbookProjectedEulerPreMomentum {Nc : ℕ} {E ι : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (lam : ι → E → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j ∈ s, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j ∈ s, DifferentiableAt ℝ (lam j) x) :
    DifferentiableAt ℝ (textbookProjectedEulerPreMomentum s γ lam U h a q p) x := by
  have hF := ((contDiff_textbookPotentialForce U hU).differentiable_one (q x)).comp x hq
  have hkick := hp.fun_add ((differentiableAt_const a).fun_smul hF)
  unfold textbookProjectedEulerPreMomentum
  exact differentiableAt_textbookMultiConstrainedMomentum s γ (fun j y => h * lam j y)
    q _ x hq hkick hγ (fun j hj => (differentiableAt_const h).fun_mul (hlam j hj))

theorem differentiableAt_textbookProjectedEulerPosition {Nc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (m : Fin Nc → ℝ) (h : ℝ) (q P : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hP : DifferentiableAt ℝ P x) :
    DifferentiableAt ℝ (textbookProjectedEulerPosition m h q P) x := by
  unfold textbookProjectedEulerPosition
  apply differentiableAt_pi.mpr
  intro i
  have hqi := ((hasFDerivAt_apply i (q x)).comp x hq.hasFDerivAt).differentiableAt
  have hPi := ((hasFDerivAt_apply i (P x)).comp x hP.hasFDerivAt).differentiableAt
  exact hqi.fun_add ((differentiableAt_const (h * (m i)⁻¹)).fun_mul hPi)

private theorem cotangentChart_differentiableAt {Nc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x) :
    DifferentiableAt ℝ (textbookCotangentChart q p) x := by
  unfold textbookCotangentChart
  apply differentiableAt_pi.mpr
  intro i
  rcases i with i | i
  · exact ((hasFDerivAt_apply i (q x)).comp x hq.hasFDerivAt).differentiableAt
  · exact ((hasFDerivAt_apply i (p x)).comp x hp.hasFDerivAt).differentiableAt

private theorem symplectic_map_preserves_parameter_pullback {Nc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (hΦ : IsTextbookSymplecticMap Φ)
    (Z : E → SymplecticCoordinates Nc) (x : E) (hZ : DifferentiableAt ℝ Z x) (u v : E) :
    textbookSymplecticForm Nc (fderiv ℝ (Φ ∘ Z) x u) (fderiv ℝ (Φ ∘ Z) x v) =
      textbookSymplecticForm Nc (fderiv ℝ Z x u) (fderiv ℝ Z x v) := by
  rw [fderiv_comp x (hΦ.1.differentiable_one (Z x)) hZ]
  exact ((isTextbookSymplecticMap_iff_preserves_form Φ).mp hΦ).2 (Z x) _ _

/-- The complete three-stage form proof uses actual differentiable multipliers
and true initial/final position constraints.  Solving for those multipliers
and imposing the final hidden constraint remain separate method construction. -/
theorem textbookProjectedEulerChart_preserves_pullback {Nc : ℕ} {E ι : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (lam μ : ι → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j ∈ s, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j ∈ s, DifferentiableAt ℝ (lam j) x)
    (hμ : ∀ j ∈ s, DifferentiableAt ℝ (μ j) x)
    (hold : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q (textbookProjectedEulerPreMomentum s γ lam U h a q p) y) = 0)
    (u v : E) :
    textbookSymplecticForm Nc (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x u)
      (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x v) =
      textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
        (fderiv ℝ (textbookCotangentChart q p) x v) := by
  let P₀ : E → Fin Nc → ℝ := fun y => p y + a • textbookPotentialForce U (q y)
  let P := textbookProjectedEulerPreMomentum s γ lam U h a q p
  let Q := textbookProjectedEulerPosition m h q P
  have hF := ((contDiff_textbookPotentialForce U hU).differentiable_one (q x)).comp x hq
  have hP₀ : DifferentiableAt ℝ P₀ x := hp.fun_add ((differentiableAt_const a).fun_smul hF)
  have hP := differentiableAt_textbookProjectedEulerPreMomentum s γ lam U h a q p x hq hp hU hγ hlam
  have hQ := differentiableAt_textbookProjectedEulerPosition m h q P x hq hP
  have hkickeq : textbookCotangentChart q P₀ =
      textbookMomentumKick (textbookPotentialForce U) a ∘ textbookCotangentChart q p := by
    funext y i
    rcases i with i | i <;> rfl
  have hdrifteq : textbookCotangentChart Q P =
      textbookPositionDrift m h ∘ textbookCotangentChart q P := by
    funext y i
    rcases i with i | i <;> rfl
  have hkick : textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q P₀) x u) (fderiv ℝ (textbookCotangentChart q P₀) x v) =
      textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
        (fderiv ℝ (textbookCotangentChart q p) x v) := by
    rw [hkickeq]
    exact symplectic_map_preserves_parameter_pullback _ (textbookPotentialKick_isSymplectic U a hU)
      _ x (cotangentChart_differentiableAt q p x hq hp) u v
  have hdrift : textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart Q P) x u) (fderiv ℝ (textbookCotangentChart Q P) x v) =
      textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q P) x u)
        (fderiv ℝ (textbookCotangentChart q P) x v) := by
    rw [hdrifteq]
    exact symplectic_map_preserves_parameter_pullback _ (textbookPositionDrift_isSymplectic m h)
      _ x (cotangentChart_differentiableAt q P x hq hP) u v
  change textbookSymplecticForm Nc
    (fderiv ℝ (textbookCotangentChart Q (textbookMultiConstrainedMomentum s γ μ Q P)) x u)
    (fderiv ℝ (textbookCotangentChart Q (textbookMultiConstrainedMomentum s γ μ Q P)) x v) = _
  calc
    _ = textbookSymplecticForm Nc
        (fderiv ℝ (textbookCotangentChart Q P) x u) (fderiv ℝ (textbookCotangentChart Q P) x v) :=
      textbookMultiConstrainedMomentum_preserves_pullback s γ μ Q x hQ hγ hμ hnew P hP u v
    _ = textbookSymplecticForm Nc
        (fderiv ℝ (textbookCotangentChart q P) x u) (fderiv ℝ (textbookCotangentChart q P) x v) := hdrift
    _ = textbookSymplecticForm Nc
        (fderiv ℝ (textbookCotangentChart q P₀) x u) (fderiv ℝ (textbookCotangentChart q P₀) x v) :=
      textbookMultiConstrainedMomentum_preserves_pullback s γ (fun j y => h * lam j y) q x hq hγ
        (fun j hj => (differentiableAt_const h).fun_mul (hlam j hj)) hold P₀ hP₀ u v
    _ = _ := hkick

end MolecularDynamics
