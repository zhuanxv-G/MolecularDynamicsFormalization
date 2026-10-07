import MolecularDynamics.Chapter02.AdjointMethods

/-!
# Composition of actual numerical methods

Printed85/PDF107, §2.4.1--2.4.2.  General C¹ symplectic maps need not be
assumed globally invertible for composition.  The adjoint construction uses
actual equivalences, and its half-step composition is proved self-adjoint.
-/

namespace MolecularDynamics

/-- The actual half-step composition, in the order displayed in the text. -/
noncomputable def textbookComposeMaps {E : Type*} (G₁ G₂ : ℝ → E → E) (h : ℝ) : E → E :=
  G₁ (h / 2) ∘ G₂ (h / 2)

/-- Actual Jacobian symplecticity of the two methods implies that of their
composition, without adding a global-invertibility assumption. -/
theorem textbookComposeMaps_isSymplectic {Nc : ℕ}
    (G₁ G₂ : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hG₁ : ∀ h, IsTextbookSymplecticMap (G₁ h))
    (hG₂ : ∀ h, IsTextbookSymplecticMap (G₂ h)) (h : ℝ) :
    IsTextbookSymplecticMap (textbookComposeMaps G₁ G₂ h) :=
  (hG₁ (h / 2)).comp (hG₂ (h / 2))

/-- When the two methods are genuinely invertible, the same composition is
an actual equivalence, with its genuine inverse. -/
noncomputable def textbookComposeMethods {E : Type*} (G₁ G₂ : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := G₁ (h / 2) * G₂ (h / 2)

theorem textbookComposeMethods_toMap {E : Type*}
    (G₁ G₂ : ℝ → Equiv.Perm E) (h : ℝ) :
    (textbookComposeMethods G₁ G₂ h : E → E) =
      textbookComposeMaps (fun t => G₁ t) (fun t => G₂ t) h := rfl

/-- Taking the adjoint reverses the order of the actual composition. -/
theorem textbookAdjointMethod_comp {E : Type*} (G₁ G₂ : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookComposeMethods G₁ G₂) =
      textbookComposeMethods (textbookAdjointMethod G₂) (textbookAdjointMethod G₁) := by
  funext h
  simp only [textbookAdjointMethod, textbookComposeMethods, neg_div]
  rfl

/-- A method followed by its adjoint, each at half step. -/
noncomputable def textbookSymmetricComposition {E : Type*} (G : ℝ → Equiv.Perm E) :
    ℝ → Equiv.Perm E := textbookComposeMethods (textbookAdjointMethod G) G

/-- The literal identity K†=K proved on printed85/PDF107. -/
theorem textbookSymmetricComposition_isSelfAdjoint {E : Type*}
    (G : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookSymmetricComposition G) =
      textbookSymmetricComposition G := by
  unfold textbookSymmetricComposition
  rw [textbookAdjointMethod_comp, textbookAdjointMethod_involutive]

theorem textbookComposeMethods_isSymplectic {Nc : ℕ}
    (G₁ G₂ : ℝ → Equiv.Perm (SymplecticCoordinates Nc))
    (hG₁ : ∀ h, IsTextbookSymplecticEquiv (G₁ h))
    (hG₂ : ∀ h, IsTextbookSymplecticEquiv (G₂ h)) (h : ℝ) :
    IsTextbookSymplecticEquiv (textbookComposeMethods G₁ G₂ h) :=
  (hG₁ (h / 2)).mul (hG₂ (h / 2))

/-- The symmetric composition of an actual C¹ symplectic equivalence
remains an actual C¹ symplectic equivalence. -/
theorem textbookSymmetricComposition_isSymplectic {Nc : ℕ}
    (G : ℝ → Equiv.Perm (SymplecticCoordinates Nc))
    (hG : ∀ h, IsTextbookSymplecticEquiv (G h)) (h : ℝ) :
    IsTextbookSymplecticEquiv (textbookSymmetricComposition G h) :=
  textbookComposeMethods_isSymplectic _ G (textbookAdjointMethod_isSymplectic G hG) hG h

end MolecularDynamics
