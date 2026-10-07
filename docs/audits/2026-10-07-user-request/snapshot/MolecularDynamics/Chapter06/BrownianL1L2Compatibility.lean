import MolecularDynamics.Chapter06.BrownianL1DensityLaw

/-! The same original Brownian L1 and L2 probability evolutions agree under
the genuine representative-preserving Gibbs inclusion. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics
noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

variable {N : ℕ} (m : Fin N → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

private def inclusionLinear :
    Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) →ₗ[ℝ]
      Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β) where
  toFun x := by
    have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hp β
    exact ⟨x.val, Lp.antitone (by norm_num : (1 : ℝ≥0∞) ≤ 2) x.prop⟩
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

private theorem inclusion_norm_le
    (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) :
    ‖inclusionLinear U hU hp β x‖ ≤ ‖x‖ := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hp β
  rw [Lp.norm_def, Lp.norm_def]
  exact ENNReal.toReal_mono (Lp.memLp x).eLpNorm_ne_top
    (eLpNorm_le_eLpNorm_of_exponent_le (by norm_num : (1 : ℝ≥0∞) ≤ 2))

/-- The actual original Gibbs L2-to-L1 inclusion keeps precisely the same underlying almost-everywhere function. -/
def textbookGibbsL2ToL1 :
    Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) →L[ℝ]
      Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β) :=
  (inclusionLinear U hU hp β).mkContinuous 1 (fun x ↦ by
    simpa only [one_mul] using inclusion_norm_le U hU hp β x)

/-- The natural inclusion preserves the actual chosen function representative at every position. -/
theorem textbookGibbsL2ToL1_apply
    (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) (Q : UnitAddTorus (Fin N)) :
    textbookGibbsL2ToL1 U hU hp β x Q = x Q := rfl

/-- The original Gibbs probability gives the natural inclusion operator norm at most one. -/
theorem textbookGibbsL2ToL1_norm_le_one :
    ‖textbookGibbsL2ToL1 U hU hp β‖ ≤ 1 := by
  apply ContinuousLinearMap.opNorm_le_bound _ zero_le_one
  intro x
  change ‖inclusionLinear U hU hp β x‖ ≤ 1 * ‖x‖
  simpa only [one_mul] using inclusion_norm_le U hU hp β x

/-- The two genuine continuous-observable inclusions are exactly compatible. -/
theorem textbookGibbsL2ToL1_continuous_inclusion (F : C(UnitAddTorus (Fin N), ℝ)) :
    textbookGibbsL2ToL1 U hU hp β (textbookGibbsContinuousToLp U hU hp β F) =
      textbookGibbsContinuousToL1 U hU hp β F := by
  apply Lp.ext
  exact (textbookGibbsContinuousToLp_ae_eq U hU hp β F).trans
    (textbookGibbsContinuousToL1_ae_eq U hU hp β F).symm

include hB in
/-- The entire actual original L1 probability evolution agrees with the proved original L2 spectral evolution under the same genuine inclusion. -/
theorem textbookBrownianGibbsL1ProbabilityOperator_L2_compatibility (t : ℝ≥0)
    (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) :
    textbookGibbsL2ToL1 U hU hp β
      (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t x) =
      textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t
        (textbookGibbsL2ToL1 U hU hp β x) := by
  let I := textbookGibbsL2ToL1 U hU hp β
  let T := textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t
  let A := textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t
  let L := I.comp T
  let R := A.comp I
  have he : (L : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) → _) = R :=
    (textbookGibbsContinuousToLp_denseRange U hU hp β).equalizer L.continuous R.continuous (by
      funext F
      have hP : T (textbookGibbsContinuousToLp U hU hp β F) =
          textbookGibbsContinuousToLp U hU hp β
            (textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F) :=
        (textbookBrownianProbabilityGibbsL2Image_eq_spectral m hm U hU hp β hβ B P hB t F).symm
      change I (T (textbookGibbsContinuousToLp U hU hp β F)) =
        A (I (textbookGibbsContinuousToLp U hU hp β F))
      rw [hP]
      simp only [I, A, textbookGibbsL2ToL1_continuous_inclusion,
        textbookBrownianGibbsL1ProbabilityOperator_spec])
  exact congr_fun he x

/-- The same actual physical initial density measure is unchanged by the genuine L2-to-L1 inclusion. -/
theorem textbookBrownianInitialL1DensityMeasure_L2_compatibility
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) :
    textbookBrownianInitialL1DensityMeasure U β (textbookGibbsL2ToL1 U hU hp β ρ) =
      textbookBrownianInitialDensityMeasure U β ρ := rfl

/-- Both actual density-law constructions push precisely the same physical initial measure through precisely the same original Brownian kernel. -/
theorem textbookBrownianL1DensityLaw_L2_compatibility
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) (t : ℝ≥0) :
    textbookBrownianL1DensityLaw m hm U hU hp β hβ B P
      (textbookGibbsL2ToL1 U hU hp β ρ) t =
      textbookBrownianDensityLaw m hm U hU hp β hβ B P ρ t := rfl

/-- The actual normalized distribution average (5.6) is precisely the same in the L1 and L2 constructions. -/
theorem textbookBrownianL1DensityAverage_L2_compatibility
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) (t : ℝ≥0)
    (F : C(UnitAddTorus (Fin N), ℝ)) :
    textbookBrownianL1DensityAverage m hm U hU hp β hβ B P
      (textbookGibbsL2ToL1 U hU hp β ρ) t F =
      textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t F := rfl


