import MolecularDynamics.Chapter06.BrownianEigenOrdering

/-! Actual Bochner integral averages for the same entire Gibbs Hilbert evolution.
These analytic averages do not assume or claim identification with an SDE law. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace

namespace MolecularDynamics
noncomputable section

private abbrev Gibbs {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

private abbrev oneVector : Gibbs U β :=
  textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1)

/-- The original normalized Hilbert constant is literally one almost everywhere for the same Gibbs measure. -/
theorem textbookPeriodicSmoothEmbedding_one_ae_eq :
    (oneVector U hU hPU β : UnitAddTorus (Fin Nc) → ℝ) =ᵐ[textbookConfigurationTorusGibbsMeasure U β]
      fun _ ↦ 1 := by
  exact textbookConfigurationGibbsL2Observable_ae_eq U hU hPU β
    (textbookPeriodicSmoothConstant Nc 1) (textbookPeriodicSmoothConstant Nc 1).prop.1.continuous
    (textbookPeriodicSmoothConstant Nc 1).prop.2

include hU hPU in
/-- Every entire original Gibbs Hilbert vector has an actual integrable representative. -/
theorem textbookBrownianGibbsL2_integrable (x : Gibbs U β) :
    Integrable (x : UnitAddTorus (Fin Nc) → ℝ) (textbookConfigurationTorusGibbsMeasure U β) := by
  refine (L2.integrable_inner (𝕜 := ℝ) (oneVector U hU hPU β) x).congr ?_
  filter_upwards [textbookPeriodicSmoothEmbedding_one_ae_eq U hU hPU β] with Q hQ
  rw [Real.inner_apply, hQ, one_mul]

/-- Products of every pair of actual entire Gibbs Hilbert representatives are integrable. -/
theorem textbookBrownianGibbsL2_integrable_product (x g : Gibbs U β) :
    Integrable (fun Q ↦ x Q * g Q) (textbookConfigurationTorusGibbsMeasure U β) := by
  simpa only [Real.inner_apply] using L2.integrable_inner (𝕜 := ℝ) x g

/-- The entire original Gibbs Hilbert pairing is the actual integral of the representatives' product. -/
theorem textbookBrownianGibbsL2_inner_eq_integral_product (x g : Gibbs U β) :
    ⟪x, g⟫_ℝ = ∫ Q, x Q * g Q ∂textbookConfigurationTorusGibbsMeasure U β := by
  simp only [L2.inner_def, Real.inner_apply]

/-- The original equilibrium-mode pairing is the actual Gibbs Bochner integral for every entire Hilbert vector. -/
theorem textbookBrownianGibbsL2_one_inner_eq_integral (x : Gibbs U β) :
    ⟪oneVector U hU hPU β, x⟫_ℝ = ∫ Q, x Q ∂textbookConfigurationTorusGibbsMeasure U β := by
  rw [textbookBrownianGibbsL2_inner_eq_integral_product]
  apply integral_congr_ae
  filter_upwards [textbookPeriodicSmoothEmbedding_one_ae_eq U hU hPU β] with Q hQ
  rw [hQ, one_mul]

/-- Every original smooth periodic test has exactly its normalized full-cube canonical integral. -/
theorem textbookBrownianGibbsL2_smooth_integral_eq_cube_average (f : textbookPeriodicSmoothSpace Nc) :
    (∫ Q, (textbookPeriodicSmoothEmbedding U hU hPU β f) Q
      ∂textbookConfigurationTorusGibbsMeasure U β) =
      (textbookConfigurationPartition U β)⁻¹ *
        ∫ q in textbookConfigurationCube Nc, (f : (Fin Nc → ℝ) → ℝ) q * textbookConfigurationGibbsWeight U β q := by
  rw [← textbookConfigurationTorusGibbsMeasure_integral_observable U hU hPU β f f.prop.2]
  apply integral_congr_ae
  exact textbookConfigurationGibbsL2Observable_ae_eq U hU hPU β f f.prop.1.continuous f.prop.2

/-- The same actual whole Gibbs evolution preserves the true integral of every entire Hilbert input. -/
theorem textbookBrownianGibbsSpectralEvolution_integral_mass (t : NNReal) (ρ : Gibbs U β) :
    (∫ Q, (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t ρ) Q
      ∂textbookConfigurationTorusGibbsMeasure U β) =
      ∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β := by
  rw [← textbookBrownianGibbsL2_one_inner_eq_integral U hU hPU β,
    ← textbookBrownianGibbsL2_one_inner_eq_integral U hU hPU β]
  exact textbookBrownianGibbsSpectralEvolution_mean m hm U hU hPU β hβ t ρ

/-- The actual integral of the evolved density against a test equals the integral of the evolved test against the initial density. -/
theorem textbookBrownianGibbsSpectralEvolution_integral_duality (t : NNReal) (ρ g : Gibbs U β) :
    (∫ Q, g Q * (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t ρ) Q
      ∂textbookConfigurationTorusGibbsMeasure U β) =
      ∫ Q, (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t g) Q * ρ Q
        ∂textbookConfigurationTorusGibbsMeasure U β := by
  rw [← textbookBrownianGibbsL2_inner_eq_integral_product,
    ← textbookBrownianGibbsL2_inner_eq_integral_product]
  exact (textbookBrownianGibbsSpectralEvolution_isSymmetric m hm U hU hPU β hβ t g ρ).symm

