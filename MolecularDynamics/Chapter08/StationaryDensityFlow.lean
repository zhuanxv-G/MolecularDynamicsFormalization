import MolecularDynamics.Chapter08.ThermostatDensity
import MolecularDynamics.Chapter02.LiouvilleVolume
import Mathlib.MeasureTheory.Measure.WithDensity

/-! Genuine density transport required to interpret Proposition 8.1 under an actual solution family. -/

open Set Matrix Filter MeasureTheory MeasureTheory.Measure
open scoped BigOperators Topology ENNReal

namespace MolecularDynamics

private theorem stationaryDensity_coordinateJacobian {ι : Type*} [Fintype ι] [DecidableEq ι]
    (f : (ι → ℝ) → ι → ℝ) (hf : ContDiff ℝ 1 f)
    (ρ : (ι → ℝ) → ℝ) (hρ : ContDiff ℝ 1 ρ)
    (hs : textbookLiouvilleStationary f ρ)
    (Φ : ℝ × (ι → ℝ) → ι → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s ↦ Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z ↦ Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ) (z : ι → ℝ) :
    ρ (Φ (t, z)) * (textbookCoordinateJacobian (fun y ↦ Φ (t, y)) z).det = ρ z := by
  have hstat (x : ι → ℝ) : (fderiv ℝ ρ x) (f x) +
      ρ x * (textbookCoordinateJacobian f x).trace = 0 := by
    have h := hs x
    rw [textbookDivergence_density (hρ.differentiable_one x) (hf.differentiable_one x)] at h
    unfold textbookDivergence at h
    rw [LinearMap.trace_eq_matrix_trace ℝ (Pi.basisFun ℝ ι)] at h
    exact h
  have hd (u : ℝ) (hu : u ∈ Icc 0 τ) :
      HasDerivAt (fun s ↦ ρ (Φ (s, z)) *
        (textbookCoordinateJacobian (fun y ↦ Φ (s, y)) z).det) 0 u := by
    have hdet := textbookMatrixDet_hasDerivAt_of_linearODE
      (fun s ↦ textbookCoordinateJacobian (fun y ↦ Φ (s, y)) z)
      (textbookCoordinateJacobian f (Φ (u, z))) u
      (textbookSolutionFamilyJacobian_hasDerivAt f Φ hΦ u z (hf.differentiable_one _)
        (Filter.Eventually.of_forall (hODE u hu)))
    have hpath : HasDerivAt (fun s ↦ ρ (Φ (s, z)))
        ((fderiv ℝ ρ (Φ (u, z))) (f (Φ (u, z)))) u := by
      simpa only [Function.comp_def] using
        (hρ.differentiable_one (Φ (u, z))).hasFDerivAt.comp_hasDerivAt u (hODE u hu z)
    have hp := hpath.mul hdet
    have hc : (fderiv ℝ ρ (Φ (u, z))) (f (Φ (u, z))) *
          (textbookCoordinateJacobian (fun y ↦ Φ (u, y)) z).det +
        ρ (Φ (u, z)) * ((textbookCoordinateJacobian f (Φ (u, z))).trace *
          (textbookCoordinateJacobian (fun y ↦ Φ (u, y)) z).det) = 0 := by
      calc
        _ = ((fderiv ℝ ρ (Φ (u, z))) (f (Φ (u, z))) +
            ρ (Φ (u, z)) * (textbookCoordinateJacobian f (Φ (u, z))).trace) *
              (textbookCoordinateJacobian (fun y ↦ Φ (u, y)) z).det := by ring
        _ = 0 := by rw [hstat, zero_mul]
    rw [hc] at hp
    exact hp
  have he : ∀ s ∈ Icc 0 τ, ρ (Φ (s, z)) *
      (textbookCoordinateJacobian (fun y ↦ Φ (s, y)) z).det =
      ρ (Φ (0, z)) * (textbookCoordinateJacobian (fun y ↦ Φ (0, y)) z).det := by
    apply constant_of_has_deriv_right_zero
      (fun s hs ↦ (hd s hs).hasDerivWithinAt.continuousWithinAt)
    intro s hs
    exact (hd s (mem_Icc_of_Ico hs)).hasDerivWithinAt.mono_of_mem_nhdsWithin
      (Icc_mem_nhdsGE_of_mem hs)
  have hzero : (textbookCoordinateJacobian (fun y ↦ Φ (0, y)) z).det = 1 := by
    rw [hinit]
    unfold textbookCoordinateJacobian
    rw [fderiv_id]
    change (LinearMap.toMatrix' (LinearMap.id : (ι → ℝ) →ₗ[ℝ] ι → ℝ)).det = 1
    rw [LinearMap.toMatrix'_id, Matrix.det_one]
  rw [he t ht, hzero, congrFun hinit z, id_eq, mul_one]

section ActualDensityFlow

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]

/-- The true weighted Jacobian identity follows from the actual time ODE and Liouville PDE. -/
theorem textbookStationaryDensityFlow_weightedJacobian
    (f : E → E) (hf : ContDiff ℝ 1 f) (ρ : E → ℝ) (hρ : ContDiff ℝ 1 ρ)
    (hs : textbookLiouvilleStationary f ρ)
    (Φ : ℝ × E → E) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s ↦ Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z ↦ Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ) (z : E) :
    ρ (Φ (t, z)) * (fderiv ℝ (fun y ↦ Φ (t, y)) z).det = ρ z := by
  classical
  let e : E ≃L[ℝ] (Fin (Module.finrank ℝ E) → ℝ) :=
    (Module.finBasis ℝ E).equivFun.toContinuousLinearEquiv
  let G := fun u ↦ e (f (e.symm u))
  let R := fun u ↦ ρ (e.symm u)
  let Ψ := fun p : ℝ × (Fin (Module.finrank ℝ E) → ℝ) ↦ e (Φ (p.1, e.symm p.2))
  have hG : ContDiff ℝ 1 G := e.contDiff.comp (hf.comp e.symm.contDiff)
  have hR : ContDiff ℝ 1 R := hρ.comp e.symm.contDiff
  have hΨ : ContDiff ℝ 2 Ψ :=
    e.contDiff.comp (hΦ.comp (contDiff_fst.prodMk (e.symm.contDiff.comp contDiff_snd)))
  have hsG : textbookLiouvilleStationary G R :=
    textbookLiouvilleStationary_conjugate e.symm hf hρ hs
  have hODEΨ (u : ℝ) (hu : u ∈ Icc 0 τ) (x : Fin (Module.finrank ℝ E) → ℝ) :
      HasDerivAt (fun s ↦ Ψ (s, x)) (G (Ψ (u, x))) u := by
    convert! e.hasFDerivAt.comp_hasDerivAt u (hODE u hu (e.symm x)) using 1
    simp [Ψ, G]
  have hinitΨ : (fun x ↦ Ψ (0, x)) = id := by
    funext x
    simp only [Ψ, congrFun hinit (e.symm x), id_eq, e.apply_symm_apply]
  have h := stationaryDensity_coordinateJacobian G hG R hR hsG Ψ hΨ τ hODEΨ hinitΨ
    t ht (e z)
  have hslice : ContDiff ℝ 1 (fun y ↦ Φ (t, y)) :=
    (hΦ.of_le (by norm_num)).comp (contDiff_const.prodMk contDiff_id)
  have hc : HasFDerivAt (fun u ↦ Ψ (t, u))
      (e.toContinuousLinearMap.comp
        ((fderiv ℝ (fun y ↦ Φ (t, y)) z).comp e.symm.toContinuousLinearMap)) (e z) := by
    simpa only [Function.comp_def, e.symm_apply_apply, Ψ] using
      e.hasFDerivAt.comp (e z) ((hslice.differentiable_one (e.symm (e z))).hasFDerivAt.comp (e z)
        e.symm.hasFDerivAt)
  have hdet : (textbookCoordinateJacobian (fun u ↦ Ψ (t, u)) (e z)).det =
      (fderiv ℝ (fun y ↦ Φ (t, y)) z).det := by
    unfold textbookCoordinateJacobian
    rw [LinearMap.det_toMatrix', hc.fderiv]
    exact LinearMap.det_conj (fderiv ℝ (fun y ↦ Φ (t, y)) z).toLinearMap e.toLinearEquiv
  rw [hdet] at h
  simpa only [R, Ψ, e.symm_apply_apply] using h

theorem textbookStationaryDensityFlow_abs_weightedJacobian
    (f : E → E) (hf : ContDiff ℝ 1 f) (ρ : E → ℝ) (hρ : ContDiff ℝ 1 ρ)
    (hρ0 : ∀ z, 0 ≤ ρ z) (hs : textbookLiouvilleStationary f ρ)
    (Φ : ℝ × E → E) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s ↦ Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z ↦ Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ) (z : E) :
    |(fderiv ℝ (fun y ↦ Φ (t, y)) z).det| * ρ (Φ (t, z)) = ρ z := by
  have h := congrArg abs
    (textbookStationaryDensityFlow_weightedJacobian f hf ρ hρ hs Φ hΦ τ hODE hinit t ht z)
  simpa only [abs_mul, abs_of_nonneg (hρ0 (Φ (t, z))), abs_of_nonneg (hρ0 z), mul_comm] using h

