import MolecularDynamics.Chapter02.SplittingError
import MolecularDynamics.Chapter02.HamiltonianVariational
import Mathlib.Analysis.Calculus.FDeriv.CompCLM
import Mathlib.Analysis.Normed.Module.FiniteDimension

/-!
# Actual Lie derivatives and the canonical Poisson bracket

Printed100--102/PDF122--124, §3.2.  All derivatives below are actual Fréchet
or time derivatives.  The canonical bracket uses the actual textbook J.
Jacobi is derived from the actual C² Hessian symmetry.
The formal operator exponential is not treated as a convergent series.
-/

open Set Matrix
open scoped BigOperators Matrix Topology

namespace MolecularDynamics

section Lie

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- The actual directional derivative of a scalar observable along the field. -/
noncomputable def textbookLieDerivative (f : E → E) (φ : E → ℝ) (z : E) : ℝ :=
  (fderiv ℝ φ z) (f z)

/-- The genuine chain rule along the specified solution, including endpoints. -/
theorem hasDerivWithinAt_textbookLieDerivative (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (s : Set ℝ) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivWithinAt γ (f (γ t)) s t) :
    HasDerivWithinAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) s t :=
  hφ.hasFDerivAt.comp_hasDerivWithinAt t hγ

theorem hasDerivAt_textbookLieDerivative (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) t :=
  hφ.hasFDerivAt.comp_hasDerivAt t hγ

/-- Regularity needed for the literal second time derivative. -/
theorem contDiff_textbookLieDerivative (f : E → E) (φ : E → ℝ)
    (hf : ContDiff ℝ 1 f) (hφ : ContDiff ℝ 2 φ) :
    ContDiff ℝ 1 (textbookLieDerivative f φ) :=
  (hφ.fderiv_right (m := 1) (by norm_num)).clm_apply hf