/-- Every actual integral average converges exponentially to the true Gibbs integral times the preserved input mass. -/
theorem textbookBrownianGibbsSpectralEvolution_integral_decay (t : NNReal) (ρ g : Gibbs U β) :
    |(∫ Q, g Q * (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t ρ) Q
        ∂textbookConfigurationTorusGibbsMeasure U β) -
      (∫ Q, g Q ∂textbookConfigurationTorusGibbsMeasure U β) *
        (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
      Real.exp (-textbookBrownianGibbsCoercivityRate m U hU hPU β * (t : ℝ)) * ‖g‖ *
        ‖ρ - (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) • oneVector U hU hPU β‖ := by
  have h := textbookBrownianGibbsSpectralEvolution_correlation_decay m hm U hU hPU β hβ t ρ g
  have hg : ⟪g, oneVector U hU hPU β⟫_ℝ =
      ∫ Q, g Q ∂textbookConfigurationTorusGibbsMeasure U β := by
    rw [real_inner_comm, textbookBrownianGibbsL2_one_inner_eq_integral]
  rw [hg, textbookBrownianGibbsL2_one_inner_eq_integral,
    textbookBrownianGibbsL2_inner_eq_integral_product] at h
  exact h

/-- Actual initial mass one gives the canonical integral target and a strictly positive density-dependent rate prefactor. -/
theorem textbookBrownianGibbsSpectralEvolution_normalized_integral_decay
    (ρ : Gibbs U β) (hρ : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : NNReal) (g : Gibbs U β) :
    |(∫ Q, g Q * (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t ρ) Q
        ∂textbookConfigurationTorusGibbsMeasure U β) -
      (∫ Q, g Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
      (‖ρ - oneVector U hU hPU β‖ + 1) * ‖g‖ *
        Real.exp (-textbookBrownianGibbsCoercivityRate m U hU hPU β * (t : ℝ)) := by
  have h := textbookBrownianGibbsSpectralEvolution_integral_decay m hm U hU hPU β hβ t ρ g
  rw [hρ, mul_one, one_smul] at h
  refine h.trans ?_
  calc
    Real.exp (-textbookBrownianGibbsCoercivityRate m U hU hPU β * (t : ℝ)) * ‖g‖ *
        ‖ρ - oneVector U hU hPU β‖ ≤
      Real.exp (-textbookBrownianGibbsCoercivityRate m U hU hPU β * (t : ℝ)) * ‖g‖ *
        (‖ρ - oneVector U hU hPU β‖ + 1) := by
      gcongr
      exact le_add_of_nonneg_right zero_le_one
    _ = _ := by ring

/-- The original smooth periodic test average has an actual full-cube canonical limit with the original weighted Hilbert test norm. -/
theorem textbookBrownianGibbsSpectralEvolution_smooth_average_decay
    (ρ : Gibbs U β) (hρ : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : NNReal) (f : textbookPeriodicSmoothSpace Nc) :
    |(∫ Q, textbookConfigurationTorusObservable f Q *
        (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t ρ) Q
          ∂textbookConfigurationTorusGibbsMeasure U β) -
      (textbookConfigurationPartition U β)⁻¹ *
        (∫ q in textbookConfigurationCube Nc, (f : (Fin Nc → ℝ) → ℝ) q * textbookConfigurationGibbsWeight U β q)| ≤
      (‖ρ - oneVector U hU hPU β‖ + 1) * ‖textbookPeriodicSmoothEmbedding U hU hPU β f‖ *
        Real.exp (-textbookBrownianGibbsCoercivityRate m U hU hPU β * (t : ℝ)) := by
  have h := textbookBrownianGibbsSpectralEvolution_normalized_integral_decay m hm U hU hPU β hβ
    ρ hρ t (textbookPeriodicSmoothEmbedding U hU hPU β f)
  have he : (∫ Q, (textbookPeriodicSmoothEmbedding U hU hPU β f) Q *
      (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t ρ) Q
        ∂textbookConfigurationTorusGibbsMeasure U β) =
      ∫ Q, textbookConfigurationTorusObservable f Q *
        (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t ρ) Q
          ∂textbookConfigurationTorusGibbsMeasure U β := by
    apply integral_congr_ae
    filter_upwards [textbookConfigurationGibbsL2Observable_ae_eq U hU hPU β f
      f.prop.1.continuous f.prop.2] with Q hQ
    change (textbookPeriodicSmoothEmbedding U hU hPU β f) Q =
      textbookConfigurationTorusObservable f Q at hQ
    rw [hQ]
  rw [he, textbookBrownianGibbsL2_smooth_integral_eq_cube_average] at h
  exact h

/-- The genuine analytic average estimate has strictly positive K and alpha, uniformly for all original smooth tests and all nonnegative times. -/
theorem textbookBrownianGibbsSpectralEvolution_smooth_average_exponential
    (ρ : Gibbs U β) (hρ : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace Nc) (t : NNReal),
      |(∫ Q, textbookConfigurationTorusObservable f Q *
          (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t ρ) Q
            ∂textbookConfigurationTorusGibbsMeasure U β) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube Nc, (f : (Fin Nc → ℝ) → ℝ) q * textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hPU β f‖ * Real.exp (-α * (t : ℝ)) := by
  refine ⟨‖ρ - oneVector U hU hPU β‖ + 1, textbookBrownianGibbsCoercivityRate m U hU hPU β,
    by positivity, textbookBrownianGibbsCoercivityRate_pos m U hU hPU β hβ, ?_⟩
  intro f t
  exact textbookBrownianGibbsSpectralEvolution_smooth_average_decay m hm U hU hPU β hβ ρ hρ t f

end
end MolecularDynamics