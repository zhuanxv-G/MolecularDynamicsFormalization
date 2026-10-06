import MolecularDynamics.Chapter06.LangevinPeriodicCausalFlow
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic

/-! Variation of constants for the same actual Langevin integral solution.
These pathwise identities supply the genuine process moment dependencies of
Theorem 6.2; the driving path is only continuous, not differentiable. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal

namespace MolecularDynamics
noncomputable section

variable {N : ℕ} (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ 2 U)
  (γ σ T : ℝ) (x : textbookLangevinPhase N) (W q p : ℝ → (Fin N → ℝ))
  (h : textbookLangevinIntegralSolution U γ σ T x W q p)

include hU h

/-- The true compensated momentum, with its integrating factor, has a right derivative even for continuous rough noise. -/
theorem textbookLangevinMomentum_weighted_hasDerivWithinAt
    (s : ℝ) (hs : s ∈ Ico 0 T) :
    HasDerivWithinAt (fun r ↦ Real.exp (γ * r) • (p r - σ • W r))
      (Real.exp (γ * s) • (textbookPotentialForce U (q s) - (γ * σ) • W s))
      (Ici s) s := by
  have hv : HasDerivWithinAt (fun r ↦ p r - σ • W r)
      (textbookPotentialForce U (q s) - γ • p s) (Ici s) s := by
    have hd := (ContinuousLinearMap.snd ℝ (Fin N → ℝ) (Fin N → ℝ)).hasFDerivAt.comp_hasDerivWithinAt s
      (textbookLangevinNoiseCompensated_hasDerivWithinAt U hU γ σ T x W q p h s hs)
    change HasDerivWithinAt (fun r ↦ p r - σ • W r)
      (textbookPotentialForce U (q s) - γ • ((p s - σ • W s) + σ • W s)) (Ici s) s at hd
    simpa only [sub_add_cancel] using hd
  have he : HasDerivAt (fun r : ℝ ↦ Real.exp (γ * r)) (Real.exp (γ * s) * γ) s := by
    simpa [Function.comp_def] using (Real.hasDerivAt_exp (γ * s)).comp s ((hasDerivAt_id s).const_mul γ)
  convert! he.hasDerivWithinAt.smul hv using 1
  module

/-- Applying genuine right-derivative FTC to the actual integral solution gives the weighted momentum equation. -/
theorem textbookLangevinMomentum_weighted_integral
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    Real.exp (γ * t) • (p t - σ • W t) = x.2 +
      ∫ s in 0..t, Real.exp (γ * s) • (textbookPotentialForce U (q s) - (γ * σ) • W s) := by
  have hseg : Icc 0 t ⊆ Icc 0 T := Icc_subset_Icc le_rfl ht.2
  have huseg : uIcc 0 t ⊆ Icc 0 T := by
    rw [uIcc_of_le ht.1]
    exact hseg
  have he : Continuous (fun s : ℝ ↦ Real.exp (γ * s)) :=
    Real.continuous_exp.comp (continuous_const.mul continuous_id)
  have hc : ContinuousOn (fun s ↦ Real.exp (γ * s) • (p s - σ • W s)) (Icc 0 T) :=
    he.continuousOn.smul (h.2.1.fun_sub (h.2.2.1.const_smul σ))
  have hb : ContinuousOn (fun s ↦ Real.exp (γ * s) •
      (textbookPotentialForce U (q s) - (γ * σ) • W s)) (Icc 0 T) :=
    he.continuousOn.smul (((contDiff_textbookPotentialForce U hU).continuous.comp_continuousOn h.1).fun_sub
      (h.2.2.1.const_smul (γ * σ)))
  have hi := intervalIntegral.integral_eq_sub_of_hasDeriv_right_of_le ht.1 (hc.mono hseg)
    (fun s hs ↦ (textbookLangevinMomentum_weighted_hasDerivWithinAt U hU γ σ T x W q p h s
      ⟨hs.1.le, hs.2.trans_le ht.2⟩).mono Ioi_subset_Ici_self)
    ((hb.mono huseg).intervalIntegrable)
  have hinit : p 0 - σ • W 0 = x.2 :=
    congrArg Prod.snd (textbookLangevinNoiseCompensated_initial U γ σ T
      (ht.1.trans ht.2) x W q p h)
  simp only [mul_zero, Real.exp_zero, one_smul, hinit] at hi
  rw [hi]
  abel

