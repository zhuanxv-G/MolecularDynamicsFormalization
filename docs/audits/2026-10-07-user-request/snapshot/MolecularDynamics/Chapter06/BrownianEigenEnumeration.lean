import MolecularDynamics.Chapter06.BrownianEigenDiscreteness

/-! Positive-dimensional genuine eigenbasis infinitude and complete sequence enumeration. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics
noncomputable section

private local instance brownianEigenEnumerationCircleMeasure : MeasureSpace UnitAddCircle :=
  ⟨AddCircle.haarAddCircle⟩
private local instance brownianEigenEnumerationCircleProbability :
    IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

private abbrev HaarReal (Nc : ℕ) := Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))
private abbrev HaarComplex (Nc : ℕ) := Lp ℂ 2 (volume : Measure (UnitAddTorus (Fin Nc)))
private abbrev Gibbs {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)

private def real_pair_complexify (Nc : ℕ) : HaarReal Nc × HaarReal Nc →ₗ[ℝ] HaarComplex Nc :=
  (textbookHaarL2Complexify Nc).toLinearMap.comp (LinearMap.fst ℝ (HaarReal Nc) (HaarReal Nc)) +
    (Complex.I • (textbookHaarL2Complexify Nc).toLinearMap).comp
      (LinearMap.snd ℝ (HaarReal Nc) (HaarReal Nc))

private theorem real_pair_complexify_surjective (Nc : ℕ) :
    Function.Surjective (real_pair_complexify Nc) := by
  intro x
  let a := textbookHaarL2RealPart Nc x
  let b := (Complex.imCLM.compLpL 2 volume) x
  refine ⟨(a, b), ?_⟩
  change textbookHaarL2Complexify Nc a + Complex.I • textbookHaarL2Complexify Nc b = x
  apply Lp.ext
  filter_upwards [Lp.coeFn_add (textbookHaarL2Complexify Nc a)
      (Complex.I • textbookHaarL2Complexify Nc b),
    Lp.coeFn_smul Complex.I (textbookHaarL2Complexify Nc b),
    textbookHaarL2Complexify_ae a, textbookHaarL2Complexify_ae b,
    textbookHaarL2RealPart_ae x, Complex.imCLM.coeFn_compLpL x] with Q hsum hsmul ha hb hre him
  simp only [Pi.add_apply, Pi.smul_apply] at hsum hsmul
  rw [hsum, hsmul, ha, hb]
  change (a Q : ℂ) + Complex.I * (b Q : ℂ) = x Q
  change a Q = (x Q).re at hre
  change b Q = (x Q).im at him
  rw [hre, him, mul_comm Complex.I]
  exact Complex.re_add_im (x Q)

/-- In positive dimension the actual real Haar Hilbert space is infinite-dimensional, proved from genuine Fourier linear independence and the actual real-imaginary decomposition. -/
theorem textbookHaarL2_not_finiteDimensional {Nc : ℕ} (hNc : 0 < Nc) :
    ¬FiniteDimensional ℝ (HaarReal Nc) := by
  intro h
  let : FiniteDimensional ℝ (HaarReal Nc) := h
  let : FiniteDimensional ℝ (HaarComplex Nc) :=
    FiniteDimensional.of_surjective (real_pair_complexify Nc) (real_pair_complexify_surjective Nc)
  let : Nonempty (Fin Nc) := ⟨⟨0, hNc⟩⟩
  let : Infinite (Fin Nc → ℤ) := inferInstance
  have hi := (UnitAddTorus.mFourierBasis (d := Fin Nc)).orthonormal.linearIndependent.restrict_scalars' ℝ
  have hf : Finite (Fin Nc → ℤ) := Cardinal.lt_aleph0_iff_finite.mp hi.lt_aleph0_of_finiteDimensional
  let : Finite (Fin Nc → ℤ) := hf
  exact not_finite (Fin Nc → ℤ)

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

