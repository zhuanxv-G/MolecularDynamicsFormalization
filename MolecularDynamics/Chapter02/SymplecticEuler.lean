import MolecularDynamics.Chapter02.HamiltonianVariational
import Mathlib.Analysis.Calculus.FDeriv.CompCLM
import Mathlib.Analysis.Calculus.FDeriv.Pi

/-!
# The actual symplectic Euler method

Printed80--81/PDF102--103, equations (2.18)--(2.21).
The force is the actual coordinate negative gradient of a C² potential.
The step updates momentum first and then position.  No symplecticity or
symmetric-Jacobian hypothesis is supplied for that method.
-/

open Matrix
open scoped Matrix

namespace MolecularDynamics

noncomputable def textbookPositionProjection (Nc : ℕ) :
    SymplecticCoordinates Nc →L[ℝ] (Fin Nc → ℝ) :=
  ContinuousLinearMap.pi fun i => ContinuousLinearMap.proj (Sum.inl i)

private theorem positionProjection_single_inl {Nc : ℕ} (j : Fin Nc) :
    textbookPositionProjection Nc (Pi.single (Sum.inl j) 1) = Pi.single j 1 := by
  ext i
  simp [textbookPositionProjection, Pi.single_apply]

private theorem positionProjection_single_inr {Nc : ℕ} (j : Fin Nc) :
    textbookPositionProjection Nc (Pi.single (Sum.inr j) 1) = 0 := by
  ext i
  simp [textbookPositionProjection]

/-- Negative partial derivatives of the actual potential. -/
noncomputable def textbookPotentialForce {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => -(fderiv ℝ U q) (Pi.single i 1)

theorem contDiff_textbookPotentialForce {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) :
    ContDiff ℝ 1 (textbookPotentialForce U) := by
  apply contDiff_pi.mpr
  intro i
  exact ((hU.fderiv_right (m := 1) (by norm_num)).clm_apply
    (contDiff_const (c := Pi.single i 1))).neg

private theorem potentialForce_hasFDerivAt {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) (hU : ContDiff ℝ 2 U) :
    HasFDerivAt (textbookPotentialForce U)
      (ContinuousLinearMap.pi fun i =>
        -((fderiv ℝ (fderiv ℝ U) q).flip (Pi.single i 1))) q := by
  apply hasFDerivAt_pi.mpr
  intro i
  have h := ((hU.fderiv_right (m := 1) (by norm_num)).differentiable_one q).hasFDerivAt
  simpa [textbookPotentialForce, Pi.neg_apply] using
    (h.clm_apply (hasFDerivAt_const (Pi.single i 1) q)).fun_neg

/-- The force Jacobian is genuinely symmetric, derived from U rather than assumed. -/
theorem textbookPotentialForce_matrix_isSymm {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) (hU : ContDiff ℝ 2 U) :
    (LinearMap.toMatrix' (fderiv ℝ (textbookPotentialForce U) q).toLinearMap).IsSymm := by
  rw [(potentialForce_hasFDerivAt U q hU).fderiv]
  apply Matrix.IsSymm.ext
  intro i j
  change -(fderiv ℝ (fderiv ℝ U) q) (Pi.single i 1) (Pi.single j 1) =
    -(fderiv ℝ (fderiv ℝ U) q) (Pi.single j 1) (Pi.single i 1)
  exact congrArg Neg.neg (hU.contDiffAt.isSymmSndFDerivAt (by norm_num)
    (Pi.single i 1) (Pi.single j 1))

/-- Momentum kick, evaluated at the old position. -/
noncomputable def textbookMomentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i))
    (fun i => z (Sum.inr i) + h * F (textbookPositionProjection Nc z) i)

/-- Position drift with the literal diagonal inverse mass coefficients. -/
noncomputable def textbookPositionDrift {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))

