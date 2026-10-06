import MolecularDynamics.Chapter06.BrownianEigenNormalization

/-! The actual complex kernel and the spectral conclusions for the original smooth Gibbs model.
The probability/SDE conclusion and the textbook regularity audit remain separate obligations. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics
noncomputable section

private abbrev Gibbs {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)
private abbrev GibbsComplex {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β)

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

private abbrev A := textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ
private abbrev R := textbookBrownianGibbsClosedOperator m U hU hPU β
private abbrev e : Gibbs U β :=
  textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1)
private abbrev J := textbookBrownianGibbsL2Complexify U β

/-- The genuine whole complex-generator kernel consists exactly of the actual zero-output graph pairs. -/
theorem textbookBrownianGibbsComplexOperator_kernel_iff_graph (z : GibbsComplex U β) :
    z ∈ (A m hm U hU hPU β hβ).ker ↔ (z, 0) ∈ (A m hm U hU hPU β hβ).graph := by
  rw [LinearPMap.mem_ker_iff, LinearPMap.mem_graph_iff]
  constructor
  · rintro ⟨a, ha, hAa⟩
    exact ⟨a, ha.symm, hAa⟩
  · rintro ⟨a, ha, hAa⟩
    exact ⟨a, ha.symm, hAa⟩

private theorem real_one_graph :
    (e U hU hPU β, 0) ∈ (R m U hU hPU β).graph := by
  let a := Submodule.inclusion (textbookBrownianGibbsPartialOperator_le_closed m U hU hPU β).1
    (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β (textbookPeriodicSmoothConstant Nc 1))
  exact (LinearPMap.mem_graph_iff _).mpr
    ⟨a, rfl, textbookBrownianGibbsClosedOperator_const m U hU hPU β 1⟩

private theorem complex_one_graph :
    (J U β (e U hU hPU β), 0) ∈ (A m hm U hU hPU β hβ).graph := by
  rw [textbookBrownianGibbsComplexOperator_graph_iff_real_imag,
    textbookBrownianGibbsL2RealPart_complexify, textbookBrownianGibbsL2ImagPart_complexify,
    map_zero, map_zero]
  exact ⟨real_one_graph m U hU hPU β, (R m U hU hPU β).graph.zero_mem⟩

include hm hβ in
/-- The actual original complex kernel is exactly the complex span of the original constant one, including zero dimension. -/
theorem textbookBrownianGibbsComplexOperator_kernel_eq_span :
    (A m hm U hU hPU β hβ).ker = Submodule.span ℂ {J U β (e U hU hPU β)} := by
  ext z
  rw [textbookBrownianGibbsComplexOperator_kernel_iff_graph, Submodule.mem_span_singleton]
  constructor
  · intro hz
    obtain ⟨hr, hi⟩ := (textbookBrownianGibbsComplexOperator_graph_iff_real_imag
      m hm U hU hPU β hβ z 0).mp hz
    rw [map_zero] at hr hi
    obtain ⟨a, ha, hAa⟩ := (LinearPMap.mem_graph_iff _).mp hr
    obtain ⟨b, hb, hAb⟩ := (LinearPMap.mem_graph_iff _).mp hi
    change (a : Gibbs U β) = textbookBrownianGibbsL2RealPart U β z at ha
    change (b : Gibbs U β) = textbookBrownianGibbsL2ImagPart U β z at hb
    change R m U hU hPU β a = 0 at hAa
    change R m U hU hPU β b = 0 at hAb
    have hra := textbookBrownianGibbsClosedOperator_kernel_constant m hm U hU hPU β hβ a hAa
    have hia := textbookBrownianGibbsClosedOperator_kernel_constant m hm U hU hPU β hβ b hAb
    rw [ha] at hra
    rw [hb] at hia
    let c := ⟪e U hU hPU β, textbookBrownianGibbsL2RealPart U β z⟫_ℝ
    let d := ⟪e U hU hPU β, textbookBrownianGibbsL2ImagPart U β z⟫_ℝ
    refine ⟨(c : ℂ) + Complex.I * (d : ℂ), ?_⟩
    calc
      ((c : ℂ) + Complex.I * (d : ℂ)) • J U β (e U hU hPU β) =
          J U β (c • e U hU hPU β) + Complex.I • J U β (d • e U hU hPU β) := by
        rw [map_smul, map_smul,
          ← algebraMap_smul ℂ c (J U β (e U hU hPU β)),
          ← algebraMap_smul ℂ d (J U β (e U hU hPU β)), Complex.coe_algebraMap,
          add_smul, mul_smul]
      _ = J U β (textbookBrownianGibbsL2RealPart U β z) +
          Complex.I • J U β (textbookBrownianGibbsL2ImagPart U β z) := by rw [← hra, ← hia]
      _ = z := textbookBrownianGibbsL2Complexify_decomposition U β z
  · rintro ⟨c, rfl⟩
    have h := (A m hm U hU hPU β hβ).graph.smul_mem c (complex_one_graph m hm U hU hPU β hβ)
    simpa only [Prod.smul_mk, smul_zero] using h