variable [MeasurableSpace E] [BorelSpace E]

omit [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E] [BorelSpace E] in
/-- The actual measure with the specified density relative to the specified Haar measure. -/
noncomputable def textbookDensityMeasure (μ : Measure E) (ρ : E → ℝ) : Measure E :=
  μ.withDensity (fun z ↦ ENNReal.ofReal (ρ z))

theorem textbookStationaryDensityFlow_measure_image
    (μ : Measure E) [IsAddHaarMeasure μ]
    (f : E → E) (hf : ContDiff ℝ 1 f) (ρ : E → ℝ) (hρ : ContDiff ℝ 1 ρ)
    (hρ0 : ∀ z, 0 ≤ ρ z) (hs : textbookLiouvilleStationary f ρ)
    (Φ : ℝ × E → E) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s ↦ Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z ↦ Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set E) (hsmeas : MeasurableSet s) :
    textbookDensityMeasure μ ρ ((fun z ↦ Φ (t, z)) '' s) = textbookDensityMeasure μ ρ s := by
  have hslice : ContDiff ℝ 1 (fun y ↦ Φ (t, y)) :=
    (hΦ.of_le (by norm_num)).comp (contDiff_const.prodMk contDiff_id)
  have hinj := textbookC1SolutionFamily_injective f hf Φ hΦ.continuous τ hODE hinit t ht
  have hmeas : MeasurableSet ((fun z ↦ Φ (t, z)) '' s) := measurable_image_of_fderivWithin hsmeas
    (fun z _ ↦ (hslice.differentiable_one z).hasFDerivAt.hasFDerivWithinAt) hinj.injOn
  unfold textbookDensityMeasure
  rw [withDensity_apply _ hmeas, withDensity_apply _ hsmeas]
  rw [lintegral_image_eq_lintegral_abs_det_fderiv_mul μ hsmeas
    (fun z _ ↦ (hslice.differentiable_one z).hasFDerivAt.hasFDerivWithinAt) hinj.injOn]
  apply lintegral_congr
  intro z
  rw [← ENNReal.ofReal_mul (abs_nonneg _),
    textbookStationaryDensityFlow_abs_weightedJacobian f hf ρ hρ hρ0 hs Φ hΦ τ hODE hinit t ht z]