/-- The second time derivative is the second actual Lie derivative. -/
theorem hasDerivAt_textbookLieDerivative_second (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (hf : ContDiff ℝ 1 f) (hφ : ContDiff ℝ 2 φ)
    (hγ : ∀ t, HasDerivAt γ (f (γ t)) t) (t : ℝ) :
    HasDerivAt (fun u => deriv (fun v => φ (γ v)) u)
      (textbookLieDerivative f (textbookLieDerivative f φ) (γ t)) t := by
  have heq : (fun u => deriv (fun v => φ (γ v)) u) =
      (fun u => textbookLieDerivative f φ (γ u)) := by
    funext u
    exact (hasDerivAt_textbookLieDerivative f φ γ u
      (hφ.differentiable (by norm_num) (γ u)) (hγ u)).deriv
  rw [heq]
  exact hasDerivAt_textbookLieDerivative f (textbookLieDerivative f φ) γ t
    ((contDiff_textbookLieDerivative f φ hf hφ).differentiable (by norm_num) (γ t))
    (hγ t)

theorem textbookLieDerivative_field_add (f g : E → E) (φ : E → ℝ) (z : E) :
    textbookLieDerivative (fun x => f x + g x) φ z =
      textbookLieDerivative f φ z + textbookLieDerivative g φ z := by
  exact map_add (fderiv ℝ φ z) (f z) (g z)

end Lie

section Poisson

variable {Nc : ℕ}

/-- Taking all actual coordinate values of a continuous covector is linear. -/
private noncomputable def dualCoordinates (Nc : ℕ) :
    (SymplecticCoordinates Nc →L[ℝ] ℝ) →L[ℝ] SymplecticCoordinates Nc :=
  ContinuousLinearMap.pi (fun i => ContinuousLinearMap.apply ℝ ℝ (Pi.single i 1))

private theorem dualCoordinates_apply (L : SymplecticCoordinates Nc →L[ℝ] ℝ)
    (i : Fin Nc ⊕ Fin Nc) : dualCoordinates Nc L i = L (Pi.single i 1) := rfl

private noncomputable def dualHamiltonianMap (Nc : ℕ) :
    (SymplecticCoordinates Nc →L[ℝ] ℝ) →L[ℝ] SymplecticCoordinates Nc :=
  ((textbookJ Nc).toLin').toContinuousLinearMap.comp (dualCoordinates Nc)

private theorem hamiltonianVectorField_eq_dual
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    textbookHamiltonianVectorField H z = dualHamiltonianMap Nc (fderiv ℝ H z) := rfl

/-- Every genuine continuous covector is its actual coordinate expansion. -/
private theorem covector_apply_coordinates (L : SymplecticCoordinates Nc →L[ℝ] ℝ)
    (v : SymplecticCoordinates Nc) : L v = dualCoordinates Nc L ⬝ᵥ v := by
  have hv : v = ∑ i, v i • Pi.single i (1 : ℝ) := by
    ext j
    simp [Finset.sum_apply, Pi.smul_apply, Pi.single_apply]
  calc
    L v = L (∑ i, v i • Pi.single i (1 : ℝ)) := congrArg L hv
    _ = ∑ i, v i * L (Pi.single i 1) := by simp [map_sum, smul_eq_mul]
    _ = dualCoordinates Nc L ⬝ᵥ v := by
      unfold dotProduct
      apply Finset.sum_congr rfl
      intro i _
      rw [dualCoordinates_apply]
      ring

private theorem covector_hamiltonian_eq_form
    (L M : SymplecticCoordinates Nc →L[ℝ] ℝ) :
    L (dualHamiltonianMap Nc M) =
      textbookSymplecticForm Nc (dualCoordinates Nc L) (dualCoordinates Nc M) := by
  rw [covector_apply_coordinates]
  simp only [textbookSymplecticForm, Matrix.toBilin'_apply']
  rfl

private theorem covector_hamiltonian_skew
    (L M : SymplecticCoordinates Nc →L[ℝ] ℝ) :
    L (dualHamiltonianMap Nc M) = -M (dualHamiltonianMap Nc L) := by
  rw [covector_hamiltonian_eq_form, covector_hamiltonian_eq_form]
  exact textbookSymplecticForm_skew Nc (dualCoordinates Nc M) (dualCoordinates Nc L)

/-- The actual canonical bracket: DF applied to the actual J-gradient of G. -/
noncomputable def textbookPoissonBracket (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : ℝ :=
  (fderiv ℝ F z) (textbookHamiltonianVectorField G z)

/-- The literal sum of position/momentum coordinate partial derivatives. -/
theorem textbookPoissonBracket_coordinates (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = ∑ i : Fin Nc,
      ((fderiv ℝ F z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ G z) (Pi.single (Sum.inr i) 1) -
      (fderiv ℝ G z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ F z) (Pi.single (Sum.inr i) 1)) := by
  unfold textbookPoissonBracket
  rw [hamiltonianVectorField_eq_dual, covector_hamiltonian_eq_form,
    textbookSymplecticForm_coordinates]
  simp only [dualCoordinates_apply]
  apply Finset.sum_congr rfl
  intro i _
  ring

theorem textbookPoissonBracket_skew (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = -textbookPoissonBracket G F z := by
  unfold textbookPoissonBracket
  rw [hamiltonianVectorField_eq_dual, hamiltonianVectorField_eq_dual]
  exact covector_hamiltonian_skew _ _

theorem textbookPoissonBracket_self (F : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : textbookPoissonBracket F F z = 0 := by
  have h := textbookPoissonBracket_skew F F z
  linarith

/-- Bilinearity uses the actual derivative of the linear combination. -/
theorem textbookPoissonBracket_linear_right (F G H : SymplecticCoordinates Nc → ℝ)
    (α β : ℝ) (z : SymplecticCoordinates Nc)
    (hG : DifferentiableAt ℝ G z) (hH : DifferentiableAt ℝ H z) :
    textbookPoissonBracket F (fun x => α * G x + β * H x) z =
      α * textbookPoissonBracket F G z + β * textbookPoissonBracket F H z := by
  have hd := (hG.hasFDerivAt.fun_const_smul α).fun_add
    (hH.hasFDerivAt.fun_const_smul β)
  have hd' : HasFDerivAt (fun x => α * G x + β * H x)
      (α • fderiv ℝ G z + β • fderiv ℝ H z) z := by
    simpa only [smul_eq_mul] using hd
  unfold textbookPoissonBracket
  rw [hamiltonianVectorField_eq_dual, hd'.fderiv]
  simp only [map_add, map_smul, smul_eq_mul, ← hamiltonianVectorField_eq_dual]

/-- Derivative of the actual bracket, with both Hessian terms derived. -/
private theorem poisson_fderiv_apply (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hF : ContDiffAt ℝ 2 F z)
    (hG : ContDiffAt ℝ 2 G z) (v : SymplecticCoordinates Nc) :
    (fderiv ℝ (textbookPoissonBracket F G) z) v =
      (fderiv ℝ (fderiv ℝ F) z v) (textbookHamiltonianVectorField G z) -
      (fderiv ℝ (fderiv ℝ G) z v) (textbookHamiltonianVectorField F z) := by
  have hdF := (hF.fderiv_right (m := 1) (by norm_num)).differentiableAt (by norm_num)
  have hdG := (hG.fderiv_right (m := 1) (by norm_num)).differentiableAt (by norm_num)
  have hxG : HasFDerivAt (textbookHamiltonianVectorField G)
      ((dualHamiltonianMap Nc).comp (fderiv ℝ (fderiv ℝ G) z)) z := by
    simpa only [Function.comp_def, ← hamiltonianVectorField_eq_dual] using
      (dualHamiltonianMap Nc).hasFDerivAt.comp z hdG.hasFDerivAt
  have hp := hdF.hasFDerivAt.clm_apply hxG
  rw [show fderiv ℝ (textbookPoissonBracket F G) z = _ from hp.fderiv]
  change (fderiv ℝ F z) (dualHamiltonianMap Nc (fderiv ℝ (fderiv ℝ G) z v)) +
      (fderiv ℝ (fderiv ℝ F) z v) (textbookHamiltonianVectorField G z) = _
  rw [covector_hamiltonian_skew, ← hamiltonianVectorField_eq_dual]
  ring

/-- The full Jacobi identity follows from actual C² second-derivative symmetry. -/
theorem textbookPoissonBracket_jacobi (F G H : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hF : ContDiffAt ℝ 2 F z)
    (hG : ContDiffAt ℝ 2 G z) (hH : ContDiffAt ℝ 2 H z) :
    textbookPoissonBracket F (textbookPoissonBracket G H) z +
      textbookPoissonBracket H (textbookPoissonBracket F G) z +
      textbookPoissonBracket G (textbookPoissonBracket H F) z = 0 := by
  rw [textbookPoissonBracket_skew F (textbookPoissonBracket G H),
    textbookPoissonBracket_skew H (textbookPoissonBracket F G),
    textbookPoissonBracket_skew G (textbookPoissonBracket H F)]
  change -(fderiv ℝ (textbookPoissonBracket G H) z) (textbookHamiltonianVectorField F z) +
    -(fderiv ℝ (textbookPoissonBracket F G) z) (textbookHamiltonianVectorField H z) +
    -(fderiv ℝ (textbookPoissonBracket H F) z) (textbookHamiltonianVectorField G z) = 0
  rw [poisson_fderiv_apply G H z hG hH, poisson_fderiv_apply F G z hF hG,
    poisson_fderiv_apply H F z hH hF]
  have hFs := hF.isSymmSndFDerivAt (by norm_num)
    (textbookHamiltonianVectorField H z) (textbookHamiltonianVectorField G z)
  have hGs := hG.isSymmSndFDerivAt (by norm_num)
    (textbookHamiltonianVectorField F z) (textbookHamiltonianVectorField H z)
  have hHs := hH.isSymmSndFDerivAt (by norm_num)
    (textbookHamiltonianVectorField F z) (textbookHamiltonianVectorField G z)
  linarith

/-- The exact textbook identification L_(J∇H) F = {F,H}. -/
theorem textbookLieDerivative_hamiltonian_eq_poisson
    (F H : SymplecticCoordinates Nc → ℝ) :
    textbookLieDerivative (textbookHamiltonianVectorField H) F =
      textbookPoissonBracket F H := rfl

theorem hasDerivWithinAt_textbookPoissonBracket (F H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (s : Set ℝ) (t : ℝ)
    (hF : DifferentiableAt ℝ F (γ t))
    (hγ : HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) s t) :
    HasDerivWithinAt (fun u => F (γ u)) (textbookPoissonBracket F H (γ t)) s t :=
  hasDerivWithinAt_textbookLieDerivative _ F γ s t hF hγ

/-- A genuine Hamiltonian solution preserves its actual Hamiltonian on the
whole closed interval; no conservation premise is supplied. -/
theorem textbookHamiltonian_energy_const_on_Icc (H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, DifferentiableAt ℝ H (γ t))
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, H (γ t) = H (γ 0) := by
  have hd : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun u => H (γ u)) 0 (Icc 0 τ) t := by
    intro t ht
    simpa only [textbookPoissonBracket_self] using
      hasDerivWithinAt_textbookPoissonBracket H H γ (Icc 0 τ) t (hH t ht) (hγ t ht)
  apply constant_of_has_deriv_right_zero (fun t ht => (hd t ht).continuousWithinAt)
  intro t ht
  exact (hd t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)

/-- The other slot is linear as a consequence of the genuine skew identity. -/
theorem textbookPoissonBracket_linear_left (F G H : SymplecticCoordinates Nc → ℝ)
    (α β : ℝ) (z : SymplecticCoordinates Nc)
    (hF : DifferentiableAt ℝ F z) (hH : DifferentiableAt ℝ H z) :
    textbookPoissonBracket (fun x => α * F x + β * H x) G z =
      α * textbookPoissonBracket F G z + β * textbookPoissonBracket H G z := by
  rw [textbookPoissonBracket_skew (fun x => α * F x + β * H x) G,
    textbookPoissonBracket_linear_right G F H α β z hF hH,
    textbookPoissonBracket_skew G F, textbookPoissonBracket_skew G H]
  ring

/-- Additivity in H uses the actual Hamiltonian field-of-sum identity. -/
theorem textbookHamiltonianLieDerivative_add (F H₁ H₂ : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hH₁ : DifferentiableAt ℝ H₁ z)
    (hH₂ : DifferentiableAt ℝ H₂ z) :
    textbookLieDerivative (textbookHamiltonianVectorField (fun x => H₁ x + H₂ x)) F z =
      textbookLieDerivative (textbookHamiltonianVectorField H₁) F z +
      textbookLieDerivative (textbookHamiltonianVectorField H₂) F z := by
  unfold textbookLieDerivative
  rw [textbookHamiltonianVectorField_add H₁ H₂ z hH₁ hH₂, map_add]

/-- With L_H F={F,H} and [A,B]=AB-BA, the commutator Hamiltonian is
{H₂,H₁}.  This matches the first displayed derivation on printed105/PDF127;
the next display there reverses the bracket and therefore the sign. -/
theorem textbookHamiltonianLieDerivative_commutator
    (F H₁ H₂ : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hF : ContDiffAt ℝ 2 F z) (hH₁ : ContDiffAt ℝ 2 H₁ z)
    (hH₂ : ContDiffAt ℝ 2 H₂ z) :
    textbookLieDerivative (textbookHamiltonianVectorField H₁)
        (textbookLieDerivative (textbookHamiltonianVectorField H₂) F) z -
      textbookLieDerivative (textbookHamiltonianVectorField H₂)
        (textbookLieDerivative (textbookHamiltonianVectorField H₁) F) z =
      textbookLieDerivative (textbookHamiltonianVectorField
        (textbookPoissonBracket H₂ H₁)) F z := by
  simp only [textbookLieDerivative_hamiltonian_eq_poisson]
  rw [textbookPoissonBracket_skew F (textbookPoissonBracket H₂ H₁)]
  change (fderiv ℝ (textbookPoissonBracket F H₂) z) (textbookHamiltonianVectorField H₁ z) -
    (fderiv ℝ (textbookPoissonBracket F H₁) z) (textbookHamiltonianVectorField H₂ z) =
    -(fderiv ℝ (textbookPoissonBracket H₂ H₁) z) (textbookHamiltonianVectorField F z)
  rw [poisson_fderiv_apply F H₂ z hF hH₂, poisson_fderiv_apply F H₁ z hF hH₁,
    poisson_fderiv_apply H₂ H₁ z hH₂ hH₁]
  have hFs := hF.isSymmSndFDerivAt (by norm_num)
    (textbookHamiltonianVectorField H₁ z) (textbookHamiltonianVectorField H₂ z)
  have hH₁s := hH₁.isSymmSndFDerivAt (by norm_num)
    (textbookHamiltonianVectorField H₂ z) (textbookHamiltonianVectorField F z)
  have hH₂s := hH₂.isSymmSndFDerivAt (by norm_num)
    (textbookHamiltonianVectorField H₁ z) (textbookHamiltonianVectorField F z)
  linarith

end Poisson

end MolecularDynamics
