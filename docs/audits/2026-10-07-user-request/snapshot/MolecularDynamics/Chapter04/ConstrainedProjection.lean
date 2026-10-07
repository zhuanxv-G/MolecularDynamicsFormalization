import MolecularDynamics.Chapter02.SymplecticEuler
import Mathlib.Analysis.Calculus.FDeriv.Congr
import Mathlib.Tactic.Abel

/-!
# Lemma 4.1: constrained momentum projection

Printed159--160/PDF181--182.  The scalar constraint gradient is made
from the actual derivative.  The form identity is pulled back to genuine
parameter maps lying in the constrained cotangent set near the point.
Tangency follows from that actual constraint, and C² supplies Hessian symmetry.
-/

open Set Filter Matrix
open scoped BigOperators Topology

namespace MolecularDynamics

/-- The actual partial-derivative gradient of the scalar constraint. -/
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)

theorem contDiff_textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (hγ : ContDiff ℝ 2 γ) :
    ContDiff ℝ 1 (textbookConstraintGradient γ) := by
  have heq : textbookConstraintGradient γ = -textbookPotentialForce γ := by
    ext q i
    simp [textbookConstraintGradient, textbookPotentialForce]
  rw [heq]
  exact (contDiff_textbookPotentialForce γ hγ).neg

/-- The literal momentum correction P=p-μ∇γ(q), with a varying multiplier. -/
noncomputable def textbookConstrainedMomentum {Nc : ℕ} {E : Type*}
    (γ : (Fin Nc → ℝ) → ℝ) (μ : E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E) : Fin Nc → ℝ :=
  p x - μ x • textbookConstraintGradient γ (q x)

/-- The genuine coordinate map used to pull back the textbook two-form. -/
def textbookCotangentChart {Nc : ℕ} {E : Type*}
    (q p : E → Fin Nc → ℝ) (x : E) : SymplecticCoordinates Nc :=
  Sum.elim (q x) (p x)

private theorem covector_sum_single {Nc : ℕ}
    (L : (Fin Nc → ℝ) →L[ℝ] ℝ) (w : Fin Nc → ℝ) :
    ∑ i : Fin Nc, w i * L (Pi.single i 1) = L w := by
  have hw : ∑ i : Fin Nc, w i • Pi.single i 1 = w := by
    ext j
    simp [Finset.sum_apply, Pi.single_apply]
  calc
    _ = L (∑ i : Fin Nc, w i • Pi.single i 1) := by
      simp only [map_sum, map_smul, smul_eq_mul]
    _ = L w := congrArg L hw

