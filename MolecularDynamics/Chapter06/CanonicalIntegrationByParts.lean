import MolecularDynamics.Chapter06.CanonicalTemperature
import Mathlib.Analysis.Calculus.BumpFunction.FiniteDimension
import Mathlib.Analysis.Normed.Group.Bounded

/-! Actual full-phase-space cutoffs needed to complete Proposition 6.1,
printed 222 / PDF 243. -/

open Set Filter MeasureTheory
open scoped Topology BigOperators

namespace MolecularDynamics

/-- A genuine fixed smooth bump on the actual 2Nc-dimensional phase space. -/
noncomputable def textbookPhaseSpaceBump (Nc : ℕ) : ContDiffBump (0 : SymplecticCoordinates Nc) :=
  ⟨1, 2, by norm_num, by norm_num⟩

/-- The actual spatial cutoff at radius R, using one fixed bump and actual scalar dilation. -/
noncomputable def textbookPhaseSpaceCutoff (Nc : ℕ) (R : ℝ) (z : SymplecticCoordinates Nc) : ℝ :=
  textbookPhaseSpaceBump Nc (R⁻¹ • z)

/-- The true spatial cutoff is C1. -/
theorem textbookPhaseSpaceCutoff_contDiff (Nc : ℕ) (R : ℝ) :
    ContDiff ℝ 1 (textbookPhaseSpaceCutoff Nc R) :=
  (textbookPhaseSpaceBump Nc).contDiff.comp (contDiff_const_smul R⁻¹)

