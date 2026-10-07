import MolecularDynamics.Chapter06.BrownianDrivenExistence
import MolecularDynamics.Chapter06.LangevinPathSolution
import Mathlib.Analysis.ODE.Gronwall

/-! Actual original-mass Brownian integral paths, uniqueness and measurable endpoint construction.
Only the deterministic path carrier is reused from Langevin; the equation here is the original
first-order Brownian equation. Identification of its stochastic law with the spectral operator
and the textbook C2/core reconciliation remain separate. -/

open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal

namespace MolecularDynamics
noncomputable section

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

/-- The actual original-mass integral equation, using genuine centered noise increments. -/
def textbookBrownianIntegralSolution (T : ℝ) (x : Fin Nc → ℝ)
    (W q : ℝ → (Fin Nc → ℝ)) : Prop :=
  ContinuousOn q (Icc 0 T) ∧ ContinuousOn W (Icc 0 T) ∧
    ∀ t ∈ Icc 0 T, q t = x + (∫ s in 0..t, textbookBrownianSDEDrift m U (q s)) +
      textbookBrownianSDENoise m β (W t - W 0)

include hm hU hPU hβ in
/-- Actual existence is inherited from the constructed integral solution, without a supplied solution premise. -/
theorem textbookBrownianIntegralSolution_exists_model (T : ℝ) (hT : 0 ≤ T)
    (x : Fin Nc → ℝ) (W : ℝ → (Fin Nc → ℝ)) (hW : ContinuousOn W (Icc 0 T)) :
    ∃ q : ℝ → (Fin Nc → ℝ), textbookBrownianIntegralSolution m U β T x W q := by
  obtain ⟨q, hq, _, he, _⟩ :=
    textbookBrownianIntegralSolution_exists m hm U hU hPU β hβ T hT x W hW
  exact ⟨q, hq, hW, he⟩

/-- Subtract the actual additive noise; no differentiability of the noise is assumed. -/
def textbookBrownianNoiseCompensated (W q : ℝ → (Fin Nc → ℝ)) (t : ℝ) : Fin Nc → ℝ :=
  q t - textbookBrownianSDENoise m β (W t - W 0)

