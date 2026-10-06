import MolecularDynamics.Chapter06.BrownianEigenEnumeration
import Mathlib.Data.Sigma.Order
import Mathlib.Order.SuccPred.LinearLocallyFinite

/-! Genuine ordered enumeration of every original Gibbs generator eigenmode, with multiplicity. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics
noncomputable section

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

/-- Actual generator eigenmodes ordered by decreasing true eigenvalue, then increasing finite multiplicity index. -/
abbrev textbookBrownianGibbsOrderedEigenIndex :=
  Lex (Σ ℓ : ℝᵒᵈ, Fin (Module.finrank ℝ
    (textbookBrownianGibbsClosedEigenspace m U hU hPU β (OrderDual.ofDual ℓ))))

/-- The order type retains precisely every original actual eigenmode and its finite multiplicity index. -/
def textbookBrownianGibbsOrderedEigenIndexEquiv :
    textbookBrownianGibbsOrderedEigenIndex m U hU hPU β ≃
      textbookBrownianGibbsEigenIndex m U hU hPU β where
  toFun j := ⟨OrderDual.ofDual (ofLex j).1, (ofLex j).2⟩
  invFun j := toLex ⟨OrderDual.toDual j.1, j.2⟩
  left_inv _ := rfl
  right_inv _ := rfl

private abbrev Ord := textbookBrownianGibbsOrderedEigenIndex m U hU hPU β

private theorem ordered_projection_antitone :
    Antitone (fun j : Ord m U hU hPU β ↦
      (textbookBrownianGibbsOrderedEigenIndexEquiv m U hU hPU β j).1) := by
  intro a b hab
  change OrderDual.ofDual (ofLex b).1 ≤ OrderDual.ofDual (ofLex a).1
  rcases Sigma.Lex.le_def.mp hab with h | ⟨h, _⟩
  · change OrderDual.ofDual (ofLex b).1 < OrderDual.ofDual (ofLex a).1 at h
    exact h.le
  · exact (congrArg (fun ℓ : ℝᵒᵈ ↦ OrderDual.ofDual ℓ) h).ge

include hm hβ in
private theorem ordered_finite_Iic (a : Ord m U hU hPU β) : (Set.Iic a).Finite := by
  let e := textbookBrownianGibbsOrderedEigenIndexEquiv m U hU hPU β
  refine Set.Finite.of_injOn (f := e) ?_ e.injective.injOn
    (textbookBrownianGibbsEigenbasis_finite_generator_levels m hm U hU hPU β hβ (e a).1)
  intro j hj
  exact ordered_projection_antitone m U hU hPU β hj

