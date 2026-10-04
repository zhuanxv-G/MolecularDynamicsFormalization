import MolecularDynamics.Chapter02.SymplecticEuler
import MolecularDynamics.Chapter02.EulerConvergence
import Mathlib.Dynamics.Flow

/-!
# The adjoint method

Printed81--82/PDF103--104, §2.3.7.  Inverse maps are genuine equivalences.
The backward-Euler equation is treated as an exact relation, with no
unsupported existence or uniqueness assertion for an arbitrary field.
-/

namespace MolecularDynamics

/-- The inverse of the negative-step map, for an actually invertible method. -/
noncomputable def textbookAdjointMethod {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm

theorem textbookAdjointMethod_apply_eq_iff {E : Type*}
    (G : ℝ → Equiv.Perm E) (h : ℝ) (z Z : E) :
    textbookAdjointMethod G h z = Z ↔ G (-h) Z = z :=
  (G (-h)).symm_apply_eq.trans eq_comm

/-- The adjoint operation is an involution on the entire actual family. -/
theorem textbookAdjointMethod_involutive {E : Type*} (G : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookAdjointMethod G) = G := by
  funext h
  simp [textbookAdjointMethod]

theorem textbookAdjointMethod_isSymplectic {Nc : ℕ}
    (G : ℝ → Equiv.Perm (SymplecticCoordinates Nc))
    (hG : ∀ h, IsTextbookSymplecticEquiv (G h)) (h : ℝ) :
    IsTextbookSymplecticEquiv (textbookAdjointMethod G h) :=
  (hG (-h)).symm

/-- Genuine continuous flows give globally invertible steps. -/
noncomputable def textbookFlowMethod {E : Type*} [TopologicalSpace E]
    (F : Flow ℝ E) (h : ℝ) : Equiv.Perm E :=
  (F.toHomeomorph h).toEquiv

theorem textbookFlowMethod_isSelfAdjoint {E : Type*} [TopologicalSpace E]
    (F : Flow ℝ E) : textbookAdjointMethod (textbookFlowMethod F) = textbookFlowMethod F := by
  funext h
  apply Equiv.ext
  intro z
  change F (-(-h)) z = F h z
  rw [neg_neg]

section BackwardEuler

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- The literal inverse-step relation is precisely the backward Euler equation. -/
theorem euler_negative_step_iff_backward (f : E → E) (h : ℝ) (z Z : E) :
    eulerStep f (-h) Z = z ↔ Z = z + h • f Z := by
  simpa only [eulerStep, neg_smul, ← sub_eq_add_neg] using
    (sub_eq_iff_eq_add : Z - h • f Z = z ↔ Z = z + h • f Z)

/-- If the negative Euler step really is invertible, its adjoint is its
unique backward-equation solution.  Invertibility is not asserted here. -/
theorem euler_adjoint_iff_backward (f : E → E) (G : ℝ → Equiv.Perm E)
    (h : ℝ) (hG : ∀ Z, G (-h) Z = eulerStep f (-h) Z) (z Z : E) :
    textbookAdjointMethod G h z = Z ↔ Z = z + h • f Z := by
  rw [textbookAdjointMethod_apply_eq_iff, hG Z, euler_negative_step_iff_backward]

end BackwardEuler

/-- The actual adjoint of the already proven invertible symplectic Euler method. -/
noncomputable def textbookAdjointSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) :=
  textbookAdjointMethod (textbookSymplecticEulerEquiv m U) h

theorem textbookAdjointSymplecticEuler_apply {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) (z : SymplecticCoordinates Nc) :
    textbookAdjointSymplecticEuler m U h z =
      textbookMomentumKick (textbookPotentialForce U) h (textbookPositionDrift m h z) := by
  simp only [textbookAdjointSymplecticEuler, textbookAdjointMethod,
    textbookSymplecticEulerEquiv_symm_apply, neg_neg]

/-- Equation (2.22): update position using the old momentum. -/
theorem textbookAdjointSymplecticEuler_position {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) (i : Fin Nc) :
    textbookAdjointSymplecticEuler m U h z (Sum.inl i) =
      z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i) := by
  rw [textbookAdjointSymplecticEuler_apply]
  rfl

/-- Equation (2.23): update momentum using the new position. -/
theorem textbookAdjointSymplecticEuler_momentum {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) (i : Fin Nc) :
    textbookAdjointSymplecticEuler m U h z (Sum.inr i) = z (Sum.inr i) +
      h * textbookPotentialForce U
        (fun j => z (Sum.inl j) + h * (m j)⁻¹ * z (Sum.inr j)) i := by
  rw [textbookAdjointSymplecticEuler_apply]
  rfl

theorem textbookAdjointSymplecticEuler_isSymplectic {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) (hU : ContDiff ℝ 2 U) :
    IsTextbookSymplecticEquiv (textbookAdjointSymplecticEuler m U h) :=
  (textbookSymplecticEulerEquiv_isSymplectic m U (-h) hU).symm

end MolecularDynamics
