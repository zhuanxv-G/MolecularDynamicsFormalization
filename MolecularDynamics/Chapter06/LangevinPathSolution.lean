import MolecularDynamics.Chapter06.LangevinDrivenExistence
import Mathlib.Topology.ContinuousMap.Compact
import Mathlib.MeasureTheory.Constructions.BorelSpace.ContinuousMap

/-! Actual solution selection and endpoint continuity, needed to construct the Langevin random model. -/

open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal

namespace MolecularDynamics

/-- Center a genuine continuous driving path at zero and extend it by the actual interval projection. -/
noncomputable def textbookLangevinPathNoise {Nc : ℕ} (T : ℝ) (hT : 0 ≤ T)
    (W : C(Icc 0 T, Fin Nc → ℝ)) (t : ℝ) : Fin Nc → ℝ :=
  W (projIcc 0 T hT t) - W ⟨0, le_rfl, hT⟩

/-- The centered actual interval extension is continuous on all real times. -/
theorem textbookLangevinPathNoise_continuous {Nc : ℕ} (T : ℝ) (hT : 0 ≤ T)
    (W : C(Icc 0 T, Fin Nc → ℝ)) : Continuous (textbookLangevinPathNoise T hT W) :=
  (W.continuous.comp continuous_projIcc).sub continuous_const

/-- The genuine centered noise starts at zero. -/
theorem textbookLangevinPathNoise_zero {Nc : ℕ} (T : ℝ) (hT : 0 ≤ T)
    (W : C(Icc 0 T, Fin Nc → ℝ)) : textbookLangevinPathNoise T hT W 0 = 0 := by
  simp [textbookLangevinPathNoise, projIcc_left]

private theorem actual_path_solution_exists {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPhase Nc) (W : C(Icc 0 T, Fin Nc → ℝ)) :
    ∃ qp : (ℝ → (Fin Nc → ℝ)) × (ℝ → (Fin Nc → ℝ)),
      textbookLangevinIntegralSolution U γ σ T x (textbookLangevinPathNoise T hT W) qp.1 qp.2 := by
  obtain ⟨q, p, h⟩ := textbookLangevinIntegralSolution_exists_globalLip U L hF γ σ T hT x
    (textbookLangevinPathNoise T hT W) (textbookLangevinPathNoise_continuous T hT W).continuousOn
    (textbookLangevinPathNoise_zero T hT W)
  exact ⟨(q, p), h⟩

/-- Select a true existing solution of the original integral equations for a genuine continuous noise path. -/
noncomputable def textbookLangevinPathSolution {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPhase Nc) (W : C(Icc 0 T, Fin Nc → ℝ)) :
    (ℝ → (Fin Nc → ℝ)) × (ℝ → (Fin Nc → ℝ)) :=
  Classical.choose (actual_path_solution_exists U L hF γ σ T hT x W)

/-- The selected functions satisfy the actual additive-noise integral equations. -/
theorem textbookLangevinPathSolution_integralSolution {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPhase Nc) (W : C(Icc 0 T, Fin Nc → ℝ)) :
    textbookLangevinIntegralSolution U γ σ T x (textbookLangevinPathNoise T hT W)
      (textbookLangevinPathSolution U L hF γ σ T hT x W).1
      (textbookLangevinPathSolution U L hF γ σ T hT x W).2 :=
  Classical.choose_spec (actual_path_solution_exists U L hF γ σ T hT x W)

/-- Evaluate the actual selected solution in the original phase coordinates. -/
noncomputable def textbookLangevinPathEndpoint {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPhase Nc) (t : ℝ)
    (W : C(Icc 0 T, Fin Nc → ℝ)) : textbookLangevinPhase Nc :=
  ((textbookLangevinPathSolution U L hF γ σ T hT x W).1 t,
    (textbookLangevinPathSolution U L hF γ σ T hT x W).2 t)

private theorem centered_noise_dist {Nc : ℕ} (T : ℝ) (hT : 0 ≤ T)
    (W R : C(Icc 0 T, Fin Nc → ℝ)) (t : ℝ) :
    ‖textbookLangevinPathNoise T hT W t - textbookLangevinPathNoise T hT R t‖ ≤ 2 * dist W R := by
  let ξ := projIcc 0 T hT t
  let ζ : Icc 0 T := ⟨0, le_rfl, hT⟩
  have he : textbookLangevinPathNoise T hT W t - textbookLangevinPathNoise T hT R t =
      (W ξ - R ξ) - (W ζ - R ζ) := by dsimp [textbookLangevinPathNoise, ξ, ζ]; abel
  rw [he]
  have hb (s : Icc 0 T) : ‖W s - R s‖ ≤ dist W R := by
    simpa only [dist_eq_norm] using ContinuousMap.dist_apply_le_dist (f := W) (g := R) s
  calc
    _ ≤ ‖W ξ - R ξ‖ + ‖W ζ - R ζ‖ := norm_sub_le _ _
    _ ≤ dist W R + dist W R := add_le_add (hb ξ) (hb ζ)
    _ = 2 * dist W R := by ring

