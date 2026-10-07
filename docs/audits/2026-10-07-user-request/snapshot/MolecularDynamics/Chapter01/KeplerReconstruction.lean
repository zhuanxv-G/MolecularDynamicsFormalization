import MolecularDynamics.Chapter01.KeplerCartesianBridge
import Mathlib.Analysis.SpecialFunctions.Complex.Arg

/-! Printed29--30/PDF52--53: actual radial IVPs and Kepler reconstruction.
The angle is a genuine interval integral. Every nonzero Cartesian initial
position has a proved polar representation, then a reconstructed local IVP. -/

open Set Filter
open scoped Topology
namespace MolecularDynamics

noncomputable def keplerReconstructedAngle (l t₀ θ₀ : ℝ) (r : ℝ → ℝ) (t : ℝ) : ℝ :=
  θ₀ + ∫ u in t₀..t, l / r u ^ 2

theorem keplerReconstructedAngle_initial (l t₀ θ₀ : ℝ) (r : ℝ → ℝ) :
    keplerReconstructedAngle l t₀ θ₀ r t₀ = θ₀ := by
  simp [keplerReconstructedAngle]

theorem keplerReconstructedAngle_hasDerivAt (l a b t₀ θ₀ : ℝ) (r v : ℝ → ℝ)
    (ht₀ : t₀ ∈ Ioo a b)
    (hr : ∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t)
    (t : ℝ) (ht : t ∈ Ioo a b) :
    HasDerivAt (keplerReconstructedAngle l t₀ θ₀ r) (l / r t ^ 2) t := by
  have hc : ∀ u ∈ Ioo a b, ContinuousAt (fun u => l / r u ^ 2) u := by
    intro u hu
    exact continuousAt_const.div ((hr u hu).2.continuousAt.pow 2)
      (pow_ne_zero 2 (ne_of_gt (hr u hu).1))
  have hcont : ContinuousOn (fun u => l / r u ^ 2) (Ioo a b) :=
    fun u hu => (hc u hu).continuousWithinAt
  have hseg : uIcc t₀ t ⊆ Ioo a b := ordConnected_Ioo.uIcc_subset ht₀ ht
  exact (intervalIntegral.integral_hasDerivAt_right
    ((hcont.mono hseg).intervalIntegrable)
    (hcont.stronglyMeasurableAtFilter isOpen_Ioo t ht) (hc t ht)).const_add θ₀

