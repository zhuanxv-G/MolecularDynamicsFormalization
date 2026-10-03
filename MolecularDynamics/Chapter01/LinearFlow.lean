import MolecularDynamics.Chapter01.GlobalFlow
import Mathlib.Analysis.SpecialFunctions.Exponential

/-! Printed27/PDF50: the constant-linear ODE has an actual exponential IVP.
Banach-space operators give joint continuous flows; finite matrix and spectral
representations require their separate bridge proofs. -/

open Set
namespace MolecularDynamics
section Banach
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

noncomputable local instance : NormedAlgebra ℚ (E →L[ℝ] E) :=
  .restrictScalars ℚ ℝ (E →L[ℝ] E)

noncomputable def linearExponentialFlow (A : E →L[ℝ] E) (t : ℝ) (z : E) : E :=
  NormedSpace.exp (t • A) z

omit [CompleteSpace E] in @[simp] theorem linearExponentialFlow_zero (A : E →L[ℝ] E) (z : E) :
    linearExponentialFlow A 0 z = z := by
  simp [linearExponentialFlow]

theorem hasDerivAt_linearExponentialFlow (A : E →L[ℝ] E) (z : E) (t : ℝ) :
    HasDerivAt (fun u => linearExponentialFlow A u z)
      (A (linearExponentialFlow A t z)) t := by
  have h := (hasDerivAt_exp_smul_const' A t).clm_apply
    (hasDerivAt_const t z)
  rw [map_zero, add_zero, mul_apply_eq_comp] at h
  exact h

theorem linearExponentialFlow_add (A : E →L[ℝ] E) (z : E) (s t : ℝ) :
    linearExponentialFlow A (t + s) z =
      linearExponentialFlow A t (linearExponentialFlow A s z) := by
  unfold linearExponentialFlow
  rw [add_smul, NormedSpace.exp_add_of_commute
    (((Commute.refl A).smul_left t).smul_right s), mul_apply_eq_comp]

theorem linearExponentialFlow_continuous (A : E →L[ℝ] E) :
    Continuous (fun x : ℝ × E => linearExponentialFlow A x.1 x.2) := by
  have hexp : Continuous (fun t : ℝ => NormedSpace.exp (t • A)) :=
    NormedSpace.exp_continuous.comp (continuous_id.smul continuous_const)
  exact (hexp.comp continuous_fst).clm_apply continuous_snd

noncomputable def linearContinuousFlow (A : E →L[ℝ] E) : Flow ℝ E where
  toFun := linearExponentialFlow A
  cont' := linearExponentialFlow_continuous A
  map_add' t s z := linearExponentialFlow_add A z s t
  map_zero' := linearExponentialFlow_zero A

theorem linearExponentialFlow_inverse (A : E →L[ℝ] E) (z : E) (t : ℝ) :
    linearExponentialFlow A (-t) (linearExponentialFlow A t z) = z := by
  rw [← linearExponentialFlow_add A z t (-t), neg_add_cancel,
    linearExponentialFlow_zero]

omit [CompleteSpace E] in theorem linearExponentialFlow_initial_time (A : E →L[ℝ] E) (z : E) (t₀ : ℝ) :
    (fun t => linearExponentialFlow A (t - t₀) z) t₀ = z := by simp

theorem hasDerivAt_linearExponentialFlow_initial_time
    (A : E →L[ℝ] E) (z : E) (t₀ t : ℝ) :
    HasDerivAt (fun u => linearExponentialFlow A (u - t₀) z)
      (A (linearExponentialFlow A (t - t₀) z)) t := by
  have h := (hasDerivAt_linearExponentialFlow A z (t - t₀)).scomp t
    ((hasDerivAt_id t).sub_const t₀)
  rw [one_smul] at h
  exact h

theorem linearExponentialFlow_unique (A : E →L[ℝ] E) (z : E) (t₀ : ℝ)
    (γ : ℝ → E) (hγ : ∀ t, HasDerivAt γ (A (γ t)) t) (hinit : γ t₀ = z) :
    γ = fun t => linearExponentialFlow A (t - t₀) z := by
  exact ODE_solution_unique_univ
    (s := fun _ => univ) (v := fun _ x => A x)
    (fun _ => A.lipschitzWith.lipschitzOnWith)
    (fun t => ⟨hγ t, mem_univ _⟩)
    (fun t => ⟨hasDerivAt_linearExponentialFlow_initial_time A z t₀ t, mem_univ _⟩)
    (hinit.trans (linearExponentialFlow_initial_time A z t₀).symm)

omit [CompleteSpace E] in theorem linearExponentialOperator_series (A : E →L[ℝ] E) (t : ℝ) :
    NormedSpace.exp (t • A) = ∑' k : ℕ, ((k.factorial : ℝ)⁻¹) • (t • A) ^ k := by
  rw [NormedSpace.exp_eq_tsum ℝ]
end Banach
end MolecularDynamics
