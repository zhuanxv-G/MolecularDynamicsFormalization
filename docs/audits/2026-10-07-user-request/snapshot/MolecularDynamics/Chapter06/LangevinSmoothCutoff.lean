import MolecularDynamics.Chapter06.LangevinNoiseStability
import Mathlib.Analysis.Calculus.BumpFunction.FiniteDimension
import Mathlib.Analysis.Calculus.ContDiff.RCLike
import Mathlib.Topology.Order.IntermediateValue

/-! Genuine smooth potential cutoff needed to remove the global force bound in Lemma6.1. -/

open Set Filter
open scoped Topology ContDiff

namespace MolecularDynamics

private def potentialBump (Nc : ℕ) (R : ℝ) (hR : 0 < R) :
    ContDiffBump (0 : Fin Nc → ℝ) := ⟨R, R + 1, hR, by linarith⟩

/-- An actual smooth cutoff of the original potential, rather than a supplied Lipschitz force. -/
noncomputable def textbookLangevinSmoothCutoff {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (R : ℝ) (hR : 0 < R) (q : Fin Nc → ℝ) : ℝ :=
  potentialBump Nc R hR q * U q

theorem textbookLangevinSmoothCutoff_contDiff {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (R : ℝ) (hR : 0 < R) :
    ContDiff ℝ ∞ (textbookLangevinSmoothCutoff U R hR) :=
  (potentialBump Nc R hR).contDiff.mul hU

theorem textbookLangevinSmoothCutoff_hasCompactSupport {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (R : ℝ) (hR : 0 < R) :
    HasCompactSupport (textbookLangevinSmoothCutoff U R hR) :=
  (potentialBump Nc R hR).hasCompactSupport.mul_right

/-- The actual potential remains equal throughout the inner closed ball. -/
theorem textbookLangevinSmoothCutoff_eq {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (R : ℝ) (hR : 0 < R) (q : Fin Nc → ℝ)
    (hq : ‖q‖ ≤ R) : textbookLangevinSmoothCutoff U R hR q = U q := by
  have hb : potentialBump Nc R hR q = 1 :=
    (potentialBump Nc R hR).one_of_mem_closedBall (by simpa [potentialBump] using hq)
  simp [textbookLangevinSmoothCutoff, hb]

/-- Interior equality of the real potentials gives equality of their real derivative forces. -/
theorem textbookLangevinSmoothCutoff_force_eq {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (R : ℝ) (hR : 0 < R) (q : Fin Nc → ℝ)
    (hq : ‖q‖ < R) :
    textbookPotentialForce (textbookLangevinSmoothCutoff U R hR) q = textbookPotentialForce U q := by
  have hb := (potentialBump Nc R hR).eventuallyEq_one_of_mem_ball
    (x := q) (by simpa [potentialBump] using hq)
  have he : textbookLangevinSmoothCutoff U R hR =ᶠ[𝓝 q] U := by
    filter_upwards [hb] with z hz
    simp [textbookLangevinSmoothCutoff, hz]
  ext i
  simp only [textbookPotentialForce]
  rw [he.fderiv_eq]

/-- Compact support of a true potential gives compact support of its coordinate gradient. -/
theorem textbookPotentialForce_hasCompactSupport {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : HasCompactSupport U) :
    HasCompactSupport (textbookPotentialForce U) := by
  apply hU.mono'
  intro q hq
  by_contra hn
  have he := fderiv_of_notMem_tsupport ℝ hn
  change textbookPotentialForce U q ≠ 0 at hq
  apply hq
  ext i
  simp [textbookPotentialForce, he]

/-- Global force Lipschitz continuity is proved from the actual smooth compactly supported potential. -/
theorem textbookLangevinSmoothCutoff_force_lipschitz {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (R : ℝ) (hR : 0 < R) :
    ∃ L, LipschitzWith L (textbookPotentialForce (textbookLangevinSmoothCutoff U R hR)) := by
  exact ContDiff.lipschitzWith_of_hasCompactSupport
    (textbookPotentialForce_hasCompactSupport _
      (textbookLangevinSmoothCutoff_hasCompactSupport U R hR))
    (textbookLangevinForce_contDiff _ (textbookLangevinSmoothCutoff_contDiff U hU R hR)) (by simp)

/-- A true first hitting time follows from continuity and compactness, with no stay-in-ball premise. -/
theorem textbookContinuous_firstExit {d : ℝ → ℝ} {T r : ℝ}
    (hd : ContinuousOn d (Icc 0 T)) (h0 : d 0 < r)
    (hhit : ∃ t ∈ Icc 0 T, r ≤ d t) :
    ∃ τ ∈ Icc 0 T, d τ = r ∧ ∀ s ∈ Icc 0 τ, d s ≤ r := by
  obtain ⟨t, ht, hdt⟩ := hhit
  have hsub : Icc 0 t ⊆ Icc 0 T := Icc_subset_Icc le_rfl ht.2
  obtain ⟨u, hu, hdu⟩ := intermediate_value_Icc ht.1 (hd.mono hsub) ⟨h0.le, hdt⟩
  let S : Set ℝ := {s ∈ Icc 0 T | d s = r}
  have hk : IsCompact S := isCompact_Icc.of_isClosed_subset
    (isClosed_Icc.isClosed_eq hd continuousOn_const) (fun _ hs ↦ hs.1)
  obtain ⟨τ, hτ⟩ := hk.exists_isLeast ⟨u, hsub hu, hdu⟩
  refine ⟨τ, hτ.1.1, hτ.1.2, ?_⟩
  intro s hs
  by_contra hn
  have hds : r < d s := lt_of_not_ge hn
  have hsT : s ∈ Icc 0 T := ⟨hs.1, hs.2.trans hτ.1.1.2⟩
  obtain ⟨v, hv, hdv⟩ := intermediate_value_Icc hs.1
    (hd.mono (Icc_subset_Icc le_rfl hsT.2)) ⟨h0.le, hds.le⟩
  have hτv : τ ≤ v := hτ.2 ⟨⟨hv.1, hv.2.trans hsT.2⟩, hdv⟩
  have he : v = s := le_antisymm hv.2 (hs.2.trans hτv)
  rw [he] at hdv
  exact hds.ne' hdv

/-- Restrict an actual solution to a shorter interval and transfer equal actual forces. -/
theorem textbookLangevinIntegralSolution_changePotential {Nc : ℕ}
    (U V : (Fin Nc → ℝ) → ℝ) (γ σ T S : ℝ) (hST : S ≤ T)
    (x : textbookLangevinPhase Nc) (W q p : ℝ → (Fin Nc → ℝ))
    (h : textbookLangevinIntegralSolution U γ σ T x W q p)
    (hF : ∀ s ∈ Icc 0 S, textbookPotentialForce V (q s) = textbookPotentialForce U (q s)) :
    textbookLangevinIntegralSolution V γ σ S x W q p := by
  rcases h with ⟨hq, hp, hW, hW0, hqeq, hpeq⟩
  have hsub : Icc 0 S ⊆ Icc 0 T := Icc_subset_Icc le_rfl hST
  refine ⟨hq.mono hsub, hp.mono hsub, hW.mono hsub, hW0, ?_, ?_⟩
  · exact fun t ht ↦ hqeq t (hsub ht)
  · intro t ht
    have he : (∫ s in 0..t, textbookPotentialForce V (q s) - γ • p s) =
        ∫ s in 0..t, textbookPotentialForce U (q s) - γ • p s := by
      apply intervalIntegral.integral_congr
      intro s hs
      rw [uIcc_of_le ht.1] at hs
      change textbookPotentialForce V (q s) - γ • p s = textbookPotentialForce U (q s) - γ • p s
      rw [hF s ⟨hs.1, hs.2.trans ht.2⟩]
    rw [he]
    exact hpeq t (hsub ht)

/-- Actual noise-path stability for every smooth potential: compact cutoff and first exit remove the global force bound. -/
theorem textbookLangevinControlledEndpoint_stable {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T δ : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (hδ : 0 < δ) (x y : textbookLangevinPhase Nc) :
    ∃ ε > 0, ∀ W q p : ℝ → (Fin Nc → ℝ),
      textbookLangevinIntegralSolution U γ σ T x W q p →
      (∀ t ∈ Icc 0 T, ‖W t - textbookLangevinControlPath U γ σ T x y t‖ ≤ ε) →
      dist (q T, p T) y < δ := by
  let qr := textbookLangevinControlPosition T x y
  let pr := textbookLangevinControlMomentum T x y
  let R := textbookLangevinControlPath U γ σ T x y
  have hqr : Continuous qr := by unfold qr textbookLangevinControlPosition; fun_prop
  have hpr : Continuous pr := by unfold pr textbookLangevinControlMomentum; fun_prop
  obtain ⟨M, hM⟩ := isCompact_Icc.exists_bound_of_continuousOn
    (hqr.continuousOn : ContinuousOn qr (Icc 0 T))
  let r := δ / 2
  have hr : 0 < r := by dsimp [r]; positivity
  let A := max M 0 + r + 1
  have hA : 0 < A := by dsimp [A]; have := le_max_right M 0; linarith
  let V := textbookLangevinSmoothCutoff U A hA
  have hV : ContDiff ℝ ∞ V := textbookLangevinSmoothCutoff_contDiff U hU A hA
  obtain ⟨L, hL⟩ := textbookLangevinSmoothCutoff_force_lipschitz U hU A hA
  have hqrA (s : ℝ) (hs : s ∈ Icc 0 T) : ‖qr s‖ < A := by
    have hm := (hM s hs).trans (le_max_left M 0)
    dsimp [A]
    linarith
  have href := textbookLangevinControl_integralSolution U hU γ σ T hσ hT x y
  have hRefV : textbookLangevinIntegralSolution V γ σ T x R qr pr :=
    textbookLangevinIntegralSolution_changePotential U V γ σ T T le_rfl x R qr pr href
      (fun s hs ↦ textbookLangevinSmoothCutoff_force_eq U A hA (qr s) (hqrA s hs))
  let B : ℝ → ℝ := fun ε ↦
    gronwallBound 0 (1 + (L : ℝ) + ‖γ‖) ((1 + ‖γ‖) * ‖σ‖ * ε) T + ‖σ‖ * ε
  have hc : Continuous B :=
    ((gronwallBound_continuous_ε 0 (1 + (L : ℝ) + ‖γ‖) T).comp
      (continuous_const.mul continuous_id)).add (continuous_const.mul continuous_id)
  have hB0 : B 0 = 0 := by simp [B, gronwallBound_ε0_δ0]
  have hn : {ε | B ε < r} ∈ 𝓝 (0 : ℝ) :=
    hc.continuousAt.preimage_mem_nhds (Iio_mem_nhds (by simpa [hB0] using hr))
  obtain ⟨η, hη, hηB⟩ := Metric.mem_nhds_iff.mp hn
  let ε := η / 2
  have hε : 0 < ε := by dsimp [ε]; positivity
  have hsmall : B ε < r := by
    apply hηB
    rw [Metric.mem_ball, Real.dist_eq, sub_zero, abs_of_pos hε]
    dsimp [ε]
    linarith
  refine ⟨ε, hε, ?_⟩
  intro W q p hSol htube
  let d : ℝ → ℝ := fun t ↦ dist (q t, p t) (qr t, pr t)
  have hd : ContinuousOn d (Icc 0 T) := by
    intro t ht
    exact ((hSol.1.prodMk hSol.2.1) t ht).dist ((hqr.prodMk hpr).continuousWithinAt)
  have hm0 : (0 : ℝ) ∈ Icc 0 T := ⟨le_rfl, hT.le⟩
  obtain ⟨hq0, hp0, hqT, hpT⟩ := textbookLangevinControl_endpoints T hT x y
  have hqinitial : q 0 = x.1 := by simpa using hSol.2.2.2.2.1 0 hm0
  have hpinitial : p 0 = x.2 := by
    simpa [hSol.2.2.2.1] using hSol.2.2.2.2.2 0 hm0
  have hd0 : d 0 = 0 := by simp [d, qr, pr, hqinitial, hpinitial, hq0, hp0]
  have hstay : ∀ t ∈ Icc 0 T, d t < r := by
    by_contra hn
    push Not at hn
    obtain ⟨τ, hτ, hdτ, hbefore⟩ := textbookContinuous_firstExit hd (by simpa [hd0] using hr) hn
    have hqA (s : ℝ) (hs : s ∈ Icc 0 τ) : ‖q s‖ < A := by
      have hsT : s ∈ Icc 0 T := ⟨hs.1, hs.2.trans hτ.2⟩
      have hdist : ‖q s - qr s‖ ≤ d s := by
        dsimp [d]
        rw [dist_eq_norm, Prod.norm_def]
        exact le_max_left _ _
      have hb := hbefore s hs
      have hm := (hM s hsT).trans (le_max_left M 0)
      have hnorm : ‖q s‖ ≤ ‖q s - qr s‖ + ‖qr s‖ := by
        simpa using norm_add_le (q s - qr s) (qr s)
      dsimp [A]
      linarith
    have hSolV := textbookLangevinIntegralSolution_changePotential U V γ σ T τ hτ.2
      x W q p hSol (fun s hs ↦ textbookLangevinSmoothCutoff_force_eq U A hA (q s) (hqA s hs))
    have hRefτ := textbookLangevinIntegralSolution_changePotential V V γ σ T τ hτ.2
      x R qr pr hRefV (fun _ _ ↦ rfl)
    have htubeτ : ∀ s ∈ Icc 0 τ, ‖W s - R s‖ ≤ ε :=
      fun s hs ↦ htube s ⟨hs.1, hs.2.trans hτ.2⟩
    have hb := textbookLangevinNoise_phase_dist_le V (hV.of_le (by simp)) L hL γ σ τ ε
      hτ.1 hε.le x W R q p qr pr hSolV hRefτ htubeτ τ ⟨hτ.1, le_rfl⟩
    have hg : gronwallBound 0 (1 + (L : ℝ) + ‖γ‖) ((1 + ‖γ‖) * ‖σ‖ * ε) τ ≤
        gronwallBound 0 (1 + (L : ℝ) + ‖γ‖) ((1 + ‖γ‖) * ‖σ‖ * ε) T :=
      gronwallBound_mono (by norm_num) (by positivity) (by positivity) hτ.2
    have hB : d τ ≤ B ε := hb.trans (add_le_add hg (le_refl _))
    rw [hdτ] at hB
    exact (not_le_of_gt hsmall) hB
  have hend := hstay T ⟨hT.le, le_rfl⟩
  have he : (qr T, pr T) = y := Prod.ext hqT hpT
  change dist (q T, p T) (qr T, pr T) < r at hend
  rw [he] at hend
  exact hend.trans (by dsimp [r]; linarith)

end MolecularDynamics