private theorem constraintGradient_component_hasFDerivAt {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (hγ : ContDiff ℝ 2 γ) (q : Fin Nc → ℝ) (i : Fin Nc) :
    HasFDerivAt (fun y => textbookConstraintGradient γ y i)
      ((fderiv ℝ (fderiv ℝ γ) q).flip (Pi.single i 1)) q := by
  have h := ((hγ.fderiv_right (m := 1) (by norm_num)).differentiable_one q).hasFDerivAt
  simpa [textbookConstraintGradient] using h.clm_apply (hasFDerivAt_const (Pi.single i 1) q)

private theorem constrainedMomentum_hasFDerivAt {Nc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (γ : (Fin Nc → ℝ) → ℝ) (hγ : ContDiff ℝ 2 γ) (μ : E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hμ : DifferentiableAt ℝ μ x) :
    HasFDerivAt (textbookConstrainedMomentum γ μ q p)
      (ContinuousLinearMap.pi fun i => (ContinuousLinearMap.proj i).comp (fderiv ℝ p x) -
        (μ x • (((fderiv ℝ (fderiv ℝ γ) (q x)).flip (Pi.single i 1)).comp (fderiv ℝ q x)) +
          textbookConstraintGradient γ (q x) i • fderiv ℝ μ x)) x := by
  apply hasFDerivAt_pi.mpr
  intro i
  have hg := (constraintGradient_component_hasFDerivAt γ hγ (q x) i).comp x hq.hasFDerivAt
  have hpi := (hasFDerivAt_apply i (p x)).comp x hp.hasFDerivAt
  simpa only [textbookConstrainedMomentum, Pi.sub_apply, Pi.smul_apply,
    Function.comp_def, smul_eq_mul] using hpi.fun_sub (hμ.hasFDerivAt.fun_mul hg)

private theorem cotangentChart_hasFDerivAt {Nc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E] (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x) :
    HasFDerivAt (textbookCotangentChart q p)
      (ContinuousLinearMap.pi (Sum.elim
        (fun i => (ContinuousLinearMap.proj i).comp (fderiv ℝ q x))
        (fun i => (ContinuousLinearMap.proj i).comp (fderiv ℝ p x)))) x := by
  apply hasFDerivAt_pi.mpr
  intro i
  rcases i with i | i
  · exact (hasFDerivAt_apply i (q x)).comp x hq.hasFDerivAt
  · exact (hasFDerivAt_apply i (p x)).comp x hp.hasFDerivAt

/-- The full coordinate wedge identity, using actual derivatives of q,p,P.
The actual position constraint supplies tangency, not a zero-gradient premise. -/
theorem lemma_4_1_coordinates {Nc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (γ : (Fin Nc → ℝ) → ℝ) (hγ : ContDiff ℝ 2 γ) (μ : E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hμ : DifferentiableAt ℝ μ x)
    (hchart : ∀ᶠ y in 𝓝 x, γ (q y) = 0) (u v : E) :
    ∑ i : Fin Nc, ((fderiv ℝ q x u) i *
        (fderiv ℝ (textbookConstrainedMomentum γ μ q p) x v) i -
      (fderiv ℝ (textbookConstrainedMomentum γ μ q p) x u) i * (fderiv ℝ q x v) i) =
    ∑ i : Fin Nc, ((fderiv ℝ q x u) i * (fderiv ℝ p x v) i -
      (fderiv ℝ p x u) i * (fderiv ℝ q x v) i) := by
  have hflat : (fun y => γ (q y)) =ᶠ[𝓝 x] (fun _ => (0 : ℝ)) :=
    hchart
  have hcomp := (hγ.differentiable (by norm_num) (q x)).hasFDerivAt.comp x hq.hasFDerivAt
  have hzero := hcomp.unique ((hasFDerivAt_const (0 : ℝ) x).congr_of_eventuallyEq hflat)
  have ht (w : E) : (fderiv ℝ γ (q x)) (fderiv ℝ q x w) = 0 := by
    have hh := congrArg (fun L : E →L[ℝ] ℝ => L w) hzero
    simpa only [ContinuousLinearMap.comp_apply, _root_.zero_apply] using hh
  let U := fderiv ℝ q x u
  let V := fderiv ℝ q x v
  let D := fderiv ℝ (fderiv ℝ γ) (q x)
  let g := textbookConstraintGradient γ (q x)
  let p' := fderiv ℝ p x
  let μ' := fderiv ℝ μ x
  rw [(constrainedMomentum_hasFDerivAt γ hγ μ q p x hq hp hμ).fderiv]
  change ∑ i : Fin Nc, (U i * (p' v i - (μ x * D V (Pi.single i 1) + g i * μ' v)) -
    (p' u i - (μ x * D U (Pi.single i 1) + g i * μ' u)) * V i) =
    ∑ i : Fin Nc, (U i * p' v i - p' u i * V i)
  have hterm (i : Fin Nc) :
      U i * (p' v i - (μ x * D V (Pi.single i 1) + g i * μ' v)) -
        (p' u i - (μ x * D U (Pi.single i 1) + g i * μ' u)) * V i =
      (U i * p' v i - p' u i * V i) -
        μ x * (U i * D V (Pi.single i 1) - V i * D U (Pi.single i 1)) -
        μ' v * (U i * g i) + μ' u * (V i * g i) := by ring
  rw [Finset.sum_congr rfl (fun i _ => hterm i)]
  simp only [Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum]
  change (∑ i, U i * p' v i) - (∑ i, p' u i * V i) -
    μ x * ((∑ i, U i * D V (Pi.single i 1)) - (∑ i, V i * D U (Pi.single i 1))) -
    μ' v * (∑ i, U i * (fderiv ℝ γ (q x)) (Pi.single i 1)) +
    μ' u * (∑ i, V i * (fderiv ℝ γ (q x)) (Pi.single i 1)) = _
  rw [covector_sum_single (D V) U, covector_sum_single (D U) V,
    covector_sum_single (fderiv ℝ γ (q x)) U, covector_sum_single (fderiv ℝ γ (q x)) V,
    ht u, ht v]
  have hs : D V U = D U V := hγ.contDiffAt.isSymmSndFDerivAt (by norm_num) V U
  rw [hs]
  ring