/-- Undoing the integrating factor preserves the original rough driving path and specified initial momentum. -/
theorem textbookLangevinMomentum_variation_of_constants
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    p t = σ • W t + Real.exp (-γ * t) • (x.2 +
      ∫ s in 0..t, Real.exp (γ * s) • (textbookPotentialForce U (q s) - (γ * σ) • W s)) := by
  rw [← textbookLangevinMomentum_weighted_integral U hU γ σ T x W q p h t ht,
    smul_smul]
  have he : Real.exp (-γ * t) * Real.exp (γ * t) = 1 := by
    rw [← Real.exp_add]
    convert Real.exp_zero using 1
    ring
  rw [he, one_smul]
  abel

/-- The true Langevin momentum is the damped initial momentum plus the actual force convolution and the same Wiener path convolution. -/
theorem textbookLangevinMomentum_duhamel
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    p t = Real.exp (-γ * t) • x.2 +
      (∫ s in 0..t, Real.exp (-γ * (t - s)) • textbookPotentialForce U (q s)) +
      σ • (W t - γ • (∫ s in 0..t, Real.exp (-γ * (t - s)) • W s)) := by
  have hseg : uIcc 0 t ⊆ Icc 0 T := by
    rw [uIcc_of_le ht.1]
    exact Icc_subset_Icc le_rfl ht.2
  have he : Continuous (fun s : ℝ ↦ Real.exp (γ * s)) :=
    Real.continuous_exp.comp (continuous_const.mul continuous_id)
  have hFint : IntervalIntegrable (fun s ↦ Real.exp (γ * s) • textbookPotentialForce U (q s)) volume 0 t :=
    ((he.continuousOn.smul ((contDiff_textbookPotentialForce U hU).continuous.comp_continuousOn h.1)).mono hseg).intervalIntegrable

  have hc (s : ℝ) : Real.exp (-γ * t) * Real.exp (γ * s) = Real.exp (-γ * (t - s)) := by
    rw [← Real.exp_add]
    congr 1
    ring
  have hf (f : ℝ → (Fin N → ℝ)) :
      Real.exp (-γ * t) • (∫ s in 0..t, Real.exp (γ * s) • f s) =
        ∫ s in 0..t, Real.exp (-γ * (t - s)) • f s := by
    rw [← intervalIntegral.integral_smul]
    apply intervalIntegral.integral_congr
    intro s _
    dsimp only
    rw [smul_smul, hc]
  have hs : (∫ s in 0..t, Real.exp (γ * s) •
      (textbookPotentialForce U (q s) - (γ * σ) • W s)) =
      (∫ s in 0..t, Real.exp (γ * s) • textbookPotentialForce U (q s)) -
      (γ * σ) • (∫ s in 0..t, Real.exp (γ * s) • W s) := by
    simp_rw [smul_sub, smul_comm (Real.exp (γ * _)) (γ * σ)]
    have hWint' : IntervalIntegrable (fun s ↦ (γ * σ) • (Real.exp (γ * s) • W s)) volume 0 t := by
      exact (((he.continuousOn.smul h.2.2.1).const_smul (γ * σ)).mono hseg).intervalIntegrable
    rw [intervalIntegral.integral_sub hFint hWint', intervalIntegral.integral_smul]
  rw [textbookLangevinMomentum_variation_of_constants U hU γ σ T x W q p h t ht,
    smul_add, hs, smul_sub, hf, smul_comm (Real.exp (-γ * t)) (γ * σ), hf]
  module

end


noncomputable section

/-- The actual damped additive noise obtained from the same continuous driving path by variation of constants. Equality with a stochastic integral and its moments are separate obligations. -/
def textbookLangevinDampedNoise {N : ℕ} (γ σ : ℝ) (W : ℝ → (Fin N → ℝ)) (t : ℝ) :
    Fin N → ℝ :=
  σ • (W t - γ • (∫ s in 0..t, Real.exp (-γ * (t - s)) • W s))

private theorem damping_kernel_integral (γ t : ℝ) (hγ : 0 < γ) :
    (∫ s in 0..t, Real.exp (-γ * (t - s))) = (1 - Real.exp (-γ * t)) / γ := by
  have hc : Continuous (fun s : ℝ ↦ Real.exp (-γ * (t - s))) := by fun_prop
  have hd (s : ℝ) : HasDerivAt (fun r ↦ Real.exp (-γ * (t - r)) / γ)
      (Real.exp (-γ * (t - s))) s := by
    have ha : HasDerivAt (fun r : ℝ ↦ -γ * (t - r)) γ s := by
      simpa [Function.comp_def] using ((hasDerivAt_const s t).sub (hasDerivAt_id s)).const_mul (-γ)
    convert ((Real.hasDerivAt_exp (-γ * (t - s))).comp s ha).div_const γ using 1
    · rfl
    · field_simp
  have hi := intervalIntegral.integral_eq_sub_of_hasDerivAt (fun s _ ↦ hd s) (hc.intervalIntegrable 0 t)
  rw [hi]
  simp only [sub_self, mul_zero, Real.exp_zero, sub_zero]
  ring

/-- The actual force convolution is bounded by the genuine damping-kernel mass, derived by ordinary integration. -/
theorem textbookLangevinMomentum_force_convolution_bound {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ 2 U)
    (γ t M : ℝ) (hγ : 0 < γ) (ht : 0 ≤ t)
    (hM : ∀ z, ‖textbookPotentialForce U z‖ ≤ M)
    (q : ℝ → (Fin N → ℝ)) (hq : ContinuousOn q (Icc 0 t)) :
    ‖∫ s in 0..t, Real.exp (-γ * (t - s)) • textbookPotentialForce U (q s)‖ ≤
      M * ((1 - Real.exp (-γ * t)) / γ) := by
  have he : Continuous (fun s : ℝ ↦ Real.exp (-γ * (t - s))) := by fun_prop
  have hb : IntervalIntegrable (fun s : ℝ ↦ Real.exp (-γ * (t - s)) * M) volume 0 t :=
    (he.mul continuous_const).intervalIntegrable 0 t
  calc
    _ ≤ ∫ s in 0..t, ‖Real.exp (-γ * (t - s)) • textbookPotentialForce U (q s)‖ :=
      intervalIntegral.norm_integral_le_integral_norm ht
    _ ≤ ∫ s in 0..t, Real.exp (-γ * (t - s)) * M := by
      have hf : IntervalIntegrable (fun s ↦ Real.exp (-γ * (t - s)) • textbookPotentialForce U (q s)) volume 0 t := by
        have hh : ContinuousOn (fun s ↦ Real.exp (-γ * (t - s)) • textbookPotentialForce U (q s)) (uIcc 0 t) := by
          rw [uIcc_of_le ht]
          exact he.continuousOn.smul ((contDiff_textbookPotentialForce U hU).continuous.comp_continuousOn hq)
        exact hh.intervalIntegrable
      exact intervalIntegral.integral_mono_on ht hf.norm hb (fun s _ ↦ by
        rw [norm_smul, Real.norm_of_nonneg (Real.exp_pos _).le]
        exact mul_le_mul_of_nonneg_left (hM (q s)) (Real.exp_pos _).le)
    _ = M * ((1 - Real.exp (-γ * t)) / γ) := by
      rw [intervalIntegral.integral_mul_const, damping_kernel_integral γ t hγ, mul_comm]

/-- The same force convolution has a time-uniform bound for positive friction; no moment bound is assumed. -/
theorem textbookLangevinMomentum_force_convolution_uniform_bound {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ 2 U)
    (γ t M : ℝ) (hγ : 0 < γ) (ht : 0 ≤ t) (hM0 : 0 ≤ M)
    (hM : ∀ z, ‖textbookPotentialForce U z‖ ≤ M)
    (q : ℝ → (Fin N → ℝ)) (hq : ContinuousOn q (Icc 0 t)) :
    ‖∫ s in 0..t, Real.exp (-γ * (t - s)) • textbookPotentialForce U (q s)‖ ≤ M / γ := by
  calc
    _ ≤ M * ((1 - Real.exp (-γ * t)) / γ) :=
      textbookLangevinMomentum_force_convolution_bound U hU γ t M hγ ht hM q hq
    _ ≤ M * (1 / γ) := mul_le_mul_of_nonneg_left
      (div_le_div_of_nonneg_right (by linarith [Real.exp_pos (-γ * t)]) hγ.le) hM0
    _ = M / γ := by ring

/-- The actual momentum estimate separates its damped initial value and bounded force from the genuine additive noise convolution. -/
theorem textbookLangevinMomentum_norm_le {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ 2 U)
    (γ σ T : ℝ) (hγ : 0 < γ) (x : textbookLangevinPhase N)
    (W q p : ℝ → (Fin N → ℝ)) (h : textbookLangevinIntegralSolution U γ σ T x W q p)
    (M : ℝ) (hM0 : 0 ≤ M) (hM : ∀ z, ‖textbookPotentialForce U z‖ ≤ M)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    ‖p t‖ ≤ Real.exp (-γ * t) * ‖x.2‖ + M / γ + ‖textbookLangevinDampedNoise γ σ W t‖ := by
  have he := textbookLangevinMomentum_duhamel U hU γ σ T x W q p h t ht
  change p t = Real.exp (-γ * t) • x.2 +
    (∫ s in 0..t, Real.exp (-γ * (t - s)) • textbookPotentialForce U (q s)) +
    textbookLangevinDampedNoise γ σ W t at he
  rw [he]
  calc
    _ ≤ ‖Real.exp (-γ * t) • x.2‖ +
        ‖∫ s in 0..t, Real.exp (-γ * (t - s)) • textbookPotentialForce U (q s)‖ +
        ‖textbookLangevinDampedNoise γ σ W t‖ :=
      (norm_add_le _ _).trans (add_le_add (norm_add_le _ _) le_rfl)
    _ ≤ Real.exp (-γ * t) * ‖x.2‖ + M / γ + ‖textbookLangevinDampedNoise γ σ W t‖ := by
      rw [norm_smul, Real.norm_of_nonneg (Real.exp_pos _).le]
      exact add_le_add (add_le_add le_rfl
        (textbookLangevinMomentum_force_convolution_uniform_bound U hU γ t M hγ ht.1 hM0 hM q
          (h.1.mono (Icc_subset_Icc le_rfl ht.2)))) le_rfl

/-- Periodicity supplies the actual global force bound used in the process Lyapunov proof, uniformly in the initial phase and time. -/
theorem textbookLangevinMomentum_periodic_norm_bound {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) (hγ : 0 < γ) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ T x W q p, textbookLangevinIntegralSolution U γ σ T x W q p →
      ∀ t ∈ Icc 0 T, ‖p t‖ ≤ Real.exp (-γ * t) * ‖x.2‖ + M / γ +
        ‖textbookLangevinDampedNoise γ σ W t‖ := by
  obtain ⟨M, hM0, hM⟩ := textbookUnitPeriodicPotential_force_bound U hU hp
  exact ⟨M, hM0, fun T x W q p h t ht ↦ textbookLangevinMomentum_norm_le U
    (hU.of_le (by simp)) γ σ T hγ x W q p h M hM0 hM t ht⟩

/-- The single already constructed all-time Wiener-driven process obeys the Duhamel equation at every nonnegative time on one common full-measure set. -/
theorem textbookLangevinGlobalRandomPhase_momentum_duhamel_ae {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPhase N) :
    ∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t →
      (textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample).2 =
        Real.exp (-γ * t) • x.2 +
        (∫ s in 0..t, Real.exp (-γ * (t - s)) •
          textbookPotentialForce U (textbookLangevinGlobalRandomPhase U L hF γ σ x B s sample).1) +
        textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) t := by
  filter_upwards [textbookLangevinGlobalRandomPhase_integralSolution_ae B P hB U hU L hF γ σ x]
    with sample hs
  intro t ht
  exact textbookLangevinMomentum_duhamel U hU γ σ t x _ _ _ (hs t ht) t ⟨ht, le_rfl⟩

/-- The original periodic all-time process has the same genuine damped momentum estimate with one force constant for every initial phase. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_bound_ae {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (hγ : 0 < γ) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : textbookLangevinPeriodicPhase N, ∀ᵐ sample ∂P,
      ∀ t : ℝ, 0 ≤ t →
        ‖(textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2‖ ≤
          Real.exp (-γ * t) * ‖x.2‖ + M / γ +
            ‖textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) t‖ := by
  obtain ⟨M, hM0, hM⟩ := textbookUnitPeriodicPotential_force_bound U hU hp
  refine ⟨M, hM0, fun x ↦ ?_⟩
  filter_upwards [textbookLangevinGlobalRandomPhase_integralSolution_ae B P hB U
    (hU.of_le (by simp)) L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2)] with sample hs
  intro t ht
  exact textbookLangevinMomentum_norm_le U (hU.of_le (by simp)) γ σ t hγ
    (textbookLangevinPeriodicRepresentative x.1, x.2) _ _ _ (hs t ht) M hM0 hM t ⟨ht, le_rfl⟩


end

end MolecularDynamics