theorem keplerRadial_reconstruction_isEulerLagrange (l a b t₀ θ₀ : ℝ) (r v : ℝ → ℝ)
    (ht₀ : t₀ ∈ Ioo a b)
    (h : ∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
      HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t) :
    IsKeplerPolarEulerLagrangeOn (Ioo a b) r
      (keplerReconstructedAngle l t₀ θ₀ r) v (fun t => l / r t ^ 2) := by
  apply (keplerPolar_eulerLagrange_iff _ _ _ _ _).mpr
  intro t ht
  obtain ⟨hpos, hr, hv⟩ := h t ht
  have hn : r t ≠ 0 := ne_of_gt hpos
  have heq : r t * (l / r t ^ 2) ^ 2 - (r t ^ 2)⁻¹ =
      -(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3 := by
    field_simp [hn]
    ring
  have hv' : HasDerivAt v (r t * (l / r t ^ 2) ^ 2 - (r t ^ 2)⁻¹) t := by
    rw [heq]
    exact hv
  have hL : HasDerivAt (fun u => r u ^ 2 * (l / r u ^ 2)) 0 t := by
    apply (hasDerivAt_const t l).congr_of_eventuallyEq
    filter_upwards [hr.continuousAt.eventually_ne hn] with u hu
    field_simp [hu]
  exact ⟨hpos, hr, keplerReconstructedAngle_hasDerivAt l a b t₀ θ₀ r v ht₀
    (fun u hu => ⟨(h u hu).1, (h u hu).2.1⟩) t ht, hv', hL⟩

theorem keplerRadial_reconstruction_isMechanical (l a b t₀ θ₀ : ℝ) (r v : ℝ → ℝ)
    (ht₀ : t₀ ∈ Ioo a b)
    (h : ∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
      HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t) :
    IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce {q : Position 2 | q ≠ 0}
      (Ioo a b) (fun t => polarCartesianState (r t)
        (keplerReconstructedAngle l t₀ θ₀ r t) (v t) (l / r t ^ 2)) :=
  keplerPolarEL_to_cartesianMechanical _ _ _ _ _
    (keplerRadial_reconstruction_isEulerLagrange l a b t₀ θ₀ r v ht₀ h)

noncomputable def keplerRadialForce (l : ℝ) (q : Position 1) : Position 1 :=
  WithLp.toLp 2 ![-(q 0 ^ 2)⁻¹ + l ^ 2 / q 0 ^ 3]

theorem keplerRadialForce_contDiffAt (l : ℝ) (q : Position 1) (hq : q 0 ≠ 0) :
    ContDiffAt ℝ 1 (keplerRadialForce l) q := by
  have hp : ContDiffAt ℝ 1 (fun q : Position 1 => q 0) q :=
    (EuclideanSpace.proj (𝕜 := ℝ) (0 : Fin 1)).contDiff.contDiffAt
  apply contDiffAt_euclidean.mpr
  intro i
  fin_cases i
  exact ((hp.pow 2).inv (pow_ne_zero 2 hq)).neg.add
    (contDiffAt_const.div (hp.pow 3) (pow_ne_zero 3 hq))

theorem exists_keplerRadial_localIVP (l t₀ r₀ v₀ : ℝ) (hr₀ : 0 < r₀) :
    ∃ (ε : ℝ) (r v : ℝ → ℝ), 0 < ε ∧ r t₀ = r₀ ∧ v t₀ = v₀ ∧
      ∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), 0 < r t ∧ HasDerivAt r (v t) t ∧
        HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t := by
  let z₀ : PhaseSpace 1 := (WithLp.toLp 2 ![r₀], WithLp.toLp 2 ![v₀])
  have hQ : IsOpen {q : Position 1 | 0 < q 0} :=
    isOpen_lt continuous_const (EuclideanSpace.proj (𝕜 := ℝ) (0 : Fin 1)).continuous
  obtain ⟨ε, γ, hγ⟩ := exists_localMechanicalIVP_open_of_force_contDiffAt
    (fun _ => (1 : ℝ)) (keplerRadialForce l) _ hQ t₀ z₀ hr₀
    (keplerRadialForce_contDiffAt l z₀.1 (ne_of_gt hr₀))
  refine ⟨ε, (fun t => (γ t).1 0), (fun t => (γ t).2 0), hγ.1, ?_, ?_, ?_⟩
  · change (γ t₀).1 0 = r₀
    rw [hγ.2.1]
    rfl
  · change (γ t₀).2 0 = v₀
    rw [hγ.2.1]
    rfl
  · intro t ht
    have hc := ((isMechanicalSolutionOn_iff_components _ _ _ _ _ isOpen_Ioo).mp hγ.2.2).2 t ht
    rw [velocityOperator_unit] at hc
    have hr := (EuclideanSpace.proj (𝕜 := ℝ) (0 : Fin 1)).hasFDerivAt.comp_hasDerivAt t hc.1
    have hv := (EuclideanSpace.proj (𝕜 := ℝ) (0 : Fin 1)).hasFDerivAt.comp_hasDerivAt t hc.2
    exact ⟨hγ.2.2.1 t ht, hr, hv⟩

theorem exists_keplerRadial_reconstructed_localIVP (l t₀ r₀ θ₀ v₀ : ℝ) (hr₀ : 0 < r₀) :
    ∃ (ε : ℝ) (r v : ℝ → ℝ), 0 < ε ∧ r t₀ = r₀ ∧ v t₀ = v₀ ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), 0 < r t ∧ HasDerivAt r (v t) t ∧
        HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t) ∧
      IsLocalMechanicalIVP (fun _ => (1 : ℝ)) keplerForce {q : Position 2 | q ≠ 0}
        t₀ (polarCartesianState r₀ θ₀ v₀ (l / r₀ ^ 2)) ε
        (fun t => polarCartesianState (r t) (keplerReconstructedAngle l t₀ θ₀ r t)
          (v t) (l / r t ^ 2)) := by
  obtain ⟨ε, r, v, hε, hr, hv, h⟩ := exists_keplerRadial_localIVP l t₀ r₀ v₀ hr₀
  have ht₀ : t₀ ∈ Ioo (t₀ - ε) (t₀ + ε) := by constructor <;> linarith
  refine ⟨ε, r, v, hε, hr, hv, h, hε, ?_, ?_⟩
  · change polarCartesianState (r t₀) (keplerReconstructedAngle l t₀ θ₀ r t₀)
      (v t₀) (l / r t₀ ^ 2) = _
    rw [hr, hv, keplerReconstructedAngle_initial]
  · exact keplerRadial_reconstruction_isMechanical l _ _ t₀ θ₀ r v ht₀ h