private theorem integral_right_derivative {Nc : ℕ} {T : ℝ}
    (f f' : ℝ → (Fin Nc → ℝ)) (a : Fin Nc → ℝ)
    (hc : ContinuousOn f' (Icc 0 T))
    (he : ∀ t ∈ Icc 0 T, f t = a + ∫ s in 0..t, f' s)
    (t : ℝ) (ht : t ∈ Ico 0 T) : HasDerivWithinAt f (f' t) (Ici t) t := by
  have hm : t ∈ Icc 0 T := Ico_subset_Icc_self ht
  have hseg : uIcc 0 t ⊆ Icc 0 T := by
    rw [uIcc_of_le ht.1]
    exact Icc_subset_Icc le_rfl ht.2.le
  have hfact : Fact (t ∈ Icc 0 T) := ⟨hm⟩
  have hd := intervalIntegral.integral_hasDerivWithinAt_right
    (s := Icc 0 T) (t := Icc 0 T) ((hc.mono hseg).intervalIntegrable)
    (hc.stronglyMeasurableAtFilter_nhdsWithin measurableSet_Icc t) (hc t hm)
  have hneigh : Icc 0 T ∈ 𝓝[Ici t] t := by
    filter_upwards [self_mem_nhdsWithin, nhdsWithin_le_nhds (Iio_mem_nhds ht.2)] with s hs hTs
    exact ⟨ht.1.trans hs, hTs.le⟩
  exact ((hd.const_add a).congr_of_mem he hm).mono_of_mem_nhdsWithin hneigh



/-- Compensation preserves genuine continuity on the specified interval. -/
theorem textbookBrownianNoiseCompensated_continuousOn (T : ℝ) (x : Fin Nc → ℝ)
    (W q : ℝ → (Fin Nc → ℝ)) (h : textbookBrownianIntegralSolution m U β T x W q) :
    ContinuousOn (textbookBrownianNoiseCompensated m β W q) (Icc 0 T) :=
  h.1.fun_sub ((textbookBrownianSDENoise m β).continuous.comp_continuousOn
    (h.2.1.fun_sub continuousOn_const))

include hU hPU in
/-- The true integral equation gives actual compensated right derivatives even for rough noise. -/
theorem textbookBrownianNoiseCompensated_hasDerivWithinAt (T : ℝ) (x : Fin Nc → ℝ)
    (W q : ℝ → (Fin Nc → ℝ)) (h : textbookBrownianIntegralSolution m U β T x W q)
    (t : ℝ) (ht : t ∈ Ico 0 T) :
    HasDerivWithinAt (textbookBrownianNoiseCompensated m β W q)
      (textbookBrownianDrivenField m U β W t (textbookBrownianNoiseCompensated m β W q t))
      (Ici t) t := by
  obtain ⟨L, hL⟩ := textbookBrownianSDEDrift_lipschitz m U hU hPU
  have hc := hL.continuous.comp_continuousOn h.1
  have he (s : ℝ) (hs : s ∈ Icc 0 T) :
      textbookBrownianNoiseCompensated m β W q s =
        x + ∫ r in 0..s, textbookBrownianSDEDrift m U (q r) := by
    dsimp [textbookBrownianNoiseCompensated]
    rw [h.2.2 s hs]
    abel
  have hd := integral_right_derivative (textbookBrownianNoiseCompensated m β W q)
    (fun s ↦ textbookBrownianSDEDrift m U (q s)) x hc he t ht
  simpa only [textbookBrownianDrivenField, textbookBrownianNoiseCompensated,
    sub_add_cancel] using hd

/-- The actual original initial configuration follows from the integral equation. -/
theorem textbookBrownianIntegralSolution_initial (T : ℝ) (hT : 0 ≤ T) (x : Fin Nc → ℝ)
    (W q : ℝ → (Fin Nc → ℝ)) (h : textbookBrownianIntegralSolution m U β T x W q) :
    q 0 = x := by
  simpa only [intervalIntegral.integral_same, sub_self, map_zero, add_zero]
    using h.2.2 0 ⟨le_rfl, hT⟩

/-- The compensated initial value is the true original initial configuration. -/
theorem textbookBrownianNoiseCompensated_initial (T : ℝ) (hT : 0 ≤ T) (x : Fin Nc → ℝ)
    (W q : ℝ → (Fin Nc → ℝ)) (h : textbookBrownianIntegralSolution m U β T x W q) :
    textbookBrownianNoiseCompensated m β W q 0 = x := by
  simp only [textbookBrownianNoiseCompensated, sub_self, map_zero, sub_zero,
    textbookBrownianIntegralSolution_initial m U β T hT x W q h]

/-- Actual integral solutions restrict to every shorter specified interval. -/
theorem textbookBrownianIntegralSolution_restrict (A T : ℝ) (hTA : T ≤ A)
    (x : Fin Nc → ℝ) (W q : ℝ → (Fin Nc → ℝ))
    (h : textbookBrownianIntegralSolution m U β A x W q) :
    textbookBrownianIntegralSolution m U β T x W q := by
  have hs : Icc (0 : ℝ) T ⊆ Icc 0 A := Icc_subset_Icc le_rfl hTA
  exact ⟨h.1.mono hs, h.2.1.mono hs, fun t ht ↦ h.2.2 t (hs ht)⟩

/-- Fix a genuine drift Lipschitz constant derived from the original smooth periodic potential. -/
def textbookBrownianDriftLipschitzConstant : ℝ≥0 :=
  Classical.choose (textbookBrownianSDEDrift_lipschitz m U hU hPU)

/-- The chosen constant is certified for the actual drift. -/
theorem textbookBrownianDriftLipschitzConstant_spec :
    LipschitzWith (textbookBrownianDriftLipschitzConstant m U hU hPU)
      (textbookBrownianSDEDrift m U) :=
  Classical.choose_spec (textbookBrownianSDEDrift_lipschitz m U hU hPU)

private theorem actual_field_lipschitz (W : ℝ → (Fin Nc → ℝ)) (t : ℝ) :
    LipschitzWith (1 + textbookBrownianDriftLipschitzConstant m U hU hPU)
      (textbookBrownianDrivenField m U β W t) := by
  apply LipschitzWith.of_dist_le_mul
  intro x y
  let c := textbookBrownianSDENoise m β (W t - W 0)
  have hd := (textbookBrownianDriftLipschitzConstant_spec m U hU hPU).dist_le_mul (x + c) (y + c)
  rw [dist_add_right] at hd
  change dist (textbookBrownianSDEDrift m U (x + c))
    (textbookBrownianSDEDrift m U (y + c)) ≤
      (1 + (textbookBrownianDriftLipschitzConstant m U hU hPU : ℝ)) * dist x y
  exact hd.trans (by nlinarith [dist_nonneg (x := x) (y := y)])

/-- Actual noise increments give a genuine operator norm error bound. -/
theorem textbookBrownianNoiseIncrement_dist_le (W R : ℝ → (Fin Nc → ℝ))
    (t ε : ℝ) (hWR : ‖(W t - W 0) - (R t - R 0)‖ ≤ ε) :
    ‖textbookBrownianSDENoise m β (W t - W 0) -
      textbookBrownianSDENoise m β (R t - R 0)‖ ≤ ‖textbookBrownianSDENoise m β‖ * ε := by
  rw [← map_sub]
  exact ((textbookBrownianSDENoise m β).le_opNorm _).trans
    (mul_le_mul_of_nonneg_left hWR (norm_nonneg _))

/-- The true original drift gives the noise-field error, rather than assuming an error estimate. -/
theorem textbookBrownianDrivenField_noise_dist_le (W R : ℝ → (Fin Nc → ℝ))
    (t ε : ℝ) (hWR : ‖(W t - W 0) - (R t - R 0)‖ ≤ ε) (z : Fin Nc → ℝ) :
    dist (textbookBrownianDrivenField m U β W t z)
      (textbookBrownianDrivenField m U β R t z) ≤
      (textbookBrownianDriftLipschitzConstant m U hU hPU : ℝ) *
        ‖textbookBrownianSDENoise m β‖ * ε := by
  let L : ℝ≥0 := textbookBrownianDriftLipschitzConstant m U hU hPU
  calc
    _ ≤ (L : ℝ) * dist
        (z + textbookBrownianSDENoise m β (W t - W 0))
        (z + textbookBrownianSDENoise m β (R t - R 0)) :=
      (textbookBrownianDriftLipschitzConstant_spec m U hU hPU).dist_le_mul _ _
    _ = (L : ℝ) * ‖textbookBrownianSDENoise m β (W t - W 0) -
        textbookBrownianSDENoise m β (R t - R 0)‖ := by rw [dist_add_left, dist_eq_norm]
    _ ≤ (L : ℝ) * (‖textbookBrownianSDENoise m β‖ * ε) :=
      mul_le_mul_of_nonneg_left (textbookBrownianNoiseIncrement_dist_le m β W R t ε hWR) L.property
    _ = (textbookBrownianDriftLipschitzConstant m U hU hPU : ℝ) *
        ‖textbookBrownianSDENoise m β‖ * ε := by dsimp [L]; ring

/-- Actual compensated solutions depend on both the true initial state and the noise increments. -/
theorem textbookBrownianNoiseCompensated_dist_le (T ε : ℝ) (hT : 0 ≤ T)
    (x y : Fin Nc → ℝ) (W R q r : ℝ → (Fin Nc → ℝ))
    (hq : textbookBrownianIntegralSolution m U β T x W q)
    (hr : textbookBrownianIntegralSolution m U β T y R r)
    (htube : ∀ s ∈ Icc 0 T, ‖(W s - W 0) - (R s - R 0)‖ ≤ ε)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    dist (textbookBrownianNoiseCompensated m β W q t)
      (textbookBrownianNoiseCompensated m β R r t) ≤
      gronwallBound (dist x y)
        (1 + (textbookBrownianDriftLipschitzConstant m U hU hPU : ℝ))
        ((textbookBrownianDriftLipschitzConstant m U hU hPU : ℝ) *
          ‖textbookBrownianSDENoise m β‖ * ε) t := by
  have hw' := textbookBrownianNoiseCompensated_hasDerivWithinAt m U hU hPU β T x W q hq
  have hr' := textbookBrownianNoiseCompensated_hasDerivWithinAt m U hU hPU β T y R r hr
  have hw_bound (s : ℝ) (hs : s ∈ Ico 0 T) :=
    textbookBrownianDrivenField_noise_dist_le m U hU hPU β W R s ε
      (htube s (Ico_subset_Icc_self hs)) (textbookBrownianNoiseCompensated m β W q s)
  have hr_bound (s : ℝ) (_ : s ∈ Ico 0 T) :
      dist (textbookBrownianDrivenField m U β R s (textbookBrownianNoiseCompensated m β R r s))
        (textbookBrownianDrivenField m U β R s (textbookBrownianNoiseCompensated m β R r s)) ≤ 0 := by
    simp only [dist_self, le_refl]
  have hh := dist_le_of_approx_trajectories_ODE
    (fun s ↦ actual_field_lipschitz m U hU hPU β R s)
    (textbookBrownianNoiseCompensated_continuousOn m U β T x W q hq) hw' hw_bound
    (textbookBrownianNoiseCompensated_continuousOn m U β T y R r hr) hr' hr_bound
    (by rw [textbookBrownianNoiseCompensated_initial m U β T hT x W q hq,
      textbookBrownianNoiseCompensated_initial m U β T hT y R r hr]) t ht
  simpa only [NNReal.coe_add, NNReal.coe_one, add_zero, sub_zero] using hh

/-- The original uncompensated paths satisfy a genuine perturbation estimate. -/
theorem textbookBrownianIntegralSolution_dist_le (T ε : ℝ) (hT : 0 ≤ T)
    (x y : Fin Nc → ℝ) (W R q r : ℝ → (Fin Nc → ℝ))
    (hq : textbookBrownianIntegralSolution m U β T x W q)
    (hr : textbookBrownianIntegralSolution m U β T y R r)
    (htube : ∀ s ∈ Icc 0 T, ‖(W s - W 0) - (R s - R 0)‖ ≤ ε)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    dist (q t) (r t) ≤
      gronwallBound (dist x y)
        (1 + (textbookBrownianDriftLipschitzConstant m U hU hPU : ℝ))
        ((textbookBrownianDriftLipschitzConstant m U hU hPU : ℝ) *
          ‖textbookBrownianSDENoise m β‖ * ε) t + ‖textbookBrownianSDENoise m β‖ * ε := by
  have hg := textbookBrownianNoiseCompensated_dist_le m U hU hPU β T ε hT x y W R q r hq hr htube t ht
  rw [dist_eq_norm] at hg
  have he : q t - r t =
      (textbookBrownianNoiseCompensated m β W q t - textbookBrownianNoiseCompensated m β R r t) +
        (textbookBrownianSDENoise m β (W t - W 0) - textbookBrownianSDENoise m β (R t - R 0)) := by
    dsimp [textbookBrownianNoiseCompensated]
    abel
  rw [dist_eq_norm, he]
  exact (norm_add_le _ _).trans
    (add_le_add hg (textbookBrownianNoiseIncrement_dist_le m β W R t ε (htube t ht)))

include hU hPU in
/-- Same true initial state and same noise imply equality on the whole specified interval. -/
theorem textbookBrownianIntegralSolution_unique (T : ℝ) (hT : 0 ≤ T)
    (x : Fin Nc → ℝ) (W q r : ℝ → (Fin Nc → ℝ))
    (hq : textbookBrownianIntegralSolution m U β T x W q)
    (hr : textbookBrownianIntegralSolution m U β T x W r) :
    ∀ t ∈ Icc 0 T, q t = r t := by
  intro t ht
  have hb := textbookBrownianIntegralSolution_dist_le m U hU hPU β T 0 hT x x W W q r hq hr
    (fun _ _ ↦ by simp) t ht
  simpa only [dist_self, mul_zero, gronwallBound_ε0_δ0, add_zero, dist_le_zero] using hb

include hU hPU in
/-- Actual finite-horizon solutions agree on each common shorter horizon. -/
theorem textbookBrownianIntegralSolution_horizon_agreement (A T : ℝ) (hT : 0 ≤ T) (hTA : T ≤ A)
    (x : Fin Nc → ℝ) (W q r : ℝ → (Fin Nc → ℝ))
    (hq : textbookBrownianIntegralSolution m U β A x W q)
    (hr : textbookBrownianIntegralSolution m U β T x W r) :
    ∀ t ∈ Icc 0 T, q t = r t :=
  textbookBrownianIntegralSolution_unique m U hU hPU β T hT x W q r
    (textbookBrownianIntegralSolution_restrict m U β A T hTA x W q hq) hr


/-- A certified actual solution selected for the genuine continuous path carrier. -/
def textbookBrownianPathSolution (T : ℝ) (hT : 0 ≤ T) (x : Fin Nc → ℝ)
    (W : C(Icc 0 T, Fin Nc → ℝ)) : ℝ → (Fin Nc → ℝ) :=
  Classical.choose (textbookBrownianIntegralSolution_exists_model m hm U hU hPU β hβ T hT x
    (textbookLangevinPathNoise T hT W) (textbookLangevinPathNoise_continuous T hT W).continuousOn)

/-- The selected path solves the original first-order Brownian equation with original masses. -/
theorem textbookBrownianPathSolution_integralSolution (T : ℝ) (hT : 0 ≤ T)
    (x : Fin Nc → ℝ) (W : C(Icc 0 T, Fin Nc → ℝ)) :
    textbookBrownianIntegralSolution m U β T x (textbookLangevinPathNoise T hT W)
      (textbookBrownianPathSolution m hm U hU hPU β hβ T hT x W) :=
  Classical.choose_spec (textbookBrownianIntegralSolution_exists_model m hm U hU hPU β hβ T hT x
    (textbookLangevinPathNoise T hT W) (textbookLangevinPathNoise_continuous T hT W).continuousOn)

/-- Evaluate the actual selected solution in the original configuration coordinates. -/
def textbookBrownianPathEndpoint (T : ℝ) (hT : 0 ≤ T) (x : Fin Nc → ℝ) (t : ℝ)
    (W : C(Icc 0 T, Fin Nc → ℝ)) : Fin Nc → ℝ :=
  textbookBrownianPathSolution m hm U hU hPU β hβ T hT x W t

private theorem centered_noise_increment_dist (T : ℝ) (hT : 0 ≤ T)
    (W R : C(Icc 0 T, Fin Nc → ℝ)) (t : ℝ) :
    ‖(textbookLangevinPathNoise T hT W t - textbookLangevinPathNoise T hT W 0) -
      (textbookLangevinPathNoise T hT R t - textbookLangevinPathNoise T hT R 0)‖ ≤
        2 * dist W R := by
  rw [textbookLangevinPathNoise_zero, textbookLangevinPathNoise_zero, sub_zero, sub_zero]
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

/-- The true endpoint has the original initial value for every actual noise path. -/
theorem textbookBrownianPathEndpoint_initial (T : ℝ) (hT : 0 ≤ T)
    (x : Fin Nc → ℝ) (W : C(Icc 0 T, Fin Nc → ℝ)) :
    textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT x 0 W = x :=
  textbookBrownianIntegralSolution_initial m U β T hT x _ _
    (textbookBrownianPathSolution_integralSolution m hm U hU hPU β hβ T hT x W)

/-- Every other actual integral solution agrees with the selected path on the true interval. -/
theorem textbookBrownianPathSolution_eq_of_integralSolution (T : ℝ) (hT : 0 ≤ T)
    (x : Fin Nc → ℝ) (W : C(Icc 0 T, Fin Nc → ℝ)) (q : ℝ → (Fin Nc → ℝ))
    (hq : textbookBrownianIntegralSolution m U β T x (textbookLangevinPathNoise T hT W) q) :
    ∀ t ∈ Icc 0 T, textbookBrownianPathSolution m hm U hU hPU β hβ T hT x W t = q t :=
  textbookBrownianIntegralSolution_unique m U hU hPU β T hT x _ _ q
    (textbookBrownianPathSolution_integralSolution m hm U hU hPU β hβ T hT x W) hq

/-- The chosen endpoint is Lipschitz jointly in the true initial state and the uniform noise path metric. -/
theorem textbookBrownianPathEndpoint_joint_lipschitz (T : ℝ) (hT : 0 ≤ T)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    ∃ C : ℝ≥0, LipschitzWith C
      (fun z : (Fin Nc → ℝ) × C(Icc 0 T, Fin Nc → ℝ) ↦
        textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT z.1 t z.2) := by
  let L : ℝ := textbookBrownianDriftLipschitzConstant m U hU hPU
  let N : ℝ := ‖textbookBrownianSDENoise m β‖
  let K : ℝ := 1 + L
  have hL : 0 ≤ L := (textbookBrownianDriftLipschitzConstant m U hU hPU).property
  have hN : 0 ≤ N := norm_nonneg _
  have hK : 0 < K := by dsimp [K]; linarith
  have hexp : 0 ≤ Real.exp (K * t) - 1 :=
    sub_nonneg.mpr (Real.one_le_exp_iff.mpr (mul_nonneg hK.le ht.1))
  let A : ℝ := 2 * (L * N / K * (Real.exp (K * t) - 1) + N)
  have hA : 0 ≤ A := by dsimp [A]; positivity
  let C : ℝ := Real.exp (K * t) + A
  have hC : 0 ≤ C := add_nonneg (Real.exp_pos _).le hA
  refine ⟨⟨C, hC⟩, LipschitzWith.of_dist_le_mul (fun z w ↦ ?_)⟩
  let q := textbookBrownianPathSolution m hm U hU hPU β hβ T hT z.1 z.2
  let r := textbookBrownianPathSolution m hm U hU hPU β hβ T hT w.1 w.2
  have hq := textbookBrownianPathSolution_integralSolution m hm U hU hPU β hβ T hT z.1 z.2
  have hr := textbookBrownianPathSolution_integralSolution m hm U hU hPU β hβ T hT w.1 w.2
  have hb := textbookBrownianIntegralSolution_dist_le m U hU hPU β T (2 * dist z.2 w.2) hT
    z.1 w.1 (textbookLangevinPathNoise T hT z.2) (textbookLangevinPathNoise T hT w.2)
    q r hq hr (fun s _ ↦ centered_noise_increment_dist T hT z.2 w.2 s) t ht
  change dist (q t) (r t) ≤
    gronwallBound (dist z.1 w.1) K (L * N * (2 * dist z.2 w.2)) t + N * (2 * dist z.2 w.2) at hb
  rw [gronwallBound_of_K_ne_0 hK.ne'] at hb
  have hz : dist z.1 w.1 ≤ dist z w := by rw [Prod.dist_eq]; exact le_max_left _ _
  have hw : dist z.2 w.2 ≤ dist z w := by rw [Prod.dist_eq]; exact le_max_right _ _
  change dist (q t) (r t) ≤ C * dist z w
  calc
    _ ≤ Real.exp (K * t) * dist z.1 w.1 + A * dist z.2 w.2 := by
      convert hb using 1
      dsimp [A]
      ring
    _ ≤ Real.exp (K * t) * dist z w + A * dist z w :=
      add_le_add (mul_le_mul_of_nonneg_left hz (Real.exp_pos _).le)
        (mul_le_mul_of_nonneg_left hw hA)
    _ = C * dist z w := by dsimp [C]; ring

/-- Genuine joint endpoint continuity is proved from the original equation, not supplied as a premise. -/
theorem textbookBrownianPathEndpoint_joint_continuous (T : ℝ) (hT : 0 ≤ T)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    Continuous (fun z : (Fin Nc → ℝ) × C(Icc 0 T, Fin Nc → ℝ) ↦
      textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT z.1 t z.2) := by
  obtain ⟨C, hC⟩ := textbookBrownianPathEndpoint_joint_lipschitz m hm U hU hPU β hβ T hT t ht
  exact hC.continuous

/-- The actual joint endpoint is Borel measurable on the true initial-state/path carrier. -/
theorem textbookBrownianPathEndpoint_joint_measurable (T : ℝ) (hT : 0 ≤ T)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    Measurable (fun z : (Fin Nc → ℝ) × C(Icc 0 T, Fin Nc → ℝ) ↦
      textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT z.1 t z.2) :=
  (textbookBrownianPathEndpoint_joint_continuous m hm U hU hPU β hβ T hT t ht).measurable

/-- Each endpoint is genuinely continuous in its actual noise path. -/
theorem textbookBrownianPathEndpoint_continuous (T : ℝ) (hT : 0 ≤ T)
    (x : Fin Nc → ℝ) (t : ℝ) (ht : t ∈ Icc 0 T) :
    Continuous (textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT x t) := by
  exact (textbookBrownianPathEndpoint_joint_continuous m hm U hU hPU β hβ T hT t ht).comp
    (continuous_const.prodMk continuous_id)

/-- Each actual endpoint is Borel measurable as a function of the continuous noise path. -/
theorem textbookBrownianPathEndpoint_measurable (T : ℝ) (hT : 0 ≤ T)
    (x : Fin Nc → ℝ) (t : ℝ) (ht : t ∈ Icc 0 T) :
    Measurable (textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT x t) :=
  (textbookBrownianPathEndpoint_continuous m hm U hU hPU β hβ T hT x t ht).measurable

/-- At each fixed true driving path, the actual solution is continuous in the original initial state. -/
theorem textbookBrownianPathEndpoint_initialState_continuous (T : ℝ) (hT : 0 ≤ T)
    (t : ℝ) (ht : t ∈ Icc 0 T) (W : C(Icc 0 T, Fin Nc → ℝ)) :
    Continuous (fun x : Fin Nc → ℝ ↦ textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT x t W) :=
  (textbookBrownianPathEndpoint_joint_continuous m hm U hU hPU β hβ T hT t ht).comp
    (continuous_id.prodMk continuous_const)

end
end MolecularDynamics