import MolecularDynamics.Chapter06.LangevinCanonicalMomentumIBP

/-! Genuine periodic-position integration by parts for the actual original
configurational Gibbs marginal, needed for full Langevin weak balance. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff BigOperators
namespace MolecularDynamics
noncomputable section

local instance positionIBPUnitAddCircleMeasureSpace : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance positionIBPUnitAddCircleHaar : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance positionIBPUnitAddCircleProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The actual integral of each coordinate derivative of a smooth periodic
test is zero on the full fundamental cube, by true opposite-face cancellation. -/
theorem textbookConfigurationCube_partial_integral_eq_zero {N : ℕ}
    (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hp : textbookUnitPeriodicPotential f)
    (i : Fin N) : (∫ q in textbookConfigurationCube N, textbookConfigurationPartial f i q) = 0 := by
  classical
  let V (j : Fin N) : (Fin N → ℝ) → ℝ := if j = i then f else fun _ ↦ 0
  have hV (j : Fin N) : ContDiff ℝ ∞ (V j) := by
    by_cases h : j = i
    · simpa only [V, h, ite_true] using hf
    · simpa only [V, h, ite_false] using (contDiff_const : ContDiff ℝ ∞ (fun _ : Fin N → ℝ ↦ (0 : ℝ)))
  have hpV (j : Fin N) : textbookUnitPeriodicPotential (V j) := by
    by_cases h : j = i
    · simpa only [V, h, ite_true] using hp
    · intro q n
      simp only [V, h, ite_false]
  have hD (j : Fin N) (q : Fin N → ℝ) :
      textbookConfigurationPartial (V j) j q =
        if j = i then textbookConfigurationPartial f i q else 0 := by
    by_cases h : j = i
    · simp only [V, h, ite_true]
    · simp only [V, h, ite_false, textbookConfigurationPartial]
      have hz : HasFDerivAt (fun _ : Fin N → ℝ ↦ (0 : ℝ))
          (0 : (Fin N → ℝ) →L[ℝ] ℝ) q := hasFDerivAt_const (0 : ℝ) q
      rw [hz.fderiv]
      rfl
  have hz := textbookConfigurationCube_integral_divergence_eq_zero V hV hpV
  simp_rw [hD] at hz
  simpa using hz

private theorem position_IBP_partial_mul {N : ℕ}
    (f g : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (i : Fin N) (q : Fin N → ℝ) :
    textbookConfigurationPartial (fun y ↦ f y * g y) i q =
      textbookConfigurationPartial f i q * g q + f q * textbookConfigurationPartial g i q := by
  have h := ((hf.differentiable (by simp) q).hasFDerivAt).mul
    ((hg.differentiable (by simp) q).hasFDerivAt)
  have hm : HasFDerivAt (fun y ↦ f y * g y)
      (f q • fderiv ℝ g q + g q • fderiv ℝ f q) q := by
    simpa only [Pi.mul_apply] using! h
  unfold textbookConfigurationPartial
  rw [hm.fderiv]
  simp only [add_apply, _root_.smul_apply, smul_eq_mul]
  ring

/-- Actual Gibbs-weighted periodic integration by parts follows from the
true derivative of the original weight and the full cube boundary cancellation. -/
theorem textbookConfigurationCube_gibbs_integrationByParts {N : ℕ}
    (U f : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (β : ℝ) (i : Fin N) :
    (∫ q in textbookConfigurationCube N,
      textbookConfigurationPartial f i q * textbookConfigurationGibbsWeight U β q) =
      β * ∫ q in textbookConfigurationCube N,
        textbookConfigurationPartial U i q * f q * textbookConfigurationGibbsWeight U β q := by
  let ρ := textbookConfigurationGibbsWeight U β
  have hρ : ContDiff ℝ ∞ ρ := textbookConfigurationGibbsWeight_contDiff U hU β
  have hpρ : textbookUnitPeriodicPotential ρ := textbookConfigurationGibbsWeight_periodic U hPU β
  have hφ : ContDiff ℝ ∞ (fun q ↦ f q * ρ q) := hf.mul hρ
  have hpφ : textbookUnitPeriodicPotential (fun q ↦ f q * ρ q) := by
    intro q n
    simp only [hPf q n, hpρ q n]
  have hz := textbookConfigurationCube_partial_integral_eq_zero (fun q ↦ f q * ρ q) hφ hpφ i
  have he (q : Fin N → ℝ) :
      textbookConfigurationPartial (fun q ↦ f q * ρ q) i q =
        textbookConfigurationPartial f i q * ρ q -
          β * (textbookConfigurationPartial U i q * f q * ρ q) := by
    rw [position_IBP_partial_mul f ρ hf hρ i q]
    change textbookConfigurationPartial f i q * ρ q +
      f q * textbookConfigurationPartial (textbookConfigurationGibbsWeight U β) i q = _
    rw [textbookConfigurationGibbsWeight_partial U hU β i q]
    dsimp only [ρ]
    ring
  have hDf := (textbookConfigurationPartial_contDiff f hf i).continuous
  have hDU := (textbookConfigurationPartial_contDiff U hU i).continuous
  have hi1 : IntegrableOn (fun q ↦ textbookConfigurationPartial f i q * ρ q)
      (textbookConfigurationCube N) :=
    ContinuousOn.integrableOn_compact isCompact_Icc (hDf.mul hρ.continuous).continuousOn
  have hi2 : IntegrableOn (fun q ↦ textbookConfigurationPartial U i q * f q * ρ q)
      (textbookConfigurationCube N) :=
    ContinuousOn.integrableOn_compact isCompact_Icc ((hDU.mul hf.continuous).mul hρ.continuous).continuousOn
  simp_rw [he] at hz
  rw [integral_sub hi1 (hi2.const_mul β), integral_const_mul] at hz
  change (∫ q in textbookConfigurationCube N, textbookConfigurationPartial f i q * ρ q) =
    β * ∫ q in textbookConfigurationCube N, textbookConfigurationPartial U i q * f q * ρ q
  linarith [hz]

/-- The same integration-by-parts identity holds for the actual normalized
position Gibbs probability on the true torus, derived from genuine cube integrals. -/
theorem textbookConfigurationTorusGibbsMeasure_integrationByParts {N : ℕ}
    (U f : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (β : ℝ) (i : Fin N) :
    (∫ Q : UnitAddTorus (Fin N),
      textbookConfigurationTorusObservable (textbookConfigurationPartial f i) Q
      ∂textbookConfigurationTorusGibbsMeasure U β) =
      β * ∫ Q : UnitAddTorus (Fin N),
        textbookConfigurationTorusObservable (fun q ↦ textbookConfigurationPartial U i q * f q) Q
        ∂textbookConfigurationTorusGibbsMeasure U β := by
  have hpf := textbookConfigurationPartial_periodic f hf hPf i
  have hpU := textbookConfigurationPartial_periodic U hU hPU i
  have hpProd : textbookUnitPeriodicPotential (fun q ↦ textbookConfigurationPartial U i q * f q) := by
    intro q n
    simp only [hpU q n, hPf q n]
  rw [textbookConfigurationTorusGibbsMeasure_integral_observable U hU hPU β
      (textbookConfigurationPartial f i) hpf,
    textbookConfigurationTorusGibbsMeasure_integral_observable U hU hPU β
      (fun q ↦ textbookConfigurationPartial U i q * f q) hpProd,
    textbookConfigurationCube_gibbs_integrationByParts U f hU hf hPU hPf β i]
  ring

end
end MolecularDynamics
