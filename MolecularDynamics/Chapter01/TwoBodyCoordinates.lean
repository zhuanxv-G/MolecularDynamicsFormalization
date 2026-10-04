import MolecularDynamics.Chapter01.ParticleCoordinates

/-!
# Two-body center-of-mass coordinates

Printed page 47/PDF page 70, exercise 3(b), asks for the center-of-mass and
relative coordinates of two equal-mass planar particles.  This module records
the exact linear coordinate algebra and the equal-mass kinetic decomposition.
The radial potential and the resulting equations of motion are separate claims.
-/

namespace MolecularDynamics

/-- Center-of-mass coordinate for two planar particles of equal mass. -/
noncomputable def twoBodyCenterOfMass (q₁ q₂ : Position 2) : Position 2 :=
  (1 / 2 : ℝ) • (q₁ + q₂)

/-- Relative coordinate (Delta = q₂ - q₁). -/
def twoBodySeparation (q₁ q₂ : Position 2) : Position 2 :=
  q₂ - q₁

/-- Center-of-mass velocity for two planar particles of equal mass. -/
noncomputable def twoBodyCenterVelocity (v₁ v₂ : Velocity 2) : Velocity 2 :=
  (1 / 2 : ℝ) • (v₁ + v₂)

/-- Relative velocity associated with the relative coordinate. -/
def twoBodyRelativeVelocity (v₁ v₂ : Velocity 2) : Velocity 2 :=
  v₂ - v₁

/-- Recover the first physical position from center and relative coordinates. -/
theorem twoBody_reconstruct_first (q₁ q₂ : Position 2) :
    twoBodyCenterOfMass q₁ q₂ -
        (1 / 2 : ℝ) • twoBodySeparation q₁ q₂ = q₁ := by
  unfold twoBodyCenterOfMass twoBodySeparation
  module

/-- Recover the second physical position from center and relative coordinates. -/
theorem twoBody_reconstruct_second (q₁ q₂ : Position 2) :
    twoBodyCenterOfMass q₁ q₂ +
        (1 / 2 : ℝ) • twoBodySeparation q₁ q₂ = q₂ := by
  unfold twoBodyCenterOfMass twoBodySeparation
  module

/-- The center coordinate is unchanged by the inverse coordinate map. -/
theorem twoBody_center_roundtrip (qcm δ : Position 2) :
    twoBodyCenterOfMass (qcm - (1 / 2 : ℝ) • δ)
      (qcm + (1 / 2 : ℝ) • δ) = qcm := by
  unfold twoBodyCenterOfMass
  module

/-- The relative coordinate is unchanged by the inverse coordinate map. -/
theorem twoBody_separation_roundtrip (qcm δ : Position 2) :
    twoBodySeparation (qcm - (1 / 2 : ℝ) • δ)
      (qcm + (1 / 2 : ℝ) • δ) = δ := by
  unfold twoBodySeparation
  module

/-- Equal-mass kinetic energy in center/relative velocity coordinates.

The first term has total mass 2m, while the second has reduced mass m/2.
-/
theorem twoBody_equalMass_kinetic_decomposition (m : ℝ) (v₁ v₂ : Velocity 2) :
    m * ‖v₁‖ ^ 2 / 2 + m * ‖v₂‖ ^ 2 / 2 =
      m * ‖twoBodyCenterVelocity v₁ v₂‖ ^ 2 +
        m / 4 * ‖twoBodyRelativeVelocity v₁ v₂‖ ^ 2 := by
  unfold twoBodyCenterVelocity twoBodyRelativeVelocity
  rw [norm_smul]
  have hhalf : ‖(1 / 2 : ℝ)‖ = 1 / 2 := by
    norm_num [Real.norm_eq_abs, abs_of_nonneg]
  rw [hhalf]
  have hcenter :
      (1 / 2 * ‖v₁ + v₂‖) ^ 2 =
        (1 / 4 : ℝ) * ‖v₁ + v₂‖ ^ 2 := by
    ring
  rw [hcenter, norm_add_sq_real, norm_sub_sq_real]
  rw [real_inner_comm v₂ v₁]
  ring

end MolecularDynamics

