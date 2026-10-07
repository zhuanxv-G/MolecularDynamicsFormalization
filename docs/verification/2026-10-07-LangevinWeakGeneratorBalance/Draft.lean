import MolecularDynamics.Chapter06.LangevinC2ExpectationDomination
import MolecularDynamics.Chapter06.LangevinC2OperatorSupport
import MolecularDynamics.Chapter06.LangevinInvariantMoments
import Mathlib.MeasureTheory.Integral.DominatedConvergence

/-! Actual invariant-law weak generator balance for the original Langevin kernel.
The initial momentum domination and genuine law moments justify the integral limit. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics
noncomputable section

private theorem weakC2_momentum_integrable_of_energy {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hLower : ∀ q, 1 ≤ U q)
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hiH : Integrable (textbookLangevinPeriodicHamiltonianPower U 1)
      (μ : Measure (textbookLangevinPeriodicPhase N))) :
    Integrable (fun x : textbookLangevinPeriodicPhase N ↦ ‖x.2‖ ^ 2)
      (μ : Measure (textbookLangevinPeriodicPhase N)) := by
  have hc : Continuous (fun x : textbookLangevinPeriodicPhase N ↦ ‖x.2‖ ^ 2) :=
    continuous_snd.norm.pow 2
  apply (hiH.const_mul (2 : ℝ)).mono' hc.aestronglyMeasurable
  exact Eventually.of_forall (fun x ↦ by
    rw [Real.norm_of_nonneg (sq_nonneg ‖x.2‖)]
    exact textbookLangevinPeriodicHamiltonianPower_momentum_coercive U hLower 1 (by norm_num) x)

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB in
/-- Every genuine full-time invariant probability has a true finite momentum
second moment, derived from actual normalized Hamiltonian moments and coercivity. -/
theorem textbookLangevinPeriodicInvariant_momentum_norm_square_integrable
    (hγ : 0 < γ)
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hInv : ∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
      (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) :
    Integrable (fun x : textbookLangevinPeriodicPhase N ↦ ‖x.2‖ ^ 2)
      (μ : Measure (textbookLangevinPeriodicPhase N)) := by
  obtain ⟨c, hc⟩ := textbookUnitPeriodicPotential_normalization U hU.continuous hp
  let V := fun q ↦ U q + c
  have hV : ContDiff ℝ ∞ V := hU.add contDiff_const
  have hpV : textbookUnitPeriodicPotential V := textbookUnitPeriodicPotential_add_const U hp c
  have hFV : LipschitzWith L (textbookPotentialForce V) := by
    dsimp only [V]
    rw [textbookPotentialForce_add_const]
    exact hF
  have hInvV : ∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P V hV hpV L hFV γ σ T ∘ₘ
      (μ : Measure (textbookLangevinPeriodicPhase N)) = μ := by
    intro T
    rw [textbookLangevinPeriodicTransitionKernel_add_const B P hB U hU hp L hF c L hFV γ σ T]
    exact hInv T
  exact weakC2_momentum_integrable_of_energy V hc μ
    (textbookLangevinPeriodicInvariant_all_hamiltonian_power_moments
      B P hB V hV hpV L hFV γ σ hc hγ μ hInvV 1 (by norm_num)).1

variable (F : textbookLangevinPeriodicPhase N → ℝ)
  (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection)) (hcs : HasCompactSupport F)

