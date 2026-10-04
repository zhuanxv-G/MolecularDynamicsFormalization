import MolecularDynamics.Chapter04.ConstrainedGram

/-!
# Actual C¹ constraint reaction and reduced phase vector field

Necessary dependencies for printed153--155/PDF175--177.  Real C³ scalar
constraints make their genuine quadratic curvature C¹.  The actual Gram
inverse then gives C¹ of the constructed reaction and the actual constrained
vector field.  Positive mass and independent gradients discharge its real
nondegeneracy condition.  No reaction derivative is supplied as model data.
-/

open Matrix
open scoped BigOperators Topology Matrix.Norms.Elementwise

namespace MolecularDynamics

section ParameterRegularity

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

theorem contDiffAt_textbookConstraintCurvature {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 3 (γ j)) (hq : ContDiffAt ℝ 1 q x)
    (hp : ContDiffAt ℝ 1 p x) :
    ContDiffAt ℝ 1 (fun y => textbookConstraintCurvature m γ (q y) (p y)) x := by
  have hv : ContDiffAt ℝ 1 (fun y => textbookInverseMassMatrix m *ᵥ p y) x := by
    apply contDiffAt_pi.mpr
    intro i
    simp only [Matrix.mulVec, dotProduct]
    exact ContDiffAt.sum fun j _ => contDiffAt_const.mul (contDiffAt_pi.mp hp j)
  apply contDiffAt_pi.mpr
  intro j
  have hdd : ContDiff ℝ 1 (fderiv ℝ (fderiv ℝ (γ j))) :=
    ((hγ j).fderiv_right (m := 2) (by norm_num)).fderiv_right (m := 1) (by norm_num)
  have hc := hdd.contDiffAt.comp x hq
  simpa only [textbookConstraintCurvature, Function.comp_def] using (hc.clm_apply hv).clm_apply hv

theorem contDiffAt_textbookConstrainedReactionMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E) (hγ : ∀ j, ContDiff ℝ 3 (γ j))
    (hF : ContDiff ℝ 1 F) (hq : ContDiffAt ℝ 1 q x) (hp : ContDiffAt ℝ 1 p x)
    (hdet : (textbookConstraintGram m γ (q x)).det ≠ 0) :
    ContDiffAt ℝ 1 (fun y => textbookConstrainedReactionMultiplier m γ F (q y) (p y)) x := by
  have hγ2 (j : Fin Mc) : ContDiff ℝ 2 (γ j) := (hγ j).of_le (by norm_num)
  have hG := contDiffAt_textbookConstraintJacobian γ q x hγ2 hq
  have hI := contDiffAt_textbookConstraintGram_inverse m γ q x hγ2 hq hdet
  have hC := contDiffAt_textbookConstraintCurvature m γ q p x hγ hq hp
  have hFq : ContDiffAt ℝ 1 (fun y => F (q y)) x := by
    simpa only [Function.comp_def] using hF.contDiffAt.comp x hq
  have hR : ContDiffAt ℝ 1 (fun y =>
      textbookConstraintJacobian γ (q y) *ᵥ (textbookInverseMassMatrix m *ᵥ F (q y)) +
        textbookConstraintCurvature m γ (q y) (p y)) x := by
    apply contDiffAt_pi.mpr
    intro j
    simp only [Pi.add_apply, Matrix.mulVec, dotProduct]
    exact (ContDiffAt.sum fun k _ => (contDiffAt_pi.mp (contDiffAt_pi.mp hG j) k).mul
      (ContDiffAt.sum fun l _ => contDiffAt_const.mul (contDiffAt_pi.mp hFq l))).add
        (contDiffAt_pi.mp hC j)
  apply contDiffAt_pi.mpr
  intro j
  unfold textbookConstrainedReactionMultiplier
  simp only [Matrix.mulVec, dotProduct]
  exact ContDiffAt.sum fun k _ =>
    (contDiffAt_pi.mp (contDiffAt_pi.mp hI j) k).mul (contDiffAt_pi.mp hR k)

