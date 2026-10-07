import MolecularDynamics.Chapter01.KeplerPolarDynamics
import MolecularDynamics.Chapter01.PolarCoordinateMap
import MolecularDynamics.Chapter01.Kepler

/-! Printed29--30/PDF52--53: actual Cartesian/polar Kepler equivalence.
Positive-radius kinematic lifts carry the genuine Cartesian momentum.
The reverse direction derives acceleration from the actual mechanical ODE. -/

open Set Filter
open scoped Topology
namespace MolecularDynamics

local instance : ContinuousSMul ℝ (PhaseSpace 2) := by
  have : IsBoundedSMul ℝ (PhaseSpace 2) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

noncomputable def polarCartesianState (r θ v ω : ℝ) : PhaseSpace 2 :=
  (WithLp.toLp 2 ![r * Real.cos θ, r * Real.sin θ],
   WithLp.toLp 2 ![v * Real.cos θ - r * ω * Real.sin θ,
     v * Real.sin θ + r * ω * Real.cos θ])

theorem norm_polarCartesianPosition (r θ v ω : ℝ) (hr : 0 ≤ r) :
    ‖(polarCartesianState r θ v ω).1‖ = r := by
  have hsq := EuclideanSpace.real_norm_sq_eq (polarCartesianState r θ v ω).1
  have heq : ∑ i : Fin 2, ((polarCartesianState r θ v ω).1 i) ^ 2 = r ^ 2 := by
    simp only [Fin.sum_univ_two]
    change (r * Real.cos θ) ^ 2 + (r * Real.sin θ) ^ 2 = r ^ 2
    calc
      _ = r ^ 2 * (Real.cos θ ^ 2 + Real.sin θ ^ 2) := by ring
      _ = _ := by rw [Real.cos_sq_add_sin_sq]; ring
  rw [heq] at hsq
  nlinarith [norm_nonneg (polarCartesianState r θ v ω).1]

theorem polarCartesianState_angular (r θ v ω : ℝ) :
    planarAngularMomentum (polarCartesianState r θ v ω) = r ^ 2 * ω :=
  polarAngularMomentum_identity r θ v ω

theorem polarCartesianState_energy (r θ v ω : ℝ) (hr : 0 < r) :
    massHamiltonian (fun _ => (1 : ℝ)) keplerPotential (polarCartesianState r θ v ω) =
      keplerRadialEnergy (r ^ 2 * ω) r v := by
  change (∑ i : Fin 2, ((polarCartesianState r θ v ω).2 i) ^ 2 / (2 * 1)) +
    -‖(polarCartesianState r θ v ω).1‖⁻¹ = _
  rw [norm_polarCartesianPosition r θ v ω hr.le]
  simp only [Fin.sum_univ_two, mul_one]
  change (v * Real.cos θ - r * ω * Real.sin θ) ^ 2 / 2 +
    (v * Real.sin θ + r * ω * Real.cos θ) ^ 2 / 2 + -r⁻¹ = _
  rw [← add_div, polarKinetic_identity]
  rw [← keplerPolar_energy_radial_identity r v ω (ne_of_gt hr)]
  simp only [one_div]
  ring

theorem hasDerivAt_planarPair (f g : ℝ → ℝ) (f' g' t : ℝ)
    (hf : HasDerivAt f f' t) (hg : HasDerivAt g g' t) :
    HasDerivAt (fun u => WithLp.toLp 2 ![f u, g u]) (WithLp.toLp 2 ![f', g']) t := by
  have hp : HasDerivAt (fun u => ![f u, g u]) ![f', g'] t := by
    apply hasDerivAt_pi.mpr
    intro i
    fin_cases i
    · exact hf
    · exact hg
  exact (PiLp.hasFDerivAt_toLp (𝕜 := ℝ) 2 _).comp_hasDerivAt t hp

theorem keplerPolar_angularVelocity_hasDerivAt (r ω : ℝ → ℝ) (v t : ℝ)
    (hr0 : r t ≠ 0) (hr : HasDerivAt r v t)
    (hL : HasDerivAt (fun u => r u ^ 2 * ω u) 0 t) :
    HasDerivAt ω (-(2 * v * ω t) / r t) t := by
  have hd := hL.div (hr.pow 2) (pow_ne_zero 2 hr0)
  have hω : HasDerivAt ω _ t := hd.congr_of_eventuallyEq (by
    filter_upwards [hr.continuousAt.eventually_ne hr0] with u hu
    change ω u = (r u ^ 2 * ω u) / r u ^ 2
    field_simp [hu])
  convert hω using 1
  norm_num
  field_simp [hr0]