include hB hG hcs in
/-- The same original kernel's true compact C2 generator limit can be integrated
against any genuine probability with a finite momentum second moment.
The actual uniform expectation dominator supplies the dominated-convergence step. -/
theorem textbookLangevinPeriodicTransitionKernel_compactC2_integrated_generator_limit
    (hγ : 0 < γ) (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hiP : Integrable (fun x : textbookLangevinPeriodicPhase N ↦ ‖x.2‖ ^ 2)
      (μ : Measure (textbookLangevinPeriodicPhase N))) :
    Integrable (textbookLangevinPeriodicDifferentialOperator U γ σ F)
      (μ : Measure (textbookLangevinPeriodicPhase N)) ∧
    Tendsto (fun T : ℝ ↦ ∫ x,
      ((∫ y, F y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T.toNNReal x) -
        F x) / T ∂(μ : Measure (textbookLangevinPeriodicPhase N)))
      (𝓝[>] 0) (𝓝 (∫ x, textbookLangevinPeriodicDifferentialOperator U γ σ F x
        ∂(μ : Measure (textbookLangevinPeriodicPhase N)))) := by
  have hFc : Continuous F :=
    (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hG.continuous
  obtain ⟨A, hA⟩ := hcs.exists_bound_of_continuous hFc
  let f := BoundedContinuousFunction.ofNormedAddCommGroup F hFc A hA
  let Q := fun (T : ℝ) (x : textbookLangevinPeriodicPhase N) ↦
    ((∫ y, F y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T.toNNReal x) - F x) / T
  have hQc (T : ℝ) : Continuous (Q T) := by
    change Continuous (fun x ↦
      (textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ T.toNNReal f x - f x) / T)
    exact ((textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ T.toNNReal f).continuous.sub
      f.continuous).div_const T
  have hLc := textbookLangevinPeriodicDifferentialOperator_C2_continuous U hU hp γ σ F hG
  have hLcs := textbookLangevinPeriodicDifferentialOperator_compactC2_hasCompactSupport U γ σ F hG hcs
  obtain ⟨D, hD⟩ := hLcs.exists_bound_of_continuous hLc
  have hiL : Integrable (textbookLangevinPeriodicDifferentialOperator U γ σ F)
      (μ : Measure (textbookLangevinPeriodicPhase N)) :=
    (integrable_const D).mono' hLc.aestronglyMeasurable (Eventually.of_forall hD)
  obtain ⟨C, _, hb⟩ := textbookLangevinPeriodicTransitionKernel_compactC2_quotient_growth_bound
    B P hB U hU hp L hF γ σ F hG hcs hγ
  have hiBound : Integrable (fun x : textbookLangevinPeriodicPhase N ↦ C * (1 + ‖x.2‖ ^ 2))
      (μ : Measure (textbookLangevinPeriodicPhase N)) :=
    ((integrable_const (1 : ℝ)).add hiP).const_mul C
  have hBound : ∀ᶠ T in 𝓝[>] (0 : ℝ), ∀ᵐ x ∂(μ : Measure (textbookLangevinPeriodicPhase N)),
      ‖Q T x‖ ≤ C * (1 + ‖x.2‖ ^ 2) := by
    filter_upwards [self_mem_nhdsWithin,
      nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))] with T hT hT1
    exact Eventually.of_forall (hb T hT (show T < 1 from hT1).le)
  have hLim : ∀ᵐ x ∂(μ : Measure (textbookLangevinPeriodicPhase N)),
      Tendsto (fun T : ℝ ↦ Q T x) (𝓝[>] 0)
        (𝓝 (textbookLangevinPeriodicDifferentialOperator U γ σ F x)) :=
    Eventually.of_forall (fun x ↦
      textbookLangevinPeriodicTransitionKernel_compactC2_actual_differentialOperator_limit
        B P hB U hU hp L hF γ σ F hFc hG hcs hγ x)
  exact ⟨hiL, tendsto_integral_filter_of_dominated_convergence
    (fun x ↦ C * (1 + ‖x.2‖ ^ 2))
    (Eventually.of_forall (fun T ↦ (hQc T).aestronglyMeasurable)) hBound hiBound hLim⟩


