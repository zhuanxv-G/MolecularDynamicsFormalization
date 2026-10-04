import MolecularDynamics.Chapter01.PolarCoordinates
import MolecularDynamics.Chapter01.FirstIntegrals
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus

/-! Printed29--30/PDF52--53: actual polar Kepler Euler--Lagrange equations,
angular conservation, radial effective energy and angle reconstruction integral.
Positive radius is explicit; Cartesian covariance is a separate bridge. -/

open Set
namespace MolecularDynamics

noncomputable def keplerPolarScalarLagrangian (r _θ v ω : ℝ) : ℝ :=
  v ^ 2 / 2 + r ^ 2 * ω ^ 2 / 2 + 1 / r

theorem keplerPolar_partial_v (r θ v ω : ℝ) :
    HasDerivAt (fun w => keplerPolarScalarLagrangian r θ w ω) v v := by
  convert (((hasDerivAt_id v).pow 2).div_const 2).add_const
    (r ^ 2 * ω ^ 2 / 2 + 1 / r) using 1
  · funext w
    dsimp [keplerPolarScalarLagrangian]
    ring
  · norm_num

theorem keplerPolar_partial_ω (r θ v ω : ℝ) :
    HasDerivAt (fun w => keplerPolarScalarLagrangian r θ v w) (r ^ 2 * ω) ω := by
  convert ((((hasDerivAt_id ω).pow 2).const_mul (r ^ 2)).div_const 2).const_add
    (v ^ 2 / 2) |>.add_const (1 / r) using 1
  · funext w
    dsimp [keplerPolarScalarLagrangian]
  · norm_num
    ring

theorem keplerPolar_partial_r (r θ v ω : ℝ) (hr : r ≠ 0) :
    HasDerivAt (fun ρ => keplerPolarScalarLagrangian ρ θ v ω)
      (r * ω ^ 2 - (r ^ 2)⁻¹) r := by
  convert (((((hasDerivAt_id r).pow 2).mul_const (ω ^ 2)).div_const 2).const_add
    (v ^ 2 / 2)).add (hasDerivAt_inv hr) using 1
  · funext ρ
    dsimp [keplerPolarScalarLagrangian]
    simp only [one_div]
  · norm_num
    ring

theorem keplerPolar_partial_θ (r θ v ω : ℝ) :
    HasDerivAt (fun ϑ => keplerPolarScalarLagrangian r ϑ v ω) 0 θ :=
  hasDerivAt_const θ _

/-- Actual scalar partial derivatives and actual time derivatives on positive radius. -/
def IsKeplerPolarEulerLagrangeOn (I : Set ℝ) (r θ v ω : ℝ → ℝ) : Prop :=
  ∀ t ∈ I, 0 < r t ∧ HasDerivAt r (v t) t ∧ HasDerivAt θ (ω t) t ∧
    HasDerivAt (fun u => deriv (fun w => keplerPolarScalarLagrangian (r u) (θ u) w (ω u)) (v u))
      (deriv (fun ρ => keplerPolarScalarLagrangian ρ (θ t) (v t) (ω t)) (r t)) t ∧
    HasDerivAt (fun u => deriv (fun w => keplerPolarScalarLagrangian (r u) (θ u) (v u) w) (ω u))
      (deriv (fun ϑ => keplerPolarScalarLagrangian (r t) ϑ (v t) (ω t)) (θ t)) t

theorem keplerPolar_eulerLagrange_iff (I : Set ℝ) (r θ v ω : ℝ → ℝ) :
    IsKeplerPolarEulerLagrangeOn I r θ v ω ↔
      ∀ t ∈ I, 0 < r t ∧ HasDerivAt r (v t) t ∧ HasDerivAt θ (ω t) t ∧
        HasDerivAt v (r t * ω t ^ 2 - (r t ^ 2)⁻¹) t ∧
        HasDerivAt (fun u => r u ^ 2 * ω u) 0 t := by
  have hv : (fun u => deriv (fun w => keplerPolarScalarLagrangian (r u) (θ u) w (ω u)) (v u)) = v := by
    funext u
    exact (keplerPolar_partial_v _ _ _ _).deriv
  have hω : (fun u => deriv (fun w => keplerPolarScalarLagrangian (r u) (θ u) (v u) w) (ω u)) =
      (fun u => r u ^ 2 * ω u) := by
    funext u
    exact (keplerPolar_partial_ω _ _ _ _).deriv
  unfold IsKeplerPolarEulerLagrangeOn
  rw [hv, hω]
  apply forall_congr'
  intro t
  apply forall_congr'
  intro ht
  constructor <;> intro h
  · rw [(keplerPolar_partial_r _ _ _ _ (ne_of_gt h.1)).deriv,
      (keplerPolar_partial_θ _ _ _ _).deriv] at h
    exact h
  · rw [(keplerPolar_partial_r _ _ _ _ (ne_of_gt h.1)).deriv,
      (keplerPolar_partial_θ _ _ _ _).deriv]
    exact h

theorem keplerPolar_angular_const (a b : ℝ) (r θ v ω : ℝ → ℝ)
    (h : IsKeplerPolarEulerLagrangeOn (Ioo a b) r θ v ω)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    r s ^ 2 * ω s = r t ^ 2 * ω t := by
  have hd := (keplerPolar_eulerLagrange_iff _ _ _ _ _).mp h
  exact isOpen_Ioo.is_const_of_deriv_eq_zero isPreconnected_Ioo
    (fun u hu => (hd u hu).2.2.2.2.differentiableAt.differentiableWithinAt)
    (fun u hu => (hd u hu).2.2.2.2.deriv) hs ht