private noncomputable def momentumKickDerivative {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc →L[ℝ] SymplecticCoordinates Nc :=
  ContinuousLinearMap.pi (Sum.elim
    (fun i => ContinuousLinearMap.proj (Sum.inl i))
    (fun i => ContinuousLinearMap.proj (Sum.inr i) + h •
      (ContinuousLinearMap.proj i).comp
        ((fderiv ℝ F (textbookPositionProjection Nc z)).comp
          (textbookPositionProjection Nc))))

private theorem momentumKick_hasFDerivAt {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc)
    (hF : ContDiff ℝ 1 F) :
    HasFDerivAt (textbookMomentumKick F h) (momentumKickDerivative F h z) z := by
  apply hasFDerivAt_pi.mpr
  intro i
  rcases i with i | i
  · exact hasFDerivAt_apply (Sum.inl i) z
  · have hf := ((hF.differentiable_one (textbookPositionProjection Nc z)).hasFDerivAt.comp z
      (textbookPositionProjection Nc).hasFDerivAt)
    have hi := (hasFDerivAt_apply i (F (textbookPositionProjection Nc z))).comp z hf
    simpa only [textbookMomentumKick, Sum.elim_inr, Pi.add_apply, Pi.smul_apply,
      Function.comp_apply, smul_eq_mul] using
      (hasFDerivAt_apply (Sum.inr i) z).fun_add (hi.fun_const_smul h)

theorem textbookJacobian_momentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc)
    (hF : ContDiff ℝ 1 F) :
    textbookJacobian (textbookMomentumKick F h) z = Matrix.fromBlocks 1 0
      (h • LinearMap.toMatrix' (fderiv ℝ F (textbookPositionProjection Nc z)).toLinearMap) 1 := by
  ext (i | i) (j | j) <;>
    rw [textbookJacobian_entry, (momentumKick_hasFDerivAt F h z hF).fderiv] <;>
    simp [momentumKickDerivative, positionProjection_single_inl, positionProjection_single_inr,
      LinearMap.toMatrix'_apply, Pi.single_apply, Matrix.one_apply, smul_eq_mul]

theorem contDiff_textbookMomentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (hF : ContDiff ℝ 1 F) :
    ContDiff ℝ 1 (textbookMomentumKick F h) := by
  apply contDiff_pi.mpr
  intro i
  rcases i with i | i
  · exact contDiff_apply ℝ ℝ (Sum.inl i)
  · simpa [textbookMomentumKick, smul_eq_mul] using
      (contDiff_apply ℝ ℝ (Sum.inr i)).add
        (ContDiff.const_smul h
          ((contDiff_apply ℝ ℝ i).comp (hF.comp (textbookPositionProjection Nc).contDiff)))

private noncomputable def positionDriftLinear (Nc : ℕ) (m : Fin Nc → ℝ) (h : ℝ) :
    SymplecticCoordinates Nc →L[ℝ] SymplecticCoordinates Nc :=
  ContinuousLinearMap.pi (Sum.elim
    (fun i => ContinuousLinearMap.proj (Sum.inl i) + (h * (m i)⁻¹) •
      ContinuousLinearMap.proj (Sum.inr i))
    (fun i => ContinuousLinearMap.proj (Sum.inr i)))

theorem textbookJacobian_positionDrift {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookJacobian (textbookPositionDrift m h) z =
      Matrix.fromBlocks 1 (Matrix.diagonal (fun i => h * (m i)⁻¹)) 0 1 := by
  have heq : textbookPositionDrift m h = positionDriftLinear Nc m h := by
    funext z i
    rcases i with i | i <;> simp [textbookPositionDrift, positionDriftLinear, smul_eq_mul]
  unfold textbookJacobian
  rw [heq, (positionDriftLinear Nc m h).hasFDerivAt.fderiv]
  ext (i | i) (j | j) <;>
    simp [positionDriftLinear, LinearMap.toMatrix'_apply, Pi.single_apply,
      Matrix.one_apply, Matrix.diagonal_apply, smul_eq_mul]

private theorem symplectic_lower_shear {Nc : ℕ}
    (B : Matrix (Fin Nc) (Fin Nc) ℝ) (hB : B.IsSymm) :
    IsTextbookSymplectic (Matrix.fromBlocks 1 0 B 1) := by
  unfold IsTextbookSymplectic textbookJ
  simp [Matrix.fromBlocks_transpose, Matrix.fromBlocks_multiply, hB.eq]

private theorem symplectic_upper_shear {Nc : ℕ}
    (B : Matrix (Fin Nc) (Fin Nc) ℝ) (hB : B.IsSymm) :
    IsTextbookSymplectic (Matrix.fromBlocks 1 B 0 1) := by
  unfold IsTextbookSymplectic textbookJ
  simp [Matrix.fromBlocks_transpose, Matrix.fromBlocks_multiply, hB.eq]

theorem textbookPositionDrift_isSymplectic {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ) :
    IsTextbookSymplecticMap (textbookPositionDrift m h) := by
  constructor
  · have heq : textbookPositionDrift m h = positionDriftLinear Nc m h := by
      funext z i
      rcases i with i | i <;> simp [textbookPositionDrift, positionDriftLinear, smul_eq_mul]
    rw [heq]
    exact (positionDriftLinear Nc m h).contDiff
  · intro z
    rw [textbookJacobian_positionDrift]
    exact symplectic_upper_shear _ (Matrix.isSymm_diagonal _)

theorem textbookPotentialKick_isSymplectic {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) (hU : ContDiff ℝ 2 U) :
    IsTextbookSymplecticMap (textbookMomentumKick (textbookPotentialForce U) h) := by
  have hF := contDiff_textbookPotentialForce U hU
  refine ⟨contDiff_textbookMomentumKick _ h hF, ?_⟩
  intro z
  rw [textbookJacobian_momentumKick _ h z hF]
  exact symplectic_lower_shear _
    ((textbookPotentialForce_matrix_isSymm U (textbookPositionProjection Nc z) hU).smul h)

/-- The literal momentum-first symplectic Euler step. -/
noncomputable def textbookSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookPositionDrift m h ∘ textbookMomentumKick (textbookPotentialForce U) h

theorem textbookSymplecticEuler_position {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) (i : Fin Nc) :
    textbookSymplecticEuler m U h z (Sum.inl i) = z (Sum.inl i) + h * (m i)⁻¹ *
      (z (Sum.inr i) + h * textbookPotentialForce U (textbookPositionProjection Nc z) i) := rfl

theorem textbookSymplecticEuler_momentum {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) (i : Fin Nc) :
    textbookSymplecticEuler m U h z (Sum.inr i) =
      z (Sum.inr i) + h * textbookPotentialForce U (textbookPositionProjection Nc z) i := rfl

/-- The actual C¹ step preserves the standard symplectic form. -/
theorem textbookSymplecticEuler_isSymplectic {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) (hU : ContDiff ℝ 2 U) :
    IsTextbookSymplecticMap (textbookSymplecticEuler m U h) := by
  exact (textbookPositionDrift_isSymplectic m h).comp
    (textbookPotentialKick_isSymplectic U h hU)

theorem textbookPositionProjection_momentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc) :
    textbookPositionProjection Nc (textbookMomentumKick F h z) =
      textbookPositionProjection Nc z := by
  ext i
  rfl

theorem textbookMomentumKick_neg_cancel {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc) :
    textbookMomentumKick F (-h) (textbookMomentumKick F h z) = z := by
  funext i
  rcases i with i | i
  · rfl
  · change textbookMomentumKick F h z (Sum.inr i) +
      (-h) * F (textbookPositionProjection Nc (textbookMomentumKick F h z)) i = z (Sum.inr i)
    rw [textbookPositionProjection_momentumKick]
    change z (Sum.inr i) + h * F (textbookPositionProjection Nc z) i +
      (-h) * F (textbookPositionProjection Nc z) i = z (Sum.inr i)
    ring

theorem textbookPositionDrift_neg_cancel {Nc : ℕ}
    (m : Fin Nc → ℝ) (h : ℝ) (z : SymplecticCoordinates Nc) :
    textbookPositionDrift m (-h) (textbookPositionDrift m h z) = z := by
  funext i
  rcases i with i | i
  · change z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i) +
      (-h) * (m i)⁻¹ * z (Sum.inr i) = z (Sum.inl i)
    ring
  · rfl

/-- The actual kick inverse exists globally for every force function. -/
noncomputable def textbookMomentumKickEquiv {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) : Equiv.Perm (SymplecticCoordinates Nc) where
  toFun := textbookMomentumKick F h
  invFun := textbookMomentumKick F (-h)
  left_inv := textbookMomentumKick_neg_cancel F h
  right_inv z := by simpa only [neg_neg] using textbookMomentumKick_neg_cancel F (-h) z

noncomputable def textbookPositionDriftEquiv {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) where
  toFun := textbookPositionDrift m h
  invFun := textbookPositionDrift m (-h)
  left_inv := textbookPositionDrift_neg_cancel m h
  right_inv z := by simpa only [neg_neg] using textbookPositionDrift_neg_cancel m (-h) z

/-- A global equivalence for the actual step, used by the next section's adjoint. -/
noncomputable def textbookSymplecticEulerEquiv {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) :=
  textbookPositionDriftEquiv m h * textbookMomentumKickEquiv (textbookPotentialForce U) h

theorem textbookSymplecticEulerEquiv_apply {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) (z : SymplecticCoordinates Nc) :
    textbookSymplecticEulerEquiv m U h z = textbookSymplecticEuler m U h z := rfl

theorem textbookSymplecticEulerEquiv_symm_apply {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) (z : SymplecticCoordinates Nc) :
    (textbookSymplecticEulerEquiv m U h).symm z =
      textbookMomentumKick (textbookPotentialForce U) (-h) (textbookPositionDrift m (-h) z) := rfl

theorem textbookSymplecticEulerEquiv_isSymplectic {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) (hU : ContDiff ℝ 2 U) :
    IsTextbookSymplecticEquiv (textbookSymplecticEulerEquiv m U h) := by
  constructor
  · exact textbookSymplecticEuler_isSymplectic m U h hU
  · exact (contDiff_textbookMomentumKick _ (-h) (contDiff_textbookPotentialForce U hU)).comp
      (textbookPositionDrift_isSymplectic m (-h)).1

end MolecularDynamics