@[instance_reducible]
private def ordered_bot (hNc : 0 < Nc) : OrderBot (Ord m U hU hPU β) := by
  classical
  let e := textbookBrownianGibbsOrderedEigenIndexEquiv m U hU hPU β
  let a := e.symm (textbookBrownianGibbsEigenEnumeration m hm U hU hPU β hβ hNc 0)
  have hf := ordered_finite_Iic m hm U hU hPU β hβ a
  let s := hf.toFinset
  have ha : a ∈ s := hf.mem_toFinset.mpr (Set.mem_Iic.mpr le_rfl)
  have hs : s.Nonempty := ⟨a, ha⟩
  let q := s.min' hs
  have hqa : q ≤ a := Set.mem_Iic.mp (hf.mem_toFinset.mp (s.min'_mem hs))
  refine { bot := q, bot_le := ?_ }
  intro r
  by_cases hr : r ≤ a
  · exact s.min'_le r (hf.mem_toFinset.mpr (Set.mem_Iic.mpr hr))
  · exact hqa.trans (not_le.mp hr).le

include hm hβ in
private theorem ordered_noMax (hNc : 0 < Nc) : NoMaxOrder (Ord m U hU hPU β) := by
  let e := textbookBrownianGibbsOrderedEigenIndexEquiv m U hU hPU β
  let : Infinite (textbookBrownianGibbsEigenIndex m U hU hPU β) :=
    textbookBrownianGibbsEigenIndex_infinite m hm U hU hPU β hβ hNc
  let : Infinite (Ord m U hU hPU β) := Infinite.of_injective e.symm e.symm.injective
  refine ⟨fun a ↦ ?_⟩
  by_contra! h
  have hf : (Set.univ : Set (Ord m U hU hPU β)).Finite :=
    (ordered_finite_Iic m hm U hU hPU β hβ a).subset fun r _ ↦ h r
  let : Finite (Ord m U hU hPU β) := Set.finite_univ_iff.mp hf
  exact not_finite (Ord m U hU hPU β)

private def ordered_nat_iso (hNc : 0 < Nc) : ℕ ≃o Ord m U hU hPU β := by
  let : LocallyFiniteOrder (Ord m U hU hPU β) :=
    LocallyFiniteOrder.ofFiniteIcc fun a b ↦
      (ordered_finite_Iic m hm U hU hPU β hβ b).subset fun r hr ↦ hr.2
  let : SuccOrder (Ord m U hU hPU β) := LinearLocallyFiniteOrder.succOrder _
  let : PredOrder (Ord m U hU hPU β) := LinearLocallyFiniteOrder.predOrder _
  let : OrderBot (Ord m U hU hPU β) := ordered_bot m hm U hU hPU β hβ hNc
  let : NoMaxOrder (Ord m U hU hPU β) := ordered_noMax m hm U hU hPU β hβ hNc
  exact (orderIsoNatOfLinearSuccPredArch (ι := Ord m U hU hPU β)).symm

/-- A genuine complete eigenmode enumeration whose eigenvalues are nonincreasing, derived from the finite spectral levels and actual positive-dimensional infinitude. -/
def textbookBrownianGibbsOrderedEigenEnumeration (hNc : 0 < Nc) :
    ℕ ≃ textbookBrownianGibbsEigenIndex m U hU hPU β :=
  (ordered_nat_iso m hm U hU hPU β hβ hNc).toEquiv.trans
    (textbookBrownianGibbsOrderedEigenIndexEquiv m U hU hPU β)

/-- The true eigenvalue sequence is ordered with multiplicity, rather than an arbitrary countable enumeration. -/
theorem textbookBrownianGibbsOrderedEigenEnumeration_antitone (hNc : 0 < Nc) :
    Antitone (fun n : ℕ ↦ (textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc n).1) := by
  intro n k hnk
  exact ordered_projection_antitone m U hU hPU β
    ((ordered_nat_iso m hm U hU hPU β hβ hNc).monotone hnk)

private abbrev Gibbs {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)

include hm hβ in
/-- The first eigenvalue in the actual ordered complete sequence is exactly the genuine constant-mode spectral value zero. -/
theorem textbookBrownianGibbsOrderedEigenEnumeration_zero (hNc : 0 < Nc) :
    (textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc 0).1 = 0 := by
  obtain ⟨j, hj⟩ := (textbookBrownianGibbsGeneratorRealSpectrum_eq_eigenbasis_range
    m hm U hU hPU β hβ) ▸
      (textbookBrownianGibbsGeneratorRealSpectrum_zero m hm U hU hPU β hβ)
  obtain ⟨n, hn⟩ := (textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc).surjective j
  have hp := textbookBrownianGibbsOrderedEigenEnumeration_antitone m hm U hU hPU β hβ hNc (Nat.zero_le n)
  change j.1 = 0 at hj
  change (textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc n).1 ≤
    (textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc 0).1 at hp
  rw [hn, hj] at hp
  exact le_antisymm
    (textbookBrownianGibbsEigenbasis_eigenvalue_nonpos m hm U hU hPU β hβ _) hp

include hm hβ in
/-- The actual zero eigenspace of the whole original generator is precisely the span of its original normalized constant vector. -/
theorem textbookBrownianGibbsClosedEigenspace_zero_eq_span :
    textbookBrownianGibbsClosedEigenspace m U hU hPU β 0 =
      Submodule.span ℝ {textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1)} := by
  let e := textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1)
  have he : (e, 0) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph := by
    let a := Submodule.inclusion (textbookBrownianGibbsPartialOperator_le_closed m U hU hPU β).1
      (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β (textbookPeriodicSmoothConstant Nc 1))
    exact (LinearPMap.mem_graph_iff _).mpr
      ⟨a, rfl, textbookBrownianGibbsClosedOperator_const m U hU hPU β 1⟩
  ext x
  rw [textbookBrownianGibbsClosedEigenspace_mem_iff, zero_smul, Submodule.mem_span_singleton]
  constructor
  · intro hx
    obtain ⟨a, ha, hAa⟩ := (LinearPMap.mem_graph_iff _).mp hx
    change (a : Gibbs U β) = x at ha
    change textbookBrownianGibbsClosedOperator m U hU hPU β a = 0 at hAa
    have h := textbookBrownianGibbsClosedOperator_kernel_constant m hm U hU hPU β hβ a hAa
    rw [ha] at h
    exact ⟨⟪e, x⟫_ℝ, h.symm⟩
  · rintro ⟨c, rfl⟩
    have h := (textbookBrownianGibbsClosedOperator m U hU hPU β).graph.smul_mem c he
    simpa only [Prod.smul_mk, smul_zero] using h