theorem exists_polarCartesian_initialRepresentation (z : PhaseSpace 2) (hz : z.1 ≠ 0) :
    ∃ r θ v : ℝ, 0 < r ∧
      polarCartesianState r θ v (planarAngularMomentum z / r ^ 2) = z := by
  let c : ℂ := ⟨z.1 0, z.1 1⟩
  have hc : c ≠ 0 := by
    intro hc
    apply hz
    ext i
    fin_cases i
    · simpa [c] using congrArg Complex.re hc
    · simpa [c] using congrArg Complex.im hc
  let r := ‖c‖
  let θ := Complex.arg c
  let v := z.2 0 * Real.cos θ + z.2 1 * Real.sin θ
  have hr : 0 < r := norm_pos_iff.mpr hc
  have hqx : r * Real.cos θ = z.1 0 := Complex.norm_mul_cos_arg c
  have hqy : r * Real.sin θ = z.1 1 := Complex.norm_mul_sin_arg c
  have hl : planarAngularMomentum z =
      r * Real.cos θ * z.2 1 - r * Real.sin θ * z.2 0 := by
    rw [hqx, hqy]
    rfl
  refine ⟨r, θ, v, hr, ?_⟩
  apply Prod.ext
  · ext i
    fin_cases i
    · exact hqx
    · exact hqy
  · ext i
    fin_cases i
    · change v * Real.cos θ - r * (planarAngularMomentum z / r ^ 2) * Real.sin θ = z.2 0
      rw [hl]
      dsimp [v]
      calc
        _ = z.2 0 * (Real.cos θ ^ 2 + Real.sin θ ^ 2) := by
          field_simp [ne_of_gt hr]
          ring
        _ = _ := by rw [Real.cos_sq_add_sin_sq]; ring
    · change v * Real.sin θ + r * (planarAngularMomentum z / r ^ 2) * Real.cos θ = z.2 1
      rw [hl]
      dsimp [v]
      calc
        _ = z.2 1 * (Real.cos θ ^ 2 + Real.sin θ ^ 2) := by
          field_simp [ne_of_gt hr]
          ring
        _ = _ := by rw [Real.cos_sq_add_sin_sq]; ring

theorem exists_kepler_localIVP_radialReconstruction (t₀ : ℝ) (z₀ : PhaseSpace 2) (hz : z₀.1 ≠ 0) :
    ∃ (r₀ θ₀ v₀ ε : ℝ) (r v : ℝ → ℝ), 0 < r₀ ∧ 0 < ε ∧ r t₀ = r₀ ∧ v t₀ = v₀ ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), 0 < r t ∧ HasDerivAt r (v t) t ∧
        HasDerivAt v (-(r t ^ 2)⁻¹ + (planarAngularMomentum z₀) ^ 2 / r t ^ 3) t) ∧
      IsLocalMechanicalIVP (fun _ => (1 : ℝ)) keplerForce {q : Position 2 | q ≠ 0}
        t₀ z₀ ε (fun t => polarCartesianState (r t)
          (keplerReconstructedAngle (planarAngularMomentum z₀) t₀ θ₀ r t)
          (v t) (planarAngularMomentum z₀ / r t ^ 2)) := by
  obtain ⟨r₀, θ₀, v₀, hr₀, hinit⟩ := exists_polarCartesian_initialRepresentation z₀ hz
  obtain ⟨ε, r, v, hε, hr, hv, hradial, hIVP⟩ :=
    exists_keplerRadial_reconstructed_localIVP (planarAngularMomentum z₀) t₀ r₀ θ₀ v₀ hr₀
  rw [hinit] at hIVP
  exact ⟨r₀, θ₀, v₀, ε, r, v, hr₀, hε, hr, hv, hradial, hIVP⟩

end MolecularDynamics