include hB in
/-- The same actual physical Haar density is obtained from the original L1 and L2 evolutions, for every entire original L2 input. -/
theorem textbookBrownianGibbsL1ToHaarDensity_L2_compatibility (t : ℝ≥0)
    (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) (Q : UnitAddTorus (Fin N)) :
    textbookBrownianGibbsL1ToHaarDensity U β
      (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t
        (textbookGibbsL2ToL1 U hU hp β x)) Q =
      textbookBrownianGibbsToHaarDensity U β
        (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t x) Q := by
  rw [← textbookBrownianGibbsL1ProbabilityOperator_L2_compatibility m hm U hU hp β hβ B P hB]
  rfl

private abbrev oneVector : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) :=
  textbookPeriodicSmoothEmbedding U hU hp β (textbookPeriodicSmoothConstant N 1)

include hB in
/-- The genuine L1 distribution average has the original full-cube canonical exponential bound when its physical initial density comes from the original L2 class. -/
theorem textbookBrownianL1DensityAverage_L2_smooth_decay
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) (f : textbookPeriodicSmoothSpace N) :
    |textbookBrownianL1DensityAverage m hm U hU hp β hβ B P
        (textbookGibbsL2ToL1 U hU hp β ρ) t
        (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
      (textbookConfigurationPartition U β)⁻¹ *
        (∫ q in textbookConfigurationCube N, (f : (Fin N → ℝ) → ℝ) q *
          textbookConfigurationGibbsWeight U β q)| ≤
      (‖ρ - oneVector U hU hp β‖ + 1) * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ *
        Real.exp (-textbookBrownianGibbsCoercivityRate m U hU hp β * (t : ℝ)) := by
  rw [textbookBrownianL1DensityAverage_L2_compatibility]
  exact textbookBrownianDensityAverage_smooth_decay m hm U hU hp β hβ B P hB ρ hρpos hρmass t f

include hB in
/-- The actual integrable-law formulation has the same strictly positive K and alpha, uniformly in original smooth tests and nonnegative times, for the honest initial L2 class. -/
theorem textbookBrownianL1DensityAverage_L2_smooth_exponential
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace N) (t : ℝ≥0),
      |textbookBrownianL1DensityAverage m hm U hU hp β hβ B P
          (textbookGibbsL2ToL1 U hU hp β ρ) t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube N, (f : (Fin N → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ * Real.exp (-α * (t : ℝ)) := by
  obtain ⟨K, α, hK, hα, hh⟩ :=
    textbookBrownianDensityAverage_smooth_exponential m hm U hU hp β hβ B P hB ρ hρpos hρmass
  refine ⟨K, α, hK, hα, ?_⟩
  intro f t
  rw [textbookBrownianL1DensityAverage_L2_compatibility]
  exact hh f t

include hB in
/-- The literal original flat-Haar density integral ratio has the same canonical bound for the actual original law, with its initial L2 condition explicitly retained. -/
theorem textbookBrownianL1HaarDensityRatio_L2_smooth_decay
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) (f : textbookPeriodicSmoothSpace N) :
    |(∫ Q, textbookConfigurationTorusObservable f Q *
        textbookBrownianGibbsL1ToHaarDensity U β
          (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t
            (textbookGibbsL2ToL1 U hU hp β ρ)) Q) /
        (∫ Q, textbookBrownianGibbsL1ToHaarDensity U β
          (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t
            (textbookGibbsL2ToL1 U hU hp β ρ)) Q) -
      (textbookConfigurationPartition U β)⁻¹ *
        (∫ q in textbookConfigurationCube N, (f : (Fin N → ℝ) → ℝ) q *
          textbookConfigurationGibbsWeight U β q)| ≤
      (‖ρ - oneVector U hU hp β‖ + 1) * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ *
        Real.exp (-textbookBrownianGibbsCoercivityRate m U hU hp β * (t : ℝ)) := by
  have hpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β]
      textbookGibbsL2ToL1 U hU hp β ρ := hρpos
  have hmass : (∫ Q, (textbookGibbsL2ToL1 U hU hp β ρ) Q
      ∂textbookConfigurationTorusGibbsMeasure U β) = 1 := hρmass
  have hh := textbookBrownianL1DensityAverage_eq_HaarDensityRatio m hm U hU hp β hβ B P hB
    (textbookGibbsL2ToL1 U hU hp β ρ) hpos hmass t
    (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2)
  change textbookBrownianL1DensityAverage m hm U hU hp β hβ B P
      (textbookGibbsL2ToL1 U hU hp β ρ) t
      (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) =
    (∫ Q, textbookConfigurationTorusObservable f Q *
      textbookBrownianGibbsL1ToHaarDensity U β
        (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t
          (textbookGibbsL2ToL1 U hU hp β ρ)) Q) /
      (∫ Q, textbookBrownianGibbsL1ToHaarDensity U β
        (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t
          (textbookGibbsL2ToL1 U hU hp β ρ)) Q) at hh
  rw [← hh]
  exact textbookBrownianL1DensityAverage_L2_smooth_decay m hm U hU hp β hβ B P hB ρ hρpos hρmass t f
end
end MolecularDynamics
