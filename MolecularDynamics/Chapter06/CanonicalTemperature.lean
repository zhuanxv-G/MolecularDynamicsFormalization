import MolecularDynamics.Chapter08.ThermostatDensity
import Mathlib.Analysis.Calculus.LineDeriv.IntegrationByParts
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.Analysis.SpecialFunctions.SmoothTransition

/-! Genuine canonical averages and weighted divergence needed for Proposition 6.1,
printed 222 / PDF 243. The full-space integration-by-parts step is separate. -/

open Set Filter MeasureTheory
open scoped Topology BigOperators

namespace MolecularDynamics

/-- The actual canonical partition integral on the textbook's full 2Nc-dimensional phase space. -/
noncomputable def textbookCanonicalPartition {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) : ℝ :=
  ∫ z, textbookHamiltonianGibbsWeight H β z

/-- Canonical average with the actual partition normalization, whose positivity is proved under integrability. -/
noncomputable def textbookCanonicalAverage {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ * ∫ z, f z * textbookHamiltonianGibbsWeight H β z

/-- The true partition function is strictly positive whenever the actual Gibbs weight is integrable. -/
theorem textbookCanonicalPartition_pos {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ)
    (hρ : Integrable (textbookHamiltonianGibbsWeight H β)) :
    0 < textbookCanonicalPartition H β := by
  exact integral_exp_pos hρ

/-- The actual normalized canonical average of one is one. -/
theorem textbookCanonicalAverage_one {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ)
    (hρ : Integrable (textbookHamiltonianGibbsWeight H β)) :
    textbookCanonicalAverage H β (fun _ ↦ 1) = 1 := by
  have hZ := (textbookCanonicalPartition_pos H β hρ).ne'
  simp only [textbookCanonicalAverage, one_mul]
  exact inv_mul_cancel₀ hZ

/-- The genuine derivative of the same actual Gibbs weight. -/
theorem textbookHamiltonianGibbsWeight_hasFDerivAt {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) (z : SymplecticCoordinates Nc)
    (hH : DifferentiableAt ℝ H z) :
    HasFDerivAt (textbookHamiltonianGibbsWeight H β)
      (textbookHamiltonianGibbsWeight H β z • (-β • fderiv ℝ H z)) z :=
  (hH.hasFDerivAt.const_mul (-β)).exp

/-- The actual Gibbs weighted flux satisfies the exact divergence identity used by the temperature formula. -/
theorem textbookCanonicalWeightedFlux_divergence {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (z : SymplecticCoordinates Nc)
    (hH : DifferentiableAt ℝ H z) (hG : DifferentiableAt ℝ G z) :
    textbookDivergence (fun x ↦ textbookHamiltonianGibbsWeight H β x • G x) z =
      textbookHamiltonianGibbsWeight H β z *
        (textbookDivergence G z - β * textbookLieDerivative G H z) := by
  have hρ := textbookHamiltonianGibbsWeight_hasFDerivAt H β z hH
  rw [textbookDivergence_density hρ.differentiableAt hG, hρ.fderiv]
  simp only [_root_.smul_apply, smul_eq_mul, textbookLieDerivative]
  ring

/-- The full weighted-flux divergence is integrable from the actual two weighted observables in Proposition 6.1. -/
theorem textbookCanonicalWeightedFlux_divergence_integrable {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (hH : Differentiable ℝ H) (hG : Differentiable ℝ G)
    (hdiv : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H β z))
    (henergy : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z)) :
    Integrable (textbookDivergence (fun z ↦ textbookHamiltonianGibbsWeight H β z • G z)) := by
  apply (hdiv.sub (henergy.const_mul β)).congr
  filter_upwards [] with z
  simp only [Pi.sub_apply]
  rw [textbookCanonicalWeightedFlux_divergence H G β z (hH z) (hG z)]
  ring


/-- The actual derivative of a C1 compactly supported phase field has zero integral in every constant direction. -/
theorem textbookCompactPhaseField_integral_fderiv_eq_zero {Nc : ℕ}
    (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hG : ContDiff ℝ 1 G) (hs : HasCompactSupport G) (v : SymplecticCoordinates Nc) :
    (∫ z, (fderiv ℝ G z) v) = 0 := by
  have hg : Integrable G := hG.continuous.integrable_of_hasCompactSupport hs
  have hd : Integrable (fun z ↦ (fderiv ℝ G z) v) :=
    ((hG.continuous_fderiv (by norm_num)).clm_apply continuous_const).integrable_of_hasCompactSupport
      (hs.fderiv_apply ℝ v)
  have hi := integral_smul_fderiv_eq_neg_fderiv_smul_of_integrable
    (f := fun _ : SymplecticCoordinates Nc ↦ (1 : ℝ)) (g := G) (v := v)
    (by simp) (by simpa using hd) (by simpa using hg)
    (fun _ _ ↦ differentiableAt_const _) (fun z _ ↦ hG.differentiable_one z)
  simpa using hi

/-- The true trace divergence equals the sum of the actual coordinate derivatives. -/
theorem textbookPhaseField_divergence_coordinates {Nc : ℕ}
    (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (z : SymplecticCoordinates Nc) :
    textbookDivergence G z =
      ∑ i : Fin Nc ⊕ Fin Nc, (fderiv ℝ G z (Pi.single i 1)) i := by
  unfold textbookDivergence
  rw [LinearMap.trace_eq_matrix_trace ℝ (Pi.basisFun ℝ (Fin Nc ⊕ Fin Nc))]
  simp [Matrix.trace]

/-- The actual divergence of a C1 compactly supported phase field has zero full-space Lebesgue integral. -/
theorem textbookCompactPhaseField_integral_divergence_eq_zero {Nc : ℕ}
    (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hG : ContDiff ℝ 1 G) (hs : HasCompactSupport G) :
    (∫ z, textbookDivergence G z) = 0 := by
  have hd (i : Fin Nc ⊕ Fin Nc) : Integrable (fun z ↦ (fderiv ℝ G z) (Pi.single i 1)) :=
    ((hG.continuous_fderiv (by norm_num)).clm_apply continuous_const).integrable_of_hasCompactSupport
      (hs.fderiv_apply ℝ (Pi.single i 1))
  have hc (i : Fin Nc ⊕ Fin Nc) :
      Integrable (fun z ↦ (fderiv ℝ G z (Pi.single i 1)) i) :=
    (ContinuousLinearMap.proj i : SymplecticCoordinates Nc →L[ℝ] ℝ).integrable_comp (hd i)
  calc
    (∫ z, textbookDivergence G z) =
        ∫ z, ∑ i : Fin Nc ⊕ Fin Nc, (fderiv ℝ G z (Pi.single i 1)) i :=
      integral_congr_ae (.of_forall (textbookPhaseField_divergence_coordinates G))
    _ = ∑ i : Fin Nc ⊕ Fin Nc, ∫ z, (fderiv ℝ G z (Pi.single i 1)) i :=
      integral_finsetSum _ (fun i _ ↦ hc i)
    _ = 0 := by
      apply Finset.sum_eq_zero
      intro i _
      change (∫ z, (ContinuousLinearMap.proj i : SymplecticCoordinates Nc →L[ℝ] ℝ)
        (fderiv ℝ G z (Pi.single i 1))) = 0
      rw [ContinuousLinearMap.integral_comp_comm _ (hd i),
        textbookCompactPhaseField_integral_fderiv_eq_zero G hG hs]
      exact map_zero _

/-- The actual smooth energy/density cutoff: zero below the Gibbs threshold exp(-2R), and one above exp(-R). -/
noncomputable def textbookCanonicalDensityCutoff {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β R : ℝ) (z : SymplecticCoordinates Nc) : ℝ :=
  Real.smoothTransition (2 - β * H z / R)

/-- The actual density cutoff lies between zero and one. -/
theorem textbookCanonicalDensityCutoff_mem_Icc {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β R : ℝ) (z : SymplecticCoordinates Nc) :
    textbookCanonicalDensityCutoff H β R z ∈ Icc 0 1 :=
  ⟨Real.smoothTransition.nonneg _, Real.smoothTransition.le_one _⟩

/-- The actual density cutoff preserves the true C1 regularity of H. -/
theorem textbookCanonicalDensityCutoff_contDiff {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β R : ℝ) (hH : ContDiff ℝ 1 H) :
    ContDiff ℝ 1 (textbookCanonicalDensityCutoff H β R) := by
  exact Real.smoothTransition.contDiff.comp (contDiff_const.sub ((contDiff_const.mul hH).div_const R))

/-- The actual cutoff derivative has the explicit 1/R factor needed for the full-space limit. -/
theorem textbookCanonicalDensityCutoff_hasFDerivAt {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β R : ℝ) (z : SymplecticCoordinates Nc)
    (hH : DifferentiableAt ℝ H z) :
    HasFDerivAt (textbookCanonicalDensityCutoff H β R)
      ((deriv Real.smoothTransition (2 - β * H z / R)) •
        (-(R⁻¹ • (β • fderiv ℝ H z)))) z := by
  have ht : DifferentiableAt ℝ Real.smoothTransition (2 - β * H z / R) :=
    (Real.smoothTransition.contDiff (n := 1)).differentiable_one _
  have ha : HasFDerivAt (fun x ↦ 2 - β * H x / R)
      (-(R⁻¹ • (β • fderiv ℝ H z))) z := by
    simpa only [Pi.sub_def, Pi.smul_def, smul_eq_mul, div_eq_mul_inv, mul_comm, zero_sub] using
      (hasFDerivAt_const (2 : ℝ) z).sub
        ((hH.hasFDerivAt.const_mul β).const_smul R⁻¹)
  exact ht.hasDerivAt.comp_hasFDerivAt z ha

/-- A nonzero actual cutoff guarantees the explicit Gibbs lower bound, derived from H rather than assumed. -/
theorem textbookCanonicalDensityCutoff_gibbs_lower {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β R : ℝ) (hR : 0 < R) (z : SymplecticCoordinates Nc)
    (hc : textbookCanonicalDensityCutoff H β R z ≠ 0) :
    Real.exp (-2 * R) < textbookHamiltonianGibbsWeight H β z := by
  have ht : 0 < 2 - β * H z / R :=
    lt_of_not_ge (fun h ↦ hc (Real.smoothTransition.zero_of_nonpos h))
  have hHR : β * H z < 2 * R := (div_lt_iff₀ hR).mp (by linarith)
  exact Real.exp_lt_exp.mpr (by linarith)

/-- The bounded weighted field in the original proposition has genuinely integrable density cutoffs, without a weighted-field L1 hypothesis. -/
theorem textbookCanonicalDensityCutoff_flux_integrable {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β R : ℝ) (hR : 0 < R) (hH : ContDiff ℝ 1 H) (hG : Continuous G)
    (hρ : Integrable (textbookHamiltonianGibbsWeight H β))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H β z • G z‖ ≤ C) :
    Integrable (fun z ↦ textbookCanonicalDensityCutoff H β R z •
      (textbookHamiltonianGibbsWeight H β z • G z)) := by
  have hc := (textbookCanonicalDensityCutoff_contDiff H β R hH).continuous
  have hw : Continuous (textbookHamiltonianGibbsWeight H β) :=
    Real.continuous_exp.comp (continuous_const.mul hH.continuous)
  apply (hρ.const_mul (C * Real.exp (2 * R))).mono'
    ((hc.smul (hw.smul hG)).aestronglyMeasurable)
  filter_upwards [] with z
  change ‖textbookCanonicalDensityCutoff H β R z •
    (textbookHamiltonianGibbsWeight H β z • G z)‖ ≤
      (C * Real.exp (2 * R)) * textbookHamiltonianGibbsWeight H β z
  by_cases hz : textbookCanonicalDensityCutoff H β R z = 0
  · simp only [hz, zero_smul, norm_zero]
    exact mul_nonneg (mul_nonneg hC (Real.exp_pos _).le)
      (textbookHamiltonianGibbsWeight_pos H β z).le
  · have hlo := textbookCanonicalDensityCutoff_gibbs_lower H β R hR z hz
    have hρlo : 1 ≤ Real.exp (2 * R) * textbookHamiltonianGibbsWeight H β z := by
      change 1 ≤ Real.exp (2 * R) * Real.exp (-β * H z)
      rw [← Real.exp_add]
      apply Real.one_le_exp
      have hHR : -2 * R < -β * H z := Real.exp_lt_exp.mp hlo
      linarith
    have h01 := textbookCanonicalDensityCutoff_mem_Icc H β R z
    rw [norm_smul, Real.norm_eq_abs, abs_of_nonneg h01.1]
    calc
      textbookCanonicalDensityCutoff H β R z *
          ‖textbookHamiltonianGibbsWeight H β z • G z‖ ≤
          1 * C := mul_le_mul h01.2 (hbound z) (norm_nonneg _) (by norm_num)
      _ ≤ (C * Real.exp (2 * R)) * textbookHamiltonianGibbsWeight H β z := by nlinarith

/-- At every fixed phase point, the actual growing density cutoffs are eventually exactly one. -/
theorem textbookCanonicalDensityCutoff_eventually_one {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) (z : SymplecticCoordinates Nc) :
    ∀ᶠ n : ℕ in atTop, textbookCanonicalDensityCutoff H β (n + 1) z = 1 := by
  filter_upwards [eventually_ge_atTop (Nat.ceil (β * H z))] with n hn
  have hc : β * H z ≤ (n : ℝ) := (Nat.le_ceil (β * H z)).trans (by exact_mod_cast hn)
  apply Real.smoothTransition.one_of_one_le
  have hpos : 0 < (n : ℝ) + 1 := by positivity
  have hd : β * H z / ((n : ℝ) + 1) ≤ 1 := (div_le_iff₀ hpos).mpr (by linarith)
  linarith

/-- The actual density-cutoff flux has the exact divergence formula with an explicit 1/R error term. -/
theorem textbookCanonicalDensityCutoff_flux_divergence {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β R : ℝ) (z : SymplecticCoordinates Nc)
    (hH : DifferentiableAt ℝ H z) (hG : DifferentiableAt ℝ G z) :
    textbookDivergence (fun x ↦ textbookCanonicalDensityCutoff H β R x •
      (textbookHamiltonianGibbsWeight H β x • G x)) z =
      textbookCanonicalDensityCutoff H β R z *
        textbookDivergence (fun x ↦ textbookHamiltonianGibbsWeight H β x • G x) z -
      (β / R) * deriv Real.smoothTransition (2 - β * H z / R) *
        (textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z) := by
  have hc := textbookCanonicalDensityCutoff_hasFDerivAt H β R z hH
  have hw := textbookHamiltonianGibbsWeight_hasFDerivAt H β z hH
  have hf : DifferentiableAt ℝ (fun x ↦ textbookHamiltonianGibbsWeight H β x • G x) z := by
    simpa only [Pi.smul_def'] using hw.differentiableAt.smul hG
  rw [textbookDivergence_density hc.differentiableAt hf, hc.fderiv]
  simp only [_root_.smul_apply, neg_apply, map_smul,
    smul_eq_mul, textbookLieDerivative, div_eq_mul_inv]
  ring
end MolecularDynamics