include hm hβ in
/-- The zero eigenvalue of the actual original whole complex generator has multiplicity exactly one. -/
theorem textbookBrownianGibbsComplexOperator_kernel_finrank :
    Module.finrank ℂ (A m hm U hU hPU β hβ).ker = 1 := by
  rw [textbookBrownianGibbsComplexOperator_kernel_eq_span m hm U hU hPU β hβ]
  apply finrank_span_singleton
  intro he
  have hn : ‖J U β (e U hU hPU β)‖ = 1 := by
    rw [textbookBrownianGibbsL2Complexify_norm, textbookPeriodicSmoothEmbedding_one_norm]
  rw [he, norm_zero] at hn
  norm_num at hn

include hm hβ in
/-- The actual complex zero eigenspace is genuinely finite-dimensional, rather than a finrank-zero convention for an infinite-dimensional subspace. -/
theorem textbookBrownianGibbsComplexOperator_kernel_finiteDimensional :
    FiniteDimensional ℂ (A m hm U hU hPU β hβ).ker := by
  rw [textbookBrownianGibbsComplexOperator_kernel_eq_span m hm U hU hPU β hβ]
  infer_instance

include hm hβ in
/-- Every actual whole-generator complex stationary vector, and only such a vector, is a true constant multiple of one. -/
theorem textbookBrownianGibbsComplexOperator_graph_zero_iff_constant (z : GibbsComplex U β) :
    (z, 0) ∈ (A m hm U hU hPU β hβ).graph ↔
      ∃ c : ℂ, c • J U β (e U hU hPU β) = z := by
  rw [← textbookBrownianGibbsComplexOperator_kernel_iff_graph,
    textbookBrownianGibbsComplexOperator_kernel_eq_span, Submodule.mem_span_singleton]

/-- The complete spectral parts of Theorem 6.1 for the original smooth same-Gibbs model:
actual complex self-adjointness, simple zero, a true negative gap, the entire complex spectrum,
and a complete ordered basis whose first vector is literally one. This does not assert the
SDE/probability conclusion or remove the separate textbook regularity obligation. -/
theorem textbookBrownianTheorem6_1_smooth_spectral_parts (hNc : 0 < Nc) :
    IsSelfAdjoint (A m hm U hU hPU β hβ) ∧
    Module.finrank ℂ (A m hm U hU hPU β hβ).ker = 1 ∧
    0 < textbookBrownianGibbsCoercivityRate m U hU hPU β ∧
    ∃ (ℓ : ℕ → ℝ) (b : HilbertBasis ℕ ℂ (GibbsComplex U β)),
      ℓ 0 = 0 ∧ Antitone ℓ ∧ Tendsto ℓ atTop atBot ∧
      (∀ n, n ≠ 0 → ℓ n ≤ -textbookBrownianGibbsCoercivityRate m U hU hPU β) ∧
      b 0 = J U β (e U hU hPU β) ∧
      (∀ n, (b n, (ℓ n : ℂ) • b n) ∈ (A m hm U hU hPU β hβ).graph) ∧
      textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ =
        Set.range (fun n : ℕ ↦ (ℓ n : ℂ)) ∧
      (∀ z : GibbsComplex U β, HasSum (fun n : ℕ ↦ ⟪b n, z⟫_ℂ • b n) z) := by
  let ℓ := fun n : ℕ ↦ (textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc n).1
  let b := textbookBrownianGibbsNormalizedComplexOrderedEigenbasis m hm U hU hPU β hβ hNc
  refine ⟨textbookBrownianGibbsComplexOperator_isSelfAdjoint m hm U hU hPU β hβ,
    textbookBrownianGibbsComplexOperator_kernel_finrank m hm U hU hPU β hβ,
    textbookBrownianGibbsCoercivityRate_pos m U hU hPU β hβ,
    ℓ, b, textbookBrownianGibbsOrderedEigenEnumeration_zero m hm U hU hPU β hβ hNc,
    textbookBrownianGibbsOrderedEigenEnumeration_antitone m hm U hU hPU β hβ hNc,
    textbookBrownianGibbsOrderedEigenEnumeration_tendsto_atBot m hm U hU hPU β hβ hNc,
    ?_, textbookBrownianGibbsNormalizedComplexOrderedEigenbasis_zero m hm U hU hPU β hβ hNc,
    textbookBrownianGibbsNormalizedComplexOrderedEigenbasis_mem_graph m hm U hU hPU β hβ hNc,
    textbookBrownianGibbsGeneratorComplexSpectrum_eq_ordered_sequence_range m hm U hU hPU β hβ hNc,
    textbookBrownianGibbsNormalizedComplexOrderedEigenbasis_hasSum m hm U hU hPU β hβ hNc⟩
  intro n hn
  exact textbookBrownianGibbsOrderedEigenEnumeration_gap m hm U hU hPU β hβ hNc n hn

end
end MolecularDynamics
