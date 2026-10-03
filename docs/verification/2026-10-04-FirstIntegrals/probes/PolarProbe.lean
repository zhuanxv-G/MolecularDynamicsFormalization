import MolecularDynamics.Chapter01.Lagrangian

namespace MolecularDynamics

theorem polarKinetic_identity (r θ v ω : ℝ) :
    (v * Real.cos θ - r * ω * Real.sin θ) ^ 2 +
      (v * Real.sin θ + r * ω * Real.cos θ) ^ 2 = v ^ 2 + r ^ 2 * ω ^ 2 := by
  calc
    _ = (v ^ 2 + r ^ 2 * ω ^ 2) * (Real.cos θ ^ 2 + Real.sin θ ^ 2) := by ring
    _ = _ := by rw [Real.cos_sq_add_sin_sq]; ring

theorem polarAngularMomentum_identity (r θ v ω : ℝ) :
    (r * Real.cos θ) * (v * Real.sin θ + r * ω * Real.cos θ) -
      (r * Real.sin θ) * (v * Real.cos θ - r * ω * Real.sin θ) = r ^ 2 * ω := by
  calc
    _ = r ^ 2 * ω * (Real.cos θ ^ 2 + Real.sin θ ^ 2) := by ring
    _ = _ := by rw [Real.cos_sq_add_sin_sq]; ring

theorem keplerPolarLagrangian_identity (r θ v ω : ℝ) :
    ((v * Real.cos θ - r * ω * Real.sin θ) ^ 2 +
      (v * Real.sin θ + r * ω * Real.cos θ) ^ 2) / 2 + 1 / r =
    v ^ 2 / 2 + r ^ 2 * ω ^ 2 / 2 + 1 / r := by
  rw [polarKinetic_identity]
  ring

theorem polarCoordinates_hasDerivAt_components (r θ : ℝ → ℝ) (v ω t : ℝ)
    (hr : HasDerivAt r v t) (hθ : HasDerivAt θ ω t) :
    HasDerivAt (fun u => r u * Real.cos (θ u))
      (v * Real.cos (θ t) - r t * ω * Real.sin (θ t)) t ∧
    HasDerivAt (fun u => r u * Real.sin (θ u))
      (v * Real.sin (θ t) + r t * ω * Real.cos (θ t)) t := by
  have hc := hr.mul ((Real.hasDerivAt_cos (θ t)).comp t hθ)
  have hs := hr.mul ((Real.hasDerivAt_sin (θ t)).comp t hθ)
  have heqc : v * Real.cos (θ t) + r t * (-Real.sin (θ t) * ω) =
      v * Real.cos (θ t) - r t * ω * Real.sin (θ t) := by ring
  have heqs : v * Real.sin (θ t) + r t * (Real.cos (θ t) * ω) =
      v * Real.sin (θ t) + r t * ω * Real.cos (θ t) := by ring
  dsimp only [Function.comp_def] at hc hs
  rw [heqc] at hc
  rw [heqs] at hs
  exact ⟨hc, hs⟩

noncomputable def polarJacobian (r θ : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos θ, -r * Real.sin θ; Real.sin θ, r * Real.cos θ]

theorem polarJacobian_det (r θ : ℝ) : (polarJacobian r θ).det = r := by
  rw [Matrix.det_fin_two]
  change Real.cos θ * (r * Real.cos θ) - (-r * Real.sin θ) * Real.sin θ = r
  calc
    _ = r * (Real.cos θ ^ 2 + Real.sin θ ^ 2) := by ring
    _ = r := by rw [Real.cos_sq_add_sin_sq]; ring

theorem polarJacobian_isUnit_iff (r θ : ℝ) : IsUnit (polarJacobian r θ) ↔ r ≠ 0 := by
  rw [Matrix.isUnit_iff_isUnit_det, polarJacobian_det, isUnit_iff_ne_zero]

#print axioms polarKinetic_identity
#print axioms polarAngularMomentum_identity
#print axioms keplerPolarLagrangian_identity
#print axioms polarCoordinates_hasDerivAt_components
#print axioms polarJacobian_isUnit_iff
end MolecularDynamics