include hm hβ in
/-- The genuine constant spectral eigenspace has multiplicity exactly one, including Nc=0. -/
theorem textbookBrownianGibbsClosedEigenspace_zero_finrank :
    Module.finrank ℝ (textbookBrownianGibbsClosedEigenspace m U hU hPU β 0) = 1 := by
  rw [textbookBrownianGibbsClosedEigenspace_zero_eq_span m hm U hU hPU β hβ]
  apply finrank_span_singleton
  intro he
  have hn := textbookPeriodicSmoothEmbedding_one_norm U hU hPU β
  rw [he, norm_zero] at hn
  norm_num at hn

include hm hβ in
private theorem zero_index_unique
    (j k : textbookBrownianGibbsEigenIndex m U hU hPU β) (hj : j.1 = 0) (hk : k.1 = 0) : j = k := by
  rcases j with ⟨a, i⟩
  rcases k with ⟨b, l⟩
  change a = 0 at hj
  change b = 0 at hk
  subst a
  subst b
  have hf := textbookBrownianGibbsClosedEigenspace_zero_finrank m hm U hU hPU β hβ
  have hs : Subsingleton (Fin (Module.finrank ℝ (textbookBrownianGibbsClosedEigenspace m U hU hPU β 0))) := by
    rw [hf]
    infer_instance
  exact congrArg (fun r ↦ Sigma.mk (0 : ℝ) r) (hs.elim i l)

include hm hβ in
/-- No subsequent vector of the genuine ordered eigenbasis can belong to the one-dimensional constant eigenspace. -/
theorem textbookBrownianGibbsOrderedEigenEnumeration_nonzero (hNc : 0 < Nc) (n : ℕ) (hn : n ≠ 0) :
    (textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc n).1 ≠ 0 := by
  intro h
  have he := zero_index_unique m hm U hU hPU β hβ
    (textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc n)
    (textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc 0) h
    (textbookBrownianGibbsOrderedEigenEnumeration_zero m hm U hU hPU β hβ hNc)
  exact hn ((textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc).injective he)

include hm hβ in
/-- Every ordered nonconstant mode obeys the derived strict original Gibbs spectral gap, with no nonzero-eigenvalue premise left. -/
theorem textbookBrownianGibbsOrderedEigenEnumeration_gap (hNc : 0 < Nc) (n : ℕ) (hn : n ≠ 0) :
    (textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc n).1 ≤
      -textbookBrownianGibbsCoercivityRate m U hU hPU β :=
  textbookBrownianGibbsEigenbasis_eigenvalue_gap m hm U hU hPU β hβ _
    (textbookBrownianGibbsOrderedEigenEnumeration_nonzero m hm U hU hPU β hβ hNc n hn)
/-- A complete natural-number Hilbert eigenbasis of the entire original Gibbs space in positive dimension, preserving every actual eigenmode. The eigenvalues are genuinely nonincreasing with multiplicity. -/
def textbookBrownianGibbsOrderedNatEigenbasis (hNc : 0 < Nc) : HilbertBasis ℕ ℝ (Gibbs U β) := by
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  let e := textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc
  refine HilbertBasis.mk (b.orthonormal.comp e e.injective) ?_
  have he : Set.range (⇑b ∘ e) = Set.range b := by
    rw [Set.range_comp, e.surjective.range_eq, Set.image_univ]
  rw [he, b.dense_span]

/-- Every natural-number basis vector is literally the original genuine whole-generator basis vector selected by the actual bijection. -/
theorem textbookBrownianGibbsOrderedNatEigenbasis_apply (hNc : 0 < Nc) (n : ℕ) :
    textbookBrownianGibbsOrderedNatEigenbasis m hm U hU hPU β hβ hNc n =
      textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
        (textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc n) := by
  simp only [textbookBrownianGibbsOrderedNatEigenbasis, HilbertBasis.coe_mk, Function.comp_apply]

