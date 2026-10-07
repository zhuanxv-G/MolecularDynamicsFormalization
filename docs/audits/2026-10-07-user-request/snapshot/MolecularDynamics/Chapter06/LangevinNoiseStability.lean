import MolecularDynamics.Chapter06.LangevinControlPath
import Mathlib.Analysis.ODE.Gronwall

/-! Actual noise-path dependence needed in Lemma6.1. Full C1 localization and Wiener support are separate. -/

open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal

namespace MolecularDynamics

/-- The actual additive-noise Langevin integral equations on the specified interval. -/
def textbookLangevinIntegralSolution {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ)
    (γ σ T : ℝ) (x : textbookLangevinPhase Nc) (W q p : ℝ → (Fin Nc → ℝ)) : Prop :=
  ContinuousOn q (Icc 0 T) ∧ ContinuousOn p (Icc 0 T) ∧ ContinuousOn W (Icc 0 T) ∧
    W 0 = 0 ∧
    (∀ t ∈ Icc 0 T, q t = x.1 + ∫ s in 0..t, p s) ∧
    (∀ t ∈ Icc 0 T, p t = x.2 +
      (∫ s in 0..t, textbookPotentialForce U (q s) - γ • p s) + σ • W t)

/-- Compensating the actual additive noise yields a genuine differentiable trajectory. -/
def textbookLangevinNoiseCompensated {Nc : ℕ} (σ : ℝ)
    (W q p : ℝ → (Fin Nc → ℝ)) (t : ℝ) : textbookLangevinPhase Nc := (q t, p t - σ • W t)

noncomputable def textbookLangevinDrivenField {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ σ : ℝ) (W : ℝ → (Fin Nc → ℝ))
    (t : ℝ) (z : textbookLangevinPhase Nc) : textbookLangevinPhase Nc :=
  (z.2 + σ • W t, textbookPotentialForce U z.1 - γ • (z.2 + σ • W t))

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

/-- The compensated path is continuous on the actual interval. -/
theorem textbookLangevinNoiseCompensated_continuousOn {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ σ T : ℝ) (x : textbookLangevinPhase Nc)
    (W q p : ℝ → (Fin Nc → ℝ)) (h : textbookLangevinIntegralSolution U γ σ T x W q p) :
    ContinuousOn (textbookLangevinNoiseCompensated σ W q p) (Icc 0 T) := by
  rcases h with ⟨hq, hp, hW, _, _, _⟩
  exact hq.prodMk (hp.fun_sub (hW.const_smul σ))