include hU hPU in
/-- The original Gibbs Hilbert space is genuinely infinite-dimensional for Nc>0, via the already proved whole-space ground-state unitary. -/
theorem textbookBrownianGibbsLp_not_finiteDimensional (hNc : 0 < Nc) :
    ¬FiniteDimensional ℝ (Gibbs U β) := by
  intro h
  let : FiniteDimensional ℝ (Gibbs U β) := h
  have hh := (textbookGibbsHaarGroundStateIsometry U hU hPU β).toLinearEquiv.finiteDimensional
  exact textbookHaarL2_not_finiteDimensional hNc hh

include hm hβ in
/-- Positive configuration dimension forces the entire actual generator eigenbasis index to be infinite. -/
theorem textbookBrownianGibbsEigenIndex_infinite (hNc : 0 < Nc) :
    Infinite (textbookBrownianGibbsEigenIndex m U hU hPU β) := by
  classical
  rcases finite_or_infinite (textbookBrownianGibbsEigenIndex m U hU hPU β) with hf | hi
  · let : Finite (textbookBrownianGibbsEigenIndex m U hU hPU β) := hf
    let : Fintype (textbookBrownianGibbsEigenIndex m U hU hPU β) := Fintype.ofFinite _
    have hd := (textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ).toOrthonormalBasis.toBasis.finiteDimensional_of_finite
    exact False.elim (textbookBrownianGibbsLp_not_finiteDimensional U hU hPU β hNc hd)
  · exact hi

/-- A genuine bijection from natural numbers to every actual eigenbasis mode, constructed only after positive-dimensional infinitude is proved. This definition makes no ordering claim. -/
def textbookBrownianGibbsEigenEnumeration (hNc : 0 < Nc) :
    ℕ ≃ textbookBrownianGibbsEigenIndex m U hU hPU β := by
  let : Countable (textbookBrownianGibbsEigenIndex m U hU hPU β) :=
    textbookBrownianGibbsEigenIndex_countable m hm U hU hPU β hβ
  let : Infinite (textbookBrownianGibbsEigenIndex m U hU hPU β) :=
    textbookBrownianGibbsEigenIndex_infinite m hm U hU hPU β hβ hNc
  let : Denumerable (textbookBrownianGibbsEigenIndex m U hU hPU β) :=
    Classical.choice (nonempty_denumerable _)
  exact (Denumerable.eqv _).symm

/-- A complete natural-number Hilbert eigenbasis of the entire original Gibbs space in positive dimension, preserving every actual eigenmode. No ordering is asserted. -/
def textbookBrownianGibbsNatEigenbasis (hNc : 0 < Nc) : HilbertBasis ℕ ℝ (Gibbs U β) := by
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  let e := textbookBrownianGibbsEigenEnumeration m hm U hU hPU β hβ hNc
  refine HilbertBasis.mk (b.orthonormal.comp e e.injective) ?_
  have he : Set.range (⇑b ∘ e) = Set.range b := by
    rw [Set.range_comp, e.surjective.range_eq, Set.image_univ]
  rw [he, b.dense_span]

/-- Every natural-number basis vector is literally the original genuine whole-generator basis vector selected by the actual bijection. -/
theorem textbookBrownianGibbsNatEigenbasis_apply (hNc : 0 < Nc) (n : ℕ) :
    textbookBrownianGibbsNatEigenbasis m hm U hU hPU β hβ hNc n =
      textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
        (textbookBrownianGibbsEigenEnumeration m hm U hU hPU β hβ hNc n) := by
  simp only [textbookBrownianGibbsNatEigenbasis, HilbertBasis.coe_mk, Function.comp_apply]