/-- Every positive-radius actual spatial cutoff is compactly supported. -/
theorem textbookPhaseSpaceCutoff_compact (Nc : ℕ) (R : ℝ) (hR : 0 < R) :
    HasCompactSupport (textbookPhaseSpaceCutoff Nc R) := by
  exact (textbookPhaseSpaceBump Nc).hasCompactSupport.comp_homeomorph
    (Homeomorph.smulOfNeZero R⁻¹ (inv_ne_zero hR.ne'))

/-- The actual spatial cutoff takes values in the interval [0,1]. -/
theorem textbookPhaseSpaceCutoff_mem_Icc (Nc : ℕ) (R : ℝ) (z : SymplecticCoordinates Nc) :
    textbookPhaseSpaceCutoff Nc R z ∈ Icc 0 1 :=
  ⟨(textbookPhaseSpaceBump Nc).nonneg, (textbookPhaseSpaceBump Nc).le_one⟩

/-- Each phase point eventually lies in the actual spatial cutoff's plateau. -/
theorem textbookPhaseSpaceCutoff_eventually_one (Nc : ℕ) (z : SymplecticCoordinates Nc) :
    ∀ᶠ n : ℕ in atTop, textbookPhaseSpaceCutoff Nc (n + 1) z = 1 := by
  filter_upwards [eventually_ge_atTop (Nat.ceil ‖z‖)] with n hn
  have hz : ‖z‖ ≤ (n : ℝ) := (Nat.le_ceil ‖z‖).trans (by exact_mod_cast hn)
  apply (textbookPhaseSpaceBump Nc).one_of_mem_closedBall
  rw [Metric.mem_closedBall, dist_zero_right]
  change ‖((n : ℝ) + 1)⁻¹ • z‖ ≤ 1
  have hR : 0 < (n : ℝ) + 1 := by positivity
  rw [norm_smul, Real.norm_eq_abs, abs_of_pos (inv_pos.mpr hR)]
  calc
    ((n : ℝ) + 1)⁻¹ * ‖z‖ ≤ ((n : ℝ) + 1)⁻¹ * ((n : ℝ) + 1) :=
      mul_le_mul_of_nonneg_left (by linarith) (inv_nonneg.mpr hR.le)
    _ = 1 := inv_mul_cancel₀ hR.ne'

/-- The actual derivative of the spatial dilation is exactly R^-1 times the fixed bump derivative. -/
theorem textbookPhaseSpaceCutoff_fderiv (Nc : ℕ) (R : ℝ) (z : SymplecticCoordinates Nc) :
    fderiv ℝ (textbookPhaseSpaceCutoff Nc R) z =
      R⁻¹ • fderiv ℝ (textbookPhaseSpaceBump Nc) (R⁻¹ • z) := by
  have hb : DifferentiableAt ℝ (textbookPhaseSpaceBump Nc) (R⁻¹ • z) :=
    ((textbookPhaseSpaceBump Nc).contDiff (n := 1)).differentiable_one _
  have he : HasFDerivAt (textbookPhaseSpaceCutoff Nc R)
      ((fderiv ℝ (textbookPhaseSpaceBump Nc) (R⁻¹ • z)).comp
        (R⁻¹ • ContinuousLinearMap.id ℝ (SymplecticCoordinates Nc))) z :=
    hb.hasFDerivAt.comp z ((hasFDerivAt_id z).const_smul R⁻¹)
  rw [he.fderiv]
  ext v
  simp

/-- A single derived constant controls all actual spatial-cutoff derivatives by C/R. -/
theorem textbookPhaseSpaceCutoff_fderiv_bound (Nc : ℕ) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ R : ℝ, 0 < R → ∀ z : SymplecticCoordinates Nc,
      ‖fderiv ℝ (textbookPhaseSpaceCutoff Nc R) z‖ ≤ C / R := by
  have hb : ContDiff ℝ 1 (textbookPhaseSpaceBump Nc) := (textbookPhaseSpaceBump Nc).contDiff
  obtain ⟨C, hC⟩ := ((textbookPhaseSpaceBump Nc).hasCompactSupport.fderiv ℝ).exists_bound_of_continuous
    (hb.continuous_fderiv (by norm_num))
  refine ⟨C, (norm_nonneg _).trans (hC 0), ?_⟩
  intro R hR z
  rw [textbookPhaseSpaceCutoff_fderiv, norm_smul, Real.norm_eq_abs, abs_of_pos (inv_pos.mpr hR)]
  calc
    R⁻¹ * ‖fderiv ℝ (textbookPhaseSpaceBump Nc) (R⁻¹ • z)‖ ≤ R⁻¹ * C :=
      mul_le_mul_of_nonneg_left (hC _) (inv_nonneg.mpr hR.le)
    _ = C / R := by ring


/-- True trace divergence of a C1 phase field is continuous. -/
theorem textbookPhaseField_divergence_continuous {Nc : ℕ}
    (F : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (hF : ContDiff ℝ 1 F) :
    Continuous (textbookDivergence F) := by
  change Continuous (fun z ↦ textbookDivergence F z)
  simp_rw [textbookPhaseField_divergence_coordinates]
  apply continuous_finsetSum
  intro i _
  exact (continuous_apply i).comp
    ((hF.continuous_fderiv (by norm_num)).clm_apply continuous_const)

/-- Full-space integration of the genuine divergence vanishes when the actual C1 field and its actual divergence are integrable. -/
theorem textbookPhaseField_integral_divergence_eq_zero {Nc : ℕ}
    (F : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hF : ContDiff ℝ 1 F) (hFI : Integrable F) (hDI : Integrable (textbookDivergence F)) :
    (∫ z, textbookDivergence F z) = 0 := by
  obtain ⟨C, hC, hderiv⟩ := textbookPhaseSpaceCutoff_fderiv_bound Nc
  let η : ℕ → SymplecticCoordinates Nc → ℝ := fun n ↦ textbookPhaseSpaceCutoff Nc (n + 1)
  let V : ℕ → SymplecticCoordinates Nc → SymplecticCoordinates Nc := fun n z ↦ η n z • F z
  have hR (n : ℕ) : 0 < (n : ℝ) + 1 := by positivity
  have hVC (n : ℕ) : ContDiff ℝ 1 (V n) := by
    simpa only [V, η, Pi.smul_def'] using
      (textbookPhaseSpaceCutoff_contDiff Nc ((n : ℝ) + 1)).smul hF
  have hVS (n : ℕ) : HasCompactSupport (V n) := by
    simpa only [V, η, Pi.smul_def'] using
      (textbookPhaseSpaceCutoff_compact Nc ((n : ℝ) + 1) (hR n)).smul_right (f' := F)
  have heq (n : ℕ) (z : SymplecticCoordinates Nc) :
      textbookDivergence (V n) z = η n z * textbookDivergence F z +
        (fderiv ℝ (η n) z) (F z) := by
    rw [textbookDivergence_density
      ((textbookPhaseSpaceCutoff_contDiff Nc ((n : ℝ) + 1)).differentiable_one z)
      (hF.differentiable_one z)]
    ring
  have hB (n : ℕ) (z : SymplecticCoordinates Nc) :
      ‖(fderiv ℝ (η n) z) (F z)‖ ≤ (C * ‖F z‖) / ((n : ℝ) + 1) := by
    calc
      ‖(fderiv ℝ (η n) z) (F z)‖ ≤ ‖fderiv ℝ (η n) z‖ * ‖F z‖ :=
        (fderiv ℝ (η n) z).le_opNorm _
      _ ≤ (C / ((n : ℝ) + 1)) * ‖F z‖ :=
        mul_le_mul_of_nonneg_right (hderiv _ (hR n) z) (norm_nonneg _)
      _ = (C * ‖F z‖) / ((n : ℝ) + 1) := by ring
  have hbound (n : ℕ) (z : SymplecticCoordinates Nc) :
      ‖textbookDivergence (V n) z‖ ≤ ‖textbookDivergence F z‖ + C * ‖F z‖ := by
    have hη := textbookPhaseSpaceCutoff_mem_Icc Nc ((n : ℝ) + 1) z
    have hmul : ‖η n z * textbookDivergence F z‖ ≤ ‖textbookDivergence F z‖ := by
      rw [norm_mul, Real.norm_eq_abs, abs_of_nonneg hη.1]
      exact (mul_le_mul_of_nonneg_right hη.2 (norm_nonneg _)).trans_eq (one_mul _)
    have hb : (C * ‖F z‖) / ((n : ℝ) + 1) ≤ C * ‖F z‖ := by
      apply (div_le_iff₀ (hR n)).mpr
      have hn : 0 ≤ (n : ℝ) := Nat.cast_nonneg n
      have hc : 0 ≤ C * ‖F z‖ := mul_nonneg hC (norm_nonneg _)
      nlinarith
    rw [heq]
    exact (norm_add_le _ _).trans (add_le_add hmul ((hB n z).trans hb))
  have hr : Tendsto (fun n : ℕ ↦ (n : ℝ) + 1) atTop atTop := by
    apply tendsto_atTop.2
    intro b
    filter_upwards [eventually_ge_atTop (Nat.ceil b)] with n hn
    have hb : b ≤ (n : ℝ) := (Nat.le_ceil b).trans (by exact_mod_cast hn)
    linarith
  have hpoint (z : SymplecticCoordinates Nc) :
      Tendsto (fun n ↦ textbookDivergence (V n) z) atTop (𝓝 (textbookDivergence F z)) := by
    have ha : Tendsto (fun n ↦ η n z * textbookDivergence F z) atTop
        (𝓝 (textbookDivergence F z)) := by
      apply tendsto_const_nhds.congr'
      filter_upwards [textbookPhaseSpaceCutoff_eventually_one Nc z] with n hn
      simp only [η, hn, one_mul]
    have hb : Tendsto (fun n ↦ (fderiv ℝ (η n) z) (F z)) atTop (𝓝 0) :=
      squeeze_zero_norm (fun n ↦ hB n z) (hr.const_div_atTop (C * ‖F z‖))
    apply (show Tendsto (fun n ↦ η n z * textbookDivergence F z +
        (fderiv ℝ (η n) z) (F z)) atTop (𝓝 (textbookDivergence F z)) by
      simpa only [add_zero] using ha.add hb).congr'
    exact .of_forall (fun n ↦ (heq n z).symm)
  have hlim := tendsto_integral_of_dominated_convergence
    (fun z ↦ ‖textbookDivergence F z‖ + C * ‖F z‖)
    (fun n ↦ (textbookPhaseField_divergence_continuous (V n) (hVC n)).aestronglyMeasurable)
    (hDI.norm.add (hFI.norm.const_mul C))
    (fun n ↦ .of_forall (hbound n)) (.of_forall hpoint)
  have hz : (fun n ↦ ∫ z, textbookDivergence (V n) z) = fun _ : ℕ ↦ (0 : ℝ) :=
    funext (fun n ↦ textbookCompactPhaseField_integral_divergence_eq_zero (V n) (hVC n) (hVS n))
  rw [hz] at hlim
  exact tendsto_nhds_unique hlim tendsto_const_nhds

/-- The actual smooth-transition derivative is compactly supported, because the transition is locally constant off [0,1]. -/
theorem textbookCanonicalTransition_deriv_compact :
    HasCompactSupport (deriv Real.smoothTransition) := by
  have hl (x : ℝ) (hx : x < 0) : deriv Real.smoothTransition x = 0 := by
    have he : Real.smoothTransition =ᶠ[𝓝 x] (fun _ : ℝ ↦ 0) := by
      filter_upwards [Iio_mem_nhds hx] with y hy
      exact Real.smoothTransition.zero_of_nonpos hy.le
    rw [he.deriv_eq]
    simp
  have hr (x : ℝ) (hx : 1 < x) : deriv Real.smoothTransition x = 0 := by
    have he : Real.smoothTransition =ᶠ[𝓝 x] (fun _ : ℝ ↦ 1) := by
      filter_upwards [Ioi_mem_nhds hx] with y hy
      exact Real.smoothTransition.one_of_one_le hy.le
    rw [he.deriv_eq]
    simp
  have hs : Function.support (deriv Real.smoothTransition) ⊆ Icc (0 : ℝ) 1 := by
    intro x hx
    exact ⟨le_of_not_gt (fun h ↦ hx (hl x h)), le_of_not_gt (fun h ↦ hx (hr x h))⟩
  change IsCompact (tsupport (deriv Real.smoothTransition))
  exact isCompact_Icc.of_isClosed_subset (isClosed_tsupport _) (closure_minimal hs isClosed_Icc)

/-- One derived constant bounds the actual transition derivative everywhere. -/
theorem textbookCanonicalTransition_deriv_bound :
    ∃ D : ℝ, 0 ≤ D ∧ ∀ s : ℝ, ‖deriv Real.smoothTransition s‖ ≤ D := by
  obtain ⟨D, hD⟩ := textbookCanonicalTransition_deriv_compact.exists_bound_of_continuous
    (Real.smoothTransition.contDiff (n := 1)).continuous_deriv_one
  exact ⟨D, (norm_nonneg _).trans (hD 0), hD⟩

/-- The actual density-cutoff flux divergence is integrable from the original weighted observables; no original weighted-field L1 premise is used. -/
theorem textbookCanonicalDensityCutoff_flux_divergence_integrable {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β R : ℝ) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hDI : Integrable (textbookDivergence (fun z ↦ textbookHamiltonianGibbsWeight H β z • G z)))
    (hEI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z)) :
    Integrable (textbookDivergence (fun z ↦ textbookCanonicalDensityCutoff H β R z •
      (textbookHamiltonianGibbsWeight H β z • G z))) := by
  obtain ⟨D, _, hD⟩ := textbookCanonicalTransition_deriv_bound
  have hc := (textbookCanonicalDensityCutoff_contDiff H β R hH).continuous
  have hd : Continuous (fun z ↦ deriv Real.smoothTransition (2 - β * H z / R)) :=
    (Real.smoothTransition.contDiff (n := 1)).continuous_deriv_one.comp
      (continuous_const.sub ((continuous_const.mul hH.continuous).div_const R))
  have hfirst : Integrable (fun z ↦ textbookCanonicalDensityCutoff H β R z *
      textbookDivergence (fun x ↦ textbookHamiltonianGibbsWeight H β x • G x) z) := by
    apply hDI.norm.mono' (hc.aestronglyMeasurable.mul hDI.aestronglyMeasurable)
    filter_upwards [] with z
    change ‖textbookCanonicalDensityCutoff H β R z *
      textbookDivergence (fun x ↦ textbookHamiltonianGibbsWeight H β x • G x) z‖ ≤ _
    rw [norm_mul, Real.norm_eq_abs, abs_of_nonneg (textbookCanonicalDensityCutoff_mem_Icc H β R z).1]
    exact (mul_le_mul_of_nonneg_right (textbookCanonicalDensityCutoff_mem_Icc H β R z).2
      (norm_nonneg _)).trans_eq (one_mul _)
  have herr : Integrable (fun z ↦ (β / R) *
      deriv Real.smoothTransition (2 - β * H z / R) *
        (textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z)) := by
    apply (hEI.norm.const_mul (|β / R| * D)).mono'
      ((hd.aestronglyMeasurable.const_mul (β / R)).mul hEI.aestronglyMeasurable)
    filter_upwards [] with z
    change ‖(β / R) * deriv Real.smoothTransition (2 - β * H z / R) *
      (textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z)‖ ≤ _
    simpa only [norm_mul, Real.norm_eq_abs] using
      mul_le_mul_of_nonneg_right
        (mul_le_mul_of_nonneg_left (hD (2 - β * H z / R)) (abs_nonneg (β / R)))
        (norm_nonneg (textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z))
  apply (hfirst.sub herr).congr
  filter_upwards [] with z
  change textbookCanonicalDensityCutoff H β R z *
    textbookDivergence (fun x ↦ textbookHamiltonianGibbsWeight H β x • G x) z -
    (β / R) * deriv Real.smoothTransition (2 - β * H z / R) *
      (textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z) = _
  exact (textbookCanonicalDensityCutoff_flux_divergence H G β R z
    (hH.differentiable_one z) (hG.differentiable_one z)).symm

/-- The actual Gibbs weighted flux has zero total divergence under the proposition's bounded weighted-field condition, without assuming that flux itself is integrable. -/
theorem textbookCanonicalWeightedFlux_integral_divergence_eq_zero {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H β))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H β z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H β z • G z‖ ≤ C) :
    (∫ z, textbookDivergence (fun x ↦ textbookHamiltonianGibbsWeight H β x • G x) z) = 0 := by
  obtain ⟨D, hD0, hD⟩ := textbookCanonicalTransition_deriv_bound
  let F : SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
    fun z ↦ textbookHamiltonianGibbsWeight H β z • G z
  let E : SymplecticCoordinates Nc → ℝ :=
    fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z
  let η : ℕ → SymplecticCoordinates Nc → ℝ :=
    fun n ↦ textbookCanonicalDensityCutoff H β (n + 1)
  let V : ℕ → SymplecticCoordinates Nc → SymplecticCoordinates Nc := fun n z ↦ η n z • F z
  let err : ℕ → SymplecticCoordinates Nc → ℝ := fun n z ↦
    (β / ((n : ℝ) + 1)) * deriv Real.smoothTransition (2 - β * H z / ((n : ℝ) + 1)) * E z
  have hDI : Integrable (textbookDivergence F) :=
    textbookCanonicalWeightedFlux_divergence_integrable H G β hH.differentiable_one
      hG.differentiable_one hdivI henergyI
  have hR (n : ℕ) : 0 < (n : ℝ) + 1 := by positivity
  have hw : ContDiff ℝ 1 (textbookHamiltonianGibbsWeight H β) :=
    (contDiff_const.mul hH).exp
  have hFC : ContDiff ℝ 1 F := by simpa only [F, Pi.smul_def'] using hw.smul hG
  have hVC (n : ℕ) : ContDiff ℝ 1 (V n) := by
    simpa only [V, η, Pi.smul_def'] using
      (textbookCanonicalDensityCutoff_contDiff H β ((n : ℝ) + 1) hH).smul hFC
  have hVI (n : ℕ) : Integrable (V n) :=
    textbookCanonicalDensityCutoff_flux_integrable H G β ((n : ℝ) + 1) (hR n) hH hG.continuous
      hρI C hC hbound
  have hVD (n : ℕ) : Integrable (textbookDivergence (V n)) :=
    textbookCanonicalDensityCutoff_flux_divergence_integrable H G β ((n : ℝ) + 1) hH hG
      hDI henergyI
  have heq (n : ℕ) (z : SymplecticCoordinates Nc) :
      textbookDivergence (V n) z = η n z * textbookDivergence F z - err n z :=
    textbookCanonicalDensityCutoff_flux_divergence H G β ((n : ℝ) + 1) z
      (hH.differentiable_one z) (hG.differentiable_one z)
  have hE (n : ℕ) (z : SymplecticCoordinates Nc) :
      ‖err n z‖ ≤ (|β| * D * ‖E z‖) / ((n : ℝ) + 1) := by
    have hd : |deriv Real.smoothTransition (2 - β * H z / ((n : ℝ) + 1))| ≤ D := by
      simpa only [Real.norm_eq_abs] using hD (2 - β * H z / ((n : ℝ) + 1))
    change ‖(β / ((n : ℝ) + 1)) *
      deriv Real.smoothTransition (2 - β * H z / ((n : ℝ) + 1)) * E z‖ ≤ _
    simp only [norm_mul, Real.norm_eq_abs, abs_div, abs_of_pos (hR n)]
    calc
      (|β| / ((n : ℝ) + 1)) *
          |deriv Real.smoothTransition (2 - β * H z / ((n : ℝ) + 1))| * |E z| ≤
          (|β| / ((n : ℝ) + 1)) * D * |E z| :=
        mul_le_mul_of_nonneg_right
          (mul_le_mul_of_nonneg_left hd (div_nonneg (abs_nonneg _) (hR n).le)) (abs_nonneg _)
      _ = (|β| * D * |E z|) / ((n : ℝ) + 1) := by ring
  have hboundV (n : ℕ) (z : SymplecticCoordinates Nc) :
      ‖textbookDivergence (V n) z‖ ≤ ‖textbookDivergence F z‖ + (|β| * D) * ‖E z‖ := by
    have hη := textbookCanonicalDensityCutoff_mem_Icc H β ((n : ℝ) + 1) z
    have ha : ‖η n z * textbookDivergence F z‖ ≤ ‖textbookDivergence F z‖ := by
      rw [norm_mul, Real.norm_eq_abs, abs_of_nonneg hη.1]
      exact (mul_le_mul_of_nonneg_right hη.2 (norm_nonneg _)).trans_eq (one_mul _)
    have hb : (|β| * D * ‖E z‖) / ((n : ℝ) + 1) ≤ (|β| * D) * ‖E z‖ := by
      apply (div_le_iff₀ (hR n)).mpr
      have hn : 0 ≤ (n : ℝ) := Nat.cast_nonneg n
      have he0 : 0 ≤ |β| * D * ‖E z‖ := mul_nonneg (mul_nonneg (abs_nonneg _) hD0) (norm_nonneg _)
      nlinarith
    rw [heq]
    exact (norm_sub_le _ _).trans (add_le_add ha ((hE n z).trans hb))
  have hr : Tendsto (fun n : ℕ ↦ (n : ℝ) + 1) atTop atTop := by
    apply tendsto_atTop.2
    intro b
    filter_upwards [eventually_ge_atTop (Nat.ceil b)] with n hn
    have hb : b ≤ (n : ℝ) := (Nat.le_ceil b).trans (by exact_mod_cast hn)
    linarith
  have hpoint (z : SymplecticCoordinates Nc) :
      Tendsto (fun n ↦ textbookDivergence (V n) z) atTop (𝓝 (textbookDivergence F z)) := by
    have ha : Tendsto (fun n ↦ η n z * textbookDivergence F z) atTop
        (𝓝 (textbookDivergence F z)) := by
      apply tendsto_const_nhds.congr'
      filter_upwards [textbookCanonicalDensityCutoff_eventually_one H β z] with n hn
      simp only [η, hn, one_mul]
    have hb : Tendsto (fun n ↦ err n z) atTop (𝓝 0) :=
      squeeze_zero_norm (fun n ↦ hE n z) (hr.const_div_atTop (|β| * D * ‖E z‖))
    apply (show Tendsto (fun n ↦ η n z * textbookDivergence F z - err n z)
        atTop (𝓝 (textbookDivergence F z)) by
      simpa only [sub_zero] using ha.sub hb).congr'
    exact .of_forall (fun n ↦ (heq n z).symm)
  have hlim := tendsto_integral_of_dominated_convergence
    (fun z ↦ ‖textbookDivergence F z‖ + (|β| * D) * ‖E z‖)
    (fun n ↦ (textbookPhaseField_divergence_continuous (V n) (hVC n)).aestronglyMeasurable)
    (hDI.norm.add (henergyI.norm.const_mul (|β| * D)))
    (fun n ↦ .of_forall (hboundV n)) (.of_forall hpoint)
  have hz : (fun n ↦ ∫ z, textbookDivergence (V n) z) = fun _ : ℕ ↦ (0 : ℝ) :=
    funext (fun n ↦ textbookPhaseField_integral_divergence_eq_zero (V n) (hVC n) (hVI n) (hVD n))
  rw [hz] at hlim
  exact tendsto_nhds_unique hlim tendsto_const_nhds

/-- Actual normalized Gibbs averages satisfy the temperature integration-by-parts identity, derived from the true full-space flux proof. -/
theorem textbookCanonicalAverage_divergence_eq_beta_lieDerivative {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H β))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H β z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H β z • G z‖ ≤ C) :
    textbookCanonicalAverage H β (textbookDivergence G) =
      β * textbookCanonicalAverage H β (textbookLieDerivative G H) := by
  have hz := textbookCanonicalWeightedFlux_integral_divergence_eq_zero
    H G β hH hG hρI hdivI henergyI C hC hbound
  have heq :
      textbookDivergence (fun z ↦ textbookHamiltonianGibbsWeight H β z • G z) =
      (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H β z -
        β * (textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z)) := by
    funext z
    rw [textbookCanonicalWeightedFlux_divergence H G β z (hH.differentiable_one z) (hG.differentiable_one z)]
    ring
  rw [heq, integral_sub hdivI (henergyI.const_mul β), integral_const_mul] at hz
  have hi := sub_eq_zero.mp hz
  unfold textbookCanonicalAverage
  rw [hi]
  ring

/-- The actual observable ratio equals inverse temperature; neither the ratio nor the full-space IBP is a hypothesis. -/
theorem textbookCanonicalAverage_temperature_ratio {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (hβ : 0 < β) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H β))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H β z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H β z • G z‖ ≤ C)
    (hpos : 0 < textbookCanonicalAverage H β (textbookDivergence G)) :
    textbookCanonicalAverage H β (textbookLieDerivative G H) /
      textbookCanonicalAverage H β (textbookDivergence G) = β⁻¹ := by
  have hi := textbookCanonicalAverage_divergence_eq_beta_lieDerivative
    H G β hH hG hρI hdivI henergyI C hC hbound
  apply (div_eq_iff hpos.ne').mpr
  rw [hi, ← mul_assoc, inv_mul_cancel₀ hβ.ne', one_mul]

/-- Proposition 6.1: the physical temperature observable formula on the true full phase space, with the original weighted-field condition made explicitly uniformly bounded. -/
theorem proposition_6_1 {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (kB T : ℝ) (hkB : 0 < kB) (hT : 0 < T) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H (kB * T)⁻¹))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z • G z‖ ≤ C)
    (hpos : 0 < textbookCanonicalAverage H (kB * T)⁻¹ (textbookDivergence G)) :
    kB * T =
      textbookCanonicalAverage H (kB * T)⁻¹ (textbookLieDerivative G H) /
        textbookCanonicalAverage H (kB * T)⁻¹ (textbookDivergence G) := by
  have hr := textbookCanonicalAverage_temperature_ratio H G (kB * T)⁻¹
    (inv_pos.mpr (mul_pos hkB hT)) hH hG hρI hdivI henergyI C hC hbound hpos
  simpa only [inv_inv] using hr.symm