/-- Genuine right derivatives follow from the true integral equations, even for rough noise. -/
theorem textbookLangevinNoiseCompensated_hasDerivWithinAt {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (γ σ T : ℝ) (x : textbookLangevinPhase Nc)
    (W q p : ℝ → (Fin Nc → ℝ)) (h : textbookLangevinIntegralSolution U γ σ T x W q p)
    (t : ℝ) (ht : t ∈ Ico 0 T) :
    HasDerivWithinAt (textbookLangevinNoiseCompensated σ W q p)
      (textbookLangevinDrivenField U γ σ W t (textbookLangevinNoiseCompensated σ W q p t))
      (Ici t) t := by
  rcases h with ⟨hq, hp, _, _, hqeq, hpeq⟩
  have hF := (contDiff_textbookPotentialForce U hU).continuous
  have hb : ContinuousOn (fun s ↦ textbookPotentialForce U (q s) - γ • p s) (Icc 0 T) :=
    (hF.comp_continuousOn hq).fun_sub (hp.const_smul γ)
  have hveq (s : ℝ) (hs : s ∈ Icc 0 T) : p s - σ • W s = x.2 +
      ∫ r in 0..s, textbookPotentialForce U (q r) - γ • p r := by
    rw [hpeq s hs]
    abel
  have hdq := integral_right_derivative q p x.1 hp hqeq t ht
  have hdv := integral_right_derivative (fun s ↦ p s - σ • W s)
    (fun s ↦ textbookPotentialForce U (q s) - γ • p s) x.2 hb hveq t ht
  convert! hdq.prodMk hdv using 1
  simp [textbookLangevinNoiseCompensated, textbookLangevinDrivenField]

/-- The compensated initial phase is genuinely the specified original phase. -/
theorem textbookLangevinNoiseCompensated_initial {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPhase Nc)
    (W q p : ℝ → (Fin Nc → ℝ)) (h : textbookLangevinIntegralSolution U γ σ T x W q p) :
    textbookLangevinNoiseCompensated σ W q p 0 = x := by
  rcases h with ⟨_, _, _, hW0, hqeq, hpeq⟩
  have hm : (0 : ℝ) ∈ Icc 0 T := ⟨le_rfl, hT⟩
  simp [textbookLangevinNoiseCompensated, hqeq 0 hm, hpeq 0 hm, hW0]

/-- The constructed smooth control satisfies the actual integral solution model. -/
theorem textbookLangevinControl_integralSolution {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T : ℝ) (hσ : σ ≠ 0) (hT : 0 < T)
    (x y : textbookLangevinPhase Nc) :
    textbookLangevinIntegralSolution U γ σ T x
      (textbookLangevinControlPath U γ σ T x y)
      (textbookLangevinControlPosition T x y) (textbookLangevinControlMomentum T x y) := by
  let q := textbookLangevinControlPosition T x y
  let p := textbookLangevinControlMomentum T x y
  let R := textbookLangevinControlPath U γ σ T x y
  have hq : Continuous q := by unfold q textbookLangevinControlPosition; fun_prop
  have hp : Continuous p := by unfold p textbookLangevinControlMomentum; fun_prop
  have hR := (textbookLangevinControlPath_contDiff U hU γ σ T x y).continuous
  have hb : Continuous (fun s ↦ textbookPotentialForce U (q s) - γ • p s) :=
    ((textbookLangevinForce_contDiff U hU).continuous.comp hq).sub (hp.const_smul γ)
  obtain ⟨hq0, hp0, _, _⟩ := textbookLangevinControl_endpoints T hT x y
  have hR0 : R 0 = 0 := by simp [R, textbookLangevinControlPath]
  refine ⟨hq.continuousOn, hp.continuousOn, hR.continuousOn, hR0, ?_, ?_⟩
  · intro t _
    have he := intervalIntegral.integral_eq_sub_of_hasDerivAt
      (fun s _ ↦ textbookLangevinControlPosition_hasDerivAt T x y s) (hp.intervalIntegrable 0 t)
    change q t = x.1 + ∫ s in 0..t, p s
    rw [he, hq0]
    abel
  · intro t _
    have hv (s : ℝ) : HasDerivAt (fun s ↦ p s - σ • R s)
        (textbookPotentialForce U (q s) - γ • p s) s := by
      have hd := (textbookLangevinControlMomentum_hasDerivAt U hU γ σ T hσ x y s).sub
        ((textbookLangevinControlPath_hasDerivAt U hU γ σ T x y s).const_smul σ)
      have he := (textbookLangevinControlPath_hasDerivAt U hU γ σ T x y s).deriv
      rw [he] at hd
      convert! hd using 1
      abel
    have he := intervalIntegral.integral_eq_sub_of_hasDerivAt (fun s _ ↦ hv s)
      (hb.intervalIntegrable 0 t)
    change p t = x.2 + (∫ s in 0..t, textbookPotentialForce U (q s) - γ • p s) + σ • R t
    have hpinitial : p 0 = x.2 := hp0
    rw [he, hpinitial, hR0]
    simp only [smul_zero, sub_zero]
    abel

private theorem driven_field_lipschitz {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (W : ℝ → (Fin Nc → ℝ)) (t : ℝ) :
    LipschitzWith (1 + L + ‖γ‖₊) (textbookLangevinDrivenField U γ σ W t) := by
  apply LipschitzWith.of_dist_le_mul
  intro z w
  simp only [dist_eq_norm]
  have hq : ‖z.1 - w.1‖ ≤ ‖z - w‖ := by rw [Prod.norm_def]; exact le_max_left _ _
  have hp : ‖z.2 - w.2‖ ≤ ‖z - w‖ := by rw [Prod.norm_def]; exact le_max_right _ _
  have he : textbookLangevinDrivenField U γ σ W t z - textbookLangevinDrivenField U γ σ W t w =
      (z.2 - w.2, textbookPotentialForce U z.1 - textbookPotentialForce U w.1 - γ • (z.2 - w.2)) := by
    apply Prod.ext
    · dsimp [textbookLangevinDrivenField]
      abel
    · dsimp [textbookLangevinDrivenField]
      module
  rw [he, Prod.norm_def]
  change max ‖z.2 - w.2‖ ‖textbookPotentialForce U z.1 - textbookPotentialForce U w.1 -
    γ • (z.2 - w.2)‖ ≤ (1 + (L : ℝ) + ‖γ‖) * ‖z - w‖
  apply max_le
  · have hL : (0 : ℝ) ≤ L := L.property
    nlinarith [norm_nonneg γ, norm_nonneg (z - w)]
  · calc
      _ ≤ ‖textbookPotentialForce U z.1 - textbookPotentialForce U w.1‖ + ‖γ • (z.2 - w.2)‖ :=
        norm_sub_le _ _
      _ ≤ (L : ℝ) * ‖z.1 - w.1‖ + ‖γ‖ * ‖z.2 - w.2‖ := by
        rw [norm_smul]
        exact add_le_add (hF.norm_sub_le z.1 w.1) (le_refl _)
      _ ≤ (1 + (L : ℝ) + ‖γ‖) * ‖z - w‖ := by
        have hL := mul_le_mul_of_nonneg_left hq L.property
        have hγ := mul_le_mul_of_nonneg_left hp (norm_nonneg γ)
        calc
          _ ≤ (L : ℝ) * ‖z - w‖ + ‖γ‖ * ‖z - w‖ := add_le_add hL hγ
          _ ≤ ‖z - w‖ + ((L : ℝ) * ‖z - w‖ + ‖γ‖ * ‖z - w‖) := by
            simpa only [zero_add] using add_le_add (norm_nonneg (z - w))
              (le_refl ((L : ℝ) * ‖z - w‖ + ‖γ‖ * ‖z - w‖))
          _ = (1 + (L : ℝ) + ‖γ‖) * ‖z - w‖ := by ring

/-- The actual noise-compensated field has a global state Lipschitz constant uniform in time and noise. -/
theorem textbookLangevinDrivenField_lipschitz {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (W : ℝ → (Fin Nc → ℝ)) (t : ℝ) :
    LipschitzWith (1 + L + ‖γ‖₊) (textbookLangevinDrivenField U γ σ W t) :=
  driven_field_lipschitz U L hF γ σ W t

private theorem driven_field_noise_error {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ σ : ℝ) (W R : ℝ → (Fin Nc → ℝ))
    (t ε : ℝ) (hε : 0 ≤ ε) (hWR : ‖W t - R t‖ ≤ ε) (z : textbookLangevinPhase Nc) :
    dist (textbookLangevinDrivenField U γ σ W t z) (textbookLangevinDrivenField U γ σ R t z) ≤
      (1 + ‖γ‖) * ‖σ‖ * ε := by
  have he : textbookLangevinDrivenField U γ σ W t z - textbookLangevinDrivenField U γ σ R t z =
      (σ • (W t - R t), -γ • (σ • (W t - R t))) := by
    apply Prod.ext
    · dsimp [textbookLangevinDrivenField]
      module
    · dsimp [textbookLangevinDrivenField]
      module
  rw [dist_eq_norm, he, Prod.norm_def]
  change max ‖σ • (W t - R t)‖ ‖-γ • (σ • (W t - R t))‖ ≤ (1 + ‖γ‖) * ‖σ‖ * ε
  have hs : ‖σ • (W t - R t)‖ ≤ ‖σ‖ * ε := by
    rw [norm_smul]
    exact mul_le_mul_of_nonneg_left hWR (norm_nonneg σ)
  have hg : ‖-γ • (σ • (W t - R t))‖ ≤ ‖γ‖ * (‖σ‖ * ε) := by
    rw [norm_smul, norm_neg]
    exact mul_le_mul_of_nonneg_left hs (norm_nonneg γ)
  have hz := mul_nonneg (norm_nonneg γ) (mul_nonneg (norm_nonneg σ) hε)
  have ha := mul_nonneg (norm_nonneg σ) hε
  exact max_le (hs.trans (by nlinarith)) (hg.trans (by nlinarith))

/-- Actual integral solutions have a genuine Gronwall bound in the compensated coordinates. -/
theorem textbookLangevinNoiseCompensated_dist_le {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T ε : ℝ)
    (hT : 0 ≤ T) (hε : 0 ≤ ε) (x : textbookLangevinPhase Nc)
    (W R q p qr pr : ℝ → (Fin Nc → ℝ))
    (hW : textbookLangevinIntegralSolution U γ σ T x W q p)
    (hR : textbookLangevinIntegralSolution U γ σ T x R qr pr)
    (htube : ∀ t ∈ Icc 0 T, ‖W t - R t‖ ≤ ε) (t : ℝ) (ht : t ∈ Icc 0 T) :
    dist (textbookLangevinNoiseCompensated σ W q p t)
        (textbookLangevinNoiseCompensated σ R qr pr t) ≤
      gronwallBound 0 (1 + (L : ℝ) + ‖γ‖) ((1 + ‖γ‖) * ‖σ‖ * ε) t := by
  have hw' := textbookLangevinNoiseCompensated_hasDerivWithinAt U hU γ σ T x W q p hW
  have hr' := textbookLangevinNoiseCompensated_hasDerivWithinAt U hU γ σ T x R qr pr hR
  have hw_bound (s : ℝ) (hs : s ∈ Ico 0 T) :
      dist (textbookLangevinDrivenField U γ σ W s (textbookLangevinNoiseCompensated σ W q p s))
        (textbookLangevinDrivenField U γ σ R s (textbookLangevinNoiseCompensated σ W q p s)) ≤
          (1 + ‖γ‖) * ‖σ‖ * ε :=
    driven_field_noise_error U γ σ W R s ε hε (htube s (Ico_subset_Icc_self hs)) _
  have hr_bound (s : ℝ) (_ : s ∈ Ico 0 T) :
      dist (textbookLangevinDrivenField U γ σ R s (textbookLangevinNoiseCompensated σ R qr pr s))
        (textbookLangevinDrivenField U γ σ R s (textbookLangevinNoiseCompensated σ R qr pr s)) ≤ 0 := by
    rw [dist_self]
  have hh := dist_le_of_approx_trajectories_ODE
    (fun s ↦ driven_field_lipschitz U L hF γ σ R s)
    (textbookLangevinNoiseCompensated_continuousOn U γ σ T x W q p hW) hw' hw_bound
    (textbookLangevinNoiseCompensated_continuousOn U γ σ T x R qr pr hR) hr'
    hr_bound
    (by rw [textbookLangevinNoiseCompensated_initial U γ σ T hT x W q p hW,
      textbookLangevinNoiseCompensated_initial U γ σ T hT x R qr pr hR, dist_self]) t ht
  simpa only [add_zero, sub_zero, NNReal.coe_add, NNReal.coe_one, coe_nnnorm] using hh

/-- Undoing the actual noise compensation gives a true bound in the original phase variables. -/
theorem textbookLangevinNoise_phase_dist_le {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T ε : ℝ)
    (hT : 0 ≤ T) (hε : 0 ≤ ε) (x : textbookLangevinPhase Nc)
    (W R q p qr pr : ℝ → (Fin Nc → ℝ))
    (hW : textbookLangevinIntegralSolution U γ σ T x W q p)
    (hR : textbookLangevinIntegralSolution U γ σ T x R qr pr)
    (htube : ∀ t ∈ Icc 0 T, ‖W t - R t‖ ≤ ε) (t : ℝ) (ht : t ∈ Icc 0 T) :
    dist (q t, p t) (qr t, pr t) ≤
      gronwallBound 0 (1 + (L : ℝ) + ‖γ‖) ((1 + ‖γ‖) * ‖σ‖ * ε) t + ‖σ‖ * ε := by
  have hg := textbookLangevinNoiseCompensated_dist_le U hU L hF γ σ T ε hT hε x
    W R q p qr pr hW hR htube t ht
  rw [dist_eq_norm] at hg
  have he : (q t, p t) - (qr t, pr t) =
      (textbookLangevinNoiseCompensated σ W q p t -
        textbookLangevinNoiseCompensated σ R qr pr t) + ((0 : Fin Nc → ℝ), σ • (W t - R t)) := by
    apply Prod.ext
    · simp [textbookLangevinNoiseCompensated]
    · change p t - pr t = (p t - σ • W t - (pr t - σ • R t)) + σ • (W t - R t)
      module
  rw [dist_eq_norm, he]
  calc
    _ ≤ ‖textbookLangevinNoiseCompensated σ W q p t -
        textbookLangevinNoiseCompensated σ R qr pr t‖ + ‖((0 : Fin Nc → ℝ), σ • (W t - R t))‖ :=
      norm_add_le _ _
    _ ≤ gronwallBound 0 (1 + (L : ℝ) + ‖γ‖) ((1 + ‖γ‖) * ‖σ‖ * ε) t + ‖σ‖ * ε := by
      apply add_le_add hg
      rw [Prod.norm_def]
      change max ‖(0 : Fin Nc → ℝ)‖ ‖σ • (W t - R t)‖ ≤ ‖σ‖ * ε
      rw [norm_zero, max_eq_right (norm_nonneg _), norm_smul]
      exact mul_le_mul_of_nonneg_left (htube t ht) (norm_nonneg σ)

/-- For the explicitly global-Lipschitz auxiliary model, an actual small noise tube reaches the target ball. -/
theorem textbookLangevinControlledEndpoint_stable_globalLip {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T δ : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (hδ : 0 < δ) (x y : textbookLangevinPhase Nc) :
    ∃ ε > 0, ∀ W q p : ℝ → (Fin Nc → ℝ),
      textbookLangevinIntegralSolution U γ σ T x W q p →
      (∀ t ∈ Icc 0 T, ‖W t - textbookLangevinControlPath U γ σ T x y t‖ ≤ ε) →
      dist (q T, p T) y < δ := by
  let B : ℝ → ℝ := fun ε ↦
    gronwallBound 0 (1 + (L : ℝ) + ‖γ‖) ((1 + ‖γ‖) * ‖σ‖ * ε) T + ‖σ‖ * ε
  have hc : Continuous B :=
    ((gronwallBound_continuous_ε 0 (1 + (L : ℝ) + ‖γ‖) T).comp
      (continuous_const.mul continuous_id)).add (continuous_const.mul continuous_id)
  have hB0 : B 0 = 0 := by simp [B, gronwallBound_ε0_δ0]
  have hn : {ε | B ε < δ} ∈ 𝓝 (0 : ℝ) :=
    hc.continuousAt.preimage_mem_nhds (Iio_mem_nhds (by simpa [hB0] using hδ))
  obtain ⟨η, hη, hηB⟩ := Metric.mem_nhds_iff.mp hn
  refine ⟨η / 2, by positivity, ?_⟩
  intro W q p hSol htube
  have hsmall : B (η / 2) < δ := by
    apply hηB
    rw [Metric.mem_ball, Real.dist_eq, sub_zero, abs_of_pos (by positivity)]
    linarith
  have href := textbookLangevinControl_integralSolution U hU γ σ T hσ hT x y
  have hb := textbookLangevinNoise_phase_dist_le U (hU.of_le (by simp)) L hF γ σ T (η / 2)
    hT.le (by positivity) x W (textbookLangevinControlPath U γ σ T x y) q p
    (textbookLangevinControlPosition T x y) (textbookLangevinControlMomentum T x y)
    hSol href htube T ⟨hT.le, le_rfl⟩
  obtain ⟨_, _, hqT, hpT⟩ := textbookLangevinControl_endpoints T hT x y
  have he : (textbookLangevinControlPosition T x y T, textbookLangevinControlMomentum T x y T) = y :=
    Prod.ext hqT hpT
  rw [he] at hb
  exact lt_of_le_of_lt hb hsmall

end MolecularDynamics