/-- A normalized true density is invariant under the specified genuine forward solution family. -/
theorem textbookStationaryDensityFlow_measure_map
    (μ : Measure E) [IsAddHaarMeasure μ]
    (f : E → E) (hf : ContDiff ℝ 1 f) (ρ : E → ℝ) (hρ : ContDiff ℝ 1 ρ)
    (hρ0 : ∀ z, 0 ≤ ρ z) (hs : textbookLiouvilleStationary f ρ)
    [IsProbabilityMeasure (textbookDensityMeasure μ ρ)]
    (Φ : ℝ × E → E) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s ↦ Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z ↦ Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ) :
    Measure.map (fun z ↦ Φ (t, z)) (textbookDensityMeasure μ ρ) = textbookDensityMeasure μ ρ := by
  let ν := textbookDensityMeasure μ ρ
  have hslice : ContDiff ℝ 1 (fun y ↦ Φ (t, y)) :=
    (hΦ.of_le (by norm_num)).comp (contDiff_const.prodMk contDiff_id)
  have hinj := textbookC1SolutionFamily_injective f hf Φ hΦ.continuous τ hODE hinit t ht
  have hrange : MeasurableSet (Set.range (fun z ↦ Φ (t, z))) := by
    rw [← image_univ]
    exact measurable_image_of_fderivWithin MeasurableSet.univ
      (fun z _ ↦ (hslice.differentiable_one z).hasFDerivAt.hasFDerivWithinAt) hinj.injOn
  have hrange1 : ν (Set.range (fun z ↦ Φ (t, z))) = 1 := by
    rw [← image_univ, textbookStationaryDensityFlow_measure_image μ f hf ρ hρ hρ0 hs
      Φ hΦ τ hODE hinit t ht univ MeasurableSet.univ]
    exact measure_univ
  have hrange0 : ν (Set.range (fun z ↦ Φ (t, z)))ᶜ = 0 := by
    rw [prob_compl_eq_one_sub hrange, hrange1, tsub_self]
  apply Measure.ext
  intro s hsmeas
  rw [Measure.map_apply hslice.continuous.measurable hsmeas]
  rw [← textbookStationaryDensityFlow_measure_image μ f hf ρ hρ hρ0 hs
    Φ hΦ τ hODE hinit t ht _ (hslice.continuous.measurable hsmeas)]
  rw [image_preimage_eq_inter_range]
  exact measure_inter_conull hrange0