theorem contDiffAt_textbookConstrainedReactionMultiplier_of_mass_and_independence
    {Nc Mc : ℕ} (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ)
    (F : (Fin Nc → ℝ) → Fin Nc → ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hm : ∀ i, 0 < m i) (hγ : ∀ j, ContDiff ℝ 3 (γ j)) (hF : ContDiff ℝ 1 F)
    (hq : ContDiffAt ℝ 1 q x) (hp : ContDiffAt ℝ 1 p x)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) (q x))) :
    ContDiffAt ℝ 1 (fun y => textbookConstrainedReactionMultiplier m γ F (q y) (p y)) x :=
  contDiffAt_textbookConstrainedReactionMultiplier m γ F q p x hγ hF hq hp
    (textbookConstraintGram_det_ne_zero m γ (q x) hm hind)

end ParameterRegularity

/-- The actual reduced (q,p) ODE, with the real negative potential gradient
and the constructed Gram reaction. -/
noncomputable def textbookConstrainedPhaseVectorField {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (z : (Fin Nc → ℝ) × (Fin Nc → ℝ)) : (Fin Nc → ℝ) × (Fin Nc → ℝ) :=
  (textbookInverseMassMatrix m *ᵥ z.2,
    textbookPotentialForce U z.1 - (textbookConstraintJacobian γ z.1)ᵀ *ᵥ
      textbookConstrainedReactionMultiplier m γ (textbookPotentialForce U) z.1 z.2)

theorem contDiffAt_textbookConstrainedPhaseVectorField {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (z : (Fin Nc → ℝ) × (Fin Nc → ℝ)) (hU : ContDiff ℝ 2 U)
    (hγ : ∀ j, ContDiff ℝ 3 (γ j)) (hdet : (textbookConstraintGram m γ z.1).det ≠ 0) :
    ContDiffAt ℝ 1 (textbookConstrainedPhaseVectorField m γ U) z := by
  have hq : ContDiffAt ℝ 1 (fun w : (Fin Nc → ℝ) × (Fin Nc → ℝ) => w.1) z := contDiffAt_fst
  have hp : ContDiffAt ℝ 1 (fun w : (Fin Nc → ℝ) × (Fin Nc → ℝ) => w.2) z := contDiffAt_snd
  have hγ2 (j : Fin Mc) : ContDiff ℝ 2 (γ j) := (hγ j).of_le (by norm_num)
  have hG := contDiffAt_textbookConstraintJacobian γ _ z hγ2 hq
  have hρ := contDiffAt_textbookConstrainedReactionMultiplier m γ (textbookPotentialForce U)
    _ _ z hγ (contDiff_textbookPotentialForce U hU) hq hp hdet
  have hF : ContDiffAt ℝ 1 (fun w : (Fin Nc → ℝ) × (Fin Nc → ℝ) =>
      textbookPotentialForce U w.1) z := by
    simpa only [Function.comp_def] using (contDiff_textbookPotentialForce U hU).contDiffAt.comp z hq
  have hv : ContDiffAt ℝ 1 (fun w : (Fin Nc → ℝ) × (Fin Nc → ℝ) =>
      textbookInverseMassMatrix m *ᵥ w.2) z := by
    apply contDiffAt_pi.mpr
    intro i
    simp only [Matrix.mulVec, dotProduct]
    exact ContDiffAt.sum fun j _ => contDiffAt_const.mul (contDiffAt_pi.mp hp j)
  have hr : ContDiffAt ℝ 1 (fun w : (Fin Nc → ℝ) × (Fin Nc → ℝ) =>
      (textbookConstraintJacobian γ w.1)ᵀ *ᵥ
        textbookConstrainedReactionMultiplier m γ (textbookPotentialForce U) w.1 w.2) z := by
    apply contDiffAt_pi.mpr
    intro i
    simp only [Matrix.mulVec, dotProduct, Matrix.transpose_apply]
    exact ContDiffAt.sum fun j _ =>
      (contDiffAt_pi.mp (contDiffAt_pi.mp hG j) i).mul (contDiffAt_pi.mp hρ j)
  exact hv.prodMk (hF.sub hr)

theorem contDiffAt_textbookConstrainedPhaseVectorField_of_mass_and_independence
    {Nc Mc : ℕ} (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (z : (Fin Nc → ℝ) × (Fin Nc → ℝ))
    (hm : ∀ i, 0 < m i) (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 3 (γ j))
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) z.1)) :
    ContDiffAt ℝ 1 (textbookConstrainedPhaseVectorField m γ U) z :=
  contDiffAt_textbookConstrainedPhaseVectorField m γ U z hU hγ
    (textbookConstraintGram_det_ne_zero m γ z.1 hm hind)

end MolecularDynamics