theorem polarCartesianState_momentum_hasDerivAt (r θ v ω : ℝ → ℝ) (t : ℝ)
    (hr0 : 0 < r t) (hr : HasDerivAt r (v t) t) (hθ : HasDerivAt θ (ω t) t)
    (hv : HasDerivAt v (r t * ω t ^ 2 - (r t ^ 2)⁻¹) t)
    (hω : HasDerivAt ω (-(2 * v t * ω t) / r t) t) :
    HasDerivAt (fun u => (polarCartesianState (r u) (θ u) (v u) (ω u)).2)
      (keplerForce (polarCartesianState (r t) (θ t) (v t) (ω t)).1) t := by
  have hc := (Real.hasDerivAt_cos (θ t)).comp t hθ
  have hs := (Real.hasDerivAt_sin (θ t)).comp t hθ
  have hx := (hv.mul hc).sub (((hr.mul hω).mul hs))
  have hy := (hv.mul hs).add (((hr.mul hω).mul hc))
  dsimp only [Function.comp_def, Pi.mul_apply] at hx hy
  have hx' : HasDerivAt (fun u => v u * Real.cos (θ u) - r u * ω u * Real.sin (θ u))
      (-(r t ^ 2)⁻¹ * Real.cos (θ t)) t := by
    convert hx using 1
    field_simp [ne_of_gt hr0]
    ring
  have hy' : HasDerivAt (fun u => v u * Real.sin (θ u) + r u * ω u * Real.cos (θ u))
      (-(r t ^ 2)⁻¹ * Real.sin (θ t)) t := by
    convert hy using 1
    field_simp [ne_of_gt hr0]
    ring
  have hp := hasDerivAt_planarPair _ _ _ _ t hx' hy'
  have heq : WithLp.toLp 2 ![-(r t ^ 2)⁻¹ * Real.cos (θ t), -(r t ^ 2)⁻¹ * Real.sin (θ t)] =
      keplerForce (polarCartesianState (r t) (θ t) (v t) (ω t)).1 := by
    rw [keplerForce, norm_polarCartesianPosition _ _ _ _ hr0.le]
    ext i
    fin_cases i <;> simp [polarCartesianState] <;> field_simp [ne_of_gt hr0]
  rw [heq] at hp
  exact hp

theorem keplerPolarEL_to_cartesianMechanical (I : Set ℝ) (r θ v ω : ℝ → ℝ)
    (h : IsKeplerPolarEulerLagrangeOn I r θ v ω) :
    IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce {q : Position 2 | q ≠ 0} I
      (fun t => polarCartesianState (r t) (θ t) (v t) (ω t)) := by
  have hEL := (keplerPolar_eulerLagrange_iff _ _ _ _ _).mp h
  refine ⟨?_, ?_⟩
  · intro t ht
    have hn := norm_polarCartesianPosition (r t) (θ t) (v t) (ω t) (hEL t ht).1.le
    intro hz
    rw [hz, norm_zero] at hn
    linarith [(hEL t ht).1]
  · intro t ht
    obtain ⟨hpos, hr, hθ, hv, hL⟩ := hEL t ht
    have hω := keplerPolar_angularVelocity_hasDerivAt r ω (v t) t (ne_of_gt hpos) hr hL
    have hp := polarCartesianState_momentum_hasDerivAt r θ v ω t hpos hr hθ hv hω
    obtain ⟨hx, hy⟩ := polarCoordinates_hasDerivAt_components r θ (v t) (ω t) t hr hθ
    have hq := hasDerivAt_planarPair _ _ _ _ t hx hy
    change HasDerivWithinAt (fun t => polarCartesianState (r t) (θ t) (v t) (ω t))
      (mechanicalVectorField (fun _ => (1 : ℝ)) keplerForce
        (polarCartesianState (r t) (θ t) (v t) (ω t))) I t
    rw [mechanicalVectorField, velocityOperator_unit]
    exact (hq.prodMk hp).hasDerivWithinAt

theorem polarCartesianState_force (r θ v ω : ℝ) (hr : 0 < r) :
    keplerForce (polarCartesianState r θ v ω).1 =
      WithLp.toLp 2 ![-(r ^ 2)⁻¹ * Real.cos θ, -(r ^ 2)⁻¹ * Real.sin θ] := by
  rw [keplerForce, norm_polarCartesianPosition _ _ _ _ hr.le]
  ext i
  fin_cases i <;> simp [polarCartesianState] <;> field_simp [ne_of_gt hr]