theorem keplerPolar_radial_reduction (I : Set ℝ) (r θ v ω : ℝ → ℝ)
    (h : IsKeplerPolarEulerLagrangeOn I r θ v ω) (t : ℝ) (ht : t ∈ I)
    (l : ℝ) (hl : r t ^ 2 * ω t = l) :
    HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t := by
  have hd := (keplerPolar_eulerLagrange_iff _ _ _ _ _).mp h t ht
  have heq : r t * ω t ^ 2 - (r t ^ 2)⁻¹ = -(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3 := by
    rw [← hl]
    field_simp [ne_of_gt hd.1]
    ring
  rw [← heq]
  exact hd.2.2.2.1

noncomputable def keplerRadialEnergy (l r v : ℝ) : ℝ :=
  v ^ 2 / 2 - r⁻¹ + (l ^ 2 / 2) * (r⁻¹) ^ 2

theorem keplerRadialEnergy_formula (l r v : ℝ) :
    keplerRadialEnergy l r v = v ^ 2 / 2 - 1 / r + l ^ 2 / (2 * r ^ 2) := by
  simp [keplerRadialEnergy, div_eq_mul_inv, inv_pow]
  ring

theorem keplerRadialEnergy_hasDerivAt_zero (l : ℝ) (r v : ℝ → ℝ) (t : ℝ)
    (hr0 : r t ≠ 0) (hr : HasDerivAt r (v t) t)
    (hv : HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t) :
    HasDerivAt (fun u => keplerRadialEnergy l (r u) (v u)) 0 t := by
  have hi := (hasDerivAt_inv hr0).comp t hr
  have he := (((hv.pow 2).div_const 2).sub hi).add ((hi.pow 2).const_mul (l ^ 2 / 2))
  convert he using 1
  · rfl
  · dsimp
    field_simp [hr0]
    ring

theorem keplerPolar_radialEnergy_const (a b : ℝ) (r θ v ω : ℝ → ℝ)
    (h : IsKeplerPolarEulerLagrangeOn (Ioo a b) r θ v ω)
    (l : ℝ) (hl : ∀ t ∈ Ioo a b, r t ^ 2 * ω t = l)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    keplerRadialEnergy l (r s) (v s) = keplerRadialEnergy l (r t) (v t) := by
  have hEL := (keplerPolar_eulerLagrange_iff _ _ _ _ _).mp h
  have hd : ∀ u ∈ Ioo a b, HasDerivAt (fun u => keplerRadialEnergy l (r u) (v u)) 0 u := by
    intro u hu
    exact keplerRadialEnergy_hasDerivAt_zero l r v u (ne_of_gt (hEL u hu).1)
      (hEL u hu).2.1 (keplerPolar_radial_reduction _ _ _ _ _ h u hu l (hl u hu))
  exact isOpen_Ioo.is_const_of_deriv_eq_zero isPreconnected_Ioo
    (fun u hu => (hd u hu).differentiableAt.differentiableWithinAt)
    (fun u hu => (hd u hu).deriv) hs ht

theorem keplerPolar_radialEnergy_const_initialAngular (a b : ℝ) (r θ v ω : ℝ → ℝ)
    (h : IsKeplerPolarEulerLagrangeOn (Ioo a b) r θ v ω)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    keplerRadialEnergy (r s ^ 2 * ω s) (r s) (v s) =
      keplerRadialEnergy (r s ^ 2 * ω s) (r t) (v t) :=
  keplerPolar_radialEnergy_const a b r θ v ω h (r s ^ 2 * ω s)
    (fun u hu => (keplerPolar_angular_const a b r θ v ω h s u hs hu).symm) s t hs ht

theorem keplerPolar_energy_radial_identity (r v ω : ℝ) (hr : r ≠ 0) :
    v ^ 2 / 2 + r ^ 2 * ω ^ 2 / 2 - 1 / r =
      keplerRadialEnergy (r ^ 2 * ω) r v := by
  rw [keplerRadialEnergy_formula]
  field_simp [hr]
  ring

theorem keplerPolar_angle_integral (a b : ℝ) (r θ v ω : ℝ → ℝ)
    (h : IsKeplerPolarEulerLagrangeOn (Ioo a b) r θ v ω)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    θ t = θ s + ∫ u in s..t, (r s ^ 2 * ω s) / r u ^ 2 := by
  let l := r s ^ 2 * ω s
  have hEL := (keplerPolar_eulerLagrange_iff _ _ _ _ _).mp h
  have hseg : uIcc s t ⊆ Ioo a b := ordConnected_Ioo.uIcc_subset hs ht
  have hω : ∀ u ∈ Ioo a b, ω u = l / r u ^ 2 := by
    intro u hu
    have hc := keplerPolar_angular_const a b r θ v ω h s u hs hu
    dsimp [l]
    rw [hc]
    field_simp [ne_of_gt (hEL u hu).1]
  have hrc : ContinuousOn r (uIcc s t) :=
    fun u hu => (hEL u (hseg hu)).2.1.continuousAt.continuousWithinAt
  have hc : ContinuousOn (fun u => l / r u ^ 2) (uIcc s t) :=
    continuousOn_const.div (hrc.pow 2)
      (fun u hu => pow_ne_zero 2 (ne_of_gt (hEL u (hseg hu)).1))
  have hi := intervalIntegral.integral_eq_sub_of_hasDerivAt
    (fun u hu => (hω u (hseg hu)) ▸ (hEL u (hseg hu)).2.2.1)
    (hc.intervalIntegrable)
  dsimp [l] at hi
  linarith

end MolecularDynamics