include hB hG hcs in
private theorem weakC2_invariant_balance_of_momentum
    (hγ : 0 < γ) (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hiP : Integrable (fun x : textbookLangevinPeriodicPhase N ↦ ‖x.2‖ ^ 2)
      (μ : Measure (textbookLangevinPeriodicPhase N)))
    (hInv : ∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
      (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) :
    Integrable (textbookLangevinPeriodicDifferentialOperator U γ σ F)
      (μ : Measure (textbookLangevinPeriodicPhase N)) ∧
    (∫ x, textbookLangevinPeriodicDifferentialOperator U γ σ F x
      ∂(μ : Measure (textbookLangevinPeriodicPhase N))) = 0 := by
  obtain ⟨hiL, hLim⟩ := textbookLangevinPeriodicTransitionKernel_compactC2_integrated_generator_limit
    B P hB U hU hp L hF γ σ F hG hcs hγ μ hiP
  have hFc : Continuous F :=
    (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hG.continuous
  obtain ⟨A, hA⟩ := hcs.exists_bound_of_continuous hFc
  let f := BoundedContinuousFunction.ofNormedAddCommGroup F hFc A hA
  have hiF : Integrable f (μ : Measure (textbookLangevinPeriodicPhase N)) :=
    (integrable_const ‖f‖).mono' f.continuous.aestronglyMeasurable (Eventually.of_forall f.norm_coe_le_norm)
  have hZero (T : ℝ) : (∫ x,
      ((∫ y, F y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T.toNNReal x) -
        F x) / T ∂(μ : Measure (textbookLangevinPeriodicPhase N))) = 0 := by
    let Kf := textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ T.toNNReal f
    have hiK : Integrable Kf (μ : Measure (textbookLangevinPeriodicPhase N)) :=
      (integrable_const ‖Kf‖).mono' Kf.continuous.aestronglyMeasurable
        (Eventually.of_forall Kf.norm_coe_le_norm)
    have he := textbookLangevinPeriodicProbabilityEvolution_integral B P hB U hU hp L hF γ σ T.toNNReal μ f
    change (∫ y, f y ∂(textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T.toNNReal ∘ₘ
      (μ : Measure (textbookLangevinPeriodicPhase N)))) = ∫ x, Kf x ∂(μ : Measure (textbookLangevinPeriodicPhase N)) at he
    rw [hInv T.toNNReal] at he
    change (∫ x, (Kf x - f x) / T ∂(μ : Measure (textbookLangevinPeriodicPhase N))) = 0
    rw [integral_div, integral_sub hiK hiF, ← he, sub_self, zero_div]
  have hefun : (fun T : ℝ ↦ ∫ x,
      ((∫ y, F y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T.toNNReal x) -
        F x) / T ∂(μ : Measure (textbookLangevinPeriodicPhase N))) = (fun _ ↦ (0 : ℝ)) :=
    funext hZero
  rw [hefun] at hLim
  exact ⟨hiL, tendsto_nhds_unique hLim tendsto_const_nhds⟩

include hB hG hcs in
/-- Every actual original invariant law satisfies the genuine compact C2 weak
generator balance. Its required moment is derived from actual invariant moments,
and the integral limit is justified by the true initial-momentum dominator. -/
theorem textbookLangevinPeriodicInvariant_compactC2_weak_generator_balance
    (hγ : 0 < γ)
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hInv : ∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
      (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) :
    Integrable (textbookLangevinPeriodicDifferentialOperator U γ σ F)
      (μ : Measure (textbookLangevinPeriodicPhase N)) ∧
    (∫ x, textbookLangevinPeriodicDifferentialOperator U γ σ F x
      ∂(μ : Measure (textbookLangevinPeriodicPhase N))) = 0 :=
  weakC2_invariant_balance_of_momentum B P hB U hU hp L hF γ σ F hG hcs hγ μ
    (textbookLangevinPeriodicInvariant_momentum_norm_square_integrable
      B P hB U hU hp L hF γ σ hγ μ hInv) hInv

include hB in
/-- For any original smooth periodic potential, the same original kernel has a
genuine invariant probability with all normalized Hamiltonian moments and actual
compact C2 weak generator balance, without a density or stationary-law premise. -/
theorem textbookLangevinPeriodicTransitionKernel_invariant_exists_with_compactC2_weak_balance
    (hγ : 0 < γ) :
    ∃ c : ℝ, (∀ q, 1 ≤ U q + c) ∧
      ∃ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
        (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
          (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) ∧
        (∀ l : ℕ, 1 ≤ l →
          Integrable (textbookLangevinPeriodicHamiltonianPower (fun q ↦ U q + c) l)
            (μ : Measure (textbookLangevinPeriodicPhase N))) ∧
        ∀ F : textbookLangevinPeriodicPhase N → ℝ,
          ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection) → HasCompactSupport F →
          Integrable (textbookLangevinPeriodicDifferentialOperator U γ σ F)
            (μ : Measure (textbookLangevinPeriodicPhase N)) ∧
          (∫ x, textbookLangevinPeriodicDifferentialOperator U γ σ F x
            ∂(μ : Measure (textbookLangevinPeriodicPhase N))) = 0 := by
  obtain ⟨c, hc, μ, hInv, hMom⟩ :=
    textbookLangevinPeriodicTransitionKernel_invariant_exists_with_normalized_energy_moments
      B P hB U hU hp L hF γ σ hγ
  have hiP := weakC2_momentum_integrable_of_energy (fun q ↦ U q + c) hc μ (hMom 1 (by norm_num))
  refine ⟨c, hc, μ, hInv, hMom, ?_⟩
  intro F hG hcs
  exact weakC2_invariant_balance_of_momentum B P hB U hU hp L hF γ σ F hG hcs hγ μ hiP hInv

end
end MolecularDynamics