/-- Each vector in the entire sequence basis lies in the actual original closed-generator graph, with its literal selected eigenvalue. -/
theorem textbookBrownianGibbsNatEigenbasis_mem_graph (hNc : 0 < Nc) (n : ℕ) :
    (textbookBrownianGibbsNatEigenbasis m hm U hU hPU β hβ hNc n,
      (textbookBrownianGibbsEigenEnumeration m hm U hU hPU β hβ hNc n).1 •
        textbookBrownianGibbsNatEigenbasis m hm U hU hPU β hβ hNc n) ∈
      (textbookBrownianGibbsClosedOperator m U hU hPU β).graph := by
  rw [textbookBrownianGibbsNatEigenbasis_apply]
  exact textbookBrownianGibbsEigenbasis_mem_graph m hm U hU hPU β hβ _

include hm hβ in
/-- The actual eigenvalues in the genuine sequence enumeration tend to minus infinity as n tends to infinity, using proved infinitude and genuine compactness. -/
theorem textbookBrownianGibbsEigenEnumeration_tendsto_atBot (hNc : 0 < Nc) :
    Tendsto (fun n : ℕ ↦ (textbookBrownianGibbsEigenEnumeration m hm U hU hPU β hβ hNc n).1)
      atTop atBot := by
  simpa only [Nat.cofinite_eq_atTop, Function.comp_def] using
    (textbookBrownianGibbsEigenbasis_eigenvalues_tendsto_atBot m hm U hU hPU β hβ).comp
      (textbookBrownianGibbsEigenEnumeration m hm U hU hPU β hβ hNc).injective.tendsto_cofinite

include hm hβ in
/-- Every value of the entire actual original-generator real spectrum occurs in the sequence, with every genuine basis mode included. -/
theorem textbookBrownianGibbsGeneratorRealSpectrum_eq_sequence_range (hNc : 0 < Nc) :
    textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β =
      Set.range (fun n : ℕ ↦ (textbookBrownianGibbsEigenEnumeration m hm U hU hPU β hβ hNc n).1) := by
  let e := textbookBrownianGibbsEigenEnumeration m hm U hU hPU β hβ hNc
  change textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β =
    Set.range ((fun j : textbookBrownianGibbsEigenIndex m U hU hPU β ↦ j.1) ∘ e)
  rw [Set.range_comp, e.surjective.range_eq, Set.image_univ,
    textbookBrownianGibbsGeneratorRealSpectrum_eq_eigenbasis_range m hm U hU hPU β hβ]

/-- The sequence eigenbasis gives an actual unconditional reconstruction of every vector of the entire original Gibbs Hilbert space. -/
theorem textbookBrownianGibbsNatEigenbasis_hasSum (hNc : 0 < Nc) (x : Gibbs U β) :
    HasSum (fun n : ℕ ↦ ⟪textbookBrownianGibbsNatEigenbasis m hm U hU hPU β hβ hNc n, x⟫_ℝ •
      textbookBrownianGibbsNatEigenbasis m hm U hU hPU β hβ hNc n) x := by
  simpa only [HilbertBasis.repr_apply_apply] using
    (textbookBrownianGibbsNatEigenbasis m hm U hU hPU β hβ hNc).hasSum_repr x

include hm hβ in
/-- In positive dimension the whole actual original-generator real spectrum is infinite, derived from the genuine sequence escape and not added as a spectrum hypothesis. -/
theorem textbookBrownianGibbsGeneratorRealSpectrum_infinite (hNc : 0 < Nc) :
    (textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β).Infinite := by
  intro hf
  obtain ⟨a, ha⟩ := hf.bddBelow
  have he := Filter.tendsto_atBot.mp
    (textbookBrownianGibbsEigenEnumeration_tendsto_atBot m hm U hU hPU β hβ hNc) (a - 1)
  obtain ⟨n, hn⟩ := he.exists
  have hs : (textbookBrownianGibbsEigenEnumeration m hm U hU hPU β hβ hNc n).1 ∈
      textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β := by
    rw [textbookBrownianGibbsGeneratorRealSpectrum_eq_sequence_range m hm U hU hPU β hβ hNc]
    exact Set.mem_range_self n
  have hb := ha hs
  linarith

end
end MolecularDynamics