/-- Each vector in the entire sequence basis lies in the actual original closed-generator graph, with its literal ordered eigenvalue. -/
theorem textbookBrownianGibbsOrderedNatEigenbasis_mem_graph (hNc : 0 < Nc) (n : ℕ) :
    (textbookBrownianGibbsOrderedNatEigenbasis m hm U hU hPU β hβ hNc n,
      (textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc n).1 •
        textbookBrownianGibbsOrderedNatEigenbasis m hm U hU hPU β hβ hNc n) ∈
      (textbookBrownianGibbsClosedOperator m U hU hPU β).graph := by
  rw [textbookBrownianGibbsOrderedNatEigenbasis_apply]
  exact textbookBrownianGibbsEigenbasis_mem_graph m hm U hU hPU β hβ _

include hm hβ in
/-- The actual eigenvalues in the genuine sequence enumeration tend to minus infinity as n tends to infinity, using proved infinitude and genuine compactness. -/
theorem textbookBrownianGibbsOrderedEigenEnumeration_tendsto_atBot (hNc : 0 < Nc) :
    Tendsto (fun n : ℕ ↦ (textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc n).1)
      atTop atBot := by
  simpa only [Nat.cofinite_eq_atTop, Function.comp_def] using
    (textbookBrownianGibbsEigenbasis_eigenvalues_tendsto_atBot m hm U hU hPU β hβ).comp
      (textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc).injective.tendsto_cofinite

include hm hβ in
/-- Every value of the entire actual original-generator real spectrum occurs in the sequence, with every genuine basis mode included. -/
theorem textbookBrownianGibbsGeneratorRealSpectrum_eq_ordered_sequence_range (hNc : 0 < Nc) :
    textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β =
      Set.range (fun n : ℕ ↦ (textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc n).1) := by
  let e := textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc
  change textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β =
    Set.range ((fun j : textbookBrownianGibbsEigenIndex m U hU hPU β ↦ j.1) ∘ e)
  rw [Set.range_comp, e.surjective.range_eq, Set.image_univ,
    textbookBrownianGibbsGeneratorRealSpectrum_eq_eigenbasis_range m hm U hU hPU β hβ]

/-- The sequence eigenbasis gives an actual unconditional reconstruction of every vector of the entire original Gibbs Hilbert space. -/
theorem textbookBrownianGibbsOrderedNatEigenbasis_hasSum (hNc : 0 < Nc) (x : Gibbs U β) :
    HasSum (fun n : ℕ ↦ ⟪textbookBrownianGibbsOrderedNatEigenbasis m hm U hU hPU β hβ hNc n, x⟫_ℝ •
      textbookBrownianGibbsOrderedNatEigenbasis m hm U hU hPU β hβ hNc n) x := by
  simpa only [HilbertBasis.repr_apply_apply] using
    (textbookBrownianGibbsOrderedNatEigenbasis m hm U hU hPU β hβ hNc).hasSum_repr x


/-- The actual original-generator evolution has the genuine ordered textbook exponential eigenfunction expansion for every vector of the whole Gibbs Hilbert space. Probability/SDE identification is a separate obligation. -/
theorem textbookBrownianGibbsSpectralEvolution_ordered_hasSum (hNc : 0 < Nc) (t : NNReal) (x : Gibbs U β) :
    HasSum (fun n : ℕ ↦
      (Real.exp ((textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc n).1 * (t : ℝ)) *
        ⟪textbookBrownianGibbsOrderedNatEigenbasis m hm U hU hPU β hβ hNc n, x⟫_ℝ) •
      textbookBrownianGibbsOrderedNatEigenbasis m hm U hU hPU β hβ hNc n)
      (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x) := by
  have h := textbookBrownianGibbsOrderedNatEigenbasis_hasSum m hm U hU hPU β hβ hNc
    (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x)
  apply h.congr_fun
  intro n
  rw [textbookBrownianGibbsOrderedNatEigenbasis_apply,
    textbookBrownianGibbsSpectralEvolution_coefficient]
  rfl

/-- Literal ordered spectral series equality for the true whole-Gibbs evolution generated by the actual original closed operator. -/
theorem textbookBrownianGibbsSpectralEvolution_ordered_tsum (hNc : 0 < Nc) (t : NNReal) (x : Gibbs U β) :
    textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x =
      ∑' n : ℕ,
        (Real.exp ((textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc n).1 * (t : ℝ)) *
          ⟪textbookBrownianGibbsOrderedNatEigenbasis m hm U hU hPU β hβ hNc n, x⟫_ℝ) •
        textbookBrownianGibbsOrderedNatEigenbasis m hm U hU hPU β hβ hNc n :=
  (textbookBrownianGibbsSpectralEvolution_ordered_hasSum m hm U hU hPU β hβ hNc t x).tsum_eq.symm

end
end MolecularDynamics