private theorem constrained_position_pullback {Nc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (γ : (Fin Nc → ℝ) → ℝ) (hγ : ContDiff ℝ 2 γ) (μ : E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hμ : DifferentiableAt ℝ μ x)
    (hchart : ∀ᶠ y in 𝓝 x, γ (q y) = 0) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q (textbookConstrainedMomentum γ μ q p)) x u)
      (fderiv ℝ (textbookCotangentChart q (textbookConstrainedMomentum γ μ q p)) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  have hP := (constrainedMomentum_hasFDerivAt γ hγ μ q p x hq hp hμ).differentiableAt
  rw [textbookSymplecticForm_coordinates, textbookSymplecticForm_coordinates,
    (cotangentChart_hasFDerivAt q (textbookConstrainedMomentum γ μ q p) x hq hP).fderiv,
    (cotangentChart_hasFDerivAt q p x hq hp).fderiv]
  exact lemma_4_1_coordinates γ hγ μ q p x hq hp hμ hchart u v

/-- Lemma4.1 as equality of the actual pulled-back textbook symplectic form
on every pair of parameter directions. -/
theorem lemma_4_1 {Nc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (γ : (Fin Nc → ℝ) → ℝ) (hγ : ContDiff ℝ 2 γ) (μ : E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hμ : DifferentiableAt ℝ μ x)
    (hchart : ∀ᶠ y in 𝓝 x, γ (q y) = 0 ∧
      p y ⬝ᵥ textbookConstraintGradient γ (q y) = 0) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q (textbookConstrainedMomentum γ μ q p)) x u)
      (fderiv ℝ (textbookCotangentChart q (textbookConstrainedMomentum γ μ q p)) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  exact constrained_position_pullback γ hγ μ q p x hq hp hμ
    (hchart.mono fun _ hy => hy.1) u v

section FiniteConstraints

/-- The actual finite sum g′(q)ᵀμ in the following printed proof. -/
noncomputable def textbookMultiConstrainedMomentum {Nc : ℕ} {E ι : Type*}
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (μ : ι → E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E) : Fin Nc → ℝ :=
  p x - ∑ j ∈ s, μ j x • textbookConstraintGradient (γ j) (q x)

theorem differentiableAt_textbookMultiConstrainedMomentum {Nc : ℕ} {E ι : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (μ : ι → E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hγ : ∀ j ∈ s, ContDiff ℝ 2 (γ j))
    (hμ : ∀ j ∈ s, DifferentiableAt ℝ (μ j) x) :
    DifferentiableAt ℝ (textbookMultiConstrainedMomentum s γ μ q p) x := by
  unfold textbookMultiConstrainedMomentum
  simpa only [Function.comp_def] using hp.fun_sub
    (DifferentiableAt.fun_sum fun j hj => (hμ j hj).fun_smul
      (((contDiff_textbookConstraintGradient (γ j) (hγ j hj)).differentiable_one (q x)).comp x hq))

/-- The next printed paragraph's multiple-constraint projection preserves
its actual pullback, by applying the proved scalar identity finitely many times.
Only the position constraints are needed in this necessary algorithm dependency. -/
theorem textbookMultiConstrainedMomentum_preserves_pullback {Nc : ℕ} {E ι : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (μ : ι → E → ℝ)
    (q : E → Fin Nc → ℝ) (x : E) (hq : DifferentiableAt ℝ q x)
    (hγ : ∀ j ∈ s, ContDiff ℝ 2 (γ j))
    (hμ : ∀ j ∈ s, DifferentiableAt ℝ (μ j) x)
    (hconstraint : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (p : E → Fin Nc → ℝ) (hp : DifferentiableAt ℝ p x) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q (textbookMultiConstrainedMomentum s γ μ q p)) x u)
      (fderiv ℝ (textbookCotangentChart q (textbookMultiConstrainedMomentum s γ μ q p)) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  classical
  revert hγ hμ hconstraint p
  induction s using Finset.induction_on with
  | empty =>
    intro _ _ _ p _
    have heq : textbookMultiConstrainedMomentum ∅ γ μ q p = p := by
      funext y
      simp [textbookMultiConstrainedMomentum]
    rw [heq]
  | insert i s hnot ih =>
    intro hg hm hc p hp
    have hgs : ∀ j ∈ s, ContDiff ℝ 2 (γ j) := fun j hj => hg j (Finset.mem_insert_of_mem hj)
    have hms : ∀ j ∈ s, DifferentiableAt ℝ (μ j) x :=
      fun j hj => hm j (Finset.mem_insert_of_mem hj)
    have hcs : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j (q y) = 0 :=
      fun j hj => hc j (Finset.mem_insert_of_mem hj)
    have hPs := differentiableAt_textbookMultiConstrainedMomentum s γ μ q p x hq hp hgs hms
    have heq : textbookMultiConstrainedMomentum (insert i s) γ μ q p =
        textbookConstrainedMomentum (γ i) (μ i) q (textbookMultiConstrainedMomentum s γ μ q p) := by
      funext y
      simp only [textbookMultiConstrainedMomentum, textbookConstrainedMomentum, Finset.sum_insert hnot]
      abel
    rw [heq]
    calc
      _ = textbookSymplecticForm Nc
          (fderiv ℝ (textbookCotangentChart q (textbookMultiConstrainedMomentum s γ μ q p)) x u)
          (fderiv ℝ (textbookCotangentChart q (textbookMultiConstrainedMomentum s γ μ q p)) x v) :=
        constrained_position_pullback (γ i) (hg i (Finset.mem_insert_self i s)) (μ i) q
          (textbookMultiConstrainedMomentum s γ μ q p) x hq hPs
          (hm i (Finset.mem_insert_self i s)) (hc i (Finset.mem_insert_self i s)) u v
      _ = _ := ih hgs hms hcs p hp

end FiniteConstraints

end MolecularDynamics