/-- The actual directional derivative is exactly the original coordinate dot product G·∇H. -/
theorem textbookPhaseLieDerivative_coordinates {Nc : ℕ}
    (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (H : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookLieDerivative G H z =
      ∑ i : Fin Nc ⊕ Fin Nc, G z i * (fderiv ℝ H z (Pi.single i 1)) := by
  classical
  have he : (∑ i : Fin Nc ⊕ Fin Nc, G z i • Pi.single i 1) = G z := by
    simpa using (Pi.basisFun ℝ (Fin Nc ⊕ Fin Nc)).sum_repr (G z)
  unfold textbookLieDerivative
  calc
    (fderiv ℝ H z) (G z) =
        (fderiv ℝ H z) (∑ i : Fin Nc ⊕ Fin Nc, G z i • Pi.single i 1) := congrArg _ he.symm
    _ = _ := by simp only [map_sum, map_smul, smul_eq_mul]

/-- The original numerator positivity is itself derived from the true IBP identity and positive divergence average. -/
theorem textbookCanonicalAverage_lieDerivative_pos {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (hβ : 0 < β) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H β))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H β z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H β z • G z‖ ≤ C)
    (hpos : 0 < textbookCanonicalAverage H β (textbookDivergence G)) :
    0 < textbookCanonicalAverage H β (textbookLieDerivative G H) := by
  have hi := textbookCanonicalAverage_divergence_eq_beta_lieDerivative
    H G β hH hG hρI hdivI henergyI C hC hbound
  have hm : 0 < β * textbookCanonicalAverage H β (textbookLieDerivative G H) := by rw [← hi]; exact hpos
  exact pos_of_mul_pos_left (by simpa only [mul_comm] using hm) hβ.le

end MolecularDynamics