theorem polarCartesianState_radialVelocity (r θ v ω : ℝ) :
    (polarCartesianState r θ v ω).2 0 * Real.cos θ +
      (polarCartesianState r θ v ω).2 1 * Real.sin θ = v := by
  change (v * Real.cos θ - r * ω * Real.sin θ) * Real.cos θ +
    (v * Real.sin θ + r * ω * Real.cos θ) * Real.sin θ = v
  calc
    _ = v * (Real.cos θ ^ 2 + Real.sin θ ^ 2) := by ring
    _ = _ := by rw [Real.cos_sq_add_sin_sq]; ring

theorem cartesianMechanical_to_keplerPolarEL (I : Set ℝ) (r θ v ω : ℝ → ℝ)
    (hI : IsOpen I)
    (hkin : ∀ t ∈ I, 0 < r t ∧ HasDerivAt r (v t) t ∧ HasDerivAt θ (ω t) t)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce {q : Position 2 | q ≠ 0} I
      (fun t => polarCartesianState (r t) (θ t) (v t) (ω t))) :
    IsKeplerPolarEulerLagrangeOn I r θ v ω := by
  apply (keplerPolar_eulerLagrange_iff _ _ _ _ _).mpr
  intro t ht
  obtain ⟨hpos, hr, hθ⟩ := hkin t ht
  have hp := ((isMechanicalSolutionOn_iff_components _ _ _ _ _ hI).mp hγ).2 t ht |>.2
  have hpx := (EuclideanSpace.proj (𝕜 := ℝ) (0 : Fin 2)).hasFDerivAt.comp_hasDerivAt t hp
  have hpy := (EuclideanSpace.proj (𝕜 := ℝ) (1 : Fin 2)).hasFDerivAt.comp_hasDerivAt t hp
  rw [polarCartesianState_force _ _ _ _ hpos] at hpx hpy
  have hc := (Real.hasDerivAt_cos (θ t)).comp t hθ
  have hs := (Real.hasDerivAt_sin (θ t)).comp t hθ
  have hv := (hpx.mul hc).add (hpy.mul hs)
  have hv' : HasDerivAt v _ t := hv.congr_of_eventuallyEq (by
    exact Filter.Eventually.of_forall (fun u => (polarCartesianState_radialVelocity
      (r u) (θ u) (v u) (ω u)).symm))
  have hvr : HasDerivAt v (r t * ω t ^ 2 - (r t ^ 2)⁻¹) t := by
    convert hv' using 1
    change r t * ω t ^ 2 - (r t ^ 2)⁻¹ =
      (-(r t ^ 2)⁻¹ * Real.cos (θ t)) * Real.cos (θ t) +
        (v t * Real.cos (θ t) - r t * ω t * Real.sin (θ t)) * (-Real.sin (θ t) * ω t) +
      ((-(r t ^ 2)⁻¹ * Real.sin (θ t)) * Real.sin (θ t) +
        (v t * Real.sin (θ t) + r t * ω t * Real.cos (θ t)) * (Real.cos (θ t) * ω t))
    symm
    calc
      _ = (r t * ω t ^ 2 - (r t ^ 2)⁻¹) *
          (Real.cos (θ t) ^ 2 + Real.sin (θ t) ^ 2) := by ring
      _ = _ := by rw [Real.cos_sq_add_sin_sq]; ring
  have hL := planarAngularMomentum_hasDerivAt_zero keplerForce _ I
    (fun t => polarCartesianState (r t) (θ t) (v t) (ω t)) hI hγ
    (fun q _ => centralForce_planarTorque_zero (fun q => -(‖q‖ ^ 3)⁻¹) q) t ht
  have hL' : HasDerivAt (fun u => r u ^ 2 * ω u) 0 t := by
    have heq : (fun u => r u ^ 2 * ω u) =
        (fun u => planarAngularMomentum (polarCartesianState (r u) (θ u) (v u) (ω u))) := by
      funext u
      exact (polarCartesianState_angular _ _ _ _).symm
    rw [heq]
    exact hL
  exact ⟨hpos, hr, hθ, hvr, hL'⟩

theorem keplerPolarEL_iff_cartesianMechanical (I : Set ℝ) (r θ v ω : ℝ → ℝ)
    (hI : IsOpen I)
    (hkin : ∀ t ∈ I, 0 < r t ∧ HasDerivAt r (v t) t ∧ HasDerivAt θ (ω t) t) :
    IsKeplerPolarEulerLagrangeOn I r θ v ω ↔
      IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce {q : Position 2 | q ≠ 0} I
        (fun t => polarCartesianState (r t) (θ t) (v t) (ω t)) :=
  ⟨keplerPolarEL_to_cartesianMechanical I r θ v ω,
    cartesianMechanical_to_keplerPolarEL I r θ v ω hI hkin⟩

end MolecularDynamics