end ActualDensityFlow

section ProductDensityProbability

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
  [MeasurableSpace E] [BorelSpace E]

/-- The actual product density measure equals the actual product of the three factor measures. -/
theorem textbookThermostatProductDensity_measure_eq_prod
    (μ : Measure E) (ν₁ ν₂ : Measure ℝ) [SFinite μ] [SFinite ν₁] [SFinite ν₂]
    (ρ : E → ℝ) (a b : ℝ → ℝ)
    (hρ : ContDiff ℝ 1 ρ) (ha : ContDiff ℝ 1 a) (hb : ContDiff ℝ 1 b)
    (ha0 : ∀ x, 0 ≤ a x) (hb0 : ∀ y, 0 ≤ b y) :
    textbookDensityMeasure ((μ.prod ν₁).prod ν₂) (textbookThermostatProductDensity ρ a b) =
      ((textbookDensityMeasure μ ρ).prod (textbookDensityMeasure ν₁ a)).prod
        (textbookDensityMeasure ν₂ b) := by
  have hmρ := hρ.continuous.measurable.ennreal_ofReal
  have hma := ha.continuous.measurable.ennreal_ofReal
  have hmb := hb.continuous.measurable.ennreal_ofReal
  have hmρa : Measurable (fun w : E × ℝ ↦ ENNReal.ofReal (ρ w.1) * ENNReal.ofReal (a w.2)) :=
    (hmρ.comp measurable_fst).mul (hma.comp measurable_snd)
  unfold textbookDensityMeasure
  rw [prod_withDensity hmρ hma, prod_withDensity hmρa hmb]
  congr 1
  funext w
  simp only [textbookThermostatProductDensity, ENNReal.ofReal_mul (hb0 w.2),
    ENNReal.ofReal_mul (ha0 w.1.2)]
  ac_rfl