/-- Actual Gronwall dependence proves that each chosen endpoint is Lipschitz in the genuine uniform path metric. -/
theorem textbookLangevinPathEndpoint_lipschitz {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hT : 0 ≤ T)
    (x : textbookLangevinPhase Nc) (t : ℝ) (ht : t ∈ Icc 0 T) :
    ∃ C : ℝ≥0, LipschitzWith C (textbookLangevinPathEndpoint U L hF γ σ T hT x t) := by
  let K : ℝ := 1 + (L : ℝ) + ‖γ‖
  have hK : 0 < K := by dsimp only [K]; positivity
  have hexp : 0 ≤ Real.exp (K * t) - 1 := by
    exact sub_nonneg.mpr (Real.one_le_exp_iff.mpr (mul_nonneg hK.le ht.1))
  let C : ℝ := 2 * ((1 + ‖γ‖) * ‖σ‖ / K * (Real.exp (K * t) - 1) + ‖σ‖)
  have hC : 0 ≤ C := by dsimp [C]; positivity
  refine ⟨⟨C, hC⟩, LipschitzWith.of_dist_le_mul (fun W R ↦ ?_)⟩
  let q := textbookLangevinPathSolution U L hF γ σ T hT x W
  let r := textbookLangevinPathSolution U L hF γ σ T hT x R
  have hq := textbookLangevinPathSolution_integralSolution U L hF γ σ T hT x W
  have hr := textbookLangevinPathSolution_integralSolution U L hF γ σ T hT x R
  have hb := textbookLangevinNoise_phase_dist_le U hU L hF γ σ T (2 * dist W R) hT
    (by positivity) x (textbookLangevinPathNoise T hT W) (textbookLangevinPathNoise T hT R)
    q.1 q.2 r.1 r.2 hq hr (fun s _ ↦ centered_noise_dist T hT W R s) t ht
  change dist (q.1 t, q.2 t) (r.1 t, r.2 t) ≤
    gronwallBound 0 K ((1 + ‖γ‖) * ‖σ‖ * (2 * dist W R)) t + ‖σ‖ * (2 * dist W R) at hb
  rw [gronwallBound_of_K_ne_0 hK.ne'] at hb
  simp only [zero_mul, zero_add] at hb
  change dist (q.1 t, q.2 t) (r.1 t, r.2 t) ≤ C * dist W R
  calc
    _ ≤ (1 + ‖γ‖) * ‖σ‖ * (2 * dist W R) / K * (Real.exp (K * t) - 1) +
        ‖σ‖ * (2 * dist W R) := hb
    _ = C * dist W R := by dsimp [C]; ring

/-- The true solution endpoint map is continuous, with no supplied continuity premise. -/
theorem textbookLangevinPathEndpoint_continuous {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hT : 0 ≤ T)
    (x : textbookLangevinPhase Nc) (t : ℝ) (ht : t ∈ Icc 0 T) :
    Continuous (textbookLangevinPathEndpoint U L hF γ σ T hT x t) := by
  obtain ⟨C, hC⟩ := textbookLangevinPathEndpoint_lipschitz U hU L hF γ σ T hT x t ht
  exact hC.continuous

/-- Two true integral solutions with the same driving path and initial phase agree on the whole actual interval. -/
theorem textbookLangevinIntegralSolution_unique_globalLip {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hT : 0 ≤ T)
    (x : textbookLangevinPhase Nc) (W q p qr pr : ℝ → (Fin Nc → ℝ))
    (h : textbookLangevinIntegralSolution U γ σ T x W q p)
    (hr : textbookLangevinIntegralSolution U γ σ T x W qr pr) :
    ∀ t ∈ Icc 0 T, (q t, p t) = (qr t, pr t) := by
  intro t ht
  have hb := textbookLangevinNoise_phase_dist_le U hU L hF γ σ T 0 hT le_rfl x
    W W q p qr pr h hr (fun _ _ ↦ by simp) t ht
  simpa only [mul_zero, gronwallBound_ε0_δ0, add_zero, dist_le_zero] using hb

end MolecularDynamics