/-- Original normalized factors give normalization of the actual combined density. -/
theorem textbookThermostatProductDensity_probability
    (μ : Measure E) (ν₁ ν₂ : Measure ℝ) [SFinite μ] [SFinite ν₁] [SFinite ν₂]
    (ρ : E → ℝ) (a b : ℝ → ℝ)
    (hρ : ContDiff ℝ 1 ρ) (ha : ContDiff ℝ 1 a) (hb : ContDiff ℝ 1 b)
    (ha0 : ∀ x, 0 ≤ a x) (hb0 : ∀ y, 0 ≤ b y)
    [IsProbabilityMeasure (textbookDensityMeasure μ ρ)]
    [IsProbabilityMeasure (textbookDensityMeasure ν₁ a)]
    [IsProbabilityMeasure (textbookDensityMeasure ν₂ b)] :
    IsProbabilityMeasure (textbookDensityMeasure ((μ.prod ν₁).prod ν₂)
      (textbookThermostatProductDensity ρ a b)) := by
  rw [textbookThermostatProductDensity_measure_eq_prod μ ν₁ ν₂ ρ a b hρ ha hb ha0 hb0]
  infer_instance

end ProductDensityProbability

private theorem combinedThermostat_contDiff {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    {F : E → E} {φ₁ φ₂ : E × ℝ → E} {g₁ g₂ : E × ℝ → ℝ}
    (hF : ContDiff ℝ 1 F) (hφ₁ : ContDiff ℝ 1 φ₁) (hφ₂ : ContDiff ℝ 1 φ₂)
    (hg₁ : ContDiff ℝ 1 g₁) (hg₂ : ContDiff ℝ 1 g₂) :
    ContDiff ℝ 1 (textbookCombinedThermostatField F φ₁ φ₂ g₁ g₂) := by
  have hπ₂ : ContDiff ℝ 1 (fun w : (E × ℝ) × ℝ ↦ (w.1.1, w.2)) :=
    (contDiff_fst.comp contDiff_fst).prodMk contDiff_snd
  exact (((hF.comp (contDiff_fst.comp contDiff_fst)).add (hφ₁.comp contDiff_fst)).add
    (hφ₂.comp hπ₂)).prodMk (hg₁.comp contDiff_fst) |>.prodMk (hg₂.comp hπ₂)

/-- Proposition 8.1 as actual invariant probability measures for a specified genuine solution family. -/
theorem textbookThermostats_additive_invariant_probability {Nc : ℕ}
    (μ : Measure (SymplecticCoordinates Nc)) [IsAddHaarMeasure μ]
    {H : SymplecticCoordinates Nc → ℝ} (hH : ContDiff ℝ 2 H) (β : ℝ) {c : ℝ} (hc : 0 < c)
    {φ₁ φ₂ : SymplecticCoordinates Nc × ℝ → SymplecticCoordinates Nc}
    {g₁ g₂ : SymplecticCoordinates Nc × ℝ → ℝ} {a b : ℝ → ℝ}
    (hφ₁ : ContDiff ℝ 1 φ₁) (hφ₂ : ContDiff ℝ 1 φ₂)
    (hg₁ : ContDiff ℝ 1 g₁) (hg₂ : ContDiff ℝ 1 g₂)
    (ha : ContDiff ℝ 1 a) (hb : ContDiff ℝ 1 b)
    (ha0 : ∀ x, 0 ≤ a x) (hb0 : ∀ y, 0 ≤ b y)
    [IsProbabilityMeasure (textbookDensityMeasure μ (textbookHamiltonianGibbsDensity H β c))]
    [IsProbabilityMeasure (textbookDensityMeasure volume a)]
    [IsProbabilityMeasure (textbookDensityMeasure volume b)]
    (hs₁ : textbookLiouvilleStationary
      (textbookSingleThermostatField (textbookHamiltonianVectorField H) φ₁ g₁)
      (fun w ↦ a w.2 * textbookHamiltonianGibbsDensity H β c w.1))
    (hs₂ : textbookLiouvilleStationary
      (textbookSingleThermostatField (textbookHamiltonianVectorField H) φ₂ g₂)
      (fun w ↦ b w.2 * textbookHamiltonianGibbsDensity H β c w.1))
    (Φ : ℝ × ((SymplecticCoordinates Nc × ℝ) × ℝ) → (SymplecticCoordinates Nc × ℝ) × ℝ)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s ↦ Φ (s, z))
      (textbookCombinedThermostatField (textbookHamiltonianVectorField H) φ₁ φ₂ g₁ g₂ (Φ (t, z))) t)
    (hinit : (fun z ↦ Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ) :
    IsProbabilityMeasure (textbookDensityMeasure ((μ.prod volume).prod volume)
      (textbookThermostatProductDensity (textbookHamiltonianGibbsDensity H β c) a b)) ∧
    Measure.map (fun z ↦ Φ (t, z))
      (textbookDensityMeasure ((μ.prod volume).prod volume)
        (textbookThermostatProductDensity (textbookHamiltonianGibbsDensity H β c) a b)) =
      textbookDensityMeasure ((μ.prod volume).prod volume)
        (textbookThermostatProductDensity (textbookHamiltonianGibbsDensity H β c) a b) := by
  have hμ : SFinite μ := inferInstance
  have hHaar₁ : IsAddHaarMeasure (μ.prod (volume : Measure ℝ)) :=
    MeasureTheory.Measure.prod.instIsAddHaarMeasure μ (volume : Measure ℝ)
  have hHaar₂ : IsAddHaarMeasure ((μ.prod (volume : Measure ℝ)).prod (volume : Measure ℝ)) :=
    MeasureTheory.Measure.prod.instIsAddHaarMeasure (μ.prod (volume : Measure ℝ))
      (volume : Measure ℝ)
  have hF : ContDiff ℝ 1 (textbookHamiltonianVectorField H) := contDiffOn_univ.mp
    (contDiffOn_textbookHamiltonianVectorField Set.univ isOpen_univ H hH.contDiffOn)
  have hρ : ContDiff ℝ 1 (textbookHamiltonianGibbsDensity H β c) :=
    contDiff_const.mul ((contDiff_const.mul (hH.of_le (by norm_num))).exp)
  have hρ0 (z : SymplecticCoordinates Nc) : 0 ≤ textbookHamiltonianGibbsDensity H β c z :=
    (textbookHamiltonianGibbsDensity_pos H β hc z).le
  have hQ : ContDiff ℝ 1
      (textbookThermostatProductDensity (textbookHamiltonianGibbsDensity H β c) a b) :=
    (hb.comp contDiff_snd).mul
      (((ha.comp contDiff_snd).mul (hρ.comp contDiff_fst)).comp contDiff_fst)
  have hQ0 := textbookThermostatProductDensity_nonneg hρ0 ha0 hb0
  have hprob := textbookThermostatProductDensity_probability μ volume volume
    (textbookHamiltonianGibbsDensity H β c) a b hρ ha hb ha0 hb0
  constructor
  · exact hprob
  · exact textbookStationaryDensityFlow_measure_map ((μ.prod volume).prod volume)
      _ (combinedThermostat_contDiff hF hφ₁ hφ₂ hg₁ hg₂) _ hQ hQ0
      (textbookThermostats_additive_proposition81 hH β c hφ₁ hφ₂ hg₁ hg₂ ha hb hs₁ hs₂)
      Φ hΦ τ hODE hinit t ht

end MolecularDynamics
